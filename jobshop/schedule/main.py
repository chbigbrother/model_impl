#!/usr/bin/env python

import sys
import time
from tensorflow import keras
import pandas as pd
from src.utils import parser, gantt
from src.genetic import encoding, decoding, genetic, termination
from src import config

from dytech.modeling import read_test_data,new_variable_NameDateMachine,new_variable_NameTypeMachine,new_variable_NameDateMachine,create_new_dataframe,creat_new_data,onehot_encoder,scaling

def generate_prediction():
    #Step 1. Generating the predictions
    model = keras.models.load_model('dytech/model/cnn.hdf5')
    train_data = creat_new_data("dytech/2019_raw.csv")

    new_coming_data=pd.read_csv("dytech/new_coming.csv")
    df1 = pd.DataFrame()
    df1["density"] = new_coming_data["실제 기계 밀도"]
    df1["rpm"] =new_coming_data["RPM"]
    df1["name of product"] =new_coming_data["제품명"]## transform data
    df1["machine"] = new_coming_data["작업 호기"]
    new_coming_data=df1
    density_encoder = onehot_encoder(train_data["density"], new_coming_data["density"])
    name_encoder = onehot_encoder(train_data["name of product"], new_coming_data["name of product"])
    scaled = scaling(df1.iloc[:,[0,1,3]]) #######checking
    ## transform datanew_data = scaled.join(pd.DataFrame(density_encoder)).join(pd.DataFrame(name_encoder), lsuffix="left",
    new_data = scaled.join(pd.DataFrame(density_encoder)).join(pd.DataFrame(name_encoder), lsuffix="left",rsuffix='_other')
    y_names = ["total processing time", 'machine numbers', 'name of product', "machine"]
    x_names = ["total processing time", 'machine numbers']
    x = new_data.iloc[:, ~new_data.columns.isin(x_names)]
    pre=model.predict(x.values.reshape(len(x),200,1))
    negative_to_positive = abs(pre[1])
    if negative_to_positive.round() == 0:
        negative_to_positive = 1
    pre_df = pd.DataFrame(negative_to_positive.round(), columns=["total processing time"])
    pre_df["machine numbers"] = pd.DataFrame(pre[0].argmax(axis=1))
    pre_df["machine numbers"].replace({0: 1, 1: 2, 2: 3, 3: 4, 4: 5, 5: 6, 6: 8}, inplace=True)
    pre_df["machine ID"] = new_coming_data["machine"]
    pre_df["name of product"] = new_coming_data["name of product"]
    pre_df.to_csv('dytech/prediction.csv')
    generate_jssp()
    print("Generating prediction for new coming data successfully and saved it in the file of prediction.csv")

def generate_jssp():
    #Step 2. Generating JSSP instance from prediction
    from dytech.scheduling import generate_jssp_instance_from_prediction
    pre=pd.read_csv("dytech/prediction.csv")
    generate_jssp_instance_from_prediction(pre.iloc[0:600,])    #Changing here to real
    generate_gantt()

def generate_gantt():
    #Step 3. Generating gantt chart
    parameters = parser.parse("./myfile.txt" )
    # parameters = parser.parse("test_data/test1.dat" )

    t0 = time.time()
    # Initialize the Population
    population = encoding.initializePopulation(parameters)
    gen = 1
    # Evaluate the population
    while not termination.shouldTerminate(population, gen):
        # Genetic Operators
        population = genetic.selection(population, parameters)
        population = genetic.crossover(population, parameters)
        # population = genetic.mutation(population, parameters)
        gen = gen + 1

    sortedPop = sorted(population, key=lambda cpl: genetic.timeTaken(cpl, parameters))
    t1 = time.time()
    total_time = t1 - t0
    print("Finished in {0:.2f}s".format(total_time))

    # Termination Criteria Satisfied ?
    # gantt_data1= [decoding.translate_decoded_to_gantt(decoding.decode(parameters, sortedPop[0][0], sortedPop[0][1]))]
    gantt_data = decoding.translate_decoded_to_gantt(decoding.decode(parameters, sortedPop[0][0], sortedPop[0][1]))
    # gantt_data=[ele for ele in ({key:val for key ,val in sub.items() if val} for sub in gantt_data1) if ele][0]
    print(gantt_data)

    import numpy as np
    a=decoding.decode(parameters, sortedPop[0][0], sortedPop[0][1])
    filter_empty=list(filter(lambda x:x!=[],a))
    # make_span=filter_empty[-1][0][3]+filter_empty[-1][0][1]

    if config.latex_export:
        gantt.export_latex(gantt_data)
    else:
        gantt.draw_chart(gantt_data,a)

# def main():
#     generate_prediction()
#
# if __name__ == "__main__":
#     main()