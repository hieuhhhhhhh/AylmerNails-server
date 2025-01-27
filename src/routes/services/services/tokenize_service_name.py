import json


def tokenize_service_name(name):
    tokens = name.lower().split()
    return json.dumps(tokens)
