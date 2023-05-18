#!/usr/bin/env python # -*- coding: utf-8 -*-
import pandas as pd

raw_data = pd.read_csv("./2019_raw.csv")
raw_data = raw_data[raw_data["가동율"] >= 90]  # "Outlier delete"
raw_data = raw_data[raw_data["운행시간(HHMM)"] <= 1011]
raw_data["time_len"] = raw_data["운행시간(HHMM)"].astype(str).str.len()
raw_data = raw_data[raw_data["time_len"] >= 3]  ##delete the length less than 2

raw_data[raw_data["time_len"] == 4]["운행시간(HHMM)"].head()

# unit the time format into mins
raw_data.loc[raw_data["time_len"] == 3, ["운행시간(HHMM)"]] = \
raw_data[raw_data["time_len"] == 3]["운행시간(HHMM)"].astype(str).str[0].astype(int) * 60 + \
raw_data[raw_data["time_len"] == 3]["운행시간(HHMM)"].astype(str).str[1:3].astype(int)
raw_data.loc[raw_data["time_len"] == 4, ["운행시간(HHMM)"]] = raw_data[raw_data["time_len"] == 4]["운행시간(HHMM)"].astype(
    str).str[0:2].astype(int) * 60 + raw_data[raw_data["time_len"] == 4]["운행시간(HHMM)"].astype(str).str[3:4].astype(int)
raw_data["운행시간(HHMM)"] = (raw_data["운행시간(HHMM)"] / 60).round(2)  # to hour
name_product = raw_data["제품명"].unique()


def new_variable_NameMachine(data):
    """data is one dataframe: groupby name, machineID
    """
    df1 = pd.DataFrame()
    df1 = data.groupby(['제품명', '작업 호기']).sum().iloc[:, [6]]
    df1["density"] = data["실제 기계 밀도"].unique()[0]
    df1["total processing time"] = data.groupby(['제품명', '작업 호기']).sum()["운행시간(HHMM)"]

    df1["machine numbers"] = data.groupby(['제품명', '작업 호기']).size()
    df1["rpm"] = data.groupby(['제품명', '작업 호기']).mean()["RPM"]
    df1["name of product"] = df1.index.levels[0][0]
    df1["machine"] = df1.index.levels[1]

    return df1


def new_variable_NameTypeMachine(data):
    """data is one dataframe"""
    df1 = pd.DataFrame()
    df1 = data.groupby(['제품명', '작업 반', '작업 호기']).sum().iloc[:, [6]]
    df1["density"] = data["실제 기계 밀도"].unique()[0]
    df1["total processing time"] = data.groupby(['제품명', '작업 반', '작업 호기']).sum()["운행시간(HHMM)"]

    df1["machine numbers"] = data.groupby(['제품명', '작업 반', '작업 호기']).size()
    df1["rpm"] = data.groupby(['제품명', '작업 반', '작업 호기']).mean()["RPM"]
    df1["name of product"] = df1.index.levels[0][0]
    df1["machine"] = df1.index.get_level_values(2)
    return df1


def new_variable_NameDateMachine(data):
    """data is one dataframe"""
    df1 = pd.DataFrame()
    df1 = data.groupby(['제품명', '작업일자', '작업 호기']).sum().iloc[:, [5]]
    df1["density"] = data["실제 기계 밀도"].unique()[0]
    df1["total processing time"] = data.groupby(['제품명', '작업일자', '작업 호기']).sum()["운행시간(HHMM)"]

    df1["machine numbers"] = data.groupby(['제품명', '작업일자', '작업 호기']).size()
    df1["rpm"] = data.groupby(['제품명', '작업일자', '작업 호기']).mean()["RPM"]
    df1["name of product"] = df1.index.levels[0][0]
    df1["machine"] = df1.index.get_level_values(2)
    return df1


def create_new_dataframe(nameofProducts, raw_data, varGenerationFunction):
    myframe = pd.DataFrame()
    for name in nameofProducts:
        sub_data = raw_data[raw_data["제품명"] == name]
        myDataframe = varGenerationFunction(sub_data)
        myframe = myframe.append(myDataframe, ignore_index=True)
    return myframe


df1 = create_new_dataframe(name_product, raw_data, new_variable_NameMachine)
df2 = create_new_dataframe(name_product, raw_data, new_variable_NameTypeMachine)
df3 = create_new_dataframe(name_product, raw_data, new_variable_NameDateMachine)

df = pd.concat([df1, df2, df3])
df = pd.concat([df2, df3])
df = df3

from sklearn.preprocessing import LabelEncoder, OneHotEncoder


