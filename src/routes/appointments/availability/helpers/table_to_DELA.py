from .appo_ranges_to_spaces import appo_ranges_to_spaces
from .spaces_to_slots import spaces_to_slots
from .store_DELA_slots import store_DELA_slots
import json


def table_to_DELA(table, DELA):
    appo_ranges = []  # list of 2 endpoint of every appointment

    # fetch appointment length
    planned_length = table[0][4]
    DELA["length"] = planned_length

    # fetch list of favorable intervals (this list is supposed to be ascending)
    stored_intervals = json.loads(table[0][2])
    interval_percent = table[0][3]

    # fetch DELA_id
    DELA_id = table[0][5]

    # fetch opening time closing time
    opening_time = table[1][0]
    closing_time = table[1][1]

    if opening_time is None or closing_time is None or closing_time <= opening_time:
        return DELA

    # validate all after fetching from table (all must be not null)
    if not all(
        [
            planned_length,
            stored_intervals,
            interval_percent,
            DELA_id,
            opening_time,
            closing_time,
        ]
    ):
        return DELA

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
    spaces = appo_ranges_to_spaces(appo_ranges)
    slots = spaces_to_slots(
        spaces,
        planned_length,
        stored_intervals,
        (closing_time - opening_time) * interval_percent / 100,
    )

    # send DELA to mysql
    store_DELA_slots(slots, DELA_id)

    DELA["slots"] = slots


# to slice ascending list with a ceiling
def slice_asc_list(list, ceiling):
    # Iterate until the value exceeds the ceiling
    for i in range(len(list)):
        if list[i] > ceiling:
            return list[:i]  # Return the slice up to the current index
    return list
