import json


def tokenize_name(name):
    try:
        tokens = name.strip().lower().split()
        return json.dumps(tokens)
    except AttributeError:
        return None
