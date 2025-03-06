from src.routes.authentication.sms_verification.sql import (
    create_authentication_sms_verification_sps,
)
from src.routes.authentication.sign_up.sql import create_authentication_signup_sps
from src.routes.authentication.login.sql import create_authentication_login_sps
from src.routes.authentication.session.sql import create_authentication_session_sps

from src.routes.services.categories.sql import create_services_categories_sps
from src.routes.services.durations.sql import create_services_durations_procs
from src.routes.services.services.sql import create_services_services_sps

from src.routes.employees.employees.sql import create_employees_employees_sps
from src.routes.employees.schedules.sql import create_employees_schedules_sps

from src.routes.appointments.appos.sql import create_appointments_appos_sps
from src.routes.appointments.availability.sql import (
    create_appointments_availability_sps,
)
from src.routes.appointments.other_sql import create_appointments_other_sql_sps


# build/update procedures
def create_procedures():

    # from authentication routes
    create_authentication_sms_verification_sps()
    create_authentication_signup_sps()
    create_authentication_login_sps()
    create_authentication_session_sps()

    # from services routes
    create_services_categories_sps()
    create_services_durations_procs()
    create_services_services_sps()

    # from employees routes
    create_employees_employees_sps()
    create_employees_schedules_sps()

    # from appointments routes
    create_appointments_appos_sps()
    create_appointments_availability_sps()
    create_appointments_other_sql_sps()
