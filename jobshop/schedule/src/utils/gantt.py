# #!/usr/bin/env python
#
# # This module helps creating Gantt from a dictionary or a text file.
# # Output formats are a Matplotlib chart or a LaTeX code (using pgfgantt).
#

import random
import numpy as np
import matplotlib.font_manager as font_manager
from matplotlib import colors as mcolors
from matplotlib import pyplot as plt
import datetime

colors = ["#e7eb1c", "#8922f0", "#e1a692", "#c92400", "#31e1ac", "#c2289e", "#63bff0", "#a7d5ed", "#e2e2e2"]

# for name, hex in mcolors.cnames.items():
#     colors.append(name)


def parse_data(file):
    try:
        textlist = open(file).readlines()
    except:
        return

    data = {}

    for tx in textlist:
        if not tx.startswith('#'):
            splitted_line = tx.split(',')
            machine = splitted_line[0]
            operations = []

            for op in splitted_line[1::]:
                label = op.split(':')[0].strip()
                l = op.split(':')[1].strip().split('-')
                start = int(l[0])
                end = int(l[1])
                operations.append([start, end, label])

            data[machine] = operations
    return data


def draw_chart(data,a):
    result = {}
    sch_id = []
    color_list = []
    order_id = []
    order_id_num = []
    machine_num = []
    x1_list = []
    x2_list = []
    y1_list = []
    nb_row = len(data.keys())

    pos = np.arange(0.5, nb_row * 0.5 + 0.5, 0.5)

    fig = plt.figure(figsize=(20, 8))
    ax = fig.add_subplot(111)

    machineID= 0
    max_len = []

    filter_empty = list(filter(lambda x: x != [], a))
    make_span =max(np.array(sum(filter_empty, []))[:, 1].astype(int) + np.array(sum(filter_empty, []))[:, 3].astype(int))
    index = 0

    for machine, operations in data.items():
        for op in operations:
            max_len.append(op[1])
            # c = random.choice(colors)
            rect = ax.barh((index*0.5)+0.5, op[1] - op[0], left=op[0], height=0.3, align='center',edgecolor='black', color=colors[int(op[2][0])], alpha=0.8)
            # rect = ax.barh((index * 0.5) + 0.5, op[1] - op[0], left=op[0], height=0.3, align='center',
            #                edgecolor=c, color=c, alpha=0.8)

            # adding label
            width = int(rect[0].get_width())
            Str = "J{}.{}".format((int(op[2][0])+1),op[2].split("-")[1])
            # Str = "OP_{}".format(op[2])
            xloc = op[0] + 0.50 * width
            clr = 'black'
            align = 'center'

            yloc = rect[0].get_y() + rect[0].get_height() / 2.0
            sch_id.append(datetime.datetime.today().strftime("%Y%m%d"))
            x1_list.append(op[0])
            x2_list.append(op[0] + width)
            y_axis = ''
            num_list = np.arange(0.5, 10, 0.5)
            for i in range(len(list(data.keys()))):
                for j in range(len(num_list)):
                    if num_list[j] == yloc:
                        y_axis = list(data.keys())[j].replace('Machine-', '')
                        machine_num.append(list(data.keys())[i])

            y1_list.append(y_axis)

            # for i in range(len(list(data.keys()))):
            #     machine_num.append(list(data.keys())[i])
            order_id_num.append("{}.{}".format((int(op[2][0])+1),op[2].split("-")[1]))
            color_list.append(colors[int(op[2][0])])

            ax.text(xloc, yloc, Str, horizontalalignment=align,
                            verticalalignment='center', color=clr, weight='bold',
                            clip_on=True)
        index+=1

    result['sch_id'] = sch_id
    result['color'] = color_list
    result['order_id_num'] = order_id_num
    result['machine_num'] = machine_num
    result['x1'] = x1_list
    result['x2'] = x2_list
    result['y1'] = y1_list

    ax.set_ylim(ymin=-0.1, ymax=nb_row * 0.5 + 0.5)
    ax.grid(color='gray', linestyle=':')
    ax.set_xlim(0, max(10, max(max_len)))

    labelsx = ax.get_xticklabels()
    plt.setp(labelsx, rotation=0, fontsize=10)

    locsy, labelsy = plt.yticks(pos, data.keys())
    plt.setp(labelsy, fontsize=14)

    font = font_manager.FontProperties(size='small')
    ax.legend(loc=1, prop=font)

    ax.invert_yaxis()
    plt.axvline(x=make_span,color='r',linestyle='--')
    # plt.text(10.5,10.5,"makespan=%d"%make_span,color='r')

    plt.title("Flexible Job Shop Solution (makespan is %d)"%make_span)
    # plt.show()
    plt.savefig('./schedule/gantt.png')

    return result

def export_latex(data):
    max_len = []
    head = """
\\noindent\\resizebox{{\\textwidth}}{{!}}{{
\\begin{{tikzpicture}}[x=.5cm, y=1cm]
\\begin{{ganttchart}}{{1}}{{{}}}
[vgrid, hgrid]{{{}}}
\\gantttitle{{Flexible Job Shop Solution}}{{{}}} \\\\
\\gantttitlelist{{1,...,{}}}{{1}} \\\\
"""
    footer = """
\\end{ganttchart}
\\end{tikzpicture}}\n
    """
    body = ""
    for machine, operations in sorted(data.items()):
        counter = 0
        for op in operations:
            max_len.append(op[1])
            label = "O$_{{{}}}$".format(op[2].replace('-', ''))
            body += "\\Dganttbar{{{}}}{{{}}}{{{}}}{{{}}}".format(machine, label, op[0]+1, op[1])
            if counter == (len(operations) - 1):
                body += "\\\\ \n"
            else:
                body += "\n"
            counter += 1

    lenM = max(10, max(max_len))
    print(head.format(lenM, lenM, lenM, lenM))
    print(body)
    print(footer)


# if __name__ == '__main__':
#     fname = r"test.txt"
#     print(parse_data(fname))
#     draw_chart(parse_data(fname),a)