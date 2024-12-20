from src.mysql.execute_sql_file.many_queries import exe_queries


def create_tables():
    exe_queries(__file__, "hello_table.sql")
    exe_queries(__file__, "authentication.sql")