def onehot_encoder(data):
    """data is the variabble need to convert into one-hot encoder"""
    label_encoder = LabelEncoder()
    integer_encoded = label_encoder.fit_transform(data.values)
    # binary encode
    onehot_encoder = OneHotEncoder(sparse=False)
    integer_encoded = integer_encoded.reshape(len(integer_encoded), 1)
    onehot_encoded = onehot_encoder.fit_transform(integer_encoded)
    return onehot_encoded


density_encoder = onehot_encoder(df["density"])
name_encoder = onehot_encoder(df["name of product"])


# Join three variables
def scaling(data):
    scaled_data = (data - data.min(axis=0)) / (data.max(axis=0) - data.min(axis=0))
    return scaled_data


scaled = scaling(df.iloc[:, [0, 4, 6]])
## transform data
new_data = scaled.join(pd.DataFrame(density_encoder)).join(pd.DataFrame(name_encoder), lsuffix="left", rsuffix='_other')

# !/usr/bin/env python
######################Splitting the data into training and testing parts
from dytech import data_generation
import pandas as pd
import numpy as np

from sklearn.model_selection import train_test_split

y_names = ["total processing time", 'machine numbers', 'name of product', "machine"]
x_names = ["total processing time", 'machine numbers']
x = new_data.iloc[:, ~new_data.columns.isin(x_names)]
y = df[y_names]
# For modeling easily
y["machine numbers"].replace({1: 0, 2: 1, 3: 2, 4: 3, 5: 4, 6: 5, 8: 6}, inplace=True)

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2)
print(x_train.shape)


def MAPE(Y_actual, Y_Predicted):
    mape = np.mean(np.abs((Y_actual - Y_Predicted) / Y_actual)) * 100
    return mape


###############################creating the models
from tensorflow import keras
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.models import Sequential, Model
from tensorflow.keras.layers import Input, Lambda, Conv1D, MaxPool1D, Dense, Flatten
from tensorflow.keras.layers import Activation, Dropout, Flatten, Dense
from tensorflow.keras.optimizers import SGD, RMSprop, Adam, Adadelta, Nadam
from tensorflow.keras import backend as K
import numpy as np
import sys

from tensorflow.keras.callbacks import EarlyStopping
from tensorflow.keras.callbacks import ModelCheckpoint


def Create_Model(trainx, trainy, testx, testy, save_path):
    classes = 7

    alpha = 0.5
    input_shape = (200, 1)
    classes = len(np.unique(trainy.iloc[:, 1]))

    input_layer = Input(input_shape)
    conv1 = Conv1D(32, 64, padding="valid", activation="relu")(input_layer)
    max1 = MaxPool1D(6)(conv1)

    conv2 = Conv1D(64, 16, padding="same", activation="relu")(max1)
    max2 = MaxPool1D(3)(conv2)

    conv3 = Conv1D(128, 8, padding="same", activation="relu")(max2)
    max3 = MaxPool1D(3)(conv3)

    flatten = Flatten()(max3)

    out1 = Dense(classes, activation="softmax", name="machine_numbers")(flatten)
    out2 = Dense(1, activation="linear", name="process_time")(flatten)

    model = keras.models.Model(inputs=[input_layer], outputs=[out1, out2])

    model.compile(loss={'machine_numbers': 'categorical_crossentropy', 'process_time': 'mae'}, optimizer="adam",
                  loss_weights={'machine_numbers': 1 - alpha, 'process_time': alpha})

    path = "./model/%s.hdf5" % save_path
    keras_callbacks = [
        EarlyStopping(monitor='val_loss', patience=20, mode='min', min_delta=0.000001),
        ModelCheckpoint(path, monitor='val_loss', save_best_only=True, mode='min')]

    # fit the keras model on the dataset

    his = model.fit(trainx.values.reshape(len(trainx), input_shape[0], 1),
                    [to_categorical(trainy.iloc[:, 1]), trainy.iloc[:, 0]],
                    epochs=100,
                    batch_size=100,
                    validation_split=0.2,
                    callbacks=keras_callbacks)

    pre = model.predict(testx.values.reshape(len(testx), 200, 1))
    acc = sum((testy.iloc[:, 1]) == pre[0].argmax(axis=1)) / float(len(testy))
    mape_times = MAPE(np.array(testy.iloc[:, 0]), np.array(pre[1]))

    return his, model, pre, acc, mape_times


his, model, pre, acc, mape_times = Create_Model(x_train, y_train.iloc[:, [0, 1]], x_test, y_test.iloc[:, [0, 1]], "cnn")
print("acc and mape are %f and %f" % (acc, mape_times))






