import json


def tokenize_name(name):
    tokens = name.strip().lower().split()
    return json.dumps(tokens)
