import os
import logging
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail
from flask import url_for, render_template

from api_utils.auth_utils import (
    get_url_serializer_and_salt,
    generate_confirmation_token,
)


FROM_EMAIL = "no_reply@myl.com"

FORMATTER = logging.Formatter("%(asctime)s — %(name)s — %(levelname)s — %(message)s")

email_logger = logging.getLogger(__name__)
email_logger.setLevel(logging.INFO)
console_handler = logging.StreamHandler()
console_handler.setFormatter(FORMATTER)
email_logger.addHandler(console_handler)


def send_email(email_address, msg, subject):
    # TODO: try to split SendGrid client instantiation with send email api
    message = Mail(
        from_email=FROM_EMAIL,
        to_emails=email_address,
        subject=subject,
        html_content=msg,
    )

    try:
        sg = SendGridAPIClient(os.environ.get("SENDGRID_API_KEY"))
    except Exception as e:
        email_logger.error(e)
        return 401

    try:
        response = sg.send(message)
    except Exception as e:
        email_logger.error(e)
        return 500
    else:
        email_logger.info(
            f"Sent email to {email_address}, "
            f"SendGrid status code: {response.status_code}"
        )

    return response.status_code


def send_confirmation_email(email):
    safe_url_token_tools = get_url_serializer_and_salt()
    token = generate_confirmation_token(email, **safe_url_token_tools)
    confirm_url = url_for(".apis_users_confirm_email", token=token, _external=True)
    subject = "MYL - Please confirm your email address"
    msg = render_template("activate_email.html", confirm_url=confirm_url)

    return send_email(email, msg, subject)
