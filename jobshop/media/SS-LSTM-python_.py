#!/usr/bin/env python
# coding: utf-8

# In[1]:


#!/usr/bin/env python


# This code is aiming at finding one optimal solver for JSSP using Deel LSTM
# Define the JSSP problem using one classe
import copy
import random
import time
# from __future__ import print_function
from itertools import combinations, permutations
    
# import guchoose
    
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
# Import Python wrapper for or-tools constraint solver.
from ortools.constraint_solver import pywrapcp


class Problem:
    m = None  # number of the machines
    n = None  # number of the jobs
    solute = None
    time_low = None
    time_high = None
    p = np.array([])  # the processing time of jobs
    r = np.array([])  # the order limit
    x = np.array([])  # the result position mat
    h = np.array([])  # the start time of jobs
    e = np.array([])  # the end time of jobs
    f = np.array([])
    
    start=np.array([])   ############Start time for each action 
    end=np.array([])     ############End time for eaCH ACTION 
    best_x = np.array([])
    opetimalx = None
    number_of_1d_feature = 18

    # p.sum()

    def __init__(self, m, n, time_low, time_high,bool_random):  
        self.m = m
        self.n = n
        self.time_high = time_high
        self.time_low = time_low
        self.solute = 0
        self.bool_generate_rondom_JSSP=bool_random
        self.GenerateRandomProblem()
    
    def GenerateRandomProblem(self):
        n=self.n
        m=self.m
        if self.bool_generate_rondom_JSSP==True:
            a = list(range(self.time_low, self.time_high))
            p = []
            for k in range(self.n):
                p.append(random.sample(a, self.m))
            self.p = np.array(p)

            a = list(range(self.m))
            r = []
            for k in range(self.n):
                r.append(random.sample(a, self.m))
            self.r = np.array(r)

            sum_time_of_job = np.sum(self.p, axis=1)

            for i in range(n):
                for j in range(i + 1, n):
                    if sum_time_of_job[i] > sum_time_of_job[j]:
                        a = np.copy(self.p[j, :])
                        self.p[j, :] = self.p[i, :]
                        self.p[i, :] = a
                        sum_time_of_job[i], sum_time_of_job[j] = sum_time_of_job[j], sum_time_of_job[i]

            sum_time_of_mach = [[i, 0] for i in range(m)]
            for i in range(n):
                for j in range(m):
                    sum_time_of_mach[self.r[i, j]][1] += self.p[i, j]

            for i in range(m):
                for j in range(i + 1, m):
                    if sum_time_of_mach[i][1] > sum_time_of_mach[j][1]:
                        sum_time_of_mach[i], sum_time_of_mach[j] = sum_time_of_mach[j], sum_time_of_mach[i]

            nr = np.zeros((n, m), dtype=int) - 1
            for i in range(m):
                nr[self.r == i] = sum_time_of_mach[i][0]

            sum_time_of_mach = [[i, 0] for i in range(m)]
            for i in range(n):
                for j in range(m):
                    sum_time_of_mach[self.r[i, j]][1] += self.p[i, j]

            self.r = nr
        else:
            ##########################la36(15by15)
#             self.r=np.array([[4,3,6,14,10,2,9,1,0,7,8,5,12,11,13],[11,4,1,7,8,14,12,0,3,6,9,5,10,13,2],
#                             [9,5,2,7,4,12,0,13,6,10,3,11,8,1,14],[5,0,9,6,4,13,7,8,11,12,2,1,10,14,3],
#                             [10,4,8,2,0,11,14,9,6,7,1,13,3,5,12],[0,2,4,13,3,12,14,6,1,9,11,8,7,10,5],
#                             [8,4,12,0,7,11,6,10,3,13,1,5,14,2,9],[4,13,11,3,7,9,1,2,12,8,14,0,10,6,5],
#                             [5,1,6,8,13,10,2,3,7,11,14,4,0,9,12],[11,5,4,8,7,0,9,6,14,3,10,13,2,12,1],
#                             [7,3,0,4,12,14,10,1,9,13,5,8,2,11,6],[1,2,3,5,4,6,9,7,10,8,11,13,12,0,14],
#                             [3,7,13,5,11,12,2,4,10,1,9,6,14,8,0],[9,7,5,14,10,4,11,2,1,3,13,6,0,12,8],
#                             [9,10,11,14,8,0,7,6,12,1,2,13,4,3,5]])
#             self.p=np.array([[21,55,71,98,12,34,16,21,53,26,52,95,31,42,39],[54,83,77,64,34,79,43,55,77,19,37,79,92,62,66],
#                             [83,77,87,38,60,98,93,17,41,44,69,49,24,87,25],[77,96,28,7,95,35,35,76,9,95,43,75,61,10,79],
#                             [87,28,50,59,46,45,9,43,52,27,91,41,16,59,39],[20,71,78,66,14,8,42,28,54,33,89,26,37,33,43],
#                             [69,96,17,69,45,31,78,20,27,87,74,84,76,94,81],[58,90,76,81,23,28,18,32,86,99,97,24,45,72,25],
#                             [27,46,67,27,19,80,17,48,62,12,28,98,42,48,50],[37,80,75,55,50,94,14,41,72,50,61,79,98,18,63],
#                             [65,96,47,75,69,58,33,71,22,32,57,79,14,31,60],[34,47,58,51,62,44,8,17,97,29,15,66,40,44,38],
#                             [50,57,61,20,85,90,58,63,84,39,87,21,56,32,57],[84,45,15,41,18,82,29,70,67,30,50,23,20,21,38],
#                             [37,81,61,57,57,52,74,62,30,52,38,68,54,54,16]])
            
             #########################la24(15by10)
#                 self.r=np.array([[7,9,0,6,4,8,2,5,1,3],[6,8,3,0,1,4,5,9,2,7],[1,3,5,4,0,2,6,8,9,7],
#                                  [1,7,4,6,5,0,8,3,9,2],[7,2,8,5,1,6,3,0,9,4],[8,0,4,5,9,1,7,6,3,2],
#                                  [6,2,8,1,9,4,7,0,5,3],[8,7,5,3,2,4,9,1,0,6],[4,0,9,5,7,3,2,8,6,1],
#                                  [9,0,3,8,1,6,2,5,4,7],[7,3,4,5,2,0,6,9,1,8],[0,3,2,7,8,5,9,1,6,4],
#                                  [9,1,3,6,2,8,7,0,5,4],[4,2,5,6,8,7,3,1,0,9],[2,5,9,8,0,6,3,7,1,4]])
#                 self.p=np.array([[8,75,72,74,30,43,38,98,26,19],[19,73,43,23,85,39,13,26,67,9],[50,93,80,7,55,61,57,72,42,46],
#                                  [68,43,99,60,68,91,11,96,11,2],[84,34,40,7,70,74,12,43,69,30],[60,49,59,72,63,69,99,45,27,9],
#                                  [71,91,65,90,98,8,50,75,37,17],[62,90,98,31,91,38,72,9,72,49],[35,39,74,25,47,52,63,21,35,80],
#                                  [58,5,50,52,88,20,68,24,53,57],[99,91,33,19,18,38,24,35,49,9],[68,60,77,10,60,15,72,18,90,18],
#                                  [79,60,56,91,40,86,72,80,89,51],[10,92,23,46,40,72,6,23,95,34],[24,29,49,55,47,77,77,8,28,48]])
                
