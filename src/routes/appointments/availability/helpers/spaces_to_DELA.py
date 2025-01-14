from .space_to_slots import space_to_slots
from .space_to_prioritized_slots import space_to_prioritized_slots


def spaces_to_DELA(spaces, planned_length, stored_intervals):
    # result holder
    DELA = []

    # flag
    all_spaces_are_ideal = True

    # create a set contain ideal gaps
    ideal_gaps = set(stored_intervals)

    # iterate a ascending list of spaces
    for space in spaces[:-1]:
        if space not in ideal_gaps:
            all_spaces_are_ideal = False
            DELA.extend(space_to_slots(space, planned_length, stored_intervals))
        else:
            DELA.extend(
                space_to_prioritized_slots(
                    space, planned_length, stored_intervals, ideal_gaps
                )
            )

    # fetch last element is space list
    last_space = spaces[-1]

    # specially process the last space (which is also the largest length, cause the list is sorted)
    if all_spaces_are_ideal or last_space not in ideal_gaps:
        DELA.extend(space_to_slots(last_space, planned_length, stored_intervals))
    else:
        DELA.extend(
            space_to_prioritized_slots(
                last_space, planned_length, stored_intervals, ideal_gaps
            )
        )

    # return result
    return DELA
