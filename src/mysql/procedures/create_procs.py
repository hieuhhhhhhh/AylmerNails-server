from src.routes.authentication.otp_codes.sql import create_authentication_otp_codes_sps
from src.routes.authentication.sign_up.sql import create_authentication_signup_sps
from src.routes.authentication.login.sql import create_authentication_login_sps
from src.routes.authentication.logout.sql import create_authentication_logout_sps
from src.routes.authentication.session.sql import create_authentication_session_sps

from src.routes.services.categories.sql import create_services_categories_sps
from src.routes.services.durations.sql import create_services_durations_procs
from src.routes.services.services.sql import create_services_services_sps
from src.routes.services.conflicts.sql import create_conflicts_procs

from src.routes.employees.employees.sql import create_employees_employees_sps
from src.routes.employees.schedules.sql import create_employees_schedules_sps
from src.routes.employees.conflicts.sql import create_employee_conflicts_procs

from src.routes.appointments.appos.sql import create_appointments_appos_sps
from src.routes.appointments.availability.sql import (
    create_appointments_availability_sps,
)
from src.routes.appointments.contacts.sql import create_contacts_procs
from src.routes.appointments.delete_appo.sql import create_delete_appo_procs
from src.routes.appointments.notifications.sql import create_appo_notifications_procs
from src.routes.appointments.saved.sql import create_saved_appos_procs

from src.routes.users.my_profile.sql import create_my_profile_procs
from src.routes.users.profiles.sql import create_profiles_procs
from src.routes.users.blacklist.sql import create_blacklist_procs

from src.routes.business_links.sql import create_business_links_procs


# build/update procedures
def create_procedures():

    # from authentication routes
    create_authentication_otp_codes_sps()
    create_authentication_signup_sps()
    create_authentication_login_sps()
    create_authentication_logout_sps()
    create_authentication_session_sps()

    # from services routes
    create_services_categories_sps()
    create_services_durations_procs()
    create_services_services_sps()
    create_conflicts_procs()

    # from employees routes
    create_employees_employees_sps()
    create_employees_schedules_sps()
    create_employee_conflicts_procs()

    # from appointments routes
    create_appointments_appos_sps()
    create_appointments_availability_sps()
    create_contacts_procs()
    create_delete_appo_procs()
    create_appo_notifications_procs()
    create_saved_appos_procs()

    # from users routes
    create_my_profile_procs()
    create_profiles_procs()
    create_blacklist_procs()

    # from business links routes
    create_business_links_procs()