#             ##########################ft20(20by5)
#             self.r=np.array([[0,1,2,3,4],[0,1,3,2,4],[1,0,2,4,3],[1,0,4,2,3],[2,1,0,3,4],[2,1,4,0,3],
#                          [1,0,2,3,4],[2,1,0,3,4],[0,3,2,1,4],[1,2,0,3,4],[1,3,0,4,2],[2,0,1,3,4],
#                          [0,2,1,3,4],[2,0,1,3,4],[0,1,4,2,3],[1,0,3,4,2],[0,2,1,3,4],[0,1,4,2,3],
#                          [1,2,0,3,4],[0,1,2,3,4]])
#             self.p=np.array([[29,9,49,62,44],[43,75,69,46,72],[91,39,90,12,45],[81,71,9,85,22],
#                                     [14,22,26,21,72],[84,52,48,47,6],[46,61,32,32,30],[31,46,32,19,36],
#                                     [76,76,85,40,26],[85,61,64,47,90],[78,36,11,56,21],[90,11,28,46,30],
#                                     [85,74,10,89,33],[95,99,52,98,43],[6,61,69,49,53],[2,95,72,65,25],[37,13,21,89,55],
#                                      [86,74,88,48,79],[69,51,11,89,74],[13,7,76,52,45]])
            
            
            ###################ft10(10by10)
            self.r=np.array([[0,1,2,3,4,5,6,7,8,9],[0,2,4,9,3,1,6,5,7,8], 
                             [1,0,3,2,8,5,7,6,9,4],[1,2,0,4,6,8,7,3,9,5],
                             [2,0,1,5,3,4,8,7,9,6],[2,1,5,3,8,9,0,6,4,7],
                             [1,0,3,2,6,5,9,8,7,4],[2,0,1,5,4,6,8,9,7,3],
                             [0,1,3,5,2,9,6,7,4,8],[1,0,2,6,8,9,5,3,4,7]])
            self.p=np.array([[29,78,9,36,98,11,62,56,44,21],[43,90,75,11,69,28,46,46,72,30], ####49
                             [91,85,39,74,90,10,12,89,45,33],[81,95,71,99,9,52,85,98,22,43],
                             [14,6,22,61,26,69,21,49,72,53],[84,2,52,95,48,72,47,65,6,25],
                             [46,37,61,13,32,21,32,89,30,55],[31,86,46,74,32,88,19,48,36,79],
                             [76,69,76,51,85,11,40,89,26,74],[85,13,61,7,64,76,47,52,90,45]])
            


    
    def Print_info(self):

        machine_job_p = np.zeros((self.m, self.n))
        machine_job_r = np.zeros((self.m, self.n))

        for job in range(self.n):
            for order in range(self.m):
                machine = self.r[job, order]
                machine_job_p[machine, job] = self.p[job, order]
                machine_job_r[machine, job] = order

        np.savetxt('p.csv', machine_job_p, delimiter=',')
        np.savetxt('r.csv', machine_job_r, delimiter=',')
        self.PlotResult()
        return machine_job_p,machine_job_r

    def SaveProblemToFile(self, filepath, index, pool=0):

        filename = '{}/jssp_problem_m={}_n={}_timehigh={}_timelow={}_pool={}.txt'.format(
            filepath, self.m, self.n, self.time_high, self.time_low, pool)
        f = open(filename, 'a')
        # f.write(str(index))
        # f.write('\nr=\n')
        f.write(str(self.m) + '\n')
        f.write(str(self.n) + '\n')
        f.write(TranslateNpToStr(self.p))
        f.write(TranslateNpToStr(self.r))
        f.close()

    def SavesolutionToFile(self, filepath, index, pool=0):
        f = open('{}/jssp_problem_m={}_n={}_timehigh={}_timelow={}_pool={}.txt'.format(
            filepath, self.m, self.n, self.time_high, self.time_low, pool), 'a')
        # f.write(str(index)+'\n')
        f.write(TranslateNpToStr(self.x))
        f.write(TranslateNpToStr(self.h))
        f.write(TranslateNpToStr(self.e))
        f.close()

    def SoluteWithBBM(self):

        solver = pywrapcp.Solver('jobshop')
        solver.TimeLimit(1)

        all_machines = range(0, self.m)
        all_jobs = range(0, self.n)

        x = np.zeros((self.m, self.n, 2), dtype=int)
        h = np.zeros((self.m, self.n), dtype=int)
        e = np.zeros((self.m, self.n), dtype=int)

        # processing_times = self.p.tolist()
        # machines = self.r.tolist()

        horizon = int(self.p.sum())
        # Creates jobs.
        all_tasks = {}
        for i in all_jobs:
            for j in range(self.m):
                all_tasks[(i, j)] = solver.FixedDurationIntervalVar(
                    0, horizon, int(self.p[i, j]), False, 'Job_%i_%i' % (i, j))

        # Creates sequence variables and add disjunctive constraints.
        all_sequences = []
        all_machines_jobs = []
        for i in all_machines:

            machines_jobs = []
            for j in all_jobs:
                for k in range(self.m):
                    if self.r[j, k] == i:
                        machines_jobs.append(all_tasks[(j, k)])
            disj = solver.DisjunctiveConstraint(
                machines_jobs, 'machine %i' % i)
            all_sequences.append(disj.SequenceVar())
            solver.Add(disj)

        # Add conjunctive contraints.
        for i in all_jobs:
            for j in range(0, self.m - 1):
                solver.Add(
                    all_tasks[(i, j + 1)].StartsAfterEnd(all_tasks[(i, j)]))

        # Set the objective.
        obj_var = solver.Max([all_tasks[(i, self.m - 1)].EndExpr()
                              for i in all_jobs])
        objective_monitor = solver.Minimize(obj_var, 1)
        # Create search phases.
        sequence_phase = solver.Phase([all_sequences[i] for i in all_machines],
                                      solver.SEQUENCE_DEFAULT)
        vars_phase = solver.Phase([obj_var],
                                  solver.CHOOSE_FIRST_UNBOUND,
                                  solver.ASSIGN_MIN_VALUE)
        main_phase = solver.Compose([sequence_phase, vars_phase])
        # Create the solution collector.
        collector = solver.LastSolutionCollector()

        # Add the interesting variables to the SolutionCollector.
        collector.Add(all_sequences)
        collector.AddObjective(obj_var)

        for i in all_machines:
            sequence = all_sequences[i]
            sequence_count = sequence.Size()
            for j in range(0, sequence_count):
                t = sequence.Interval(j)
                collector.Add(t.StartExpr().Var())
                collector.Add(t.EndExpr().Var())
        # Solve the problem.
        disp_col_width = 10
        if solver.Solve(main_phase, [objective_monitor, collector]):
            # print("\nOptimal Schedule Length:", collector.ObjectiveValue(0), "\n")
            sol_line = ""
            sol_line_tasks = ""
            # print("Optimal Schedule", "\n")

            for i in all_machines:
                seq = all_sequences[i]
                sol_line += "Machine " + str(i) + ": "
                sol_line_tasks += "Machine " + str(i) + ": "
                sequence = collector.ForwardSequence(0, seq)
                seq_size = len(sequence)

                for j in range(0, seq_size):
                    t = seq.Interval(sequence[j])
                    # Add spaces to output to align columns.
                    sol_line_tasks += t.Name() + " " * (disp_col_width - len(t.Name()))
                    x[i, j, 0] = int(t.Name().split('_')[1])
                    x[i, j, 1] = int(t.Name().split('_')[2])

                for j in range(0, seq_size):
                    t = seq.Interval(sequence[j])
                    sol_tmp = "[" +                               str(collector.Value(0, t.StartExpr().Var())) + ","
                    sol_tmp += str(collector.Value(0,
                                                   t.EndExpr().Var())) + "] "
                    # Add spaces to output to align columns.
                    sol_line += sol_tmp + " " * (disp_col_width - len(sol_tmp))

                    h[i, j] = collector.Value(0, t.StartExpr().Var())
                    e[i, j] = collector.Value(0, t.EndExpr().Var())
                    self.start=h
                    self.end=e

                sol_line += "\n"
                sol_line_tasks += "\n"

        self.x = x
        self.h = h
        self.e = e
        self.best_x = x

    def SoluteWithGA(self):

        pt_tmp = self.p
        ms_tmp = self.r + 1

        dfshape = pt_tmp.shape
        num_mc = dfshape[1]  # number of machines
        num_job = dfshape[0]  # number of jobs
        num_gene = num_mc * num_job  # number of genes in a chromosome

        pt = pt_tmp
        ms = ms_tmp

        population_size = 30
        crossover_rate = 0.8
        mutation_rate = 0.2
        mutation_selection_rate = 0.2
        num_mutation_jobs = int(round(num_gene * mutation_selection_rate))
        num_iteration = 2000

        start_time = time.time()

        Tbest = 999999999999999
        best_list, best_obj = [], []
        population_list = []
        makespan_record = []
        for i in range(population_size):
            # generate a random permutation of 0 to num_job*num_mc-1
            nxm_random_num = list(np.random.permutation(num_gene))
            # add to the population_list
            population_list.append(nxm_random_num)
            for j in range(num_gene):
                # convert to job number format, every job appears m times
                population_list[i][j] = population_list[i][j] % num_job

        for n in range(num_iteration):
            Tbest_now = 99999999999

            '''-------- two point crossover --------'''
            parent_list = copy.deepcopy(population_list)
            offspring_list = copy.deepcopy(population_list)
            # generate a random sequence to select the parent chromosome to crossover
            S = list(np.random.permutation(population_size))

            for m in range(int(population_size / 2)):
                crossover_prob = np.random.rand()
                if crossover_rate >= crossover_prob:
                    parent_1 = population_list[S[2 * m]][:]
                    parent_2 = population_list[S[2 * m + 1]][:]
                    child_1 = parent_1[:]
                    child_2 = parent_2[:]
                    cutpoint = list(np.random.choice(
                        num_gene, 2, replace=False))
                    cutpoint.sort()

                    child_1[cutpoint[0]:cutpoint[1]
                    ] = parent_2[cutpoint[0]:cutpoint[1]]
                    child_2[cutpoint[0]:cutpoint[1]
                    ] = parent_1[cutpoint[0]:cutpoint[1]]
                    offspring_list[S[2 * m]] = child_1[:]
                    offspring_list[S[2 * m + 1]] = child_2[:]

            '''----------repairment-------------'''
            for m in range(population_size):
                job_count = {}
                # 'larger' record jobs appear in the chromosome more than m times, and 'less' records less than m times.
                larger, less = [], []
                for i in range(num_job):
                    if i in offspring_list[m]:
                        count = offspring_list[m].count(i)
                        pos = offspring_list[m].index(i)
                        # store the above two values to the job_count dictionary
                        job_count[i] = [count, pos]
                    else:
                        count = 0
                        job_count[i] = [count, 0]
                    if count > num_mc:
                        larger.append(i)
                    elif count < num_mc:
                        less.append(i)

                for k in range(len(larger)):
                    chg_job = larger[k]
                    while job_count[chg_job][0] > num_mc:
                        for d in range(len(less)):
                            if job_count[less[d]][0] < num_mc:
                                offspring_list[m][job_count[chg_job]
                                [1]] = less[d]
                                job_count[chg_job][1] = offspring_list[m].index(
                                    chg_job)
                                job_count[chg_job][0] = job_count[chg_job][0] - 1
                                job_count[less[d]][0] = job_count[less[d]][0] + 1
                            if job_count[chg_job][0] == num_mc:
                                break

            '''--------mutatuon--------'''
            for m in range(len(offspring_list)):
                mutation_prob = np.random.rand()
                if mutation_rate >= mutation_prob:
                    # chooses the position to mutation
                    m_chg = list(np.random.choice(
                        num_gene, num_mutation_jobs, replace=False))
                    # save the value which is on the first mutation position
                    t_value_last = offspring_list[m][m_chg[0]]
                    for i in range(num_mutation_jobs - 1):
                        # displacement
                        offspring_list[m][m_chg[i]
                        ] = offspring_list[m][m_chg[i + 1]]

                    # move the value of the first mutation position to the last mutation position
                    offspring_list[m][m_chg[num_mutation_jobs - 1]
                    ] = t_value_last

            '''--------fitness value(calculate makespan)-------------'''
            total_chromosome = copy.deepcopy(
                parent_list) + copy.deepcopy(offspring_list)  # parent and offspring chromosomes combination
            chrom_fitness, chrom_fit = [], []
            total_fitness = 0
            for m in range(population_size * 2):  # for every gene line
                j_keys = [j for j in range(num_job)]
                key_count = {key: 0 for key in j_keys}
                j_count = {key: 0 for key in j_keys}
                m_keys = [j + 1 for j in range(num_mc)]
                m_count = {key: 0 for key in m_keys}

                for i in total_chromosome[m]:
                    gen_t = int(pt[i][key_count[i]])
                    gen_m = int(ms[i][key_count[i]])
                    j_count[i] = j_count[i] + gen_t
                    m_count[gen_m] = m_count[gen_m] + gen_t

                    if m_count[gen_m] < j_count[i]:
                        m_count[gen_m] = j_count[i]
                    elif m_count[gen_m] > j_count[i]:
                        j_count[i] = m_count[gen_m]

                    key_count[i] = key_count[i] + 1

                makespan = max(j_count.values())
                chrom_fitness.append(1 / makespan)
                chrom_fit.append(makespan)
                total_fitness = total_fitness + chrom_fitness[m]+0.01

            '''----------selection(roulette wheel approach)----------'''
            pk, qk = [], []

            for i in range(population_size * 2):
                pk.append(chrom_fitness[i] / total_fitness)
            for i in range(population_size * 2):
                cumulative = 0
                for j in range(0, i + 1):
                    cumulative = cumulative + pk[j]
                qk.append(cumulative)

            selection_rand = [np.random.rand() for i in range(population_size)]

            for i in range(population_size):
                if selection_rand[i] <= qk[0]:
                    population_list[i] = copy.deepcopy(total_chromosome[0])
                else:
                    for j in range(0, population_size * 2 - 1):
                        if selection_rand[i] > qk[j] and selection_rand[i] <= qk[j + 1]:
                            population_list[i] = copy.deepcopy(
                                total_chromosome[j + 1])
                            break
            '''----------comparison----------'''
            for i in range(population_size * 2):
                if chrom_fit[i] < Tbest_now:
                    Tbest_now = chrom_fit[i]
                    sequence_now = copy.deepcopy(total_chromosome[i])
            if Tbest_now <= Tbest:
                Tbest = Tbest_now
                sequence_best = copy.deepcopy(sequence_now)

            makespan_record.append(Tbest)
        '''----------result----------'''
        # print("optimal sequence", sequence_best)
        # print("optimal value:%f" % Tbest)
        # print('the elapsed time:%s' % (time.time() - start_time))

        import pandas as pd
        import datetime

        x = np.zeros((self.m, self.n, 2), dtype=int)
        h = np.zeros((self.m, self.n), dtype=int)
        e = np.zeros((self.m, self.n), dtype=int)

        m_keys = [j + 1 for j in range(num_mc)]
        j_keys = [j for j in range(num_job)]
        key_count = {key: 0 for key in j_keys}
        j_count = {key: 0 for key in j_keys}
        m_count = {key: 0 for key in m_keys}
        j_record = {}
        for i in sequence_best:
            gen_t = int(pt[i][key_count[i]])  # time
            gen_m = int(ms[i][key_count[i]])  # order
            j_count[i] = j_count[i] + gen_t  # time of job
            m_count[gen_m] = m_count[gen_m] + gen_t  # time of machine

            if m_count[gen_m] < j_count[i]:
                m_count[gen_m] = j_count[i]
            elif m_count[gen_m] > j_count[i]:
                j_count[i] = m_count[gen_m]

            # convert seconds to hours, minutes and seconds
            start_time = int(j_count[i] - pt[i][int(key_count[i])])
            end_time = int(j_count[i])

            j_record[(i, gen_m)] = [start_time, end_time, key_count[i]]

            key_count[i] = key_count[i] + 1

        df = []
        for m in m_keys:
            for j in j_keys:
                list_of_start = [j_record[(q, m)][0] for q in j_keys]
                list_of_start.sort()
                order = list_of_start.index(j_record[(j, m)][0])
                h[m - 1, order] = j_record[(j, m)][0]
                e[m - 1, order] = j_record[(j, m)][1]
                x[m - 1, order, 0] = j
                x[m - 1, order, 1] = j_record[(j, m)][2]
                df.append(dict(Task='Machine %s' % (m), Start='2018-07-14 %s' % (str(j_record[(
                    j, m)][0])), Finish='2018-07-14 %s' % (str(j_record[(j, m)][1])), Resource='Job %s' % (j + 1)))
                self.start=h
                self.end=e
                
        self.h = h
        self.e = e
        self.x = x
        self.best_x = x
        # self.PlotResult()
        # plt.show()

    def PlotResult(self, num=0):

        colorbox = ['yellow', 'whitesmoke', 'lightyellow',
                    'khaki', 'silver', 'pink', 'lightgreen', 'orange', 'grey', 'r', 'brown']

        for i in range(100):
            colorArr = ['1', '2', '3', '4', '5', '6', '7',
                        '8', '9', 'A', 'B', 'C', 'D', 'E', 'F']
            color = ""
            for i in range(6):
                color += colorArr[random.randint(0, 14)]
            colorbox.append("#" + color)

        zzl = plt.figure(figsize=(12, 4))
        for i in range(self.m):
            # number_of_mashine:
            for j in range(self.n):
                # number_of_job:

                mPoint1 = self.h[i, j]
                mPoint2 = self.e[i, j]
                mText = i + 1.5
                PlotRec(mPoint1, mPoint2, mText)
                Word = str(self.x[i, j, 0] + 1) + '.' + str(self.x[i, j, 1] + 1)
                # hold on

                x1 = mPoint1
                y1 = mText - 0.8
                x2 = mPoint2
                y2 = mText - 0.8
                x3 = mPoint2
                y3 = mText
                x4 = mPoint1
                y4 = mText

                plt.fill([x1, x2, x3, x4], [y1, y2, y3, y4],
                         color=colorbox[self.x[i, j, 0]])

                plt.text(0.5 * mPoint1 + 0.5 * mPoint2 - 3, mText - 0.5, Word)
        plt.xlabel('Time')
        plt.ylabel('Machine')
        plt.tight_layout()
        plt.savefig('./results/out.png', dpi=700)

    def SoluteWithBBMAndSaveToFile(self, filepath, index, pool=0):
        self.SoluteWithBBM()
        self.SaveProblemToFile(filepath, index, pool)
        self.SavesolutionToFile(filepath, index, pool)

    def SoluteWithGaAndSaveToFile(self, filepath, index, pool=0):
        self.SoluteWithGA()
        self.SaveProblemToFile(filepath, index, pool)
        self.SavesolutionToFile(filepath, index, pool)

    def LoadProblemWithSolution(self, filepath, index, pool=0):
        f = open('data/jssp_problem_' + filepath, 'r')
        # line_list = [ i for i in range(index * 7, index * 7 + 7 )]
        data = f.readlines()
        data = data[index * 7:index * 7 + 7]
        self.m = int(data[0])
        self.n = int(data[1])
        # print(data[2])
        self.p = np.fromstring(
            data[2][:-1], dtype=int, sep=',').reshape((self.n, self.m))
        self.r = np.fromstring(
            data[3][:-1], dtype=int, sep=',').reshape((self.n, self.m))
        self.x = np.fromstring(
            data[4][:-1], dtype=int, sep=',').reshape((self.m, self.n, 2))
        self.h = np.fromstring(
            data[5][:-1], dtype=int, sep=',').reshape((self.m, self.n))
        self.e = np.fromstring(
            data[6][:-1], dtype=int, sep=',').reshape((self.m, self.n))

    def CalculateSimilarityDegree(self, x=None):

        if x is not None:
            self.x = x

        right = 0
        for i in range(self.m):
            for j in range(self.n):
                if self.x[i, j, 0] == self.best_x[i, j, 0] and self.x[i, j, 1] == self.best_x[i, j, 1]:
                    right += 1

        return right / self.m / self.n

    def LoadProblemWithoutSolution(self, filepath, index, pool=0):
        f = open('data/jssp_problem_' + filepath, 'r')
        # line_list = [ i for i in range(index * 7, index * 7 + 7 )]
        data = f.readlines()
        data = data[index * 7:index * 7 + 7]
        self.m = int(data[0])
        self.n = int(data[1])
        # print(data[2])
        self.p = np.fromstring(
            data[2][:-1], dtype=int, sep=',').reshape((self.n, self.m))
        self.r = np.fromstring(
            data[3][:-1], dtype=int, sep=',').reshape((self.n, self.m))

        # self.x = np.fromstring(
        #     data[4][:-1], dtype=int, sep=',').reshape((self.m, self.n, 2))
        # self.h = np.fromstring(
        #     data[5][:-1], dtype=int, sep=',').reshape((self.m, self.n))
        # self.e = np.fromstring(
        #     data[6][:-1], dtype=int, sep=',').reshape((self.m, self.n))

    def subproblem(self):
        sub_list = []
        for job in range(self.n):
            for procedure in range(self.m):
                sub_p = Subproblem(self, job, procedure)
                sub_list.append(sub_p)
        return sub_list

    def GetFeaturesInTest1D(self):

        F = []
        sub_list = self.subproblem()
        for sub in sub_list:
            F.append(sub.GetFeatures1D())
        F = np.array(F)

        return F

    def Getlables(self):

        L = []
        sub_list = self.subproblem()
        for sub in sub_list:
            L.append(sub.label)
        L = np.array(L)

        return L

    def GetFeaturesInTest1D2D(self):
        len_feature_1d = self.number_of_1d_feature
