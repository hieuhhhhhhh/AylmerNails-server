from .space_to_slots import space_to_slots
from .space_to_prioritized_slots import space_to_prioritized_slots


def spaces_to_slots(spaces, planned_length, stored_intervals, ideal_cap):
    # result holder
    slots = []
    non_ideals = []

    # flag
    all_spaces_are_ideal = True

    # create a set contain ideal gaps
    ideal_gaps = set(stored_intervals)

    # iterate a ascending list of spaces
    for space in spaces[:-1]:
        if space not in ideal_gaps:
            all_spaces_are_ideal = False
            non_ideals.append(space)
        else:
            slots.extend(
                space_to_prioritized_slots(
                    space, planned_length, stored_intervals, ideal_gaps
                )
            )

    # fetch last element is space list
    last_space = spaces[-1]

    # specially process the last space (which is also the largest length, cause the list is sorted)
    if all_spaces_are_ideal or last_space not in ideal_gaps:
        non_ideals.append(last_space)
    else:
        slots.extend(
            space_to_prioritized_slots(
                last_space, planned_length, stored_intervals, ideal_gaps
            )
        )

    # handle non-ideal list
    ideal_size = calculate_ideal_size(spaces, non_ideals)
    non_ideal_cap = ideal_cap - ideal_size
    still_short = len(slots) <= 1

    limited_SIs = get_SI_for_non_ideal(stored_intervals, non_ideal_cap, still_short)

    for space in non_ideals:
        slots.extend(space_to_slots(space, planned_length, limited_SIs))

    # return result
    return slots


def get_SI_for_non_ideal(stored_intervals, non_ideal_cap, still_short):
    # Iterate until the value exceeds the ceiling
    for i in range(len(stored_intervals)):
        if stored_intervals[i] > non_ideal_cap:
            if still_short:
                # Ensures at least the 1 interval is included
                return stored_intervals[: max(1, i)]
            else:
                return stored_intervals[:i]
    return stored_intervals


def calculate_ideal_size(spaces, non_ideals):
    sum = 0
    non_ideal_size = 0
    for space in spaces:
        sum += space[1] - space[0]
    for space in non_ideals:
        non_ideal_size += space[1] - space[0]

    return sum - non_ideal_size
