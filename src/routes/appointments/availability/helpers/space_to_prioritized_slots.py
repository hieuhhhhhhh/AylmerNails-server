def space_to_prioritized_slots(space, planned_length, stored_intervals, ideal_gaps):
    # result holder
    slots = []

    # calculate total gap to next and last endpoints
    gap = space[1] - space[0]

    # iterate an ascending list of stored intervals
    for interval in stored_intervals:

        # calculate how much is the gap on the left of the slot (toward opening time)
        left_gap = interval

        # calculate how much is the gap on the right of the slot (toward closing time)
        right_gap = gap - left_gap - planned_length

        # if the iteration has exceed threshold, break the loop
        if right_gap < 0:
            break

        # if right_gap is suitable, select this slot
        if right_gap in ideal_gaps:
            # calculate and add new slot to list
            slot = space[0] + left_gap
            slots.append(slot)

    return slots
