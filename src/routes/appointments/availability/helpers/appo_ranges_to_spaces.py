def appo_ranges_to_spaces(appo_ranges):
    # result holder
    spaces = []

    # iterate ascending appointment ranges with index
    for i in range(len(appo_ranges) - 1):
        last_end = appo_ranges[i][1]
        next_start = appo_ranges[i + 1][0]

        # if there is a gap, create a new space
        if (next_start - last_end) > 0:
            space = (last_end, next_start)
            spaces.append(space)

    # return sorted result
    return sort_spaces_asc(spaces)


# to sort a list of space ascending base on their length
def sort_spaces_asc(spaces):
    # Sort by the difference between start and end
    return sorted(spaces, key=lambda x: x[1] - x[0])