#         len_feature_detailed=self.n*self.m

        F1d = []
# #         F_s=[]   ###########add
# #         F_e=[]   ###########add
        
#         F2d1 = []
#         F2d2 = []
#         F2d3 = []
#         F2d4 = []
#         F2d5 = []
#         F2d6 = []

        sub_list = self.subproblem()
        for sub in sub_list:
            F1d.append(sub.GetFeatures1D())
# #             F_s.append(sub.GetFeaturesDetailed()[0])
# #             F_e.append(sub.GetFeaturesDetailed()[1])
        
#             features_2d = sub.GetFeatures2D()
#             F2d1.append(features_2d[0])
#             F2d2.append(features_2d[1])
#             F2d3.append(features_2d[2])
#             F2d4.append(features_2d[3])
#             F2d5.append(features_2d[4])
#             F2d6.append(features_2d[5])

        F1d = np.array(F1d).reshape((-1, len_feature_1d, 1))
# #         F_s=np.array(F_s).reshape((-1,len_feature_detailed,1))
# #         F_e=np.array(F_e).reshape((-1,len_feature_detailed,1))

#         F2d1 = np.array(F2d1).reshape(
#             (-1, self.n ** 2, self.n ** 2, 1))
#         F2d2 = np.array(F2d2).reshape(
#             (-1, self.n ** 2, self.n, 1))
#         F2d3 = np.array(F2d3).reshape(
#             (-1, self.n ** 2, len_feature_1d, 1))
#         F2d4 = np.array(F2d4).reshape(
#             (-1, self.n, self.n, 1))
#         F2d5 = np.array(F2d5).reshape(
#             (-1, self.n, len_feature_1d, 1))
#         F2d6 = np.array(F2d6).reshape(
#             (-1, len_feature_1d, len_feature_1d, 1))

