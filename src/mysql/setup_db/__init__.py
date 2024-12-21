from src.mysql.execute_sql_file.one_query import exe_one_query
from .tables import create_tables
from src.routes.authentication.hello_table_test.sp_insert_msg import (
    create_sp_insert_msg,
)
from src.routes.authentication.sms_verification.sp_store_code import (
    create_sp_store_code,
)
from src.routes.authentication.sms_verification.sp_verify_code import (
    create_sp_verify_code,
)
from src.routes.authentication.new_auth.sp_get_new_pw import create_sp_get_new_pw
from src.routes.authentication.new_auth.sp_new_auth import (
    create_sp_new_auth,
)
from src.routes.authentication.sign_up.sp_is_phonenum_avail import (
    create_sp_is_phonenum_avail,
)
from src.routes.authentication.login.sp_add_session import (
    create_sp_add_session,
)
from src.routes.authentication.login.sp_get_stored_pw import (
    create_sp_get_stored_pw,
)


# create required database if not exists
def setup_db_on_mysql():
    print("\033[94m" + "setup_db_on_mysql" + "\033[0m")

    # if the db already exists, skip setup:
    db_exist = exe_one_query(__file__, "does_db_exist.sql")[0][0]
    if not db_exist:
        print("aylmer_nails not exist, creating database...")
        exe_one_query(__file__, "create_db.sql")
        # create required tables
        create_tables()

    # build/update procedures:
    create_procedures()


# build/update procedures:
def create_procedures():

    # from authentication routes
    create_sp_insert_msg()
    create_sp_store_code()
    create_sp_verify_code()
    create_sp_get_new_pw()
    create_sp_new_auth()
    create_sp_is_phonenum_avail()
    create_sp_add_session()
    create_sp_get_stored_pw()
