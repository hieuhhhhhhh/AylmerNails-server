import re


def normalize_and_define_query(query):
    # remove unnecessary spaces
    query = re.sub(r"\s+", " ", query).strip()

    # check types
    phone_num_pattern = r"^\+?[0-9 ]+$"
    if bool(re.fullmatch(phone_num_pattern, query)):
        query = query.replace(" ", "").replace("+", "")
        return "phone number", query

    if " " in query:
        return "name with spaces", query

    return "name", query
