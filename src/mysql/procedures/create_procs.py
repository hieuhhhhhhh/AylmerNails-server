from src.routes.authentication.sms_verification.sql import (
    create_authentication_sms_verification_sps,
)
from src.routes.authentication.sign_up.sql import create_authentication_signup_sps
from src.routes.authentication.login.sql import create_authentication_login_sps
from src.routes.authentication.session.sql import create_authentication_session_sps


# build/update procedures:
def create_procedures():

    # from authentication routes
    create_authentication_sms_verification_sps()
    create_authentication_signup_sps()
    create_authentication_login_sps()
    create_authentication_session_sps()
