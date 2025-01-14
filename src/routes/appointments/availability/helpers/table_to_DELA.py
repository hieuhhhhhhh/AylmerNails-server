from .appo_ranges_to_spaces import appo_ranges_to_spaces
from .spaces_to_DELA import spaces_to_DELA
from .store_DELA import store_DELA
import json


def table_to_DELA(table):
    appo_ranges = []  # a list of tuples

    # fetch appointment length
    planned_length = table[0][3]

    # fetch list of favorable intervals (this list is supposed to be ascending)
    stored_intervals = json.loads(table[0][2])

    # fetch DELA_id
    DELA_id = table[0][4]

    # fetch opening time closing time
    opening_time = table[1][0]
    closing_time = table[1][1]

    # validate all after fetching from table (all must be not null)
    if not all([planned_length, stored_intervals, DELA_id, opening_time, closing_time]):
        return []

    # merge opening time
    appo_ranges.append((None, opening_time))

    # fetch list of appointment ranges from table
    for i in range(2, len(table)):
        # get start time of every appointment
        appo_ST = table[i][0]

        # get end time of every appointment
        appo_ET = table[i][1]

        appo_ranges.append((appo_ST, appo_ET))

    # merge closing time
    appo_ranges.append((closing_time, None))

    # filter out intervals that exceed the opening hours range
    stored_intervals = slice_asc_list(stored_intervals, closing_time - opening_time)

    # create and return  DELA
    spaces = appo_ranges_to_spaces(appo_ranges, planned_length, stored_intervals)
    DELA = spaces_to_DELA(spaces)

    # send DELA to mysql
    store_DELA(DELA, DELA_id)

    return DELA


# to slice ascending list with a ceiling
def slice_asc_list(list, ceiling):
    # Iterate until the value exceeds the ceiling
    for i in range(len(list)):
        if list[i] > ceiling:
            return list[:i]  # Return the slice up to the current index
    return list
