from src.routes.authentication.sms_verification.sql import (
    create_authentication_sms_verification_sps,
)
from src.routes.authentication.sign_up.sql import create_authentication_signup_sps
from src.routes.authentication.login.sql import create_authentication_login_sps
from src.routes.authentication.session.sql import create_authentication_session_sps

from src.routes.services.categories.sql import create_services_categories_sps
from src.routes.services.groups.sql import create_services_groups_sps
from src.routes.services.lengths.sql import create_services_lengths_sps
from src.routes.services.services.sql import create_services_services_sps

from src.routes.employees.employees.sql import create_employees_employees_sps


# build/update procedures
def create_procedures():

    # from authentication routes
    create_authentication_sms_verification_sps()
    create_authentication_signup_sps()
    create_authentication_login_sps()
    create_authentication_session_sps()

    # from services routes
    create_services_categories_sps()
    create_services_groups_sps()
    create_services_lengths_sps()
    create_services_services_sps()

    # from employees routes
    create_employees_employees_sps()
