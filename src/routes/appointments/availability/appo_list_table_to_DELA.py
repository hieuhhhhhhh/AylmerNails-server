from .range_list_to_DELA import range_list_to_DELA
import json


def appo_list_table_to_DELA(table):
    range_list = []  # a list of tuples

    # fetch appointment length
    planned_length = table[0][3]

    # fetch list of favorable intervals
    stored_intervals = set(json.loads(table[0][2]))

    # fetch and merge opening time
    opening_time = table[1][0]
    range_list.append((None, opening_time))

    # fetch list of appointment ranges from table
    for i in range(2, len(table)):
        # get start time of every appointment
        appo_ST = table[i][0]

        # get end time of every appointment
        appo_ET = table[i][1]

        range_list.append((appo_ST, appo_ET))

    # fetch and merge closing time
    closing_time = table[1][1]
    range_list.append((closing_time, None))

    return range_list_to_DELA(range_list, planned_length, stored_intervals)
