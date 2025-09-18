from tutor import hooks

hooks.Filters.ENV_PATCHES.add_item(
    (
        "openedx-lms-common-settings",
        """
FEATURES["ALLOW_PUBLIC_ACCOUNT_CREATION"] = True
FEATURES["SKIP_EMAIL_VALIDATION"] = True

REGISTRATION_EXTRA_FIELDS["country"] = "hidden"

THIRD_PARTY_AUTH_BACKENDS = ["ol_social_auth.backends.OLOAuth2",]

AUTHENTICATION_BACKENDS = list(THIRD_PARTY_AUTH_BACKENDS) + list(AUTHENTICATION_BACKENDS)

IDA_LOGOUT_URI_LIST = list(IDA_LOGOUT_URI_LIST) + list(["https://mitxonline.odl.local/logout"])

SOCIAL_AUTH_OAUTH_SECRETS = {
   "ol-oauth2": "abc123"
}

REGISTRATION_VALIDATION_RATELIMIT = "1000000/minute"
REGISTRATION_RATELIMIT = "1000000/minute"
        """
    )
)

