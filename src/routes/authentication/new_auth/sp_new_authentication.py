from flask import jsonify, current_app
from src.mysql.execute_sql_file.many_queries import exe_queries
from src.mysql.call_sp import call_sp


# to build the required procedures:
def create_sp_new_authentication():
    print("\033[94m" + "create_sp_new_authentication" + "\033[0m")
    exe_queries(__file__, "sp_new_authentication.sql")