#         tf = F1d.reshape((-1, len_feature_1d, 1))
#               F_s.reshape((-1,len_feature_detailed,1)),
#              F_e.reshape((-1,len_feature_detailed,1))]

        return F1d

    def GetIndexMatrix(self):
        index = np.zeros((self.n, self.m))

        sub = self.subproblem()
        for s in sub:
            index[s.job_id, s.machine_id] = s.SearchInX()
        return index

    def SchedulingSequenceGenerationMethod(self, output):
        np.savetxt('output.csv', output, fmt="%.2f", delimiter=',')
        for i in range(self.m * self.n):
            output[i, :] = output[i, :] / output[i, :].sum()

        h = np.zeros((self.m, self.n))
        e = np.zeros((self.m, self.n))
        x = np.zeros((self.m, self.n, 2))

        procedure_job = [0] * self.n
        order_machine = [0] * self.m

        for i in range(self.m * self.n):
            possible_probability = []

            for job in range(self.n):
                procedure = procedure_job[job]
                machine = self.r[job, min(4, procedure)]
                order = order_machine[machine]
                if procedure < 5 and order < 5:
                    possible_probability.append(
                        [job, procedure, machine, order, output[job * self.m + procedure][order]])
                else:
                    machine = -1
                    possible_probability.append([job, procedure, machine, order, 0])

            possible_probability = sorted(possible_probability, key=lambda x: x[4])

            bestjob, bestproce, bestmachine, bestorder = possible_probability[-1][:4]
            x[bestmachine, bestorder][:] = [bestjob, bestproce]

            procedure_job[bestjob] += 1
            order_machine[bestmachine] += 1

        self.x = x

    def GurobiModelingmethod(self, output):
        np.savetxt('output.csv', output, fmt="%.2f", delimiter=',')
        lables = self.Getlables()
        R = self.r.reshape(self.m * self.n)
        # x ,p = guchoose.main(output,R,lables,self.m,self.n)

        x = [[] for j in range(self.m)]######################################################Chaning 
        h = np.zeros((self.m, self.n))
        e = np.zeros((self.m, self.n))

        for order in range(self.n):
            timeline_machine = np.zeros((self.m), dtype=int)
            timeline_jobs = np.zeros((self.n), dtype=int)
            index_in_machine = np.zeros((self.m), dtype=int)
            job_finsh = np.zeros((self.n), dtype=int)
            for i in range(self.m * self.n):
                mask = np.zeros((self.m), dtype=int)
                for ma in range(self.m):
                    job, order = x[ma, min(self.n - 1, index_in_machine[ma]), :]
                    # if job_finsh[job] == order:
                    mask[ma] = timeline_machine[ma]
                    # else:
                    #     mask[ma] = 10000
                earlyestmachine = np.argmin(mask)

                while index_in_machine[earlyestmachine] == self.n:
                    timeline_machine[earlyestmachine] = 100000
                    earlyestmachine = np.argmin(timeline_machine)
                # while can_do_in_machine[earlyestmachine]

                job, order = x[earlyestmachine,
                             index_in_machine[earlyestmachine], :]
                time_s = max(
                    timeline_machine[earlyestmachine], timeline_jobs[job])
                time_e = time_s + self.p[job, order]
                timeline_machine[earlyestmachine] = time_e
                timeline_jobs[job] = time_e
                h[earlyestmachine, index_in_machine[earlyestmachine]] = time_s
                e[earlyestmachine, index_in_machine[earlyestmachine]] = time_e
                index_in_machine[earlyestmachine] += 1
                job_finsh[job] += 1

        self.e = e
        self.h = h

    def PriorityQueuingMethod(self, output):
        np.savetxt('output.csv', output, fmt="%.2f", delimiter=',')
        lables = self.Getlables()
        R = self.r.reshape(self.m * self.n)

        x = [[] for j in range(self.m)]
        for i in range(self.m * self.n):
            machine = R[i]
            x[machine].append([i // self.m, i % self.m, output[i]])

        for m in range(self.m):
            x[m].sort(key=lambda x: x[2])

        xx = np.zeros((self.m, self.n, 2), dtype=int)
        for i in range(self.m):
            for j in range(self.n):
                xx[i, j, 0] = x[i][j][0]
                xx[i, j, 1] = x[i][j][1]
        x = xx
#         self.x = xx                         ####################################Changing
        h = np.zeros((self.m, self.n))
        e = np.zeros((self.m, self.n))

        for order in range(self.n):
            timeline_machine = np.zeros((self.m), dtype=int)
            timeline_jobs = np.zeros((self.n), dtype=int)
            index_in_machine = np.zeros((self.m), dtype=int)
            job_finsh = np.zeros((self.n), dtype=int)
            for i in range(self.m * self.n):
                mask = np.zeros((self.m), dtype=int)
                for ma in range(self.m):
                    job, order = x[ma, min(self.n - 1, index_in_machine[ma]), :]
                    if job_finsh[job] == order:
                        mask[ma] = timeline_machine[ma]
                    else:
                        mask[ma] = 10000
                earlyestmachine = np.argmin(mask)

                while index_in_machine[earlyestmachine] == self.n:
                    timeline_machine[earlyestmachine] = 100000
                    earlyestmachine = np.argmin(timeline_machine)
                # while can_do_in_machine[earlyestmachine]

                job, order = x[earlyestmachine,
                             index_in_machine[earlyestmachine], :]
                time_s = max(
                    timeline_machine[earlyestmachine], timeline_jobs[job])
                time_e = time_s + self.p[job, order]
                timeline_machine[earlyestmachine] = time_e
                timeline_jobs[job] = time_e
                h[earlyestmachine, index_in_machine[earlyestmachine]] = time_s
                e[earlyestmachine, index_in_machine[earlyestmachine]] = time_e
                index_in_machine[earlyestmachine] += 1
                job_finsh[job] += 1

    def GetMakespan(self):
        return self.e.max()


def TranslateNpToStr(m):
    a = m.reshape((-1))
    a = list(a)
    s = ''.join(['{},'.format(round(o, 2)) for o in a]) + '\n'
    return s


def PlotRec(mPoint1, mPoint2, mText):
    vPoint = np.zeros((4, 2))
    vPoint[0, :] = [mPoint1, mText - 0.8]
    vPoint[1, :] = [mPoint2, mText - 0.8]
    vPoint[2, :] = [mPoint1, mText]
    vPoint[3, :] = [mPoint2, mText]
    plt.plot([vPoint[0, 0], vPoint[1, 0]], [vPoint[0, 1], vPoint[1, 1]], 'k')
    # hold on
    plt.plot([vPoint[0, 0], vPoint[2, 0]], [vPoint[0, 1], vPoint[2, 1]], 'k')
    plt.plot([vPoint[1, 0], vPoint[3, 0]], [vPoint[1, 1], vPoint[3, 1]], 'k')
    plt.plot([vPoint[2, 0], vPoint[3, 0]], [vPoint[2, 1], vPoint[3, 1]], 'k')


import numpy as np
import matplotlib.pyplot as plt
import random

class Subproblem:
    father_problem = None
    machine_id = None
    job_id = None
    procedure = None
    time = None
    num_of_machine = None
    num_of_job = None
    number_of_1D_feature = None
    features_1D = None
    features_2D = None
    order_in_machine = None
#     features_start=None ###################add
#     features_end=None #######################add

    label = []

    def __init__(self, fatherproblem, jobs, procedure):
        self.father_problem = fatherproblem
        self.job_id = jobs
        self.procedure = procedure
        self.machine_id = fatherproblem.r[jobs, procedure] - 1
        self.time = self.father_problem.p[self.job_id, self.machine_id]
        self.num_of_job = fatherproblem.p.shape[0]
        self.num_of_machine = fatherproblem.p.shape[1]

        self.label = self.SearchInX()
        self.time2 = self.label
        self.order_in_machine = self.SearchInX()
        self.features_1D = self.GetFeatures1D()
        self.features_2D = self.GetFeatures2D()
#         self.features_start,self.features_end=self.GetFeaturesDetailed()

    def SearchInX(self):

        for i in range(self.num_of_machine):
            for j in range(self.num_of_job):
                if self.job_id == self.father_problem.x[i, j, 0] and self.procedure == self.father_problem.x[i, j, 1]:
                    self.order_in_machine = j
                    return j
        return 'error'

    def CheckOrderInMachine(self):
        father_problem = self.father_problem
        joblist_in_machine = []
        for job in range(father_problem.n):
            for pro in range(father_problem.m):
                machine = father_problem.r[job, pro]
                if machine - 1 == self.machine_id:
                    joblist_in_machine.append([job, pro])

        joblist_in_machine.sort(key=lambda d: d[1])
        index = joblist_in_machine.index([self.job_id, self.procedure])
        return index

    def GetFeatures1D(self):
        # p [job,order]
        # r [job,order]

        features = np.zeros((18))
        
        start_time=np.zeros((self.father_problem.m,self.father_problem.n))
        start_end=np.zeros((self.father_problem.m,self.father_problem.n))
        
        T_max=float(self.father_problem.p.max())       #####################add
        T_min=float(self.father_problem.p.min())      ####################add
        T_mean=float(self.father_problem.p.mean())     ####################add
        T_total = float(self.father_problem.p.sum())
        
        T_machine = float(self.father_problem.p[:, self.machine_id].sum())
        T_job = float(self.father_problem.p[self.job_id, :].sum())
        T_item = float(self.time)
        order_of_procedure_in_machine = float(self.CheckOrderInMachine())
        
        ############Job
        features[0] = self.procedure / self.father_problem.n
        features[1] = T_item/ T_total
        features[2]=T_item/T_max          ##################
        features[3]=T_item/T_min          ##################
        features[4]=T_item/T_mean         ##################

        features[5] = self.father_problem.p[self.job_id,
                                            :self.procedure].sum() / T_job
        features[6] = self.father_problem.p[self.job_id,self.procedure]/self.father_problem.p[self.job_id,
                                            :self.procedure].sum()  #####################
        
        features[7] = self.father_problem.p[self.job_id,
                                             self.procedure:].sum() / T_job
                
        features[8] = self.father_problem.p[self.job_id,self.procedure]/self.father_problem.p[self.job_id,
                                             self.procedure:].sum() ######################

        features[9] = self.job_id/self.father_problem.n
        
        features[10] = T_item/T_machine
        features[11] = T_job/T_machine
        features[12] = np.sum(
            self.father_problem.r[:, self.procedure] == self.machine_id)/self.father_problem.n
        features[13] = order_of_procedure_in_machine/self.father_problem.n #######Unused
        features[14] = self.machine_id/self.father_problem.m
        features[15]=T_item #####################
        features[16]=order_of_procedure_in_machine   ############unused
        features[17]=self.procedure  ######################
        
        statr_time=self.father_problem.start
        end_time=self.father_problem.end
        

        self.number_of_1D_feature = features.shape[0]
        return features
                                                         
#     def GetFeaturesDetailed(self):
#         features_start=self.father_problem.h
#         features_end=self.father_problem.e
#         return features_start,features_end
                                                     
    def GetPLine(self):
        out = np.zeros((self.father_problem.n*self.father_problem.n, 1))
        sum_time_job = self.father_problem.p.sum(axis=1)
        for i in range(self.father_problem.n):
            for j in range(self.father_problem.n):
                out[i*self.father_problem.n + j,
                    0] = sum_time_job[i]/sum_time_job[j]
        # assert(sum_time_job.shape == self.father_problem.n)
        return out

    def GetELine(self):
        out = np.zeros((self.father_problem.n, 1))
        sum_time_job = self.father_problem.p.sum(axis=1)
        for i in range(self.father_problem.n):
            out[i, 0] = self.time/sum_time_job[i]
        # assert(sum_time_job.shape == self.father_problem.n)
        return out

    def GetFeatures2D(self):
        features = []

        p_line = self.GetPLine()
        E_line = self.GetELine()
        f_line = self.features_1D.reshape((-1, 1))

        features.append(np.dot(p_line, p_line.T))
        features.append(np.dot(p_line, E_line.T))
        features.append(np.dot(p_line, f_line.T))
        features.append(np.dot(E_line, E_line.T))
        features.append(np.dot(E_line, f_line.T))
        features.append(np.dot(f_line, f_line.T))

        return features

    def Show2DFeatures(self):

        plt.figure(figsize=(6, 4))

        plt.subplot(231)
        plt.imshow(self.features_2D[0])
        plt.xlabel(r'$D^{2d}_{P^l,P^l}$')
        plt.subplot(232)
        plt.imshow(self.features_2D[1].T)
        plt.xlabel(r'$D^{2d}_{P^l,E^l}$')
        plt.subplot(233)
        plt.imshow(self.features_2D[2].T)
        plt.xlabel(r'$D^{2d}_{P^l,F^{l}_{ij}}$')
        plt.subplot(234)
        plt.imshow(self.features_2D[3])
        plt.xlabel(r'$D^{2d}_{E^l,E^l}$')
        plt.subplot(235)
        plt.imshow(self.features_2D[4])
        plt.xlabel(r'$D^{2d}_{E^l,F^{l}_{ij}}$')
        plt.subplot(236)
        plt.imshow(self.features_2D[5])
        plt.xlabel(r'$D^{2d}_{F^{l}_{ij},F^{l}_{ij}}$')
        plt.tight_layout()
        plt.savefig('figure/n={}m={}order={}.png'.format(self.machine_id,
                                                         self.job_id, self.procedure), dpi=500)

        plt.close()
        plt.show()

    def SaveFeaturesToFile(self, filepath, index, pool=0):

        father_problem = self.father_problem
        f = open('{}/jssp_feature_m={}_n={}_timehigh={}_timelow={}_pool={}.txt'.format(
            filepath, father_problem.m, father_problem.n, father_problem.time_high, father_problem.time_low, pool), 'a')
        f.write(TranslateNpToStr(self.features_1D))
        f.close()

    def SaveLablesToFile(self, filepath, index, pool=0):

        father_problem = self.father_problem
        probinfo = 'm={}_n={}_timehigh={}_timelow={}_pool={}.txt'.format(
            father_problem.m, father_problem.n, father_problem.time_high, father_problem.time_low, pool)

        f = open('{}/jssp_label_m={}_n={}_timehigh={}_timelow={}_pool={}.txt'.format(
            filepath, father_problem.m, father_problem.n, father_problem.time_high, father_problem.time_low, pool), 'a')
        f.write(str(self.label)+'\n')
        f.close()

        return probinfo

    def LoadFeatures(self, filepath, index, pool=0):

        father_problem = self.father_problem
        f = open('{}/jssp_problem_m={}_n={}_timehigh={}_timelow={}_pool={}.txt'.format(
            filepath, father_problem.m, father_problem.n, father_problem.time_high, father_problem.time_low, pool), 'r')
        data = f.readlines()
        data = data[index * 7:index * 7 + 7]

        len_of_1D_features = np.fromstring(
            data[0][:-1], dtype=float, sep=',').shape[0]
        len_of_m_muti_n = int(np.sqrt(np.fromstring(
            data[1][:-1], dtype=float, sep=',').shape))

        self.features_1D = np.fromstring(data[0][:-1], dtype=float, sep=',')
        featrue_2D = []
        featrue_2D.append(np.fromstring(
            data[1][:-1], dtype=float, sep=',').reshape((len_of_m_muti_n, len_of_m_muti_n)))
        featrue_2D.append(np.fromstring(
            data[2][:-1], dtype=float, sep=',').reshape((len_of_m_muti_n, len_of_m_muti_n)))
        featrue_2D.append(np.fromstring(
            data[3][:-1], dtype=float, sep=',').reshape((len_of_m_muti_n, len_of_1D_features)))
        featrue_2D.append(np.fromstring(
            data[4][:-1], dtype=float, sep=',').reshape((len_of_m_muti_n, len_of_m_muti_n)))
        featrue_2D.append(np.fromstring(
            data[5][:-1], dtype=float, sep=',').reshape((len_of_m_muti_n, len_of_1D_features)))
        featrue_2D.append(np.fromstring(
            data[6][:-1], dtype=float, sep=',').reshape((len_of_1D_features, len_of_1D_features)))
        f.close()

        self.features_2D = featrue_2D
        return self.features_1D, self.features_2D

    def PrintInfo(self):
        print('machineid is {}, jobid is {}'.format(self.job_id, self.job_id))
        print(self.features_1D)
        print(self.features_2D)


import matplotlib.pyplot as plt
import numpy as np
import progressbar
def CreateJssp_BBM(number_of_problem, index_cpu, m, n, 
                   timehigh, timelow,
                   solution_path_bbm,feature_path_bbm,label_path_bbm,
                   solution_path_ga,feature_path_ga,label_path_ga,
                   bool_random):
    # Create Jobshop problem with ortools and save it to 'bigdata/'
    # problem can be solute with two main method:
    #   1. Branch and bound method (BBM) for small problems
    #   2. Genetic Method(GA) for big problems
    # Input:
    #   number_of_loop: is the number of problems need to create
    #   index_cpu: only used in muti cpu:
    #   m: the number of the machine in jobshop problem
    #   n: the number of the job in the job problem
    #   timehigh: the max producing time of the job's one processing
    #   timelow: the min producing time of the job's one processing

    pbar = progressbar.ProgressBar().start()
    for p in range(number_of_problem):

        pbar.update(int((p / (number_of_problem - 1)) * 100))

        # init one Jobshop problem randomly
        prob = Problem(m, n, time_low=timelow,time_high=timehigh,bool_random=bool_random)
        # solute the problem with two method, you can change it
        # if you do not the the ortools wheels, choose the GA method
        # prob.SoluteWithGaAndSaveToFile('bigdata/data', 0)
        prob.SoluteWithBBMAndSaveToFile(solution_path_bbm, 0)

        # print the information of the problem and the solution, and save it in to the file 'bigdata/'
        # prob.Print_info()
        sub_list = prob.subproblem()
        for i, subp in enumerate(sub_list):
            subp.SaveFeaturesToFile(feature_path_bbm, i)
            info = subp.SaveLablesToFile(label_path_bbm, i)
        
#         prob.SoluteWithGaAndSaveToFile(solution_path_ga, 0)
#         sub_list = prob.subproblem()
#         for i, subp in enumerate(sub_list):
#             subp.SaveFeaturesToFile(feature_path_ga, i)
#             info = subp.SaveLablesToFile(label_path_ga, i)
    pbar.finish()



def loadFeaturesAndLabels(feature_path,label_path):

        features_1D_list = []
        label_list = []
        
        ###########Feature 
        with open(feature_path, 'r') as f:
            while True:
                data =f.readline()
                if data!= '':
                    features_1D = np.fromstring(data, dtype=float, sep=',')
                    features_1D_list.append(features_1D[0:18])
                else:
                    break
        
        ############label
        with open(label_path, 'r') as f:
            while True:
                data = f.readline()
                if data != '':
                    label_list.append(int(data))
                else:
                    break
                    
        return np.asanyarray(features_1D_list),np.asanyarray(label_list) 
################features have 11 elements


# In[23]:


from sklearn.cluster import KMeans
# function returns WSS score for k values from 1 to kmax
def calculate_WSS(points, kmax):
    sse = []
    for k in range(1, kmax+1):
        kmeans = KMeans(n_clusters = k).fit(points)
        centroids = kmeans.cluster_centers_
        pred_clusters = kmeans.predict(points)
        curr_sse = 0
        # calculate square of Euclidean distance of each point from its cluster center and add to current WSS
        for i in range(len(points)):
            curr_center = centroids[pred_clusters[i]]
            curr_sse += (points[i, 0] - curr_center[0]) ** 2 + (points[i, 1] - curr_center[1]) ** 2
        sse.append(curr_sse)


def normilization(data):
    """DATA NORMILIZATION
       The result willl be a list"""
    dataset=data
    max_value = np.max(dataset)
    min_value = np.min(dataset)
    scalar = max_value - min_value
    dataset=(dataset-min_value)/(scalar)
#     dataset = list(map(lambda x: (x-min_value) / scalar, dataset))
    return dataset


from sklearn.model_selection import train_test_split
import time
import keras
import numpy as np
import tensorflow as tf
from keras.layers import (Conv2D, Dense, RepeatVector,Dropout,BatchNormalization, Flatten, Input, MaxPooling2D, LSTM,TimeDistributed)
from keras.models import Model
from keras.utils import np_utils, plot_model,to_categorical
from keras.callbacks import EarlyStopping, ModelCheckpoint


def SS_lstm(trainX1,trainY1,testX1,testY1,trainX2,testX2,model_path):
    alpha=0.4
    input_shape=(18,1)
    classes=len(np.unique(trainY1))
    
    input2=Input((1,1))
    
    input1=Input(input_shape)
    batch=BatchNormalization()(input1)
    lstm1=LSTM(64,activation="relu",return_sequences=True)(batch)
    lstm2=LSTM(128,activation="relu",return_sequences=False)(lstm1)
    
    flatten1=Flatten()(input2)
    fetures=keras.layers.concatenate([lstm2,flatten1])
    
    out1=Dense(classes,activation='softmax',name="classification")(fetures)
    
    repeat_vector=RepeatVector(input_shape[0])(lstm2) ###############inpuu_shape[0] is time_steps

    decoder_lstm2=LSTM(128,activation="relu",return_sequences=True)(repeat_vector)
    decoder_lstm1=LSTM(64,activation="relu",return_sequences=True)(decoder_lstm2)
    
    out2=Dense(input_shape[1],activation="linear",name="linear_regression")(decoder_lstm1)

    model=keras.models.Model(inputs=[input1,input2],outputs=[out1,out2])
    
    model.compile(loss={'classification':'categorical_crossentropy','linear_regression':'mse'},optimizer="adam",
                 loss_weights={'classification':1-alpha,'linear_regression':alpha})
    
    model.summary()
    
    path=model_path
    keras_callbacks   = [
      EarlyStopping(monitor='val_loss', patience=10, mode='min', min_delta=0.000001),
      ModelCheckpoint(path, monitor='val_loss', save_best_only=True, mode='min')]
    
    his=model.fit([trainX1.reshape(len(trainX1),input_shape[0],input_shape[1]),
               trainX2.reshape(len(trainX2),1,1)],
              [to_categorical(trainY1),trainX1.reshape(len(trainX1),18,1)],
              validation_data=[[testX1.reshape(len(testX1),input_shape[0],input_shape[1]),
                                testX2.reshape(len(testX2),1,1)],
                               [to_categorical(testY1),testX1.reshape(len(testX1),18,1)]],
              callbacks=keras_callbacks,
              batch_size=24,epochs=150)
    return model,his



# ## Testing 
####### Generating the testing sampels using GA or BBM
def generate_new_jssp_GA(m,n,time_low,time_high,bool_random):
    new_pro= Problem(m,n,time_low,time_high,bool_random=bool_random)
    new_pro.SoluteWithGA()
    best_mak = new_pro.GetMakespan()
    features = new_pro.GetFeaturesInTest1D2D()
    
    return features,best_mak,new_pro


from keras.models import load_model


# In[31]:


def generating_features_labels(m,n,nubmers_of_problems):
    """ft10by10 JSSP training instances if m,n is setted as 10 by 10"""
    #Generating the training samples using optimal methods 
    m=m
    n=n
    timehigh =50
    timelow = 10
    pool = 0
    CreateJssp_BBM(nubmers_of_problems, pool,m,n, timehigh, timelow,"./solution/BBM/ft10by10/",
               "./feature/BBM/ft10by10/",
               "./label/BBM/ft10by10/",
               "./solution/GA/ft10by10/",
               "./feature/GA/ft10by10/",
               "./label/GA/ft10by10/",
               True)
    
    #Loading the generating samples including features and lables 
    features_1D_bbm,labels_1D_bbm=loadFeaturesAndLabels("./feature/BBM/ft10by10/jssp_feature_m={}_n={}_timehigh=50_timelow=10_pool=0.txt".format(m,n),
                                                   "./label/BBM/ft10by10/jssp_label_m={}_n={}_timehigh=50_timelow=10_pool=0.txt".format(m,n))
    
    
    #Caculating the system features using the Kmeans algorithm 
    WSS=calculate_WSS(features_1D_bbm,30)
    kmeans=KMeans(n_clusters = 12).fit(features_1D_bbm)
    centroids = kmeans.cluster_centers_
    pred_clusters = kmeans.predict(normilization(features_1D_bbm))
    df=pd.DataFrame(normilization(features_1D_bbm),pred_clusters)
    df["type"]=pred_clusters
    features_1D_bbm=np.array(df)
    
    return features_1D_bbm,labels_1D_bbm

def training_model(features,labels):
    X_train_bbm, X_test_bbm, y_train_bbm, y_test_bbm = train_test_split(features,labels, test_size=0.2, random_state=42)
    ss_lstm,his_sslstm=SS_lstm(X_train_bbm[:,0:18],y_train_bbm,X_test_bbm[:,0:18],y_test_bbm,
                X_train_bbm[:,-1],X_test_bbm[:,-1],
               "./model/fusion/best.hdf5")
    
    
def solving_new_jssp(new_m,new_n):
    """new_m: new JSSP's m
       new_n: new JSSP's n
    """
    #JSSP instance 
    features_ft10_10by10_bbm,mak_bbm_ft10_10by_10_ga,new_pro_ga=generate_new_jssp_GA(new_m,new_n,100,10,False)

    ###Step 1.1 Loading the model
    bestss_model_bbm=load_model("./model/fusion/best.hdf5")
    ###Step 1.2 Peparing the system-level features using K-means
    kmeans=KMeans(n_clusters =12).fit(normilization(features_ft10_10by10_bbm.reshape(features_ft10_10by10_bbm.shape[0],18)))
    centroids = kmeans.cluster_centers_
    pred_types = kmeans.predict(normilization(features_ft10_10by10_bbm.reshape(features_ft10_10by10_bbm.shape[0],18)))
    ###Step 1.3 Preparing the details-level feature
    features_ft10_10by10_bbm_types=pd.DataFrame(normilization(features_ft10_10by10_bbm.reshape(features_ft10_10by10_bbm.shape[0],18)))
    features_ft10_10by10_bbm_types["type"]=pred_types
    
    sslstm_bbm=bestss_model_bbm.predict([normilization(np.asarray(features_ft10_10by10_bbm_types)[:,0:18].reshape(new_m*new_n,18,1)),
                                                   np.asarray(features_ft10_10by10_bbm_types)[:,-1].reshape(new_m*new_n,1,1)])
    ###########lstm_bbm
    new_pro_ga.PriorityQueuingMethod(np.argmax(sslstm_bbm[0],axis=1)) ####################PriorityQueuingMethod()
    sslstm_mak_bbm = new_pro_ga.GetMakespan()
    print(sslstm_mak_bbm)
    new_pro_ga.PlotResult()
    
def main():
    m=5
    n=5
    number_of_problems=10
    features,labels=generating_features_labels(m,n,number_of_problems)
    training_model(features,labels)
    
    #defined the new JSSP instance 
    new_m=10
    new_n=10
    solving_new_jssp(new_m,new_n)


if __name__=="__main__":
    main()






