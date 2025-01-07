from .range_list_to_DELA import range_list_to_DELA
import json


def appo_list_table_to_DELA(table):
    range_list = []  # a list of tuples

    # fetch appointment length
    planned_length = table[0][3]

    # fetch list of favorable intervals (this list is supposed to be ascending)
    stored_intervals = json.loads(table[0][2])

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

    # filter out intervals that exceed the opening hours range
    stored_intervals = slice_asc_list(stored_intervals, closing_time - opening_time)

    return range_list_to_DELA(range_list, planned_length, stored_intervals)


# to slice ascending list with a ceiling
def slice_asc_list(list, ceiling):
    # Iterate until the value exceeds the ceiling
    for i in range(len(list)):
        if list[i] > ceiling:
            return list[:i]  # Return the slice up to the current index
    return list
