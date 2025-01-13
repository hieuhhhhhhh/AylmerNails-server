import json


def generate_intervals(key_intervals, threshold):
    # result holder
    interval_set = set()

    # fetch 2 keys
    key1 = key_intervals[0]
    key2 = key_intervals[1]

    # generate stored intervals with formula x*key1 + y*key2 <= threshold
    # x and y are integers that increment from 0,1,2, .etc
    max_x = threshold // key1
    for x in range(0, max_x):
        max_y = (threshold - key1 * x) // key2
        for y in range(0, max_y):
            interval = x * key1 + y * key2
            interval_set.add(interval)

    # convert to required data type (a sorted json array)
    return json.dumps(sorted(interval_set))
