#!/usr/bin/env python # -*- coding: utf-8 -*-

from tensorflow import keras
import pandas as pd

import pandas as pd
import numpy as np

from sklearn.model_selection import train_test_split

def read_test_data(path):
    raw_data = pd.read_csv(path)
    raw_data = raw_data[raw_data["가동율"]>= 90]
    raw_data = raw_data[raw_data["운행시간(HHMM)"] <= 1011]
    raw_data["time_len"] = raw_data["운행시간(HHMM)"].astype(str).str.len()
    raw_data = raw_data[raw_data["time_len"] >= 3]
    raw_data[raw_data["time_len"] == 4]["운행시간(HHMM)"].head()

    # unit the time format into mins
    raw_data.loc[raw_data["time_len"] == 3, ["운행시간(HHMM)"]] =raw_data[raw_data["time_len"] == 3]["운행시간(HHMM)"].astype(str).str[0].astype(int) * 60 +\
                                                             raw_data[raw_data["time_len"] == 3]["운행시간(HHMM)"].astype(str).str[1:3].astype(int)
    raw_data.loc[raw_data["time_len"] == 4, ["운행시간(HHMM)"]] = raw_data[raw_data["time_len"] == 4]["운행시간(HHMM)"].astype(
    str).str[0:2].astype(int) * 60 + raw_data[raw_data["time_len"] == 4]["운행시간(HHMM)"].astype(str).str[3:4].astype(int)
    raw_data["운행시간(HHMM)"] = (raw_data["운행시간(HHMM)"] / 60).round(2)

    return raw_data

def read_real_data(path):
    raw_data = pd.read_csv(path)

    return raw_data

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

def new_variable_realData(data):
    """data is one dataframe"""
    df1 = pd.DataFrame()

    df1["density"] = data["실제 기계 밀도"].unique()
    df1["name of product"] = data["제품명"].unique()
    # df1.index.levels[0][0]
    df1["machine"] = data["작업 호기"].unique()
    # df1.index.get_level_values(2)
    # print(df1["density"])
    return df1

def create_new_dataframe(nameofProducts, raw_data, varGenerationFunction):
    myframe = pd.DataFrame()
    for name in nameofProducts:
        sub_data = raw_data[raw_data["제품명"] == name]
        myDataframe = varGenerationFunction(sub_data)
        myframe = myframe.append(myDataframe, ignore_index=True)
    return myframe


def creat_new_data(path):
    raw_data=read_test_data(path)
    name_product = raw_data["제품명"].unique()
    df3 = create_new_dataframe(name_product, raw_data, new_variable_NameDateMachine)
    df = df3
    return df

def format_new_data(path):
    raw_data=read_real_data(path)
    name_product = raw_data["제품명"].unique()
    df3 = create_new_dataframe(name_product, raw_data, new_variable_realData)
    df = df3
    return df

from sklearn.preprocessing import LabelEncoder, OneHotEncoder
def onehot_encoder(train_data,coming_data):
    """data is the variabble need to convert into one-hot encoder"""
    enc=OneHotEncoder(handle_unknown='ignore')
    enc.fit(train_data.values.reshape(-1,1))
    code=enc.transform(coming_data.values.reshape(-1,1)).toarray()
    return code

# Join three variables
def scaling(data):
    scaled_data = (data - data.min(axis=0)) / (data.max(axis=0) - data.min(axis=0))
    return scaled_data


if __name__ == '__main__':
    model= keras.models.load_model('./model/cnn.hdf5')
    train_data = creat_new_data("./2019_raw.csv")
    new_coming_data = creat_new_data("./2019_raw.csv")
    density_encoder = onehot_encoder(train_data["density"], new_coming_data["density"])
    name_encoder = onehot_encoder(train_data["name of product"], new_coming_data["name of product"])
    scaled = scaling(new_coming_data.iloc[:, [0, 4, 6]])
    ## transform data
    new_data = scaled.join(pd.DataFrame(density_encoder)).join(pd.DataFrame(name_encoder), lsuffix="left",
                                                               rsuffix='_other')
    y_names = ["total processing time", 'machine numbers', 'name of product', "machine"]
    x_names = ["total processing time", 'machine numbers']
    x = new_data.iloc[:, ~new_data.columns.isin(x_names)]

    print(x.shape)
    pre=model.predict(x.values.reshape(len(x),200,1))
    pre_df = pd.DataFrame(pre[1].round(), columns=["total processing time"])
    pre_df["machine numbers"] = pd.DataFrame(pre[0].argmax(axis=1))
    pre_df["machine numbers"].replace({0: 1, 1: 2, 2: 3, 3: 4, 4: 5, 5: 6, 6: 8}, inplace=True)
    pre_df["machine ID"] = new_coming_data["machine"]
    pre_df["name of product"] = new_coming_data["name of product"]
    pre_df.to_csv('./prediction.csv')