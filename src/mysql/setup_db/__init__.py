from src.mysql.execute_sql_file.one_query import exe_one_query
from ..tables import create_tables

from src.routes.authentication.sms_verification.sql import (
    create_authentication_sms_verification_sps,
)
from src.routes.authentication.sign_up.sql import create_authentication_signup_sps
from src.routes.authentication.login.sql import create_authentication_login_sps
from src.routes.authentication.session.sql import create_authentication_session_sps


# create required database if not exists
def setup_db_on_mysql():
    print("\033[36m" + "setup_db_on_mysql" + "\033[0m")

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
    create_authentication_sms_verification_sps()
    create_authentication_signup_sps()
    create_authentication_login_sps()
    create_authentication_session_sps()
