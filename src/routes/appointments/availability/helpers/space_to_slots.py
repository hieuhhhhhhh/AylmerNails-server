def space_to_slots(space, planned_length, stored_intervals):
    # result holder
    slots = []

    # calculate total gap to next and last endpoints
    length = space[1] - space[0]

    # iterate an ascending list of stored intervals
    for interval in stored_intervals:

        # calculate how much is the gap on the left of the slot (toward opening time)
        left_gap = interval

        # calculate how much is the gap on the right of the slot (toward closing time)
        right_gap = length - left_gap - planned_length

        # if the iteration has exceed threshold, break the loop
        if right_gap < left_gap:
            break

        # calculate and add 2 new slot to list
        slot = space[0] + left_gap
        slots.append(slot)

        # mirrored version (right_gap swap to left_gap)
        mirrored = space[0] + right_gap
        if mirrored != slot:
            slots.append(mirrored)

    return sorted(slots)
