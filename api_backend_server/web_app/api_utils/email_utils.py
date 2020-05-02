import os
import logging
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail


FROM_EMAIL = "no_reply@myl.com"

FORMATTER = logging.Formatter("%(asctime)s — %(name)s — %(levelname)s — %(message)s")

email_logger = logging.getLogger(__name__)
email_logger.setLevel(logging.INFO)
console_handler = logging.StreamHandler()
console_handler.setFormatter(FORMATTER)
email_logger.addHandler(console_handler)


def send_email(email_address, msg, subject):

    message = Mail(
        from_email=FROM_EMAIL,
        to_emails=email_address,
        subject=subject,
        html_content=msg,
    )

    try:
        sg = SendGridAPIClient(os.environ.get("SENDGRID_API_KEY"))
        response = sg.send(message)
        email_logger.info(
            f"Sent email to {email_address}, "
            f"SendGrid status code: {response.status_code}"
        )
    except Exception as e:
        email_logger.error(e.message)

    return response.status_code
