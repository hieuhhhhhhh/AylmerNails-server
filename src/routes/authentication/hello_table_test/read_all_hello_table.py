from flask import jsonify
from src.mysql.execute_sql_file.one_query import exe_one_query


def read_all_hello_table():
    return jsonify(exe_one_query(__file__, "read_all_hello_table.sql")), 200
