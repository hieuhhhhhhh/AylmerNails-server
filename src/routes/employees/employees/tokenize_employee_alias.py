import json


def tokenize_employee_alias(name):
    tokens = name.lower().split()
    return json.dumps(tokens)
