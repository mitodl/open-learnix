--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.2 (Debian 17.2-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangelog_scim_jpa_e; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog_scim_jpa_e (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog_scim_jpa_e OWNER TO postgres;

--
-- Name: databasechangelog_scim_resou; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog_scim_resou (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog_scim_resou OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: org; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO postgres;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scim_client_resource_filtering; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_client_resource_filtering (
    id character varying(36) NOT NULL,
    scim_remote_provider_id character varying(36),
    invert_filter_rule boolean DEFAULT false,
    resource_assignment character varying(50),
    filter_type character varying(15),
    property_name character varying(75),
    comparator character varying(2),
    comparator_value character varying(100)
);


ALTER TABLE public.scim_client_resource_filtering OWNER TO postgres;

--
-- Name: scim_endpoint_create_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_endpoint_create_roles (
    scim_resource_type_id character varying(36),
    role_id character varying(36)
);


ALTER TABLE public.scim_endpoint_create_roles OWNER TO postgres;

--
-- Name: scim_endpoint_delete_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_endpoint_delete_roles (
    scim_resource_type_id character varying(36),
    role_id character varying(36)
);


ALTER TABLE public.scim_endpoint_delete_roles OWNER TO postgres;

--
-- Name: scim_endpoint_get_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_endpoint_get_roles (
    scim_resource_type_id character varying(36),
    role_id character varying(36)
);


ALTER TABLE public.scim_endpoint_get_roles OWNER TO postgres;

--
-- Name: scim_endpoint_list_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_endpoint_list_roles (
    scim_resource_type_id character varying(36),
    role_id character varying(36)
);


ALTER TABLE public.scim_endpoint_list_roles OWNER TO postgres;

--
-- Name: scim_endpoint_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_endpoint_roles (
    scim_resource_type_id character varying(36),
    role_id character varying(36)
);


ALTER TABLE public.scim_endpoint_roles OWNER TO postgres;

--
-- Name: scim_endpoint_update_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_endpoint_update_roles (
    scim_resource_type_id character varying(36),
    role_id character varying(36)
);


ALTER TABLE public.scim_endpoint_update_roles OWNER TO postgres;

--
-- Name: scim_external_resource_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_external_resource_mapping (
    id character varying(36) NOT NULL,
    scim_remote_provider_id character varying(36),
    realm_id character varying(36),
    resource_assignment character varying(50),
    local_resource_id character varying(75),
    external_resource_id character varying(100)
);


ALTER TABLE public.scim_external_resource_mapping OWNER TO postgres;

--
-- Name: scim_remote_authentication; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_remote_authentication (
    id character varying(36) NOT NULL,
    authentication_type character varying(50),
    api_key_header_name character varying(100),
    auth_token text,
    client_id character varying(255),
    client_secret character varying(255),
    token_endpoint character varying(512),
    keystore_bytes bytea,
    keystore_type character varying(6),
    keystore_password character varying(255),
    scim_remote_provider_id character varying(36)
);


ALTER TABLE public.scim_remote_authentication OWNER TO postgres;

--
-- Name: scim_remote_operation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_remote_operation (
    id bigint NOT NULL,
    resource_assignment character varying(50),
    realm_id character varying(36),
    resource_id character varying(255),
    operation character varying(7),
    path character varying(255),
    value text,
    created timestamp without time zone,
    scim_remote_provider_id character varying(36),
    external_id character varying(100),
    local_operation_type character varying(6)
);


ALTER TABLE public.scim_remote_operation OWNER TO postgres;

--
-- Name: scim_remote_operation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.scim_remote_operation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scim_remote_operation_seq OWNER TO postgres;

--
-- Name: scim_remote_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_remote_provider (
    id character varying(36) NOT NULL,
    name character varying(100),
    enabled boolean,
    base_url character varying(512),
    is_user_storage_provider boolean,
    table_list_strategy character varying(20),
    truststore_bytes bytea,
    truststore_type character varying(6),
    truststore_password character varying(255),
    hostname_verifier_on boolean,
    proxy_host character varying(255),
    proxy_port integer,
    proxy_user character varying(255),
    proxy_password character varying(255),
    use_lower_case_filter_compare boolean,
    request_timeout integer,
    connect_timeout integer,
    socket_timeout integer,
    filter_supported boolean,
    filter_max_results integer,
    sort_supported boolean,
    patch_supported boolean,
    change_password_supported boolean,
    bulk_supported boolean,
    bulk_max_operations integer,
    bulk_max_payload_size integer,
    etag_supported boolean,
    created timestamp without time zone,
    last_modified timestamp without time zone,
    send_local_id_in_request boolean DEFAULT true,
    send_external_id_in_request boolean DEFAULT false,
    max_patch_operations integer DEFAULT 0
);


ALTER TABLE public.scim_remote_provider OWNER TO postgres;

--
-- Name: scim_remote_provider_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_remote_provider_mapping (
    realm_id character varying(36),
    scim_remote_provider_id character varying(36)
);


ALTER TABLE public.scim_remote_provider_mapping OWNER TO postgres;

--
-- Name: scim_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_resource (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    type character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    external_id character varying(36) NOT NULL
);


ALTER TABLE public.scim_resource OWNER TO postgres;

--
-- Name: scim_resource_schema_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_resource_schema_mapping (
    id character varying(36) NOT NULL,
    resource_type_id character varying(36),
    schema_id character varying(36),
    is_extension boolean,
    is_required boolean
);


ALTER TABLE public.scim_resource_schema_mapping OWNER TO postgres;

--
-- Name: scim_resource_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_resource_type (
    id character varying(36) NOT NULL,
    name character varying(50),
    description character varying(255),
    enabled boolean,
    auto_filtering boolean,
    auto_sorting boolean,
    etag_enabled boolean,
    disable_create boolean,
    disable_get boolean,
    disable_list boolean,
    disable_update boolean,
    disable_delete boolean,
    require_authentication boolean,
    service_provider_id character varying(36),
    endpoint character varying(255),
    is_default boolean DEFAULT false,
    is_or_on_roles boolean DEFAULT false,
    created bigint,
    last_modified bigint,
    scim_remote_provider_id character varying(36),
    scim_client_update_strategy character varying(25),
    attribute_naming_strategy character varying(25),
    resource_assignment character varying(25)
);


ALTER TABLE public.scim_resource_type OWNER TO postgres;

--
-- Name: scim_schema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_schema (
    id character varying(36) NOT NULL,
    modifiable boolean,
    schema_id character varying(255),
    name character varying(255),
    description character varying(255),
    created bigint,
    last_modified bigint,
    scim_remote_provider_id character varying(36)
);


ALTER TABLE public.scim_schema OWNER TO postgres;

--
-- Name: scim_schema_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_schema_attribute (
    id character varying(36) NOT NULL,
    schema_id character varying(36),
    parent_attribute character varying(36),
    modifiable boolean,
    name character varying(255),
    description character varying(512),
    reference_types character varying(100),
    canonical_values text,
    scim_type character varying(10),
    mutability character varying(10),
    returned character varying(7),
    uniqueness character varying(7),
    multivalued boolean,
    required boolean,
    case_exact boolean,
    min_length integer,
    max_length integer,
    min_items integer,
    max_items integer,
    pattern character varying(255),
    minimum numeric,
    maximum numeric,
    multiple_of numeric,
    ignore_in_filter_expression boolean DEFAULT false,
    default_value character varying(512),
    not_before bigint,
    not_after bigint,
    created bigint,
    last_modified bigint,
    custom_attribute_name character varying(255)
);


ALTER TABLE public.scim_schema_attribute OWNER TO postgres;

--
-- Name: scim_service_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_service_provider (
    id character varying(36) NOT NULL,
    version bigint,
    realm_id character varying(36),
    enabled boolean,
    filter_supported boolean,
    filter_max_results integer,
    sort_supported boolean,
    patch_supported boolean,
    change_password_supported boolean,
    bulk_supported boolean,
    bulk_max_operations integer,
    bulk_max_payload_size bigint,
    etag_supported boolean,
    case_insensi_attr_validation boolean DEFAULT false,
    sails_point_workaround_active boolean DEFAULT false,
    ms_azure_patch_workarou_active boolean DEFAULT false,
    bulk_return_resources_enabled boolean DEFAULT false,
    bulk_return_resources_default boolean DEFAULT false,
    bulk_support_get boolean DEFAULT false,
    table_list_strategy character varying(20) DEFAULT 'USER_ENTITY'::character varying,
    is_user_storage_provider boolean DEFAULT false,
    azure_patch_sub_val_wa_active boolean DEFAULT false,
    use_default_values_on_request boolean DEFAULT true,
    use_default_values_on_response boolean DEFAULT true,
    ignore_unknown_attributes boolean DEFAULT false,
    azure_patch_simp_val_wa_active boolean DEFAULT false,
    ignore_required_on_response boolean DEFAULT true,
    ignore_req_extension_response boolean DEFAULT true,
    created bigint,
    last_modified bigint,
    patch_return_resources boolean DEFAULT false,
    limit_client_access boolean DEFAULT false
);


ALTER TABLE public.scim_service_provider OWNER TO postgres;

--
-- Name: scim_sp_authorized_clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scim_sp_authorized_clients (
    scim_service_provider_id character varying(36),
    client_id character varying(36)
);


ALTER TABLE public.scim_sp_authorized_clients OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
b2d1d1b5-62f3-49ef-83f9-24ff4dc5b5b1	\N	auth-cookie	f493d84c-5308-498f-afec-c6f4cfffd553	0ba17251-efd0-427d-9ab0-dae4e934a40d	2	10	f	\N	\N
6ed7f91a-0dd1-4c31-921d-2143f36aa54d	\N	auth-spnego	f493d84c-5308-498f-afec-c6f4cfffd553	0ba17251-efd0-427d-9ab0-dae4e934a40d	3	20	f	\N	\N
d121fcf7-9e82-4116-8157-8513e50b3af8	\N	identity-provider-redirector	f493d84c-5308-498f-afec-c6f4cfffd553	0ba17251-efd0-427d-9ab0-dae4e934a40d	2	25	f	\N	\N
3dfc03d1-62dc-4602-b74c-870212a6aff0	\N	\N	f493d84c-5308-498f-afec-c6f4cfffd553	0ba17251-efd0-427d-9ab0-dae4e934a40d	2	30	t	9d5a7030-ebbb-48b1-9ba2-93c2c75431b4	\N
0cb11fbd-ad7c-4f61-abc7-28ca078be77b	\N	auth-username-password-form	f493d84c-5308-498f-afec-c6f4cfffd553	9d5a7030-ebbb-48b1-9ba2-93c2c75431b4	0	10	f	\N	\N
dbf1c644-9441-4fa6-baf6-b8d628310d1e	\N	\N	f493d84c-5308-498f-afec-c6f4cfffd553	9d5a7030-ebbb-48b1-9ba2-93c2c75431b4	1	20	t	14370d31-e4fb-459a-a73f-d54a9e382914	\N
d41b7404-d4a6-4ccf-b87b-01355c204c0d	\N	conditional-user-configured	f493d84c-5308-498f-afec-c6f4cfffd553	14370d31-e4fb-459a-a73f-d54a9e382914	0	10	f	\N	\N
21653d0e-a762-4dcf-b6ca-ebe8d99a7687	\N	auth-otp-form	f493d84c-5308-498f-afec-c6f4cfffd553	14370d31-e4fb-459a-a73f-d54a9e382914	0	20	f	\N	\N
1af966c4-e6c4-4687-a4e7-307eb41c6bba	\N	direct-grant-validate-username	f493d84c-5308-498f-afec-c6f4cfffd553	66c83497-7f4f-4bb2-a963-f712f4519120	0	10	f	\N	\N
d6be4b6c-c015-4706-aadd-daed0be7e44c	\N	direct-grant-validate-password	f493d84c-5308-498f-afec-c6f4cfffd553	66c83497-7f4f-4bb2-a963-f712f4519120	0	20	f	\N	\N
29fd257e-1d23-40b0-81bc-bd8eb7174d54	\N	\N	f493d84c-5308-498f-afec-c6f4cfffd553	66c83497-7f4f-4bb2-a963-f712f4519120	1	30	t	cbf0ea65-0c0f-4456-bb63-9ca961357643	\N
ca607f9d-6aa0-4733-a0eb-4c950eb65929	\N	conditional-user-configured	f493d84c-5308-498f-afec-c6f4cfffd553	cbf0ea65-0c0f-4456-bb63-9ca961357643	0	10	f	\N	\N
1bbbdcfc-67b4-4162-9229-ff1730f63499	\N	direct-grant-validate-otp	f493d84c-5308-498f-afec-c6f4cfffd553	cbf0ea65-0c0f-4456-bb63-9ca961357643	0	20	f	\N	\N
879d6324-1b6c-4c55-9c03-fe800564adc8	\N	registration-page-form	f493d84c-5308-498f-afec-c6f4cfffd553	3ae0a9e7-1c33-405f-bf5b-07af9ab31bb8	0	10	t	764d7dd0-34ce-46ce-b7ec-1456873cb2f6	\N
c2baf02d-e1ff-45a4-a10b-73455b24b0bb	\N	registration-user-creation	f493d84c-5308-498f-afec-c6f4cfffd553	764d7dd0-34ce-46ce-b7ec-1456873cb2f6	0	20	f	\N	\N
1e03e133-0414-4fb1-a035-f5fefe8c4699	\N	registration-password-action	f493d84c-5308-498f-afec-c6f4cfffd553	764d7dd0-34ce-46ce-b7ec-1456873cb2f6	0	50	f	\N	\N
0fb90fb6-92f5-4a5c-8aea-c4a8bab1d4f9	\N	registration-recaptcha-action	f493d84c-5308-498f-afec-c6f4cfffd553	764d7dd0-34ce-46ce-b7ec-1456873cb2f6	3	60	f	\N	\N
82af74ae-93f4-49b8-9988-98a5f2500321	\N	registration-terms-and-conditions	f493d84c-5308-498f-afec-c6f4cfffd553	764d7dd0-34ce-46ce-b7ec-1456873cb2f6	3	70	f	\N	\N
db847919-ab39-46c3-94cd-a2f3d7404c71	\N	reset-credentials-choose-user	f493d84c-5308-498f-afec-c6f4cfffd553	eb164f98-3325-4540-9bf5-3f67e99ed183	0	10	f	\N	\N
067d69c9-5748-4033-8551-b5be7e491a4f	\N	reset-credential-email	f493d84c-5308-498f-afec-c6f4cfffd553	eb164f98-3325-4540-9bf5-3f67e99ed183	0	20	f	\N	\N
1ccfcac8-79f5-4a2e-b588-3a0de41f93d4	\N	reset-password	f493d84c-5308-498f-afec-c6f4cfffd553	eb164f98-3325-4540-9bf5-3f67e99ed183	0	30	f	\N	\N
20d3e2c9-6811-48f5-acad-fd338c24aa6a	\N	\N	f493d84c-5308-498f-afec-c6f4cfffd553	eb164f98-3325-4540-9bf5-3f67e99ed183	1	40	t	ca69306e-2b7b-4a4f-8cb8-be43f2846c7a	\N
a3135c68-2401-4291-ace9-a0ee5484b396	\N	conditional-user-configured	f493d84c-5308-498f-afec-c6f4cfffd553	ca69306e-2b7b-4a4f-8cb8-be43f2846c7a	0	10	f	\N	\N
d1e11f26-63df-4c18-b013-a7b885760535	\N	reset-otp	f493d84c-5308-498f-afec-c6f4cfffd553	ca69306e-2b7b-4a4f-8cb8-be43f2846c7a	0	20	f	\N	\N
ff0dadc4-adfc-4ce7-b63e-9f7543278c84	\N	client-secret	f493d84c-5308-498f-afec-c6f4cfffd553	d0f014fa-0d88-4543-be77-3dedab5e93dc	2	10	f	\N	\N
3c51ced2-4224-47bc-8fe9-388c58ab7ef9	\N	client-jwt	f493d84c-5308-498f-afec-c6f4cfffd553	d0f014fa-0d88-4543-be77-3dedab5e93dc	2	20	f	\N	\N
016076e0-f9eb-480d-935c-6e631b1abf89	\N	client-secret-jwt	f493d84c-5308-498f-afec-c6f4cfffd553	d0f014fa-0d88-4543-be77-3dedab5e93dc	2	30	f	\N	\N
2a668c66-c6dd-4c91-92bb-8b01f0e1790b	\N	client-x509	f493d84c-5308-498f-afec-c6f4cfffd553	d0f014fa-0d88-4543-be77-3dedab5e93dc	2	40	f	\N	\N
9e98f557-44c5-4ae0-b3dd-cdc0a728eca3	\N	idp-review-profile	f493d84c-5308-498f-afec-c6f4cfffd553	bec443cf-4bf5-4fb1-b3a3-a7ec90481f05	0	10	f	\N	854b0776-d880-4fce-a215-40581f4dec12
3e424492-b2e1-49bb-b115-b527dd507a3e	\N	\N	f493d84c-5308-498f-afec-c6f4cfffd553	bec443cf-4bf5-4fb1-b3a3-a7ec90481f05	0	20	t	54bba0a6-13d4-466a-9e33-1ad853e9a7f7	\N
a8702e69-5b4a-423b-a1c0-29093234d0e4	\N	idp-create-user-if-unique	f493d84c-5308-498f-afec-c6f4cfffd553	54bba0a6-13d4-466a-9e33-1ad853e9a7f7	2	10	f	\N	ae17917a-f245-4d91-82b8-b11e6cf0b31e
4b87a114-dc40-49a3-a21c-09a274ce4ec5	\N	\N	f493d84c-5308-498f-afec-c6f4cfffd553	54bba0a6-13d4-466a-9e33-1ad853e9a7f7	2	20	t	071d40c7-bf91-45e6-978f-40b5b013c3ca	\N
d183a34e-1172-45ec-8598-bdf5d9972bed	\N	idp-confirm-link	f493d84c-5308-498f-afec-c6f4cfffd553	071d40c7-bf91-45e6-978f-40b5b013c3ca	0	10	f	\N	\N
99283c3b-d432-4925-97c9-236d18375360	\N	\N	f493d84c-5308-498f-afec-c6f4cfffd553	071d40c7-bf91-45e6-978f-40b5b013c3ca	0	20	t	0707e388-7c6b-41ed-8693-f2d4142d3254	\N
6092fff2-7ef6-45b7-95be-84068554990c	\N	idp-email-verification	f493d84c-5308-498f-afec-c6f4cfffd553	0707e388-7c6b-41ed-8693-f2d4142d3254	2	10	f	\N	\N
58d6d3b4-4c09-4b2a-9006-19545d9a6735	\N	\N	f493d84c-5308-498f-afec-c6f4cfffd553	0707e388-7c6b-41ed-8693-f2d4142d3254	2	20	t	d02f9d39-a87f-4644-bb4f-76f23b536159	\N
a3ff58e1-ec63-4f2f-a892-8cdb5fd4740f	\N	idp-username-password-form	f493d84c-5308-498f-afec-c6f4cfffd553	d02f9d39-a87f-4644-bb4f-76f23b536159	0	10	f	\N	\N
d6aaeb14-0432-46ff-bafa-4781bdde2a68	\N	\N	f493d84c-5308-498f-afec-c6f4cfffd553	d02f9d39-a87f-4644-bb4f-76f23b536159	1	20	t	dbf55f76-c1a2-40d2-bcb0-b8ba35189d52	\N
57742b97-a0b5-46eb-81fa-b2397e0735f3	\N	conditional-user-configured	f493d84c-5308-498f-afec-c6f4cfffd553	dbf55f76-c1a2-40d2-bcb0-b8ba35189d52	0	10	f	\N	\N
b1e7d8ba-12b3-43a9-bdbb-2309426ba38a	\N	auth-otp-form	f493d84c-5308-498f-afec-c6f4cfffd553	dbf55f76-c1a2-40d2-bcb0-b8ba35189d52	0	20	f	\N	\N
e3a64c0c-b592-4ffa-b10c-0348aad268ce	\N	http-basic-authenticator	f493d84c-5308-498f-afec-c6f4cfffd553	c1ed4cc4-5d08-4d27-8225-d478f251acbb	0	10	f	\N	\N
7c22fc06-9c43-4c00-a432-84a213cafb4d	\N	docker-http-basic-authenticator	f493d84c-5308-498f-afec-c6f4cfffd553	fe1910a0-ce2a-455c-ac27-b4054141d4ae	0	10	f	\N	\N
4b8bad6e-9be0-4104-bed8-97c054a1784b	\N	auth-cookie	5760f0e0-8dc4-453f-b407-19c01025187d	e1a27992-be07-4db8-a4fe-39dcb84603ea	2	10	f	\N	\N
26edaab8-68c7-42ab-98de-b856db0a2f45	\N	auth-spnego	5760f0e0-8dc4-453f-b407-19c01025187d	e1a27992-be07-4db8-a4fe-39dcb84603ea	3	20	f	\N	\N
f8f4bed0-b340-4283-baa9-9c881d4277aa	\N	identity-provider-redirector	5760f0e0-8dc4-453f-b407-19c01025187d	e1a27992-be07-4db8-a4fe-39dcb84603ea	2	25	f	\N	\N
2ae38a7f-9a9a-4f43-a7d3-806c6f9b7d4f	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	e1a27992-be07-4db8-a4fe-39dcb84603ea	2	30	t	b01fd215-623b-4e6a-9d18-595a090751e1	\N
8ae72d4f-9053-44fa-9aef-9770d854b268	\N	auth-username-password-form	5760f0e0-8dc4-453f-b407-19c01025187d	b01fd215-623b-4e6a-9d18-595a090751e1	0	10	f	\N	\N
5395b8f4-b64a-46a1-b796-a3637a1f4e71	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	b01fd215-623b-4e6a-9d18-595a090751e1	1	20	t	6c61a420-df1b-4743-93b6-bfaa93667d6f	\N
356b24d9-389d-4012-a853-f4676109c4e8	\N	conditional-user-configured	5760f0e0-8dc4-453f-b407-19c01025187d	6c61a420-df1b-4743-93b6-bfaa93667d6f	0	10	f	\N	\N
b2ced82b-7440-4c60-8aac-51851c4aca91	\N	auth-otp-form	5760f0e0-8dc4-453f-b407-19c01025187d	6c61a420-df1b-4743-93b6-bfaa93667d6f	0	20	f	\N	\N
74ca7281-308a-4be1-a671-eaf33a1093a4	\N	direct-grant-validate-username	5760f0e0-8dc4-453f-b407-19c01025187d	8ec8ad2f-78c1-4b30-95c4-76bb0f48529f	0	10	f	\N	\N
64064f6f-a4d3-4f1c-9e1a-e151eab2d894	\N	direct-grant-validate-password	5760f0e0-8dc4-453f-b407-19c01025187d	8ec8ad2f-78c1-4b30-95c4-76bb0f48529f	0	20	f	\N	\N
25ab2175-7422-4c8f-bbd3-05d31510d8c0	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	8ec8ad2f-78c1-4b30-95c4-76bb0f48529f	1	30	t	0706de0d-9615-4647-b3bd-44a97ad63f28	\N
1a14091a-19ab-4333-98d8-9ca3b6b62d10	\N	conditional-user-configured	5760f0e0-8dc4-453f-b407-19c01025187d	0706de0d-9615-4647-b3bd-44a97ad63f28	0	10	f	\N	\N
2e53ca57-e911-4771-86ff-a5737ad89ffa	\N	direct-grant-validate-otp	5760f0e0-8dc4-453f-b407-19c01025187d	0706de0d-9615-4647-b3bd-44a97ad63f28	0	20	f	\N	\N
bf82690b-227c-42d1-bc26-866bba27367c	\N	registration-page-form	5760f0e0-8dc4-453f-b407-19c01025187d	a8a05551-ae94-4fda-9a0f-41f9dc1ed6f9	0	10	t	a13b3dd3-dae1-4199-8290-8039a65f66e6	\N
79758840-992e-469f-9a43-a4f5ae2c9317	\N	registration-user-creation	5760f0e0-8dc4-453f-b407-19c01025187d	a13b3dd3-dae1-4199-8290-8039a65f66e6	0	20	f	\N	\N
2c203712-926b-4b5a-b377-d06f7ba3e4ab	\N	registration-password-action	5760f0e0-8dc4-453f-b407-19c01025187d	a13b3dd3-dae1-4199-8290-8039a65f66e6	0	50	f	\N	\N
290c4f56-7639-4b60-9eb3-d732f954cfa4	\N	registration-terms-and-conditions	5760f0e0-8dc4-453f-b407-19c01025187d	a13b3dd3-dae1-4199-8290-8039a65f66e6	3	70	f	\N	\N
f96c0130-b081-48b7-a522-c968fa97c0c7	\N	reset-credentials-choose-user	5760f0e0-8dc4-453f-b407-19c01025187d	982c10d6-5e7e-4365-bc73-b9255a2fce9c	0	10	f	\N	\N
8de1127c-e93e-4b1b-8c62-ef23931cf671	\N	reset-credential-email	5760f0e0-8dc4-453f-b407-19c01025187d	982c10d6-5e7e-4365-bc73-b9255a2fce9c	0	20	f	\N	\N
5bde40e6-0f81-4d3c-b60a-e3ab7f5b2b43	\N	reset-password	5760f0e0-8dc4-453f-b407-19c01025187d	982c10d6-5e7e-4365-bc73-b9255a2fce9c	0	30	f	\N	\N
f3f27641-e23b-40b6-8086-7fd9b5ae48cb	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	982c10d6-5e7e-4365-bc73-b9255a2fce9c	1	40	t	b0f1deaa-cfe1-4c99-b5d0-1b29dfe0a45d	\N
b99ac96f-8aa7-44fd-9148-b0756f357671	\N	conditional-user-configured	5760f0e0-8dc4-453f-b407-19c01025187d	b0f1deaa-cfe1-4c99-b5d0-1b29dfe0a45d	0	10	f	\N	\N
daa6147a-55c7-45e8-8e05-feddf86aaf10	\N	reset-otp	5760f0e0-8dc4-453f-b407-19c01025187d	b0f1deaa-cfe1-4c99-b5d0-1b29dfe0a45d	0	20	f	\N	\N
61d29a0c-f32e-41fb-8eef-2c7023457987	\N	client-secret	5760f0e0-8dc4-453f-b407-19c01025187d	987fb39d-dde7-4aa0-b100-c3ed19911cbd	2	10	f	\N	\N
a738f3b6-3c2f-4cda-965b-93fa142b6952	\N	client-jwt	5760f0e0-8dc4-453f-b407-19c01025187d	987fb39d-dde7-4aa0-b100-c3ed19911cbd	2	20	f	\N	\N
62ca350b-10f8-4c90-acb2-8d3b9b508c11	\N	client-secret-jwt	5760f0e0-8dc4-453f-b407-19c01025187d	987fb39d-dde7-4aa0-b100-c3ed19911cbd	2	30	f	\N	\N
2d494edd-3989-4882-a41d-17ededebcfa6	\N	client-x509	5760f0e0-8dc4-453f-b407-19c01025187d	987fb39d-dde7-4aa0-b100-c3ed19911cbd	2	40	f	\N	\N
8594e685-cc1b-4fdd-9567-14dc8a4452e9	\N	idp-review-profile	5760f0e0-8dc4-453f-b407-19c01025187d	182b2041-2e16-423a-9af7-e1c3a30d78f5	0	10	f	\N	c3df6f4d-fc49-4567-a333-7f79a3e94273
d966df37-4564-424f-8f05-932e0952d2a4	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	182b2041-2e16-423a-9af7-e1c3a30d78f5	0	20	t	ca69ec5d-7260-4d81-9ad8-eec1b7ac4972	\N
e319c300-914f-49b9-b7b7-299972ba298b	\N	idp-create-user-if-unique	5760f0e0-8dc4-453f-b407-19c01025187d	ca69ec5d-7260-4d81-9ad8-eec1b7ac4972	2	10	f	\N	58609a18-f130-4585-a65c-f53a72c971d4
3b335e5f-bc1c-4efe-8894-81221246249e	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	ca69ec5d-7260-4d81-9ad8-eec1b7ac4972	2	20	t	ab60ba3a-812b-420b-a002-8bebe9accdb9	\N
7211904e-1ad2-4730-93a4-7d13d2be30c8	\N	idp-confirm-link	5760f0e0-8dc4-453f-b407-19c01025187d	ab60ba3a-812b-420b-a002-8bebe9accdb9	0	10	f	\N	\N
4f4e1963-31a1-4866-beb5-1d0024aab4cf	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	ab60ba3a-812b-420b-a002-8bebe9accdb9	0	20	t	3eca6fbf-1d4b-44a7-a588-eab49a4508cd	\N
584c13de-b44f-4b23-aa7b-821e1e9f0b26	\N	idp-email-verification	5760f0e0-8dc4-453f-b407-19c01025187d	3eca6fbf-1d4b-44a7-a588-eab49a4508cd	2	10	f	\N	\N
7cb6766e-f3da-42b1-9e56-b0e57a3d224d	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	3eca6fbf-1d4b-44a7-a588-eab49a4508cd	2	20	t	80c82437-beb3-4679-b31e-88b85f3efe60	\N
929bad14-f760-4a26-92d8-1c824b4c76c7	\N	idp-username-password-form	5760f0e0-8dc4-453f-b407-19c01025187d	80c82437-beb3-4679-b31e-88b85f3efe60	0	10	f	\N	\N
c4e168d7-8d87-4d2b-a572-14c6b9debb2c	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	80c82437-beb3-4679-b31e-88b85f3efe60	1	20	t	0872c06e-54b1-4b7f-9491-8e828d7f9309	\N
b8224831-63d3-464d-94fc-d4726b990847	\N	conditional-user-configured	5760f0e0-8dc4-453f-b407-19c01025187d	0872c06e-54b1-4b7f-9491-8e828d7f9309	0	10	f	\N	\N
d2d41c6a-4e35-400a-b821-c7f8f72ff435	\N	auth-otp-form	5760f0e0-8dc4-453f-b407-19c01025187d	0872c06e-54b1-4b7f-9491-8e828d7f9309	0	20	f	\N	\N
cd11469c-7e7f-474b-abd1-10c92d6edb48	\N	http-basic-authenticator	5760f0e0-8dc4-453f-b407-19c01025187d	25a5690c-b96f-4215-ae90-9bb13f624f44	0	10	f	\N	\N
0a4783bb-81b5-4ad6-940a-be046e767552	\N	docker-http-basic-authenticator	5760f0e0-8dc4-453f-b407-19c01025187d	5671c7ed-7dc1-44e9-b574-2687b5530130	0	10	f	\N	\N
589bbd73-f721-4dba-8f23-2459234a5696	\N	auth-cookie	5760f0e0-8dc4-453f-b407-19c01025187d	8f98653d-bc49-4b3c-b297-43d14d7840b4	2	10	f	\N	\N
1270a9a7-d2f6-400c-805d-b4aa7df504fc	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	8f98653d-bc49-4b3c-b297-43d14d7840b4	2	30	t	d9d38c08-d6aa-4d14-bf0d-b1aca441ae83	\N
a8328261-ea6b-4939-b7f9-c5d420da9c4d	\N	auth-username-password-form	5760f0e0-8dc4-453f-b407-19c01025187d	d9d38c08-d6aa-4d14-bf0d-b1aca441ae83	0	20	f	\N	\N
61086b28-2e80-45e3-9d84-96f59f34b40d	\N	auth-username-form	5760f0e0-8dc4-453f-b407-19c01025187d	d9d38c08-d6aa-4d14-bf0d-b1aca441ae83	0	10	f	\N	\N
acab7062-a002-4b67-bb0b-22f16f78aeee	\N	registration-recaptcha-action	5760f0e0-8dc4-453f-b407-19c01025187d	a13b3dd3-dae1-4199-8290-8039a65f66e6	0	60	f	\N	ea4ddc27-34c1-40c6-b9d2-305a957a23dc
7616e531-64f0-42ba-a705-7f770f90b0ce	\N	auth-cookie	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	12bb5f70-be1c-41cc-a773-70988d0d987e	2	10	f	\N	\N
f3115adc-a544-4c23-805b-f987af9593f2	\N	auth-spnego	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	12bb5f70-be1c-41cc-a773-70988d0d987e	3	20	f	\N	\N
07701941-549a-469a-b249-b05ad0df8ef9	\N	identity-provider-redirector	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	12bb5f70-be1c-41cc-a773-70988d0d987e	2	25	f	\N	\N
e00b4f8e-c19d-4828-a5dc-55480d0ac01f	\N	\N	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	12bb5f70-be1c-41cc-a773-70988d0d987e	2	30	t	5e6e36ba-575a-4a15-a708-893f34ae2e47	\N
0aa2481f-9360-4860-a568-8837838c5f7f	\N	auth-username-password-form	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	5e6e36ba-575a-4a15-a708-893f34ae2e47	0	10	f	\N	\N
b5c62ec8-cc9d-4a50-99be-e37e20e30d95	\N	\N	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	5e6e36ba-575a-4a15-a708-893f34ae2e47	1	20	t	380bbbea-7229-4e8d-9da8-c9cb63a33b6b	\N
38e7c6f4-a108-46f7-bde3-8b6c1bdabd23	\N	conditional-user-configured	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	380bbbea-7229-4e8d-9da8-c9cb63a33b6b	0	10	f	\N	\N
fad78183-26f3-4657-8a1a-9fc3e7c551be	\N	auth-otp-form	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	380bbbea-7229-4e8d-9da8-c9cb63a33b6b	0	20	f	\N	\N
0886fe18-9274-49ea-93a3-70a3396557ea	\N	direct-grant-validate-username	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	9c193f5c-a7ac-4007-ae6d-d84b2f1bfafc	0	10	f	\N	\N
d86cd6f0-fc48-4fde-ab37-5f8182ea08e3	\N	direct-grant-validate-password	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	9c193f5c-a7ac-4007-ae6d-d84b2f1bfafc	0	20	f	\N	\N
12086189-482f-4966-b6e5-9c63e20365e3	\N	\N	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	9c193f5c-a7ac-4007-ae6d-d84b2f1bfafc	1	30	t	845ea257-b22d-4cd0-860b-e86e09f9c571	\N
89b42cdb-5f61-43f5-a2cd-9023280a230e	\N	conditional-user-configured	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	845ea257-b22d-4cd0-860b-e86e09f9c571	0	10	f	\N	\N
371ee3ca-bee3-4488-bab5-6f4f57f6a1d9	\N	direct-grant-validate-otp	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	845ea257-b22d-4cd0-860b-e86e09f9c571	0	20	f	\N	\N
4dc9d93c-49b8-4f0b-8064-33bf4cb39cb3	\N	registration-page-form	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	be18abc9-79c3-44ea-b6b2-139dbc7db299	0	10	t	e04d189b-1b80-4911-978a-de407a4d501f	\N
a53f98ef-a6bc-476f-95f4-de33cc72a4be	\N	registration-user-creation	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	e04d189b-1b80-4911-978a-de407a4d501f	0	20	f	\N	\N
7383c1a3-6e49-42cb-af89-2b736f599bda	\N	registration-password-action	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	e04d189b-1b80-4911-978a-de407a4d501f	0	50	f	\N	\N
771e4ebf-a642-4c47-9f65-14b5a97f2410	\N	registration-recaptcha-action	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	e04d189b-1b80-4911-978a-de407a4d501f	3	60	f	\N	\N
810bf583-8237-40b5-984c-487eb1aa62ea	\N	registration-terms-and-conditions	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	e04d189b-1b80-4911-978a-de407a4d501f	3	70	f	\N	\N
9f61c72e-2f0f-43ac-aece-7b876a220a2e	\N	reset-credentials-choose-user	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	216b8618-d4fc-4e7f-acec-cfe05025e7b6	0	10	f	\N	\N
51e0be9f-1296-4ea6-b6b5-982f0ea1c771	\N	reset-credential-email	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	216b8618-d4fc-4e7f-acec-cfe05025e7b6	0	20	f	\N	\N
b6d1b395-a919-4ee4-b236-952e751db601	\N	reset-password	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	216b8618-d4fc-4e7f-acec-cfe05025e7b6	0	30	f	\N	\N
d281fb7c-8823-47ba-9e26-31bcebdd788c	\N	\N	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	216b8618-d4fc-4e7f-acec-cfe05025e7b6	1	40	t	623677ac-326c-41df-a770-9b478a08de8f	\N
5472922c-6a41-4988-9131-4a31b495eb6b	\N	conditional-user-configured	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	623677ac-326c-41df-a770-9b478a08de8f	0	10	f	\N	\N
474829e7-bf14-4cc8-81d1-5314aaf839f6	\N	reset-otp	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	623677ac-326c-41df-a770-9b478a08de8f	0	20	f	\N	\N
9c425293-ecb7-4f0e-8323-55b2c39e37f7	\N	client-secret	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	115afaed-6d8f-4712-bdca-8b5aa323c6f1	2	10	f	\N	\N
6d62a2c6-8926-4b8e-b6c5-7090e71d6330	\N	client-jwt	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	115afaed-6d8f-4712-bdca-8b5aa323c6f1	2	20	f	\N	\N
b32cc31b-7164-4487-8bc9-cafedbe4447d	\N	client-secret-jwt	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	115afaed-6d8f-4712-bdca-8b5aa323c6f1	2	30	f	\N	\N
01c5e0bc-c928-4192-b361-458c394e0cc5	\N	client-x509	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	115afaed-6d8f-4712-bdca-8b5aa323c6f1	2	40	f	\N	\N
3b225ea7-0ebb-42c2-8250-f53ba883cb3f	\N	idp-review-profile	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	836795b8-9f9e-44b8-96a6-5ef2cad92d9c	0	10	f	\N	aff8e752-0cc4-42ab-aa25-df48c561a6c8
2e47b6ca-b381-443f-b65f-21b72f25949a	\N	\N	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	836795b8-9f9e-44b8-96a6-5ef2cad92d9c	0	20	t	f2dc1eb0-a1e6-42c1-a2e7-d663ad2d0ed1	\N
222d246f-42fe-4a84-87a3-6b36a44eda74	\N	idp-create-user-if-unique	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	f2dc1eb0-a1e6-42c1-a2e7-d663ad2d0ed1	2	10	f	\N	3cf1063c-0c4d-4766-be7e-b28cb4ffa7d1
ea878cc5-3d0b-47c1-9839-62027974a5dc	\N	\N	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	f2dc1eb0-a1e6-42c1-a2e7-d663ad2d0ed1	2	20	t	99cc1989-3302-4dc3-b227-8c2b6ae33d13	\N
41ccecdb-1b40-4d25-80e0-d465f14c4005	\N	idp-confirm-link	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	99cc1989-3302-4dc3-b227-8c2b6ae33d13	0	10	f	\N	\N
b7344ea1-876b-417b-b3fd-aca055b6fcb7	\N	\N	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	99cc1989-3302-4dc3-b227-8c2b6ae33d13	0	20	t	72660555-cbab-40ca-a9bc-b79f95719820	\N
5c863250-292f-4c93-bc2c-d40751cc9b71	\N	idp-email-verification	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	72660555-cbab-40ca-a9bc-b79f95719820	2	10	f	\N	\N
52c1322f-1b45-4763-a735-6710f6849e8a	\N	\N	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	72660555-cbab-40ca-a9bc-b79f95719820	2	20	t	ac1a52b2-56c1-4915-a5b5-c9076b3a5bc8	\N
ae7a5a7a-34eb-416a-b4d5-f7d9ae2c3bdf	\N	idp-username-password-form	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	ac1a52b2-56c1-4915-a5b5-c9076b3a5bc8	0	10	f	\N	\N
0e4c138b-8074-4e3e-9a01-d4fe0dd0443e	\N	\N	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	ac1a52b2-56c1-4915-a5b5-c9076b3a5bc8	1	20	t	f7e464aa-ddf6-4a69-804a-b05fcbc03b3a	\N
4d101228-57aa-49aa-a2a3-98673b576ffd	\N	conditional-user-configured	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	f7e464aa-ddf6-4a69-804a-b05fcbc03b3a	0	10	f	\N	\N
b4634f99-49a9-4859-949e-2791bd4e0074	\N	auth-otp-form	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	f7e464aa-ddf6-4a69-804a-b05fcbc03b3a	0	20	f	\N	\N
b37b409a-8be5-422d-a002-5001b883c43f	\N	http-basic-authenticator	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	bf97f1e7-d61d-4f56-b70c-a49f38157b4e	0	10	f	\N	\N
10a221f4-eb2e-4ea4-8d34-7373cee8f50c	\N	docker-http-basic-authenticator	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	4e4e75e6-cef2-47f1-ba83-b62acdb75f58	0	10	f	\N	\N
ac1e543f-8cca-44b0-9b77-3339c1455871	\N	auth-cookie	b4825e08-1ac5-43e9-990a-7556e882153a	49945d46-dd92-4440-a7b4-553a1a9d68d5	2	10	f	\N	\N
ba256a7b-de27-4256-bda4-6a5ed7dbf07e	\N	auth-spnego	b4825e08-1ac5-43e9-990a-7556e882153a	49945d46-dd92-4440-a7b4-553a1a9d68d5	3	20	f	\N	\N
82d2acba-2738-4ede-9dd5-b73f6a42c49a	\N	identity-provider-redirector	b4825e08-1ac5-43e9-990a-7556e882153a	49945d46-dd92-4440-a7b4-553a1a9d68d5	2	25	f	\N	\N
bf838771-6330-4363-9369-fef9ea463121	\N	\N	b4825e08-1ac5-43e9-990a-7556e882153a	49945d46-dd92-4440-a7b4-553a1a9d68d5	2	30	t	c1676a2f-699f-4e6d-83ef-9059c3721600	\N
ee7097c0-a977-4ea9-b6cb-dcdc2aef84a0	\N	auth-username-password-form	b4825e08-1ac5-43e9-990a-7556e882153a	c1676a2f-699f-4e6d-83ef-9059c3721600	0	10	f	\N	\N
e9e8e954-b034-4ae6-9871-1f451f11d5d7	\N	\N	b4825e08-1ac5-43e9-990a-7556e882153a	c1676a2f-699f-4e6d-83ef-9059c3721600	1	20	t	3a8d3503-b6fd-4749-aa8d-844888d69481	\N
9d9bf477-b0a4-4216-8380-f7ac4d482210	\N	conditional-user-configured	b4825e08-1ac5-43e9-990a-7556e882153a	3a8d3503-b6fd-4749-aa8d-844888d69481	0	10	f	\N	\N
48bd8bd4-733c-4ce7-b268-ad91bd7f3337	\N	auth-otp-form	b4825e08-1ac5-43e9-990a-7556e882153a	3a8d3503-b6fd-4749-aa8d-844888d69481	0	20	f	\N	\N
3d329d15-975c-43f4-b610-a400d903e9f3	\N	direct-grant-validate-username	b4825e08-1ac5-43e9-990a-7556e882153a	05fca361-73f0-4aea-9236-0a7b40610856	0	10	f	\N	\N
f68eb02c-5b7b-4cee-a770-35c300a15686	\N	direct-grant-validate-password	b4825e08-1ac5-43e9-990a-7556e882153a	05fca361-73f0-4aea-9236-0a7b40610856	0	20	f	\N	\N
7e7c88a0-24ba-44c7-aeea-2631888125ed	\N	\N	b4825e08-1ac5-43e9-990a-7556e882153a	05fca361-73f0-4aea-9236-0a7b40610856	1	30	t	6121c516-e023-4beb-a531-e45cb5966eea	\N
6aced2ea-49ea-437d-a8bc-122fd1ad645c	\N	conditional-user-configured	b4825e08-1ac5-43e9-990a-7556e882153a	6121c516-e023-4beb-a531-e45cb5966eea	0	10	f	\N	\N
e6b62994-6270-4a2b-8649-9d8abe745bfa	\N	direct-grant-validate-otp	b4825e08-1ac5-43e9-990a-7556e882153a	6121c516-e023-4beb-a531-e45cb5966eea	0	20	f	\N	\N
5e28ac6c-9751-4f86-8e0f-b75c54b79506	\N	registration-page-form	b4825e08-1ac5-43e9-990a-7556e882153a	3620b83e-2ca5-4721-83a6-ca16a73f7f3f	0	10	t	676581bf-a82d-4076-8d37-aaba1bb5c241	\N
c54eeb39-216c-47ec-9c53-f369572a7f25	\N	registration-user-creation	b4825e08-1ac5-43e9-990a-7556e882153a	676581bf-a82d-4076-8d37-aaba1bb5c241	0	20	f	\N	\N
887f45ee-d7dd-42ca-97f4-768dcb4617b1	\N	registration-password-action	b4825e08-1ac5-43e9-990a-7556e882153a	676581bf-a82d-4076-8d37-aaba1bb5c241	0	50	f	\N	\N
01bb0bf8-aa92-4966-99bf-973e1c4abdf6	\N	registration-recaptcha-action	b4825e08-1ac5-43e9-990a-7556e882153a	676581bf-a82d-4076-8d37-aaba1bb5c241	3	60	f	\N	\N
4de553a0-2183-4867-8905-0e073817eadf	\N	registration-terms-and-conditions	b4825e08-1ac5-43e9-990a-7556e882153a	676581bf-a82d-4076-8d37-aaba1bb5c241	3	70	f	\N	\N
97d15147-0803-46c8-a36e-2ab346ca398c	\N	reset-credentials-choose-user	b4825e08-1ac5-43e9-990a-7556e882153a	e1889b1c-067a-42d2-a4fa-184690cc575f	0	10	f	\N	\N
a958ade5-a284-450f-b457-b7b99b4c7c01	\N	reset-credential-email	b4825e08-1ac5-43e9-990a-7556e882153a	e1889b1c-067a-42d2-a4fa-184690cc575f	0	20	f	\N	\N
5100d07f-4500-4e0f-b087-bf312cf08787	\N	reset-password	b4825e08-1ac5-43e9-990a-7556e882153a	e1889b1c-067a-42d2-a4fa-184690cc575f	0	30	f	\N	\N
ab96d62d-90b3-4a69-92a6-0b0d7453672e	\N	\N	b4825e08-1ac5-43e9-990a-7556e882153a	e1889b1c-067a-42d2-a4fa-184690cc575f	1	40	t	34996416-2d2f-4f9a-bd9e-1b514d594dbe	\N
45114495-78c0-4503-9b1b-2c95b4536285	\N	conditional-user-configured	b4825e08-1ac5-43e9-990a-7556e882153a	34996416-2d2f-4f9a-bd9e-1b514d594dbe	0	10	f	\N	\N
a633b541-a41a-4e6e-9892-576734fbc449	\N	reset-otp	b4825e08-1ac5-43e9-990a-7556e882153a	34996416-2d2f-4f9a-bd9e-1b514d594dbe	0	20	f	\N	\N
11dd7854-4011-4f4e-bc1b-a9a29e4df749	\N	client-secret	b4825e08-1ac5-43e9-990a-7556e882153a	32ba0404-77e1-45e1-a1a2-40393f8dc0f9	2	10	f	\N	\N
ca2fc8dc-c4ce-4085-ae4c-e5bc0f374886	\N	client-jwt	b4825e08-1ac5-43e9-990a-7556e882153a	32ba0404-77e1-45e1-a1a2-40393f8dc0f9	2	20	f	\N	\N
7b43d23a-41a8-4a4f-9f09-76b62e4fa120	\N	client-secret-jwt	b4825e08-1ac5-43e9-990a-7556e882153a	32ba0404-77e1-45e1-a1a2-40393f8dc0f9	2	30	f	\N	\N
308c6c5a-9aa4-436f-a330-427238691bcb	\N	client-x509	b4825e08-1ac5-43e9-990a-7556e882153a	32ba0404-77e1-45e1-a1a2-40393f8dc0f9	2	40	f	\N	\N
c50ca165-5d12-41d9-84e1-18d2d5e85012	\N	idp-review-profile	b4825e08-1ac5-43e9-990a-7556e882153a	c6a6fabf-c7a8-4889-8fdf-d1df61729bc4	0	10	f	\N	e1e7aa71-83ea-410a-8fc0-759b12c658b6
099ec42d-c6b8-4698-847e-7ea5a894972f	\N	\N	b4825e08-1ac5-43e9-990a-7556e882153a	c6a6fabf-c7a8-4889-8fdf-d1df61729bc4	0	20	t	c9b13ce3-d984-496e-a9e8-407f95f7de35	\N
17215e89-c608-4fbf-aa6e-c390bced4d5e	\N	idp-create-user-if-unique	b4825e08-1ac5-43e9-990a-7556e882153a	c9b13ce3-d984-496e-a9e8-407f95f7de35	2	10	f	\N	3bb7907e-b8b1-41d4-b4e7-3336d8a8708f
09e6cb1c-c80a-4aa5-9d21-fcc98728075f	\N	\N	b4825e08-1ac5-43e9-990a-7556e882153a	c9b13ce3-d984-496e-a9e8-407f95f7de35	2	20	t	d7e05e70-b9f0-465d-a1dd-e5ad4c09d636	\N
67857539-7ef8-468d-bb56-9c1a9761dac4	\N	idp-confirm-link	b4825e08-1ac5-43e9-990a-7556e882153a	d7e05e70-b9f0-465d-a1dd-e5ad4c09d636	0	10	f	\N	\N
2335a617-bfb7-47d4-ad29-f8ba8784c180	\N	\N	b4825e08-1ac5-43e9-990a-7556e882153a	d7e05e70-b9f0-465d-a1dd-e5ad4c09d636	0	20	t	b68c8ba0-91a7-4369-ba96-7d5f26d9fc7a	\N
edda2795-93d8-44a9-83c6-6ebfb200ab50	\N	idp-email-verification	b4825e08-1ac5-43e9-990a-7556e882153a	b68c8ba0-91a7-4369-ba96-7d5f26d9fc7a	2	10	f	\N	\N
cd29cdcd-5de4-479c-aa1f-ee5544c5adb5	\N	\N	b4825e08-1ac5-43e9-990a-7556e882153a	b68c8ba0-91a7-4369-ba96-7d5f26d9fc7a	2	20	t	a205c92a-9aef-49f8-b25f-d510ed59c33e	\N
d3eede16-5ecd-4d36-8928-0876ef4dc24f	\N	idp-username-password-form	b4825e08-1ac5-43e9-990a-7556e882153a	a205c92a-9aef-49f8-b25f-d510ed59c33e	0	10	f	\N	\N
0987c9de-abd2-4ad7-92ec-72c3af78d0b1	\N	\N	b4825e08-1ac5-43e9-990a-7556e882153a	a205c92a-9aef-49f8-b25f-d510ed59c33e	1	20	t	e48f4a16-9c03-49aa-8199-ff81bc9ad0ff	\N
c53f3491-8aca-4f5f-b2db-3d16caff5358	\N	conditional-user-configured	b4825e08-1ac5-43e9-990a-7556e882153a	e48f4a16-9c03-49aa-8199-ff81bc9ad0ff	0	10	f	\N	\N
576c1957-4bb1-4684-8049-d3a52db023a0	\N	auth-otp-form	b4825e08-1ac5-43e9-990a-7556e882153a	e48f4a16-9c03-49aa-8199-ff81bc9ad0ff	0	20	f	\N	\N
0d63abbd-b062-46ea-96a1-714058c8a03a	\N	http-basic-authenticator	b4825e08-1ac5-43e9-990a-7556e882153a	ff8289c2-c485-4dfa-b5b2-905bc38105da	0	10	f	\N	\N
8b490362-43e1-4970-97bb-450bdef1c27a	\N	docker-http-basic-authenticator	b4825e08-1ac5-43e9-990a-7556e882153a	7b75457a-c4c2-4bad-81e5-034f9357e58f	0	10	f	\N	\N
2ff22431-483e-4e17-b483-3d1702f47736	\N	auth-cookie	2256a568-ee44-4cb6-88fa-488d343b1bf5	f17fdeb3-6313-4e32-b352-6bf19c7de8a3	2	10	f	\N	\N
00db306f-8ad9-44b4-bc2c-c3c90e5bdcff	\N	auth-spnego	2256a568-ee44-4cb6-88fa-488d343b1bf5	f17fdeb3-6313-4e32-b352-6bf19c7de8a3	3	20	f	\N	\N
12e9676a-88aa-429c-902e-e09605be7410	\N	identity-provider-redirector	2256a568-ee44-4cb6-88fa-488d343b1bf5	f17fdeb3-6313-4e32-b352-6bf19c7de8a3	2	25	f	\N	\N
9cab1621-5420-43fe-8695-855d6a8612cf	\N	\N	2256a568-ee44-4cb6-88fa-488d343b1bf5	f17fdeb3-6313-4e32-b352-6bf19c7de8a3	2	30	t	905c7659-76e8-4e9c-a923-23d0f8ac3f87	\N
2e8ddbf2-d83a-4db9-872d-af770627a927	\N	auth-username-password-form	2256a568-ee44-4cb6-88fa-488d343b1bf5	905c7659-76e8-4e9c-a923-23d0f8ac3f87	0	10	f	\N	\N
4a21fe97-b040-47d9-b7f4-92ea3ddbf159	\N	\N	2256a568-ee44-4cb6-88fa-488d343b1bf5	905c7659-76e8-4e9c-a923-23d0f8ac3f87	1	20	t	cf9d31a0-225c-4ea7-b266-a8b7362eef9e	\N
c2d08344-de6d-4fa0-ab9b-b7d29ebf058f	\N	conditional-user-configured	2256a568-ee44-4cb6-88fa-488d343b1bf5	cf9d31a0-225c-4ea7-b266-a8b7362eef9e	0	10	f	\N	\N
beb4e5a7-ad3f-4663-adf3-d5af7952ef7f	\N	auth-otp-form	2256a568-ee44-4cb6-88fa-488d343b1bf5	cf9d31a0-225c-4ea7-b266-a8b7362eef9e	0	20	f	\N	\N
5b22a85a-c023-41e9-9ae9-4f46d18c4658	\N	direct-grant-validate-username	2256a568-ee44-4cb6-88fa-488d343b1bf5	4240e704-7d9f-4071-8327-2979a9fad2ed	0	10	f	\N	\N
271223fe-7499-4a7b-8317-6b9f5d497520	\N	direct-grant-validate-password	2256a568-ee44-4cb6-88fa-488d343b1bf5	4240e704-7d9f-4071-8327-2979a9fad2ed	0	20	f	\N	\N
76a92203-aa08-4b71-87ba-ad389728cc8d	\N	\N	2256a568-ee44-4cb6-88fa-488d343b1bf5	4240e704-7d9f-4071-8327-2979a9fad2ed	1	30	t	11e13af6-2ad1-4509-947f-ca89d100b900	\N
a6bd00a7-eea6-41f2-b25a-867219bf577d	\N	conditional-user-configured	2256a568-ee44-4cb6-88fa-488d343b1bf5	11e13af6-2ad1-4509-947f-ca89d100b900	0	10	f	\N	\N
e49b1234-d53b-4afd-9e9c-6d58efa4d017	\N	direct-grant-validate-otp	2256a568-ee44-4cb6-88fa-488d343b1bf5	11e13af6-2ad1-4509-947f-ca89d100b900	0	20	f	\N	\N
26efdb66-dcf7-410f-a3ca-e18076df7b4a	\N	registration-page-form	2256a568-ee44-4cb6-88fa-488d343b1bf5	f9646b25-951c-499a-b3e6-bbdd07948b20	0	10	t	a0922a3a-3ef2-4511-b3c2-f009c3c634fe	\N
f2714271-51b8-4eb6-9b48-bace8356981b	\N	registration-user-creation	2256a568-ee44-4cb6-88fa-488d343b1bf5	a0922a3a-3ef2-4511-b3c2-f009c3c634fe	0	20	f	\N	\N
96fe312d-b6d9-4d51-bd7e-314cf6162acb	\N	registration-password-action	2256a568-ee44-4cb6-88fa-488d343b1bf5	a0922a3a-3ef2-4511-b3c2-f009c3c634fe	0	50	f	\N	\N
a4262395-61d3-45ad-8c6f-23f3138338a3	\N	registration-recaptcha-action	2256a568-ee44-4cb6-88fa-488d343b1bf5	a0922a3a-3ef2-4511-b3c2-f009c3c634fe	3	60	f	\N	\N
c434131f-ed13-4b8d-851f-3796a60c0659	\N	registration-terms-and-conditions	2256a568-ee44-4cb6-88fa-488d343b1bf5	a0922a3a-3ef2-4511-b3c2-f009c3c634fe	3	70	f	\N	\N
f567166e-5f77-4851-b935-d3cb87385866	\N	reset-credentials-choose-user	2256a568-ee44-4cb6-88fa-488d343b1bf5	9f4f1ea1-68c2-44f2-ad65-f8d9f1868263	0	10	f	\N	\N
b5d0396d-6659-4bd6-8775-17a8a12617e1	\N	reset-credential-email	2256a568-ee44-4cb6-88fa-488d343b1bf5	9f4f1ea1-68c2-44f2-ad65-f8d9f1868263	0	20	f	\N	\N
30cf6f92-7587-401e-bbe9-24019d80d29d	\N	reset-password	2256a568-ee44-4cb6-88fa-488d343b1bf5	9f4f1ea1-68c2-44f2-ad65-f8d9f1868263	0	30	f	\N	\N
f10495a9-0402-4699-880a-2a5b89ac5074	\N	\N	2256a568-ee44-4cb6-88fa-488d343b1bf5	9f4f1ea1-68c2-44f2-ad65-f8d9f1868263	1	40	t	5d1aecdd-4c94-47f0-8a34-91ea641e931e	\N
5334fc75-878c-4d63-bdee-67869a64e29e	\N	conditional-user-configured	2256a568-ee44-4cb6-88fa-488d343b1bf5	5d1aecdd-4c94-47f0-8a34-91ea641e931e	0	10	f	\N	\N
4224ffbb-c953-4187-8bbd-c78a61cf1a4a	\N	reset-otp	2256a568-ee44-4cb6-88fa-488d343b1bf5	5d1aecdd-4c94-47f0-8a34-91ea641e931e	0	20	f	\N	\N
4791ae6b-4747-4056-9a25-c008a6050535	\N	client-secret	2256a568-ee44-4cb6-88fa-488d343b1bf5	f8606255-568a-4266-aacf-006de0f0d009	2	10	f	\N	\N
72416292-a45f-455f-b783-490f429c91df	\N	client-jwt	2256a568-ee44-4cb6-88fa-488d343b1bf5	f8606255-568a-4266-aacf-006de0f0d009	2	20	f	\N	\N
8a4389b8-3be8-450e-b650-0f963de7ee9e	\N	client-secret-jwt	2256a568-ee44-4cb6-88fa-488d343b1bf5	f8606255-568a-4266-aacf-006de0f0d009	2	30	f	\N	\N
a17a5167-1bd5-47ff-bbbc-18184e8864b5	\N	client-x509	2256a568-ee44-4cb6-88fa-488d343b1bf5	f8606255-568a-4266-aacf-006de0f0d009	2	40	f	\N	\N
3d4677e8-5c99-4fd1-af8b-0ad88b4882fb	\N	idp-review-profile	2256a568-ee44-4cb6-88fa-488d343b1bf5	66c0da3b-2a03-4831-81ec-b6d3be1938b7	0	10	f	\N	98edfe66-12e1-4eab-9cc2-fa4fca68244f
0eb0d03c-ab26-42ac-894f-3bb48960a447	\N	\N	2256a568-ee44-4cb6-88fa-488d343b1bf5	66c0da3b-2a03-4831-81ec-b6d3be1938b7	0	20	t	cb55a7c3-b799-41ad-bb80-ef5fe8b0db6a	\N
01022caa-5e43-419c-847d-e01dfaeb158c	\N	idp-create-user-if-unique	2256a568-ee44-4cb6-88fa-488d343b1bf5	cb55a7c3-b799-41ad-bb80-ef5fe8b0db6a	2	10	f	\N	72df875a-611c-45a0-ae76-9dcdd2153887
ec2562e9-215a-4f5c-8d57-aafcc50ce509	\N	\N	2256a568-ee44-4cb6-88fa-488d343b1bf5	cb55a7c3-b799-41ad-bb80-ef5fe8b0db6a	2	20	t	85d7aedf-dc90-47f6-9d22-f4b8769d0a85	\N
c68832ab-e6c6-4835-9779-746a2aa3c4cf	\N	idp-confirm-link	2256a568-ee44-4cb6-88fa-488d343b1bf5	85d7aedf-dc90-47f6-9d22-f4b8769d0a85	0	10	f	\N	\N
d9fb143e-e7af-461d-a171-9e7398f841bc	\N	\N	2256a568-ee44-4cb6-88fa-488d343b1bf5	85d7aedf-dc90-47f6-9d22-f4b8769d0a85	0	20	t	1a6e03d8-c877-4306-aa1b-e9576192fde3	\N
00e830b6-47cc-4a5a-ad87-435a2b333896	\N	idp-email-verification	2256a568-ee44-4cb6-88fa-488d343b1bf5	1a6e03d8-c877-4306-aa1b-e9576192fde3	2	10	f	\N	\N
1f9bcc86-b982-4083-abb3-faf171a6a3f4	\N	\N	2256a568-ee44-4cb6-88fa-488d343b1bf5	1a6e03d8-c877-4306-aa1b-e9576192fde3	2	20	t	45575877-7f5a-4df3-acb9-f2fe4d44c048	\N
c78a4942-e279-41d1-a8fe-878b69a1f6c3	\N	idp-username-password-form	2256a568-ee44-4cb6-88fa-488d343b1bf5	45575877-7f5a-4df3-acb9-f2fe4d44c048	0	10	f	\N	\N
bc70fb22-be82-40fa-818c-a84d09f8133f	\N	\N	2256a568-ee44-4cb6-88fa-488d343b1bf5	45575877-7f5a-4df3-acb9-f2fe4d44c048	1	20	t	3146e186-52de-4235-9d2d-4bc067145897	\N
e5ca5ab3-7646-4ea8-aa68-82676cd34050	\N	conditional-user-configured	2256a568-ee44-4cb6-88fa-488d343b1bf5	3146e186-52de-4235-9d2d-4bc067145897	0	10	f	\N	\N
d80487e3-6782-47b6-b72f-1246a2030aaf	\N	auth-otp-form	2256a568-ee44-4cb6-88fa-488d343b1bf5	3146e186-52de-4235-9d2d-4bc067145897	0	20	f	\N	\N
13d83aeb-0f2f-4007-aae1-f65e70549f8d	\N	http-basic-authenticator	2256a568-ee44-4cb6-88fa-488d343b1bf5	f841908a-4da5-4877-a010-80727f248bab	0	10	f	\N	\N
2b025bcf-c904-4579-899c-9830f7691765	\N	docker-http-basic-authenticator	2256a568-ee44-4cb6-88fa-488d343b1bf5	0fd2b968-fe02-4967-982f-6c4c738c094c	0	10	f	\N	\N
ce44ffbf-811d-47ec-9bb3-af4fcee0ed74	\N	registration-user-creation	5760f0e0-8dc4-453f-b407-19c01025187d	c82fe2ed-50a9-4932-b4ba-afb66a8e42f1	0	20	f	\N	\N
ce631e0f-4235-4866-971a-e82af14bacfb	\N	registration-password-action	5760f0e0-8dc4-453f-b407-19c01025187d	c82fe2ed-50a9-4932-b4ba-afb66a8e42f1	0	50	f	\N	\N
750c4b19-8937-4a48-92c4-ca2c014e0c10	\N	registration-recaptcha-action	5760f0e0-8dc4-453f-b407-19c01025187d	c82fe2ed-50a9-4932-b4ba-afb66a8e42f1	0	60	f	\N	7eea235b-694f-41c8-b8bb-dec262da75a2
bbd18f75-29fb-4456-80e7-481dc6390194	\N	registration-terms-and-conditions	5760f0e0-8dc4-453f-b407-19c01025187d	c82fe2ed-50a9-4932-b4ba-afb66a8e42f1	3	70	f	\N	\N
4fd0a389-b8cd-406b-8bb4-1bc5269c557e	\N	registration-page-form	5760f0e0-8dc4-453f-b407-19c01025187d	e1786458-5657-4871-b724-3e97e5cf3c7f	0	10	t	c82fe2ed-50a9-4932-b4ba-afb66a8e42f1	\N
7dda6b28-198d-4fa4-bf75-2f22f731f966	\N	auth-username-form	f493d84c-5308-498f-afec-c6f4cfffd553	b4ff78b2-66fb-4443-a94c-94a6869864da	0	0	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
0ba17251-efd0-427d-9ab0-dae4e934a40d	browser	browser based authentication	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	t	t
9d5a7030-ebbb-48b1-9ba2-93c2c75431b4	forms	Username, password, otp and other auth forms.	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	f	t
14370d31-e4fb-459a-a73f-d54a9e382914	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	f	t
66c83497-7f4f-4bb2-a963-f712f4519120	direct grant	OpenID Connect Resource Owner Grant	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	t	t
cbf0ea65-0c0f-4456-bb63-9ca961357643	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	f	t
3ae0a9e7-1c33-405f-bf5b-07af9ab31bb8	registration	registration flow	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	t	t
764d7dd0-34ce-46ce-b7ec-1456873cb2f6	registration form	registration form	f493d84c-5308-498f-afec-c6f4cfffd553	form-flow	f	t
eb164f98-3325-4540-9bf5-3f67e99ed183	reset credentials	Reset credentials for a user if they forgot their password or something	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	t	t
ca69306e-2b7b-4a4f-8cb8-be43f2846c7a	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	f	t
d0f014fa-0d88-4543-be77-3dedab5e93dc	clients	Base authentication for clients	f493d84c-5308-498f-afec-c6f4cfffd553	client-flow	t	t
bec443cf-4bf5-4fb1-b3a3-a7ec90481f05	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	t	t
54bba0a6-13d4-466a-9e33-1ad853e9a7f7	User creation or linking	Flow for the existing/non-existing user alternatives	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	f	t
071d40c7-bf91-45e6-978f-40b5b013c3ca	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	f	t
0707e388-7c6b-41ed-8693-f2d4142d3254	Account verification options	Method with which to verity the existing account	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	f	t
d02f9d39-a87f-4644-bb4f-76f23b536159	Verify Existing Account by Re-authentication	Reauthentication of existing account	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	f	t
dbf55f76-c1a2-40d2-bcb0-b8ba35189d52	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	f	t
c1ed4cc4-5d08-4d27-8225-d478f251acbb	saml ecp	SAML ECP Profile Authentication Flow	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	t	t
fe1910a0-ce2a-455c-ac27-b4054141d4ae	docker auth	Used by Docker clients to authenticate against the IDP	f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	t	t
e1a27992-be07-4db8-a4fe-39dcb84603ea	browser	browser based authentication	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	t	t
b01fd215-623b-4e6a-9d18-595a090751e1	forms	Username, password, otp and other auth forms.	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	f	t
6c61a420-df1b-4743-93b6-bfaa93667d6f	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	f	t
8ec8ad2f-78c1-4b30-95c4-76bb0f48529f	direct grant	OpenID Connect Resource Owner Grant	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	t	t
0706de0d-9615-4647-b3bd-44a97ad63f28	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	f	t
a8a05551-ae94-4fda-9a0f-41f9dc1ed6f9	registration	registration flow	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	t	t
a13b3dd3-dae1-4199-8290-8039a65f66e6	registration form	registration form	5760f0e0-8dc4-453f-b407-19c01025187d	form-flow	f	t
982c10d6-5e7e-4365-bc73-b9255a2fce9c	reset credentials	Reset credentials for a user if they forgot their password or something	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	t	t
b0f1deaa-cfe1-4c99-b5d0-1b29dfe0a45d	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	f	t
987fb39d-dde7-4aa0-b100-c3ed19911cbd	clients	Base authentication for clients	5760f0e0-8dc4-453f-b407-19c01025187d	client-flow	t	t
182b2041-2e16-423a-9af7-e1c3a30d78f5	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	t	t
ca69ec5d-7260-4d81-9ad8-eec1b7ac4972	User creation or linking	Flow for the existing/non-existing user alternatives	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	f	t
ab60ba3a-812b-420b-a002-8bebe9accdb9	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	f	t
3eca6fbf-1d4b-44a7-a588-eab49a4508cd	Account verification options	Method with which to verity the existing account	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	f	t
80c82437-beb3-4679-b31e-88b85f3efe60	Verify Existing Account by Re-authentication	Reauthentication of existing account	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	f	t
0872c06e-54b1-4b7f-9491-8e828d7f9309	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	f	t
25a5690c-b96f-4215-ae90-9bb13f624f44	saml ecp	SAML ECP Profile Authentication Flow	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	t	t
5671c7ed-7dc1-44e9-b574-2687b5530130	docker auth	Used by Docker clients to authenticate against the IDP	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	t	t
8f98653d-bc49-4b3c-b297-43d14d7840b4	ol-browser	browser based authentication	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	t	f
d9d38c08-d6aa-4d14-bf0d-b1aca441ae83	ol-browser forms	Username, password, otp and other auth forms.	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	f	f
12bb5f70-be1c-41cc-a773-70988d0d987e	browser	browser based authentication	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	t	t
5e6e36ba-575a-4a15-a708-893f34ae2e47	forms	Username, password, otp and other auth forms.	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	f	t
380bbbea-7229-4e8d-9da8-c9cb63a33b6b	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	f	t
9c193f5c-a7ac-4007-ae6d-d84b2f1bfafc	direct grant	OpenID Connect Resource Owner Grant	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	t	t
845ea257-b22d-4cd0-860b-e86e09f9c571	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	f	t
be18abc9-79c3-44ea-b6b2-139dbc7db299	registration	registration flow	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	t	t
e04d189b-1b80-4911-978a-de407a4d501f	registration form	registration form	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	form-flow	f	t
216b8618-d4fc-4e7f-acec-cfe05025e7b6	reset credentials	Reset credentials for a user if they forgot their password or something	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	t	t
623677ac-326c-41df-a770-9b478a08de8f	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	f	t
115afaed-6d8f-4712-bdca-8b5aa323c6f1	clients	Base authentication for clients	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	client-flow	t	t
836795b8-9f9e-44b8-96a6-5ef2cad92d9c	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	t	t
f2dc1eb0-a1e6-42c1-a2e7-d663ad2d0ed1	User creation or linking	Flow for the existing/non-existing user alternatives	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	f	t
99cc1989-3302-4dc3-b227-8c2b6ae33d13	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	f	t
72660555-cbab-40ca-a9bc-b79f95719820	Account verification options	Method with which to verity the existing account	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	f	t
ac1a52b2-56c1-4915-a5b5-c9076b3a5bc8	Verify Existing Account by Re-authentication	Reauthentication of existing account	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	f	t
f7e464aa-ddf6-4a69-804a-b05fcbc03b3a	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	f	t
bf97f1e7-d61d-4f56-b70c-a49f38157b4e	saml ecp	SAML ECP Profile Authentication Flow	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	t	t
4e4e75e6-cef2-47f1-ba83-b62acdb75f58	docker auth	Used by Docker clients to authenticate against the IDP	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	basic-flow	t	t
49945d46-dd92-4440-a7b4-553a1a9d68d5	browser	browser based authentication	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	t	t
c1676a2f-699f-4e6d-83ef-9059c3721600	forms	Username, password, otp and other auth forms.	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	f	t
3a8d3503-b6fd-4749-aa8d-844888d69481	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	f	t
05fca361-73f0-4aea-9236-0a7b40610856	direct grant	OpenID Connect Resource Owner Grant	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	t	t
6121c516-e023-4beb-a531-e45cb5966eea	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	f	t
3620b83e-2ca5-4721-83a6-ca16a73f7f3f	registration	registration flow	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	t	t
676581bf-a82d-4076-8d37-aaba1bb5c241	registration form	registration form	b4825e08-1ac5-43e9-990a-7556e882153a	form-flow	f	t
e1889b1c-067a-42d2-a4fa-184690cc575f	reset credentials	Reset credentials for a user if they forgot their password or something	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	t	t
34996416-2d2f-4f9a-bd9e-1b514d594dbe	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	f	t
32ba0404-77e1-45e1-a1a2-40393f8dc0f9	clients	Base authentication for clients	b4825e08-1ac5-43e9-990a-7556e882153a	client-flow	t	t
c6a6fabf-c7a8-4889-8fdf-d1df61729bc4	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	t	t
c9b13ce3-d984-496e-a9e8-407f95f7de35	User creation or linking	Flow for the existing/non-existing user alternatives	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	f	t
d7e05e70-b9f0-465d-a1dd-e5ad4c09d636	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	f	t
b68c8ba0-91a7-4369-ba96-7d5f26d9fc7a	Account verification options	Method with which to verity the existing account	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	f	t
a205c92a-9aef-49f8-b25f-d510ed59c33e	Verify Existing Account by Re-authentication	Reauthentication of existing account	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	f	t
e48f4a16-9c03-49aa-8199-ff81bc9ad0ff	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	f	t
ff8289c2-c485-4dfa-b5b2-905bc38105da	saml ecp	SAML ECP Profile Authentication Flow	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	t	t
7b75457a-c4c2-4bad-81e5-034f9357e58f	docker auth	Used by Docker clients to authenticate against the IDP	b4825e08-1ac5-43e9-990a-7556e882153a	basic-flow	t	t
f17fdeb3-6313-4e32-b352-6bf19c7de8a3	browser	browser based authentication	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	t	t
905c7659-76e8-4e9c-a923-23d0f8ac3f87	forms	Username, password, otp and other auth forms.	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	f	t
cf9d31a0-225c-4ea7-b266-a8b7362eef9e	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	f	t
4240e704-7d9f-4071-8327-2979a9fad2ed	direct grant	OpenID Connect Resource Owner Grant	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	t	t
11e13af6-2ad1-4509-947f-ca89d100b900	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	f	t
f9646b25-951c-499a-b3e6-bbdd07948b20	registration	registration flow	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	t	t
a0922a3a-3ef2-4511-b3c2-f009c3c634fe	registration form	registration form	2256a568-ee44-4cb6-88fa-488d343b1bf5	form-flow	f	t
9f4f1ea1-68c2-44f2-ad65-f8d9f1868263	reset credentials	Reset credentials for a user if they forgot their password or something	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	t	t
5d1aecdd-4c94-47f0-8a34-91ea641e931e	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	f	t
f8606255-568a-4266-aacf-006de0f0d009	clients	Base authentication for clients	2256a568-ee44-4cb6-88fa-488d343b1bf5	client-flow	t	t
66c0da3b-2a03-4831-81ec-b6d3be1938b7	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	t	t
cb55a7c3-b799-41ad-bb80-ef5fe8b0db6a	User creation or linking	Flow for the existing/non-existing user alternatives	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	f	t
85d7aedf-dc90-47f6-9d22-f4b8769d0a85	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	f	t
1a6e03d8-c877-4306-aa1b-e9576192fde3	Account verification options	Method with which to verity the existing account	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	f	t
45575877-7f5a-4df3-acb9-f2fe4d44c048	Verify Existing Account by Re-authentication	Reauthentication of existing account	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	f	t
3146e186-52de-4235-9d2d-4bc067145897	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	f	t
f841908a-4da5-4877-a010-80727f248bab	saml ecp	SAML ECP Profile Authentication Flow	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	t	t
0fd2b968-fe02-4967-982f-6c4c738c094c	docker auth	Used by Docker clients to authenticate against the IDP	2256a568-ee44-4cb6-88fa-488d343b1bf5	basic-flow	t	t
e1786458-5657-4871-b724-3e97e5cf3c7f	ol-registration	registration flow	5760f0e0-8dc4-453f-b407-19c01025187d	basic-flow	t	f
c82fe2ed-50a9-4932-b4ba-afb66a8e42f1	ol-registration registration form	registration form	5760f0e0-8dc4-453f-b407-19c01025187d	form-flow	f	f
b4ff78b2-66fb-4443-a94c-94a6869864da	test		f493d84c-5308-498f-afec-c6f4cfffd553	basic-flow	t	f
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
854b0776-d880-4fce-a215-40581f4dec12	review profile config	f493d84c-5308-498f-afec-c6f4cfffd553
ae17917a-f245-4d91-82b8-b11e6cf0b31e	create unique user config	f493d84c-5308-498f-afec-c6f4cfffd553
c3df6f4d-fc49-4567-a333-7f79a3e94273	review profile config	5760f0e0-8dc4-453f-b407-19c01025187d
58609a18-f130-4585-a65c-f53a72c971d4	create unique user config	5760f0e0-8dc4-453f-b407-19c01025187d
ea4ddc27-34c1-40c6-b9d2-305a957a23dc	recaptcha	5760f0e0-8dc4-453f-b407-19c01025187d
aff8e752-0cc4-42ab-aa25-df48c561a6c8	review profile config	429ce2ec-99a2-44b6-9c27-36b18f46b8d3
3cf1063c-0c4d-4766-be7e-b28cb4ffa7d1	create unique user config	429ce2ec-99a2-44b6-9c27-36b18f46b8d3
e1e7aa71-83ea-410a-8fc0-759b12c658b6	review profile config	b4825e08-1ac5-43e9-990a-7556e882153a
3bb7907e-b8b1-41d4-b4e7-3336d8a8708f	create unique user config	b4825e08-1ac5-43e9-990a-7556e882153a
98edfe66-12e1-4eab-9cc2-fa4fca68244f	review profile config	2256a568-ee44-4cb6-88fa-488d343b1bf5
72df875a-611c-45a0-ae76-9dcdd2153887	create unique user config	2256a568-ee44-4cb6-88fa-488d343b1bf5
7eea235b-694f-41c8-b8bb-dec262da75a2	ol-registration recaptcha	5760f0e0-8dc4-453f-b407-19c01025187d
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
854b0776-d880-4fce-a215-40581f4dec12	missing	update.profile.on.first.login
ae17917a-f245-4d91-82b8-b11e6cf0b31e	false	require.password.update.after.registration
58609a18-f130-4585-a65c-f53a72c971d4	false	require.password.update.after.registration
c3df6f4d-fc49-4567-a333-7f79a3e94273	missing	update.profile.on.first.login
ea4ddc27-34c1-40c6-b9d2-305a957a23dc	6Lf8WvspAAAAAHXM_pfMSY8CRHdhTHa-zqwpWVXj	secret
ea4ddc27-34c1-40c6-b9d2-305a957a23dc	6Lf8WvspAAAAAL2Pw4yqzgumFWAsBNz_l-IoYm9p	site.key
3cf1063c-0c4d-4766-be7e-b28cb4ffa7d1	false	require.password.update.after.registration
aff8e752-0cc4-42ab-aa25-df48c561a6c8	missing	update.profile.on.first.login
3bb7907e-b8b1-41d4-b4e7-3336d8a8708f	false	require.password.update.after.registration
e1e7aa71-83ea-410a-8fc0-759b12c658b6	missing	update.profile.on.first.login
72df875a-611c-45a0-ae76-9dcdd2153887	false	require.password.update.after.registration
98edfe66-12e1-4eab-9cc2-fa4fca68244f	missing	update.profile.on.first.login
7eea235b-694f-41c8-b8bb-dec262da75a2	6Lf8WvspAAAAAL2Pw4yqzgumFWAsBNz_l-IoYm9p	site.key
7eea235b-694f-41c8-b8bb-dec262da75a2	6Lf8WvspAAAAAHXM_pfMSY8CRHdhTHa-zqwpWVXj	secret
7eea235b-694f-41c8-b8bb-dec262da75a2	register	action
7eea235b-694f-41c8-b8bb-dec262da75a2	false	useRecaptchaNet
7eea235b-694f-41c8-b8bb-dec262da75a2	false	recaptcha.v3
7eea235b-694f-41c8-b8bb-dec262da75a2	6Lf8WvspAAAAAHXM_pfMSY8CRHdhTHa-zqwpWVXj	secret.key
7eea235b-694f-41c8-b8bb-dec262da75a2	1	default.reference.maxAge
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
80b8e421-a8d0-48c7-a471-5bdddf12de86	t	f	master-realm	0	f	\N	\N	t	\N	f	f493d84c-5308-498f-afec-c6f4cfffd553	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
853be0b2-ad1a-4116-aff3-c10f318e9ad5	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	f493d84c-5308-498f-afec-c6f4cfffd553	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
b43612df-590a-4e25-a38f-2f0de881be8f	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	f493d84c-5308-498f-afec-c6f4cfffd553	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
357be594-815d-408b-b337-1e7bb854eb1a	t	f	broker	0	f	\N	\N	t	\N	f	f493d84c-5308-498f-afec-c6f4cfffd553	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	t	t	mit-learn-local	0	f	iaqW9Pqa0usDN7OKcobLVN8KMnacK0DJ	https://api.learn.odl.local/	f	https://api.learn.odl.local/	f	5760f0e0-8dc4-453f-b407-19c01025187d	openid-connect	-1	t	f	MIT Learn Local	f	client-secret	https://api.learn.odl.local/		\N	t	t	t	f
a172934f-a9e5-458f-9483-7dfc4d6e1991	t	t	admin-cli	0	f	7OZulYXWP0VhKw6TIjhRRHRDKg2HNVcj		f		f	5760f0e0-8dc4-453f-b407-19c01025187d	openid-connect	0	f	f	${client_admin-cli}	t	client-secret			\N	t	f	t	f
8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	f	olapps-realm	0	f	\N	\N	t	\N	f	f493d84c-5308-498f-afec-c6f4cfffd553	\N	0	f	f	olapps Realm	f	client-secret	\N	\N	\N	t	f	f	f
0f393319-fded-4b0c-9711-a9ca8eeba66d	t	f	realm-management	0	f	\N	\N	t	\N	f	5760f0e0-8dc4-453f-b407-19c01025187d	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
37ffb6d7-4e38-4e14-a47f-6a5a85276f55	t	f	account	0	t	\N	/realms/olapps/account/	f	\N	f	5760f0e0-8dc4-453f-b407-19c01025187d	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
0eecf1c0-c127-4ca2-9327-459efbb9c681	t	f	account-console	0	t	\N	/realms/olapps/account/	f	\N	f	5760f0e0-8dc4-453f-b407-19c01025187d	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f56304c4-598f-4c59-8424-c762dc578149	t	f	broker	0	f	\N	\N	t	\N	f	5760f0e0-8dc4-453f-b407-19c01025187d	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
44cee68c-7ad2-465c-b7e4-67db09369afc	t	t	security-admin-console	0	t	\N	/admin/olapps/console/	f	\N	f	5760f0e0-8dc4-453f-b407-19c01025187d	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
b864b55f-9586-4738-b061-ab0bec85b58c	t	f	broker	0	f	\N	\N	t	\N	f	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	t	t	unified-ecommerce	0	f	6VURz9dEML7HjuBb3TYgAyU9SlZtEFvc	http://ue.odl.local:4080/	f	http://ue.odl.local:4080/	f	5760f0e0-8dc4-453f-b407-19c01025187d	openid-connect	-1	t	f	unified-ecommerce	f	client-secret	http://ue.odl.local:4080/		\N	t	f	t	f
854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	f	test-realm	0	f	\N	\N	t	\N	f	f493d84c-5308-498f-afec-c6f4cfffd553	\N	0	f	f	test Realm	f	client-secret	\N	\N	\N	t	f	f	f
7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	f	realm-management	0	f	\N	\N	t	\N	f	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
20ab4f86-015d-4d03-9ca5-de7ab82277bf	t	f	account	0	t	\N	/realms/test/account/	f	\N	f	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f99d9cb1-4be5-4cd0-8061-e223ad552b74	t	f	account-console	0	t	\N	/realms/test/account/	f	\N	f	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4260b713-6bb7-4cb2-9790-fe665558ba00	t	f	test1-realm	0	f	\N	\N	t	\N	f	f493d84c-5308-498f-afec-c6f4cfffd553	\N	0	f	f	test1 Realm	f	client-secret	\N	\N	\N	t	f	f	f
2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	f	realm-management	0	f	\N	\N	t	\N	f	b4825e08-1ac5-43e9-990a-7556e882153a	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
df1eed9b-9772-4844-bf38-063fcfbf2c71	t	f	account	0	t	\N	/realms/test1/account/	f	\N	f	b4825e08-1ac5-43e9-990a-7556e882153a	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
bb4d8a91-43ec-4a96-8bec-800f920c8826	t	f	account-console	0	t	\N	/realms/test1/account/	f	\N	f	b4825e08-1ac5-43e9-990a-7556e882153a	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
9e559194-7abb-42a9-9aa5-f689dafa911d	t	f	broker	0	f	\N	\N	t	\N	f	b4825e08-1ac5-43e9-990a-7556e882153a	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	f	test2-realm	0	f	\N	\N	t	\N	f	f493d84c-5308-498f-afec-c6f4cfffd553	\N	0	f	f	test2 Realm	f	client-secret	\N	\N	\N	t	f	f	f
a244baff-703f-4856-ae02-dc4dc6aacd1e	t	f	realm-management	0	f	\N	\N	t	\N	f	2256a568-ee44-4cb6-88fa-488d343b1bf5	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
75fc95fe-2c73-4934-a450-5d00669f5b97	t	f	account	0	t	\N	/realms/test2/account/	f	\N	f	2256a568-ee44-4cb6-88fa-488d343b1bf5	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7f6732e2-e3c2-456a-9e4e-234ecab9072d	t	f	account-console	0	t	\N	/realms/test2/account/	f	\N	f	2256a568-ee44-4cb6-88fa-488d343b1bf5	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
9f878ecd-e756-43ca-8964-7858e766bb1a	t	t	admin-cli	0	t	\N	\N	f	\N	f	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
7f1eda49-4d82-4b18-8c52-36c8fa8e42c6	t	f	broker	0	f	\N	\N	t	\N	f	2256a568-ee44-4cb6-88fa-488d343b1bf5	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	t	t	open-discussions	0	f	nFhAt5ZdUMZMn7OwJpre2CvTZBt23Phc		f		f	f493d84c-5308-498f-afec-c6f4cfffd553	openid-connect	-1	t	f	open-discussions	f	client-jwt			\N	t	f	t	f
b2a0a790-59c5-4142-9d77-44932b1e8620	t	t	open-discussions	0	f	djKLNRPe0r82C87reW886y4JVoLuW12a		f		f	5760f0e0-8dc4-453f-b407-19c01025187d	openid-connect	-1	t	f	open-discussions	f	client-secret			\N	f	f	t	f
d15c1b01-566a-4497-8bc9-3d9d87253ea1	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	f493d84c-5308-498f-afec-c6f4cfffd553	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
c630ba3c-66f1-4ffd-af22-675166784cba	t	t	admin-cli	0	f	n8Hb2QBexomqNv4ctudNv4kxvRheiW6D		f		f	f493d84c-5308-498f-afec-c6f4cfffd553	openid-connect	0	f	f	${client_admin-cli}	f	client-secret			\N	t	f	t	f
797f6274-dc0a-4a46-8098-9e25decee64f	t	t	security-admin-console	0	t	\N	/admin/test2/console/	f	\N	f	2256a568-ee44-4cb6-88fa-488d343b1bf5	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
b4d77a2c-4fe5-4a83-b79f-a1b13b2e0132	t	t	admin-cli	0	t	\N	\N	f	\N	f	2256a568-ee44-4cb6-88fa-488d343b1bf5	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
838fe32e-5500-4989-8194-c83c43aa5617	t	t	security-admin-console	0	t	\N	/admin/test/console/	f	\N	f	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
3d21aefb-1d20-4d27-9756-3cce60b5e958	t	t	security-admin-console	0	t	\N	/admin/test1/console/	f	\N	f	b4825e08-1ac5-43e9-990a-7556e882153a	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
60340a1c-493f-4648-96ca-76635694dcec	t	t	admin-cli	0	t	\N	\N	f	\N	f	b4825e08-1ac5-43e9-990a-7556e882153a	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
473685f9-266f-4983-b2a5-156a6dc8468c	t	t	apisix	0	f	AKRQhCV6WaWgLP4BhxIkS1gyaoyUQ9ZD		f		f	5760f0e0-8dc4-453f-b407-19c01025187d	openid-connect	-1	t	f		f	client-secret			\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
853be0b2-ad1a-4116-aff3-c10f318e9ad5	post.logout.redirect.uris	+
b43612df-590a-4e25-a38f-2f0de881be8f	post.logout.redirect.uris	+
b43612df-590a-4e25-a38f-2f0de881be8f	pkce.code.challenge.method	S256
d15c1b01-566a-4497-8bc9-3d9d87253ea1	post.logout.redirect.uris	+
d15c1b01-566a-4497-8bc9-3d9d87253ea1	pkce.code.challenge.method	S256
37ffb6d7-4e38-4e14-a47f-6a5a85276f55	post.logout.redirect.uris	+
0eecf1c0-c127-4ca2-9327-459efbb9c681	post.logout.redirect.uris	+
0eecf1c0-c127-4ca2-9327-459efbb9c681	pkce.code.challenge.method	S256
44cee68c-7ad2-465c-b7e4-67db09369afc	post.logout.redirect.uris	+
44cee68c-7ad2-465c-b7e4-67db09369afc	pkce.code.challenge.method	S256
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	client.secret.creation.time	1723148721
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	oauth2.device.authorization.grant.enabled	false
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	oidc.ciba.grant.enabled	false
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	backchannel.logout.session.required	true
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	backchannel.logout.revoke.offline.tokens	false
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	client.secret.creation.time	1726248398
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	oauth2.device.authorization.grant.enabled	false
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	oidc.ciba.grant.enabled	false
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	backchannel.logout.session.required	true
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	backchannel.logout.revoke.offline.tokens	false
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	display.on.consent.screen	false
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	post.logout.redirect.uris	http://ue.odl.local:4080/*##http://ue.odl.local:9080/*
20ab4f86-015d-4d03-9ca5-de7ab82277bf	post.logout.redirect.uris	+
f99d9cb1-4be5-4cd0-8061-e223ad552b74	post.logout.redirect.uris	+
f99d9cb1-4be5-4cd0-8061-e223ad552b74	pkce.code.challenge.method	S256
838fe32e-5500-4989-8194-c83c43aa5617	post.logout.redirect.uris	+
838fe32e-5500-4989-8194-c83c43aa5617	pkce.code.challenge.method	S256
df1eed9b-9772-4844-bf38-063fcfbf2c71	post.logout.redirect.uris	+
bb4d8a91-43ec-4a96-8bec-800f920c8826	post.logout.redirect.uris	+
bb4d8a91-43ec-4a96-8bec-800f920c8826	pkce.code.challenge.method	S256
3d21aefb-1d20-4d27-9756-3cce60b5e958	post.logout.redirect.uris	+
3d21aefb-1d20-4d27-9756-3cce60b5e958	pkce.code.challenge.method	S256
75fc95fe-2c73-4934-a450-5d00669f5b97	post.logout.redirect.uris	+
7f6732e2-e3c2-456a-9e4e-234ecab9072d	post.logout.redirect.uris	+
7f6732e2-e3c2-456a-9e4e-234ecab9072d	pkce.code.challenge.method	S256
797f6274-dc0a-4a46-8098-9e25decee64f	post.logout.redirect.uris	+
797f6274-dc0a-4a46-8098-9e25decee64f	pkce.code.challenge.method	S256
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	client.secret.creation.time	1729687300
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	oauth2.device.authorization.grant.enabled	false
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	oidc.ciba.grant.enabled	false
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	backchannel.logout.session.required	true
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	backchannel.logout.revoke.offline.tokens	false
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	display.on.consent.screen	false
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	token.endpoint.auth.signing.alg	ES256
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	jwt.credential.certificate	MIICrzCCAZcCBgGSup+iZTANBgkqhkiG9w0BAQsFADAbMRkwFwYDVQQDDBBvcGVuLWRpc2N1c3Npb25zMB4XDTI0MTAyMzE4MjI1NloXDTM0MTAyMzE4MjQzNlowGzEZMBcGA1UEAwwQb3Blbi1kaXNjdXNzaW9uczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJavnEG+nDnGp4jk3rN70nYEspJPTrYGoRZtQ8JSJUUAdui1uk42fFlqcpaUryzV60M84h/No0bBSJ7yzbVLlDQcFc6XjsyH/VTu3+JTq1AyYHafZjSFD6mMceVXGizUlP8oq8U2JPSw74FCrDiR8D6VcwK7yaZaM48ZdQNej8PsFuk4y2L0nRL+eRhxtI5gfegJZ+pGhDreAbOlN3LDW7isOGcRwKCTVb3ZumQ1VUO9Hr3INApUrt1uO5AN+Il5ybo8tnn/yviN5RAi+3rVhi9Vgz5QUycygM4PUxpd5ppnc5F6jEGLzsCYTFaWSKhaaF7F2FleiLHKxNGcL0Bb0Y0CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAb5G2gNhIBu+MVSnKoHQ8ipaFZJhMUyuY300VJupag+5RN57jaOLCsaqdv+Ua5LNnncROzRrIxv+xzxp91WdLqEeVPzt/MDun6tJFsTJaEdCJHhZfaniSZbRD6AnDRZiy/e24UmDmvJmJ7hXRKZzC2vMaUdRkc3b16xwCc4vAUP/EcBk66+XrIVtvScoRS1VkyBRbd2Zln8Sd0DRFmMozQ8IwMxyeARQJU1HcZTwx/R1/nwkeXh0HA+j9AK4PBqujEe7rYwG17/J4+qLNn2G3wTINztNefeHWiSH7XTV/sruXAwY1K2LKzjo323iIZwuQ3r6jSivr3JqEAGgQfwqPuQ==
b2a0a790-59c5-4142-9d77-44932b1e8620	client.secret.creation.time	1729708103
b2a0a790-59c5-4142-9d77-44932b1e8620	oauth2.device.authorization.grant.enabled	false
b2a0a790-59c5-4142-9d77-44932b1e8620	oidc.ciba.grant.enabled	false
b2a0a790-59c5-4142-9d77-44932b1e8620	backchannel.logout.session.required	true
b2a0a790-59c5-4142-9d77-44932b1e8620	backchannel.logout.revoke.offline.tokens	false
b2a0a790-59c5-4142-9d77-44932b1e8620	token.endpoint.auth.signing.alg	ES256
b2a0a790-59c5-4142-9d77-44932b1e8620	jwt.credential.certificate	MIICrzCCAZcCBgGSuqpy5jANBgkqhkiG9w0BAQsFADAbMRkwFwYDVQQDDBBvcGVuLWRpc2N1c3Npb25zMB4XDTI0MTAyMzE4MzQ0NVoXDTM0MTAyMzE4MzYyNVowGzEZMBcGA1UEAwwQb3Blbi1kaXNjdXNzaW9uczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKrPA+MzzfgJ5c7J5Y2xfiPnyUaaE2JiUYh6if2JkHfQoFDQM/FfHzyhCCRkJRYoyErWKB/9CXu+ObcnlH9tcGSIGTRMnZPj46CbAZ9uYdO9L5y1/QGlnlE0IKM9SNdvGp+c3DEJnGbfcG3A1XkAxzvuyx7KYIzfyDa4Va37B67iImzGbDUv1iJ1Ta1fZYldekHUFCbmOAoBO1JHsQb7ZZHjuRxhakp/JPoMccjsII3EIJM+1Zgw1OlgBhhsKT6x5zDilAKGZpFxNIbnniPdb6bMf8EK9ZBfArkuxMan3QDIwwLSDFQqhVU6L+zAYPuSIeKybrigkXAHjQgalXU2OsUCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEApxgpeU5ECMpxyMTqFaWCFdCWXof0NKLiUY57qAyqBmQIg0DU9d4DcuNf/HR9Knk0UKet9Y20UDcnCtm3T0toZNPi/hfyIC2gI28TryInPm9LaeuGH8ePIDTEIdX1Axu4h7S634qkf32qIplpUaZ8k70+yOUf0qSNu8jeJpeUIcF/1jYwdTM2Yu86LK8MieHuhW3/GSJkuAC8WOFjoNdEYOc6cOSzujWD25Ivu8q7CE21urEm0N09g+EZlwfRbwvq++8EUDoBd0fofJYlc9Qa+r6jTFr1JeKGLqFrBL8FJrbAYZXp8I8/l7+CbSv8CojU+SukpxhlrsMJni8go+71tg==
b2a0a790-59c5-4142-9d77-44932b1e8620	use.jwks.url	false
c630ba3c-66f1-4ffd-af22-675166784cba	oauth2.device.authorization.grant.enabled	false
c630ba3c-66f1-4ffd-af22-675166784cba	oidc.ciba.grant.enabled	false
c630ba3c-66f1-4ffd-af22-675166784cba	display.on.consent.screen	false
c630ba3c-66f1-4ffd-af22-675166784cba	backchannel.logout.session.required	true
c630ba3c-66f1-4ffd-af22-675166784cba	backchannel.logout.revoke.offline.tokens	false
c630ba3c-66f1-4ffd-af22-675166784cba	client.secret.creation.time	1729886289
a172934f-a9e5-458f-9483-7dfc4d6e1991	oauth2.device.authorization.grant.enabled	false
a172934f-a9e5-458f-9483-7dfc4d6e1991	oidc.ciba.grant.enabled	false
a172934f-a9e5-458f-9483-7dfc4d6e1991	display.on.consent.screen	false
a172934f-a9e5-458f-9483-7dfc4d6e1991	backchannel.logout.session.required	true
a172934f-a9e5-458f-9483-7dfc4d6e1991	backchannel.logout.revoke.offline.tokens	false
a172934f-a9e5-458f-9483-7dfc4d6e1991	client.secret.creation.time	1729886915
44cee68c-7ad2-465c-b7e4-67db09369afc	client.use.lightweight.access.token.enabled	true
a172934f-a9e5-458f-9483-7dfc4d6e1991	client.use.lightweight.access.token.enabled	true
d15c1b01-566a-4497-8bc9-3d9d87253ea1	client.use.lightweight.access.token.enabled	true
c630ba3c-66f1-4ffd-af22-675166784cba	client.use.lightweight.access.token.enabled	true
797f6274-dc0a-4a46-8098-9e25decee64f	client.use.lightweight.access.token.enabled	true
b4d77a2c-4fe5-4a83-b79f-a1b13b2e0132	client.use.lightweight.access.token.enabled	true
838fe32e-5500-4989-8194-c83c43aa5617	client.use.lightweight.access.token.enabled	true
9f878ecd-e756-43ca-8964-7858e766bb1a	client.use.lightweight.access.token.enabled	true
3d21aefb-1d20-4d27-9756-3cce60b5e958	client.use.lightweight.access.token.enabled	true
60340a1c-493f-4648-96ca-76635694dcec	client.use.lightweight.access.token.enabled	true
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	realm_client	false
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	display.on.consent.screen	false
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	post.logout.redirect.uris	https://api.learn.odl.local/*
a172934f-a9e5-458f-9483-7dfc4d6e1991	realm_client	false
a172934f-a9e5-458f-9483-7dfc4d6e1991	use.refresh.tokens	true
a172934f-a9e5-458f-9483-7dfc4d6e1991	client_credentials.use_refresh_token	false
a172934f-a9e5-458f-9483-7dfc4d6e1991	token.response.type.bearer.lower-case	false
a172934f-a9e5-458f-9483-7dfc4d6e1991	tls.client.certificate.bound.access.tokens	false
a172934f-a9e5-458f-9483-7dfc4d6e1991	dpop.bound.access.tokens	false
a172934f-a9e5-458f-9483-7dfc4d6e1991	require.pushed.authorization.requests	false
a172934f-a9e5-458f-9483-7dfc4d6e1991	client.introspection.response.allow.jwt.claim.enabled	false
a172934f-a9e5-458f-9483-7dfc4d6e1991	acr.loa.map	{}
473685f9-266f-4983-b2a5-156a6dc8468c	client.secret.creation.time	1740417580
473685f9-266f-4983-b2a5-156a6dc8468c	oauth2.device.authorization.grant.enabled	false
473685f9-266f-4983-b2a5-156a6dc8468c	oidc.ciba.grant.enabled	false
473685f9-266f-4983-b2a5-156a6dc8468c	backchannel.logout.session.required	true
473685f9-266f-4983-b2a5-156a6dc8468c	backchannel.logout.revoke.offline.tokens	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
ae1f5c94-4630-4846-acb8-200371e03893	offline_access	f493d84c-5308-498f-afec-c6f4cfffd553	OpenID Connect built-in scope: offline_access	openid-connect
e699d045-6556-4a8c-bb2b-eec123e7d607	role_list	f493d84c-5308-498f-afec-c6f4cfffd553	SAML role list	saml
5c2a597a-7480-4270-a86c-b1d02750ce60	profile	f493d84c-5308-498f-afec-c6f4cfffd553	OpenID Connect built-in scope: profile	openid-connect
379a3e26-dd12-4608-919a-e84602fcbeb1	email	f493d84c-5308-498f-afec-c6f4cfffd553	OpenID Connect built-in scope: email	openid-connect
637fac36-2646-4763-8913-3fb8679a77a4	address	f493d84c-5308-498f-afec-c6f4cfffd553	OpenID Connect built-in scope: address	openid-connect
040da43b-fd9e-47cf-8f0d-68f6ac7e6405	phone	f493d84c-5308-498f-afec-c6f4cfffd553	OpenID Connect built-in scope: phone	openid-connect
22b7f0e6-d566-4ac4-80ef-08ff08998740	roles	f493d84c-5308-498f-afec-c6f4cfffd553	OpenID Connect scope for add user roles to the access token	openid-connect
131703b4-a4fe-4c12-91e4-10aa029661e0	web-origins	f493d84c-5308-498f-afec-c6f4cfffd553	OpenID Connect scope for add allowed web origins to the access token	openid-connect
3419fbee-de34-42ab-813d-873b113fa211	microprofile-jwt	f493d84c-5308-498f-afec-c6f4cfffd553	Microprofile - JWT built-in scope	openid-connect
2ba22377-8a2c-4e8b-a860-b2ba519f38da	acr	f493d84c-5308-498f-afec-c6f4cfffd553	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
7610c75c-6b08-47eb-a96b-37b6d0ed8afb	offline_access	5760f0e0-8dc4-453f-b407-19c01025187d	OpenID Connect built-in scope: offline_access	openid-connect
5361170e-966a-40f4-b73f-da51458ba393	role_list	5760f0e0-8dc4-453f-b407-19c01025187d	SAML role list	saml
d7ce6ee2-6ed3-4a82-a5af-718704a6a888	profile	5760f0e0-8dc4-453f-b407-19c01025187d	OpenID Connect built-in scope: profile	openid-connect
18adc9ea-03c2-4910-a599-b60baf0926b2	email	5760f0e0-8dc4-453f-b407-19c01025187d	OpenID Connect built-in scope: email	openid-connect
b789a1aa-c97d-4fb1-b771-f2cbccafeae0	address	5760f0e0-8dc4-453f-b407-19c01025187d	OpenID Connect built-in scope: address	openid-connect
15db502e-270d-4bc5-98d8-786393ef0fed	phone	5760f0e0-8dc4-453f-b407-19c01025187d	OpenID Connect built-in scope: phone	openid-connect
4597c668-fa1b-478d-9843-5848285c470b	roles	5760f0e0-8dc4-453f-b407-19c01025187d	OpenID Connect scope for add user roles to the access token	openid-connect
52b1693f-4fc2-4ce5-9b30-95a8daef5fcd	web-origins	5760f0e0-8dc4-453f-b407-19c01025187d	OpenID Connect scope for add allowed web origins to the access token	openid-connect
667d3b9a-7261-460e-847f-d66563aae9e1	microprofile-jwt	5760f0e0-8dc4-453f-b407-19c01025187d	Microprofile - JWT built-in scope	openid-connect
cf860e2f-978d-469d-a18e-db7a4008b243	acr	5760f0e0-8dc4-453f-b407-19c01025187d	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
c72aafc0-5c09-4215-b3ae-eae56f417bd5	offline_access	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	OpenID Connect built-in scope: offline_access	openid-connect
eaae48b2-ecee-4938-a10a-2f9cbf593b5f	role_list	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	SAML role list	saml
cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3	profile	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	OpenID Connect built-in scope: profile	openid-connect
e1785efd-bf9a-446a-ad94-3d569bad7869	email	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	OpenID Connect built-in scope: email	openid-connect
5f554b86-1456-486d-b699-03c87529d428	address	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	OpenID Connect built-in scope: address	openid-connect
8b8d5b04-7e0f-43a8-8829-250ff789726a	phone	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	OpenID Connect built-in scope: phone	openid-connect
cda41599-0e60-42d6-b433-c15b126c1449	roles	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	OpenID Connect scope for add user roles to the access token	openid-connect
fb4f128c-0ba4-4d3c-80d9-65a0f3c4b2ec	web-origins	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	OpenID Connect scope for add allowed web origins to the access token	openid-connect
42b96f1a-dd81-47b8-b5b6-b4a0630b6350	microprofile-jwt	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	Microprofile - JWT built-in scope	openid-connect
6b8b6f76-1427-43b0-aed9-5ac7260ae1f1	acr	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
329657bf-094f-44e9-92ed-bf9aca3b7fbb	offline_access	b4825e08-1ac5-43e9-990a-7556e882153a	OpenID Connect built-in scope: offline_access	openid-connect
8561625f-4b07-445c-84ab-1640048627e2	role_list	b4825e08-1ac5-43e9-990a-7556e882153a	SAML role list	saml
e40d1da7-3987-4338-ad34-02ece0227ddd	profile	b4825e08-1ac5-43e9-990a-7556e882153a	OpenID Connect built-in scope: profile	openid-connect
7340bf61-1107-4848-a100-32981012bf8f	email	b4825e08-1ac5-43e9-990a-7556e882153a	OpenID Connect built-in scope: email	openid-connect
0b7b08ab-1f3c-44de-86e6-74d304e82697	address	b4825e08-1ac5-43e9-990a-7556e882153a	OpenID Connect built-in scope: address	openid-connect
23806095-5d19-4b3c-9977-076c75933e96	phone	b4825e08-1ac5-43e9-990a-7556e882153a	OpenID Connect built-in scope: phone	openid-connect
9e7c1bdc-270a-4b82-a59d-fa511fb71964	roles	b4825e08-1ac5-43e9-990a-7556e882153a	OpenID Connect scope for add user roles to the access token	openid-connect
4a255549-9040-4e49-b43b-1c7c017e424c	web-origins	b4825e08-1ac5-43e9-990a-7556e882153a	OpenID Connect scope for add allowed web origins to the access token	openid-connect
55be477a-ddcf-4a58-bd0b-d9f0f829593b	microprofile-jwt	b4825e08-1ac5-43e9-990a-7556e882153a	Microprofile - JWT built-in scope	openid-connect
4a8e7cf1-2d35-451b-9c98-67b3f61f1368	acr	b4825e08-1ac5-43e9-990a-7556e882153a	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
2bd5607e-74d2-4ead-94c8-5b0e4861b266	offline_access	2256a568-ee44-4cb6-88fa-488d343b1bf5	OpenID Connect built-in scope: offline_access	openid-connect
6c937d93-30b4-4bac-9406-4d11a6fdd1b2	role_list	2256a568-ee44-4cb6-88fa-488d343b1bf5	SAML role list	saml
5981264e-0c65-4ccc-b73c-894a11d9d5f5	profile	2256a568-ee44-4cb6-88fa-488d343b1bf5	OpenID Connect built-in scope: profile	openid-connect
1131f752-fbe3-4ca0-a3a4-8a009a537b5a	email	2256a568-ee44-4cb6-88fa-488d343b1bf5	OpenID Connect built-in scope: email	openid-connect
a499924a-2f59-4e14-a115-16aac030f760	address	2256a568-ee44-4cb6-88fa-488d343b1bf5	OpenID Connect built-in scope: address	openid-connect
30a3ec2f-b90a-4656-8d56-60466a47a79e	phone	2256a568-ee44-4cb6-88fa-488d343b1bf5	OpenID Connect built-in scope: phone	openid-connect
13abbec8-4f5f-4eab-97a8-9b5097559d9e	roles	2256a568-ee44-4cb6-88fa-488d343b1bf5	OpenID Connect scope for add user roles to the access token	openid-connect
40dc0180-628a-4c3a-b686-705d70183eda	web-origins	2256a568-ee44-4cb6-88fa-488d343b1bf5	OpenID Connect scope for add allowed web origins to the access token	openid-connect
20220de8-fcaf-4554-80ef-9078a66c844e	microprofile-jwt	2256a568-ee44-4cb6-88fa-488d343b1bf5	Microprofile - JWT built-in scope	openid-connect
99665abe-71db-4ae8-8e31-f4c782298c4a	acr	2256a568-ee44-4cb6-88fa-488d343b1bf5	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
49e25b5d-d76e-4051-9c7c-7a0b5c1052bd	ol-profile	5760f0e0-8dc4-453f-b407-19c01025187d	Open Learning Profile	openid-connect
9bb34a3b-605f-449f-9ed3-62abe31262f8	Test	f493d84c-5308-498f-afec-c6f4cfffd553		openid-connect
03b1a0a4-bd48-49a4-926b-de5f66803c2b	basic	5760f0e0-8dc4-453f-b407-19c01025187d	OpenID Connect scope for add all basic claims to the token	openid-connect
d93f07c8-4801-4b12-a63b-1085e3135be8	basic	f493d84c-5308-498f-afec-c6f4cfffd553	OpenID Connect scope for add all basic claims to the token	openid-connect
0673cf19-e51c-4979-be63-052f84c3c555	basic	2256a568-ee44-4cb6-88fa-488d343b1bf5	OpenID Connect scope for add all basic claims to the token	openid-connect
fa7619c7-fa00-4a0a-a46f-911d0bbc309b	basic	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	OpenID Connect scope for add all basic claims to the token	openid-connect
79cf0e01-9d2d-4d0e-95a5-a0884158d529	basic	b4825e08-1ac5-43e9-990a-7556e882153a	OpenID Connect scope for add all basic claims to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
ae1f5c94-4630-4846-acb8-200371e03893	true	display.on.consent.screen
ae1f5c94-4630-4846-acb8-200371e03893	${offlineAccessScopeConsentText}	consent.screen.text
e699d045-6556-4a8c-bb2b-eec123e7d607	true	display.on.consent.screen
e699d045-6556-4a8c-bb2b-eec123e7d607	${samlRoleListScopeConsentText}	consent.screen.text
5c2a597a-7480-4270-a86c-b1d02750ce60	true	display.on.consent.screen
5c2a597a-7480-4270-a86c-b1d02750ce60	${profileScopeConsentText}	consent.screen.text
5c2a597a-7480-4270-a86c-b1d02750ce60	true	include.in.token.scope
379a3e26-dd12-4608-919a-e84602fcbeb1	true	display.on.consent.screen
379a3e26-dd12-4608-919a-e84602fcbeb1	${emailScopeConsentText}	consent.screen.text
379a3e26-dd12-4608-919a-e84602fcbeb1	true	include.in.token.scope
637fac36-2646-4763-8913-3fb8679a77a4	true	display.on.consent.screen
637fac36-2646-4763-8913-3fb8679a77a4	${addressScopeConsentText}	consent.screen.text
637fac36-2646-4763-8913-3fb8679a77a4	true	include.in.token.scope
040da43b-fd9e-47cf-8f0d-68f6ac7e6405	true	display.on.consent.screen
040da43b-fd9e-47cf-8f0d-68f6ac7e6405	${phoneScopeConsentText}	consent.screen.text
040da43b-fd9e-47cf-8f0d-68f6ac7e6405	true	include.in.token.scope
22b7f0e6-d566-4ac4-80ef-08ff08998740	true	display.on.consent.screen
22b7f0e6-d566-4ac4-80ef-08ff08998740	${rolesScopeConsentText}	consent.screen.text
22b7f0e6-d566-4ac4-80ef-08ff08998740	false	include.in.token.scope
131703b4-a4fe-4c12-91e4-10aa029661e0	false	display.on.consent.screen
131703b4-a4fe-4c12-91e4-10aa029661e0		consent.screen.text
131703b4-a4fe-4c12-91e4-10aa029661e0	false	include.in.token.scope
3419fbee-de34-42ab-813d-873b113fa211	false	display.on.consent.screen
3419fbee-de34-42ab-813d-873b113fa211	true	include.in.token.scope
2ba22377-8a2c-4e8b-a860-b2ba519f38da	false	display.on.consent.screen
2ba22377-8a2c-4e8b-a860-b2ba519f38da	false	include.in.token.scope
7610c75c-6b08-47eb-a96b-37b6d0ed8afb	true	display.on.consent.screen
7610c75c-6b08-47eb-a96b-37b6d0ed8afb	${offlineAccessScopeConsentText}	consent.screen.text
5361170e-966a-40f4-b73f-da51458ba393	true	display.on.consent.screen
5361170e-966a-40f4-b73f-da51458ba393	${samlRoleListScopeConsentText}	consent.screen.text
d7ce6ee2-6ed3-4a82-a5af-718704a6a888	true	display.on.consent.screen
d7ce6ee2-6ed3-4a82-a5af-718704a6a888	${profileScopeConsentText}	consent.screen.text
d7ce6ee2-6ed3-4a82-a5af-718704a6a888	true	include.in.token.scope
18adc9ea-03c2-4910-a599-b60baf0926b2	true	display.on.consent.screen
18adc9ea-03c2-4910-a599-b60baf0926b2	${emailScopeConsentText}	consent.screen.text
18adc9ea-03c2-4910-a599-b60baf0926b2	true	include.in.token.scope
b789a1aa-c97d-4fb1-b771-f2cbccafeae0	true	display.on.consent.screen
b789a1aa-c97d-4fb1-b771-f2cbccafeae0	${addressScopeConsentText}	consent.screen.text
b789a1aa-c97d-4fb1-b771-f2cbccafeae0	true	include.in.token.scope
15db502e-270d-4bc5-98d8-786393ef0fed	true	display.on.consent.screen
15db502e-270d-4bc5-98d8-786393ef0fed	${phoneScopeConsentText}	consent.screen.text
15db502e-270d-4bc5-98d8-786393ef0fed	true	include.in.token.scope
4597c668-fa1b-478d-9843-5848285c470b	true	display.on.consent.screen
4597c668-fa1b-478d-9843-5848285c470b	${rolesScopeConsentText}	consent.screen.text
4597c668-fa1b-478d-9843-5848285c470b	false	include.in.token.scope
52b1693f-4fc2-4ce5-9b30-95a8daef5fcd	false	display.on.consent.screen
52b1693f-4fc2-4ce5-9b30-95a8daef5fcd		consent.screen.text
52b1693f-4fc2-4ce5-9b30-95a8daef5fcd	false	include.in.token.scope
667d3b9a-7261-460e-847f-d66563aae9e1	false	display.on.consent.screen
667d3b9a-7261-460e-847f-d66563aae9e1	true	include.in.token.scope
cf860e2f-978d-469d-a18e-db7a4008b243	false	display.on.consent.screen
cf860e2f-978d-469d-a18e-db7a4008b243	false	include.in.token.scope
c72aafc0-5c09-4215-b3ae-eae56f417bd5	true	display.on.consent.screen
c72aafc0-5c09-4215-b3ae-eae56f417bd5	${offlineAccessScopeConsentText}	consent.screen.text
eaae48b2-ecee-4938-a10a-2f9cbf593b5f	true	display.on.consent.screen
eaae48b2-ecee-4938-a10a-2f9cbf593b5f	${samlRoleListScopeConsentText}	consent.screen.text
cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3	true	display.on.consent.screen
cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3	${profileScopeConsentText}	consent.screen.text
cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3	true	include.in.token.scope
e1785efd-bf9a-446a-ad94-3d569bad7869	true	display.on.consent.screen
e1785efd-bf9a-446a-ad94-3d569bad7869	${emailScopeConsentText}	consent.screen.text
e1785efd-bf9a-446a-ad94-3d569bad7869	true	include.in.token.scope
5f554b86-1456-486d-b699-03c87529d428	true	display.on.consent.screen
5f554b86-1456-486d-b699-03c87529d428	${addressScopeConsentText}	consent.screen.text
5f554b86-1456-486d-b699-03c87529d428	true	include.in.token.scope
8b8d5b04-7e0f-43a8-8829-250ff789726a	true	display.on.consent.screen
8b8d5b04-7e0f-43a8-8829-250ff789726a	${phoneScopeConsentText}	consent.screen.text
8b8d5b04-7e0f-43a8-8829-250ff789726a	true	include.in.token.scope
cda41599-0e60-42d6-b433-c15b126c1449	true	display.on.consent.screen
cda41599-0e60-42d6-b433-c15b126c1449	${rolesScopeConsentText}	consent.screen.text
cda41599-0e60-42d6-b433-c15b126c1449	false	include.in.token.scope
fb4f128c-0ba4-4d3c-80d9-65a0f3c4b2ec	false	display.on.consent.screen
fb4f128c-0ba4-4d3c-80d9-65a0f3c4b2ec		consent.screen.text
fb4f128c-0ba4-4d3c-80d9-65a0f3c4b2ec	false	include.in.token.scope
42b96f1a-dd81-47b8-b5b6-b4a0630b6350	false	display.on.consent.screen
42b96f1a-dd81-47b8-b5b6-b4a0630b6350	true	include.in.token.scope
6b8b6f76-1427-43b0-aed9-5ac7260ae1f1	false	display.on.consent.screen
6b8b6f76-1427-43b0-aed9-5ac7260ae1f1	false	include.in.token.scope
329657bf-094f-44e9-92ed-bf9aca3b7fbb	true	display.on.consent.screen
329657bf-094f-44e9-92ed-bf9aca3b7fbb	${offlineAccessScopeConsentText}	consent.screen.text
8561625f-4b07-445c-84ab-1640048627e2	true	display.on.consent.screen
8561625f-4b07-445c-84ab-1640048627e2	${samlRoleListScopeConsentText}	consent.screen.text
e40d1da7-3987-4338-ad34-02ece0227ddd	true	display.on.consent.screen
e40d1da7-3987-4338-ad34-02ece0227ddd	${profileScopeConsentText}	consent.screen.text
e40d1da7-3987-4338-ad34-02ece0227ddd	true	include.in.token.scope
7340bf61-1107-4848-a100-32981012bf8f	true	display.on.consent.screen
7340bf61-1107-4848-a100-32981012bf8f	${emailScopeConsentText}	consent.screen.text
7340bf61-1107-4848-a100-32981012bf8f	true	include.in.token.scope
0b7b08ab-1f3c-44de-86e6-74d304e82697	true	display.on.consent.screen
0b7b08ab-1f3c-44de-86e6-74d304e82697	${addressScopeConsentText}	consent.screen.text
0b7b08ab-1f3c-44de-86e6-74d304e82697	true	include.in.token.scope
23806095-5d19-4b3c-9977-076c75933e96	true	display.on.consent.screen
23806095-5d19-4b3c-9977-076c75933e96	${phoneScopeConsentText}	consent.screen.text
23806095-5d19-4b3c-9977-076c75933e96	true	include.in.token.scope
9e7c1bdc-270a-4b82-a59d-fa511fb71964	true	display.on.consent.screen
9e7c1bdc-270a-4b82-a59d-fa511fb71964	${rolesScopeConsentText}	consent.screen.text
9e7c1bdc-270a-4b82-a59d-fa511fb71964	false	include.in.token.scope
4a255549-9040-4e49-b43b-1c7c017e424c	false	display.on.consent.screen
4a255549-9040-4e49-b43b-1c7c017e424c		consent.screen.text
4a255549-9040-4e49-b43b-1c7c017e424c	false	include.in.token.scope
55be477a-ddcf-4a58-bd0b-d9f0f829593b	false	display.on.consent.screen
55be477a-ddcf-4a58-bd0b-d9f0f829593b	true	include.in.token.scope
4a8e7cf1-2d35-451b-9c98-67b3f61f1368	false	display.on.consent.screen
4a8e7cf1-2d35-451b-9c98-67b3f61f1368	false	include.in.token.scope
2bd5607e-74d2-4ead-94c8-5b0e4861b266	true	display.on.consent.screen
2bd5607e-74d2-4ead-94c8-5b0e4861b266	${offlineAccessScopeConsentText}	consent.screen.text
6c937d93-30b4-4bac-9406-4d11a6fdd1b2	true	display.on.consent.screen
6c937d93-30b4-4bac-9406-4d11a6fdd1b2	${samlRoleListScopeConsentText}	consent.screen.text
5981264e-0c65-4ccc-b73c-894a11d9d5f5	true	display.on.consent.screen
5981264e-0c65-4ccc-b73c-894a11d9d5f5	${profileScopeConsentText}	consent.screen.text
5981264e-0c65-4ccc-b73c-894a11d9d5f5	true	include.in.token.scope
1131f752-fbe3-4ca0-a3a4-8a009a537b5a	true	display.on.consent.screen
1131f752-fbe3-4ca0-a3a4-8a009a537b5a	${emailScopeConsentText}	consent.screen.text
1131f752-fbe3-4ca0-a3a4-8a009a537b5a	true	include.in.token.scope
a499924a-2f59-4e14-a115-16aac030f760	true	display.on.consent.screen
a499924a-2f59-4e14-a115-16aac030f760	${addressScopeConsentText}	consent.screen.text
a499924a-2f59-4e14-a115-16aac030f760	true	include.in.token.scope
30a3ec2f-b90a-4656-8d56-60466a47a79e	true	display.on.consent.screen
30a3ec2f-b90a-4656-8d56-60466a47a79e	${phoneScopeConsentText}	consent.screen.text
30a3ec2f-b90a-4656-8d56-60466a47a79e	true	include.in.token.scope
13abbec8-4f5f-4eab-97a8-9b5097559d9e	true	display.on.consent.screen
13abbec8-4f5f-4eab-97a8-9b5097559d9e	${rolesScopeConsentText}	consent.screen.text
13abbec8-4f5f-4eab-97a8-9b5097559d9e	false	include.in.token.scope
40dc0180-628a-4c3a-b686-705d70183eda	false	display.on.consent.screen
40dc0180-628a-4c3a-b686-705d70183eda		consent.screen.text
40dc0180-628a-4c3a-b686-705d70183eda	false	include.in.token.scope
20220de8-fcaf-4554-80ef-9078a66c844e	false	display.on.consent.screen
20220de8-fcaf-4554-80ef-9078a66c844e	true	include.in.token.scope
99665abe-71db-4ae8-8e31-f4c782298c4a	false	display.on.consent.screen
99665abe-71db-4ae8-8e31-f4c782298c4a	false	include.in.token.scope
49e25b5d-d76e-4051-9c7c-7a0b5c1052bd	true	display.on.consent.screen
49e25b5d-d76e-4051-9c7c-7a0b5c1052bd		consent.screen.text
49e25b5d-d76e-4051-9c7c-7a0b5c1052bd	false	include.in.token.scope
49e25b5d-d76e-4051-9c7c-7a0b5c1052bd		gui.order
9bb34a3b-605f-449f-9ed3-62abe31262f8	true	display.on.consent.screen
9bb34a3b-605f-449f-9ed3-62abe31262f8		consent.screen.text
9bb34a3b-605f-449f-9ed3-62abe31262f8	false	include.in.token.scope
9bb34a3b-605f-449f-9ed3-62abe31262f8		gui.order
03b1a0a4-bd48-49a4-926b-de5f66803c2b	false	display.on.consent.screen
03b1a0a4-bd48-49a4-926b-de5f66803c2b	false	include.in.token.scope
d93f07c8-4801-4b12-a63b-1085e3135be8	false	display.on.consent.screen
d93f07c8-4801-4b12-a63b-1085e3135be8	false	include.in.token.scope
0673cf19-e51c-4979-be63-052f84c3c555	false	display.on.consent.screen
0673cf19-e51c-4979-be63-052f84c3c555	false	include.in.token.scope
fa7619c7-fa00-4a0a-a46f-911d0bbc309b	false	display.on.consent.screen
fa7619c7-fa00-4a0a-a46f-911d0bbc309b	false	include.in.token.scope
79cf0e01-9d2d-4d0e-95a5-a0884158d529	false	display.on.consent.screen
79cf0e01-9d2d-4d0e-95a5-a0884158d529	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
853be0b2-ad1a-4116-aff3-c10f318e9ad5	131703b4-a4fe-4c12-91e4-10aa029661e0	t
853be0b2-ad1a-4116-aff3-c10f318e9ad5	379a3e26-dd12-4608-919a-e84602fcbeb1	t
853be0b2-ad1a-4116-aff3-c10f318e9ad5	2ba22377-8a2c-4e8b-a860-b2ba519f38da	t
853be0b2-ad1a-4116-aff3-c10f318e9ad5	5c2a597a-7480-4270-a86c-b1d02750ce60	t
853be0b2-ad1a-4116-aff3-c10f318e9ad5	22b7f0e6-d566-4ac4-80ef-08ff08998740	t
853be0b2-ad1a-4116-aff3-c10f318e9ad5	040da43b-fd9e-47cf-8f0d-68f6ac7e6405	f
853be0b2-ad1a-4116-aff3-c10f318e9ad5	637fac36-2646-4763-8913-3fb8679a77a4	f
853be0b2-ad1a-4116-aff3-c10f318e9ad5	ae1f5c94-4630-4846-acb8-200371e03893	f
853be0b2-ad1a-4116-aff3-c10f318e9ad5	3419fbee-de34-42ab-813d-873b113fa211	f
b43612df-590a-4e25-a38f-2f0de881be8f	131703b4-a4fe-4c12-91e4-10aa029661e0	t
b43612df-590a-4e25-a38f-2f0de881be8f	379a3e26-dd12-4608-919a-e84602fcbeb1	t
b43612df-590a-4e25-a38f-2f0de881be8f	2ba22377-8a2c-4e8b-a860-b2ba519f38da	t
b43612df-590a-4e25-a38f-2f0de881be8f	5c2a597a-7480-4270-a86c-b1d02750ce60	t
b43612df-590a-4e25-a38f-2f0de881be8f	22b7f0e6-d566-4ac4-80ef-08ff08998740	t
b43612df-590a-4e25-a38f-2f0de881be8f	040da43b-fd9e-47cf-8f0d-68f6ac7e6405	f
b43612df-590a-4e25-a38f-2f0de881be8f	637fac36-2646-4763-8913-3fb8679a77a4	f
b43612df-590a-4e25-a38f-2f0de881be8f	ae1f5c94-4630-4846-acb8-200371e03893	f
b43612df-590a-4e25-a38f-2f0de881be8f	3419fbee-de34-42ab-813d-873b113fa211	f
c630ba3c-66f1-4ffd-af22-675166784cba	131703b4-a4fe-4c12-91e4-10aa029661e0	t
c630ba3c-66f1-4ffd-af22-675166784cba	379a3e26-dd12-4608-919a-e84602fcbeb1	t
c630ba3c-66f1-4ffd-af22-675166784cba	2ba22377-8a2c-4e8b-a860-b2ba519f38da	t
c630ba3c-66f1-4ffd-af22-675166784cba	5c2a597a-7480-4270-a86c-b1d02750ce60	t
c630ba3c-66f1-4ffd-af22-675166784cba	22b7f0e6-d566-4ac4-80ef-08ff08998740	t
c630ba3c-66f1-4ffd-af22-675166784cba	040da43b-fd9e-47cf-8f0d-68f6ac7e6405	f
c630ba3c-66f1-4ffd-af22-675166784cba	637fac36-2646-4763-8913-3fb8679a77a4	f
c630ba3c-66f1-4ffd-af22-675166784cba	ae1f5c94-4630-4846-acb8-200371e03893	f
c630ba3c-66f1-4ffd-af22-675166784cba	3419fbee-de34-42ab-813d-873b113fa211	f
357be594-815d-408b-b337-1e7bb854eb1a	131703b4-a4fe-4c12-91e4-10aa029661e0	t
357be594-815d-408b-b337-1e7bb854eb1a	379a3e26-dd12-4608-919a-e84602fcbeb1	t
357be594-815d-408b-b337-1e7bb854eb1a	2ba22377-8a2c-4e8b-a860-b2ba519f38da	t
357be594-815d-408b-b337-1e7bb854eb1a	5c2a597a-7480-4270-a86c-b1d02750ce60	t
357be594-815d-408b-b337-1e7bb854eb1a	22b7f0e6-d566-4ac4-80ef-08ff08998740	t
357be594-815d-408b-b337-1e7bb854eb1a	040da43b-fd9e-47cf-8f0d-68f6ac7e6405	f
357be594-815d-408b-b337-1e7bb854eb1a	637fac36-2646-4763-8913-3fb8679a77a4	f
357be594-815d-408b-b337-1e7bb854eb1a	ae1f5c94-4630-4846-acb8-200371e03893	f
357be594-815d-408b-b337-1e7bb854eb1a	3419fbee-de34-42ab-813d-873b113fa211	f
80b8e421-a8d0-48c7-a471-5bdddf12de86	131703b4-a4fe-4c12-91e4-10aa029661e0	t
80b8e421-a8d0-48c7-a471-5bdddf12de86	379a3e26-dd12-4608-919a-e84602fcbeb1	t
80b8e421-a8d0-48c7-a471-5bdddf12de86	2ba22377-8a2c-4e8b-a860-b2ba519f38da	t
80b8e421-a8d0-48c7-a471-5bdddf12de86	5c2a597a-7480-4270-a86c-b1d02750ce60	t
80b8e421-a8d0-48c7-a471-5bdddf12de86	22b7f0e6-d566-4ac4-80ef-08ff08998740	t
80b8e421-a8d0-48c7-a471-5bdddf12de86	040da43b-fd9e-47cf-8f0d-68f6ac7e6405	f
80b8e421-a8d0-48c7-a471-5bdddf12de86	637fac36-2646-4763-8913-3fb8679a77a4	f
80b8e421-a8d0-48c7-a471-5bdddf12de86	ae1f5c94-4630-4846-acb8-200371e03893	f
80b8e421-a8d0-48c7-a471-5bdddf12de86	3419fbee-de34-42ab-813d-873b113fa211	f
d15c1b01-566a-4497-8bc9-3d9d87253ea1	131703b4-a4fe-4c12-91e4-10aa029661e0	t
d15c1b01-566a-4497-8bc9-3d9d87253ea1	379a3e26-dd12-4608-919a-e84602fcbeb1	t
d15c1b01-566a-4497-8bc9-3d9d87253ea1	2ba22377-8a2c-4e8b-a860-b2ba519f38da	t
d15c1b01-566a-4497-8bc9-3d9d87253ea1	5c2a597a-7480-4270-a86c-b1d02750ce60	t
d15c1b01-566a-4497-8bc9-3d9d87253ea1	22b7f0e6-d566-4ac4-80ef-08ff08998740	t
d15c1b01-566a-4497-8bc9-3d9d87253ea1	040da43b-fd9e-47cf-8f0d-68f6ac7e6405	f
d15c1b01-566a-4497-8bc9-3d9d87253ea1	637fac36-2646-4763-8913-3fb8679a77a4	f
d15c1b01-566a-4497-8bc9-3d9d87253ea1	ae1f5c94-4630-4846-acb8-200371e03893	f
d15c1b01-566a-4497-8bc9-3d9d87253ea1	3419fbee-de34-42ab-813d-873b113fa211	f
37ffb6d7-4e38-4e14-a47f-6a5a85276f55	4597c668-fa1b-478d-9843-5848285c470b	t
37ffb6d7-4e38-4e14-a47f-6a5a85276f55	cf860e2f-978d-469d-a18e-db7a4008b243	t
37ffb6d7-4e38-4e14-a47f-6a5a85276f55	d7ce6ee2-6ed3-4a82-a5af-718704a6a888	t
37ffb6d7-4e38-4e14-a47f-6a5a85276f55	18adc9ea-03c2-4910-a599-b60baf0926b2	t
37ffb6d7-4e38-4e14-a47f-6a5a85276f55	52b1693f-4fc2-4ce5-9b30-95a8daef5fcd	t
37ffb6d7-4e38-4e14-a47f-6a5a85276f55	7610c75c-6b08-47eb-a96b-37b6d0ed8afb	f
37ffb6d7-4e38-4e14-a47f-6a5a85276f55	15db502e-270d-4bc5-98d8-786393ef0fed	f
37ffb6d7-4e38-4e14-a47f-6a5a85276f55	667d3b9a-7261-460e-847f-d66563aae9e1	f
37ffb6d7-4e38-4e14-a47f-6a5a85276f55	b789a1aa-c97d-4fb1-b771-f2cbccafeae0	f
0eecf1c0-c127-4ca2-9327-459efbb9c681	4597c668-fa1b-478d-9843-5848285c470b	t
0eecf1c0-c127-4ca2-9327-459efbb9c681	cf860e2f-978d-469d-a18e-db7a4008b243	t
0eecf1c0-c127-4ca2-9327-459efbb9c681	d7ce6ee2-6ed3-4a82-a5af-718704a6a888	t
0eecf1c0-c127-4ca2-9327-459efbb9c681	18adc9ea-03c2-4910-a599-b60baf0926b2	t
0eecf1c0-c127-4ca2-9327-459efbb9c681	52b1693f-4fc2-4ce5-9b30-95a8daef5fcd	t
0eecf1c0-c127-4ca2-9327-459efbb9c681	7610c75c-6b08-47eb-a96b-37b6d0ed8afb	f
0eecf1c0-c127-4ca2-9327-459efbb9c681	15db502e-270d-4bc5-98d8-786393ef0fed	f
0eecf1c0-c127-4ca2-9327-459efbb9c681	667d3b9a-7261-460e-847f-d66563aae9e1	f
0eecf1c0-c127-4ca2-9327-459efbb9c681	b789a1aa-c97d-4fb1-b771-f2cbccafeae0	f
a172934f-a9e5-458f-9483-7dfc4d6e1991	4597c668-fa1b-478d-9843-5848285c470b	t
a172934f-a9e5-458f-9483-7dfc4d6e1991	cf860e2f-978d-469d-a18e-db7a4008b243	t
a172934f-a9e5-458f-9483-7dfc4d6e1991	d7ce6ee2-6ed3-4a82-a5af-718704a6a888	t
a172934f-a9e5-458f-9483-7dfc4d6e1991	18adc9ea-03c2-4910-a599-b60baf0926b2	t
a172934f-a9e5-458f-9483-7dfc4d6e1991	52b1693f-4fc2-4ce5-9b30-95a8daef5fcd	t
a172934f-a9e5-458f-9483-7dfc4d6e1991	7610c75c-6b08-47eb-a96b-37b6d0ed8afb	f
a172934f-a9e5-458f-9483-7dfc4d6e1991	15db502e-270d-4bc5-98d8-786393ef0fed	f
a172934f-a9e5-458f-9483-7dfc4d6e1991	667d3b9a-7261-460e-847f-d66563aae9e1	f
a172934f-a9e5-458f-9483-7dfc4d6e1991	b789a1aa-c97d-4fb1-b771-f2cbccafeae0	f
f56304c4-598f-4c59-8424-c762dc578149	4597c668-fa1b-478d-9843-5848285c470b	t
f56304c4-598f-4c59-8424-c762dc578149	cf860e2f-978d-469d-a18e-db7a4008b243	t
f56304c4-598f-4c59-8424-c762dc578149	d7ce6ee2-6ed3-4a82-a5af-718704a6a888	t
f56304c4-598f-4c59-8424-c762dc578149	18adc9ea-03c2-4910-a599-b60baf0926b2	t
f56304c4-598f-4c59-8424-c762dc578149	52b1693f-4fc2-4ce5-9b30-95a8daef5fcd	t
f56304c4-598f-4c59-8424-c762dc578149	7610c75c-6b08-47eb-a96b-37b6d0ed8afb	f
f56304c4-598f-4c59-8424-c762dc578149	15db502e-270d-4bc5-98d8-786393ef0fed	f
f56304c4-598f-4c59-8424-c762dc578149	667d3b9a-7261-460e-847f-d66563aae9e1	f
f56304c4-598f-4c59-8424-c762dc578149	b789a1aa-c97d-4fb1-b771-f2cbccafeae0	f
0f393319-fded-4b0c-9711-a9ca8eeba66d	4597c668-fa1b-478d-9843-5848285c470b	t
0f393319-fded-4b0c-9711-a9ca8eeba66d	cf860e2f-978d-469d-a18e-db7a4008b243	t
0f393319-fded-4b0c-9711-a9ca8eeba66d	d7ce6ee2-6ed3-4a82-a5af-718704a6a888	t
0f393319-fded-4b0c-9711-a9ca8eeba66d	18adc9ea-03c2-4910-a599-b60baf0926b2	t
0f393319-fded-4b0c-9711-a9ca8eeba66d	52b1693f-4fc2-4ce5-9b30-95a8daef5fcd	t
0f393319-fded-4b0c-9711-a9ca8eeba66d	7610c75c-6b08-47eb-a96b-37b6d0ed8afb	f
0f393319-fded-4b0c-9711-a9ca8eeba66d	15db502e-270d-4bc5-98d8-786393ef0fed	f
0f393319-fded-4b0c-9711-a9ca8eeba66d	667d3b9a-7261-460e-847f-d66563aae9e1	f
0f393319-fded-4b0c-9711-a9ca8eeba66d	b789a1aa-c97d-4fb1-b771-f2cbccafeae0	f
44cee68c-7ad2-465c-b7e4-67db09369afc	4597c668-fa1b-478d-9843-5848285c470b	t
44cee68c-7ad2-465c-b7e4-67db09369afc	cf860e2f-978d-469d-a18e-db7a4008b243	t
44cee68c-7ad2-465c-b7e4-67db09369afc	d7ce6ee2-6ed3-4a82-a5af-718704a6a888	t
44cee68c-7ad2-465c-b7e4-67db09369afc	18adc9ea-03c2-4910-a599-b60baf0926b2	t
44cee68c-7ad2-465c-b7e4-67db09369afc	52b1693f-4fc2-4ce5-9b30-95a8daef5fcd	t
44cee68c-7ad2-465c-b7e4-67db09369afc	7610c75c-6b08-47eb-a96b-37b6d0ed8afb	f
44cee68c-7ad2-465c-b7e4-67db09369afc	15db502e-270d-4bc5-98d8-786393ef0fed	f
44cee68c-7ad2-465c-b7e4-67db09369afc	667d3b9a-7261-460e-847f-d66563aae9e1	f
44cee68c-7ad2-465c-b7e4-67db09369afc	b789a1aa-c97d-4fb1-b771-f2cbccafeae0	f
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	4597c668-fa1b-478d-9843-5848285c470b	t
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	cf860e2f-978d-469d-a18e-db7a4008b243	t
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	d7ce6ee2-6ed3-4a82-a5af-718704a6a888	t
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	18adc9ea-03c2-4910-a599-b60baf0926b2	t
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	52b1693f-4fc2-4ce5-9b30-95a8daef5fcd	t
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	7610c75c-6b08-47eb-a96b-37b6d0ed8afb	f
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	15db502e-270d-4bc5-98d8-786393ef0fed	f
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	667d3b9a-7261-460e-847f-d66563aae9e1	f
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	b789a1aa-c97d-4fb1-b771-f2cbccafeae0	f
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	4597c668-fa1b-478d-9843-5848285c470b	t
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	cf860e2f-978d-469d-a18e-db7a4008b243	t
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	d7ce6ee2-6ed3-4a82-a5af-718704a6a888	t
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	18adc9ea-03c2-4910-a599-b60baf0926b2	t
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	52b1693f-4fc2-4ce5-9b30-95a8daef5fcd	t
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	7610c75c-6b08-47eb-a96b-37b6d0ed8afb	f
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	15db502e-270d-4bc5-98d8-786393ef0fed	f
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	667d3b9a-7261-460e-847f-d66563aae9e1	f
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	b789a1aa-c97d-4fb1-b771-f2cbccafeae0	f
20ab4f86-015d-4d03-9ca5-de7ab82277bf	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3	t
20ab4f86-015d-4d03-9ca5-de7ab82277bf	fb4f128c-0ba4-4d3c-80d9-65a0f3c4b2ec	t
20ab4f86-015d-4d03-9ca5-de7ab82277bf	e1785efd-bf9a-446a-ad94-3d569bad7869	t
20ab4f86-015d-4d03-9ca5-de7ab82277bf	cda41599-0e60-42d6-b433-c15b126c1449	t
20ab4f86-015d-4d03-9ca5-de7ab82277bf	6b8b6f76-1427-43b0-aed9-5ac7260ae1f1	t
20ab4f86-015d-4d03-9ca5-de7ab82277bf	5f554b86-1456-486d-b699-03c87529d428	f
20ab4f86-015d-4d03-9ca5-de7ab82277bf	42b96f1a-dd81-47b8-b5b6-b4a0630b6350	f
20ab4f86-015d-4d03-9ca5-de7ab82277bf	c72aafc0-5c09-4215-b3ae-eae56f417bd5	f
20ab4f86-015d-4d03-9ca5-de7ab82277bf	8b8d5b04-7e0f-43a8-8829-250ff789726a	f
f99d9cb1-4be5-4cd0-8061-e223ad552b74	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3	t
f99d9cb1-4be5-4cd0-8061-e223ad552b74	fb4f128c-0ba4-4d3c-80d9-65a0f3c4b2ec	t
f99d9cb1-4be5-4cd0-8061-e223ad552b74	e1785efd-bf9a-446a-ad94-3d569bad7869	t
f99d9cb1-4be5-4cd0-8061-e223ad552b74	cda41599-0e60-42d6-b433-c15b126c1449	t
f99d9cb1-4be5-4cd0-8061-e223ad552b74	6b8b6f76-1427-43b0-aed9-5ac7260ae1f1	t
f99d9cb1-4be5-4cd0-8061-e223ad552b74	5f554b86-1456-486d-b699-03c87529d428	f
f99d9cb1-4be5-4cd0-8061-e223ad552b74	42b96f1a-dd81-47b8-b5b6-b4a0630b6350	f
f99d9cb1-4be5-4cd0-8061-e223ad552b74	c72aafc0-5c09-4215-b3ae-eae56f417bd5	f
f99d9cb1-4be5-4cd0-8061-e223ad552b74	8b8d5b04-7e0f-43a8-8829-250ff789726a	f
9f878ecd-e756-43ca-8964-7858e766bb1a	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3	t
9f878ecd-e756-43ca-8964-7858e766bb1a	fb4f128c-0ba4-4d3c-80d9-65a0f3c4b2ec	t
9f878ecd-e756-43ca-8964-7858e766bb1a	e1785efd-bf9a-446a-ad94-3d569bad7869	t
9f878ecd-e756-43ca-8964-7858e766bb1a	cda41599-0e60-42d6-b433-c15b126c1449	t
9f878ecd-e756-43ca-8964-7858e766bb1a	6b8b6f76-1427-43b0-aed9-5ac7260ae1f1	t
9f878ecd-e756-43ca-8964-7858e766bb1a	5f554b86-1456-486d-b699-03c87529d428	f
9f878ecd-e756-43ca-8964-7858e766bb1a	42b96f1a-dd81-47b8-b5b6-b4a0630b6350	f
9f878ecd-e756-43ca-8964-7858e766bb1a	c72aafc0-5c09-4215-b3ae-eae56f417bd5	f
9f878ecd-e756-43ca-8964-7858e766bb1a	8b8d5b04-7e0f-43a8-8829-250ff789726a	f
b864b55f-9586-4738-b061-ab0bec85b58c	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3	t
b864b55f-9586-4738-b061-ab0bec85b58c	fb4f128c-0ba4-4d3c-80d9-65a0f3c4b2ec	t
b864b55f-9586-4738-b061-ab0bec85b58c	e1785efd-bf9a-446a-ad94-3d569bad7869	t
b864b55f-9586-4738-b061-ab0bec85b58c	cda41599-0e60-42d6-b433-c15b126c1449	t
b864b55f-9586-4738-b061-ab0bec85b58c	6b8b6f76-1427-43b0-aed9-5ac7260ae1f1	t
b864b55f-9586-4738-b061-ab0bec85b58c	5f554b86-1456-486d-b699-03c87529d428	f
b864b55f-9586-4738-b061-ab0bec85b58c	42b96f1a-dd81-47b8-b5b6-b4a0630b6350	f
b864b55f-9586-4738-b061-ab0bec85b58c	c72aafc0-5c09-4215-b3ae-eae56f417bd5	f
b864b55f-9586-4738-b061-ab0bec85b58c	8b8d5b04-7e0f-43a8-8829-250ff789726a	f
7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3	t
7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	fb4f128c-0ba4-4d3c-80d9-65a0f3c4b2ec	t
7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	e1785efd-bf9a-446a-ad94-3d569bad7869	t
7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	cda41599-0e60-42d6-b433-c15b126c1449	t
7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	6b8b6f76-1427-43b0-aed9-5ac7260ae1f1	t
7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	5f554b86-1456-486d-b699-03c87529d428	f
7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	42b96f1a-dd81-47b8-b5b6-b4a0630b6350	f
7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	c72aafc0-5c09-4215-b3ae-eae56f417bd5	f
7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	8b8d5b04-7e0f-43a8-8829-250ff789726a	f
838fe32e-5500-4989-8194-c83c43aa5617	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3	t
838fe32e-5500-4989-8194-c83c43aa5617	fb4f128c-0ba4-4d3c-80d9-65a0f3c4b2ec	t
838fe32e-5500-4989-8194-c83c43aa5617	e1785efd-bf9a-446a-ad94-3d569bad7869	t
838fe32e-5500-4989-8194-c83c43aa5617	cda41599-0e60-42d6-b433-c15b126c1449	t
838fe32e-5500-4989-8194-c83c43aa5617	6b8b6f76-1427-43b0-aed9-5ac7260ae1f1	t
838fe32e-5500-4989-8194-c83c43aa5617	5f554b86-1456-486d-b699-03c87529d428	f
838fe32e-5500-4989-8194-c83c43aa5617	42b96f1a-dd81-47b8-b5b6-b4a0630b6350	f
838fe32e-5500-4989-8194-c83c43aa5617	c72aafc0-5c09-4215-b3ae-eae56f417bd5	f
838fe32e-5500-4989-8194-c83c43aa5617	8b8d5b04-7e0f-43a8-8829-250ff789726a	f
df1eed9b-9772-4844-bf38-063fcfbf2c71	9e7c1bdc-270a-4b82-a59d-fa511fb71964	t
df1eed9b-9772-4844-bf38-063fcfbf2c71	4a8e7cf1-2d35-451b-9c98-67b3f61f1368	t
df1eed9b-9772-4844-bf38-063fcfbf2c71	e40d1da7-3987-4338-ad34-02ece0227ddd	t
df1eed9b-9772-4844-bf38-063fcfbf2c71	7340bf61-1107-4848-a100-32981012bf8f	t
df1eed9b-9772-4844-bf38-063fcfbf2c71	4a255549-9040-4e49-b43b-1c7c017e424c	t
df1eed9b-9772-4844-bf38-063fcfbf2c71	23806095-5d19-4b3c-9977-076c75933e96	f
df1eed9b-9772-4844-bf38-063fcfbf2c71	55be477a-ddcf-4a58-bd0b-d9f0f829593b	f
df1eed9b-9772-4844-bf38-063fcfbf2c71	329657bf-094f-44e9-92ed-bf9aca3b7fbb	f
df1eed9b-9772-4844-bf38-063fcfbf2c71	0b7b08ab-1f3c-44de-86e6-74d304e82697	f
bb4d8a91-43ec-4a96-8bec-800f920c8826	9e7c1bdc-270a-4b82-a59d-fa511fb71964	t
bb4d8a91-43ec-4a96-8bec-800f920c8826	4a8e7cf1-2d35-451b-9c98-67b3f61f1368	t
bb4d8a91-43ec-4a96-8bec-800f920c8826	e40d1da7-3987-4338-ad34-02ece0227ddd	t
bb4d8a91-43ec-4a96-8bec-800f920c8826	7340bf61-1107-4848-a100-32981012bf8f	t
bb4d8a91-43ec-4a96-8bec-800f920c8826	4a255549-9040-4e49-b43b-1c7c017e424c	t
bb4d8a91-43ec-4a96-8bec-800f920c8826	23806095-5d19-4b3c-9977-076c75933e96	f
bb4d8a91-43ec-4a96-8bec-800f920c8826	55be477a-ddcf-4a58-bd0b-d9f0f829593b	f
bb4d8a91-43ec-4a96-8bec-800f920c8826	329657bf-094f-44e9-92ed-bf9aca3b7fbb	f
bb4d8a91-43ec-4a96-8bec-800f920c8826	0b7b08ab-1f3c-44de-86e6-74d304e82697	f
60340a1c-493f-4648-96ca-76635694dcec	9e7c1bdc-270a-4b82-a59d-fa511fb71964	t
60340a1c-493f-4648-96ca-76635694dcec	4a8e7cf1-2d35-451b-9c98-67b3f61f1368	t
60340a1c-493f-4648-96ca-76635694dcec	e40d1da7-3987-4338-ad34-02ece0227ddd	t
60340a1c-493f-4648-96ca-76635694dcec	7340bf61-1107-4848-a100-32981012bf8f	t
60340a1c-493f-4648-96ca-76635694dcec	4a255549-9040-4e49-b43b-1c7c017e424c	t
60340a1c-493f-4648-96ca-76635694dcec	23806095-5d19-4b3c-9977-076c75933e96	f
60340a1c-493f-4648-96ca-76635694dcec	55be477a-ddcf-4a58-bd0b-d9f0f829593b	f
60340a1c-493f-4648-96ca-76635694dcec	329657bf-094f-44e9-92ed-bf9aca3b7fbb	f
60340a1c-493f-4648-96ca-76635694dcec	0b7b08ab-1f3c-44de-86e6-74d304e82697	f
9e559194-7abb-42a9-9aa5-f689dafa911d	9e7c1bdc-270a-4b82-a59d-fa511fb71964	t
9e559194-7abb-42a9-9aa5-f689dafa911d	4a8e7cf1-2d35-451b-9c98-67b3f61f1368	t
9e559194-7abb-42a9-9aa5-f689dafa911d	e40d1da7-3987-4338-ad34-02ece0227ddd	t
9e559194-7abb-42a9-9aa5-f689dafa911d	7340bf61-1107-4848-a100-32981012bf8f	t
9e559194-7abb-42a9-9aa5-f689dafa911d	4a255549-9040-4e49-b43b-1c7c017e424c	t
9e559194-7abb-42a9-9aa5-f689dafa911d	23806095-5d19-4b3c-9977-076c75933e96	f
9e559194-7abb-42a9-9aa5-f689dafa911d	55be477a-ddcf-4a58-bd0b-d9f0f829593b	f
9e559194-7abb-42a9-9aa5-f689dafa911d	329657bf-094f-44e9-92ed-bf9aca3b7fbb	f
9e559194-7abb-42a9-9aa5-f689dafa911d	0b7b08ab-1f3c-44de-86e6-74d304e82697	f
2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	9e7c1bdc-270a-4b82-a59d-fa511fb71964	t
2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	4a8e7cf1-2d35-451b-9c98-67b3f61f1368	t
2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	e40d1da7-3987-4338-ad34-02ece0227ddd	t
2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	7340bf61-1107-4848-a100-32981012bf8f	t
2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	4a255549-9040-4e49-b43b-1c7c017e424c	t
2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	23806095-5d19-4b3c-9977-076c75933e96	f
2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	55be477a-ddcf-4a58-bd0b-d9f0f829593b	f
2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	329657bf-094f-44e9-92ed-bf9aca3b7fbb	f
2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	0b7b08ab-1f3c-44de-86e6-74d304e82697	f
3d21aefb-1d20-4d27-9756-3cce60b5e958	9e7c1bdc-270a-4b82-a59d-fa511fb71964	t
3d21aefb-1d20-4d27-9756-3cce60b5e958	4a8e7cf1-2d35-451b-9c98-67b3f61f1368	t
3d21aefb-1d20-4d27-9756-3cce60b5e958	e40d1da7-3987-4338-ad34-02ece0227ddd	t
3d21aefb-1d20-4d27-9756-3cce60b5e958	7340bf61-1107-4848-a100-32981012bf8f	t
3d21aefb-1d20-4d27-9756-3cce60b5e958	4a255549-9040-4e49-b43b-1c7c017e424c	t
3d21aefb-1d20-4d27-9756-3cce60b5e958	23806095-5d19-4b3c-9977-076c75933e96	f
3d21aefb-1d20-4d27-9756-3cce60b5e958	55be477a-ddcf-4a58-bd0b-d9f0f829593b	f
3d21aefb-1d20-4d27-9756-3cce60b5e958	329657bf-094f-44e9-92ed-bf9aca3b7fbb	f
3d21aefb-1d20-4d27-9756-3cce60b5e958	0b7b08ab-1f3c-44de-86e6-74d304e82697	f
75fc95fe-2c73-4934-a450-5d00669f5b97	99665abe-71db-4ae8-8e31-f4c782298c4a	t
75fc95fe-2c73-4934-a450-5d00669f5b97	5981264e-0c65-4ccc-b73c-894a11d9d5f5	t
75fc95fe-2c73-4934-a450-5d00669f5b97	13abbec8-4f5f-4eab-97a8-9b5097559d9e	t
75fc95fe-2c73-4934-a450-5d00669f5b97	1131f752-fbe3-4ca0-a3a4-8a009a537b5a	t
75fc95fe-2c73-4934-a450-5d00669f5b97	40dc0180-628a-4c3a-b686-705d70183eda	t
75fc95fe-2c73-4934-a450-5d00669f5b97	30a3ec2f-b90a-4656-8d56-60466a47a79e	f
75fc95fe-2c73-4934-a450-5d00669f5b97	2bd5607e-74d2-4ead-94c8-5b0e4861b266	f
75fc95fe-2c73-4934-a450-5d00669f5b97	20220de8-fcaf-4554-80ef-9078a66c844e	f
75fc95fe-2c73-4934-a450-5d00669f5b97	a499924a-2f59-4e14-a115-16aac030f760	f
7f6732e2-e3c2-456a-9e4e-234ecab9072d	99665abe-71db-4ae8-8e31-f4c782298c4a	t
7f6732e2-e3c2-456a-9e4e-234ecab9072d	5981264e-0c65-4ccc-b73c-894a11d9d5f5	t
7f6732e2-e3c2-456a-9e4e-234ecab9072d	13abbec8-4f5f-4eab-97a8-9b5097559d9e	t
7f6732e2-e3c2-456a-9e4e-234ecab9072d	1131f752-fbe3-4ca0-a3a4-8a009a537b5a	t
7f6732e2-e3c2-456a-9e4e-234ecab9072d	40dc0180-628a-4c3a-b686-705d70183eda	t
7f6732e2-e3c2-456a-9e4e-234ecab9072d	30a3ec2f-b90a-4656-8d56-60466a47a79e	f
7f6732e2-e3c2-456a-9e4e-234ecab9072d	2bd5607e-74d2-4ead-94c8-5b0e4861b266	f
7f6732e2-e3c2-456a-9e4e-234ecab9072d	20220de8-fcaf-4554-80ef-9078a66c844e	f
7f6732e2-e3c2-456a-9e4e-234ecab9072d	a499924a-2f59-4e14-a115-16aac030f760	f
b4d77a2c-4fe5-4a83-b79f-a1b13b2e0132	99665abe-71db-4ae8-8e31-f4c782298c4a	t
b4d77a2c-4fe5-4a83-b79f-a1b13b2e0132	5981264e-0c65-4ccc-b73c-894a11d9d5f5	t
b4d77a2c-4fe5-4a83-b79f-a1b13b2e0132	13abbec8-4f5f-4eab-97a8-9b5097559d9e	t
b4d77a2c-4fe5-4a83-b79f-a1b13b2e0132	1131f752-fbe3-4ca0-a3a4-8a009a537b5a	t
b4d77a2c-4fe5-4a83-b79f-a1b13b2e0132	40dc0180-628a-4c3a-b686-705d70183eda	t
b4d77a2c-4fe5-4a83-b79f-a1b13b2e0132	30a3ec2f-b90a-4656-8d56-60466a47a79e	f
b4d77a2c-4fe5-4a83-b79f-a1b13b2e0132	2bd5607e-74d2-4ead-94c8-5b0e4861b266	f
b4d77a2c-4fe5-4a83-b79f-a1b13b2e0132	20220de8-fcaf-4554-80ef-9078a66c844e	f
b4d77a2c-4fe5-4a83-b79f-a1b13b2e0132	a499924a-2f59-4e14-a115-16aac030f760	f
7f1eda49-4d82-4b18-8c52-36c8fa8e42c6	99665abe-71db-4ae8-8e31-f4c782298c4a	t
7f1eda49-4d82-4b18-8c52-36c8fa8e42c6	5981264e-0c65-4ccc-b73c-894a11d9d5f5	t
7f1eda49-4d82-4b18-8c52-36c8fa8e42c6	13abbec8-4f5f-4eab-97a8-9b5097559d9e	t
7f1eda49-4d82-4b18-8c52-36c8fa8e42c6	1131f752-fbe3-4ca0-a3a4-8a009a537b5a	t
7f1eda49-4d82-4b18-8c52-36c8fa8e42c6	40dc0180-628a-4c3a-b686-705d70183eda	t
7f1eda49-4d82-4b18-8c52-36c8fa8e42c6	30a3ec2f-b90a-4656-8d56-60466a47a79e	f
7f1eda49-4d82-4b18-8c52-36c8fa8e42c6	2bd5607e-74d2-4ead-94c8-5b0e4861b266	f
7f1eda49-4d82-4b18-8c52-36c8fa8e42c6	20220de8-fcaf-4554-80ef-9078a66c844e	f
7f1eda49-4d82-4b18-8c52-36c8fa8e42c6	a499924a-2f59-4e14-a115-16aac030f760	f
a244baff-703f-4856-ae02-dc4dc6aacd1e	99665abe-71db-4ae8-8e31-f4c782298c4a	t
a244baff-703f-4856-ae02-dc4dc6aacd1e	5981264e-0c65-4ccc-b73c-894a11d9d5f5	t
a244baff-703f-4856-ae02-dc4dc6aacd1e	13abbec8-4f5f-4eab-97a8-9b5097559d9e	t
a244baff-703f-4856-ae02-dc4dc6aacd1e	1131f752-fbe3-4ca0-a3a4-8a009a537b5a	t
a244baff-703f-4856-ae02-dc4dc6aacd1e	40dc0180-628a-4c3a-b686-705d70183eda	t
a244baff-703f-4856-ae02-dc4dc6aacd1e	30a3ec2f-b90a-4656-8d56-60466a47a79e	f
a244baff-703f-4856-ae02-dc4dc6aacd1e	2bd5607e-74d2-4ead-94c8-5b0e4861b266	f
a244baff-703f-4856-ae02-dc4dc6aacd1e	20220de8-fcaf-4554-80ef-9078a66c844e	f
a244baff-703f-4856-ae02-dc4dc6aacd1e	a499924a-2f59-4e14-a115-16aac030f760	f
797f6274-dc0a-4a46-8098-9e25decee64f	99665abe-71db-4ae8-8e31-f4c782298c4a	t
797f6274-dc0a-4a46-8098-9e25decee64f	5981264e-0c65-4ccc-b73c-894a11d9d5f5	t
797f6274-dc0a-4a46-8098-9e25decee64f	13abbec8-4f5f-4eab-97a8-9b5097559d9e	t
797f6274-dc0a-4a46-8098-9e25decee64f	1131f752-fbe3-4ca0-a3a4-8a009a537b5a	t
797f6274-dc0a-4a46-8098-9e25decee64f	40dc0180-628a-4c3a-b686-705d70183eda	t
797f6274-dc0a-4a46-8098-9e25decee64f	30a3ec2f-b90a-4656-8d56-60466a47a79e	f
797f6274-dc0a-4a46-8098-9e25decee64f	2bd5607e-74d2-4ead-94c8-5b0e4861b266	f
797f6274-dc0a-4a46-8098-9e25decee64f	20220de8-fcaf-4554-80ef-9078a66c844e	f
797f6274-dc0a-4a46-8098-9e25decee64f	a499924a-2f59-4e14-a115-16aac030f760	f
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	131703b4-a4fe-4c12-91e4-10aa029661e0	t
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	379a3e26-dd12-4608-919a-e84602fcbeb1	t
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	2ba22377-8a2c-4e8b-a860-b2ba519f38da	t
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	5c2a597a-7480-4270-a86c-b1d02750ce60	t
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	22b7f0e6-d566-4ac4-80ef-08ff08998740	t
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	040da43b-fd9e-47cf-8f0d-68f6ac7e6405	f
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	637fac36-2646-4763-8913-3fb8679a77a4	f
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	ae1f5c94-4630-4846-acb8-200371e03893	f
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	3419fbee-de34-42ab-813d-873b113fa211	f
b2a0a790-59c5-4142-9d77-44932b1e8620	4597c668-fa1b-478d-9843-5848285c470b	t
b2a0a790-59c5-4142-9d77-44932b1e8620	cf860e2f-978d-469d-a18e-db7a4008b243	t
b2a0a790-59c5-4142-9d77-44932b1e8620	d7ce6ee2-6ed3-4a82-a5af-718704a6a888	t
b2a0a790-59c5-4142-9d77-44932b1e8620	18adc9ea-03c2-4910-a599-b60baf0926b2	t
b2a0a790-59c5-4142-9d77-44932b1e8620	52b1693f-4fc2-4ce5-9b30-95a8daef5fcd	t
b2a0a790-59c5-4142-9d77-44932b1e8620	7610c75c-6b08-47eb-a96b-37b6d0ed8afb	f
b2a0a790-59c5-4142-9d77-44932b1e8620	15db502e-270d-4bc5-98d8-786393ef0fed	f
b2a0a790-59c5-4142-9d77-44932b1e8620	667d3b9a-7261-460e-847f-d66563aae9e1	f
b2a0a790-59c5-4142-9d77-44932b1e8620	b789a1aa-c97d-4fb1-b771-f2cbccafeae0	f
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	49e25b5d-d76e-4051-9c7c-7a0b5c1052bd	t
37ffb6d7-4e38-4e14-a47f-6a5a85276f55	03b1a0a4-bd48-49a4-926b-de5f66803c2b	t
0eecf1c0-c127-4ca2-9327-459efbb9c681	03b1a0a4-bd48-49a4-926b-de5f66803c2b	t
a172934f-a9e5-458f-9483-7dfc4d6e1991	03b1a0a4-bd48-49a4-926b-de5f66803c2b	t
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	03b1a0a4-bd48-49a4-926b-de5f66803c2b	t
b2a0a790-59c5-4142-9d77-44932b1e8620	03b1a0a4-bd48-49a4-926b-de5f66803c2b	t
44cee68c-7ad2-465c-b7e4-67db09369afc	03b1a0a4-bd48-49a4-926b-de5f66803c2b	t
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	03b1a0a4-bd48-49a4-926b-de5f66803c2b	t
853be0b2-ad1a-4116-aff3-c10f318e9ad5	d93f07c8-4801-4b12-a63b-1085e3135be8	t
b43612df-590a-4e25-a38f-2f0de881be8f	d93f07c8-4801-4b12-a63b-1085e3135be8	t
c630ba3c-66f1-4ffd-af22-675166784cba	d93f07c8-4801-4b12-a63b-1085e3135be8	t
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	d93f07c8-4801-4b12-a63b-1085e3135be8	t
d15c1b01-566a-4497-8bc9-3d9d87253ea1	d93f07c8-4801-4b12-a63b-1085e3135be8	t
75fc95fe-2c73-4934-a450-5d00669f5b97	0673cf19-e51c-4979-be63-052f84c3c555	t
7f6732e2-e3c2-456a-9e4e-234ecab9072d	0673cf19-e51c-4979-be63-052f84c3c555	t
b4d77a2c-4fe5-4a83-b79f-a1b13b2e0132	0673cf19-e51c-4979-be63-052f84c3c555	t
797f6274-dc0a-4a46-8098-9e25decee64f	0673cf19-e51c-4979-be63-052f84c3c555	t
20ab4f86-015d-4d03-9ca5-de7ab82277bf	fa7619c7-fa00-4a0a-a46f-911d0bbc309b	t
f99d9cb1-4be5-4cd0-8061-e223ad552b74	fa7619c7-fa00-4a0a-a46f-911d0bbc309b	t
9f878ecd-e756-43ca-8964-7858e766bb1a	fa7619c7-fa00-4a0a-a46f-911d0bbc309b	t
838fe32e-5500-4989-8194-c83c43aa5617	fa7619c7-fa00-4a0a-a46f-911d0bbc309b	t
df1eed9b-9772-4844-bf38-063fcfbf2c71	79cf0e01-9d2d-4d0e-95a5-a0884158d529	t
bb4d8a91-43ec-4a96-8bec-800f920c8826	79cf0e01-9d2d-4d0e-95a5-a0884158d529	t
60340a1c-493f-4648-96ca-76635694dcec	79cf0e01-9d2d-4d0e-95a5-a0884158d529	t
3d21aefb-1d20-4d27-9756-3cce60b5e958	79cf0e01-9d2d-4d0e-95a5-a0884158d529	t
473685f9-266f-4983-b2a5-156a6dc8468c	4597c668-fa1b-478d-9843-5848285c470b	t
473685f9-266f-4983-b2a5-156a6dc8468c	49e25b5d-d76e-4051-9c7c-7a0b5c1052bd	t
473685f9-266f-4983-b2a5-156a6dc8468c	cf860e2f-978d-469d-a18e-db7a4008b243	t
473685f9-266f-4983-b2a5-156a6dc8468c	d7ce6ee2-6ed3-4a82-a5af-718704a6a888	t
473685f9-266f-4983-b2a5-156a6dc8468c	03b1a0a4-bd48-49a4-926b-de5f66803c2b	t
473685f9-266f-4983-b2a5-156a6dc8468c	18adc9ea-03c2-4910-a599-b60baf0926b2	t
473685f9-266f-4983-b2a5-156a6dc8468c	52b1693f-4fc2-4ce5-9b30-95a8daef5fcd	t
473685f9-266f-4983-b2a5-156a6dc8468c	7610c75c-6b08-47eb-a96b-37b6d0ed8afb	f
473685f9-266f-4983-b2a5-156a6dc8468c	15db502e-270d-4bc5-98d8-786393ef0fed	f
473685f9-266f-4983-b2a5-156a6dc8468c	667d3b9a-7261-460e-847f-d66563aae9e1	f
473685f9-266f-4983-b2a5-156a6dc8468c	b789a1aa-c97d-4fb1-b771-f2cbccafeae0	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
ae1f5c94-4630-4846-acb8-200371e03893	ac91fe6e-cc15-4a44-8d4b-d4aa5eefa2e4
7610c75c-6b08-47eb-a96b-37b6d0ed8afb	8b635337-8c5a-42ae-a75e-c4ba77db20e1
c72aafc0-5c09-4215-b3ae-eae56f417bd5	950e111f-22e9-4953-a133-24a7eb6c4cb4
329657bf-094f-44e9-92ed-bf9aca3b7fbb	5ca4b80a-176b-4feb-8104-d2f4a9794e1b
2bd5607e-74d2-4ead-94c8-5b0e4861b266	493dda44-5c4a-4d7a-a26f-75e855b4e133
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
c917c6e2-1780-43bb-bce2-143c09b6c616	Trusted Hosts	f493d84c-5308-498f-afec-c6f4cfffd553	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f493d84c-5308-498f-afec-c6f4cfffd553	anonymous
f36ff38a-ca85-44f7-ae05-bbc87c50534e	Consent Required	f493d84c-5308-498f-afec-c6f4cfffd553	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f493d84c-5308-498f-afec-c6f4cfffd553	anonymous
0e43b464-cdca-4097-8798-51ae7a2f602f	Full Scope Disabled	f493d84c-5308-498f-afec-c6f4cfffd553	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f493d84c-5308-498f-afec-c6f4cfffd553	anonymous
93ab7847-f569-450c-a8f8-aab11df7e45f	Max Clients Limit	f493d84c-5308-498f-afec-c6f4cfffd553	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f493d84c-5308-498f-afec-c6f4cfffd553	anonymous
fbc9ebb7-877a-4ff7-9869-ae32466cb3c5	Allowed Protocol Mapper Types	f493d84c-5308-498f-afec-c6f4cfffd553	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f493d84c-5308-498f-afec-c6f4cfffd553	anonymous
ef0d822a-9c55-4a09-92f5-a1ab2502387e	Allowed Client Scopes	f493d84c-5308-498f-afec-c6f4cfffd553	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f493d84c-5308-498f-afec-c6f4cfffd553	anonymous
de9a408b-a0e6-426a-92e0-e4aa1200e528	Allowed Protocol Mapper Types	f493d84c-5308-498f-afec-c6f4cfffd553	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f493d84c-5308-498f-afec-c6f4cfffd553	authenticated
8cec4baf-35f5-45f7-8991-aae529ea8a4f	Allowed Client Scopes	f493d84c-5308-498f-afec-c6f4cfffd553	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f493d84c-5308-498f-afec-c6f4cfffd553	authenticated
cf57d1c7-d5c2-419e-84b7-f19170248a2c	rsa-generated	f493d84c-5308-498f-afec-c6f4cfffd553	rsa-generated	org.keycloak.keys.KeyProvider	f493d84c-5308-498f-afec-c6f4cfffd553	\N
816541a9-f00b-4ad9-bb7a-52e486f0ff37	rsa-enc-generated	f493d84c-5308-498f-afec-c6f4cfffd553	rsa-enc-generated	org.keycloak.keys.KeyProvider	f493d84c-5308-498f-afec-c6f4cfffd553	\N
8c32731f-70b5-4465-91c7-7cd1ef795d07	hmac-generated-hs512	f493d84c-5308-498f-afec-c6f4cfffd553	hmac-generated	org.keycloak.keys.KeyProvider	f493d84c-5308-498f-afec-c6f4cfffd553	\N
28bf6149-1578-4ef9-80c7-7b780eccf9f2	aes-generated	f493d84c-5308-498f-afec-c6f4cfffd553	aes-generated	org.keycloak.keys.KeyProvider	f493d84c-5308-498f-afec-c6f4cfffd553	\N
8af89d6f-48ac-4fd1-a3b3-3443a4e01b88	\N	f493d84c-5308-498f-afec-c6f4cfffd553	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	f493d84c-5308-498f-afec-c6f4cfffd553	\N
f9bf1944-6bd8-4d50-b811-c51924e38df6	rsa-generated	5760f0e0-8dc4-453f-b407-19c01025187d	rsa-generated	org.keycloak.keys.KeyProvider	5760f0e0-8dc4-453f-b407-19c01025187d	\N
6971eee4-21eb-42b7-8af7-af00aa09d4be	rsa-enc-generated	5760f0e0-8dc4-453f-b407-19c01025187d	rsa-enc-generated	org.keycloak.keys.KeyProvider	5760f0e0-8dc4-453f-b407-19c01025187d	\N
4a2ea3b6-be43-4fe8-a774-d1381dcca2d7	hmac-generated-hs512	5760f0e0-8dc4-453f-b407-19c01025187d	hmac-generated	org.keycloak.keys.KeyProvider	5760f0e0-8dc4-453f-b407-19c01025187d	\N
ea97647f-5089-488c-b30c-5d61d1972a33	aes-generated	5760f0e0-8dc4-453f-b407-19c01025187d	aes-generated	org.keycloak.keys.KeyProvider	5760f0e0-8dc4-453f-b407-19c01025187d	\N
a36ab92c-e7c7-4521-8c85-895d0c2d87e5	Trusted Hosts	5760f0e0-8dc4-453f-b407-19c01025187d	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5760f0e0-8dc4-453f-b407-19c01025187d	anonymous
b3833527-f62f-43c3-b94a-5be8b714cde7	Consent Required	5760f0e0-8dc4-453f-b407-19c01025187d	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5760f0e0-8dc4-453f-b407-19c01025187d	anonymous
12aa3e0a-e938-4db3-97ec-c7e41dd042fa	Full Scope Disabled	5760f0e0-8dc4-453f-b407-19c01025187d	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5760f0e0-8dc4-453f-b407-19c01025187d	anonymous
f6058763-7158-4148-b56c-50124b2078af	Max Clients Limit	5760f0e0-8dc4-453f-b407-19c01025187d	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5760f0e0-8dc4-453f-b407-19c01025187d	anonymous
5e0cb8bd-af54-466f-87ac-f6bb368eade1	Allowed Protocol Mapper Types	5760f0e0-8dc4-453f-b407-19c01025187d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5760f0e0-8dc4-453f-b407-19c01025187d	anonymous
82a3e397-d535-4261-a2f2-08b83888f5c5	Allowed Client Scopes	5760f0e0-8dc4-453f-b407-19c01025187d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5760f0e0-8dc4-453f-b407-19c01025187d	anonymous
cce81271-81ea-49fb-9ca9-0104186ee345	Allowed Protocol Mapper Types	5760f0e0-8dc4-453f-b407-19c01025187d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5760f0e0-8dc4-453f-b407-19c01025187d	authenticated
6bc03ffc-7029-4eed-8bac-f4693a887b0e	Allowed Client Scopes	5760f0e0-8dc4-453f-b407-19c01025187d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5760f0e0-8dc4-453f-b407-19c01025187d	authenticated
859d4bca-86da-4ff0-a2e7-cf0ee130f774	\N	5760f0e0-8dc4-453f-b407-19c01025187d	Open Learning	org.keycloak.services.ui.extend.UiTabProvider	5760f0e0-8dc4-453f-b407-19c01025187d	\N
eb435621-1a72-4355-b62b-ecd8c28c7b0f	\N	5760f0e0-8dc4-453f-b407-19c01025187d	Open Learning	org.keycloak.services.ui.extend.UiTabProvider	5760f0e0-8dc4-453f-b407-19c01025187d	\N
49810d1c-9496-4b1e-84aa-afd85ab5ecc5	\N	5760f0e0-8dc4-453f-b407-19c01025187d	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	5760f0e0-8dc4-453f-b407-19c01025187d	\N
ac4c2880-2551-4f80-910e-75c9223f7c4f	rsa-generated	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	rsa-generated	org.keycloak.keys.KeyProvider	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	\N
f399ac6e-7e92-4aab-8830-390d8313822f	rsa-enc-generated	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	rsa-enc-generated	org.keycloak.keys.KeyProvider	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	\N
679ef00a-7555-440d-8896-9023ae5bfb62	hmac-generated-hs512	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	hmac-generated	org.keycloak.keys.KeyProvider	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	\N
f214c716-6f26-4d6d-ab3c-5c2335faac45	aes-generated	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	aes-generated	org.keycloak.keys.KeyProvider	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	\N
358f74a9-3fa1-44e4-ba15-2b917601f41f	Trusted Hosts	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	anonymous
3134c151-4636-4cd4-aecb-f10909080dfe	Consent Required	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	anonymous
08d86f89-0c17-416f-8958-e756d90875ba	Full Scope Disabled	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	anonymous
55deb522-9756-4ccc-9345-dda70d75696b	Max Clients Limit	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	anonymous
34608685-5dbb-4060-b5c3-f6c6454ef22f	Allowed Protocol Mapper Types	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	anonymous
a4f9f73c-01ac-4d8c-9798-7c2ad6daf6d7	Allowed Client Scopes	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	anonymous
1fe66da8-218b-442a-ac69-a86fd3803b24	Allowed Protocol Mapper Types	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	authenticated
9681ffc6-4bcf-4782-94af-c9ad6f1c09d8	Allowed Client Scopes	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	authenticated
377103b4-3fb9-4d7b-8caf-94c39c038af5	\N	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	\N
93df4fdd-eb37-4863-9212-b8e1c34a44e4	rsa-generated	b4825e08-1ac5-43e9-990a-7556e882153a	rsa-generated	org.keycloak.keys.KeyProvider	b4825e08-1ac5-43e9-990a-7556e882153a	\N
1821b69d-462a-4ccf-b648-48d5cd78dc98	rsa-enc-generated	b4825e08-1ac5-43e9-990a-7556e882153a	rsa-enc-generated	org.keycloak.keys.KeyProvider	b4825e08-1ac5-43e9-990a-7556e882153a	\N
347d0045-8dc5-4b08-8ecd-308044029978	hmac-generated-hs512	b4825e08-1ac5-43e9-990a-7556e882153a	hmac-generated	org.keycloak.keys.KeyProvider	b4825e08-1ac5-43e9-990a-7556e882153a	\N
abe3cb13-73c7-40f9-b007-f65d2dce789d	aes-generated	b4825e08-1ac5-43e9-990a-7556e882153a	aes-generated	org.keycloak.keys.KeyProvider	b4825e08-1ac5-43e9-990a-7556e882153a	\N
59de6fd1-9305-41fc-8089-b217a4980141	Trusted Hosts	b4825e08-1ac5-43e9-990a-7556e882153a	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b4825e08-1ac5-43e9-990a-7556e882153a	anonymous
b5f629a4-6ee1-491b-9afb-e1fbbcc1ec7a	Consent Required	b4825e08-1ac5-43e9-990a-7556e882153a	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b4825e08-1ac5-43e9-990a-7556e882153a	anonymous
20a6a409-6410-4abb-a0d7-f2e61167a205	Full Scope Disabled	b4825e08-1ac5-43e9-990a-7556e882153a	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b4825e08-1ac5-43e9-990a-7556e882153a	anonymous
12723d99-64ef-40c2-a587-435e04239356	Max Clients Limit	b4825e08-1ac5-43e9-990a-7556e882153a	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b4825e08-1ac5-43e9-990a-7556e882153a	anonymous
50898e27-992f-44a9-bc5f-4d741c7acc82	Allowed Protocol Mapper Types	b4825e08-1ac5-43e9-990a-7556e882153a	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b4825e08-1ac5-43e9-990a-7556e882153a	anonymous
553eefee-6e62-4b3a-9437-2fa68cfc4f2d	Allowed Client Scopes	b4825e08-1ac5-43e9-990a-7556e882153a	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b4825e08-1ac5-43e9-990a-7556e882153a	anonymous
30c62879-8355-4054-a784-09037cc34ea1	Allowed Protocol Mapper Types	b4825e08-1ac5-43e9-990a-7556e882153a	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b4825e08-1ac5-43e9-990a-7556e882153a	authenticated
26574e7f-a816-4ccf-80c6-79c35a3d2f83	Allowed Client Scopes	b4825e08-1ac5-43e9-990a-7556e882153a	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b4825e08-1ac5-43e9-990a-7556e882153a	authenticated
f6cb81d1-1a9f-4d99-bfa7-51927a904a98	rsa-generated	2256a568-ee44-4cb6-88fa-488d343b1bf5	rsa-generated	org.keycloak.keys.KeyProvider	2256a568-ee44-4cb6-88fa-488d343b1bf5	\N
e5c2900b-bee6-4c4e-9612-363eeada8a87	rsa-enc-generated	2256a568-ee44-4cb6-88fa-488d343b1bf5	rsa-enc-generated	org.keycloak.keys.KeyProvider	2256a568-ee44-4cb6-88fa-488d343b1bf5	\N
568a6e2c-caf1-4093-9258-a31554a6d08b	hmac-generated-hs512	2256a568-ee44-4cb6-88fa-488d343b1bf5	hmac-generated	org.keycloak.keys.KeyProvider	2256a568-ee44-4cb6-88fa-488d343b1bf5	\N
e84d01a2-1cad-4779-b5c6-63e2f8f48834	aes-generated	2256a568-ee44-4cb6-88fa-488d343b1bf5	aes-generated	org.keycloak.keys.KeyProvider	2256a568-ee44-4cb6-88fa-488d343b1bf5	\N
3ba0fed2-2fd4-4fba-94ac-3bb1f3066f0d	Trusted Hosts	2256a568-ee44-4cb6-88fa-488d343b1bf5	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2256a568-ee44-4cb6-88fa-488d343b1bf5	anonymous
43f1b5dd-e19e-41d9-a7e8-3c80ece92b57	Consent Required	2256a568-ee44-4cb6-88fa-488d343b1bf5	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2256a568-ee44-4cb6-88fa-488d343b1bf5	anonymous
3eaad8e9-c3cd-4dd9-8011-0548eccad123	Full Scope Disabled	2256a568-ee44-4cb6-88fa-488d343b1bf5	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2256a568-ee44-4cb6-88fa-488d343b1bf5	anonymous
da87c877-b66c-4dd0-842c-0bcc2af0a5b2	Max Clients Limit	2256a568-ee44-4cb6-88fa-488d343b1bf5	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2256a568-ee44-4cb6-88fa-488d343b1bf5	anonymous
8f8c8b24-c802-487f-9ac7-2a4df160c81f	Allowed Protocol Mapper Types	2256a568-ee44-4cb6-88fa-488d343b1bf5	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2256a568-ee44-4cb6-88fa-488d343b1bf5	anonymous
4864c054-a923-4381-986b-62adc1802cad	Allowed Client Scopes	2256a568-ee44-4cb6-88fa-488d343b1bf5	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2256a568-ee44-4cb6-88fa-488d343b1bf5	anonymous
bcf43d9a-74b4-4734-99cc-b89e0e606d8d	Allowed Protocol Mapper Types	2256a568-ee44-4cb6-88fa-488d343b1bf5	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2256a568-ee44-4cb6-88fa-488d343b1bf5	authenticated
08a2f30f-353e-4ee6-bf7e-ba4fd0816db6	Allowed Client Scopes	2256a568-ee44-4cb6-88fa-488d343b1bf5	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2256a568-ee44-4cb6-88fa-488d343b1bf5	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
559f60c9-40b0-413e-98f1-2beac592ce20	fbc9ebb7-877a-4ff7-9869-ae32466cb3c5	allowed-protocol-mapper-types	oidc-full-name-mapper
6d0605c0-6ab1-4e4a-ac04-b5fb03e87931	fbc9ebb7-877a-4ff7-9869-ae32466cb3c5	allowed-protocol-mapper-types	saml-user-property-mapper
e88f4442-739d-4bb4-990f-e2a4b8c4998c	fbc9ebb7-877a-4ff7-9869-ae32466cb3c5	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
aa103eb7-743f-448d-99fc-a918a8c22100	fbc9ebb7-877a-4ff7-9869-ae32466cb3c5	allowed-protocol-mapper-types	saml-user-attribute-mapper
7b757304-3f17-4703-b262-5effafa66c2a	fbc9ebb7-877a-4ff7-9869-ae32466cb3c5	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
972ae6c3-62de-4ba3-9956-b6097e878c38	fbc9ebb7-877a-4ff7-9869-ae32466cb3c5	allowed-protocol-mapper-types	saml-role-list-mapper
6f004b9c-4c60-4396-9ed6-f5f4da875dd5	fbc9ebb7-877a-4ff7-9869-ae32466cb3c5	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c8a29366-883f-47c5-95f6-b0f330b37f30	fbc9ebb7-877a-4ff7-9869-ae32466cb3c5	allowed-protocol-mapper-types	oidc-address-mapper
772b6935-5bfd-4b74-8ec8-3ebc501b4f71	8cec4baf-35f5-45f7-8991-aae529ea8a4f	allow-default-scopes	true
e4267ee1-3ad3-4db9-bcaa-439dbe9806a6	ef0d822a-9c55-4a09-92f5-a1ab2502387e	allow-default-scopes	true
afd2b2d1-9338-41e2-8169-c28c3b8a5f0b	c917c6e2-1780-43bb-bce2-143c09b6c616	client-uris-must-match	true
2872c1da-b8dd-405d-8145-3b71290aba5a	c917c6e2-1780-43bb-bce2-143c09b6c616	host-sending-registration-request-must-match	true
064aadae-e5bd-4b95-a444-5adf9ed5e619	de9a408b-a0e6-426a-92e0-e4aa1200e528	allowed-protocol-mapper-types	oidc-full-name-mapper
df58bc47-f59a-4a80-abdc-6b54ed725242	de9a408b-a0e6-426a-92e0-e4aa1200e528	allowed-protocol-mapper-types	oidc-address-mapper
f40bf468-5039-4298-82ca-185a55ef60a6	de9a408b-a0e6-426a-92e0-e4aa1200e528	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3ad1abca-1056-4c74-8fb1-4781d0fca126	de9a408b-a0e6-426a-92e0-e4aa1200e528	allowed-protocol-mapper-types	saml-user-property-mapper
7965823a-fa90-48d2-9288-3f5987761920	de9a408b-a0e6-426a-92e0-e4aa1200e528	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b2181a44-e609-42fa-80c5-c38a27217d91	de9a408b-a0e6-426a-92e0-e4aa1200e528	allowed-protocol-mapper-types	saml-role-list-mapper
daa765c0-84d0-41a3-902c-b54ca53aa97f	de9a408b-a0e6-426a-92e0-e4aa1200e528	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
14e6d1da-c31b-4f94-954e-99ec84c716eb	de9a408b-a0e6-426a-92e0-e4aa1200e528	allowed-protocol-mapper-types	saml-user-attribute-mapper
7e6c1e42-8c31-489d-9be3-01fd1069b18f	93ab7847-f569-450c-a8f8-aab11df7e45f	max-clients	200
3dbf1a31-08c1-4126-ae51-e0baaab1b619	28bf6149-1578-4ef9-80c7-7b780eccf9f2	priority	100
8ca1b8b6-1c6f-4152-83e0-2e6ffddea123	28bf6149-1578-4ef9-80c7-7b780eccf9f2	kid	0cf6abc3-0bb5-4328-8521-cfaf78a52478
71d582e1-336a-47cd-b886-aa8ec0e21b70	28bf6149-1578-4ef9-80c7-7b780eccf9f2	secret	ABGmi4EkWFBkEEHHRk7qpA
dd9ac0d3-9e74-49b9-9819-09bfa29319d5	cf57d1c7-d5c2-419e-84b7-f19170248a2c	privateKey	MIIEogIBAAKCAQEAxYXjCoFPyAD09sKRxBMq1GMTJNOhDAmbIhhC1zrjI0FJDcRJCt0zCL76xv3hm4xle6P5ChtIO/3rl9rPy6366kS5JupOXWsKV8SZKfF1GbGTrXz/MdTkwrcX8VPjWXlNPIzhXlJ0db5SfLCtF/Fy3xFVVWWt/iH1+NCiEfskSgUcs+xnN8yOjOUy6JY55fRJEq0vILKwcRSZwpfViPfjz7MbS4PWKyzsGIsohVRULx+8uyQu7QQhlzacMPbS7VQuYATkJ/CHTFMxFa7oSJZEN6u/mORRIZy/iGS3vGTMKdWLVS+PoATfFLPlfF3ay5ZH/ed0zw/X8Ul86s/N0evTfwIDAQABAoIBAC2vV+H4IrHJtt7UBc7p+AADokvkPt1/40exgNQzJJHk6barbZF7s/AT7ADWe7X0dQxx0ooJ4V0uz6zhySn85YoFtyVPECz/Mvc1248d782vis6XmJa3/OkkW/9PPchWDA0zMHUWcSVCjeWVH5PoHn+FjM0hpWqgBDo2VyX9hlkwCW5795r+24OTcjTxLGt0I/zXDd+O+YH571kMbba7m0myqN1AyA1OWASBoToxS+/ttvizbnGwri8pPJwpA3F9NdeSztlq3yTX0upwMi2H3nx8duKiMvpRaUG1ycWQNDokxkwl43sj0XRdp/E6KO0pJqP2vvZ9OrQB7861t8jcAoECgYEA6C6HE5etwi8/kOjn3tCnJcOF15tk7ayIa30D8edoVO23jJgGEV3sovaMX9r+dEjSfDL13wnV/vHWxOheV6iLcFT0Vf3L0YPmv5st4Y1IiJmAnEZHO53k1xdZ7wM7knk1mK8g6C7iQ8qL3UN3cjGOaCT3EzXar5xCEh/1lwmaHiECgYEA2ckp6RMopxoTYTT1bzzhDylFfkDShbc3AVS/YbygyMoJBnGqMq264DSUL7lBmxubza5pCCikQe06nzkZHPQLdtxW339EfDsU/05WhhPeGQpgLekKXGekht+CxUn3PPXit/YkAftuqeDjBPb27Fh3nSbXIj6llTXGINepf5jdfZ8CgYBrKU5e1Jr2DSihkV2zkUoUO/ICWU50BDXSppizhcK5sB4PXfsu+NLHRFP1yfW3ZgUAHeUtVDTYvnYJ29XvT3NMHWnIZqMzyFUwCkda2wKnSXH6rtUhxvZf7/8qOau9JwR9vBbMExeLgmibbxAqPIUlvCntS+XrN4unIekQFPZ1AQKBgGwoJiM1O5Q5M/Srm1QiFNc1tOhtgt+bTLrhfqYoSmVNSMwleNPwSYV9Nza4Nyezv12XR1wg6uo+yUU30wv4+xSNeqtGBhn4MYZVPk0Z4svmxjsmp9maMzA0IjqecCWbK3wWxm0hlCTTpYrap2hayxSFrIO6PvtqGDpJQEk4/o6bAoGAO2uuaSd1p2x+u1FtwjcvVUxB2tD9jxAG6+34JCmeoIfmWGXK87Dp9fqdFdtsTv4H+t1EkWSihX0IAe+88z4AuL651v2TwHknk1rn70Nj8e3uaqtYOSRxVCBTqCZeXE3ZcjnCu22zYle3AOx+7gnywQwjiySdL9SZmo19Hnqek60=
a1e019ff-924b-4c93-b1f6-912860d4c829	cf57d1c7-d5c2-419e-84b7-f19170248a2c	keyUse	SIG
00fc6f61-c323-4a9e-a0ca-0b0b260ad59d	cf57d1c7-d5c2-419e-84b7-f19170248a2c	certificate	MIICmzCCAYMCBgGRM6aHbzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwODA4MjAxODU3WhcNMzQwODA4MjAyMDM3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDFheMKgU/IAPT2wpHEEyrUYxMk06EMCZsiGELXOuMjQUkNxEkK3TMIvvrG/eGbjGV7o/kKG0g7/euX2s/LrfrqRLkm6k5dawpXxJkp8XUZsZOtfP8x1OTCtxfxU+NZeU08jOFeUnR1vlJ8sK0X8XLfEVVVZa3+IfX40KIR+yRKBRyz7Gc3zI6M5TLoljnl9EkSrS8gsrBxFJnCl9WI9+PPsxtLg9YrLOwYiyiFVFQvH7y7JC7tBCGXNpww9tLtVC5gBOQn8IdMUzEVruhIlkQ3q7+Y5FEhnL+IZLe8ZMwp1YtVL4+gBN8Us+V8XdrLlkf953TPD9fxSXzqz83R69N/AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHlURfoliKEQal8jl0c8qMEP34UTjr1as2wwbh4sGwI7QMtSJyO1Ai8bP3bPTWZFirR7cxBIOZ0Lo+Pf5ISf3ihqHXHt1wZsVi/b8eOrIKZ5yZxxkhLEv8/shBozh79kKa01TnBL7w90hG6kLGIagwuB/f+zi8dqyWqYwC7STzIv/FyydqVamxCulWZfOGVbloMgAQxn3zb0JHjjdcF0HzkXOPYOK5VNrTu0+O7+AKaTk5V6FUMc24P40zK0kwaTy9PwWMt8zp2WBzePKtVkaQoP+T/Zk4x/GGA+KdAPkOgXgdRKFp9kHAT3uU+c7ECpmK1wInR1BBhVumEJOVzAvCA=
2082fa86-f90c-416b-b04f-642bbb45b016	cf57d1c7-d5c2-419e-84b7-f19170248a2c	priority	100
96b2d991-6bb6-4f23-902f-6548f7e5ad97	816541a9-f00b-4ad9-bb7a-52e486f0ff37	keyUse	ENC
596a3c20-5bd7-492d-8712-a5b982743c1f	f9bf1944-6bd8-4d50-b811-c51924e38df6	certificate	MIICmzCCAYMCBgGRM6fv5jANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZvbGFwcHMwHhcNMjQwODA4MjAyMDI5WhcNMzQwODA4MjAyMjA5WjARMQ8wDQYDVQQDDAZvbGFwcHMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDJEaNg/Y6glTMWdkSno43VMNCVUiZEo4MDpHwMmVywvdO+Eg6DxtmdrF8VRGjKovPomQ9GI/drl491qcqSzPc+loyepQHli8ua1oOHsGHcWxHxU9cLdeUmmo4uZFRHBGGvwUzGyykn4FUuWMnRwWNaRwAicW20OmUSJOoytnRKTVyJtaY3ga9n3y2J23KqYoyyEvwxt5Lh5B5lyGRtcD7FGl90lFZx25ocljama02aT/qgbfvfX//WVdZGkAmbNverckXbir4sRGqITtYFhZc/LZEAfXQ+lpq5Jcv1YGL9Ber0S1r8mXMFBf/WdXjhrywL/yJKQIU7qxGUrxrEki6VAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGvfYai2t1mmKCLLN2KUMvS0KU6Bdp2mH/z7GDculvuwDE+ExUOf1Pgr+Yn7Hwaod4EJL+lee0eDmzZG8D5Y1ch+rF+Q+cizktF7qJwYcKYnl/VExHGAO9nBVycsDPWGU/QGrPzl17/VSU5pseX+BCrg67TERzB7c+r8rPwhPD3UR0O1uFobdf/uYAAJHACmxSBXO7G9ov0LdNn4kwEyyyHHU+R0CF3EYfUwcF/yypbT7HrH4OjNcU7WTgf1pBojZuFL3dWSwII+34SsqtaDajV+oDTZS//TEfpE+LnTqGwqL2sKd0Buy49cOKoIeZjLs3XhCktN9PLfECCZHs9g0rw=
268a1de3-a249-4e95-81c8-6841381b2c43	1fe66da8-218b-442a-ac69-a86fd3803b24	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
cf482338-02b2-42fb-bf46-493ecdc8608c	1fe66da8-218b-442a-ac69-a86fd3803b24	allowed-protocol-mapper-types	oidc-address-mapper
167c8a21-e5bd-4eb2-8078-eef0368cec38	816541a9-f00b-4ad9-bb7a-52e486f0ff37	privateKey	MIIEowIBAAKCAQEAitpTOLtY0eYgqaP3TGZFd795BoakIqN7AqvRSdsFeorkubrEvVmf09fjXTpF6NTyOD7YUj0cIhUrUOSHXLZyLMC2E5bYSiMRoxjSMwdlpfRNq2OpMomZ5eISf1O5A933qDk5aN9lbYLc9ASVm+bvAaVomvzs2YchfJ838hpE3LCum9+ERLdrssaP2djQVWg1+ElPkgZMPIazDIagYJr4dSdNGQ1PY3jogmI49NgYGNMoe0BnvSGkm4cjkPykv/bqFQrds4WAsMFe+uNG7qfMhzd6EMq5aWaaeyfk/FbzGzO3n8QLPSIBhRdSBVhaldJr0K3Bh0FpVN+MLS8J6QoIRwIDAQABAoIBABTAk5k82ttSxG/w2xLhOCGxDW1YbdXleWAz/g1xPWI2uao5NpKW1LMsfBqLYovCrnQ8jvJ07Vb6CKVy5Pjfewn4QAjbzctVbsXhqEzLHrniXOywHPIPgbT2CE4HsnUDADLKtqtXXrPdepjCdKUT1dsjoGeFmf/a2To5xk/vSs/Gzzur2H49VFppd5dXOlnz4LU4aGy2iB/irrtp/JUrRg8oXisVesB7e0Hc24Jc0t/rdA7PBg4jSBJbkNnMBibkYKepLBk2Dwl6HSfSZYunelqbQeGPI9dtTL7Xw/lnXSKBb+1tKJzSH9VPTGs2Be7YyoJGAeDkNFW4qJm6r73B8aUCgYEAwGWVuIMOkvKjhhA0of3s3Z/DL8R8bpFnieCTWsPyK5D+3qAqQ6n9mlW3tOGNG57TsXGhqdf5hRuW6X2A0esAUPVWuCLD79AsXgwCjD8SDQMY8gGm1KxfMkQGQz+ROT/B+AVR2A4ZF9Q9l4FslGktG6O47Sz6Q0Sfis0r0xKCUK0CgYEAuMFZLndoJN7O3c4vX4nYPfwe4MN0mGIq4CCKW1lPYMR4O/3JJ0gmHMf0saI+ufvmQvRMrFhE8QRm43tN7f+Swas5MNeIhGIa2j6VUQ4TVR0BLA9f+GDF57r0GTpRT1RQVKcvbNqWOjfgInsKYVcBuLpAtA9DyMWro5aPYRR490MCgYACcIdQeqDxrg/ywDvanfyl5sOz1Fr7j+5vKiDUMs3cTY9dxUwj5YDotxOIQJ/obMAkbNtu6uUoEex883Fxt/geDq5V0WMIpGwbmS1jF92juplTYD/8TF88pO4rZh/ySOOtwGuEQNGCotdRF3wH+blvs0jCASL/PVyEhwt6Nq7eVQKBgQCTaGjAQzMLn93LaNOxVWj746m7SRdA8aol0rCxO6uymG8Z5l3VAqKt+ffItpt3hnzsVMDMDU1MQ2fX/ixqRKyR6wwhZQYeIawtDxvRZPqVwSOLROUcZhHg1vAlJLt1IN9K+21CW5Da+HPS7vqUOXg9LBWt1DQP/273gYv6N/xfwwKBgGcdwN7PmPe7ggOWQeXJwMdt2gtEvzZPpr+vfSQOQsLS+EVBgZw7dTr0H2ZJGukuEqhUuGjJP03HvDk2p7+R67XNfDQwHc6CcYrNn+2A2ika1JmSFHdij9Tz3m+wq+cmvcPObyqbDHIhe/JY6UB13cM9OYMWqfbA2y+aPmtS0fsQ
bc15b68d-ab5f-4170-887d-5ce05b1b5b1f	816541a9-f00b-4ad9-bb7a-52e486f0ff37	algorithm	RSA-OAEP
58e9024f-cf52-436d-975a-ce031f037fde	816541a9-f00b-4ad9-bb7a-52e486f0ff37	certificate	MIICmzCCAYMCBgGRM6aI1DANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwODA4MjAxODU3WhcNMzQwODA4MjAyMDM3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCK2lM4u1jR5iCpo/dMZkV3v3kGhqQio3sCq9FJ2wV6iuS5usS9WZ/T1+NdOkXo1PI4PthSPRwiFStQ5IdctnIswLYTlthKIxGjGNIzB2Wl9E2rY6kyiZnl4hJ/U7kD3feoOTlo32Vtgtz0BJWb5u8BpWia/OzZhyF8nzfyGkTcsK6b34REt2uyxo/Z2NBVaDX4SU+SBkw8hrMMhqBgmvh1J00ZDU9jeOiCYjj02BgY0yh7QGe9IaSbhyOQ/KS/9uoVCt2zhYCwwV7640bup8yHN3oQyrlpZpp7J+T8VvMbM7efxAs9IgGFF1IFWFqV0mvQrcGHQWlU34wtLwnpCghHAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEWMf8ZPzMJK6YZS9qxv0nnBknDmKX8Yq44dp15d2ymyDPoN4viRXwJ/1EDiCju/sCclvv5jjv5zTRCAfKDhbkAsBwcNKjIKhsGIpZ9bhdzIXexRhLx9QoQ8gjnobtVkPiIXIGOLzo4IyYVSj0VUWhzSCq3dNE7YEqEYOgyhP2ZBmCavqpkUPhF+KB5JHUeIfRsmJsWhh/rXBRSK7gPuxjqXhQ8EuDl+aDf4T2tj17bLOZsnR5Dp5GtPjnuJD7NsSpiwm7BJTxR0I3hbeL+20S1FeIW4JLXC8XZGJ3xtUc1ncWuzICjRDeyxIgizKXuKQOHTpaIvKsAVC2zV+tkOHTg=
4c73dac7-8beb-4222-973a-e844776b0000	816541a9-f00b-4ad9-bb7a-52e486f0ff37	priority	100
d18cd63d-09af-4b2a-b952-2a66b83936a8	8c32731f-70b5-4465-91c7-7cd1ef795d07	priority	100
caae2c09-c105-4769-929b-977671a150b1	8c32731f-70b5-4465-91c7-7cd1ef795d07	secret	_ziiA68ECVgN2OwJfdBPrv8psxXCpxBPTALoL-lVDa0Mri_EcwyI8ZQ-is1cdIw4WrLg3zkyr1eyKKYrzobqNe9VMCeBW7R5_0sxp4sV-Z400M9kzfWh91gRLNA01b5cM6_WZGsQJ-mJnbNVuFmENQ-aUWXmEgIAWVSYLMVKwsM
4ff52714-1c07-4c95-b2d7-082819c4d13c	8c32731f-70b5-4465-91c7-7cd1ef795d07	kid	785be119-ffd8-4161-869b-3f1efdddb1fe
2213f6df-4096-489a-98e2-b1dda864cc99	8c32731f-70b5-4465-91c7-7cd1ef795d07	algorithm	HS512
f66fa387-644d-42d7-9fb7-07fac5eab839	8af89d6f-48ac-4fd1-a3b3-3443a4e01b88	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
8dc7a7ef-8a9f-4511-aabe-334d212ef0c2	ea97647f-5089-488c-b30c-5d61d1972a33	kid	f739e1ab-b956-456b-b3d7-c368a4665f38
6b131856-d7fc-4ea8-a920-74123f63de18	ea97647f-5089-488c-b30c-5d61d1972a33	priority	100
44f5a084-0218-41d6-b0e5-41ecb65bb6a9	ea97647f-5089-488c-b30c-5d61d1972a33	secret	vprWoyKeZQIwJsB8otZnoA
313d1db7-5eb9-4c44-8ef1-ce358b820e85	4a2ea3b6-be43-4fe8-a774-d1381dcca2d7	priority	100
dfcf2c3d-155a-4507-bc6d-643b3b4befc2	4a2ea3b6-be43-4fe8-a774-d1381dcca2d7	secret	BQrTqeHA7gtvCHx_qe61LQ30mtxOhVziX0ycAR7HKkRV7ZToV_yYMFcgMMl6uUN1gEf33ICLtlL9G1wdKVQQ8IybKhCUBpWc_R96P1eTWxwlioJG2dbl0IZoQTG1CrcTFQX65jferuxhyfsy7UfES_h7FQt9t8bPIrdn1Lli7_A
ac5f4157-238f-44ca-9ca2-e1f5704f0af3	4a2ea3b6-be43-4fe8-a774-d1381dcca2d7	algorithm	HS512
70bf545f-7afe-4734-b04e-b896848f65c1	4a2ea3b6-be43-4fe8-a774-d1381dcca2d7	kid	8917a42a-c4d4-485b-90b7-60e650e67c97
1846a48b-c935-49db-a395-979bc9df411b	f9bf1944-6bd8-4d50-b811-c51924e38df6	keyUse	SIG
53c681db-c8d8-406b-8d8d-4a16430427dc	f9bf1944-6bd8-4d50-b811-c51924e38df6	priority	100
fb5f0bdc-bb94-4819-94fb-9d190f6941ba	f9bf1944-6bd8-4d50-b811-c51924e38df6	privateKey	MIIEowIBAAKCAQEAyRGjYP2OoJUzFnZEp6ON1TDQlVImRKODA6R8DJlcsL3TvhIOg8bZnaxfFURoyqLz6JkPRiP3a5ePdanKksz3PpaMnqUB5YvLmtaDh7Bh3FsR8VPXC3XlJpqOLmRURwRhr8FMxsspJ+BVLljJ0cFjWkcAInFttDplEiTqMrZ0Sk1cibWmN4GvZ98tidtyqmKMshL8MbeS4eQeZchkbXA+xRpfdJRWcduaHJY2pmtNmk/6oG3731//1lXWRpAJmzb3q3JF24q+LERqiE7WBYWXPy2RAH10PpaauSXL9WBi/QXq9Eta/JlzBQX/1nV44a8sC/8iSkCFO6sRlK8axJIulQIDAQABAoIBACWfVAV+ND2WZUaG7y4583xIY8MI6cmumcFo+eAmoxocDt5yBP7Byq7O1cTGNeBysLZdS2cZrD5Yz9pZoKKq0PmIVHwLzojLyVdp25ccWRdRABC6mhKWJwA7665BDibyqi+neOz6jzMbrfyb1vmVWLiH7/3B4R/XzFkiiKLgEm7jaVi3+3fT3GzdJNggWwkD/8hwLMGrn85GT1qxSldOVJcyHKJe0iYx5tQs9/wnEnDpA2O2gF9iZCYiHIHDpvXm2ibnYc4TekThxF3oFM6cB/5Cw8+yJ/Ky+u2AjLqU531+d7Ch45oehEHTFOAAmxNQMXYc4NgzWsurgE3OKknoo9kCgYEA7QR9scCs4BKSG1dD5RxpZbcJbGBVtdC66o4eH05mUMOiD2BYxwHR9o2UJeu76dWKo20Wp9yDqfA2Dv1DzmcAoItBdWbNwiHaNSqIS5+zmr6jRcK+Ar5M1ukKz4omE7gcyCV4EYWpifrVUdbUE87P1+0jTMI25UoNWHQdrUN02fkCgYEA2SwZ/QmwTsh6n7eYc9UhEQ0rUzT9kG64d9oYHA5BhSIpw6p209fwBfUGJK8ztjWQ61wSq3AgaDJJHvQT4wg1hmkISLA1bY7hB+DrzjHM0Tw4+r+dRBaBKvJz10L7GEyJX3OG1qqBEg9IN/vEzJ3FoSMS6BAIGdREs8Vy/lORwH0CgYBbIiHuaeZO1fUl3Bz4CD+iY4mVCUmLejGUpIaChROkNESo4uPfyRxhT7jKB+UeGQSQqA5RBuH9QqaWht0+jK5aDJFjwd6VqYyMaskzQrm9Y1XGKgYDagaDj+GfQUA4zs8KShXrrtgsfKzvJcovv5J9NOogxoBzE1EkVKlgiJJyiQKBgQCp7oFTZ05nByY0bcPD92RNZGGfVRqH9qsvVR+CbIFGPIozieI7N3+gGa8560HqdJW2JLCTJ0SkY5yltNUO1DCVwP/zaLYVyTQ6Jvw8tukOXDI1utPDIFzoDxknukiiJdlkMBC1Tmt6hyy6aa3/cgDfaoNzxH+iPl+Xz4uAiEHHPQKBgBp9yg45kaEvLtTlt9WQJaW25ADMNEC2MK5MG3glI4d2/ofiz9HSg38MEMqiOcF5l6NgFP+YPW7m0wo26e5XwK5UxITDRuHwBV2cM6GLbmG84D7ijlbJO/7XJ3EAYfnWkEvoMh3n86oQVW9T41ftAXxSq5CAOfjG5h5wOw+yQBHZ
fd4abe65-a7fa-46c7-af43-41c2fb0c3e2b	ac4c2880-2551-4f80-910e-75c9223f7c4f	priority	100
21ff2b0b-e4ad-42e7-8fd9-fd9e6b65be22	1fe66da8-218b-442a-ac69-a86fd3803b24	allowed-protocol-mapper-types	oidc-full-name-mapper
ec3b11b6-f497-4824-bcc9-eb906964432d	6971eee4-21eb-42b7-8af7-af00aa09d4be	privateKey	MIIEowIBAAKCAQEA18YK/WXMMtYjcVXC6giFtiFp4bXpFjp+ckXMSEbbyQW+NDzeKjnUR5sJQfVhAmRC7PbvnpJI0uPxmCjACVc0D7wVsG58lM1tno6tHAwr/Vzx24rsLIFhVslVBVmFfRI9B4cAnn0z2y3nTpmz03PxXdMuXmsL3b4pIETyWNcr5jg0chsuludWqQiz0Hk5qpyv++z+Zo2GsYpw7kDvCXrl2KsM42spVYs66apxNGNwFK0cZznpoMcGgjZ9o+KBVZPIVGgdU+6Pyz1e3GKA1i9LigBKV1nPW40tWfPD3bDIdGmYYUyJDof+jUglMB5WCA6QORn77mQq6BSBAA7VGO36tQIDAQABAoIBACKCyGszBu/ylASihORNrKUuvvKc18T4YhUA2OWOf8StKHjOa3IxgaRaRabJClUJmDKyZCzmlMM2NgPyMJTN38PMf2OSqFZcbPX5N/LOd5K0dPJ6S7/qiZkJ5pFOei1A54X2r8CpocuikeZeawac+rPY/QeY83Lp4UYKAQD4mUre00CTSkPl5LUX+hdefdSOpOGaJ1IpBBojAK3GpRqxK9MFqoam7uEzaCFjDNDOrvDGMf9Cxdzv9vcOAGdbIeyTOy3Q1GdMGLa4s5uxT3lGqtwpvSzqHbInjti+6Dl9v2x0orPHpxQuebLWy98CfxQmdWWgEwrsTIDvc7eynBMAGpkCgYEA8K5RPHfHbpuya6X3FXja7D25/R+AqzNIizrT9CeleaSq5LwmQ6UiG/PA/FJiR8Xe2PPI4AWhvchoOYsVF4alYpslVpWt73/0tygn84oEO/qgHxFPLMaYt30tA5/jJaLSnmW5HzLnrQTFqYyopr72DQnHLcQKzRL5yd+u8MoiZzsCgYEA5YHiAZOeG9psVMjBBnh5SpmKLAKC9bH1PREUTb2VX5iilGM3R92V+kIVEh7UX0W91R82fjUo/606kex2Pc44HIb/m7UCJv2JLBDqUaSGyiFP0mhMtVT8QFH2jBCGJwn0x9tgvVbTafkJuB05EKr+ZB3yg6bGZ2zFajcg73RBZs8CgYEA7QXusMsRF2ez3XmzjGzZxH/Bk3sbvv4hOiR0KeWFe/dj6SE12bZdkgOKkbMcYKyIG0ZyE9TYBUvBALJs0h9i7mn16oA7rDpqKJoeRiQsqVjXqeDlBSaLrWBUHVavXxgrrZxmJEiAig7CDoicaqJzNEHl6rc/H9jJMDreUPnvyZMCgYBXI5hfBuBKLQVir5JyVX2f8GoAybdVeArn87skxS2YzUg1VPJhS+WszjhX1/LEdaNc7uvuwVpesTQCwagnUUwGsM8OHIzDpxHU9FszQmeXCUzYU5eEZc8c0MHubjuxSNtyon25heThYJfrGtVW2cWa17ADgmfkTu0ppeLQZ/CJCwKBgA3UELSw/W5po2wZD2hVlaszwAwbwzjr15dggTYg1ZcUaxZbudFZc6jF4Trohx+XKFTam8KPpUv82EA4DWXrMpywYAEFa/U5rLhrCLqLbH6uPsAR9CkBaFEDOg+8gxgEwV1oZ8aHYiMNJF1R7UIIDKa6+DCvR5j4R/TmqU/NRAdL
c708c90c-ff11-47a8-888c-f9b55563463a	6971eee4-21eb-42b7-8af7-af00aa09d4be	certificate	MIICmzCCAYMCBgGRM6fxGzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZvbGFwcHMwHhcNMjQwODA4MjAyMDI5WhcNMzQwODA4MjAyMjA5WjARMQ8wDQYDVQQDDAZvbGFwcHMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDXxgr9Zcwy1iNxVcLqCIW2IWnhtekWOn5yRcxIRtvJBb40PN4qOdRHmwlB9WECZELs9u+ekkjS4/GYKMAJVzQPvBWwbnyUzW2ejq0cDCv9XPHbiuwsgWFWyVUFWYV9Ej0HhwCefTPbLedOmbPTc/Fd0y5eawvdvikgRPJY1yvmODRyGy6W51apCLPQeTmqnK/77P5mjYaxinDuQO8JeuXYqwzjaylVizrpqnE0Y3AUrRxnOemgxwaCNn2j4oFVk8hUaB1T7o/LPV7cYoDWL0uKAEpXWc9bjS1Z88PdsMh0aZhhTIkOh/6NSCUwHlYIDpA5GfvuZCroFIEADtUY7fq1AgMBAAEwDQYJKoZIhvcNAQELBQADggEBALJP0YVcq+e5765KNh+yEhraosxHEgSLUPVXlrePC4gGoQxtmvJPPewmaFxUa+tzHTGYsQpV1A6roUmbCuorMe+VT9ssW4/eNvy0ZyI1VuBbziZYCCaM4Ib9VFOgQGmZruTuwnqdDAcAaeSf4mpwg/fWzRuJqNkW9UEQva98DxEY8hMwNU9xlVNGPd4DhDSKNtgh3aWtJjFr2ACLX426RFYrzA2RKSBe8/MeIU2JRSttGkQ6UibRpoUY3nAHdsu+uVGIZtoMXTvY87Q5DQ4mHYwx/9aFaEfbsJGUA78FJDMCnlLhqF3ldouWbhoJ8Z8mUZGmeoKcr490gtESjYkEG2U=
817d4e05-2752-4e2b-9998-1dc98c16239c	6971eee4-21eb-42b7-8af7-af00aa09d4be	algorithm	RSA-OAEP
8d1401b9-f507-41e6-a405-30b4c7d77963	6971eee4-21eb-42b7-8af7-af00aa09d4be	priority	100
80bd3687-a3bb-4cea-adab-d0811a81f623	6971eee4-21eb-42b7-8af7-af00aa09d4be	keyUse	ENC
0363e3ef-9286-41b5-aeca-0cb23e320ee3	6bc03ffc-7029-4eed-8bac-f4693a887b0e	allow-default-scopes	true
4dd290fe-6129-4336-adbe-4e7756ab7a6c	a36ab92c-e7c7-4521-8c85-895d0c2d87e5	client-uris-must-match	true
78ef6072-ed9d-4cc4-b24f-043776eae2b2	a36ab92c-e7c7-4521-8c85-895d0c2d87e5	host-sending-registration-request-must-match	true
9c221e69-fa36-451b-9d48-df9ecc534ffb	cce81271-81ea-49fb-9ca9-0104186ee345	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
9a7c8f1f-25d5-42c7-a37f-274fb9b23b67	cce81271-81ea-49fb-9ca9-0104186ee345	allowed-protocol-mapper-types	oidc-full-name-mapper
76cf40b1-8d29-42bc-889a-92fa2784318d	cce81271-81ea-49fb-9ca9-0104186ee345	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
38e5d8e6-c699-4314-912b-82b0f7a522ab	cce81271-81ea-49fb-9ca9-0104186ee345	allowed-protocol-mapper-types	saml-role-list-mapper
c60687ee-fba7-4913-bc0e-75887345496f	cce81271-81ea-49fb-9ca9-0104186ee345	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e3bac270-25d3-46be-a0c2-c4dab85b207d	cce81271-81ea-49fb-9ca9-0104186ee345	allowed-protocol-mapper-types	oidc-address-mapper
6f84a79e-261f-43b8-8222-4c250dbd6f8a	cce81271-81ea-49fb-9ca9-0104186ee345	allowed-protocol-mapper-types	saml-user-property-mapper
ee7013af-0f69-4b44-b3da-7669d7239658	cce81271-81ea-49fb-9ca9-0104186ee345	allowed-protocol-mapper-types	saml-user-attribute-mapper
c57c6986-79b6-464a-a0bc-feb742859f47	f6058763-7158-4148-b56c-50124b2078af	max-clients	200
9f4ad980-42df-41c3-976b-2a6e48d6fa1a	5e0cb8bd-af54-466f-87ac-f6bb368eade1	allowed-protocol-mapper-types	saml-user-property-mapper
16cb2bef-139d-4cc2-9b7f-04902cae9512	5e0cb8bd-af54-466f-87ac-f6bb368eade1	allowed-protocol-mapper-types	oidc-address-mapper
38e83020-1087-40aa-a6a1-81b1aca46631	5e0cb8bd-af54-466f-87ac-f6bb368eade1	allowed-protocol-mapper-types	oidc-full-name-mapper
4c97ac82-31b1-47ca-a707-c6d4751f2f76	5e0cb8bd-af54-466f-87ac-f6bb368eade1	allowed-protocol-mapper-types	saml-role-list-mapper
243ae86f-c250-4241-ba6d-ae8cdf298d87	5e0cb8bd-af54-466f-87ac-f6bb368eade1	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
1f4b0ab7-c27e-469a-8b05-23394b833e18	5e0cb8bd-af54-466f-87ac-f6bb368eade1	allowed-protocol-mapper-types	saml-user-attribute-mapper
7b732aaa-1d6f-4c4f-a205-c3b7fa18ba12	5e0cb8bd-af54-466f-87ac-f6bb368eade1	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9db6ca46-2bd9-4268-a3cd-df612dcccf5e	5e0cb8bd-af54-466f-87ac-f6bb368eade1	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
9bd74321-e3f6-4cf4-b335-538f16f7dc94	82a3e397-d535-4261-a2f2-08b83888f5c5	allow-default-scopes	true
e8928e84-1101-4484-bc0b-ccaeff6c308e	859d4bca-86da-4ff0-a2e7-cf0ee130f774	olCanonicalHomeUrl	http://open.odl.local:8063/
f6b3ab84-5fe5-4270-b9c1-8d240fc28211	eb435621-1a72-4355-b62b-ecd8c28c7b0f	olCanonicalHomeUrl	http://open.odl.local:8062/
a24ed0d4-0e46-4c9a-8092-2ca84af10fac	347d0045-8dc5-4b08-8ecd-308044029978	kid	8eaf6eba-f3f1-48b1-958b-48745f77ece7
cc271cf0-b649-4351-8426-7605b0c8e3d3	347d0045-8dc5-4b08-8ecd-308044029978	priority	100
d89319fb-8137-4d5f-8cdf-0a69890f004e	347d0045-8dc5-4b08-8ecd-308044029978	secret	TU4BOjzvbFQU9jQpi5VvAUMtJ_tqdY1VxN9pPQYbcpbdWuSS0E-OkA5XdIZO4eFURDCqRRF4gQC0TX_KYe82S7WGOWCB80SVO3ETEddCznm_JfGDqYRm2DSkwFHh3wEd34vMu880e8N-p8uQBr6HvNWGrwFzm7KfL-opFzJIUn0
997dd1c2-d70c-40e2-a09b-d420d734534e	347d0045-8dc5-4b08-8ecd-308044029978	algorithm	HS512
95f3e45f-13fe-4e3f-b6d5-caccdfe8a876	bcf43d9a-74b4-4734-99cc-b89e0e606d8d	allowed-protocol-mapper-types	saml-user-attribute-mapper
c07a8d00-9705-46d7-a116-ba44a3551ffc	3ba0fed2-2fd4-4fba-94ac-3bb1f3066f0d	host-sending-registration-request-must-match	true
f43b67f1-1d80-4b4e-85d6-ceb3857323d7	3ba0fed2-2fd4-4fba-94ac-3bb1f3066f0d	client-uris-must-match	true
86ef424a-c27e-4fb4-885a-d73485925589	da87c877-b66c-4dd0-842c-0bcc2af0a5b2	max-clients	200
45d56d68-8881-4845-ba45-44e369ab52e4	08a2f30f-353e-4ee6-bf7e-ba4fd0816db6	allow-default-scopes	true
a88ee1b4-807a-44fc-8617-4a86507bd790	ac4c2880-2551-4f80-910e-75c9223f7c4f	privateKey	MIIEowIBAAKCAQEA5vlQ8LkwpYC6bMfXWUKxiJEcgT8fBXSVa9DXnuaU0+4EdYVK4atewzUs3rPaVIoQRArivob/h5VVgDKCG4aiwZ3+hPjVGdiv6ZaVgDcMFIykeMjfu5gvl2tGu6X7LHGfEkNYtCJXQch86jr/biD9n0qAcGUsgc+QvleImvnBqU5G9O94QRUZIFAPeNUOBs727H1W1mFOvtgLVk7xUqXcHV+ZbGR1gAYBJE9sHlLWohyazrW9uVfWxCTCVMoU1R3+fmbDIkFjHjmmyDC73gWIjSOD0cy1Tsd5xSJPaHxkzcw+mAZTwBhnXd+vnuM6vOb2aIs7AfYAwhPUHgZiZEZRfwIDAQABAoIBAB0Wiex/DhLRxuibNFIv9YbC66mVRvVbbNPyraz70gNsptAcFMWd3OXNpRR45wadipXfHxYqjzTGiEmIUt1fk9C5covRgJjsMp9C0RogFJvj6HSzq4WHEXtKzdIlAaBjwMo+hAXPi1ikBKNFAdUfP4GXktxUyYmhl9N416HY0VxeW4ohetrUz3Xpvj9OZyBvu3t8sW40zg7sKa99sdygzJFNM15rsrjBh8AOMMlJ/lGGZMetwl6JRaJsJiqy8JL2+IN61bhDL4maq+LutiuHi46gXtvgZGGL10mgstFwQK9NbFDwO5upJULP3QL99Qsv2G2G2qZYMwyikEm0qEfo32ECgYEA+TybXT/w94IcfiIC6szQuVN2fz7X+nqdj5CjJM+86WbD2vtgkCvt1YMa+ze/9l5O67YVbkrwe0foy/4/9kcRuMZJqgHJ52GU6/NLdJH8M03oH2Tujr988JaWQy4qAAFv0Arf90PXw1kxwQVnf7b58falH9MVsa1v7xY2Qrjd+eECgYEA7T3XWt/msVwo3KG4/Bp39FQV7z7h1BDLkBVnhOntrBGSxlDpD8LpLeQsNfv3hfkvZN6zUoIgUqOt4q2KEHnesX1jLNnIFm0IEABg7NfyuAQJu/qftIL4cEqiLiAUQzhz1KIRw7K94+4wKbkDYgfOSpQiDo2PiyaEobsAL2ifd18CgYEA0nzw6Uv7Ac0MqymmNQ5MqHdoeAZm+M9dCcYpQgl/jc6QUfxCjP/MmKlkvA1VPYhgNolMiB0aA8OzQ7Sx6BgVS2uLAt0H2zV6Q9rxOr2ftORyyTDAmCX4KmfC93GhXufXume0xmqxafWGI3Gg+ydY55RZ2Aq5I5lKEy07HhZqwYECgYBkt99oriuzWmvilyoApYANk3Eoe+rF7EdvqRakv+duKJvGY+0+CsKSAA+g75K7Jvou+bjpq2Lrkp+s334A1qxrb88d6Gtg0fMdT/vWMSvTYat8Sb9plDzC93x41pejniDWweOG0Kh7TtDVtb0w7h1vXgpDYWfybGzceJZwihtBQwKBgCHQS1u/NHiXikGA1A4Qgos+5zahZLa8rKCe1IH+cUmOQBBSj5A9yMsNrQTzKwSPkN1gJJBjBCC2Z7QiV5gPb82GVbwl+se1KYzgKQCGZmumwCbnC4PvjGc4ZKXuBbRryPUFE8sksxYzgEasTkf+xQ6eghAfEWvLo1HSlJbCWzvU
43696bd4-d93c-4dda-a1a7-5937d0d4b8ec	ac4c2880-2551-4f80-910e-75c9223f7c4f	certificate	MIIClzCCAX8CBgGSEI2ipDANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDAR0ZXN0MB4XDTI0MDkyMDE3NDc1MFoXDTM0MDkyMDE3NDkzMFowDzENMAsGA1UEAwwEdGVzdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOb5UPC5MKWAumzH11lCsYiRHIE/HwV0lWvQ157mlNPuBHWFSuGrXsM1LN6z2lSKEEQK4r6G/4eVVYAyghuGosGd/oT41RnYr+mWlYA3DBSMpHjI37uYL5drRrul+yxxnxJDWLQiV0HIfOo6/24g/Z9KgHBlLIHPkL5XiJr5walORvTveEEVGSBQD3jVDgbO9ux9VtZhTr7YC1ZO8VKl3B1fmWxkdYAGASRPbB5S1qIcms61vblX1sQkwlTKFNUd/n5mwyJBYx45psgwu94FiI0jg9HMtU7HecUiT2h8ZM3MPpgGU8AYZ13fr57jOrzm9miLOwH2AMIT1B4GYmRGUX8CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAe4npOzX01cJjbEpxtwyaLxziJyTu6KsI7UjCpWHg8tNIGOYxisGo+Ce2V5zUlvxt2A+70Q91uofytUzhPdn4GDYpoA5woPLA6TkE+yEza3V/oTf7EejLvAncJeZnx937hEkYgS/F+E/+ylD1cH8qf8Ou/rOwNzXksl470ASdL8BxYAYELltkWBTAATPo5lKnzukpdAhl0umKiSvwXQwciKTltQjz6m57Jra/oAneRyiesMVQHnvTr7FZi7oJn90EXNTvBZBqBuFz1ZH1wh4XnufDiDn1QxY2lCrjkzSSAhI4H8wu+ZBTZlSAPNbSdrYAPaTfmstLb5oiVZiJ7NfB8Q==
07acecac-3516-4370-8207-7f6a8508224b	ac4c2880-2551-4f80-910e-75c9223f7c4f	keyUse	SIG
67c1cdc0-0f5a-41b8-b817-e241f62a051f	679ef00a-7555-440d-8896-9023ae5bfb62	secret	OT0gckxCLo6-F9J2v0_O-Q8tScuUh74vrpRjus7kLCTzJ7iIvJ1aiLh33Plk8trFn4BkybKe_8K8zZRrVyjpR0AOP5mOFYGCXU2uRThJte9LldjxHvBSZbOkiBZ9w5MVi9K0-SQw8HpQ_DwAB0x3JUYFK-mMVe7s_HMsDL8Jr4M
91ec2d51-823d-42c1-83cc-de039296ae52	679ef00a-7555-440d-8896-9023ae5bfb62	algorithm	HS512
7a1b6248-beb2-414a-adc9-ec435b6956c9	679ef00a-7555-440d-8896-9023ae5bfb62	kid	24b7ab50-6614-4ca3-9a71-cdca7d83ca1d
bd1bcc4b-0c88-4eaf-9a63-a4c6baf40079	679ef00a-7555-440d-8896-9023ae5bfb62	priority	100
6df58f17-c590-4cdc-ae95-8c74107b659d	f399ac6e-7e92-4aab-8830-390d8313822f	algorithm	RSA-OAEP
87ffba8a-588d-4f0e-b290-6634552c52f0	f399ac6e-7e92-4aab-8830-390d8313822f	keyUse	ENC
6ae07f0e-dcf7-4b83-bd85-6d76562230aa	f399ac6e-7e92-4aab-8830-390d8313822f	certificate	MIIClzCCAX8CBgGSEI2mAjANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDAR0ZXN0MB4XDTI0MDkyMDE3NDc1MVoXDTM0MDkyMDE3NDkzMVowDzENMAsGA1UEAwwEdGVzdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOiKMJPQbn16KImhyHvmaMbXjtyi1iwh8A91T9X5io5MVgT8bPyQfO0KhlNAehkS6NG8iSMxfBCWuJFEWexU2w24/+P3XkQdlAdp6CaE88iT4P3T3Ys7gMPMLfWHbPpa+a+Jr9ww79xkiPozljr+zsfzFhXabvYZ7WRCVWaowqn77z710Yn5gtGi8ITtw40KNC8wh3x472+TawhOMqy/CQbOJE4HLHp7rRxhq2iNnusKHTyWm+7yMDiHL9xfsfcke2S/sLtImHTa78b9lLn5rv2RRFtNlBhEYCZP/Mdh9s6CumbzJlj5G0GHrfDFdU9wsSdZ7YYHUXo6OoDcpXVaeUkCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEACd9UvS6pia+ubt+Bu3jXJ+VcENGj8ev2hPg0XE/QaASVOjO+wYKrnHS6uYXjs1n4IurdVF7Tps4nD5EygdDla5mmcaFBYMByo48Kylm2NFZ9+HIQWNOIUuJjPwhJBV1QT+izG98XliB7/pVTJvAyDzHH2FNbaNG5Hj8nMDgk0GUCufxw45lECKRkYYJTCU+lyQ9fHHoM9wlgPvUt7y1GHCPd39Xzk/RBEALdb/NfBba+zm9I8VqN7JP/IrUAb3JzP7ZvcXZZV5c+50ZXOZUHSg9YNTqicvysWGe0Owljpzrzl4jIdElC6tTMNQDx91whdJ5Z7xduCGPbdCjAKT7h/A==
93799ba1-e873-49c7-83aa-66f8c376926e	f399ac6e-7e92-4aab-8830-390d8313822f	privateKey	MIIEowIBAAKCAQEA6Iowk9BufXooiaHIe+ZoxteO3KLWLCHwD3VP1fmKjkxWBPxs/JB87QqGU0B6GRLo0byJIzF8EJa4kURZ7FTbDbj/4/deRB2UB2noJoTzyJPg/dPdizuAw8wt9Yds+lr5r4mv3DDv3GSI+jOWOv7Ox/MWFdpu9hntZEJVZqjCqfvvPvXRifmC0aLwhO3DjQo0LzCHfHjvb5NrCE4yrL8JBs4kTgcsenutHGGraI2e6wodPJab7vIwOIcv3F+x9yR7ZL+wu0iYdNrvxv2Uufmu/ZFEW02UGERgJk/8x2H2zoK6ZvMmWPkbQYet8MV1T3CxJ1nthgdRejo6gNyldVp5SQIDAQABAoIBABJ/M3/+e1t1xRW1jbn1SO5QJSf9t+WIyYyhOzl9AP1yqwD4hz7Ly3QbezXSEiQ+cdCFG6919zVml8XOVwzKbyY3Sft7KL9oTucMEJBH0RBqWuI14RB7KjHo4tr967g6VlQVMqzkI6A3SwID6nZE4HPdLSuN1Xez9kMcV6iz0dAteDEfKj3Ek3S185hZtumGKLMPRu0vEfXpSSPlM8OV86rFmiV6ZkkzeO48RvNxTYpcSBsPYIclORRBrgB1BlXr1K8apPNL7uG0B7uDKi+aQv6UpISr+Oo5v0JdAGVjfg52Fpzc4IacyJ/T1JvAjSaqjTXAZLMLN+bSCcIfRYB8+YECgYEA/Z4HyNmGTDdoIVhcVneKIjDbHop5mV85AK05vqmPBlpzS4+E/cU/hoZBleuQgyqXlsuNnL93QYoQUY6M/H4iFeafiwqnTFpu4wvPZtTzgXu965YxG11J9l9v5IaOmgqTKuCTyiLrPcF+6fEDkoexDk0Tcyrt3w35aSkWyJmiyjkCgYEA6rl3XwZALdjfHA/41awca09pfuxNESqQlDxrcK77NPkyF03HYyA0POVTijtRn8VEyGB2SEgYdbR3pDPX+T6QCxaKag0bLLEji4BaowdUIccvE11rjkdxkxI+S7MB2IUSB+QYenAJFxLk2KUYnYb9XvhydOImgyqybNwqppsRZ5ECgYEA81bKf1L/AWf0GHJwfmJJ/k5EH8SbsaXkyppqml6UJXNpxmkZIGg+cHOmwBL6YG/gbMY3xNsMsKyoxafx7F2VlM/n6n+5T5BBbsWpJTBTx7wT2NQNoATdb2/YqzrT3kchN3WtN7hTX7ilbg9a7yAUqPUZIVpiS69bzCOpgaWvxTkCgYAOaYTi2MdoCUDpwDFPLVoxXJblrCyvOSXXdD5ElPnnrsVcmPH9LCUI+CvA+RNx8/LdOs8IcSTPVV1jP6urKiQ+CgxFprhcbiP4lND74Z9Q06IYVkwcWFao6R3aGAus9767rU2zdt2YBRj4FGsGgRtdkXO1qY0j0KNT+9DCmhLfgQKBgAe1msDhxRru7MWw0PzQGleLeH26ezpaj9DWcfWL5Xj4u8bBOCd4F7zGhYeXzM65KQwXXHBFrn6NOsOFRGTb8sQGE9DpJYmoPgwTaPojxfubTwcFiizaPH9lkFmBD8dPYZ8MEWubfQU7crLE0Lib9vMDDfKkkSMdMyLoZxLgJlIA
43f02577-3413-465f-b67a-5194845020e7	f399ac6e-7e92-4aab-8830-390d8313822f	priority	100
81679dc6-9b15-4711-8f87-425232510acf	f214c716-6f26-4d6d-ab3c-5c2335faac45	priority	100
a5755683-f5eb-4f96-9a1a-3dc7ee9b95e3	f214c716-6f26-4d6d-ab3c-5c2335faac45	secret	PD-wJi1bzcQoK1JTKeWfFg
66000982-5206-4d29-9cb4-48a3ae99ef28	f214c716-6f26-4d6d-ab3c-5c2335faac45	kid	4290c768-c332-4489-b440-763440857fe5
68b9a50f-ae82-4e37-82b4-d71e3fae4878	55deb522-9756-4ccc-9345-dda70d75696b	max-clients	200
62a2d201-d67c-4bd4-9ddc-5aad4b0dab76	358f74a9-3fa1-44e4-ba15-2b917601f41f	client-uris-must-match	true
10a347fb-31f6-4d7b-8546-58b18213d812	358f74a9-3fa1-44e4-ba15-2b917601f41f	host-sending-registration-request-must-match	true
59fd1563-f1cd-4b39-9e3a-a4b29c89aaee	a4f9f73c-01ac-4d8c-9798-7c2ad6daf6d7	allow-default-scopes	true
abb7d589-7165-4a37-802e-3122110cf0c2	1fe66da8-218b-442a-ac69-a86fd3803b24	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
8ab7cce2-da7c-4e8c-9040-285394f7df79	1fe66da8-218b-442a-ac69-a86fd3803b24	allowed-protocol-mapper-types	saml-user-property-mapper
3a596017-b4ca-40e4-b344-47b6cb2feb1a	1fe66da8-218b-442a-ac69-a86fd3803b24	allowed-protocol-mapper-types	saml-role-list-mapper
8423bba9-b03c-43b5-aea9-48cee7eeb690	1fe66da8-218b-442a-ac69-a86fd3803b24	allowed-protocol-mapper-types	saml-user-attribute-mapper
3efbfbf7-4620-4ff1-a637-b8600953dab5	1fe66da8-218b-442a-ac69-a86fd3803b24	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
13927e7c-dc64-428c-869e-b8a50c76dcdd	9681ffc6-4bcf-4782-94af-c9ad6f1c09d8	allow-default-scopes	true
1174cec8-6e59-41b0-bead-4477dba810a5	34608685-5dbb-4060-b5c3-f6c6454ef22f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b5e376f1-4a15-4d77-9828-505212d1d43e	34608685-5dbb-4060-b5c3-f6c6454ef22f	allowed-protocol-mapper-types	saml-role-list-mapper
8cde4dd5-0d88-4f51-a95a-d91e09df7211	34608685-5dbb-4060-b5c3-f6c6454ef22f	allowed-protocol-mapper-types	oidc-address-mapper
9e5f938d-8e7f-40c9-b70b-e75cf466e32d	34608685-5dbb-4060-b5c3-f6c6454ef22f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
b4002a9f-ec5a-4c1f-a825-626160bf377a	34608685-5dbb-4060-b5c3-f6c6454ef22f	allowed-protocol-mapper-types	oidc-full-name-mapper
798b53ea-2c3b-41c0-a207-b98e5b18856d	34608685-5dbb-4060-b5c3-f6c6454ef22f	allowed-protocol-mapper-types	saml-user-attribute-mapper
a92927cb-5161-4651-ab36-e9dd4be3dfa8	34608685-5dbb-4060-b5c3-f6c6454ef22f	allowed-protocol-mapper-types	saml-user-property-mapper
a27b50c0-cfd7-47bc-90df-61c77b6249f9	34608685-5dbb-4060-b5c3-f6c6454ef22f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
777245bd-6304-495f-9329-8a503b8ad394	93df4fdd-eb37-4863-9212-b8e1c34a44e4	certificate	MIICmTCCAYECBgGSsA64ajANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAV0ZXN0MTAeFw0yNDEwMjExNzA4MjdaFw0zNDEwMjExNzEwMDdaMBAxDjAMBgNVBAMMBXRlc3QxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnBRbPmgOgcA4IXXawS2OxgDH+ApagSaM7y0615E3EjF+EZpVnHzC5GHKtMPycNrkRSVSIZN+Ub6Up011gqhysDkF9ZnU7q9fuYlJdmocO7936rdddSg3wtBGwRdQDEawf967VpMV9GwlLE/wfAPzuWt9DCxG0QzTFleIwPHqSgeesmpcpCYNNY1W/UrvIroTK8LPntA3VOvftS3u1xmLCk6julys9j+UfU77ROVMJcuRwRHRXoVT0lh2pfMGph4VRFd8nKHozqh24jUVfTPGTPRBMQOATaim/4aMH3MoGpfabgpmN4CrZLDcsc9onxdg4cWCAn9MmREL6Tqw6WEWnQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAFUluXI/RjrnneVlz7mGQcjoiqK8O9edTxrCkiRnbdFSX/GfiMuYAKvyMk+q35MdN5PRM++C6N1h7rXjQl+9ObfUMOpR7O1MgGd1yZ24PqpWhKuoLzFag53P+yl8zQg2LQzrV9eDof+FpLvDBoxKh5kAPyymNatRrk06ppe05kKv26XmcFhc+JDrqkPEgcrBno/SXiRRgILDjCIVQir0GWBC087BuSrqL08givT5eS/cUfG4KAwXirTXL7nliKEmwS9bACdOxZLOfA/pSacBAxmm3WLTtMDFzg8zZpF27NlnAH9g0Sw8SqCNWnebx1JlJwZDY2uN7H8Y+Segob3Acf
ec592879-c94c-4ed1-ba36-e7c8aade8da9	93df4fdd-eb37-4863-9212-b8e1c34a44e4	keyUse	SIG
1f76f1c8-f260-4d64-b5ee-564d4d5566d0	377103b4-3fb9-4d7b-8caf-94c39c038af5	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"fullName","displayName":"Full Name","validations":{},"annotations":{},"required":{"roles":["admin","user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
ab4d00cc-266d-48ff-9579-a308771c7c23	93df4fdd-eb37-4863-9212-b8e1c34a44e4	priority	100
d23a50f2-4080-4113-a614-0b0b2b992a4f	93df4fdd-eb37-4863-9212-b8e1c34a44e4	privateKey	MIIEpAIBAAKCAQEAnBRbPmgOgcA4IXXawS2OxgDH+ApagSaM7y0615E3EjF+EZpVnHzC5GHKtMPycNrkRSVSIZN+Ub6Up011gqhysDkF9ZnU7q9fuYlJdmocO7936rdddSg3wtBGwRdQDEawf967VpMV9GwlLE/wfAPzuWt9DCxG0QzTFleIwPHqSgeesmpcpCYNNY1W/UrvIroTK8LPntA3VOvftS3u1xmLCk6julys9j+UfU77ROVMJcuRwRHRXoVT0lh2pfMGph4VRFd8nKHozqh24jUVfTPGTPRBMQOATaim/4aMH3MoGpfabgpmN4CrZLDcsc9onxdg4cWCAn9MmREL6Tqw6WEWnQIDAQABAoIBAAHkY0jJ5Scgh+2r6pd98GWpG8N/iKJZL8s0fqqfWY4QaIlZGCGaB5jSMK1pVLaWiL7n2WuLyLO//jhbAYowdZd6UX6tOz4bhSsQJYJYffghdZg0Wd8yOh7T/I+Zs0A62SfrsNS3WsRITVkQrQcr2xgL3Au6O6+MGsECFafVJvR3x1ToKQ+nVqSmEtHplwaBYy65sld6NbR4uLdnRL6Je+kILwpcmGBMcEatuBMOCVdVJkW6p1h2V6GKnGq4oJMnutnmICPgdeNDl9YF6yUOXRCQXGE2AuG6EcJwxPwdPLcWoPYlnDYJTi2aNFGD5n9tCtW29hJQSs6ZWJqj7d0htWECgYEAzjn+FcWzQFxxUdWD0dT7xh6P6QuumHBUFgEz3/YYYX30lF2DACiLQxkG+WBMudTjdLn6vw7AvfoHpMnScNpPtb9/NoQ0WSiZRGYRhmSMzvHHaYmtZamriDJj9Qu64o8yo+OVWGC8sdvKSvuU5vNM2plIByq6i4IKngsAnhf/kY0CgYEAwb/1EUevHrHj9vuAkcD2oMqKCc0dDQg4rICWm21qtGr444bbDF/jf5eD259Ishiu4uguaHeAPuJjMw/UH+95TmZnKeadAKyChJzDAFz1jD4zJM0SFjbGBqHJrswd0w2e351x4K57uruGvFWnkntyJ07WzWcJgiHFHXrQEDh3bVECgYEAtlL1PaCFQtC36ya/HUOUuOsKRnpqiSE+Zhn4F/iGQ6NNGeK2z+wIe3DkBpPKIb2Cvw8yDbpoU017dohsQhPwxvmf6b3mXjETmDI5Kj05dDi0Ga18HNZt7cLHNr2BI46Asf6iaflUulZcOgDE+459EwLTeGqhdHerFWEa0arb630CgYBVOzp1lZFF8X+VQOI4PCjCZxb+ZMro1rsHt7GJQkL0hzJh9QsbkHslv+Nzk8iJAC6/BuCTeC5ke3akGcx5GAHHKWksl5RtnXX1HHj0CfDC9wHMqKHSP9oxRK7SRFzCYXWIbVyROHCZnrEQ3KVQ3RlEjXwU88TNCEoMQ+CPoid3YQKBgQCmU+jG3dk+p26E62PXTX62uBKswaDf1YPv4t9hvz5A9JOjLPnxPdYYq5k7wPAg1jT8O3aXvhfWhpGj3QSQNBjwmgl5G2R3aRAibrlCMNzW8EtSO1tOsUQ+yXL+qUHAe+s75MRHsqqACl3odB3R2gk9C/7t+tZPdDPZ1wCXqTBwfg==
c454ed80-a6ba-4a2d-92f2-5558fdb89cd9	1821b69d-462a-4ccf-b648-48d5cd78dc98	keyUse	ENC
acc18910-cc16-4e7e-b76e-8a53a1b96869	1821b69d-462a-4ccf-b648-48d5cd78dc98	privateKey	MIIEowIBAAKCAQEA04tCRgcudcTaoBdHydIH4mpiyTeNCSisDduj9D2lAVr3A/Ou8Nd3qlCW0k1fzwmcZwE/bX1KTcChUpIxsgXk9f8MgsYC6H0eDKK19509RAsTOgzB22TqOhcoqzQjzwH+4JJF+ra4f0/sCEQXt/SZ63jkOWUAS298L+5Ks2Q3FbVmR/XtmDhuaiKVBj1fmRhoTe+7Ye2niZ0pwYx2HqlPvPbt7fdHTcrE91y/l3376s6JtQQqvT+9eDNSgBzi6GXXEdiOW4s30YC0zT82p6x/EQgZLp5MYOXP9W7erdYN6wqD3IBeJhC/ogmrRtVz9XlnvQFf/nC4JU2i8/MFyeWTzQIDAQABAoIBAAUoCDciw/wmIlBCqtuHXXc4FC0flqxBerH/x5NibjStjy50BGHb3+gnkGu6f44MdCe9rkam3skFoJ8xUiXcCdhP9jbMl7s/K/UvWdYj1eSLjJCBIgZltKDQKz0Rs7/miO/X8iUxVGJpIZ319qKoaoVJicc3I0Vkrvm3gGXeQCzeFwjMeRLZ2tE6NXpwwLPiD5CmogGkFRFoBpAYVf5I3E3LkP7CRXldp5Q5bdqzl+EOIcUw0fNRvZlUO0egdDLSCyWVNjD1R2AJrJZNTPKx3Y/k8APDRsOvTPByF7MRvuTrSSOATArFQHRJeM9Zj6SxFNwLQxqasXqBS8Gg2gD/wtUCgYEA8kxwGVFIR30jCJbfGbvBYeQqaaiqZiIHHc5rVj4hy96JMjU6Hy7NLqRIx4qb7HEi7cZoJG1SUu2xDG2k2LzCJEoS+cYpCgi8LZJW7aGU9FYyAZvdKDG47773UNkzAJsOifaI8X9afwjb6sjuxyyMrUvxMNmmuhWbr5leBFz9zScCgYEA34Gce4SvN0h/zJSiLFG8GSwQ2pk8EOemt9JRcgy4p+UbLJ/FPjhmrGwKFQw4OJ5K938Z5nX+gKUdFJOHUQhoBwK8uolc8q+cuNa6vsyQ3/ZChltiE01atQi6Ud6cvw0Xqo6rRzopDpYuxZlknHjtkIJG96fPlorRoHDI3RV+V+sCgYBgVROcfTyHb7EmERXSXVudV+Gk8HIO+ShrKU5zk3BMZcWWOKNLEohxKs/kxa8IalLAxklRckVwwx/JGS6ZHTLyyqCQvcBDRQXL+IqnH77hBgQLr7RV7q7gYsRhWHl2nC9DmskHeuK37wXAavLELWog3Dige2hWQ5EKV6eRhIdDsQKBgAkFPSCLEVtE1MuX8Bej0NifO6rm5lK0VrkyhtD4jHdSOs+JPzespRAuaBXDYX1/ff0RJyVy+6uLfmn3Lk3p7fDifmV058hvp/6Zw/2xWeOAF90+UO4AgDmwOXzWZDMdvyfGDEmaok+RZh/ZegMKqmPbriuOnUUxIxa7lo+9r1SzAoGBALlvqWOuxB0Ln/3gOHYZ5nZkhfYtimAf4qYbOAKSXrVYcSHRF6HEjKjaeZnJ1+9HHCkbzRvt+cnjQTH7+G5QYz5EQAe9SJ7eIIFwVCqk3VH8+jTX4QRrVC7UslACXj1bpiClcgI1cIMWbS3bYmyog1l21YacB8F6PGuc5TIbZE/o
7129780a-2cb4-4de8-a6ce-3b7c97e3fc07	1821b69d-462a-4ccf-b648-48d5cd78dc98	algorithm	RSA-OAEP
c61a5cbf-0664-4f47-9001-bd7661aa9f11	1821b69d-462a-4ccf-b648-48d5cd78dc98	priority	100
26d8407b-4d1c-4571-831e-819527b54608	1821b69d-462a-4ccf-b648-48d5cd78dc98	certificate	MIICmTCCAYECBgGSsA65uTANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAV0ZXN0MTAeFw0yNDEwMjExNzA4MjhaFw0zNDEwMjExNzEwMDhaMBAxDjAMBgNVBAMMBXRlc3QxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA04tCRgcudcTaoBdHydIH4mpiyTeNCSisDduj9D2lAVr3A/Ou8Nd3qlCW0k1fzwmcZwE/bX1KTcChUpIxsgXk9f8MgsYC6H0eDKK19509RAsTOgzB22TqOhcoqzQjzwH+4JJF+ra4f0/sCEQXt/SZ63jkOWUAS298L+5Ks2Q3FbVmR/XtmDhuaiKVBj1fmRhoTe+7Ye2niZ0pwYx2HqlPvPbt7fdHTcrE91y/l3376s6JtQQqvT+9eDNSgBzi6GXXEdiOW4s30YC0zT82p6x/EQgZLp5MYOXP9W7erdYN6wqD3IBeJhC/ogmrRtVz9XlnvQFf/nC4JU2i8/MFyeWTzQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQA+N9i5Jw16vx0JY6YxXoYBtcwN5eIuqfjp37dLGFcCfN/cXzZdQQI8uDzlV4E/QqnVN8HMWFoSnkAoLwXEQuvsqGX4T7/bnm5I4iGyjwklMp4CfWQDo+pBr3h63IdqXszQGxebbaPVKo9Ua0YbGISfgv/lbUJO2h39bA8dp3hYfsoiMZ4m/MAuWMs3gNkwsxGRQLfyhTYQBfbpN7SDyvyP0UrGwqMYgKXWsLdNqhHTXrhrD/h5e15dOlGqIkjIoOBy20f89CV8zNNpqIfRo+sLHyf2O+KOdXBwtm3K2xrPh8Hl84LyZC5UvwHT84asQGrdCq0ZE9UpoVtnRI0fnIQ3
ba74bd4d-23e8-4968-b94b-fc08073eb7a6	abe3cb13-73c7-40f9-b007-f65d2dce789d	kid	27604d1d-d6cb-480c-bcc6-4e75c38b2ed7
360796d5-c25d-4779-b11e-af58e183fb3f	abe3cb13-73c7-40f9-b007-f65d2dce789d	secret	48gsn1yiy34gb-TPhsmMTg
b401eab3-419f-4b33-a539-1e29d08a1296	abe3cb13-73c7-40f9-b007-f65d2dce789d	priority	100
1f14b72b-04de-4a76-9b21-a29bdb0d7698	12723d99-64ef-40c2-a587-435e04239356	max-clients	200
c5b1975e-7b64-44b7-b105-f5957eca5ff7	59de6fd1-9305-41fc-8089-b217a4980141	client-uris-must-match	true
b149c3c2-47a3-434b-8776-180d8be24fea	59de6fd1-9305-41fc-8089-b217a4980141	host-sending-registration-request-must-match	true
ed009812-9cf8-4c75-88e3-60b391cca2f4	553eefee-6e62-4b3a-9437-2fa68cfc4f2d	allow-default-scopes	true
3345f55d-6a38-4a27-b7a9-9f0fe31e8923	50898e27-992f-44a9-bc5f-4d741c7acc82	allowed-protocol-mapper-types	saml-user-attribute-mapper
335d94f5-e3fd-48df-ac37-ac4f2dd9035a	50898e27-992f-44a9-bc5f-4d741c7acc82	allowed-protocol-mapper-types	oidc-full-name-mapper
eee0568f-81bc-47d7-87d9-823f16e2ddb1	50898e27-992f-44a9-bc5f-4d741c7acc82	allowed-protocol-mapper-types	oidc-address-mapper
019d3c1c-0497-4c18-81b8-50cacb38b9d6	50898e27-992f-44a9-bc5f-4d741c7acc82	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
281400de-4250-4cdf-bc71-bebbe7a07fb0	50898e27-992f-44a9-bc5f-4d741c7acc82	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
4c09d414-7ccb-4de8-87d9-92a27c752fd2	50898e27-992f-44a9-bc5f-4d741c7acc82	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4984b186-38da-4884-bf5c-2d6333141e26	50898e27-992f-44a9-bc5f-4d741c7acc82	allowed-protocol-mapper-types	saml-user-property-mapper
1ace1442-1ac4-412f-871c-e73367f3650e	50898e27-992f-44a9-bc5f-4d741c7acc82	allowed-protocol-mapper-types	saml-role-list-mapper
79722097-8c92-4cf2-8dd0-5b1d5c7bd1f0	30c62879-8355-4054-a784-09037cc34ea1	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
55d0e794-57e4-4b62-b512-ffe7a1deaaca	30c62879-8355-4054-a784-09037cc34ea1	allowed-protocol-mapper-types	saml-user-attribute-mapper
f307881b-8377-4d82-95a5-3953cc639404	30c62879-8355-4054-a784-09037cc34ea1	allowed-protocol-mapper-types	oidc-full-name-mapper
6373f3fa-4424-4594-983e-f7f0c662dc85	30c62879-8355-4054-a784-09037cc34ea1	allowed-protocol-mapper-types	saml-role-list-mapper
33b65462-0595-4ece-86fa-a4c6eb24d8b0	30c62879-8355-4054-a784-09037cc34ea1	allowed-protocol-mapper-types	oidc-address-mapper
60b4c4ec-0a11-4850-aae6-b16d345bbbf2	30c62879-8355-4054-a784-09037cc34ea1	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5a1dcf72-7c50-4c17-898b-451fb2782747	30c62879-8355-4054-a784-09037cc34ea1	allowed-protocol-mapper-types	saml-user-property-mapper
a9169f92-817d-45bc-bdf0-976e60939e2a	30c62879-8355-4054-a784-09037cc34ea1	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
e3c88203-e49f-483a-b2d3-700e539477c8	26574e7f-a816-4ccf-80c6-79c35a3d2f83	allow-default-scopes	true
e66db47b-f428-46a0-9b99-2d83dd7e20ba	f6cb81d1-1a9f-4d99-bfa7-51927a904a98	privateKey	MIIEowIBAAKCAQEAyTPMtCtMQbfiWVahV/8nIcs1c6kXjgUTQ9is0SsVXr4e7ddPg7m2qc2yJPyD2goZk4DisqJVABTuMTcGAeof0vImqdEk72UIYBFMtaiXJRKv1SqcDQ/B2AQcmecu08s2/hY+Ew0W3wkIhjgsJ6E+hCmiSZ7K4/Lp1Om4x8+kjU23giLQyF+FJ/3WCa54nd/28G/pXJINN5MIV6YknJ9ITDNtyeKuFB08XzUo/FpzdkhgpSKFKuNPphdpIr4nWeCOKCnt2/K1xXUJvpjZieH3JRsAQEfDHH8YLLcHwcF/zpvUEn0cMG31VNCtshcExB01EfpD1UdyFjzkT0t++VAq8QIDAQABAoIBAE2kSZg1JSYvGY+0GGrmsWkfC69oTwik+LwzvuywnXyEDVdmwO5qGg0IrXgMYa0gPKJpGBIrBnYTnZ8sRosyl7lFbJoXdRNUf5ji1CE9v6W0wlmWKcX4kKsVWxwg1DcysjP2zVl4sZy71ahFwPRCCufhURjryAuSz50z2/RvMma8KTROd9b+VgQSR+KKmgpbrZWU61Wn85bNeZUzoXyKJzLfKWErhyhIEXteBMjnINrewoqz/svQjw3SWJGQY5VpyVljP3dThcdmIS8k/WV94ID6pm/u9M5Bx0ssEplE4dUWDALVQYNd3MfeZpAVnugbah07kN/C4PsNUFfv+iGHhekCgYEA9EKfZDdISDp1Eg/3om9fpExIVNqp0vqTBQDhZzsfwy6cXtL0XsRWFBUXFEGPPP0hwbcWac+RDKR3WguDPaz6c43CKS5D5yCjuz997hJOdDHcdZ0Ix6Rg0/smzCXPzGBiNEqZNH1IT5b8YerEIu4evIl9ktLvFzQaerC8IWu7bD8CgYEA0t9kh0u6pYz7ag7ySnCaw3mYHRh/cjqPUxkW6GuaprEiFFOAuC736P0W+S/aJ/pMcdluqlR2+kgqWYNKAQpQ/ZmmdXk85ZJ/JVhvZbkEExt1sf0E6WXz0RxKy1YQKKFOCleolVDiJgmtCUniBpA52P6pSlpQFmUJYByaZfrjXM8CgYBXUzI02+bFm9Ca4oZ/1h11WahKXdp1CQxir4vmIica2qEg7X5cGwlDKL8ViNKy1TSqUtB6h7CtumbJFHCZLixj/3w4yMeR7ANdQDe/U2Ak/mZ4zemDpmrPnmyic6o0wQia9UiMkXW2rp4QS6RPcJ4gfW8dfLfprcEBuAmqUR+ydQKBgQCAycMCBrRVy8b5PWupHyDGZgsLKh0cTLugSuB8zstDJ0fjFiS1WKo8d+aCBkG8zNfHaL539OI9dbm3tcGK5RwV5rONZ6BTradNzbcrb1YXvVuiex921LeWbSsZCNURm4KoOmVR3HZiOOKfm6oZzBgoeVA3gvUK2GZjdtStmA8obQKBgCRGoKCn3KdKksqQ9Upyo6RhyHAuKIYLst1O3QX4fbjWH0PXKUXaum0gW2OsKkpWLAIHsr1DbegFzDBF+HtIj5jzC9yQQScvi+f4/TDANH46Niv+gmL/dGyXcYLJMuPO+enwKZxvx+oqEjwm4DnqDQ9UvGqRmo9OjpLiD39isqye
e3f5653f-47a7-4557-b198-428897880dec	e84d01a2-1cad-4779-b5c6-63e2f8f48834	priority	100
97cc3b31-9d52-439e-a327-5f89a88d274f	e84d01a2-1cad-4779-b5c6-63e2f8f48834	kid	3c753aa8-538b-46ee-863d-33e217ab160e
d3c38451-5d8c-4c9b-808f-0a587eaf11f8	e84d01a2-1cad-4779-b5c6-63e2f8f48834	secret	xmJLPhmV3W2ljsWbcCQQIw
f3ccce06-88df-4058-8b6d-3382433b0282	8f8c8b24-c802-487f-9ac7-2a4df160c81f	allowed-protocol-mapper-types	oidc-address-mapper
76904e4a-b099-4a53-9819-b718442add2d	8f8c8b24-c802-487f-9ac7-2a4df160c81f	allowed-protocol-mapper-types	saml-user-attribute-mapper
a7aaf367-9b23-45d0-8afc-2893355418bb	8f8c8b24-c802-487f-9ac7-2a4df160c81f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
464ab234-b11d-4e86-885b-f7aed0afa359	8f8c8b24-c802-487f-9ac7-2a4df160c81f	allowed-protocol-mapper-types	saml-user-property-mapper
ce482bbd-12cb-41e4-a68c-0babb909e0ba	8f8c8b24-c802-487f-9ac7-2a4df160c81f	allowed-protocol-mapper-types	oidc-full-name-mapper
9e24dbcb-687b-4ec9-a15a-ac5892650e1f	8f8c8b24-c802-487f-9ac7-2a4df160c81f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
77cc5ecb-802c-4a47-93d7-ae7b609d472b	8f8c8b24-c802-487f-9ac7-2a4df160c81f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
acba1437-13a8-43a9-81eb-0a662613c0a7	8f8c8b24-c802-487f-9ac7-2a4df160c81f	allowed-protocol-mapper-types	saml-role-list-mapper
c9065da7-79f2-47fa-8324-b46e53149443	e5c2900b-bee6-4c4e-9612-363eeada8a87	certificate	MIICmTCCAYECBgGSsGvOlzANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAV0ZXN0MjAeFw0yNDEwMjExODUwMDhaFw0zNDEwMjExODUxNDhaMBAxDjAMBgNVBAMMBXRlc3QyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvOz69/5VWT59SEdlY6EM6bueoBPzXeIKfD/tYLwCKUyNuDJv5JjuUeN1c4y7gu6a7Z1XLBPfJl7aZFq/caLN4Widq028iwLyE5cWuX3TU3Gda6/V4f81bE+AgJ1SZEKczi/78Nks1bazxhmLvxC0fZTJAN26uL7IVcKIoRPgmy3ZfMhh+jc9JncyyUu/M8XX+oiaM743OCfIN7EJRHhYh10pMXbZPYSkgpoMZ5s2wCAzbCAfj458x0Gsfhetdei/HwwtfZ75FcUKmRkQjD2qjZ9Qj8eo8yzt8jK320P/saKa+UyIz6CbAWOEpgxWYAYnFl/Z+NeiVrnTSoXaD5tIPwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCzeVQ+SCD7HWt/gsENpGLopVD3jPNcxe5FH5GyeQSUWajjS08UAiYoUuE7DnGivprPQMef5aGcXYapDBdxXc+KJGjv6Uta4lvqXN5fUs9VrMZUiNkedNsffzvpU/Al86y4B6G9KT67FvEewoNlJQIflO0P+2X4BT+mZueOZg6xmcoUdgIBlAE4vcc6LDL0i2wmQORk6rWs4j5P46rABlBLiAkIi1y3Bd9J3i5Zl/l6tjV6ggzrimGRuURvuRxvBNw17ILxclA8PkMyPWL53b2PIx9gH11JTu2XofLYOO0UHwecH07haaGBxEH7szLLBXZm8VV4rensVq8d0G/H50tz
9d53442d-0169-46f2-a8d7-d917d496097e	e5c2900b-bee6-4c4e-9612-363eeada8a87	priority	100
be7a383d-cae3-4731-8684-79d88a94adb4	e5c2900b-bee6-4c4e-9612-363eeada8a87	algorithm	RSA-OAEP
3a2e42f3-9020-4435-a1d1-1bdf5f48f12c	e5c2900b-bee6-4c4e-9612-363eeada8a87	privateKey	MIIEowIBAAKCAQEAvOz69/5VWT59SEdlY6EM6bueoBPzXeIKfD/tYLwCKUyNuDJv5JjuUeN1c4y7gu6a7Z1XLBPfJl7aZFq/caLN4Widq028iwLyE5cWuX3TU3Gda6/V4f81bE+AgJ1SZEKczi/78Nks1bazxhmLvxC0fZTJAN26uL7IVcKIoRPgmy3ZfMhh+jc9JncyyUu/M8XX+oiaM743OCfIN7EJRHhYh10pMXbZPYSkgpoMZ5s2wCAzbCAfj458x0Gsfhetdei/HwwtfZ75FcUKmRkQjD2qjZ9Qj8eo8yzt8jK320P/saKa+UyIz6CbAWOEpgxWYAYnFl/Z+NeiVrnTSoXaD5tIPwIDAQABAoIBAATP6N3IbPMbfBE+irVJcZNCIKdSKsV0gv2pATDEFfs1HhNkt+RNbIPKDk1PQ3cLAQfWLwi9e6McdzKalYkqJoiI/VWGL6wllI+HYZN/wkWI8NBz4Tfi8MDqaEsEw6FjIvklHSU3p7eZcj9nzV8kaHyEZCqxLlbgISkyDc0QidmNLsqON60V74BLX9A/1DFFBd/gX91+nh864FWc4DbHRXrheQpURyMWKN88XtQK/Fp2jj0l0h4uI85emJgKYAIKquR9wiFbcU210Tlf9MTvNIHea6Gydi+N6YCVLNlvBBiHIJeYVQKyBU+PTHsiQg/lvvvtNYDqB4m6d5BhP+1659kCgYEA/1qhr09qq0P/4XInf8gBwFxhMcc/znxw1HANcTsTugCoOuawHb5XeUA4UNfvw5ng4vodb4pjjhBN5CJfypdO+itQJEDC26ZFsqDjNPLfLdxfva5YQTCvkXeJqtBB4y7fdaxziKk8OgKO42x6g3yVFemRlLcQXY/9lMiY4fOlVMkCgYEAvWdUWP+ap2lVJf9145NEwKoAP9HGGe5G5jWYTXsvyzy/5IXcuqS4Cm0V21W6of4gqGFQ58AOTXz/gTmxaDYkF72rCm55pmgSXMVYO9z5HHrRQ3Q3AMMiVbOXFn0M4004uNOtEBB1CFejeO7NQCHHw1W4/sUrkmmVyIHFK/RzYMcCgYBmCYVKVGW/gjChmcgG25k3kLKV/ZSVokxD13LHqF+9l72hq8T8Xa7+mJboVyFL/BVNHbzdcWNOxV0aqFG21reMZ/piQi6bLtnzAy9HXTWpUcJAPYauphHCAw5T31w0t+o7T2nrVhTm6VbHsfVSzVmVo/u0fWJgwMUHyxCsWXvbYQKBgFnvSabk3/ukUXE0hzbjg970GiAzrJw9f17qjgIkf0JC+184jOH3OwiAWcOHRpKLB9jMNM2GbYQv2Wb0DSBNrP+06RWP9aWlfyqb7lSmjYcPbnRYJ5HuFkyZdSGRiWAZF9jzchbRqbCnZJEU21Mbdy5ycuBOoWzpQ90seYJwlaSbAoGBALdTuna5B0/Ev+jNAXOkj/JLvOxrFA5GYvgAPvSJ4EFrxlHROQgtMv4nzr+P/ae9+1vUmnLeOFu8VejT7bM1jF+uZquk6uS51ICarQh95R2ci3lMwe9fMZjGyvj8GCSkRu6Q+xRfx/4SHKpuFxDg3gw0TB2g4Z1oldbeHfM/kPl+
31cc8a20-a5f9-4494-a621-20fe556d1353	e5c2900b-bee6-4c4e-9612-363eeada8a87	keyUse	ENC
4d61c5b9-8460-4690-ac28-715d932b5396	568a6e2c-caf1-4093-9258-a31554a6d08b	secret	WQGTjswC7uW47-prQmpLIVngsBOvTfPCdP-YJi-GHhwi7YsnR1IgijHvyvWro3fZ9TTmCTYnHS6nQfENGNAwFUfAkQqBtderUf7saV26HAy_ypQel9tkrZsVQLftUhe4k66wXrr6rdpTsg-xX1lrGaMeZFhabmKkWT_dxfqSg6U
c301b1be-7901-4e8b-84f7-1db5d4366b21	568a6e2c-caf1-4093-9258-a31554a6d08b	priority	100
acfbcbb0-337e-490e-bc2a-78e9c46760b7	568a6e2c-caf1-4093-9258-a31554a6d08b	algorithm	HS512
3fe894ad-2f97-467d-a512-38cc3c415114	568a6e2c-caf1-4093-9258-a31554a6d08b	kid	fd181698-ffbd-4d5d-9c05-231d20d5d7cb
1b2eff66-8216-417d-b5f8-c3fe8449f2eb	f6cb81d1-1a9f-4d99-bfa7-51927a904a98	keyUse	SIG
e3d0db5f-979f-4c26-9d5c-b195cb8d73ca	f6cb81d1-1a9f-4d99-bfa7-51927a904a98	certificate	MIICmTCCAYECBgGSsGvN4zANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAV0ZXN0MjAeFw0yNDEwMjExODUwMDhaFw0zNDEwMjExODUxNDhaMBAxDjAMBgNVBAMMBXRlc3QyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyTPMtCtMQbfiWVahV/8nIcs1c6kXjgUTQ9is0SsVXr4e7ddPg7m2qc2yJPyD2goZk4DisqJVABTuMTcGAeof0vImqdEk72UIYBFMtaiXJRKv1SqcDQ/B2AQcmecu08s2/hY+Ew0W3wkIhjgsJ6E+hCmiSZ7K4/Lp1Om4x8+kjU23giLQyF+FJ/3WCa54nd/28G/pXJINN5MIV6YknJ9ITDNtyeKuFB08XzUo/FpzdkhgpSKFKuNPphdpIr4nWeCOKCnt2/K1xXUJvpjZieH3JRsAQEfDHH8YLLcHwcF/zpvUEn0cMG31VNCtshcExB01EfpD1UdyFjzkT0t++VAq8QIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBCtiIkS2DQ8JQhqtlU76ByeLspJWyX0CXoTOU4paPc3CgsDxWSaoPX29IXju5s4+7todIqus1s0i7xJE8kahiL+32Cgzwgzi4BMZufov/kBHKF3OeIxv4csadm0l5npZUDkJgvSLCklOTKRmrmeZyUFkqqxH84XWQ3HdwfES+w6YTHugHqX7jVqjuElf4WuFQsXZfxnmnFjrYrjq5n9wwgh0QE2Q0tBSD9+m+ve6TY7976NW7YlnTfltDCJL0pAdvVeNj2zXot4xxwbG/SqFhQDS5UXvO7ivCiVwJRrLbQ+8q+rLd74plAm2Ki2Eb7o1YR53BDjmVWRajk5ENHVuvC
86746e6c-9d0e-444f-9bd4-5d8ca03e4d1a	f6cb81d1-1a9f-4d99-bfa7-51927a904a98	priority	100
eb6a141a-3b1f-4628-a4f6-643fa0fe0dc2	4864c054-a923-4381-986b-62adc1802cad	allow-default-scopes	true
3077d97a-01b1-4020-b9ca-76ce25768ce0	bcf43d9a-74b4-4734-99cc-b89e0e606d8d	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
a17cd28d-399e-43f1-9aa7-b72626f1a046	bcf43d9a-74b4-4734-99cc-b89e0e606d8d	allowed-protocol-mapper-types	saml-role-list-mapper
1d5879dc-918f-44fb-885e-8d284cc966c3	bcf43d9a-74b4-4734-99cc-b89e0e606d8d	allowed-protocol-mapper-types	oidc-address-mapper
5d113b7a-c44f-4c0a-9314-7fa915f71559	bcf43d9a-74b4-4734-99cc-b89e0e606d8d	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
342a2917-4797-4331-bf97-0d6dd2e63921	bcf43d9a-74b4-4734-99cc-b89e0e606d8d	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b5a312c9-63db-4fde-97cf-f4d10c89ae65	bcf43d9a-74b4-4734-99cc-b89e0e606d8d	allowed-protocol-mapper-types	saml-user-property-mapper
72505fa5-191c-4d11-9b85-d6efb7cc8004	bcf43d9a-74b4-4734-99cc-b89e0e606d8d	allowed-protocol-mapper-types	oidc-full-name-mapper
2bfe5d5c-aefd-47c0-ada9-0a388f359735	49810d1c-9496-4b1e-84aa-afd85ab5ecc5	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"selector":{"scopes":["address"]},"group":"legal-address","multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"selector":{"scopes":["address"]},"group":"legal-address","multivalued":false},{"name":"fullName","displayName":"${fullName}","validations":{},"annotations":{},"required":{"roles":["admin","user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"emailOptIn","displayName":"${emailOptIn}","validations":{},"annotations":{"inputType":"text"},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"},{"name":"legal-address","displayHeader":"Legal Address","displayDescription":"","annotations":{}}]}
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
edc30253-7dcc-456a-8b45-698bcb7a4f13	80545bcc-e358-49d3-86ba-313940cdd7ff
edc30253-7dcc-456a-8b45-698bcb7a4f13	74075efc-d3b5-4a36-99eb-1ef3c2e3d59d
edc30253-7dcc-456a-8b45-698bcb7a4f13	0fafe4d1-8287-4b40-8b34-d15bb7ed3c23
edc30253-7dcc-456a-8b45-698bcb7a4f13	bb7b66f6-c51f-427a-b719-dced8d0a8b94
edc30253-7dcc-456a-8b45-698bcb7a4f13	14943061-6e0b-44b0-bd7e-ac4e5041a708
edc30253-7dcc-456a-8b45-698bcb7a4f13	6fbd252f-b853-4ee7-ae38-57d8079cc9d3
edc30253-7dcc-456a-8b45-698bcb7a4f13	c71d31f4-ba6f-473a-9e5e-e5aa0f52ccd1
edc30253-7dcc-456a-8b45-698bcb7a4f13	0031a068-38fc-4740-aff5-9090a25a9d64
edc30253-7dcc-456a-8b45-698bcb7a4f13	5c7f1b3b-8b77-4bd6-8e45-9c673abdae69
edc30253-7dcc-456a-8b45-698bcb7a4f13	893777ab-9cc2-417f-9939-7268a885fb50
edc30253-7dcc-456a-8b45-698bcb7a4f13	a001819c-1669-40f4-8f17-8f93c62e2353
edc30253-7dcc-456a-8b45-698bcb7a4f13	cfb607e2-660b-4271-88f2-dd4bba924767
edc30253-7dcc-456a-8b45-698bcb7a4f13	43b3b2de-46ca-427d-9db1-8c0c96ea3e84
edc30253-7dcc-456a-8b45-698bcb7a4f13	294d846c-2cbb-4e3a-afda-5580c14cd445
edc30253-7dcc-456a-8b45-698bcb7a4f13	e2e6515f-4aed-4e6e-b7dd-7cc85ff7f69a
edc30253-7dcc-456a-8b45-698bcb7a4f13	1ae50995-5b04-41fb-9416-1c88bd8900ad
edc30253-7dcc-456a-8b45-698bcb7a4f13	6cb514ac-9fb5-4305-8c02-a872585b57bb
edc30253-7dcc-456a-8b45-698bcb7a4f13	aa4019f0-f81f-486d-b4ff-8a919a3fcd79
14943061-6e0b-44b0-bd7e-ac4e5041a708	1ae50995-5b04-41fb-9416-1c88bd8900ad
8eaee4b4-db59-489b-9ce3-217077d760ff	7a47bcef-dfae-41ef-ab34-7ab480f8caa7
bb7b66f6-c51f-427a-b719-dced8d0a8b94	e2e6515f-4aed-4e6e-b7dd-7cc85ff7f69a
bb7b66f6-c51f-427a-b719-dced8d0a8b94	aa4019f0-f81f-486d-b4ff-8a919a3fcd79
8eaee4b4-db59-489b-9ce3-217077d760ff	21fbca6f-0536-4f1d-b130-78f40e7c690b
21fbca6f-0536-4f1d-b130-78f40e7c690b	b5c29448-3d25-494b-bb97-863c156cddb0
9da14183-e4c7-4cab-9ce4-6a4980cb93c9	ebd4c600-550b-4939-bb60-fb77f2f1baf4
edc30253-7dcc-456a-8b45-698bcb7a4f13	b2a9a138-1987-4bf0-8b27-a5ddd31429a2
8eaee4b4-db59-489b-9ce3-217077d760ff	ac91fe6e-cc15-4a44-8d4b-d4aa5eefa2e4
8eaee4b4-db59-489b-9ce3-217077d760ff	d74046a4-88fc-44c8-8932-83b2f591f531
edc30253-7dcc-456a-8b45-698bcb7a4f13	6a904e2e-f3c9-472c-bf44-95d020efbbb4
edc30253-7dcc-456a-8b45-698bcb7a4f13	ed4c4868-d0d3-4e11-9c47-64f9b29e2079
edc30253-7dcc-456a-8b45-698bcb7a4f13	53d46425-1218-4a18-99c3-1a2ea59cdcc6
edc30253-7dcc-456a-8b45-698bcb7a4f13	7eb43cc8-500f-41a5-a1f4-8af2f9357c72
edc30253-7dcc-456a-8b45-698bcb7a4f13	b182889a-7dbf-4c40-912f-67763a28203e
edc30253-7dcc-456a-8b45-698bcb7a4f13	dffff9e9-c020-4b1e-b13b-6e1eeddbc4d5
edc30253-7dcc-456a-8b45-698bcb7a4f13	a5154a91-8a42-45c8-a8b5-f789e2f29b98
edc30253-7dcc-456a-8b45-698bcb7a4f13	d5dd0a8a-d688-4895-ace6-eb7a48c3286b
edc30253-7dcc-456a-8b45-698bcb7a4f13	09dd1b46-f079-4622-bd1e-eb0559eb8df2
edc30253-7dcc-456a-8b45-698bcb7a4f13	c51eebd2-b5e1-41fe-89fa-a1a5d1c88ee8
edc30253-7dcc-456a-8b45-698bcb7a4f13	ca327a3a-d462-49b4-aa31-a778923c4a7f
edc30253-7dcc-456a-8b45-698bcb7a4f13	3393382f-8a01-4173-9212-3b6efd2b174a
edc30253-7dcc-456a-8b45-698bcb7a4f13	c656a012-664f-47c6-b167-b35d6420531e
edc30253-7dcc-456a-8b45-698bcb7a4f13	62688fd7-649d-4280-95fd-3c6bcf089398
edc30253-7dcc-456a-8b45-698bcb7a4f13	1b3023fc-4784-41ce-9138-08c701368d5d
edc30253-7dcc-456a-8b45-698bcb7a4f13	9febcf71-25cf-458b-8cd8-e66029b07a5c
edc30253-7dcc-456a-8b45-698bcb7a4f13	860422ac-0fa5-4b32-bbe1-0bb020df02a4
53d46425-1218-4a18-99c3-1a2ea59cdcc6	860422ac-0fa5-4b32-bbe1-0bb020df02a4
53d46425-1218-4a18-99c3-1a2ea59cdcc6	62688fd7-649d-4280-95fd-3c6bcf089398
7eb43cc8-500f-41a5-a1f4-8af2f9357c72	1b3023fc-4784-41ce-9138-08c701368d5d
152776e5-c698-4833-832a-29c8eb6d450b	cd3aa552-18e0-4238-9834-0dc7257a6b5e
152776e5-c698-4833-832a-29c8eb6d450b	be184363-7950-4ce2-bcef-5a241affb1dd
152776e5-c698-4833-832a-29c8eb6d450b	ca068d6a-9a3a-4efa-88a3-4065ef2fb773
152776e5-c698-4833-832a-29c8eb6d450b	c0575c46-c528-4085-bed9-26e08d134ea6
152776e5-c698-4833-832a-29c8eb6d450b	866bd311-e882-45f4-9363-d2337fe4c47e
152776e5-c698-4833-832a-29c8eb6d450b	f9d16fb4-276d-4bf0-ae62-7a0c4e68e0fa
152776e5-c698-4833-832a-29c8eb6d450b	f9717605-aeb0-4d2e-acb9-6977d29ee414
152776e5-c698-4833-832a-29c8eb6d450b	dab1ca36-0c9c-4912-8c9d-c652c63e3e3d
152776e5-c698-4833-832a-29c8eb6d450b	7306b841-10ab-4c35-ac50-22745ad15d37
152776e5-c698-4833-832a-29c8eb6d450b	f8105dfc-de27-4ca5-ac38-cb4523709d69
152776e5-c698-4833-832a-29c8eb6d450b	076d83aa-a43f-4ca9-81db-8c56ecea8f9b
152776e5-c698-4833-832a-29c8eb6d450b	c72b99bb-052c-4eb8-9c19-8a49aec430e9
152776e5-c698-4833-832a-29c8eb6d450b	f8a6f949-2438-4f82-bbb0-777812fa55d2
152776e5-c698-4833-832a-29c8eb6d450b	1f2e5693-fa9d-47ac-9bce-ba608f8315b8
152776e5-c698-4833-832a-29c8eb6d450b	112a73e2-1e47-47fa-8f3a-c5912f5a6e02
152776e5-c698-4833-832a-29c8eb6d450b	87251ec4-1906-44a1-8883-cd2bcf7b7d9a
152776e5-c698-4833-832a-29c8eb6d450b	62216db2-b28a-4ec8-bea0-c18b03a34f52
25dc23c9-fc78-4647-97cd-149741a77307	4447db17-6dbf-442a-8932-01d7ae56c86c
c0575c46-c528-4085-bed9-26e08d134ea6	112a73e2-1e47-47fa-8f3a-c5912f5a6e02
ca068d6a-9a3a-4efa-88a3-4065ef2fb773	1f2e5693-fa9d-47ac-9bce-ba608f8315b8
ca068d6a-9a3a-4efa-88a3-4065ef2fb773	62216db2-b28a-4ec8-bea0-c18b03a34f52
25dc23c9-fc78-4647-97cd-149741a77307	4b9db14e-b704-406d-9a5f-c8641feb087e
4b9db14e-b704-406d-9a5f-c8641feb087e	ea338b8e-8350-46ec-b460-005f927c7538
e7ed8bbc-1bcb-4871-9242-79a64cc8fdfa	f2219cf1-58cd-405d-a4ec-c10c0d61e7b8
edc30253-7dcc-456a-8b45-698bcb7a4f13	24587b86-1ce6-49eb-aac6-e8ceda5ef017
152776e5-c698-4833-832a-29c8eb6d450b	18695ffd-832d-4a0d-bace-8b3c9ad752e4
25dc23c9-fc78-4647-97cd-149741a77307	8b635337-8c5a-42ae-a75e-c4ba77db20e1
25dc23c9-fc78-4647-97cd-149741a77307	9281f40e-6d33-4e24-bb52-335f964683a1
edc30253-7dcc-456a-8b45-698bcb7a4f13	7dc1592d-953b-47b2-96e8-6b792c8f01c3
edc30253-7dcc-456a-8b45-698bcb7a4f13	49a10d53-ea6c-4e6c-8d92-bf4a494180f6
edc30253-7dcc-456a-8b45-698bcb7a4f13	072b4764-e708-4bbe-b6a8-f76d8674fbf5
edc30253-7dcc-456a-8b45-698bcb7a4f13	96745421-d678-4a65-bcb9-72dc8d1d7962
edc30253-7dcc-456a-8b45-698bcb7a4f13	4d73db27-7641-4d23-8f9c-e70008eca882
edc30253-7dcc-456a-8b45-698bcb7a4f13	d33ef96b-aabe-444d-b33c-2b8b95139536
edc30253-7dcc-456a-8b45-698bcb7a4f13	2fa5a6cd-d43a-4681-9efd-52dd4e95a217
edc30253-7dcc-456a-8b45-698bcb7a4f13	9a54158b-c83d-417b-8698-0a60df58b296
edc30253-7dcc-456a-8b45-698bcb7a4f13	afcccb55-78e6-402e-98ae-e0ab801969a8
edc30253-7dcc-456a-8b45-698bcb7a4f13	f695f016-c55a-476d-a942-384571bdd698
edc30253-7dcc-456a-8b45-698bcb7a4f13	1a1b159d-31da-48a2-8d00-8c2b8f188276
edc30253-7dcc-456a-8b45-698bcb7a4f13	3a9c9b7b-d11b-4196-8137-0fa9721457f7
edc30253-7dcc-456a-8b45-698bcb7a4f13	bf8db88d-703d-4ef0-abbf-0ca968f1a4b8
edc30253-7dcc-456a-8b45-698bcb7a4f13	0e2378d0-1cee-409d-9350-ff1418dd53ea
edc30253-7dcc-456a-8b45-698bcb7a4f13	8734e94f-1f04-4310-b2fa-8b5046dcb448
edc30253-7dcc-456a-8b45-698bcb7a4f13	ed761718-c140-4f5a-8328-e45c657b0e87
edc30253-7dcc-456a-8b45-698bcb7a4f13	a7d7fd57-bf99-4def-b5c9-5f7be0a1e4ed
072b4764-e708-4bbe-b6a8-f76d8674fbf5	0e2378d0-1cee-409d-9350-ff1418dd53ea
072b4764-e708-4bbe-b6a8-f76d8674fbf5	a7d7fd57-bf99-4def-b5c9-5f7be0a1e4ed
96745421-d678-4a65-bcb9-72dc8d1d7962	8734e94f-1f04-4310-b2fa-8b5046dcb448
c9d8d0de-22a4-421e-afaf-38f9a6195b24	bd41d3fb-b4cf-4499-b988-cbc99a184fcc
c9d8d0de-22a4-421e-afaf-38f9a6195b24	19848b3c-fcfe-4fd0-aefe-7fd1382799cc
c9d8d0de-22a4-421e-afaf-38f9a6195b24	8faf91e7-7c22-44db-aea8-1f7258b17edb
c9d8d0de-22a4-421e-afaf-38f9a6195b24	da12dd95-1fb1-47d7-b4d3-bcb4fa86f5dd
c9d8d0de-22a4-421e-afaf-38f9a6195b24	a817ab92-32ce-42a2-b792-4307f6f6c013
c9d8d0de-22a4-421e-afaf-38f9a6195b24	10fa23c2-29ff-44bc-852b-12246a89a401
c9d8d0de-22a4-421e-afaf-38f9a6195b24	75a69324-df62-4192-a5f6-be0a4f93dff1
c9d8d0de-22a4-421e-afaf-38f9a6195b24	b07b7798-e1b3-4cfd-9be0-fdf50abf85eb
c9d8d0de-22a4-421e-afaf-38f9a6195b24	ccfc217a-6569-4364-b6a0-c5fa654ec877
c9d8d0de-22a4-421e-afaf-38f9a6195b24	eb93715b-c7bb-4fed-97f9-657a426faebb
c9d8d0de-22a4-421e-afaf-38f9a6195b24	de53c04e-3780-4c84-8ebe-c20d0b9549ad
c9d8d0de-22a4-421e-afaf-38f9a6195b24	2659ac30-5f79-49a2-8413-5438c825be49
c9d8d0de-22a4-421e-afaf-38f9a6195b24	7e9199b6-40b9-4d91-b9b3-7dfc326430f0
c9d8d0de-22a4-421e-afaf-38f9a6195b24	91632ffa-3889-4e88-96dd-a40345728e83
c9d8d0de-22a4-421e-afaf-38f9a6195b24	706fc139-57d7-458e-93f4-eca3c86c7676
c9d8d0de-22a4-421e-afaf-38f9a6195b24	fca93d3e-ee5f-4b27-ad1f-e1ca641046e1
c9d8d0de-22a4-421e-afaf-38f9a6195b24	d99f8de8-4220-40f8-9337-1da128c8ba0c
8faf91e7-7c22-44db-aea8-1f7258b17edb	d99f8de8-4220-40f8-9337-1da128c8ba0c
8faf91e7-7c22-44db-aea8-1f7258b17edb	91632ffa-3889-4e88-96dd-a40345728e83
da12dd95-1fb1-47d7-b4d3-bcb4fa86f5dd	706fc139-57d7-458e-93f4-eca3c86c7676
dc580ac0-3400-493e-b4e9-45350ffeb879	5ebb5aab-f7bf-43c4-ab65-8fd54aee74fc
dc580ac0-3400-493e-b4e9-45350ffeb879	ef79cd14-9af3-4a7b-bdea-23b6d88fca0c
ef79cd14-9af3-4a7b-bdea-23b6d88fca0c	3e5a46bc-5407-4c0d-8a71-6eb5f086b01a
3d87be55-e6fc-421e-b07c-16406493efa9	6d9f810b-bc2e-43e0-b67c-5b4d7332a85e
edc30253-7dcc-456a-8b45-698bcb7a4f13	4d1e4a16-54bd-4da5-8b0f-cb1a25eb8011
c9d8d0de-22a4-421e-afaf-38f9a6195b24	bce5f442-6fc0-4b61-a72d-cbb3aa49ab44
dc580ac0-3400-493e-b4e9-45350ffeb879	950e111f-22e9-4953-a133-24a7eb6c4cb4
dc580ac0-3400-493e-b4e9-45350ffeb879	b09ccad9-ed87-4cf1-879b-9d68049f254d
edc30253-7dcc-456a-8b45-698bcb7a4f13	ee309557-e023-4c09-8725-366dbe58865c
6a529145-6246-4c15-8791-db82f27e024b	6a529145-6246-4c15-8791-db82f27e024b
edc30253-7dcc-456a-8b45-698bcb7a4f13	6a30e800-81ad-42b9-9bcf-f82b3ef0aa58
edc30253-7dcc-456a-8b45-698bcb7a4f13	db6d0ecc-965b-4d9e-acbc-a3aed34e9d24
edc30253-7dcc-456a-8b45-698bcb7a4f13	38a651d9-27c3-48db-ac00-454f0b2fcd9c
edc30253-7dcc-456a-8b45-698bcb7a4f13	1d031beb-dcc7-4066-a4ed-ac972150b2f3
edc30253-7dcc-456a-8b45-698bcb7a4f13	83f4c60b-2ea2-4f82-bc30-b75f407bd48c
edc30253-7dcc-456a-8b45-698bcb7a4f13	f3a7f525-c735-4c0b-b6ee-f35399cafcb1
edc30253-7dcc-456a-8b45-698bcb7a4f13	dc14d21e-5c6f-4c7d-9c47-63ccdf33260e
edc30253-7dcc-456a-8b45-698bcb7a4f13	a76da85c-adc7-4465-b870-8f614a27aaa6
edc30253-7dcc-456a-8b45-698bcb7a4f13	05eb3dc0-d554-45e5-901f-1af0c4eed0c6
edc30253-7dcc-456a-8b45-698bcb7a4f13	c7d76103-617d-47e2-8850-4665a9c1dc83
edc30253-7dcc-456a-8b45-698bcb7a4f13	16c21d2e-4e51-41be-bf7a-b7dde02625b0
edc30253-7dcc-456a-8b45-698bcb7a4f13	ca8981f4-362c-4e96-91ee-568bf4f6a029
edc30253-7dcc-456a-8b45-698bcb7a4f13	95576acc-012b-4bef-aba3-aafd399a3d14
edc30253-7dcc-456a-8b45-698bcb7a4f13	8392ad62-fae8-4fef-89e9-d85a512af4e5
edc30253-7dcc-456a-8b45-698bcb7a4f13	c0f932f5-2236-4688-9a21-71c6308b73ca
edc30253-7dcc-456a-8b45-698bcb7a4f13	bacd1c49-e971-4209-89dc-6bfcbb13f612
edc30253-7dcc-456a-8b45-698bcb7a4f13	7ba00ae6-1b4f-44f0-8dbc-fec5798dc93a
1d031beb-dcc7-4066-a4ed-ac972150b2f3	c0f932f5-2236-4688-9a21-71c6308b73ca
38a651d9-27c3-48db-ac00-454f0b2fcd9c	7ba00ae6-1b4f-44f0-8dbc-fec5798dc93a
38a651d9-27c3-48db-ac00-454f0b2fcd9c	8392ad62-fae8-4fef-89e9-d85a512af4e5
c5a7284b-c110-4f57-82bf-8707a02a4db0	c9303d68-7434-46ea-98b8-687888661f28
c5a7284b-c110-4f57-82bf-8707a02a4db0	e5b4409b-8b65-4b42-b253-5b2e08e787d7
c5a7284b-c110-4f57-82bf-8707a02a4db0	ebe7b3b4-8d1d-4656-8ddb-5a62d0283427
c5a7284b-c110-4f57-82bf-8707a02a4db0	8bda2464-8d93-43b3-921a-47fe5dd3e901
c5a7284b-c110-4f57-82bf-8707a02a4db0	53f765e1-194a-4c6a-87f5-201dca34b197
c5a7284b-c110-4f57-82bf-8707a02a4db0	b64bc647-3961-4978-90ee-93ba533e36a2
c5a7284b-c110-4f57-82bf-8707a02a4db0	05f5800f-71b8-45a6-ac7b-1b9af0da3c99
c5a7284b-c110-4f57-82bf-8707a02a4db0	f570fab7-bc80-4374-ab78-14c15505de14
c5a7284b-c110-4f57-82bf-8707a02a4db0	7ab48d89-d60a-4467-a76b-20940174b7c2
c5a7284b-c110-4f57-82bf-8707a02a4db0	913b81e0-8f30-4da9-9e73-f1e74d58244b
c5a7284b-c110-4f57-82bf-8707a02a4db0	62ff99a7-12c0-4bdf-8f3d-6b3d4b8b8071
c5a7284b-c110-4f57-82bf-8707a02a4db0	fd1aecd9-8d71-4960-a020-bfc9cf0a03a9
c5a7284b-c110-4f57-82bf-8707a02a4db0	9fcbef3c-e3f5-43f5-b08d-0758167962f8
c5a7284b-c110-4f57-82bf-8707a02a4db0	1366d4ff-6074-4e57-a096-23514c05c2f6
c5a7284b-c110-4f57-82bf-8707a02a4db0	9d5b2d54-4441-4287-9877-bd9386c0d898
c5a7284b-c110-4f57-82bf-8707a02a4db0	7d52917e-6711-4cb0-815f-7256acf701fe
c5a7284b-c110-4f57-82bf-8707a02a4db0	df199243-e73d-4e47-9bb8-300b737d2ea7
8bda2464-8d93-43b3-921a-47fe5dd3e901	9d5b2d54-4441-4287-9877-bd9386c0d898
b848d658-ab02-420c-b827-c6c44cd852c4	924c8c59-cabf-44d5-ab7a-97d447d6426a
ebe7b3b4-8d1d-4656-8ddb-5a62d0283427	df199243-e73d-4e47-9bb8-300b737d2ea7
ebe7b3b4-8d1d-4656-8ddb-5a62d0283427	1366d4ff-6074-4e57-a096-23514c05c2f6
b848d658-ab02-420c-b827-c6c44cd852c4	2f89427b-0757-4de1-9fb9-f43d42524645
2f89427b-0757-4de1-9fb9-f43d42524645	acda493a-4f96-449d-8635-a9f300819f2e
071772e7-ee3f-43d8-9407-a23fd72b0c99	823d79f4-c2b1-488e-bba6-3ddc03a03c65
edc30253-7dcc-456a-8b45-698bcb7a4f13	d976fbae-74d2-493e-a30c-db9ff603e7fc
c5a7284b-c110-4f57-82bf-8707a02a4db0	a7dc9acc-6436-4fe6-bebe-9e247ccd5c98
b848d658-ab02-420c-b827-c6c44cd852c4	5ca4b80a-176b-4feb-8104-d2f4a9794e1b
b848d658-ab02-420c-b827-c6c44cd852c4	8f3a1b0f-b35b-4214-8adb-d5c16e8a99ff
edc30253-7dcc-456a-8b45-698bcb7a4f13	57c6e7e7-28d2-4204-855b-6fdb0c161e93
c5a7284b-c110-4f57-82bf-8707a02a4db0	d5c5071f-4dc8-46fe-9b62-4d8867e00f8a
edc30253-7dcc-456a-8b45-698bcb7a4f13	528a3268-e600-441e-818f-f04499946c40
edc30253-7dcc-456a-8b45-698bcb7a4f13	39abef73-21ab-4e13-a7bd-4f72730f0c94
edc30253-7dcc-456a-8b45-698bcb7a4f13	e0ce877c-93fe-4efb-9f3b-e833a63d32f2
edc30253-7dcc-456a-8b45-698bcb7a4f13	55eebbe9-9606-4c77-9ceb-fcdd4b5059ae
edc30253-7dcc-456a-8b45-698bcb7a4f13	753c7960-27ac-471d-a9e1-3b9b71bfe645
edc30253-7dcc-456a-8b45-698bcb7a4f13	5759a9a9-c0d2-44b6-9db5-50076cfdad92
edc30253-7dcc-456a-8b45-698bcb7a4f13	4e18fd5b-74a6-4e2f-bb55-ca928dbb7592
edc30253-7dcc-456a-8b45-698bcb7a4f13	60be092f-788b-4378-b1dd-037d454a7bd3
edc30253-7dcc-456a-8b45-698bcb7a4f13	65938bef-99b8-4f4b-9b1d-c3bc7ccaec96
edc30253-7dcc-456a-8b45-698bcb7a4f13	5ded3ac5-eb61-440f-aa4a-958ddb5a4581
edc30253-7dcc-456a-8b45-698bcb7a4f13	a833f282-9c6a-48c8-b757-4c2bde15fdcd
edc30253-7dcc-456a-8b45-698bcb7a4f13	15055946-24c4-4091-85f5-d86210e001b5
edc30253-7dcc-456a-8b45-698bcb7a4f13	a5a2cb8d-d0e2-4718-a052-807f6019a3c5
edc30253-7dcc-456a-8b45-698bcb7a4f13	05342de1-db31-4d31-b30c-138fc131019f
edc30253-7dcc-456a-8b45-698bcb7a4f13	05e0e44f-cba9-4389-80a8-93d8c1238125
edc30253-7dcc-456a-8b45-698bcb7a4f13	d0104005-974f-423d-8480-d82ac3d0d9a0
edc30253-7dcc-456a-8b45-698bcb7a4f13	d9ab0443-2a16-4c4b-9c2a-801c1c2c7326
55eebbe9-9606-4c77-9ceb-fcdd4b5059ae	05e0e44f-cba9-4389-80a8-93d8c1238125
e0ce877c-93fe-4efb-9f3b-e833a63d32f2	d9ab0443-2a16-4c4b-9c2a-801c1c2c7326
e0ce877c-93fe-4efb-9f3b-e833a63d32f2	05342de1-db31-4d31-b30c-138fc131019f
0611a81c-223a-4fe7-bfe2-aa304886938e	3a827b11-3834-4501-bdb6-9bae194a13f3
0611a81c-223a-4fe7-bfe2-aa304886938e	6de95a9f-6679-4890-a468-16eb0a5d4c76
0611a81c-223a-4fe7-bfe2-aa304886938e	a5037949-1955-426f-be0b-ada22ae1e206
0611a81c-223a-4fe7-bfe2-aa304886938e	2fd7c680-1112-4125-b16d-14689fe3ff23
0611a81c-223a-4fe7-bfe2-aa304886938e	29401645-8ec7-4a83-8d01-e62e0892dd02
0611a81c-223a-4fe7-bfe2-aa304886938e	8f53c26f-be01-4d0d-a4b4-b3236da447d0
0611a81c-223a-4fe7-bfe2-aa304886938e	8ffe2222-03b4-4c7e-86c2-5dd01e88eb5a
0611a81c-223a-4fe7-bfe2-aa304886938e	4579e5c6-55c8-4b55-89c0-cb5d19019844
0611a81c-223a-4fe7-bfe2-aa304886938e	355b7d98-72b9-4ca4-9c82-134a701ec368
0611a81c-223a-4fe7-bfe2-aa304886938e	4c4fbd4c-f688-4df4-b5ce-720f734889da
0611a81c-223a-4fe7-bfe2-aa304886938e	afe731ed-576a-45c3-aea1-a4ee9abb4efd
0611a81c-223a-4fe7-bfe2-aa304886938e	97ed72f4-c86e-4a49-b5c9-d8b09f45cc8b
0611a81c-223a-4fe7-bfe2-aa304886938e	a5f13fe4-31c2-4f75-9302-86d8bc52a973
0611a81c-223a-4fe7-bfe2-aa304886938e	4e098be1-19c4-4392-a8bb-a3e1a0995e0b
0611a81c-223a-4fe7-bfe2-aa304886938e	20bd775f-ff36-4e25-a723-c3f538f4e0fb
0611a81c-223a-4fe7-bfe2-aa304886938e	e9d52322-baaa-419c-b8db-76243529154f
0611a81c-223a-4fe7-bfe2-aa304886938e	54fa6632-120b-4c1b-aa34-ebc61073c9d3
2fd7c680-1112-4125-b16d-14689fe3ff23	20bd775f-ff36-4e25-a723-c3f538f4e0fb
a5037949-1955-426f-be0b-ada22ae1e206	4e098be1-19c4-4392-a8bb-a3e1a0995e0b
a5037949-1955-426f-be0b-ada22ae1e206	54fa6632-120b-4c1b-aa34-ebc61073c9d3
aa1e55eb-ef79-4e0a-8817-2e8cd9ff6441	1e905119-14aa-42e2-a581-f7869f061333
aa1e55eb-ef79-4e0a-8817-2e8cd9ff6441	27263657-f217-4348-84c4-6a24e1735d0f
27263657-f217-4348-84c4-6a24e1735d0f	6dfe2352-68a2-4474-89b0-cdbe62e51fea
3de1425a-9f55-4dab-bd2c-97c6f0356964	7066b0df-1810-4c8e-bacf-bb5e47ae8483
edc30253-7dcc-456a-8b45-698bcb7a4f13	0c1df1b9-1e00-471f-b4ed-5c526578d362
0611a81c-223a-4fe7-bfe2-aa304886938e	d5857976-7bf6-41d2-8f25-9f9d49e7a1d1
aa1e55eb-ef79-4e0a-8817-2e8cd9ff6441	493dda44-5c4a-4d7a-a26f-75e855b4e133
aa1e55eb-ef79-4e0a-8817-2e8cd9ff6441	245541ae-f825-4176-b9ed-84839b3d7a1a
edc30253-7dcc-456a-8b45-698bcb7a4f13	67999782-eaf9-4077-ad51-61bae8acf919
0611a81c-223a-4fe7-bfe2-aa304886938e	82af302c-7dd7-40fb-9743-b2dbb8084b83
edc30253-7dcc-456a-8b45-698bcb7a4f13	d6c68eac-4bb7-4a62-bbb7-8f0a3562815a
c9d8d0de-22a4-421e-afaf-38f9a6195b24	a44cb456-5c9c-4c21-9636-388029bd79ca
edc30253-7dcc-456a-8b45-698bcb7a4f13	264b0a1c-800c-4284-9679-f8e7d1b7ba05
152776e5-c698-4833-832a-29c8eb6d450b	1d779b91-609b-4f4f-a4d0-e47ef5e6a195
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
71ab280d-4ef8-480e-89c9-a9ff1aa1587a	\N	password	5c10f566-9160-4795-b2af-afc12f92b293	1726858399051	\N	{"value":"lPSV28vAuLkIUjgQgFKCgOl4aAcw8r4qvkiYfp9dNKL7SrbiSOx8cTVruc7ir4pI2cgH+XRgV5o3vySdTHgyRw==","salt":"D+mxEpuhcyWa0VoZOFWnTw==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
a4d3eeab-4e6a-4952-963d-d05578f5d0a4	\N	password	d4cdfbec-5b6c-4155-9009-24442152ba71	1728582216727	\N	{"value":"iOMfC06sb0XoIt29NMy+HngeqhjJaxoD15UYWz9OKwg6hlnwG1gZhSry7loU5U4WR5KPkAEVSslJVwurXKVY5Q==","salt":"ErZDYrTeMmlljcyLpjN9PQ==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
f711f0f3-97b3-4804-8dbe-bcc7ad1b6ea5	\N	password	b790034a-8da9-4c3a-a8c1-78591737f64d	1728590760764	\N	{"value":"sU+aRT/Rq6RkXVY5d+0We7DlnsRC9i03mU+1F2X567absWG8WNDLiJAmkUR5H91NXtdMJleeFjTcrhU+VjV7LQ==","salt":"oE7UUZHo4zZAT/ZmIdHEuA==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
ac1a677f-49dc-4b2e-9a4c-9566dfcbcf7f	\N	password	950b2f4a-3004-4bc5-9d86-0fd0f156ac82	1729535982435	\N	{"value":"7S4mCIyfptbFeM5ILsqMmlU8Dl7a6GM0yn1SFhTVb6alE4cjSLrErkpfVumVPySxZfec2BJbsZfD0PPS/IcxbA==","salt":"wYop85Q0kxFCBlm37xOuOQ==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
0f87e0af-1b7d-465e-9a85-85fce26a7129	\N	password	3193f207-14e1-468c-9a60-12366b111b08	1730138770334	\N	{"value":"aTxfO84q0dfVyEyVbHaevxHSx3Qb5l7BUp21Be07drAcl/l3hfoqx62R/Dai2L1kKyoriiPrD7B7L2LSM0uw2Q==","salt":"D50/TYcH7bFRfqPPiDi/rQ==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
27fdb321-c4d9-4a2b-be18-7dc36578d3c8	\N	password	964439e4-3fa5-442b-98f2-5629b10e54c6	1730323775697	\N	{"value":"G4D/CaSstZ0MVBeYM+xQDYKtvKW47cJH7Q4MU3LwBoZ6mUlDfbAbCoCRchzdFQZmwYQYlBKNtnzsqsFNKodmrw==","salt":"7HYkH08QnLDWsGUw7wwWpA==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
83a9726d-9649-48af-b1c1-b55464044ba9	\N	password	83ceeb5a-9e8f-4c63-b671-6d8f3560f890	1730725148256	\N	{"value":"BZpxoFxFfftmdFaNGntsAbeLzQeIBIAtoxUtSd1014iSDY+3cFFsE6/xTFR+YLN6eJcqQMYCGmMUY2u9+xFg5g==","salt":"sxEL3lj5PsVcS2zEL++Ojw==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
4743f925-b1fa-40d3-ae84-b8380126de25	\N	password	90586e33-9783-4143-ac23-e38f0665f1a9	1730739463122	\N	{"value":"JmGTckM1Prvwm3Sl0JJwcUWHr4EogMKRKOUQRYPOvzckkbuVpleBrB3JnFs4pe5XxEYG4/9GRcsBZcnjfNrO/g==","salt":"Epkn+WqErbkoGSuoPoawkA==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
f39922c7-1efb-4f8e-ae7c-733d4deecf15	\N	password	7463cbb2-b6ac-4383-b8d4-0abf0d3bf323	1730739850032	\N	{"value":"a9DcU2eqHbhlhfICmZC52Vg9wGbnX+w8zKFZOpWTmD3SnTCMGf9qNCEIyTqIcL7fyd1wEDr1tZjbfuuF57iWdg==","salt":"E6nu3rhjdD6C0BHChL+gjQ==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
000157dd-0bdb-4a2a-8e9a-2f3af58eedb8	\N	password	c8db480e-8390-4496-a99e-93efca3c49db	1730740187665	\N	{"value":"18RXZMP0WoPuqbhvbfXuQ0BjsByIxoMqRS8ghRsvvArmGWVO8c53jzTwOoSSTN3AakcHzbiZRxuImW1NeCeFew==","salt":"AoGjeYqi4ZMD3ZK9f0YdJQ==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
7eca6846-7b68-4999-8599-2335c88e44e2	\N	password	33362f14-57ae-4518-9140-9b69907bc721	1730740282634	\N	{"value":"7Iyp6IBsJWNWkL2djGEQUjNehsi6W4d16HOsT0+htBMn9oCQItJMgGw5OMREkQwEyzO7BJy2XV/3gzdSg8N0PA==","salt":"tzLErQWsLjB3cZ1rDh84ow==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
4c95fcf1-5558-4dd7-a8ac-33c03912d1dd	\N	password	fc20baea-ea1a-45b7-a801-3a126d93937d	1730923836693	\N	{"value":"X4S0GeqMTAOGSnfR7V+9LI49qkb37hbd+nLIWWOEY7dytGxdkvbre2HUPm8IIIOOliPj3WeeKI2/ZzMWZkWZOA==","salt":"/kkwrxbfgkSGWrOb/AIDZA==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
a2116d74-2b30-4e4e-a7b3-ead4b494f8bf	\N	password	8778b977-06d5-479a-bd60-474903c6b024	1730924704159	\N	{"value":"BRXfTSJ1e5LClOyOM6TU2FGYhosvljWOv0z9y9ta+y+EGeDKiG9jewcCg5+/USMASODQb8Ojm6CpfiXoIlPBow==","salt":"+qgPs3kAeYKpHWqfZR4MdQ==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
267c5cc4-3412-46d3-898e-57825452869c	\N	password	19be8373-0fbf-48c9-8d18-bbee1df65cfb	1731081672639	\N	{"value":"RBFMniKzgtSJM75JWwPxKU9NIDRE8uRiXocy6GlggBzGKDfLtt30np2+Hk3VewxfiPSETGR9skMevqeCPO11Sg==","salt":"VmErhi8xS9+gt0jfU/g+hw==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
6e445a50-20f2-4e4b-be9d-b5aa7f253e86	\N	password	b7cf04e7-a16c-44fc-9d85-93f5bbda4f93	1731515744959	\N	{"value":"WhaIsg28QLW3YxpXpiwk7yfPmv+bZlFlU1XuKbJci0xgxMExco/b17r3g9nsOZe6iDPVctaEBgNOaAbG77ExLg==","salt":"EJJoOqufLOfbzQvKH0UIbQ==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
ae925d3b-7d00-4c57-9521-3c10d8f807b3	\N	password	b4a8deab-e981-406c-a88d-272fb85c82c8	1723148438407	\N	{"value":"odMM6MgcJ/MBLjXJ7njwJHwbFD0OBmzhu+90kmw9ZqU=","salt":"mR1E9tO2hDE6clm90M6Bvg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
17907375-fb50-4c4b-ae31-fa95bcd891b5	\N	password	fc01f525-4201-4005-b61e-6c3ad5d2b36e	1732311351726	\N	{"value":"X6niL3rK9SF44epV2kKykmwPcce9Hmm8hDHAtUV7Uto=","salt":"DV8hoFdTX7+tMxEpnY2j+Q==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
52a2ab50-5000-4333-a73b-9d0d8d0def19	\N	password	40dec71f-adcb-48ac-af3c-606c6007158e	1733348008275	\N	{"value":"huw6TS+N3oRNdVP+JOUPxxvH4VgrkF4PAkjybit7KwM=","salt":"0pTitL5h4ev7B3rM3Q6s8A==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
40016a62-693b-4e73-b627-a9946980faff	\N	password	534e938c-43b1-44a3-894c-4c9372316c9d	1723149072077	\N	{"value":"T76gTjrFPaDNPoZAn5Xa2qV27H6gqYupE3vvlkZbwJY=","salt":"TC3P14O90AofMrKQxrGOag==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
b101a794-bd65-4bac-b559-74badd2e131a	\N	password	07e338d0-0827-4ba3-b350-5b55182d34dc	1737481655850	\N	{"value":"CUZSBg/6XdXWJFFWRdUC+Boke3uYaMsWLeNHRaR9B0o=","salt":"G2rdmeCIki2ioszlGgIi5w==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
94b48cb2-d1b3-4192-a6ad-c32b5454059b	\N	password	489717d3-9c35-4de8-a8de-48848340b18a	1740412321888	\N	{"value":"42FsMLB53+lGZQplfjY9mGgnHBAMiqv2nRNRcTU0H1Q=","salt":"xrg7P8W6ZcdyJn4SDblUpA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2024-08-08 20:20:34.51301	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	3148434101
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2024-08-08 20:20:34.531413	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	3148434101
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2024-08-08 20:20:34.573163	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.25.1	\N	\N	3148434101
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2024-08-08 20:20:34.576842	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	3148434101
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2024-08-08 20:20:34.656035	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	3148434101
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2024-08-08 20:20:34.660688	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	3148434101
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2024-08-08 20:20:34.725975	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	3148434101
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2024-08-08 20:20:34.730223	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	3148434101
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2024-08-08 20:20:34.735762	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.25.1	\N	\N	3148434101
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2024-08-08 20:20:34.815841	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.25.1	\N	\N	3148434101
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2024-08-08 20:20:34.865684	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	3148434101
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2024-08-08 20:20:34.870409	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	3148434101
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2024-08-08 20:20:34.889218	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	3148434101
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-08-08 20:20:34.906716	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.25.1	\N	\N	3148434101
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-08-08 20:20:34.908498	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	3148434101
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-08-08 20:20:34.911306	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.25.1	\N	\N	3148434101
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-08-08 20:20:34.914206	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.25.1	\N	\N	3148434101
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2024-08-08 20:20:34.950633	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.25.1	\N	\N	3148434101
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2024-08-08 20:20:34.989774	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	3148434101
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2024-08-08 20:20:34.994577	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	3148434101
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-08-08 20:20:36.181463	119	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	3148434101
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2024-08-08 20:20:34.998559	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	3148434101
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2024-08-08 20:20:35.001904	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	3148434101
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2024-08-08 20:20:35.025147	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.25.1	\N	\N	3148434101
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2024-08-08 20:20:35.030667	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	3148434101
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2024-08-08 20:20:35.032473	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	3148434101
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2024-08-08 20:20:35.058258	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.25.1	\N	\N	3148434101
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2024-08-08 20:20:35.110877	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.25.1	\N	\N	3148434101
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2024-08-08 20:20:35.11359	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	3148434101
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2024-08-08 20:20:35.159793	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.25.1	\N	\N	3148434101
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2024-08-08 20:20:35.169999	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.25.1	\N	\N	3148434101
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2024-08-08 20:20:35.187037	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.25.1	\N	\N	3148434101
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2024-08-08 20:20:35.19346	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.25.1	\N	\N	3148434101
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-08-08 20:20:35.19973	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	3148434101
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-08-08 20:20:35.201643	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	3148434101
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-08-08 20:20:35.223898	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	3148434101
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2024-08-08 20:20:35.22764	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.25.1	\N	\N	3148434101
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-08-08 20:20:35.232208	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	3148434101
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2024-08-08 20:20:35.235602	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.25.1	\N	\N	3148434101
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2024-08-08 20:20:35.238788	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.25.1	\N	\N	3148434101
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-08-08 20:20:35.240087	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	3148434101
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-08-08 20:20:35.241993	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	3148434101
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2024-08-08 20:20:35.2475	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.25.1	\N	\N	3148434101
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-08-08 20:20:35.358186	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.25.1	\N	\N	3148434101
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2024-08-08 20:20:35.364347	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.25.1	\N	\N	3148434101
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-08-08 20:20:35.373937	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	3148434101
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-08-08 20:20:35.387436	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.25.1	\N	\N	3148434101
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-08-08 20:20:35.391181	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	3148434101
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-08-08 20:20:35.458079	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.25.1	\N	\N	3148434101
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-08-08 20:20:35.466366	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.25.1	\N	\N	3148434101
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2024-08-08 20:20:35.529539	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.25.1	\N	\N	3148434101
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2024-08-08 20:20:35.573551	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.25.1	\N	\N	3148434101
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2024-08-08 20:20:35.580362	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3148434101
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2024-08-08 20:20:35.586624	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.25.1	\N	\N	3148434101
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2024-08-08 20:20:35.593353	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.25.1	\N	\N	3148434101
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-08-08 20:20:35.605241	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.25.1	\N	\N	3148434101
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-08-08 20:20:35.615125	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.25.1	\N	\N	3148434101
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-08-08 20:20:35.655607	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.25.1	\N	\N	3148434101
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-08-08 20:20:35.808558	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.25.1	\N	\N	3148434101
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2024-08-08 20:20:35.864666	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.25.1	\N	\N	3148434101
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2024-08-08 20:20:35.874151	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	3148434101
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-08-08 20:20:35.884968	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.25.1	\N	\N	3148434101
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-08-08 20:20:35.890788	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.25.1	\N	\N	3148434101
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2024-08-08 20:20:35.894571	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	3148434101
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2024-08-08 20:20:35.897813	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	3148434101
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2024-08-08 20:20:35.900991	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.25.1	\N	\N	3148434101
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2024-08-08 20:20:35.912394	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.25.1	\N	\N	3148434101
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2024-08-08 20:20:35.917381	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.25.1	\N	\N	3148434101
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2024-08-08 20:20:35.921463	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.25.1	\N	\N	3148434101
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2024-08-08 20:20:35.931953	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.25.1	\N	\N	3148434101
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2024-08-08 20:20:35.936648	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.25.1	\N	\N	3148434101
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2024-08-08 20:20:35.940291	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	3148434101
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-08-08 20:20:35.946081	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	3148434101
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-08-08 20:20:35.952237	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	3148434101
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-08-08 20:20:35.954317	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	3148434101
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-08-08 20:20:35.969139	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.25.1	\N	\N	3148434101
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-08-08 20:20:35.974893	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.25.1	\N	\N	3148434101
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-08-08 20:20:35.978189	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.25.1	\N	\N	3148434101
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-08-08 20:20:35.97966	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.25.1	\N	\N	3148434101
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-08-08 20:20:35.992712	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.25.1	\N	\N	3148434101
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-08-08 20:20:35.994305	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.25.1	\N	\N	3148434101
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-08-08 20:20:35.999423	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.25.1	\N	\N	3148434101
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-08-08 20:20:36.000872	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	3148434101
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-08-08 20:20:36.004797	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	3148434101
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-08-08 20:20:36.005995	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	3148434101
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-08-08 20:20:36.010932	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	3148434101
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2024-08-08 20:20:36.014607	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.25.1	\N	\N	3148434101
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-08-08 20:20:36.019873	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.25.1	\N	\N	3148434101
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-08-08 20:20:36.027011	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.25.1	\N	\N	3148434101
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-08 20:20:36.032779	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.25.1	\N	\N	3148434101
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-08 20:20:36.037152	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.25.1	\N	\N	3148434101
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-08 20:20:36.042131	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	3148434101
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-08 20:20:36.047676	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.25.1	\N	\N	3148434101
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-08 20:20:36.049107	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	3148434101
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-08 20:20:36.055704	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	3148434101
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-08 20:20:36.057146	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.25.1	\N	\N	3148434101
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-08 20:20:36.062089	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.25.1	\N	\N	3148434101
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-08-08 20:20:36.070045	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	3148434101
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-08-08 20:20:36.071457	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3148434101
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-08-08 20:20:36.078746	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3148434101
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-08-08 20:20:36.084303	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3148434101
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-08-08 20:20:36.085649	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3148434101
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-08-08 20:20:36.090515	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.25.1	\N	\N	3148434101
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-08-08 20:20:36.095575	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.25.1	\N	\N	3148434101
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2024-08-08 20:20:36.100205	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.25.1	\N	\N	3148434101
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2024-08-08 20:20:36.104664	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.25.1	\N	\N	3148434101
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2024-08-08 20:20:36.108939	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.25.1	\N	\N	3148434101
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2024-08-08 20:20:36.113886	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.25.1	\N	\N	3148434101
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-08-08 20:20:36.11839	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	3148434101
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-08-08 20:20:36.119812	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	3148434101
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-08-08 20:20:36.124729	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3148434101
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2024-08-08 20:20:36.129121	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.25.1	\N	\N	3148434101
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-08-08 20:20:36.148227	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	3148434101
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-08-08 20:20:36.149787	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.25.1	\N	\N	3148434101
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-08-08 20:20:36.154122	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.25.1	\N	\N	3148434101
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-08-08 20:20:36.155615	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.25.1	\N	\N	3148434101
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-08-08 20:20:36.160276	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.25.1	\N	\N	3148434101
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-08-08 20:20:36.163211	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	3148434101
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-08-08 20:20:36.176111	118	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	3148434101
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-08-08 20:20:36.185187	120	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3148434101
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-08-08 20:20:36.191581	121	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3148434101
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-08-08 20:20:36.195618	122	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	3148434101
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-08-08 20:20:36.197414	123	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3148434101
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-08-08 20:20:36.199828	124	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3148434101
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2024-11-19 16:11:10.511148	125	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	2032669831
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-19 16:11:10.56376	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	2032669831
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-19 16:11:11.14948	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	2032669831
25.0.0-28265-index-cleanup	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-19 16:11:11.190007	128	EXECUTED	9:8c0cfa341a0474385b324f5c4b2dfcc1	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...		\N	4.29.1	\N	\N	2032669831
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-19 16:11:11.198889	129	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	2032669831
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-19 16:11:11.57202	130	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	2032669831
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-19 16:11:11.663653	131	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	2032669831
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-19 16:11:11.75339	132	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	2032669831
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-19 16:11:11.761723	133	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	2032669831
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-19 16:11:12.354237	134	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	2032669831
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-11-19 16:11:12.392081	135	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	2032669831
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-11-19 16:11:12.447153	136	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	2032669831
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-11-19 16:11:12.95861	137	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	2032669831
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-11-19 16:11:12.99858	138	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	2032669831
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-11-19 16:11:13.040463	139	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	2032669831
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-11-19 16:11:13.578126	140	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	2032669831
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-11-19 16:11:14.144355	141	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	2032669831
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-11-19 16:11:14.281515	142	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	2032669831
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-11-19 16:11:14.345375	143	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	2032669831
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-11-19 16:11:14.360923	144	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	2032669831
26.0.6-34013	keycloak	META-INF/jpa-changelog-26.0.6.xml	2025-01-03 16:45:23.062865	145	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	5922723034
\.


--
-- Data for Name: databasechangelog_scim_jpa_e; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog_scim_jpa_e (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
scim-sdk-1.0	pascal knueppel	META-INF/scim-changelog.xml	2024-10-21 16:47:27.192175	1	EXECUTED	9:c452158d23232ca6d0f33ed7baaac0db	createTable tableName=SCIM_SERVICE_PROVIDER; createTable tableName=SCIM_RESOURCE_TYPE; addUniqueConstraint constraintName=SCIM_RESOURCE_TYPE_UQ, tableName=SCIM_RESOURCE_TYPE; createTable tableName=SCIM_ENDPOINT_ROLES; createIndex indexName=SCIM_EN...		\N	4.25.1	\N	\N	9529246971
scim-enterprise-extension-1	pascal_knueppel	META-INF/scim-changelog.xml	2024-10-21 16:47:27.296605	2	EXECUTED	9:7bf32d01bdc221a70e3f001466dba706	addColumn tableName=SCIM_SERVICE_PROVIDER; createTable tableName=SCIM_SCHEMA; createTable tableName=SCIM_SCHEMA_ATTRIBUTE; createIndex indexName=SCIM_ATTRIBUTE_SCHEMA_IDX, tableName=SCIM_SCHEMA_ATTRIBUTE; createIndex indexName=SCIM_ATTRIBUTE_PAREN...		\N	4.25.1	\N	\N	9529246971
user-fed-tables-extension	pascal_knueppel	META-INF/scim-changelog.xml	2024-10-21 16:47:27.305185	3	EXECUTED	9:f31bfa5b826778da7dd9cf86870a0e56	addColumn tableName=SCIM_SERVICE_PROVIDER		\N	4.25.1	\N	\N	9529246971
kc-22-1.1.0	pascal_knueppel	META-INF/scim-changelog.xml	2024-10-21 16:47:27.315961	4	EXECUTED	9:ea78aa0cac9e2dcce9dc5dcf0247cf00	addColumn tableName=SCIM_SERVICE_PROVIDER		\N	4.25.1	\N	\N	9529246971
kc-22-1.2.0	pascal_knueppel	META-INF/scim-changelog.xml	2024-10-21 16:47:27.333055	5	EXECUTED	9:aefd0121878b97695a67804f05a9c3d3	addColumn tableName=SCIM_SERVICE_PROVIDER; addColumn tableName=SCIM_SCHEMA_ATTRIBUTE		\N	4.25.1	\N	\N	9529246971
1.3.0	pascal_knueppel	META-INF/scim-changelog.xml	2024-10-21 16:47:27.345213	6	EXECUTED	9:63d7ebf07abef14ab5957e8b7c75999b	addColumn tableName=SCIM_SERVICE_PROVIDER		\N	4.25.1	\N	\N	9529246971
1.4.0-support-for-oracle	pascal_knueppel	META-INF/scim-changelog.xml	2024-10-21 16:47:27.392539	7	EXECUTED	9:19405c60987fd00ec0bf973054b07fcc	dropColumn columnName=CREATED, tableName=SCIM_SERVICE_PROVIDER; dropColumn columnName=LAST_MODIFIED, tableName=SCIM_SERVICE_PROVIDER; addColumn tableName=SCIM_SERVICE_PROVIDER; dropColumn columnName=CREATED, tableName=SCIM_RESOURCE_TYPE; dropColum...		\N	4.25.1	\N	\N	9529246971
2.0.0-sequence-creation	pascal_knueppel	META-INF/scim-changelog.xml	2024-10-21 16:47:27.403849	8	EXECUTED	9:16999aee0f593421ac5c3cd23c985b60	createSequence sequenceName=SCIM_REMOTE_OPERATION_SEQ		\N	4.25.1	\N	\N	9529246971
2.0.0-sequence-creation-mariadb	pascal_knueppel	META-INF/scim-changelog.xml	2024-10-21 16:47:27.409623	9	MARK_RAN	9:a5aa60da58307fbebec5a24a29ace56a	createSequence sequenceName=SCIM_REMOTE_OPERATION_SEQ		\N	4.25.1	\N	\N	9529246971
2.0.0	pascal_knueppel	META-INF/scim-changelog.xml	2024-10-21 16:47:27.497461	10	EXECUTED	9:21a5c0f6e50cfd7c8b6360e86dba7704	createTable tableName=SCIM_REMOTE_PROVIDER; createTable tableName=SCIM_REMOTE_AUTHENTICATION; createIndex indexName=REMOTE_PROVIDER_AUTH_IDX, tableName=SCIM_REMOTE_AUTHENTICATION; createTable tableName=SCIM_REMOTE_PROVIDER_MAPPING; createIndex ind...		\N	4.25.1	\N	\N	9529246971
2.2.0	pascal_knueppel	META-INF/scim-changelog.xml	2024-10-21 16:47:27.509203	11	EXECUTED	9:00954dea9016ae1b765c9b0db28d7af9	addColumn tableName=SCIM_REMOTE_PROVIDER; addColumn tableName=SCIM_SERVICE_PROVIDER		\N	4.25.1	\N	\N	9529246971
3.0.0	pascal_knueppel	META-INF/scim-changelog.xml	2025-01-28 15:58:01.743934	12	EXECUTED	9:f672ba3b0dfc4a3a076b2d466f425836	createTable tableName=SCIM_EXTERNAL_RESOURCE_MAPPING; addUniqueConstraint constraintName=EXTERNAL_ID_UNIQUE, tableName=SCIM_EXTERNAL_RESOURCE_MAPPING; createIndex indexName=EXT_RESOURCE_PROV_REALM_IDX, tableName=SCIM_EXTERNAL_RESOURCE_MAPPING; cre...		\N	4.29.1	\N	\N	8079881669
\.


--
-- Data for Name: databasechangelog_scim_resou; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog_scim_resou (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
scim-resource-1.0	contact@indiehosters.net	META-INF/scim-resource-changelog.xml	2024-10-11 14:34:24.026484	1	EXECUTED	9:f623bbf4f09e35c60098a3b026d42cae	createTable tableName=SCIM_RESOURCE; addPrimaryKey constraintName=PK_SCIM_RESOURCE, tableName=SCIM_RESOURCE; addForeignKeyConstraint baseTableName=SCIM_RESOURCE, constraintName=FK_SCIM_RESOURCE_REALM, referencedTableName=REALM; addForeignKeyConstr...		\N	4.25.1	\N	\N	8657263714
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
f493d84c-5308-498f-afec-c6f4cfffd553	ae1f5c94-4630-4846-acb8-200371e03893	f
f493d84c-5308-498f-afec-c6f4cfffd553	e699d045-6556-4a8c-bb2b-eec123e7d607	t
f493d84c-5308-498f-afec-c6f4cfffd553	5c2a597a-7480-4270-a86c-b1d02750ce60	t
f493d84c-5308-498f-afec-c6f4cfffd553	379a3e26-dd12-4608-919a-e84602fcbeb1	t
f493d84c-5308-498f-afec-c6f4cfffd553	637fac36-2646-4763-8913-3fb8679a77a4	f
f493d84c-5308-498f-afec-c6f4cfffd553	040da43b-fd9e-47cf-8f0d-68f6ac7e6405	f
f493d84c-5308-498f-afec-c6f4cfffd553	22b7f0e6-d566-4ac4-80ef-08ff08998740	t
f493d84c-5308-498f-afec-c6f4cfffd553	131703b4-a4fe-4c12-91e4-10aa029661e0	t
f493d84c-5308-498f-afec-c6f4cfffd553	3419fbee-de34-42ab-813d-873b113fa211	f
f493d84c-5308-498f-afec-c6f4cfffd553	2ba22377-8a2c-4e8b-a860-b2ba519f38da	t
5760f0e0-8dc4-453f-b407-19c01025187d	7610c75c-6b08-47eb-a96b-37b6d0ed8afb	f
5760f0e0-8dc4-453f-b407-19c01025187d	5361170e-966a-40f4-b73f-da51458ba393	t
5760f0e0-8dc4-453f-b407-19c01025187d	d7ce6ee2-6ed3-4a82-a5af-718704a6a888	t
5760f0e0-8dc4-453f-b407-19c01025187d	18adc9ea-03c2-4910-a599-b60baf0926b2	t
5760f0e0-8dc4-453f-b407-19c01025187d	b789a1aa-c97d-4fb1-b771-f2cbccafeae0	f
5760f0e0-8dc4-453f-b407-19c01025187d	15db502e-270d-4bc5-98d8-786393ef0fed	f
5760f0e0-8dc4-453f-b407-19c01025187d	4597c668-fa1b-478d-9843-5848285c470b	t
5760f0e0-8dc4-453f-b407-19c01025187d	52b1693f-4fc2-4ce5-9b30-95a8daef5fcd	t
5760f0e0-8dc4-453f-b407-19c01025187d	667d3b9a-7261-460e-847f-d66563aae9e1	f
5760f0e0-8dc4-453f-b407-19c01025187d	cf860e2f-978d-469d-a18e-db7a4008b243	t
429ce2ec-99a2-44b6-9c27-36b18f46b8d3	c72aafc0-5c09-4215-b3ae-eae56f417bd5	f
429ce2ec-99a2-44b6-9c27-36b18f46b8d3	eaae48b2-ecee-4938-a10a-2f9cbf593b5f	t
429ce2ec-99a2-44b6-9c27-36b18f46b8d3	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3	t
429ce2ec-99a2-44b6-9c27-36b18f46b8d3	e1785efd-bf9a-446a-ad94-3d569bad7869	t
429ce2ec-99a2-44b6-9c27-36b18f46b8d3	5f554b86-1456-486d-b699-03c87529d428	f
429ce2ec-99a2-44b6-9c27-36b18f46b8d3	8b8d5b04-7e0f-43a8-8829-250ff789726a	f
429ce2ec-99a2-44b6-9c27-36b18f46b8d3	cda41599-0e60-42d6-b433-c15b126c1449	t
429ce2ec-99a2-44b6-9c27-36b18f46b8d3	fb4f128c-0ba4-4d3c-80d9-65a0f3c4b2ec	t
429ce2ec-99a2-44b6-9c27-36b18f46b8d3	42b96f1a-dd81-47b8-b5b6-b4a0630b6350	f
429ce2ec-99a2-44b6-9c27-36b18f46b8d3	6b8b6f76-1427-43b0-aed9-5ac7260ae1f1	t
b4825e08-1ac5-43e9-990a-7556e882153a	329657bf-094f-44e9-92ed-bf9aca3b7fbb	f
b4825e08-1ac5-43e9-990a-7556e882153a	8561625f-4b07-445c-84ab-1640048627e2	t
b4825e08-1ac5-43e9-990a-7556e882153a	e40d1da7-3987-4338-ad34-02ece0227ddd	t
b4825e08-1ac5-43e9-990a-7556e882153a	7340bf61-1107-4848-a100-32981012bf8f	t
b4825e08-1ac5-43e9-990a-7556e882153a	0b7b08ab-1f3c-44de-86e6-74d304e82697	f
b4825e08-1ac5-43e9-990a-7556e882153a	23806095-5d19-4b3c-9977-076c75933e96	f
b4825e08-1ac5-43e9-990a-7556e882153a	9e7c1bdc-270a-4b82-a59d-fa511fb71964	t
b4825e08-1ac5-43e9-990a-7556e882153a	4a255549-9040-4e49-b43b-1c7c017e424c	t
b4825e08-1ac5-43e9-990a-7556e882153a	55be477a-ddcf-4a58-bd0b-d9f0f829593b	f
b4825e08-1ac5-43e9-990a-7556e882153a	4a8e7cf1-2d35-451b-9c98-67b3f61f1368	t
2256a568-ee44-4cb6-88fa-488d343b1bf5	2bd5607e-74d2-4ead-94c8-5b0e4861b266	f
2256a568-ee44-4cb6-88fa-488d343b1bf5	6c937d93-30b4-4bac-9406-4d11a6fdd1b2	t
2256a568-ee44-4cb6-88fa-488d343b1bf5	5981264e-0c65-4ccc-b73c-894a11d9d5f5	t
2256a568-ee44-4cb6-88fa-488d343b1bf5	1131f752-fbe3-4ca0-a3a4-8a009a537b5a	t
2256a568-ee44-4cb6-88fa-488d343b1bf5	a499924a-2f59-4e14-a115-16aac030f760	f
2256a568-ee44-4cb6-88fa-488d343b1bf5	30a3ec2f-b90a-4656-8d56-60466a47a79e	f
2256a568-ee44-4cb6-88fa-488d343b1bf5	13abbec8-4f5f-4eab-97a8-9b5097559d9e	t
2256a568-ee44-4cb6-88fa-488d343b1bf5	40dc0180-628a-4c3a-b686-705d70183eda	t
2256a568-ee44-4cb6-88fa-488d343b1bf5	20220de8-fcaf-4554-80ef-9078a66c844e	f
2256a568-ee44-4cb6-88fa-488d343b1bf5	99665abe-71db-4ae8-8e31-f4c782298c4a	t
5760f0e0-8dc4-453f-b407-19c01025187d	49e25b5d-d76e-4051-9c7c-7a0b5c1052bd	t
5760f0e0-8dc4-453f-b407-19c01025187d	03b1a0a4-bd48-49a4-926b-de5f66803c2b	t
f493d84c-5308-498f-afec-c6f4cfffd553	d93f07c8-4801-4b12-a63b-1085e3135be8	t
2256a568-ee44-4cb6-88fa-488d343b1bf5	0673cf19-e51c-4979-be63-052f84c3c555	t
429ce2ec-99a2-44b6-9c27-36b18f46b8d3	fa7619c7-fa00-4a0a-a46f-911d0bbc309b	t
b4825e08-1ac5-43e9-990a-7556e882153a	79cf0e01-9d2d-4d0e-95a5-a0884158d529	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
saml	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+test120924-1@gmail.com	rhysyngsun+test120924-1@gmail.com	\N	ff8c6822-a130-408e-98ce-1e083b2dfeca
touchstone-idp	5760f0e0-8dc4-453f-b407-19c01025187d	jackson@example.com	jackson@example.com	\N	3492d892-d606-436d-af14-4c1e303d43db
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
72e53f01-c6eb-4162-a1af-2b18d3acd901	t	touchstone-idp	saml	f	f	5760f0e0-8dc4-453f-b407-19c01025187d	f	f	\N	\N	Use Touchstone@MIT	f	\N	f
63f0b599-31a4-4ac4-9b27-69c2e3515822	t	saml	saml	f	f	5760f0e0-8dc4-453f-b407-19c01025187d	f	t	\N	\N	Auth0	f	\N	f
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
72e53f01-c6eb-4162-a1af-2b18d3acd901	false	postBindingLogout
72e53f01-c6eb-4162-a1af-2b18d3acd901	true	postBindingResponse
72e53f01-c6eb-4162-a1af-2b18d3acd901	false	backchannelSupported
72e53f01-c6eb-4162-a1af-2b18d3acd901	KEY_ID	xmlSigKeyInfoKeyNameTransformer
72e53f01-c6eb-4162-a1af-2b18d3acd901	https://saml.example.com/entityid	idpEntityId
72e53f01-c6eb-4162-a1af-2b18d3acd901	false	useMetadataDescriptorUrl
72e53f01-c6eb-4162-a1af-2b18d3acd901	false	loginHint
72e53f01-c6eb-4162-a1af-2b18d3acd901	true	allowCreate
72e53f01-c6eb-4162-a1af-2b18d3acd901	true	enabledFromMetadata
72e53f01-c6eb-4162-a1af-2b18d3acd901	exact	authnContextComparisonType
72e53f01-c6eb-4162-a1af-2b18d3acd901	IMPORT	syncMode
72e53f01-c6eb-4162-a1af-2b18d3acd901	https://mocksaml.com/api/saml/sso	singleSignOnServiceUrl
72e53f01-c6eb-4162-a1af-2b18d3acd901	true	wantAuthnRequestsSigned
72e53f01-c6eb-4162-a1af-2b18d3acd901	0	allowedClockSkew
72e53f01-c6eb-4162-a1af-2b18d3acd901	true	validateSignature
72e53f01-c6eb-4162-a1af-2b18d3acd901	MIIC4jCCAcoCCQC33wnybT5QZDANBgkqhkiG9w0BAQsFADAyMQswCQYDVQQGEwJV\nSzEPMA0GA1UECgwGQm94eUhRMRIwEAYDVQQDDAlNb2NrIFNBTUwwIBcNMjIwMjI4\nMjE0NjM4WhgPMzAyMTA3MDEyMTQ2MzhaMDIxCzAJBgNVBAYTAlVLMQ8wDQYDVQQK\nDAZCb3h5SFExEjAQBgNVBAMMCU1vY2sgU0FNTDCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBALGfYettMsct1T6tVUwTudNJH5Pnb9GGnkXi9Zw/e6x45DD0\nRuRONbFlJ2T4RjAE/uG+AjXxXQ8o2SZfb9+GgmCHuTJFNgHoZ1nFVXCmb/Hg8Hpd\n4vOAGXndixaReOiq3EH5XvpMjMkJ3+8+9VYMzMZOjkgQtAqO36eAFFfNKX7dTj3V\npwLkvz6/KFCq8OAwY+AUi4eZm5J57D31GzjHwfjH9WTeX0MyndmnNB1qV75qQR3b\n2/W5sGHRv+9AarggJkF+ptUkXoLtVA51wcfYm6hILptpde5FQC8RWY1YrswBWAEZ\nNfyrR4JeSweElNHg4NVOs4TwGjOPwWGqzTfgTlECAwEAATANBgkqhkiG9w0BAQsF\nAAOCAQEAAYRlYflSXAWoZpFfwNiCQVE5d9zZ0DPzNdWhAybXcTyMf0z5mDf6FWBW\n5Gyoi9u3EMEDnzLcJNkwJAAc39Apa4I2/tml+Jy29dk8bTyX6m93ngmCgdLh5Za4\nkhuU3AM3L63g7VexCuO7kwkjh/+LqdcIXsVGO6XDfu2QOs1Xpe9zIzLpwm/RNYeX\nUjbSj5ce/jekpAw7qyVVL4xOyh8AtUW1ek3wIw1MJvEgEPt0d16oshWJpoS1OT8L\nr/22SvYEo3EmSGdTVGgk3x3s+A0qWAqTcyjr7Q4s/GKYRFfomGwz0TZ4Iw1ZN99M\nm0eo2USlSRTVl7QHRTuiuSThHpLKQQ==	signingCertificate
72e53f01-c6eb-4162-a1af-2b18d3acd901	urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress	nameIDPolicyFormat
72e53f01-c6eb-4162-a1af-2b18d3acd901	http://keycloak.odl.local:8080/realms/olapps	entityId
72e53f01-c6eb-4162-a1af-2b18d3acd901	false	signSpMetadata
72e53f01-c6eb-4162-a1af-2b18d3acd901	false	wantAssertionsEncrypted
72e53f01-c6eb-4162-a1af-2b18d3acd901	RSA_SHA256	signatureAlgorithm
72e53f01-c6eb-4162-a1af-2b18d3acd901	false	sendClientIdOnLogout
72e53f01-c6eb-4162-a1af-2b18d3acd901	false	wantAssertionsSigned
72e53f01-c6eb-4162-a1af-2b18d3acd901	https://mocksaml.com/api/saml/metadata	metadataDescriptorUrl
72e53f01-c6eb-4162-a1af-2b18d3acd901	true	sendIdTokenOnLogout
72e53f01-c6eb-4162-a1af-2b18d3acd901	true	postBindingAuthnRequest
72e53f01-c6eb-4162-a1af-2b18d3acd901	false	forceAuthn
72e53f01-c6eb-4162-a1af-2b18d3acd901	0	attributeConsumingServiceIndex
72e53f01-c6eb-4162-a1af-2b18d3acd901	false	addExtensionsElementWithKeyInfo
72e53f01-c6eb-4162-a1af-2b18d3acd901	Subject NameID	principalType
63f0b599-31a4-4ac4-9b27-69c2e3515822	true	postBindingLogout
63f0b599-31a4-4ac4-9b27-69c2e3515822	https://dev-6408c7fe0f830jhf.us.auth0.com/samlp/5Lj9IZ1kmLEsGY3LIUNjaT23AnVGSxmO/logout	singleLogoutServiceUrl
63f0b599-31a4-4ac4-9b27-69c2e3515822	true	postBindingResponse
63f0b599-31a4-4ac4-9b27-69c2e3515822	false	backchannelSupported
63f0b599-31a4-4ac4-9b27-69c2e3515822	false	caseSensitiveOriginalUsername
63f0b599-31a4-4ac4-9b27-69c2e3515822	urn:dev-6408c7fe0f830jhf.us.auth0.com	idpEntityId
63f0b599-31a4-4ac4-9b27-69c2e3515822	false	loginHint
63f0b599-31a4-4ac4-9b27-69c2e3515822	true	allowCreate
63f0b599-31a4-4ac4-9b27-69c2e3515822	true	enabledFromMetadata
63f0b599-31a4-4ac4-9b27-69c2e3515822	LEGACY	syncMode
63f0b599-31a4-4ac4-9b27-69c2e3515822	exact	authnContextComparisonType
63f0b599-31a4-4ac4-9b27-69c2e3515822	https://dev-6408c7fe0f830jhf.us.auth0.com/samlp/5Lj9IZ1kmLEsGY3LIUNjaT23AnVGSxmO	singleSignOnServiceUrl
63f0b599-31a4-4ac4-9b27-69c2e3515822	false	wantAuthnRequestsSigned
63f0b599-31a4-4ac4-9b27-69c2e3515822	0	allowedClockSkew
63f0b599-31a4-4ac4-9b27-69c2e3515822	false	artifactBindingResponse
63f0b599-31a4-4ac4-9b27-69c2e3515822	false	validateSignature
63f0b599-31a4-4ac4-9b27-69c2e3515822	MIIDHTCCAgWgAwIBAgIJfPUhLlBClXmBMA0GCSqGSIb3DQEBCwUAMCwxKjAoBgNVBAMTIWRldi02NDA4YzdmZTBmODMwamhmLnVzLmF1dGgwLmNvbTAeFw0yNDEyMDkxNjU0NDdaFw0zODA4MTgxNjU0NDdaMCwxKjAoBgNVBAMTIWRldi02NDA4YzdmZTBmODMwamhmLnVzLmF1dGgwLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKwZbYUoMW/IYw0ZEPBWfyVhGzbEZ3KrCf7Nfy/ayKg1/2V65UZw2L7mNTQ9amEGry2lyFA+8g3XmEhBGeU5I/DLMaqPgvxW8H6GohJQxJkByUzsHtZu7gpAfDsP0TqiwP3JiSxC7fLAGOCksiTjhcf7MTQAAXy/gsAD8wNeAJC3kx1xExUfzZ1nS72AV3HNelzhpKHw4yNhyg4Yoav4nll2LnKhyM0kj7dFd/FtB3t6v4BYjWafZ7EWk09Gvgd8CSfXYI9OJe2Ng4HU4kHO9kQREOG3osAvz+SU1frsWrN4IuA9rk6CZhfr85wi5eBlQifjjTwEylcobwCSjZKXo0UCAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUKzLnORFqKfIddShJo42WK9bqdYAwDgYDVR0PAQH/BAQDAgKEMA0GCSqGSIb3DQEBCwUAA4IBAQCcdDsnO6Qf0tHqwzLZARpntk7G0NKDDKUREB7uFSY9J1A5wGMY1ENtF0TZ+2WI1EJQ7/MBAdBxGgiOFJDxFQRXuSojyYXKNmzmDcH5NXkSsiCQRNE1WSc5UpaJSxBQcDUyVfdpKIwZjO2HSzM1XsaGY9NY5jlHuj/qWa2b5bgtlFquHzsSw2wuHVaIFwaBiO+Kbr85tUDWb//eTRzr39a8Pn/81Yl7bt4ik/TPvLvSo2snIgU20vOz0lFHBDkYJPxhiNkZTS8I7uVw+lnw9UVuYmWFpZCOg/1rSADSqAQTKWkya0JUkMjgP1kz3JKmwdTAYi/SkAuMkscs+IfcyVU0	signingCertificate
63f0b599-31a4-4ac4-9b27-69c2e3515822	urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress	nameIDPolicyFormat
63f0b599-31a4-4ac4-9b27-69c2e3515822	https://keycloak.odl.local/realms/olapps	entityId
63f0b599-31a4-4ac4-9b27-69c2e3515822	false	signSpMetadata
63f0b599-31a4-4ac4-9b27-69c2e3515822	false	wantAssertionsEncrypted
63f0b599-31a4-4ac4-9b27-69c2e3515822	false	sendClientIdOnLogout
63f0b599-31a4-4ac4-9b27-69c2e3515822	false	wantAssertionsSigned
63f0b599-31a4-4ac4-9b27-69c2e3515822	https://dev-6408c7fe0f830jhf.us.auth0.com/samlp/metadata/5Lj9IZ1kmLEsGY3LIUNjaT23AnVGSxmO	metadataDescriptorUrl
63f0b599-31a4-4ac4-9b27-69c2e3515822	true	sendIdTokenOnLogout
63f0b599-31a4-4ac4-9b27-69c2e3515822	true	postBindingAuthnRequest
63f0b599-31a4-4ac4-9b27-69c2e3515822	false	forceAuthn
63f0b599-31a4-4ac4-9b27-69c2e3515822	0	attributeConsumingServiceIndex
63f0b599-31a4-4ac4-9b27-69c2e3515822	false	addExtensionsElementWithKeyInfo
63f0b599-31a4-4ac4-9b27-69c2e3515822	SUBJECT	principalType
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
919f72fe-8bd5-40b7-9240-f28b17732799	email	touchstone-idp	saml-user-attribute-idp-mapper	5760f0e0-8dc4-453f-b407-19c01025187d
b9fb59d1-07e4-41d7-9f6b-efec026d15b5	email	saml	saml-user-attribute-idp-mapper	5760f0e0-8dc4-453f-b407-19c01025187d
a69d7697-6cad-44b2-9d7a-f686c39d808f	name	saml	saml-user-attribute-idp-mapper	5760f0e0-8dc4-453f-b407-19c01025187d
34ec9545-1897-4280-a1b6-b2f5632d4396	username-formatter	saml	saml-username-idp-mapper	5760f0e0-8dc4-453f-b407-19c01025187d
3bd72fc6-efdb-4cef-a461-c8a63f957d60	email-opt-in-default	saml	hardcoded-attribute-idp-mapper	5760f0e0-8dc4-453f-b407-19c01025187d
6e3a4aff-6f83-4d16-b149-a5b8ed54a0ff	first-name	saml	saml-user-attribute-idp-mapper	5760f0e0-8dc4-453f-b407-19c01025187d
a7737a74-2cf3-45d1-9c1f-01f754c26aa1	last-name	saml	saml-user-attribute-idp-mapper	5760f0e0-8dc4-453f-b407-19c01025187d
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
919f72fe-8bd5-40b7-9240-f28b17732799	INHERIT	syncMode
919f72fe-8bd5-40b7-9240-f28b17732799	email	user.attribute
919f72fe-8bd5-40b7-9240-f28b17732799	Email	attribute.friendly.name
919f72fe-8bd5-40b7-9240-f28b17732799	ATTRIBUTE_FORMAT_BASIC	attribute.name.format
919f72fe-8bd5-40b7-9240-f28b17732799	mail	attribute.name
a69d7697-6cad-44b2-9d7a-f686c39d808f	INHERIT	syncMode
a69d7697-6cad-44b2-9d7a-f686c39d808f	fullName	user.attribute
a69d7697-6cad-44b2-9d7a-f686c39d808f	ATTRIBUTE_FORMAT_BASIC	attribute.name.format
a69d7697-6cad-44b2-9d7a-f686c39d808f	http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name	attribute.name
34ec9545-1897-4280-a1b6-b2f5632d4396	INHERIT	syncMode
34ec9545-1897-4280-a1b6-b2f5632d4396	${ATTRIBUTE.mail | localpart}	template
34ec9545-1897-4280-a1b6-b2f5632d4396	LOCAL	target
6e3a4aff-6f83-4d16-b149-a5b8ed54a0ff	INHERIT	syncMode
6e3a4aff-6f83-4d16-b149-a5b8ed54a0ff	firstName	user.attribute
6e3a4aff-6f83-4d16-b149-a5b8ed54a0ff	ATTRIBUTE_FORMAT_BASIC	attribute.name.format
6e3a4aff-6f83-4d16-b149-a5b8ed54a0ff	givenName	attribute.name
a7737a74-2cf3-45d1-9c1f-01f754c26aa1	INHERIT	syncMode
a7737a74-2cf3-45d1-9c1f-01f754c26aa1	lastName	user.attribute
a7737a74-2cf3-45d1-9c1f-01f754c26aa1	ATTRIBUTE_FORMAT_BASIC	attribute.name.format
a7737a74-2cf3-45d1-9c1f-01f754c26aa1	sn	attribute.name
b9fb59d1-07e4-41d7-9f6b-efec026d15b5	INHERIT	syncMode
b9fb59d1-07e4-41d7-9f6b-efec026d15b5	email	user.attribute
b9fb59d1-07e4-41d7-9f6b-efec026d15b5	ATTRIBUTE_FORMAT_BASIC	attribute.name.format
b9fb59d1-07e4-41d7-9f6b-efec026d15b5	http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress	attribute.name
3bd72fc6-efdb-4cef-a461-c8a63f957d60	1	attribute.value
3bd72fc6-efdb-4cef-a461-c8a63f957d60	INHERIT	syncMode
3bd72fc6-efdb-4cef-a461-c8a63f957d60	emailOptIn	attribute
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
f2a35d82-c9fe-4fef-abba-0a714b3c8217	Discussions	1730a51a-64e2-4559-a195-6bed2ed1ad6f	5760f0e0-8dc4-453f-b407-19c01025187d	0
1730a51a-64e2-4559-a195-6bed2ed1ad6f	Imported	 	5760f0e0-8dc4-453f-b407-19c01025187d	0
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
8eaee4b4-db59-489b-9ce3-217077d760ff	f493d84c-5308-498f-afec-c6f4cfffd553	f	${role_default-roles}	default-roles-master	f493d84c-5308-498f-afec-c6f4cfffd553	\N	\N
80545bcc-e358-49d3-86ba-313940cdd7ff	f493d84c-5308-498f-afec-c6f4cfffd553	f	${role_create-realm}	create-realm	f493d84c-5308-498f-afec-c6f4cfffd553	\N	\N
edc30253-7dcc-456a-8b45-698bcb7a4f13	f493d84c-5308-498f-afec-c6f4cfffd553	f	${role_admin}	admin	f493d84c-5308-498f-afec-c6f4cfffd553	\N	\N
74075efc-d3b5-4a36-99eb-1ef3c2e3d59d	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_create-client}	create-client	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
0fafe4d1-8287-4b40-8b34-d15bb7ed3c23	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_view-realm}	view-realm	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
bb7b66f6-c51f-427a-b719-dced8d0a8b94	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_view-users}	view-users	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
14943061-6e0b-44b0-bd7e-ac4e5041a708	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_view-clients}	view-clients	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
6fbd252f-b853-4ee7-ae38-57d8079cc9d3	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_view-events}	view-events	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
c71d31f4-ba6f-473a-9e5e-e5aa0f52ccd1	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_view-identity-providers}	view-identity-providers	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
0031a068-38fc-4740-aff5-9090a25a9d64	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_view-authorization}	view-authorization	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
5c7f1b3b-8b77-4bd6-8e45-9c673abdae69	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_manage-realm}	manage-realm	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
893777ab-9cc2-417f-9939-7268a885fb50	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_manage-users}	manage-users	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
a001819c-1669-40f4-8f17-8f93c62e2353	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_manage-clients}	manage-clients	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
cfb607e2-660b-4271-88f2-dd4bba924767	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_manage-events}	manage-events	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
43b3b2de-46ca-427d-9db1-8c0c96ea3e84	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_manage-identity-providers}	manage-identity-providers	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
294d846c-2cbb-4e3a-afda-5580c14cd445	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_manage-authorization}	manage-authorization	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
e2e6515f-4aed-4e6e-b7dd-7cc85ff7f69a	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_query-users}	query-users	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
1ae50995-5b04-41fb-9416-1c88bd8900ad	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_query-clients}	query-clients	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
6cb514ac-9fb5-4305-8c02-a872585b57bb	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_query-realms}	query-realms	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
aa4019f0-f81f-486d-b4ff-8a919a3fcd79	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_query-groups}	query-groups	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
7a47bcef-dfae-41ef-ab34-7ab480f8caa7	853be0b2-ad1a-4116-aff3-c10f318e9ad5	t	${role_view-profile}	view-profile	f493d84c-5308-498f-afec-c6f4cfffd553	853be0b2-ad1a-4116-aff3-c10f318e9ad5	\N
21fbca6f-0536-4f1d-b130-78f40e7c690b	853be0b2-ad1a-4116-aff3-c10f318e9ad5	t	${role_manage-account}	manage-account	f493d84c-5308-498f-afec-c6f4cfffd553	853be0b2-ad1a-4116-aff3-c10f318e9ad5	\N
b5c29448-3d25-494b-bb97-863c156cddb0	853be0b2-ad1a-4116-aff3-c10f318e9ad5	t	${role_manage-account-links}	manage-account-links	f493d84c-5308-498f-afec-c6f4cfffd553	853be0b2-ad1a-4116-aff3-c10f318e9ad5	\N
5554fc1f-3ba9-48a8-8c97-1ec3e732f942	853be0b2-ad1a-4116-aff3-c10f318e9ad5	t	${role_view-applications}	view-applications	f493d84c-5308-498f-afec-c6f4cfffd553	853be0b2-ad1a-4116-aff3-c10f318e9ad5	\N
ebd4c600-550b-4939-bb60-fb77f2f1baf4	853be0b2-ad1a-4116-aff3-c10f318e9ad5	t	${role_view-consent}	view-consent	f493d84c-5308-498f-afec-c6f4cfffd553	853be0b2-ad1a-4116-aff3-c10f318e9ad5	\N
9da14183-e4c7-4cab-9ce4-6a4980cb93c9	853be0b2-ad1a-4116-aff3-c10f318e9ad5	t	${role_manage-consent}	manage-consent	f493d84c-5308-498f-afec-c6f4cfffd553	853be0b2-ad1a-4116-aff3-c10f318e9ad5	\N
2bf90d1e-8a18-42d7-8dd3-92741165fb5b	853be0b2-ad1a-4116-aff3-c10f318e9ad5	t	${role_view-groups}	view-groups	f493d84c-5308-498f-afec-c6f4cfffd553	853be0b2-ad1a-4116-aff3-c10f318e9ad5	\N
3e1ed336-81e5-437e-97cb-a084762fa5ed	853be0b2-ad1a-4116-aff3-c10f318e9ad5	t	${role_delete-account}	delete-account	f493d84c-5308-498f-afec-c6f4cfffd553	853be0b2-ad1a-4116-aff3-c10f318e9ad5	\N
8b1e01bf-4b6f-4b65-8c97-f0d300aa4d3d	357be594-815d-408b-b337-1e7bb854eb1a	t	${role_read-token}	read-token	f493d84c-5308-498f-afec-c6f4cfffd553	357be594-815d-408b-b337-1e7bb854eb1a	\N
b2a9a138-1987-4bf0-8b27-a5ddd31429a2	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_impersonation}	impersonation	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
ac91fe6e-cc15-4a44-8d4b-d4aa5eefa2e4	f493d84c-5308-498f-afec-c6f4cfffd553	f	${role_offline-access}	offline_access	f493d84c-5308-498f-afec-c6f4cfffd553	\N	\N
d74046a4-88fc-44c8-8932-83b2f591f531	f493d84c-5308-498f-afec-c6f4cfffd553	f	${role_uma_authorization}	uma_authorization	f493d84c-5308-498f-afec-c6f4cfffd553	\N	\N
25dc23c9-fc78-4647-97cd-149741a77307	5760f0e0-8dc4-453f-b407-19c01025187d	f	${role_default-roles}	default-roles-olapps	5760f0e0-8dc4-453f-b407-19c01025187d	\N	\N
6a904e2e-f3c9-472c-bf44-95d020efbbb4	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_create-client}	create-client	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
ed4c4868-d0d3-4e11-9c47-64f9b29e2079	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_view-realm}	view-realm	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
53d46425-1218-4a18-99c3-1a2ea59cdcc6	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_view-users}	view-users	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
7eb43cc8-500f-41a5-a1f4-8af2f9357c72	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_view-clients}	view-clients	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
b182889a-7dbf-4c40-912f-67763a28203e	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_view-events}	view-events	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
dffff9e9-c020-4b1e-b13b-6e1eeddbc4d5	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_view-identity-providers}	view-identity-providers	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
a5154a91-8a42-45c8-a8b5-f789e2f29b98	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_view-authorization}	view-authorization	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
d5dd0a8a-d688-4895-ace6-eb7a48c3286b	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_manage-realm}	manage-realm	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
09dd1b46-f079-4622-bd1e-eb0559eb8df2	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_manage-users}	manage-users	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
c51eebd2-b5e1-41fe-89fa-a1a5d1c88ee8	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_manage-clients}	manage-clients	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
ca327a3a-d462-49b4-aa31-a778923c4a7f	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_manage-events}	manage-events	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
3393382f-8a01-4173-9212-3b6efd2b174a	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_manage-identity-providers}	manage-identity-providers	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
c656a012-664f-47c6-b167-b35d6420531e	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_manage-authorization}	manage-authorization	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
62688fd7-649d-4280-95fd-3c6bcf089398	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_query-users}	query-users	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
1b3023fc-4784-41ce-9138-08c701368d5d	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_query-clients}	query-clients	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
9febcf71-25cf-458b-8cd8-e66029b07a5c	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_query-realms}	query-realms	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
860422ac-0fa5-4b32-bbe1-0bb020df02a4	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_query-groups}	query-groups	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
152776e5-c698-4833-832a-29c8eb6d450b	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_realm-admin}	realm-admin	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
cd3aa552-18e0-4238-9834-0dc7257a6b5e	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_create-client}	create-client	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
be184363-7950-4ce2-bcef-5a241affb1dd	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_view-realm}	view-realm	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
ca068d6a-9a3a-4efa-88a3-4065ef2fb773	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_view-users}	view-users	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
c0575c46-c528-4085-bed9-26e08d134ea6	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_view-clients}	view-clients	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
866bd311-e882-45f4-9363-d2337fe4c47e	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_view-events}	view-events	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
f9d16fb4-276d-4bf0-ae62-7a0c4e68e0fa	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_view-identity-providers}	view-identity-providers	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
f9717605-aeb0-4d2e-acb9-6977d29ee414	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_view-authorization}	view-authorization	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
dab1ca36-0c9c-4912-8c9d-c652c63e3e3d	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_manage-realm}	manage-realm	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
7306b841-10ab-4c35-ac50-22745ad15d37	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_manage-users}	manage-users	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
f8105dfc-de27-4ca5-ac38-cb4523709d69	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_manage-clients}	manage-clients	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
076d83aa-a43f-4ca9-81db-8c56ecea8f9b	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_manage-events}	manage-events	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
55b78541-7ad6-497a-ab8c-935443d9aff1	b864b55f-9586-4738-b061-ab0bec85b58c	t	${role_read-token}	read-token	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	b864b55f-9586-4738-b061-ab0bec85b58c	\N
950e111f-22e9-4953-a133-24a7eb6c4cb4	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	f	${role_offline-access}	offline_access	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	\N	\N
b09ccad9-ed87-4cf1-879b-9d68049f254d	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	f	${role_uma_authorization}	uma_authorization	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	\N	\N
c72b99bb-052c-4eb8-9c19-8a49aec430e9	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_manage-identity-providers}	manage-identity-providers	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
f8a6f949-2438-4f82-bbb0-777812fa55d2	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_manage-authorization}	manage-authorization	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
1f2e5693-fa9d-47ac-9bce-ba608f8315b8	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_query-users}	query-users	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
112a73e2-1e47-47fa-8f3a-c5912f5a6e02	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_query-clients}	query-clients	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
87251ec4-1906-44a1-8883-cd2bcf7b7d9a	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_query-realms}	query-realms	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
62216db2-b28a-4ec8-bea0-c18b03a34f52	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_query-groups}	query-groups	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
4447db17-6dbf-442a-8932-01d7ae56c86c	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	t	${role_view-profile}	view-profile	5760f0e0-8dc4-453f-b407-19c01025187d	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	\N
4b9db14e-b704-406d-9a5f-c8641feb087e	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	t	${role_manage-account}	manage-account	5760f0e0-8dc4-453f-b407-19c01025187d	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	\N
ea338b8e-8350-46ec-b460-005f927c7538	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	t	${role_manage-account-links}	manage-account-links	5760f0e0-8dc4-453f-b407-19c01025187d	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	\N
ad1be974-b056-41c6-92db-975d566551cb	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	t	${role_view-applications}	view-applications	5760f0e0-8dc4-453f-b407-19c01025187d	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	\N
f2219cf1-58cd-405d-a4ec-c10c0d61e7b8	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	t	${role_view-consent}	view-consent	5760f0e0-8dc4-453f-b407-19c01025187d	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	\N
e7ed8bbc-1bcb-4871-9242-79a64cc8fdfa	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	t	${role_manage-consent}	manage-consent	5760f0e0-8dc4-453f-b407-19c01025187d	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	\N
8a318305-aab0-4c58-8041-56dd8617ae51	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	t	${role_view-groups}	view-groups	5760f0e0-8dc4-453f-b407-19c01025187d	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	\N
0c9bf73a-d714-41dd-8a99-75097080bb6f	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	t	${role_delete-account}	delete-account	5760f0e0-8dc4-453f-b407-19c01025187d	37ffb6d7-4e38-4e14-a47f-6a5a85276f55	\N
24587b86-1ce6-49eb-aac6-e8ceda5ef017	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_impersonation}	impersonation	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
18695ffd-832d-4a0d-bace-8b3c9ad752e4	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_impersonation}	impersonation	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
3ef8f59e-e0e1-4ec7-a14d-7b7dfcf0b68f	f56304c4-598f-4c59-8424-c762dc578149	t	${role_read-token}	read-token	5760f0e0-8dc4-453f-b407-19c01025187d	f56304c4-598f-4c59-8424-c762dc578149	\N
8b635337-8c5a-42ae-a75e-c4ba77db20e1	5760f0e0-8dc4-453f-b407-19c01025187d	f	${role_offline-access}	offline_access	5760f0e0-8dc4-453f-b407-19c01025187d	\N	\N
9281f40e-6d33-4e24-bb52-335f964683a1	5760f0e0-8dc4-453f-b407-19c01025187d	f	${role_uma_authorization}	uma_authorization	5760f0e0-8dc4-453f-b407-19c01025187d	\N	\N
dc580ac0-3400-493e-b4e9-45350ffeb879	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	f	${role_default-roles}	default-roles-test	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	\N	\N
7dc1592d-953b-47b2-96e8-6b792c8f01c3	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_create-client}	create-client	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
49a10d53-ea6c-4e6c-8d92-bf4a494180f6	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_view-realm}	view-realm	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
072b4764-e708-4bbe-b6a8-f76d8674fbf5	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_view-users}	view-users	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
96745421-d678-4a65-bcb9-72dc8d1d7962	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_view-clients}	view-clients	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
4d73db27-7641-4d23-8f9c-e70008eca882	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_view-events}	view-events	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
d33ef96b-aabe-444d-b33c-2b8b95139536	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_view-identity-providers}	view-identity-providers	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
2fa5a6cd-d43a-4681-9efd-52dd4e95a217	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_view-authorization}	view-authorization	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
9a54158b-c83d-417b-8698-0a60df58b296	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_manage-realm}	manage-realm	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
afcccb55-78e6-402e-98ae-e0ab801969a8	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_manage-users}	manage-users	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
f695f016-c55a-476d-a942-384571bdd698	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_manage-clients}	manage-clients	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
1a1b159d-31da-48a2-8d00-8c2b8f188276	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_manage-events}	manage-events	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
3a9c9b7b-d11b-4196-8137-0fa9721457f7	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_manage-identity-providers}	manage-identity-providers	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
bf8db88d-703d-4ef0-abbf-0ca968f1a4b8	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_manage-authorization}	manage-authorization	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
0e2378d0-1cee-409d-9350-ff1418dd53ea	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_query-users}	query-users	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
8734e94f-1f04-4310-b2fa-8b5046dcb448	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_query-clients}	query-clients	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
ed761718-c140-4f5a-8328-e45c657b0e87	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_query-realms}	query-realms	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
a7d7fd57-bf99-4def-b5c9-5f7be0a1e4ed	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_query-groups}	query-groups	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
c9d8d0de-22a4-421e-afaf-38f9a6195b24	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_realm-admin}	realm-admin	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
bd41d3fb-b4cf-4499-b988-cbc99a184fcc	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_create-client}	create-client	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
19848b3c-fcfe-4fd0-aefe-7fd1382799cc	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_view-realm}	view-realm	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
8faf91e7-7c22-44db-aea8-1f7258b17edb	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_view-users}	view-users	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
da12dd95-1fb1-47d7-b4d3-bcb4fa86f5dd	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_view-clients}	view-clients	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
a817ab92-32ce-42a2-b792-4307f6f6c013	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_view-events}	view-events	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
10fa23c2-29ff-44bc-852b-12246a89a401	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_view-identity-providers}	view-identity-providers	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
75a69324-df62-4192-a5f6-be0a4f93dff1	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_view-authorization}	view-authorization	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
b07b7798-e1b3-4cfd-9be0-fdf50abf85eb	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_manage-realm}	manage-realm	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
ccfc217a-6569-4364-b6a0-c5fa654ec877	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_manage-users}	manage-users	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
eb93715b-c7bb-4fed-97f9-657a426faebb	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_manage-clients}	manage-clients	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
de53c04e-3780-4c84-8ebe-c20d0b9549ad	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_manage-events}	manage-events	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
2659ac30-5f79-49a2-8413-5438c825be49	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_manage-identity-providers}	manage-identity-providers	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
7e9199b6-40b9-4d91-b9b3-7dfc326430f0	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_manage-authorization}	manage-authorization	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
91632ffa-3889-4e88-96dd-a40345728e83	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_query-users}	query-users	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
706fc139-57d7-458e-93f4-eca3c86c7676	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_query-clients}	query-clients	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
fca93d3e-ee5f-4b27-ad1f-e1ca641046e1	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_query-realms}	query-realms	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
d99f8de8-4220-40f8-9337-1da128c8ba0c	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_query-groups}	query-groups	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
5ebb5aab-f7bf-43c4-ab65-8fd54aee74fc	20ab4f86-015d-4d03-9ca5-de7ab82277bf	t	${role_view-profile}	view-profile	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	20ab4f86-015d-4d03-9ca5-de7ab82277bf	\N
ef79cd14-9af3-4a7b-bdea-23b6d88fca0c	20ab4f86-015d-4d03-9ca5-de7ab82277bf	t	${role_manage-account}	manage-account	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	20ab4f86-015d-4d03-9ca5-de7ab82277bf	\N
3e5a46bc-5407-4c0d-8a71-6eb5f086b01a	20ab4f86-015d-4d03-9ca5-de7ab82277bf	t	${role_manage-account-links}	manage-account-links	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	20ab4f86-015d-4d03-9ca5-de7ab82277bf	\N
ca67f36b-ccf2-4216-917c-6fb3d246a32a	20ab4f86-015d-4d03-9ca5-de7ab82277bf	t	${role_view-applications}	view-applications	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	20ab4f86-015d-4d03-9ca5-de7ab82277bf	\N
6d9f810b-bc2e-43e0-b67c-5b4d7332a85e	20ab4f86-015d-4d03-9ca5-de7ab82277bf	t	${role_view-consent}	view-consent	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	20ab4f86-015d-4d03-9ca5-de7ab82277bf	\N
3d87be55-e6fc-421e-b07c-16406493efa9	20ab4f86-015d-4d03-9ca5-de7ab82277bf	t	${role_manage-consent}	manage-consent	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	20ab4f86-015d-4d03-9ca5-de7ab82277bf	\N
e6326423-af5c-430b-9610-c4ba3ae8fae5	20ab4f86-015d-4d03-9ca5-de7ab82277bf	t	${role_view-groups}	view-groups	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	20ab4f86-015d-4d03-9ca5-de7ab82277bf	\N
55c5bda4-32f5-4711-914a-a29cab5a1f29	20ab4f86-015d-4d03-9ca5-de7ab82277bf	t	${role_delete-account}	delete-account	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	20ab4f86-015d-4d03-9ca5-de7ab82277bf	\N
4d1e4a16-54bd-4da5-8b0f-cb1a25eb8011	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_impersonation}	impersonation	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
bce5f442-6fc0-4b61-a72d-cbb3aa49ab44	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_impersonation}	impersonation	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
ee309557-e023-4c09-8725-366dbe58865c	80b8e421-a8d0-48c7-a471-5bdddf12de86	t	${role_scim-admin}	scim-admin	f493d84c-5308-498f-afec-c6f4cfffd553	80b8e421-a8d0-48c7-a471-5bdddf12de86	\N
b68b08bd-b84f-4ed0-8190-88c8c78108a4	f493d84c-5308-498f-afec-c6f4cfffd553	f	Assign this role to users that shall not be synchronized with the SCIM Client synchronization.	scim-client-user-exclude	f493d84c-5308-498f-afec-c6f4cfffd553	\N	\N
eafa58f2-7fd0-453a-83fa-058a6cd4064a	f493d84c-5308-498f-afec-c6f4cfffd553	f	Assign this role to groups that shall not be synchronized with the SCIM Client synchronization.	scim-client-group-exclude	f493d84c-5308-498f-afec-c6f4cfffd553	\N	\N
6a529145-6246-4c15-8791-db82f27e024b	5760f0e0-8dc4-453f-b407-19c01025187d	f		admin	5760f0e0-8dc4-453f-b407-19c01025187d	\N	\N
db6d0ecc-965b-4d9e-acbc-a3aed34e9d24	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_view-realm}	view-realm	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
b848d658-ab02-420c-b827-c6c44cd852c4	b4825e08-1ac5-43e9-990a-7556e882153a	f	${role_default-roles}	default-roles-test1	b4825e08-1ac5-43e9-990a-7556e882153a	\N	\N
6a30e800-81ad-42b9-9bcf-f82b3ef0aa58	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_create-client}	create-client	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
38a651d9-27c3-48db-ac00-454f0b2fcd9c	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_view-users}	view-users	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
1d031beb-dcc7-4066-a4ed-ac972150b2f3	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_view-clients}	view-clients	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
83f4c60b-2ea2-4f82-bc30-b75f407bd48c	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_view-events}	view-events	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
f3a7f525-c735-4c0b-b6ee-f35399cafcb1	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_view-identity-providers}	view-identity-providers	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
dc14d21e-5c6f-4c7d-9c47-63ccdf33260e	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_view-authorization}	view-authorization	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
a76da85c-adc7-4465-b870-8f614a27aaa6	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_manage-realm}	manage-realm	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
05eb3dc0-d554-45e5-901f-1af0c4eed0c6	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_manage-users}	manage-users	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
c7d76103-617d-47e2-8850-4665a9c1dc83	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_manage-clients}	manage-clients	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
16c21d2e-4e51-41be-bf7a-b7dde02625b0	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_manage-events}	manage-events	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
ca8981f4-362c-4e96-91ee-568bf4f6a029	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_manage-identity-providers}	manage-identity-providers	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
95576acc-012b-4bef-aba3-aafd399a3d14	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_manage-authorization}	manage-authorization	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
8392ad62-fae8-4fef-89e9-d85a512af4e5	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_query-users}	query-users	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
c0f932f5-2236-4688-9a21-71c6308b73ca	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_query-clients}	query-clients	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
bacd1c49-e971-4209-89dc-6bfcbb13f612	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_query-realms}	query-realms	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
7ba00ae6-1b4f-44f0-8dbc-fec5798dc93a	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_query-groups}	query-groups	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
c5a7284b-c110-4f57-82bf-8707a02a4db0	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_realm-admin}	realm-admin	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
c9303d68-7434-46ea-98b8-687888661f28	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_create-client}	create-client	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
e5b4409b-8b65-4b42-b253-5b2e08e787d7	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_view-realm}	view-realm	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
ebe7b3b4-8d1d-4656-8ddb-5a62d0283427	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_view-users}	view-users	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
8bda2464-8d93-43b3-921a-47fe5dd3e901	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_view-clients}	view-clients	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
53f765e1-194a-4c6a-87f5-201dca34b197	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_view-events}	view-events	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
b64bc647-3961-4978-90ee-93ba533e36a2	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_view-identity-providers}	view-identity-providers	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
05f5800f-71b8-45a6-ac7b-1b9af0da3c99	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_view-authorization}	view-authorization	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
f570fab7-bc80-4374-ab78-14c15505de14	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_manage-realm}	manage-realm	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
7ab48d89-d60a-4467-a76b-20940174b7c2	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_manage-users}	manage-users	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
913b81e0-8f30-4da9-9e73-f1e74d58244b	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_manage-clients}	manage-clients	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
62ff99a7-12c0-4bdf-8f3d-6b3d4b8b8071	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_manage-events}	manage-events	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
fd1aecd9-8d71-4960-a020-bfc9cf0a03a9	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_manage-identity-providers}	manage-identity-providers	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
9fcbef3c-e3f5-43f5-b08d-0758167962f8	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_manage-authorization}	manage-authorization	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
1366d4ff-6074-4e57-a096-23514c05c2f6	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_query-users}	query-users	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
9d5b2d54-4441-4287-9877-bd9386c0d898	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_query-clients}	query-clients	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
7d52917e-6711-4cb0-815f-7256acf701fe	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_query-realms}	query-realms	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
df199243-e73d-4e47-9bb8-300b737d2ea7	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_query-groups}	query-groups	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
924c8c59-cabf-44d5-ab7a-97d447d6426a	df1eed9b-9772-4844-bf38-063fcfbf2c71	t	${role_view-profile}	view-profile	b4825e08-1ac5-43e9-990a-7556e882153a	df1eed9b-9772-4844-bf38-063fcfbf2c71	\N
2f89427b-0757-4de1-9fb9-f43d42524645	df1eed9b-9772-4844-bf38-063fcfbf2c71	t	${role_manage-account}	manage-account	b4825e08-1ac5-43e9-990a-7556e882153a	df1eed9b-9772-4844-bf38-063fcfbf2c71	\N
acda493a-4f96-449d-8635-a9f300819f2e	df1eed9b-9772-4844-bf38-063fcfbf2c71	t	${role_manage-account-links}	manage-account-links	b4825e08-1ac5-43e9-990a-7556e882153a	df1eed9b-9772-4844-bf38-063fcfbf2c71	\N
2eb7fc39-4606-4765-b8f8-58ecc3df8a1c	df1eed9b-9772-4844-bf38-063fcfbf2c71	t	${role_view-applications}	view-applications	b4825e08-1ac5-43e9-990a-7556e882153a	df1eed9b-9772-4844-bf38-063fcfbf2c71	\N
823d79f4-c2b1-488e-bba6-3ddc03a03c65	df1eed9b-9772-4844-bf38-063fcfbf2c71	t	${role_view-consent}	view-consent	b4825e08-1ac5-43e9-990a-7556e882153a	df1eed9b-9772-4844-bf38-063fcfbf2c71	\N
071772e7-ee3f-43d8-9407-a23fd72b0c99	df1eed9b-9772-4844-bf38-063fcfbf2c71	t	${role_manage-consent}	manage-consent	b4825e08-1ac5-43e9-990a-7556e882153a	df1eed9b-9772-4844-bf38-063fcfbf2c71	\N
c365e7d1-9da3-485c-a4d7-f28833935964	df1eed9b-9772-4844-bf38-063fcfbf2c71	t	${role_view-groups}	view-groups	b4825e08-1ac5-43e9-990a-7556e882153a	df1eed9b-9772-4844-bf38-063fcfbf2c71	\N
f9946fb7-2188-4c8a-873b-f8fce16f686b	df1eed9b-9772-4844-bf38-063fcfbf2c71	t	${role_delete-account}	delete-account	b4825e08-1ac5-43e9-990a-7556e882153a	df1eed9b-9772-4844-bf38-063fcfbf2c71	\N
d976fbae-74d2-493e-a30c-db9ff603e7fc	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_impersonation}	impersonation	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
a7dc9acc-6436-4fe6-bebe-9e247ccd5c98	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_impersonation}	impersonation	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
b79fe906-9e67-4733-8161-9940bcb4248c	9e559194-7abb-42a9-9aa5-f689dafa911d	t	${role_read-token}	read-token	b4825e08-1ac5-43e9-990a-7556e882153a	9e559194-7abb-42a9-9aa5-f689dafa911d	\N
5ca4b80a-176b-4feb-8104-d2f4a9794e1b	b4825e08-1ac5-43e9-990a-7556e882153a	f	${role_offline-access}	offline_access	b4825e08-1ac5-43e9-990a-7556e882153a	\N	\N
8f3a1b0f-b35b-4214-8adb-d5c16e8a99ff	b4825e08-1ac5-43e9-990a-7556e882153a	f	${role_uma_authorization}	uma_authorization	b4825e08-1ac5-43e9-990a-7556e882153a	\N	\N
57c6e7e7-28d2-4204-855b-6fdb0c161e93	4260b713-6bb7-4cb2-9790-fe665558ba00	t	${role_scim-admin}	scim-admin	f493d84c-5308-498f-afec-c6f4cfffd553	4260b713-6bb7-4cb2-9790-fe665558ba00	\N
d5c5071f-4dc8-46fe-9b62-4d8867e00f8a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	t	${role_scim-admin}	scim-admin	b4825e08-1ac5-43e9-990a-7556e882153a	2bef6b49-f4fe-44b4-b8a0-ff62293fa41a	\N
b7ffa378-e367-4ee1-bbf4-b04fd90bb242	b4825e08-1ac5-43e9-990a-7556e882153a	f	Assign this role to users that shall not be synchronized with the SCIM Client synchronization.	scim-client-user-exclude	b4825e08-1ac5-43e9-990a-7556e882153a	\N	\N
219fa47e-5877-4444-ab54-de560814d9ca	b4825e08-1ac5-43e9-990a-7556e882153a	f	Assign this role to groups that shall not be synchronized with the SCIM Client synchronization.	scim-client-group-exclude	b4825e08-1ac5-43e9-990a-7556e882153a	\N	\N
aa1e55eb-ef79-4e0a-8817-2e8cd9ff6441	2256a568-ee44-4cb6-88fa-488d343b1bf5	f	${role_default-roles}	default-roles-test2	2256a568-ee44-4cb6-88fa-488d343b1bf5	\N	\N
528a3268-e600-441e-818f-f04499946c40	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_create-client}	create-client	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
39abef73-21ab-4e13-a7bd-4f72730f0c94	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_view-realm}	view-realm	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
e0ce877c-93fe-4efb-9f3b-e833a63d32f2	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_view-users}	view-users	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
55eebbe9-9606-4c77-9ceb-fcdd4b5059ae	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_view-clients}	view-clients	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
753c7960-27ac-471d-a9e1-3b9b71bfe645	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_view-events}	view-events	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
5759a9a9-c0d2-44b6-9db5-50076cfdad92	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_view-identity-providers}	view-identity-providers	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
4e18fd5b-74a6-4e2f-bb55-ca928dbb7592	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_view-authorization}	view-authorization	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
60be092f-788b-4378-b1dd-037d454a7bd3	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_manage-realm}	manage-realm	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
65938bef-99b8-4f4b-9b1d-c3bc7ccaec96	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_manage-users}	manage-users	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
5ded3ac5-eb61-440f-aa4a-958ddb5a4581	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_manage-clients}	manage-clients	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
a833f282-9c6a-48c8-b757-4c2bde15fdcd	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_manage-events}	manage-events	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
15055946-24c4-4091-85f5-d86210e001b5	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_manage-identity-providers}	manage-identity-providers	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
264b0a1c-800c-4284-9679-f8e7d1b7ba05	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	t	${role_scim-admin}	scim-admin	f493d84c-5308-498f-afec-c6f4cfffd553	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	\N
a5a2cb8d-d0e2-4718-a052-807f6019a3c5	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_manage-authorization}	manage-authorization	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
05342de1-db31-4d31-b30c-138fc131019f	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_query-users}	query-users	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
05e0e44f-cba9-4389-80a8-93d8c1238125	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_query-clients}	query-clients	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
d0104005-974f-423d-8480-d82ac3d0d9a0	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_query-realms}	query-realms	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
d9ab0443-2a16-4c4b-9c2a-801c1c2c7326	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_query-groups}	query-groups	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
0611a81c-223a-4fe7-bfe2-aa304886938e	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_realm-admin}	realm-admin	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
3a827b11-3834-4501-bdb6-9bae194a13f3	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_create-client}	create-client	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
6de95a9f-6679-4890-a468-16eb0a5d4c76	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_view-realm}	view-realm	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
a5037949-1955-426f-be0b-ada22ae1e206	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_view-users}	view-users	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
2fd7c680-1112-4125-b16d-14689fe3ff23	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_view-clients}	view-clients	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
29401645-8ec7-4a83-8d01-e62e0892dd02	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_view-events}	view-events	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
8f53c26f-be01-4d0d-a4b4-b3236da447d0	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_view-identity-providers}	view-identity-providers	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
8ffe2222-03b4-4c7e-86c2-5dd01e88eb5a	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_view-authorization}	view-authorization	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
4579e5c6-55c8-4b55-89c0-cb5d19019844	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_manage-realm}	manage-realm	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
355b7d98-72b9-4ca4-9c82-134a701ec368	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_manage-users}	manage-users	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
4c4fbd4c-f688-4df4-b5ce-720f734889da	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_manage-clients}	manage-clients	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
afe731ed-576a-45c3-aea1-a4ee9abb4efd	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_manage-events}	manage-events	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
97ed72f4-c86e-4a49-b5c9-d8b09f45cc8b	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_manage-identity-providers}	manage-identity-providers	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
a5f13fe4-31c2-4f75-9302-86d8bc52a973	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_manage-authorization}	manage-authorization	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
4e098be1-19c4-4392-a8bb-a3e1a0995e0b	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_query-users}	query-users	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
20bd775f-ff36-4e25-a723-c3f538f4e0fb	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_query-clients}	query-clients	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
e9d52322-baaa-419c-b8db-76243529154f	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_query-realms}	query-realms	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
54fa6632-120b-4c1b-aa34-ebc61073c9d3	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_query-groups}	query-groups	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
1e905119-14aa-42e2-a581-f7869f061333	75fc95fe-2c73-4934-a450-5d00669f5b97	t	${role_view-profile}	view-profile	2256a568-ee44-4cb6-88fa-488d343b1bf5	75fc95fe-2c73-4934-a450-5d00669f5b97	\N
27263657-f217-4348-84c4-6a24e1735d0f	75fc95fe-2c73-4934-a450-5d00669f5b97	t	${role_manage-account}	manage-account	2256a568-ee44-4cb6-88fa-488d343b1bf5	75fc95fe-2c73-4934-a450-5d00669f5b97	\N
6dfe2352-68a2-4474-89b0-cdbe62e51fea	75fc95fe-2c73-4934-a450-5d00669f5b97	t	${role_manage-account-links}	manage-account-links	2256a568-ee44-4cb6-88fa-488d343b1bf5	75fc95fe-2c73-4934-a450-5d00669f5b97	\N
22ce4ff0-18e3-4307-87ce-9b3e132421d0	75fc95fe-2c73-4934-a450-5d00669f5b97	t	${role_view-applications}	view-applications	2256a568-ee44-4cb6-88fa-488d343b1bf5	75fc95fe-2c73-4934-a450-5d00669f5b97	\N
7066b0df-1810-4c8e-bacf-bb5e47ae8483	75fc95fe-2c73-4934-a450-5d00669f5b97	t	${role_view-consent}	view-consent	2256a568-ee44-4cb6-88fa-488d343b1bf5	75fc95fe-2c73-4934-a450-5d00669f5b97	\N
3de1425a-9f55-4dab-bd2c-97c6f0356964	75fc95fe-2c73-4934-a450-5d00669f5b97	t	${role_manage-consent}	manage-consent	2256a568-ee44-4cb6-88fa-488d343b1bf5	75fc95fe-2c73-4934-a450-5d00669f5b97	\N
e29d6bdc-e7da-4d33-b8e3-6b57aa4ac6c8	75fc95fe-2c73-4934-a450-5d00669f5b97	t	${role_view-groups}	view-groups	2256a568-ee44-4cb6-88fa-488d343b1bf5	75fc95fe-2c73-4934-a450-5d00669f5b97	\N
31c39f07-153b-47d3-8ac5-0cee7cad8aa0	75fc95fe-2c73-4934-a450-5d00669f5b97	t	${role_delete-account}	delete-account	2256a568-ee44-4cb6-88fa-488d343b1bf5	75fc95fe-2c73-4934-a450-5d00669f5b97	\N
0c1df1b9-1e00-471f-b4ed-5c526578d362	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_impersonation}	impersonation	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
d5857976-7bf6-41d2-8f25-9f9d49e7a1d1	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_impersonation}	impersonation	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
5aa6b8b6-059f-4de4-a84d-3d6f0457492b	7f1eda49-4d82-4b18-8c52-36c8fa8e42c6	t	${role_read-token}	read-token	2256a568-ee44-4cb6-88fa-488d343b1bf5	7f1eda49-4d82-4b18-8c52-36c8fa8e42c6	\N
493dda44-5c4a-4d7a-a26f-75e855b4e133	2256a568-ee44-4cb6-88fa-488d343b1bf5	f	${role_offline-access}	offline_access	2256a568-ee44-4cb6-88fa-488d343b1bf5	\N	\N
245541ae-f825-4176-b9ed-84839b3d7a1a	2256a568-ee44-4cb6-88fa-488d343b1bf5	f	${role_uma_authorization}	uma_authorization	2256a568-ee44-4cb6-88fa-488d343b1bf5	\N	\N
67999782-eaf9-4077-ad51-61bae8acf919	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	t	${role_scim-admin}	scim-admin	f493d84c-5308-498f-afec-c6f4cfffd553	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	\N
82af302c-7dd7-40fb-9743-b2dbb8084b83	a244baff-703f-4856-ae02-dc4dc6aacd1e	t	${role_scim-admin}	scim-admin	2256a568-ee44-4cb6-88fa-488d343b1bf5	a244baff-703f-4856-ae02-dc4dc6aacd1e	\N
007cf2ae-f527-47c2-864e-216e14359820	2256a568-ee44-4cb6-88fa-488d343b1bf5	f	Assign this role to users that shall not be synchronized with the SCIM Client synchronization.	scim-client-user-exclude	2256a568-ee44-4cb6-88fa-488d343b1bf5	\N	\N
11094a3c-c2da-41c0-aa1f-00cabea5039a	2256a568-ee44-4cb6-88fa-488d343b1bf5	f	Assign this role to groups that shall not be synchronized with the SCIM Client synchronization.	scim-client-group-exclude	2256a568-ee44-4cb6-88fa-488d343b1bf5	\N	\N
d4a224fa-74e6-46e0-8df4-b2f16d1667d8	5760f0e0-8dc4-453f-b407-19c01025187d	f		scim-admin	5760f0e0-8dc4-453f-b407-19c01025187d	\N	\N
d6c68eac-4bb7-4a62-bbb7-8f0a3562815a	854ad7cd-1eff-40da-870d-00e3dc34ceb0	t	${role_scim-admin}	scim-admin	f493d84c-5308-498f-afec-c6f4cfffd553	854ad7cd-1eff-40da-870d-00e3dc34ceb0	\N
a44cb456-5c9c-4c21-9636-388029bd79ca	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	t	${role_scim-admin}	scim-admin	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	7d0bbda1-7ac2-44d4-9bfb-524fd77c2050	\N
23096689-8999-47a6-aaea-0ffccad6bff4	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	f	Assign this role to users that shall not be synchronized with the SCIM Client synchronization.	scim-client-user-exclude	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	\N	\N
80b6cd08-63f7-4cd4-be14-bb6d98c17615	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	f	Assign this role to groups that shall not be synchronized with the SCIM Client synchronization.	scim-client-group-exclude	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	\N	\N
1d779b91-609b-4f4f-a4d0-e47ef5e6a195	0f393319-fded-4b0c-9711-a9ca8eeba66d	t	${role_scim-admin}	scim-admin	5760f0e0-8dc4-453f-b407-19c01025187d	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
4e9b3509-fdb7-4a8d-9251-c27ac333b8d5	5760f0e0-8dc4-453f-b407-19c01025187d	f	Assign this role to users that shall not be synchronized with the SCIM Client synchronization.	scim-client-user-exclude	5760f0e0-8dc4-453f-b407-19c01025187d	\N	\N
5e047e20-95f7-4224-a4c1-aa9d7f4653f8	5760f0e0-8dc4-453f-b407-19c01025187d	f	Assign this role to groups that shall not be synchronized with the SCIM Client synchronization.	scim-client-group-exclude	5760f0e0-8dc4-453f-b407-19c01025187d	\N	\N
8e35ead3-200b-471f-af2f-c24285e8602e	b2a0a790-59c5-4142-9d77-44932b1e8620	t		admin	5760f0e0-8dc4-453f-b407-19c01025187d	b2a0a790-59c5-4142-9d77-44932b1e8620	\N
afb2da26-c32c-4293-8e70-ce44ea512d58	5760f0e0-8dc4-453f-b407-19c01025187d	f	\N	default-roles-master	5760f0e0-8dc4-453f-b407-19c01025187d	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
olad8	24.0.5	1723148436
zd32w	26.0.5	1732032688
9oj42	26.0.6	1735922723
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
6236d48a-e115-47a5-995a-aae206cb9e0d	audience resolve	openid-connect	oidc-audience-resolve-mapper	b43612df-590a-4e25-a38f-2f0de881be8f	\N
4590494b-25a8-40a6-a865-a9d20ead5c2c	locale	openid-connect	oidc-usermodel-attribute-mapper	d15c1b01-566a-4497-8bc9-3d9d87253ea1	\N
e6b25144-7583-4366-8eb1-db8735418ca9	role list	saml	saml-role-list-mapper	\N	e699d045-6556-4a8c-bb2b-eec123e7d607
efdc8fda-ad45-4ab5-a1f3-c2665f2c6798	full name	openid-connect	oidc-full-name-mapper	\N	5c2a597a-7480-4270-a86c-b1d02750ce60
814ac9d7-4f60-466f-8065-bd45ed90229c	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	5c2a597a-7480-4270-a86c-b1d02750ce60
ccb68d8d-f236-4b5e-b2e1-017725cd19ba	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	5c2a597a-7480-4270-a86c-b1d02750ce60
76c81d7e-196e-4b7b-8090-faeed5f0bb04	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	5c2a597a-7480-4270-a86c-b1d02750ce60
2ff2fc62-d6d6-41b3-8a08-125362bbaf66	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	5c2a597a-7480-4270-a86c-b1d02750ce60
fe519a3d-8d81-403a-be5a-8a67bf243659	username	openid-connect	oidc-usermodel-attribute-mapper	\N	5c2a597a-7480-4270-a86c-b1d02750ce60
51f87cf9-c0c5-4e0d-a4ff-595caffa7fdc	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	5c2a597a-7480-4270-a86c-b1d02750ce60
3ad3e8f2-153b-49ed-9f97-15fa018758c1	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	5c2a597a-7480-4270-a86c-b1d02750ce60
7f4c65b7-27e1-4b48-8e4b-cf8338ad668d	website	openid-connect	oidc-usermodel-attribute-mapper	\N	5c2a597a-7480-4270-a86c-b1d02750ce60
cee49b80-2c73-469d-a2ce-60bc04478935	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	5c2a597a-7480-4270-a86c-b1d02750ce60
6bd0524f-9172-403c-9f36-c3a1b3163352	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	5c2a597a-7480-4270-a86c-b1d02750ce60
0f0d34bf-bb53-4dd9-8390-09a33f505205	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	5c2a597a-7480-4270-a86c-b1d02750ce60
f719c648-758d-40c1-b781-9e893ef35caf	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	5c2a597a-7480-4270-a86c-b1d02750ce60
029af4ef-a9e9-4e6d-af31-ad8a7e256ebb	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	5c2a597a-7480-4270-a86c-b1d02750ce60
9a60ed49-ad95-4b3f-865f-9bf30ebba741	email	openid-connect	oidc-usermodel-attribute-mapper	\N	379a3e26-dd12-4608-919a-e84602fcbeb1
3dfbbdc8-d30c-4d60-995b-e08d3be19a54	email verified	openid-connect	oidc-usermodel-property-mapper	\N	379a3e26-dd12-4608-919a-e84602fcbeb1
c0f5aa35-5294-4c17-a4b7-c112163440a0	address	openid-connect	oidc-address-mapper	\N	637fac36-2646-4763-8913-3fb8679a77a4
b34ec6d0-0f56-48fe-80ce-372de5301cd5	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	040da43b-fd9e-47cf-8f0d-68f6ac7e6405
5b05fdbb-21b4-486f-ae99-a5da48831b01	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	040da43b-fd9e-47cf-8f0d-68f6ac7e6405
609928cb-abac-43eb-b3f8-b47af9a06b55	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	22b7f0e6-d566-4ac4-80ef-08ff08998740
1157b2a4-0661-4f6f-a4b4-d85c536e4250	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	22b7f0e6-d566-4ac4-80ef-08ff08998740
2f070510-4487-45af-b507-d86a02c921f2	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	22b7f0e6-d566-4ac4-80ef-08ff08998740
35b14489-ec9d-4070-a093-d01de98c07f5	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	131703b4-a4fe-4c12-91e4-10aa029661e0
193b641f-41de-4ded-8a8d-ba0457b5a8e7	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	3419fbee-de34-42ab-813d-873b113fa211
3339fc33-1519-4277-bc8a-283c3c04baf6	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	3419fbee-de34-42ab-813d-873b113fa211
10e0a925-1e97-4107-808e-abac818b646b	acr loa level	openid-connect	oidc-acr-mapper	\N	2ba22377-8a2c-4e8b-a860-b2ba519f38da
dfc7b021-327e-4303-b6d1-1abccfb2ef65	audience resolve	openid-connect	oidc-audience-resolve-mapper	0eecf1c0-c127-4ca2-9327-459efbb9c681	\N
390a8622-93ea-4771-b4f3-9356472ec56d	role list	saml	saml-role-list-mapper	\N	5361170e-966a-40f4-b73f-da51458ba393
6cd0bfcb-86e6-40d2-9eb7-3e549ea05609	full name	openid-connect	oidc-full-name-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
68e3fb00-20d3-4db0-90c8-6b29c9349c7f	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
f90df792-14f7-4b35-ae91-aed2bcfa4d42	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
864377d4-6034-4d01-834e-0d1af96a88d7	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
e73696f5-09fc-4ad7-aabb-2c273413dd15	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
60d1aa0a-8020-47f9-86bd-593e8b77a05d	username	openid-connect	oidc-usermodel-attribute-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
9754637c-dd67-4a7c-bbd3-f4eaaf720777	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
608e6ba7-37ab-4b65-9578-2b310729a70f	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
fed6f0b2-1fbc-423d-a6bd-4ed38d03740f	website	openid-connect	oidc-usermodel-attribute-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
d35e6580-2d82-4717-b8ec-a151ff7eba61	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
585cd667-851b-47cb-823f-00b8c64c05f9	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
f410e08f-7aa0-4b11-b5d9-080ea63de760	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
a8d5e83a-b2d7-4ce0-8a89-2ab76e210117	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
d7e86a27-2f27-4c6d-8b66-767956f5ae78	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
a7399f8f-66b5-4f85-a8ea-f5454ee1471e	email	openid-connect	oidc-usermodel-attribute-mapper	\N	18adc9ea-03c2-4910-a599-b60baf0926b2
ba9cd7bd-a693-443b-84ff-333de8f4a6cc	email verified	openid-connect	oidc-usermodel-property-mapper	\N	18adc9ea-03c2-4910-a599-b60baf0926b2
eb1fb2fb-14cd-452e-b21b-b5700d9db841	address	openid-connect	oidc-address-mapper	\N	b789a1aa-c97d-4fb1-b771-f2cbccafeae0
f97d2b63-9eac-4544-862f-55f51da0c5f1	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	15db502e-270d-4bc5-98d8-786393ef0fed
214f5911-00ac-4dc4-bc22-9c9bda10bcac	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	15db502e-270d-4bc5-98d8-786393ef0fed
1d3f4b72-4d65-4ad3-b70f-f615ad8c293e	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	4597c668-fa1b-478d-9843-5848285c470b
f222e79b-1beb-46ef-91a0-f34c3cd5a197	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	4597c668-fa1b-478d-9843-5848285c470b
a43706ba-87d5-4ee4-ba63-6fed6e181f1e	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	4597c668-fa1b-478d-9843-5848285c470b
061f4e4b-fa6b-4836-aa36-4ee4acdaebf0	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	52b1693f-4fc2-4ce5-9b30-95a8daef5fcd
d2a42598-32f3-4d4a-bd65-24f7d030ed3d	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	667d3b9a-7261-460e-847f-d66563aae9e1
7bb94383-720a-4586-90f4-43d369727e5e	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	667d3b9a-7261-460e-847f-d66563aae9e1
28e9a316-b600-4c91-9dfc-f33d7cb84665	acr loa level	openid-connect	oidc-acr-mapper	\N	cf860e2f-978d-469d-a18e-db7a4008b243
60d7358f-eb1b-4b02-bc97-da0304fb555c	locale	openid-connect	oidc-usermodel-attribute-mapper	44cee68c-7ad2-465c-b7e4-67db09369afc	\N
a7e74f60-b6f3-4b40-8553-f281f1c24940	audience resolve	openid-connect	oidc-audience-resolve-mapper	f99d9cb1-4be5-4cd0-8061-e223ad552b74	\N
7c3ce644-39ad-44e6-a6fa-98a0348479a8	role list	saml	saml-role-list-mapper	\N	eaae48b2-ecee-4938-a10a-2f9cbf593b5f
b2b42de3-d154-490e-89b4-a601d1a6c03c	full name	openid-connect	oidc-full-name-mapper	\N	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3
e87766c1-3c66-4a92-9f27-4567f672b51c	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3
8fee777c-03bf-493a-8fca-6c49d1dd166f	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3
46f7d4b6-ec60-4dc9-97a7-78af53082baf	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3
c7b0ebba-4595-43bd-bad9-863a50161d2a	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3
01a19ace-405f-4ccb-b361-6b23e03e1ddb	username	openid-connect	oidc-usermodel-attribute-mapper	\N	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3
9e66cdc1-b8fa-4bf6-9206-664912e170f6	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3
ce06cefe-942b-4c40-a1c3-282ffa31b092	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3
c606b220-529d-4fb1-9d21-8dfbd19ad43e	website	openid-connect	oidc-usermodel-attribute-mapper	\N	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3
16b73921-6dbe-4513-b14d-f21739c6a7cf	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3
6ddf67eb-5d45-4232-a4d1-dc54f13529e6	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3
e9c232c1-737a-4cc5-9092-1049e615d388	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3
a484a062-5b8e-44a2-bd9e-37884b9e9106	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3
8213189f-de5d-4245-a43e-f2533223f40d	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	cc7cafbc-83d8-4fb4-a3ef-152d23e09cb3
9703b9cd-a6cf-4997-aacc-d774d26a34cb	email	openid-connect	oidc-usermodel-attribute-mapper	\N	e1785efd-bf9a-446a-ad94-3d569bad7869
6618c401-2c95-4cc6-9116-dff0af122828	email verified	openid-connect	oidc-usermodel-property-mapper	\N	e1785efd-bf9a-446a-ad94-3d569bad7869
6ca6503c-c51c-400b-addc-3a83832feed5	address	openid-connect	oidc-address-mapper	\N	5f554b86-1456-486d-b699-03c87529d428
cff21dd4-16d5-4cba-9c72-b397e6f219bc	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	8b8d5b04-7e0f-43a8-8829-250ff789726a
9c3df38c-fd8c-47fb-8713-3fc387f7b1ef	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	8b8d5b04-7e0f-43a8-8829-250ff789726a
8fb04627-6288-4e8e-8c7d-a9ddbc9206f9	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	cda41599-0e60-42d6-b433-c15b126c1449
7eb44102-cfed-408c-8639-9363086b6125	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	cda41599-0e60-42d6-b433-c15b126c1449
8479bf8f-eaf8-490c-9bc3-d6f29a66e1c0	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	cda41599-0e60-42d6-b433-c15b126c1449
535df3a8-a18f-4401-adbc-d47cd866223d	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	fb4f128c-0ba4-4d3c-80d9-65a0f3c4b2ec
fc836e5d-9884-4b50-bed7-18babd423edd	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	42b96f1a-dd81-47b8-b5b6-b4a0630b6350
e122ca50-559e-4d6c-8f4f-f7848e2aac2d	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	42b96f1a-dd81-47b8-b5b6-b4a0630b6350
7c9f3990-8c9e-4bef-9faa-0f6f6f21f294	acr loa level	openid-connect	oidc-acr-mapper	\N	6b8b6f76-1427-43b0-aed9-5ac7260ae1f1
9c099bd4-621a-4e80-a201-f050b8b8109e	locale	openid-connect	oidc-usermodel-attribute-mapper	838fe32e-5500-4989-8194-c83c43aa5617	\N
6d0b4192-ac75-411f-9e9d-71b5dc9b2116	name	openid-connect	oidc-usermodel-attribute-mapper	\N	d7ce6ee2-6ed3-4a82-a5af-718704a6a888
2043f4b4-bbed-42d0-ac06-79090dde3fa4	audience resolve	openid-connect	oidc-audience-resolve-mapper	bb4d8a91-43ec-4a96-8bec-800f920c8826	\N
fd1fe02d-7396-4c92-bbe6-a34c394c7fac	role list	saml	saml-role-list-mapper	\N	8561625f-4b07-445c-84ab-1640048627e2
00fc59db-df89-4df9-9c3c-2db4f4ffcfaf	full name	openid-connect	oidc-full-name-mapper	\N	e40d1da7-3987-4338-ad34-02ece0227ddd
c7101307-0a0a-4539-a6eb-8c02300b5e77	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	e40d1da7-3987-4338-ad34-02ece0227ddd
2dbeff4a-07c3-4400-8935-da9fe0ab3cb4	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	e40d1da7-3987-4338-ad34-02ece0227ddd
eee37f25-a61c-4dda-805e-9ee7e077237a	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	e40d1da7-3987-4338-ad34-02ece0227ddd
b812cb64-43d7-457f-be25-27afb5a8ddc4	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	e40d1da7-3987-4338-ad34-02ece0227ddd
c5af2ba4-9df8-4c2d-875d-81d7488ed2bc	username	openid-connect	oidc-usermodel-attribute-mapper	\N	e40d1da7-3987-4338-ad34-02ece0227ddd
018a2cad-af43-439f-9ef8-1e4ffc184f38	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	e40d1da7-3987-4338-ad34-02ece0227ddd
778cee48-68db-412c-8cef-ed2992ec3a41	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	e40d1da7-3987-4338-ad34-02ece0227ddd
a2a17ff4-92b2-4ecc-83cd-326290c6ffd1	website	openid-connect	oidc-usermodel-attribute-mapper	\N	e40d1da7-3987-4338-ad34-02ece0227ddd
9b8af3ce-e6be-4ced-9f47-a577ee3e80c9	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	e40d1da7-3987-4338-ad34-02ece0227ddd
1ddbf44e-e6b1-4840-a663-3f4a5a7ab20e	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	e40d1da7-3987-4338-ad34-02ece0227ddd
62d3bc95-853f-4c07-99c3-57ebb385083c	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	e40d1da7-3987-4338-ad34-02ece0227ddd
15c90da1-ee01-4247-89c1-fdd7dbf67f3e	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	e40d1da7-3987-4338-ad34-02ece0227ddd
de308fe1-bfae-49fd-9b40-ff50ba9b4357	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	e40d1da7-3987-4338-ad34-02ece0227ddd
76a3ab14-d744-40ae-b5a8-0426cd272e80	email	openid-connect	oidc-usermodel-attribute-mapper	\N	7340bf61-1107-4848-a100-32981012bf8f
92b2fdff-cdb1-44da-933d-622217d2ff06	email verified	openid-connect	oidc-usermodel-property-mapper	\N	7340bf61-1107-4848-a100-32981012bf8f
aa66d39b-3bcf-4120-8370-d55918ccb689	address	openid-connect	oidc-address-mapper	\N	0b7b08ab-1f3c-44de-86e6-74d304e82697
f11567e2-c53b-4600-8ebf-d4d2b8c56ba0	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	23806095-5d19-4b3c-9977-076c75933e96
e39e5595-62eb-4c0f-b423-b2932cca92db	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	23806095-5d19-4b3c-9977-076c75933e96
527c9e4e-207c-4958-960e-a3700250596b	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	9e7c1bdc-270a-4b82-a59d-fa511fb71964
ab6b6be3-4996-463d-9735-00e6d34149d4	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	9e7c1bdc-270a-4b82-a59d-fa511fb71964
5977026f-63fa-49fa-8199-ef1836218980	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	9e7c1bdc-270a-4b82-a59d-fa511fb71964
32dc9fca-2b73-4616-bb91-938ad664cd0c	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	4a255549-9040-4e49-b43b-1c7c017e424c
3062ea3a-9c44-45a7-8ff2-81dd9c513ae5	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	55be477a-ddcf-4a58-bd0b-d9f0f829593b
67b80b3e-1f69-4729-85e5-c8a417a28042	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	55be477a-ddcf-4a58-bd0b-d9f0f829593b
a9922c7d-b179-4179-a8ea-3125763d7c2d	acr loa level	openid-connect	oidc-acr-mapper	\N	4a8e7cf1-2d35-451b-9c98-67b3f61f1368
609a843b-fadd-4a42-8ba1-588ee35b4111	locale	openid-connect	oidc-usermodel-attribute-mapper	3d21aefb-1d20-4d27-9756-3cce60b5e958	\N
c4eb66f8-d3f8-4321-9390-c70c1ce0ddcb	audience resolve	openid-connect	oidc-audience-resolve-mapper	7f6732e2-e3c2-456a-9e4e-234ecab9072d	\N
1dad7b5c-d41e-4452-b2d4-12a26a421b59	role list	saml	saml-role-list-mapper	\N	6c937d93-30b4-4bac-9406-4d11a6fdd1b2
565ca273-1285-4fde-89a1-ba3444c86396	full name	openid-connect	oidc-full-name-mapper	\N	5981264e-0c65-4ccc-b73c-894a11d9d5f5
13b9cce0-9520-4827-b3c4-95bd3f38c629	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	5981264e-0c65-4ccc-b73c-894a11d9d5f5
597f2f70-16b3-4dd2-9b07-a33eea41b182	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	5981264e-0c65-4ccc-b73c-894a11d9d5f5
0b80f305-b494-4d79-8a48-4854fd454355	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	5981264e-0c65-4ccc-b73c-894a11d9d5f5
ff3f717f-a6a9-4ef2-82b2-f8b9928655da	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	5981264e-0c65-4ccc-b73c-894a11d9d5f5
d1d8160e-7e02-445e-90fa-34165706c88d	username	openid-connect	oidc-usermodel-attribute-mapper	\N	5981264e-0c65-4ccc-b73c-894a11d9d5f5
ce96c8da-ed38-42f1-829e-ca780429737d	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	5981264e-0c65-4ccc-b73c-894a11d9d5f5
284ca781-d8c6-4b02-a23a-5f2efb22eb34	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	5981264e-0c65-4ccc-b73c-894a11d9d5f5
7628b0f4-ced6-4ef6-a9fd-34fbe3dd39dc	website	openid-connect	oidc-usermodel-attribute-mapper	\N	5981264e-0c65-4ccc-b73c-894a11d9d5f5
b0ed88d9-1a0b-486a-8ffa-a54b56557b5b	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	5981264e-0c65-4ccc-b73c-894a11d9d5f5
ed594df8-3555-4cc4-8578-e39fa473943d	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	5981264e-0c65-4ccc-b73c-894a11d9d5f5
ac861c55-2924-43e4-8e6c-dd8596f256ad	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	5981264e-0c65-4ccc-b73c-894a11d9d5f5
04e8d6e5-8f8d-4244-8f34-19709bd9ef08	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	5981264e-0c65-4ccc-b73c-894a11d9d5f5
665533c7-bfbe-419f-a39b-4d07de0e9969	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	5981264e-0c65-4ccc-b73c-894a11d9d5f5
cd7b8715-c904-43d4-8b54-9787bed9b799	email	openid-connect	oidc-usermodel-attribute-mapper	\N	1131f752-fbe3-4ca0-a3a4-8a009a537b5a
6f87ccb7-1f07-414c-8ce4-670c5fdfd725	email verified	openid-connect	oidc-usermodel-property-mapper	\N	1131f752-fbe3-4ca0-a3a4-8a009a537b5a
fa4d17f2-f9d2-4b13-8ed4-7d4f888bd911	address	openid-connect	oidc-address-mapper	\N	a499924a-2f59-4e14-a115-16aac030f760
681de82e-7d4d-402f-a912-ff374a351672	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	30a3ec2f-b90a-4656-8d56-60466a47a79e
bd44bf8c-4a93-452c-94ac-7500bf5d3c23	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	30a3ec2f-b90a-4656-8d56-60466a47a79e
d249e9c0-06ed-46a0-a932-8549c90d60f0	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	13abbec8-4f5f-4eab-97a8-9b5097559d9e
09c30085-7cb1-4daa-95f8-c5e33c6186ec	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	13abbec8-4f5f-4eab-97a8-9b5097559d9e
4dc2546b-6b54-4e11-8436-fef4f029c837	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	13abbec8-4f5f-4eab-97a8-9b5097559d9e
06555e4c-43d1-4429-8c53-d38d22c62077	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	40dc0180-628a-4c3a-b686-705d70183eda
d0bb618e-a9a6-489d-bf33-f95e4befe573	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	20220de8-fcaf-4554-80ef-9078a66c844e
5b588cc9-80b7-4868-b80a-14966be22ed4	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	20220de8-fcaf-4554-80ef-9078a66c844e
82c93633-2ef1-473a-b6a1-5daf5ae79bbd	acr loa level	openid-connect	oidc-acr-mapper	\N	99665abe-71db-4ae8-8e31-f4c782298c4a
03e0a754-7e4f-4318-808e-d4d62e4ffbc5	locale	openid-connect	oidc-usermodel-attribute-mapper	797f6274-dc0a-4a46-8098-9e25decee64f	\N
482f9b53-0935-4820-a492-feecbbb9b105	email-opt-in	openid-connect	oidc-usermodel-attribute-mapper	\N	49e25b5d-d76e-4051-9c7c-7a0b5c1052bd
92380b59-56eb-4427-b957-30d122fd9943	fullname	openid-connect	oidc-usermodel-attribute-mapper	\N	49e25b5d-d76e-4051-9c7c-7a0b5c1052bd
242f2fa5-41fe-41d2-bd51-09593d288911	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	03b1a0a4-bd48-49a4-926b-de5f66803c2b
5b0e35aa-bf5b-44c5-bd6b-8a81f120fff7	sub	openid-connect	oidc-sub-mapper	\N	03b1a0a4-bd48-49a4-926b-de5f66803c2b
1d0f4bc2-ecf8-4749-878f-ee25075ceff6	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	d93f07c8-4801-4b12-a63b-1085e3135be8
bd9a8289-2e89-45e4-9d51-ef7d99b485b2	sub	openid-connect	oidc-sub-mapper	\N	d93f07c8-4801-4b12-a63b-1085e3135be8
13312910-e27a-4b8c-974b-d2b4f8349393	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	0673cf19-e51c-4979-be63-052f84c3c555
d3246769-c8fa-4e42-9c18-c240ff010259	sub	openid-connect	oidc-sub-mapper	\N	0673cf19-e51c-4979-be63-052f84c3c555
94fac029-774d-4160-9fb3-60f385db20a4	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	fa7619c7-fa00-4a0a-a46f-911d0bbc309b
9ea96afe-9fbc-4dd8-a2c9-84912d64f033	sub	openid-connect	oidc-sub-mapper	\N	fa7619c7-fa00-4a0a-a46f-911d0bbc309b
b44646d3-c973-4733-9f4d-bcfc9682307a	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	79cf0e01-9d2d-4d0e-95a5-a0884158d529
7bee9df0-1d9f-4fae-a7a4-3c0f8dde6965	sub	openid-connect	oidc-sub-mapper	\N	79cf0e01-9d2d-4d0e-95a5-a0884158d529
24a305cb-3d70-42f6-8dfa-9230e9fecb43	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	a172934f-a9e5-458f-9483-7dfc4d6e1991	\N
9a698d26-5e60-4a0e-bf1f-8614156771b2	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	a172934f-a9e5-458f-9483-7dfc4d6e1991	\N
c67657db-2363-413b-8824-2e1ae6fea7c6	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	a172934f-a9e5-458f-9483-7dfc4d6e1991	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
4590494b-25a8-40a6-a865-a9d20ead5c2c	true	introspection.token.claim
4590494b-25a8-40a6-a865-a9d20ead5c2c	true	userinfo.token.claim
4590494b-25a8-40a6-a865-a9d20ead5c2c	locale	user.attribute
4590494b-25a8-40a6-a865-a9d20ead5c2c	true	id.token.claim
4590494b-25a8-40a6-a865-a9d20ead5c2c	true	access.token.claim
4590494b-25a8-40a6-a865-a9d20ead5c2c	locale	claim.name
4590494b-25a8-40a6-a865-a9d20ead5c2c	String	jsonType.label
e6b25144-7583-4366-8eb1-db8735418ca9	false	single
e6b25144-7583-4366-8eb1-db8735418ca9	Basic	attribute.nameformat
e6b25144-7583-4366-8eb1-db8735418ca9	Role	attribute.name
029af4ef-a9e9-4e6d-af31-ad8a7e256ebb	true	introspection.token.claim
029af4ef-a9e9-4e6d-af31-ad8a7e256ebb	true	userinfo.token.claim
029af4ef-a9e9-4e6d-af31-ad8a7e256ebb	updatedAt	user.attribute
029af4ef-a9e9-4e6d-af31-ad8a7e256ebb	true	id.token.claim
029af4ef-a9e9-4e6d-af31-ad8a7e256ebb	true	access.token.claim
029af4ef-a9e9-4e6d-af31-ad8a7e256ebb	updated_at	claim.name
029af4ef-a9e9-4e6d-af31-ad8a7e256ebb	long	jsonType.label
0f0d34bf-bb53-4dd9-8390-09a33f505205	true	introspection.token.claim
0f0d34bf-bb53-4dd9-8390-09a33f505205	true	userinfo.token.claim
0f0d34bf-bb53-4dd9-8390-09a33f505205	zoneinfo	user.attribute
0f0d34bf-bb53-4dd9-8390-09a33f505205	true	id.token.claim
0f0d34bf-bb53-4dd9-8390-09a33f505205	true	access.token.claim
0f0d34bf-bb53-4dd9-8390-09a33f505205	zoneinfo	claim.name
0f0d34bf-bb53-4dd9-8390-09a33f505205	String	jsonType.label
2ff2fc62-d6d6-41b3-8a08-125362bbaf66	true	introspection.token.claim
2ff2fc62-d6d6-41b3-8a08-125362bbaf66	true	userinfo.token.claim
2ff2fc62-d6d6-41b3-8a08-125362bbaf66	nickname	user.attribute
2ff2fc62-d6d6-41b3-8a08-125362bbaf66	true	id.token.claim
2ff2fc62-d6d6-41b3-8a08-125362bbaf66	true	access.token.claim
2ff2fc62-d6d6-41b3-8a08-125362bbaf66	nickname	claim.name
2ff2fc62-d6d6-41b3-8a08-125362bbaf66	String	jsonType.label
3ad3e8f2-153b-49ed-9f97-15fa018758c1	true	introspection.token.claim
3ad3e8f2-153b-49ed-9f97-15fa018758c1	true	userinfo.token.claim
3ad3e8f2-153b-49ed-9f97-15fa018758c1	picture	user.attribute
3ad3e8f2-153b-49ed-9f97-15fa018758c1	true	id.token.claim
3ad3e8f2-153b-49ed-9f97-15fa018758c1	true	access.token.claim
3ad3e8f2-153b-49ed-9f97-15fa018758c1	picture	claim.name
3ad3e8f2-153b-49ed-9f97-15fa018758c1	String	jsonType.label
51f87cf9-c0c5-4e0d-a4ff-595caffa7fdc	true	introspection.token.claim
51f87cf9-c0c5-4e0d-a4ff-595caffa7fdc	true	userinfo.token.claim
51f87cf9-c0c5-4e0d-a4ff-595caffa7fdc	profile	user.attribute
51f87cf9-c0c5-4e0d-a4ff-595caffa7fdc	true	id.token.claim
51f87cf9-c0c5-4e0d-a4ff-595caffa7fdc	true	access.token.claim
51f87cf9-c0c5-4e0d-a4ff-595caffa7fdc	profile	claim.name
51f87cf9-c0c5-4e0d-a4ff-595caffa7fdc	String	jsonType.label
6bd0524f-9172-403c-9f36-c3a1b3163352	true	introspection.token.claim
6bd0524f-9172-403c-9f36-c3a1b3163352	true	userinfo.token.claim
6bd0524f-9172-403c-9f36-c3a1b3163352	birthdate	user.attribute
6bd0524f-9172-403c-9f36-c3a1b3163352	true	id.token.claim
6bd0524f-9172-403c-9f36-c3a1b3163352	true	access.token.claim
6bd0524f-9172-403c-9f36-c3a1b3163352	birthdate	claim.name
6bd0524f-9172-403c-9f36-c3a1b3163352	String	jsonType.label
76c81d7e-196e-4b7b-8090-faeed5f0bb04	true	introspection.token.claim
76c81d7e-196e-4b7b-8090-faeed5f0bb04	true	userinfo.token.claim
76c81d7e-196e-4b7b-8090-faeed5f0bb04	middleName	user.attribute
76c81d7e-196e-4b7b-8090-faeed5f0bb04	true	id.token.claim
76c81d7e-196e-4b7b-8090-faeed5f0bb04	true	access.token.claim
76c81d7e-196e-4b7b-8090-faeed5f0bb04	middle_name	claim.name
76c81d7e-196e-4b7b-8090-faeed5f0bb04	String	jsonType.label
7f4c65b7-27e1-4b48-8e4b-cf8338ad668d	true	introspection.token.claim
7f4c65b7-27e1-4b48-8e4b-cf8338ad668d	true	userinfo.token.claim
7f4c65b7-27e1-4b48-8e4b-cf8338ad668d	website	user.attribute
7f4c65b7-27e1-4b48-8e4b-cf8338ad668d	true	id.token.claim
7f4c65b7-27e1-4b48-8e4b-cf8338ad668d	true	access.token.claim
7f4c65b7-27e1-4b48-8e4b-cf8338ad668d	website	claim.name
7f4c65b7-27e1-4b48-8e4b-cf8338ad668d	String	jsonType.label
814ac9d7-4f60-466f-8065-bd45ed90229c	true	introspection.token.claim
814ac9d7-4f60-466f-8065-bd45ed90229c	true	userinfo.token.claim
814ac9d7-4f60-466f-8065-bd45ed90229c	lastName	user.attribute
814ac9d7-4f60-466f-8065-bd45ed90229c	true	id.token.claim
814ac9d7-4f60-466f-8065-bd45ed90229c	true	access.token.claim
814ac9d7-4f60-466f-8065-bd45ed90229c	family_name	claim.name
814ac9d7-4f60-466f-8065-bd45ed90229c	String	jsonType.label
ccb68d8d-f236-4b5e-b2e1-017725cd19ba	true	introspection.token.claim
ccb68d8d-f236-4b5e-b2e1-017725cd19ba	true	userinfo.token.claim
ccb68d8d-f236-4b5e-b2e1-017725cd19ba	firstName	user.attribute
ccb68d8d-f236-4b5e-b2e1-017725cd19ba	true	id.token.claim
ccb68d8d-f236-4b5e-b2e1-017725cd19ba	true	access.token.claim
ccb68d8d-f236-4b5e-b2e1-017725cd19ba	given_name	claim.name
ccb68d8d-f236-4b5e-b2e1-017725cd19ba	String	jsonType.label
cee49b80-2c73-469d-a2ce-60bc04478935	true	introspection.token.claim
cee49b80-2c73-469d-a2ce-60bc04478935	true	userinfo.token.claim
cee49b80-2c73-469d-a2ce-60bc04478935	gender	user.attribute
cee49b80-2c73-469d-a2ce-60bc04478935	true	id.token.claim
cee49b80-2c73-469d-a2ce-60bc04478935	true	access.token.claim
cee49b80-2c73-469d-a2ce-60bc04478935	gender	claim.name
cee49b80-2c73-469d-a2ce-60bc04478935	String	jsonType.label
efdc8fda-ad45-4ab5-a1f3-c2665f2c6798	true	introspection.token.claim
efdc8fda-ad45-4ab5-a1f3-c2665f2c6798	true	userinfo.token.claim
efdc8fda-ad45-4ab5-a1f3-c2665f2c6798	true	id.token.claim
efdc8fda-ad45-4ab5-a1f3-c2665f2c6798	true	access.token.claim
f719c648-758d-40c1-b781-9e893ef35caf	true	introspection.token.claim
f719c648-758d-40c1-b781-9e893ef35caf	true	userinfo.token.claim
f719c648-758d-40c1-b781-9e893ef35caf	locale	user.attribute
f719c648-758d-40c1-b781-9e893ef35caf	true	id.token.claim
f719c648-758d-40c1-b781-9e893ef35caf	true	access.token.claim
f719c648-758d-40c1-b781-9e893ef35caf	locale	claim.name
f719c648-758d-40c1-b781-9e893ef35caf	String	jsonType.label
fe519a3d-8d81-403a-be5a-8a67bf243659	true	introspection.token.claim
fe519a3d-8d81-403a-be5a-8a67bf243659	true	userinfo.token.claim
fe519a3d-8d81-403a-be5a-8a67bf243659	username	user.attribute
fe519a3d-8d81-403a-be5a-8a67bf243659	true	id.token.claim
fe519a3d-8d81-403a-be5a-8a67bf243659	true	access.token.claim
fe519a3d-8d81-403a-be5a-8a67bf243659	preferred_username	claim.name
fe519a3d-8d81-403a-be5a-8a67bf243659	String	jsonType.label
3dfbbdc8-d30c-4d60-995b-e08d3be19a54	true	introspection.token.claim
3dfbbdc8-d30c-4d60-995b-e08d3be19a54	true	userinfo.token.claim
3dfbbdc8-d30c-4d60-995b-e08d3be19a54	emailVerified	user.attribute
3dfbbdc8-d30c-4d60-995b-e08d3be19a54	true	id.token.claim
3dfbbdc8-d30c-4d60-995b-e08d3be19a54	true	access.token.claim
3dfbbdc8-d30c-4d60-995b-e08d3be19a54	email_verified	claim.name
3dfbbdc8-d30c-4d60-995b-e08d3be19a54	boolean	jsonType.label
9a60ed49-ad95-4b3f-865f-9bf30ebba741	true	introspection.token.claim
9a60ed49-ad95-4b3f-865f-9bf30ebba741	true	userinfo.token.claim
9a60ed49-ad95-4b3f-865f-9bf30ebba741	email	user.attribute
9a60ed49-ad95-4b3f-865f-9bf30ebba741	true	id.token.claim
9a60ed49-ad95-4b3f-865f-9bf30ebba741	true	access.token.claim
9a60ed49-ad95-4b3f-865f-9bf30ebba741	email	claim.name
9a60ed49-ad95-4b3f-865f-9bf30ebba741	String	jsonType.label
c0f5aa35-5294-4c17-a4b7-c112163440a0	formatted	user.attribute.formatted
c0f5aa35-5294-4c17-a4b7-c112163440a0	country	user.attribute.country
c0f5aa35-5294-4c17-a4b7-c112163440a0	true	introspection.token.claim
c0f5aa35-5294-4c17-a4b7-c112163440a0	postal_code	user.attribute.postal_code
c0f5aa35-5294-4c17-a4b7-c112163440a0	true	userinfo.token.claim
c0f5aa35-5294-4c17-a4b7-c112163440a0	street	user.attribute.street
c0f5aa35-5294-4c17-a4b7-c112163440a0	true	id.token.claim
c0f5aa35-5294-4c17-a4b7-c112163440a0	region	user.attribute.region
c0f5aa35-5294-4c17-a4b7-c112163440a0	true	access.token.claim
c0f5aa35-5294-4c17-a4b7-c112163440a0	locality	user.attribute.locality
5b05fdbb-21b4-486f-ae99-a5da48831b01	true	introspection.token.claim
5b05fdbb-21b4-486f-ae99-a5da48831b01	true	userinfo.token.claim
5b05fdbb-21b4-486f-ae99-a5da48831b01	phoneNumberVerified	user.attribute
5b05fdbb-21b4-486f-ae99-a5da48831b01	true	id.token.claim
5b05fdbb-21b4-486f-ae99-a5da48831b01	true	access.token.claim
5b05fdbb-21b4-486f-ae99-a5da48831b01	phone_number_verified	claim.name
5b05fdbb-21b4-486f-ae99-a5da48831b01	boolean	jsonType.label
b34ec6d0-0f56-48fe-80ce-372de5301cd5	true	introspection.token.claim
b34ec6d0-0f56-48fe-80ce-372de5301cd5	true	userinfo.token.claim
b34ec6d0-0f56-48fe-80ce-372de5301cd5	phoneNumber	user.attribute
b34ec6d0-0f56-48fe-80ce-372de5301cd5	true	id.token.claim
b34ec6d0-0f56-48fe-80ce-372de5301cd5	true	access.token.claim
b34ec6d0-0f56-48fe-80ce-372de5301cd5	phone_number	claim.name
b34ec6d0-0f56-48fe-80ce-372de5301cd5	String	jsonType.label
1157b2a4-0661-4f6f-a4b4-d85c536e4250	true	introspection.token.claim
1157b2a4-0661-4f6f-a4b4-d85c536e4250	true	multivalued
1157b2a4-0661-4f6f-a4b4-d85c536e4250	foo	user.attribute
1157b2a4-0661-4f6f-a4b4-d85c536e4250	true	access.token.claim
1157b2a4-0661-4f6f-a4b4-d85c536e4250	resource_access.${client_id}.roles	claim.name
1157b2a4-0661-4f6f-a4b4-d85c536e4250	String	jsonType.label
2f070510-4487-45af-b507-d86a02c921f2	true	introspection.token.claim
2f070510-4487-45af-b507-d86a02c921f2	true	access.token.claim
609928cb-abac-43eb-b3f8-b47af9a06b55	true	introspection.token.claim
609928cb-abac-43eb-b3f8-b47af9a06b55	true	multivalued
609928cb-abac-43eb-b3f8-b47af9a06b55	foo	user.attribute
609928cb-abac-43eb-b3f8-b47af9a06b55	true	access.token.claim
609928cb-abac-43eb-b3f8-b47af9a06b55	realm_access.roles	claim.name
609928cb-abac-43eb-b3f8-b47af9a06b55	String	jsonType.label
35b14489-ec9d-4070-a093-d01de98c07f5	true	introspection.token.claim
35b14489-ec9d-4070-a093-d01de98c07f5	true	access.token.claim
193b641f-41de-4ded-8a8d-ba0457b5a8e7	true	introspection.token.claim
193b641f-41de-4ded-8a8d-ba0457b5a8e7	true	userinfo.token.claim
193b641f-41de-4ded-8a8d-ba0457b5a8e7	username	user.attribute
193b641f-41de-4ded-8a8d-ba0457b5a8e7	true	id.token.claim
193b641f-41de-4ded-8a8d-ba0457b5a8e7	true	access.token.claim
193b641f-41de-4ded-8a8d-ba0457b5a8e7	upn	claim.name
193b641f-41de-4ded-8a8d-ba0457b5a8e7	String	jsonType.label
3339fc33-1519-4277-bc8a-283c3c04baf6	true	introspection.token.claim
3339fc33-1519-4277-bc8a-283c3c04baf6	true	multivalued
3339fc33-1519-4277-bc8a-283c3c04baf6	foo	user.attribute
3339fc33-1519-4277-bc8a-283c3c04baf6	true	id.token.claim
3339fc33-1519-4277-bc8a-283c3c04baf6	true	access.token.claim
3339fc33-1519-4277-bc8a-283c3c04baf6	groups	claim.name
3339fc33-1519-4277-bc8a-283c3c04baf6	String	jsonType.label
10e0a925-1e97-4107-808e-abac818b646b	true	introspection.token.claim
10e0a925-1e97-4107-808e-abac818b646b	true	id.token.claim
10e0a925-1e97-4107-808e-abac818b646b	true	access.token.claim
390a8622-93ea-4771-b4f3-9356472ec56d	false	single
390a8622-93ea-4771-b4f3-9356472ec56d	Basic	attribute.nameformat
390a8622-93ea-4771-b4f3-9356472ec56d	Role	attribute.name
585cd667-851b-47cb-823f-00b8c64c05f9	true	introspection.token.claim
585cd667-851b-47cb-823f-00b8c64c05f9	true	userinfo.token.claim
585cd667-851b-47cb-823f-00b8c64c05f9	birthdate	user.attribute
585cd667-851b-47cb-823f-00b8c64c05f9	true	id.token.claim
585cd667-851b-47cb-823f-00b8c64c05f9	true	access.token.claim
585cd667-851b-47cb-823f-00b8c64c05f9	birthdate	claim.name
585cd667-851b-47cb-823f-00b8c64c05f9	String	jsonType.label
608e6ba7-37ab-4b65-9578-2b310729a70f	true	introspection.token.claim
608e6ba7-37ab-4b65-9578-2b310729a70f	true	userinfo.token.claim
608e6ba7-37ab-4b65-9578-2b310729a70f	picture	user.attribute
608e6ba7-37ab-4b65-9578-2b310729a70f	true	id.token.claim
608e6ba7-37ab-4b65-9578-2b310729a70f	true	access.token.claim
608e6ba7-37ab-4b65-9578-2b310729a70f	picture	claim.name
608e6ba7-37ab-4b65-9578-2b310729a70f	String	jsonType.label
60d1aa0a-8020-47f9-86bd-593e8b77a05d	true	introspection.token.claim
60d1aa0a-8020-47f9-86bd-593e8b77a05d	true	userinfo.token.claim
60d1aa0a-8020-47f9-86bd-593e8b77a05d	username	user.attribute
60d1aa0a-8020-47f9-86bd-593e8b77a05d	true	id.token.claim
60d1aa0a-8020-47f9-86bd-593e8b77a05d	true	access.token.claim
60d1aa0a-8020-47f9-86bd-593e8b77a05d	preferred_username	claim.name
60d1aa0a-8020-47f9-86bd-593e8b77a05d	String	jsonType.label
68e3fb00-20d3-4db0-90c8-6b29c9349c7f	true	introspection.token.claim
68e3fb00-20d3-4db0-90c8-6b29c9349c7f	true	userinfo.token.claim
68e3fb00-20d3-4db0-90c8-6b29c9349c7f	lastName	user.attribute
68e3fb00-20d3-4db0-90c8-6b29c9349c7f	true	id.token.claim
68e3fb00-20d3-4db0-90c8-6b29c9349c7f	true	access.token.claim
68e3fb00-20d3-4db0-90c8-6b29c9349c7f	family_name	claim.name
68e3fb00-20d3-4db0-90c8-6b29c9349c7f	String	jsonType.label
6cd0bfcb-86e6-40d2-9eb7-3e549ea05609	true	introspection.token.claim
6cd0bfcb-86e6-40d2-9eb7-3e549ea05609	true	userinfo.token.claim
6cd0bfcb-86e6-40d2-9eb7-3e549ea05609	true	id.token.claim
6cd0bfcb-86e6-40d2-9eb7-3e549ea05609	true	access.token.claim
864377d4-6034-4d01-834e-0d1af96a88d7	true	introspection.token.claim
864377d4-6034-4d01-834e-0d1af96a88d7	true	userinfo.token.claim
864377d4-6034-4d01-834e-0d1af96a88d7	middleName	user.attribute
864377d4-6034-4d01-834e-0d1af96a88d7	true	id.token.claim
864377d4-6034-4d01-834e-0d1af96a88d7	true	access.token.claim
864377d4-6034-4d01-834e-0d1af96a88d7	middle_name	claim.name
864377d4-6034-4d01-834e-0d1af96a88d7	String	jsonType.label
9754637c-dd67-4a7c-bbd3-f4eaaf720777	true	introspection.token.claim
9754637c-dd67-4a7c-bbd3-f4eaaf720777	true	userinfo.token.claim
9754637c-dd67-4a7c-bbd3-f4eaaf720777	profile	user.attribute
9754637c-dd67-4a7c-bbd3-f4eaaf720777	true	id.token.claim
9754637c-dd67-4a7c-bbd3-f4eaaf720777	true	access.token.claim
9754637c-dd67-4a7c-bbd3-f4eaaf720777	profile	claim.name
9754637c-dd67-4a7c-bbd3-f4eaaf720777	String	jsonType.label
a8d5e83a-b2d7-4ce0-8a89-2ab76e210117	true	introspection.token.claim
a8d5e83a-b2d7-4ce0-8a89-2ab76e210117	true	userinfo.token.claim
a8d5e83a-b2d7-4ce0-8a89-2ab76e210117	locale	user.attribute
a8d5e83a-b2d7-4ce0-8a89-2ab76e210117	true	id.token.claim
a8d5e83a-b2d7-4ce0-8a89-2ab76e210117	true	access.token.claim
a8d5e83a-b2d7-4ce0-8a89-2ab76e210117	locale	claim.name
a8d5e83a-b2d7-4ce0-8a89-2ab76e210117	String	jsonType.label
d35e6580-2d82-4717-b8ec-a151ff7eba61	true	introspection.token.claim
d35e6580-2d82-4717-b8ec-a151ff7eba61	true	userinfo.token.claim
d35e6580-2d82-4717-b8ec-a151ff7eba61	gender	user.attribute
d35e6580-2d82-4717-b8ec-a151ff7eba61	true	id.token.claim
d35e6580-2d82-4717-b8ec-a151ff7eba61	true	access.token.claim
d35e6580-2d82-4717-b8ec-a151ff7eba61	gender	claim.name
d35e6580-2d82-4717-b8ec-a151ff7eba61	String	jsonType.label
d7e86a27-2f27-4c6d-8b66-767956f5ae78	true	introspection.token.claim
d7e86a27-2f27-4c6d-8b66-767956f5ae78	true	userinfo.token.claim
d7e86a27-2f27-4c6d-8b66-767956f5ae78	updatedAt	user.attribute
d7e86a27-2f27-4c6d-8b66-767956f5ae78	true	id.token.claim
d7e86a27-2f27-4c6d-8b66-767956f5ae78	true	access.token.claim
d7e86a27-2f27-4c6d-8b66-767956f5ae78	updated_at	claim.name
d7e86a27-2f27-4c6d-8b66-767956f5ae78	long	jsonType.label
e73696f5-09fc-4ad7-aabb-2c273413dd15	true	introspection.token.claim
e73696f5-09fc-4ad7-aabb-2c273413dd15	true	userinfo.token.claim
e73696f5-09fc-4ad7-aabb-2c273413dd15	nickname	user.attribute
e73696f5-09fc-4ad7-aabb-2c273413dd15	true	id.token.claim
e73696f5-09fc-4ad7-aabb-2c273413dd15	true	access.token.claim
e73696f5-09fc-4ad7-aabb-2c273413dd15	nickname	claim.name
e73696f5-09fc-4ad7-aabb-2c273413dd15	String	jsonType.label
f410e08f-7aa0-4b11-b5d9-080ea63de760	true	introspection.token.claim
f410e08f-7aa0-4b11-b5d9-080ea63de760	true	userinfo.token.claim
f410e08f-7aa0-4b11-b5d9-080ea63de760	zoneinfo	user.attribute
f410e08f-7aa0-4b11-b5d9-080ea63de760	true	id.token.claim
f410e08f-7aa0-4b11-b5d9-080ea63de760	true	access.token.claim
f410e08f-7aa0-4b11-b5d9-080ea63de760	zoneinfo	claim.name
f410e08f-7aa0-4b11-b5d9-080ea63de760	String	jsonType.label
f90df792-14f7-4b35-ae91-aed2bcfa4d42	true	introspection.token.claim
f90df792-14f7-4b35-ae91-aed2bcfa4d42	true	userinfo.token.claim
f90df792-14f7-4b35-ae91-aed2bcfa4d42	firstName	user.attribute
f90df792-14f7-4b35-ae91-aed2bcfa4d42	true	id.token.claim
f90df792-14f7-4b35-ae91-aed2bcfa4d42	true	access.token.claim
f90df792-14f7-4b35-ae91-aed2bcfa4d42	given_name	claim.name
f90df792-14f7-4b35-ae91-aed2bcfa4d42	String	jsonType.label
fed6f0b2-1fbc-423d-a6bd-4ed38d03740f	true	introspection.token.claim
fed6f0b2-1fbc-423d-a6bd-4ed38d03740f	true	userinfo.token.claim
fed6f0b2-1fbc-423d-a6bd-4ed38d03740f	website	user.attribute
fed6f0b2-1fbc-423d-a6bd-4ed38d03740f	true	id.token.claim
fed6f0b2-1fbc-423d-a6bd-4ed38d03740f	true	access.token.claim
fed6f0b2-1fbc-423d-a6bd-4ed38d03740f	website	claim.name
fed6f0b2-1fbc-423d-a6bd-4ed38d03740f	String	jsonType.label
a7399f8f-66b5-4f85-a8ea-f5454ee1471e	true	introspection.token.claim
a7399f8f-66b5-4f85-a8ea-f5454ee1471e	true	userinfo.token.claim
a7399f8f-66b5-4f85-a8ea-f5454ee1471e	email	user.attribute
a7399f8f-66b5-4f85-a8ea-f5454ee1471e	true	id.token.claim
a7399f8f-66b5-4f85-a8ea-f5454ee1471e	true	access.token.claim
a7399f8f-66b5-4f85-a8ea-f5454ee1471e	email	claim.name
a7399f8f-66b5-4f85-a8ea-f5454ee1471e	String	jsonType.label
ba9cd7bd-a693-443b-84ff-333de8f4a6cc	true	introspection.token.claim
ba9cd7bd-a693-443b-84ff-333de8f4a6cc	true	userinfo.token.claim
ba9cd7bd-a693-443b-84ff-333de8f4a6cc	emailVerified	user.attribute
ba9cd7bd-a693-443b-84ff-333de8f4a6cc	true	id.token.claim
ba9cd7bd-a693-443b-84ff-333de8f4a6cc	true	access.token.claim
ba9cd7bd-a693-443b-84ff-333de8f4a6cc	email_verified	claim.name
ba9cd7bd-a693-443b-84ff-333de8f4a6cc	boolean	jsonType.label
eb1fb2fb-14cd-452e-b21b-b5700d9db841	formatted	user.attribute.formatted
eb1fb2fb-14cd-452e-b21b-b5700d9db841	country	user.attribute.country
eb1fb2fb-14cd-452e-b21b-b5700d9db841	true	introspection.token.claim
eb1fb2fb-14cd-452e-b21b-b5700d9db841	postal_code	user.attribute.postal_code
eb1fb2fb-14cd-452e-b21b-b5700d9db841	true	userinfo.token.claim
eb1fb2fb-14cd-452e-b21b-b5700d9db841	street	user.attribute.street
eb1fb2fb-14cd-452e-b21b-b5700d9db841	true	id.token.claim
eb1fb2fb-14cd-452e-b21b-b5700d9db841	region	user.attribute.region
eb1fb2fb-14cd-452e-b21b-b5700d9db841	true	access.token.claim
eb1fb2fb-14cd-452e-b21b-b5700d9db841	locality	user.attribute.locality
214f5911-00ac-4dc4-bc22-9c9bda10bcac	true	introspection.token.claim
214f5911-00ac-4dc4-bc22-9c9bda10bcac	true	userinfo.token.claim
214f5911-00ac-4dc4-bc22-9c9bda10bcac	phoneNumberVerified	user.attribute
214f5911-00ac-4dc4-bc22-9c9bda10bcac	true	id.token.claim
214f5911-00ac-4dc4-bc22-9c9bda10bcac	true	access.token.claim
214f5911-00ac-4dc4-bc22-9c9bda10bcac	phone_number_verified	claim.name
214f5911-00ac-4dc4-bc22-9c9bda10bcac	boolean	jsonType.label
f97d2b63-9eac-4544-862f-55f51da0c5f1	true	introspection.token.claim
f97d2b63-9eac-4544-862f-55f51da0c5f1	true	userinfo.token.claim
f97d2b63-9eac-4544-862f-55f51da0c5f1	phoneNumber	user.attribute
f97d2b63-9eac-4544-862f-55f51da0c5f1	true	id.token.claim
f97d2b63-9eac-4544-862f-55f51da0c5f1	true	access.token.claim
f97d2b63-9eac-4544-862f-55f51da0c5f1	phone_number	claim.name
f97d2b63-9eac-4544-862f-55f51da0c5f1	String	jsonType.label
1d3f4b72-4d65-4ad3-b70f-f615ad8c293e	true	introspection.token.claim
1d3f4b72-4d65-4ad3-b70f-f615ad8c293e	true	multivalued
1d3f4b72-4d65-4ad3-b70f-f615ad8c293e	foo	user.attribute
1d3f4b72-4d65-4ad3-b70f-f615ad8c293e	true	access.token.claim
1d3f4b72-4d65-4ad3-b70f-f615ad8c293e	realm_access.roles	claim.name
1d3f4b72-4d65-4ad3-b70f-f615ad8c293e	String	jsonType.label
a43706ba-87d5-4ee4-ba63-6fed6e181f1e	true	introspection.token.claim
a43706ba-87d5-4ee4-ba63-6fed6e181f1e	true	access.token.claim
f222e79b-1beb-46ef-91a0-f34c3cd5a197	true	introspection.token.claim
f222e79b-1beb-46ef-91a0-f34c3cd5a197	true	multivalued
f222e79b-1beb-46ef-91a0-f34c3cd5a197	foo	user.attribute
f222e79b-1beb-46ef-91a0-f34c3cd5a197	true	access.token.claim
f222e79b-1beb-46ef-91a0-f34c3cd5a197	resource_access.${client_id}.roles	claim.name
f222e79b-1beb-46ef-91a0-f34c3cd5a197	String	jsonType.label
061f4e4b-fa6b-4836-aa36-4ee4acdaebf0	true	introspection.token.claim
061f4e4b-fa6b-4836-aa36-4ee4acdaebf0	true	access.token.claim
7bb94383-720a-4586-90f4-43d369727e5e	true	introspection.token.claim
7bb94383-720a-4586-90f4-43d369727e5e	true	multivalued
7bb94383-720a-4586-90f4-43d369727e5e	foo	user.attribute
7bb94383-720a-4586-90f4-43d369727e5e	true	id.token.claim
7bb94383-720a-4586-90f4-43d369727e5e	true	access.token.claim
7bb94383-720a-4586-90f4-43d369727e5e	groups	claim.name
7bb94383-720a-4586-90f4-43d369727e5e	String	jsonType.label
d2a42598-32f3-4d4a-bd65-24f7d030ed3d	true	introspection.token.claim
d2a42598-32f3-4d4a-bd65-24f7d030ed3d	true	userinfo.token.claim
d2a42598-32f3-4d4a-bd65-24f7d030ed3d	username	user.attribute
d2a42598-32f3-4d4a-bd65-24f7d030ed3d	true	id.token.claim
d2a42598-32f3-4d4a-bd65-24f7d030ed3d	true	access.token.claim
d2a42598-32f3-4d4a-bd65-24f7d030ed3d	upn	claim.name
d2a42598-32f3-4d4a-bd65-24f7d030ed3d	String	jsonType.label
28e9a316-b600-4c91-9dfc-f33d7cb84665	true	introspection.token.claim
28e9a316-b600-4c91-9dfc-f33d7cb84665	true	id.token.claim
28e9a316-b600-4c91-9dfc-f33d7cb84665	true	access.token.claim
60d7358f-eb1b-4b02-bc97-da0304fb555c	true	introspection.token.claim
60d7358f-eb1b-4b02-bc97-da0304fb555c	true	userinfo.token.claim
60d7358f-eb1b-4b02-bc97-da0304fb555c	locale	user.attribute
60d7358f-eb1b-4b02-bc97-da0304fb555c	true	id.token.claim
60d7358f-eb1b-4b02-bc97-da0304fb555c	true	access.token.claim
60d7358f-eb1b-4b02-bc97-da0304fb555c	locale	claim.name
60d7358f-eb1b-4b02-bc97-da0304fb555c	String	jsonType.label
7c3ce644-39ad-44e6-a6fa-98a0348479a8	false	single
7c3ce644-39ad-44e6-a6fa-98a0348479a8	Basic	attribute.nameformat
7c3ce644-39ad-44e6-a6fa-98a0348479a8	Role	attribute.name
01a19ace-405f-4ccb-b361-6b23e03e1ddb	true	introspection.token.claim
01a19ace-405f-4ccb-b361-6b23e03e1ddb	true	userinfo.token.claim
01a19ace-405f-4ccb-b361-6b23e03e1ddb	username	user.attribute
01a19ace-405f-4ccb-b361-6b23e03e1ddb	true	id.token.claim
01a19ace-405f-4ccb-b361-6b23e03e1ddb	true	access.token.claim
01a19ace-405f-4ccb-b361-6b23e03e1ddb	preferred_username	claim.name
01a19ace-405f-4ccb-b361-6b23e03e1ddb	String	jsonType.label
16b73921-6dbe-4513-b14d-f21739c6a7cf	true	introspection.token.claim
16b73921-6dbe-4513-b14d-f21739c6a7cf	true	userinfo.token.claim
16b73921-6dbe-4513-b14d-f21739c6a7cf	gender	user.attribute
16b73921-6dbe-4513-b14d-f21739c6a7cf	true	id.token.claim
16b73921-6dbe-4513-b14d-f21739c6a7cf	true	access.token.claim
16b73921-6dbe-4513-b14d-f21739c6a7cf	gender	claim.name
16b73921-6dbe-4513-b14d-f21739c6a7cf	String	jsonType.label
46f7d4b6-ec60-4dc9-97a7-78af53082baf	true	introspection.token.claim
46f7d4b6-ec60-4dc9-97a7-78af53082baf	true	userinfo.token.claim
46f7d4b6-ec60-4dc9-97a7-78af53082baf	middleName	user.attribute
46f7d4b6-ec60-4dc9-97a7-78af53082baf	true	id.token.claim
46f7d4b6-ec60-4dc9-97a7-78af53082baf	true	access.token.claim
46f7d4b6-ec60-4dc9-97a7-78af53082baf	middle_name	claim.name
46f7d4b6-ec60-4dc9-97a7-78af53082baf	String	jsonType.label
6ddf67eb-5d45-4232-a4d1-dc54f13529e6	true	introspection.token.claim
6ddf67eb-5d45-4232-a4d1-dc54f13529e6	true	userinfo.token.claim
6ddf67eb-5d45-4232-a4d1-dc54f13529e6	birthdate	user.attribute
6ddf67eb-5d45-4232-a4d1-dc54f13529e6	true	id.token.claim
6ddf67eb-5d45-4232-a4d1-dc54f13529e6	true	access.token.claim
6ddf67eb-5d45-4232-a4d1-dc54f13529e6	birthdate	claim.name
6ddf67eb-5d45-4232-a4d1-dc54f13529e6	String	jsonType.label
8213189f-de5d-4245-a43e-f2533223f40d	true	introspection.token.claim
8213189f-de5d-4245-a43e-f2533223f40d	true	userinfo.token.claim
8213189f-de5d-4245-a43e-f2533223f40d	updatedAt	user.attribute
8213189f-de5d-4245-a43e-f2533223f40d	true	id.token.claim
8213189f-de5d-4245-a43e-f2533223f40d	true	access.token.claim
8213189f-de5d-4245-a43e-f2533223f40d	updated_at	claim.name
8213189f-de5d-4245-a43e-f2533223f40d	long	jsonType.label
8fee777c-03bf-493a-8fca-6c49d1dd166f	true	introspection.token.claim
8fee777c-03bf-493a-8fca-6c49d1dd166f	true	userinfo.token.claim
8fee777c-03bf-493a-8fca-6c49d1dd166f	firstName	user.attribute
8fee777c-03bf-493a-8fca-6c49d1dd166f	true	id.token.claim
8fee777c-03bf-493a-8fca-6c49d1dd166f	true	access.token.claim
8fee777c-03bf-493a-8fca-6c49d1dd166f	given_name	claim.name
8fee777c-03bf-493a-8fca-6c49d1dd166f	String	jsonType.label
9e66cdc1-b8fa-4bf6-9206-664912e170f6	true	introspection.token.claim
9e66cdc1-b8fa-4bf6-9206-664912e170f6	true	userinfo.token.claim
9e66cdc1-b8fa-4bf6-9206-664912e170f6	profile	user.attribute
9e66cdc1-b8fa-4bf6-9206-664912e170f6	true	id.token.claim
9e66cdc1-b8fa-4bf6-9206-664912e170f6	true	access.token.claim
9e66cdc1-b8fa-4bf6-9206-664912e170f6	profile	claim.name
9e66cdc1-b8fa-4bf6-9206-664912e170f6	String	jsonType.label
a484a062-5b8e-44a2-bd9e-37884b9e9106	true	introspection.token.claim
a484a062-5b8e-44a2-bd9e-37884b9e9106	true	userinfo.token.claim
a484a062-5b8e-44a2-bd9e-37884b9e9106	locale	user.attribute
a484a062-5b8e-44a2-bd9e-37884b9e9106	true	id.token.claim
a484a062-5b8e-44a2-bd9e-37884b9e9106	true	access.token.claim
a484a062-5b8e-44a2-bd9e-37884b9e9106	locale	claim.name
a484a062-5b8e-44a2-bd9e-37884b9e9106	String	jsonType.label
b2b42de3-d154-490e-89b4-a601d1a6c03c	true	introspection.token.claim
b2b42de3-d154-490e-89b4-a601d1a6c03c	true	userinfo.token.claim
b2b42de3-d154-490e-89b4-a601d1a6c03c	true	id.token.claim
b2b42de3-d154-490e-89b4-a601d1a6c03c	true	access.token.claim
c606b220-529d-4fb1-9d21-8dfbd19ad43e	true	introspection.token.claim
c606b220-529d-4fb1-9d21-8dfbd19ad43e	true	userinfo.token.claim
c606b220-529d-4fb1-9d21-8dfbd19ad43e	website	user.attribute
c606b220-529d-4fb1-9d21-8dfbd19ad43e	true	id.token.claim
c606b220-529d-4fb1-9d21-8dfbd19ad43e	true	access.token.claim
c606b220-529d-4fb1-9d21-8dfbd19ad43e	website	claim.name
c606b220-529d-4fb1-9d21-8dfbd19ad43e	String	jsonType.label
c7b0ebba-4595-43bd-bad9-863a50161d2a	true	introspection.token.claim
c7b0ebba-4595-43bd-bad9-863a50161d2a	true	userinfo.token.claim
c7b0ebba-4595-43bd-bad9-863a50161d2a	nickname	user.attribute
c7b0ebba-4595-43bd-bad9-863a50161d2a	true	id.token.claim
c7b0ebba-4595-43bd-bad9-863a50161d2a	true	access.token.claim
c7b0ebba-4595-43bd-bad9-863a50161d2a	nickname	claim.name
c7b0ebba-4595-43bd-bad9-863a50161d2a	String	jsonType.label
ce06cefe-942b-4c40-a1c3-282ffa31b092	true	introspection.token.claim
ce06cefe-942b-4c40-a1c3-282ffa31b092	true	userinfo.token.claim
ce06cefe-942b-4c40-a1c3-282ffa31b092	picture	user.attribute
ce06cefe-942b-4c40-a1c3-282ffa31b092	true	id.token.claim
ce06cefe-942b-4c40-a1c3-282ffa31b092	true	access.token.claim
ce06cefe-942b-4c40-a1c3-282ffa31b092	picture	claim.name
ce06cefe-942b-4c40-a1c3-282ffa31b092	String	jsonType.label
e87766c1-3c66-4a92-9f27-4567f672b51c	true	introspection.token.claim
e87766c1-3c66-4a92-9f27-4567f672b51c	true	userinfo.token.claim
e87766c1-3c66-4a92-9f27-4567f672b51c	lastName	user.attribute
e87766c1-3c66-4a92-9f27-4567f672b51c	true	id.token.claim
e87766c1-3c66-4a92-9f27-4567f672b51c	true	access.token.claim
e87766c1-3c66-4a92-9f27-4567f672b51c	family_name	claim.name
e87766c1-3c66-4a92-9f27-4567f672b51c	String	jsonType.label
e9c232c1-737a-4cc5-9092-1049e615d388	true	introspection.token.claim
e9c232c1-737a-4cc5-9092-1049e615d388	true	userinfo.token.claim
e9c232c1-737a-4cc5-9092-1049e615d388	zoneinfo	user.attribute
e9c232c1-737a-4cc5-9092-1049e615d388	true	id.token.claim
e9c232c1-737a-4cc5-9092-1049e615d388	true	access.token.claim
e9c232c1-737a-4cc5-9092-1049e615d388	zoneinfo	claim.name
e9c232c1-737a-4cc5-9092-1049e615d388	String	jsonType.label
6618c401-2c95-4cc6-9116-dff0af122828	true	introspection.token.claim
6618c401-2c95-4cc6-9116-dff0af122828	true	userinfo.token.claim
6618c401-2c95-4cc6-9116-dff0af122828	emailVerified	user.attribute
6618c401-2c95-4cc6-9116-dff0af122828	true	id.token.claim
6618c401-2c95-4cc6-9116-dff0af122828	true	access.token.claim
6618c401-2c95-4cc6-9116-dff0af122828	email_verified	claim.name
6618c401-2c95-4cc6-9116-dff0af122828	boolean	jsonType.label
9703b9cd-a6cf-4997-aacc-d774d26a34cb	true	introspection.token.claim
9703b9cd-a6cf-4997-aacc-d774d26a34cb	true	userinfo.token.claim
9703b9cd-a6cf-4997-aacc-d774d26a34cb	email	user.attribute
9703b9cd-a6cf-4997-aacc-d774d26a34cb	true	id.token.claim
9703b9cd-a6cf-4997-aacc-d774d26a34cb	true	access.token.claim
9703b9cd-a6cf-4997-aacc-d774d26a34cb	email	claim.name
9703b9cd-a6cf-4997-aacc-d774d26a34cb	String	jsonType.label
6ca6503c-c51c-400b-addc-3a83832feed5	formatted	user.attribute.formatted
6ca6503c-c51c-400b-addc-3a83832feed5	country	user.attribute.country
6ca6503c-c51c-400b-addc-3a83832feed5	true	introspection.token.claim
6ca6503c-c51c-400b-addc-3a83832feed5	postal_code	user.attribute.postal_code
6ca6503c-c51c-400b-addc-3a83832feed5	true	userinfo.token.claim
6ca6503c-c51c-400b-addc-3a83832feed5	street	user.attribute.street
6ca6503c-c51c-400b-addc-3a83832feed5	true	id.token.claim
6ca6503c-c51c-400b-addc-3a83832feed5	region	user.attribute.region
6ca6503c-c51c-400b-addc-3a83832feed5	true	access.token.claim
6ca6503c-c51c-400b-addc-3a83832feed5	locality	user.attribute.locality
9c3df38c-fd8c-47fb-8713-3fc387f7b1ef	true	introspection.token.claim
9c3df38c-fd8c-47fb-8713-3fc387f7b1ef	true	userinfo.token.claim
9c3df38c-fd8c-47fb-8713-3fc387f7b1ef	phoneNumberVerified	user.attribute
9c3df38c-fd8c-47fb-8713-3fc387f7b1ef	true	id.token.claim
9c3df38c-fd8c-47fb-8713-3fc387f7b1ef	true	access.token.claim
9c3df38c-fd8c-47fb-8713-3fc387f7b1ef	phone_number_verified	claim.name
9c3df38c-fd8c-47fb-8713-3fc387f7b1ef	boolean	jsonType.label
cff21dd4-16d5-4cba-9c72-b397e6f219bc	true	introspection.token.claim
cff21dd4-16d5-4cba-9c72-b397e6f219bc	true	userinfo.token.claim
cff21dd4-16d5-4cba-9c72-b397e6f219bc	phoneNumber	user.attribute
cff21dd4-16d5-4cba-9c72-b397e6f219bc	true	id.token.claim
cff21dd4-16d5-4cba-9c72-b397e6f219bc	true	access.token.claim
cff21dd4-16d5-4cba-9c72-b397e6f219bc	phone_number	claim.name
cff21dd4-16d5-4cba-9c72-b397e6f219bc	String	jsonType.label
7eb44102-cfed-408c-8639-9363086b6125	true	introspection.token.claim
7eb44102-cfed-408c-8639-9363086b6125	true	multivalued
7eb44102-cfed-408c-8639-9363086b6125	foo	user.attribute
7eb44102-cfed-408c-8639-9363086b6125	true	access.token.claim
7eb44102-cfed-408c-8639-9363086b6125	resource_access.${client_id}.roles	claim.name
7eb44102-cfed-408c-8639-9363086b6125	String	jsonType.label
8479bf8f-eaf8-490c-9bc3-d6f29a66e1c0	true	introspection.token.claim
8479bf8f-eaf8-490c-9bc3-d6f29a66e1c0	true	access.token.claim
8fb04627-6288-4e8e-8c7d-a9ddbc9206f9	true	introspection.token.claim
8fb04627-6288-4e8e-8c7d-a9ddbc9206f9	true	multivalued
8fb04627-6288-4e8e-8c7d-a9ddbc9206f9	foo	user.attribute
8fb04627-6288-4e8e-8c7d-a9ddbc9206f9	true	access.token.claim
8fb04627-6288-4e8e-8c7d-a9ddbc9206f9	realm_access.roles	claim.name
8fb04627-6288-4e8e-8c7d-a9ddbc9206f9	String	jsonType.label
535df3a8-a18f-4401-adbc-d47cd866223d	true	introspection.token.claim
535df3a8-a18f-4401-adbc-d47cd866223d	true	access.token.claim
e122ca50-559e-4d6c-8f4f-f7848e2aac2d	true	introspection.token.claim
e122ca50-559e-4d6c-8f4f-f7848e2aac2d	true	multivalued
e122ca50-559e-4d6c-8f4f-f7848e2aac2d	foo	user.attribute
e122ca50-559e-4d6c-8f4f-f7848e2aac2d	true	id.token.claim
e122ca50-559e-4d6c-8f4f-f7848e2aac2d	true	access.token.claim
e122ca50-559e-4d6c-8f4f-f7848e2aac2d	groups	claim.name
e122ca50-559e-4d6c-8f4f-f7848e2aac2d	String	jsonType.label
fc836e5d-9884-4b50-bed7-18babd423edd	true	introspection.token.claim
fc836e5d-9884-4b50-bed7-18babd423edd	true	userinfo.token.claim
fc836e5d-9884-4b50-bed7-18babd423edd	username	user.attribute
fc836e5d-9884-4b50-bed7-18babd423edd	true	id.token.claim
fc836e5d-9884-4b50-bed7-18babd423edd	true	access.token.claim
fc836e5d-9884-4b50-bed7-18babd423edd	upn	claim.name
fc836e5d-9884-4b50-bed7-18babd423edd	String	jsonType.label
7c9f3990-8c9e-4bef-9faa-0f6f6f21f294	true	introspection.token.claim
7c9f3990-8c9e-4bef-9faa-0f6f6f21f294	true	id.token.claim
7c9f3990-8c9e-4bef-9faa-0f6f6f21f294	true	access.token.claim
9c099bd4-621a-4e80-a201-f050b8b8109e	true	introspection.token.claim
9c099bd4-621a-4e80-a201-f050b8b8109e	true	userinfo.token.claim
9c099bd4-621a-4e80-a201-f050b8b8109e	locale	user.attribute
9c099bd4-621a-4e80-a201-f050b8b8109e	true	id.token.claim
9c099bd4-621a-4e80-a201-f050b8b8109e	true	access.token.claim
9c099bd4-621a-4e80-a201-f050b8b8109e	locale	claim.name
9c099bd4-621a-4e80-a201-f050b8b8109e	String	jsonType.label
6d0b4192-ac75-411f-9e9d-71b5dc9b2116	true	introspection.token.claim
6d0b4192-ac75-411f-9e9d-71b5dc9b2116	true	userinfo.token.claim
6d0b4192-ac75-411f-9e9d-71b5dc9b2116	fullName	user.attribute
6d0b4192-ac75-411f-9e9d-71b5dc9b2116	true	id.token.claim
6d0b4192-ac75-411f-9e9d-71b5dc9b2116	false	lightweight.claim
6d0b4192-ac75-411f-9e9d-71b5dc9b2116	true	access.token.claim
6d0b4192-ac75-411f-9e9d-71b5dc9b2116	name	claim.name
6d0b4192-ac75-411f-9e9d-71b5dc9b2116	String	jsonType.label
fd1fe02d-7396-4c92-bbe6-a34c394c7fac	false	single
fd1fe02d-7396-4c92-bbe6-a34c394c7fac	Basic	attribute.nameformat
fd1fe02d-7396-4c92-bbe6-a34c394c7fac	Role	attribute.name
00fc59db-df89-4df9-9c3c-2db4f4ffcfaf	true	introspection.token.claim
00fc59db-df89-4df9-9c3c-2db4f4ffcfaf	true	userinfo.token.claim
00fc59db-df89-4df9-9c3c-2db4f4ffcfaf	true	id.token.claim
00fc59db-df89-4df9-9c3c-2db4f4ffcfaf	true	access.token.claim
018a2cad-af43-439f-9ef8-1e4ffc184f38	true	introspection.token.claim
018a2cad-af43-439f-9ef8-1e4ffc184f38	true	userinfo.token.claim
018a2cad-af43-439f-9ef8-1e4ffc184f38	profile	user.attribute
018a2cad-af43-439f-9ef8-1e4ffc184f38	true	id.token.claim
018a2cad-af43-439f-9ef8-1e4ffc184f38	true	access.token.claim
018a2cad-af43-439f-9ef8-1e4ffc184f38	profile	claim.name
018a2cad-af43-439f-9ef8-1e4ffc184f38	String	jsonType.label
15c90da1-ee01-4247-89c1-fdd7dbf67f3e	true	introspection.token.claim
15c90da1-ee01-4247-89c1-fdd7dbf67f3e	true	userinfo.token.claim
15c90da1-ee01-4247-89c1-fdd7dbf67f3e	locale	user.attribute
15c90da1-ee01-4247-89c1-fdd7dbf67f3e	true	id.token.claim
15c90da1-ee01-4247-89c1-fdd7dbf67f3e	true	access.token.claim
15c90da1-ee01-4247-89c1-fdd7dbf67f3e	locale	claim.name
15c90da1-ee01-4247-89c1-fdd7dbf67f3e	String	jsonType.label
1ddbf44e-e6b1-4840-a663-3f4a5a7ab20e	true	introspection.token.claim
1ddbf44e-e6b1-4840-a663-3f4a5a7ab20e	true	userinfo.token.claim
1ddbf44e-e6b1-4840-a663-3f4a5a7ab20e	birthdate	user.attribute
1ddbf44e-e6b1-4840-a663-3f4a5a7ab20e	true	id.token.claim
1ddbf44e-e6b1-4840-a663-3f4a5a7ab20e	true	access.token.claim
1ddbf44e-e6b1-4840-a663-3f4a5a7ab20e	birthdate	claim.name
1ddbf44e-e6b1-4840-a663-3f4a5a7ab20e	String	jsonType.label
2dbeff4a-07c3-4400-8935-da9fe0ab3cb4	true	introspection.token.claim
2dbeff4a-07c3-4400-8935-da9fe0ab3cb4	true	userinfo.token.claim
2dbeff4a-07c3-4400-8935-da9fe0ab3cb4	firstName	user.attribute
2dbeff4a-07c3-4400-8935-da9fe0ab3cb4	true	id.token.claim
2dbeff4a-07c3-4400-8935-da9fe0ab3cb4	true	access.token.claim
2dbeff4a-07c3-4400-8935-da9fe0ab3cb4	given_name	claim.name
2dbeff4a-07c3-4400-8935-da9fe0ab3cb4	String	jsonType.label
62d3bc95-853f-4c07-99c3-57ebb385083c	true	introspection.token.claim
62d3bc95-853f-4c07-99c3-57ebb385083c	true	userinfo.token.claim
62d3bc95-853f-4c07-99c3-57ebb385083c	zoneinfo	user.attribute
62d3bc95-853f-4c07-99c3-57ebb385083c	true	id.token.claim
62d3bc95-853f-4c07-99c3-57ebb385083c	true	access.token.claim
62d3bc95-853f-4c07-99c3-57ebb385083c	zoneinfo	claim.name
62d3bc95-853f-4c07-99c3-57ebb385083c	String	jsonType.label
778cee48-68db-412c-8cef-ed2992ec3a41	true	introspection.token.claim
778cee48-68db-412c-8cef-ed2992ec3a41	true	userinfo.token.claim
778cee48-68db-412c-8cef-ed2992ec3a41	picture	user.attribute
778cee48-68db-412c-8cef-ed2992ec3a41	true	id.token.claim
778cee48-68db-412c-8cef-ed2992ec3a41	true	access.token.claim
778cee48-68db-412c-8cef-ed2992ec3a41	picture	claim.name
778cee48-68db-412c-8cef-ed2992ec3a41	String	jsonType.label
9b8af3ce-e6be-4ced-9f47-a577ee3e80c9	true	introspection.token.claim
9b8af3ce-e6be-4ced-9f47-a577ee3e80c9	true	userinfo.token.claim
9b8af3ce-e6be-4ced-9f47-a577ee3e80c9	gender	user.attribute
9b8af3ce-e6be-4ced-9f47-a577ee3e80c9	true	id.token.claim
9b8af3ce-e6be-4ced-9f47-a577ee3e80c9	true	access.token.claim
9b8af3ce-e6be-4ced-9f47-a577ee3e80c9	gender	claim.name
9b8af3ce-e6be-4ced-9f47-a577ee3e80c9	String	jsonType.label
a2a17ff4-92b2-4ecc-83cd-326290c6ffd1	true	introspection.token.claim
a2a17ff4-92b2-4ecc-83cd-326290c6ffd1	true	userinfo.token.claim
a2a17ff4-92b2-4ecc-83cd-326290c6ffd1	website	user.attribute
a2a17ff4-92b2-4ecc-83cd-326290c6ffd1	true	id.token.claim
a2a17ff4-92b2-4ecc-83cd-326290c6ffd1	true	access.token.claim
a2a17ff4-92b2-4ecc-83cd-326290c6ffd1	website	claim.name
a2a17ff4-92b2-4ecc-83cd-326290c6ffd1	String	jsonType.label
b812cb64-43d7-457f-be25-27afb5a8ddc4	true	introspection.token.claim
b812cb64-43d7-457f-be25-27afb5a8ddc4	true	userinfo.token.claim
b812cb64-43d7-457f-be25-27afb5a8ddc4	nickname	user.attribute
b812cb64-43d7-457f-be25-27afb5a8ddc4	true	id.token.claim
b812cb64-43d7-457f-be25-27afb5a8ddc4	true	access.token.claim
b812cb64-43d7-457f-be25-27afb5a8ddc4	nickname	claim.name
b812cb64-43d7-457f-be25-27afb5a8ddc4	String	jsonType.label
c5af2ba4-9df8-4c2d-875d-81d7488ed2bc	true	introspection.token.claim
c5af2ba4-9df8-4c2d-875d-81d7488ed2bc	true	userinfo.token.claim
c5af2ba4-9df8-4c2d-875d-81d7488ed2bc	username	user.attribute
c5af2ba4-9df8-4c2d-875d-81d7488ed2bc	true	id.token.claim
c5af2ba4-9df8-4c2d-875d-81d7488ed2bc	true	access.token.claim
c5af2ba4-9df8-4c2d-875d-81d7488ed2bc	preferred_username	claim.name
c5af2ba4-9df8-4c2d-875d-81d7488ed2bc	String	jsonType.label
c7101307-0a0a-4539-a6eb-8c02300b5e77	true	introspection.token.claim
c7101307-0a0a-4539-a6eb-8c02300b5e77	true	userinfo.token.claim
c7101307-0a0a-4539-a6eb-8c02300b5e77	lastName	user.attribute
c7101307-0a0a-4539-a6eb-8c02300b5e77	true	id.token.claim
c7101307-0a0a-4539-a6eb-8c02300b5e77	true	access.token.claim
c7101307-0a0a-4539-a6eb-8c02300b5e77	family_name	claim.name
c7101307-0a0a-4539-a6eb-8c02300b5e77	String	jsonType.label
de308fe1-bfae-49fd-9b40-ff50ba9b4357	true	introspection.token.claim
de308fe1-bfae-49fd-9b40-ff50ba9b4357	true	userinfo.token.claim
de308fe1-bfae-49fd-9b40-ff50ba9b4357	updatedAt	user.attribute
de308fe1-bfae-49fd-9b40-ff50ba9b4357	true	id.token.claim
de308fe1-bfae-49fd-9b40-ff50ba9b4357	true	access.token.claim
de308fe1-bfae-49fd-9b40-ff50ba9b4357	updated_at	claim.name
de308fe1-bfae-49fd-9b40-ff50ba9b4357	long	jsonType.label
eee37f25-a61c-4dda-805e-9ee7e077237a	true	introspection.token.claim
eee37f25-a61c-4dda-805e-9ee7e077237a	true	userinfo.token.claim
eee37f25-a61c-4dda-805e-9ee7e077237a	middleName	user.attribute
eee37f25-a61c-4dda-805e-9ee7e077237a	true	id.token.claim
eee37f25-a61c-4dda-805e-9ee7e077237a	true	access.token.claim
eee37f25-a61c-4dda-805e-9ee7e077237a	middle_name	claim.name
eee37f25-a61c-4dda-805e-9ee7e077237a	String	jsonType.label
76a3ab14-d744-40ae-b5a8-0426cd272e80	true	introspection.token.claim
76a3ab14-d744-40ae-b5a8-0426cd272e80	true	userinfo.token.claim
76a3ab14-d744-40ae-b5a8-0426cd272e80	email	user.attribute
76a3ab14-d744-40ae-b5a8-0426cd272e80	true	id.token.claim
76a3ab14-d744-40ae-b5a8-0426cd272e80	true	access.token.claim
76a3ab14-d744-40ae-b5a8-0426cd272e80	email	claim.name
76a3ab14-d744-40ae-b5a8-0426cd272e80	String	jsonType.label
92b2fdff-cdb1-44da-933d-622217d2ff06	true	introspection.token.claim
92b2fdff-cdb1-44da-933d-622217d2ff06	true	userinfo.token.claim
92b2fdff-cdb1-44da-933d-622217d2ff06	emailVerified	user.attribute
92b2fdff-cdb1-44da-933d-622217d2ff06	true	id.token.claim
92b2fdff-cdb1-44da-933d-622217d2ff06	true	access.token.claim
92b2fdff-cdb1-44da-933d-622217d2ff06	email_verified	claim.name
92b2fdff-cdb1-44da-933d-622217d2ff06	boolean	jsonType.label
aa66d39b-3bcf-4120-8370-d55918ccb689	formatted	user.attribute.formatted
aa66d39b-3bcf-4120-8370-d55918ccb689	country	user.attribute.country
aa66d39b-3bcf-4120-8370-d55918ccb689	true	introspection.token.claim
aa66d39b-3bcf-4120-8370-d55918ccb689	postal_code	user.attribute.postal_code
aa66d39b-3bcf-4120-8370-d55918ccb689	true	userinfo.token.claim
aa66d39b-3bcf-4120-8370-d55918ccb689	street	user.attribute.street
aa66d39b-3bcf-4120-8370-d55918ccb689	true	id.token.claim
aa66d39b-3bcf-4120-8370-d55918ccb689	region	user.attribute.region
aa66d39b-3bcf-4120-8370-d55918ccb689	true	access.token.claim
aa66d39b-3bcf-4120-8370-d55918ccb689	locality	user.attribute.locality
e39e5595-62eb-4c0f-b423-b2932cca92db	true	introspection.token.claim
e39e5595-62eb-4c0f-b423-b2932cca92db	true	userinfo.token.claim
e39e5595-62eb-4c0f-b423-b2932cca92db	phoneNumberVerified	user.attribute
e39e5595-62eb-4c0f-b423-b2932cca92db	true	id.token.claim
e39e5595-62eb-4c0f-b423-b2932cca92db	true	access.token.claim
e39e5595-62eb-4c0f-b423-b2932cca92db	phone_number_verified	claim.name
e39e5595-62eb-4c0f-b423-b2932cca92db	boolean	jsonType.label
f11567e2-c53b-4600-8ebf-d4d2b8c56ba0	true	introspection.token.claim
f11567e2-c53b-4600-8ebf-d4d2b8c56ba0	true	userinfo.token.claim
f11567e2-c53b-4600-8ebf-d4d2b8c56ba0	phoneNumber	user.attribute
f11567e2-c53b-4600-8ebf-d4d2b8c56ba0	true	id.token.claim
f11567e2-c53b-4600-8ebf-d4d2b8c56ba0	true	access.token.claim
f11567e2-c53b-4600-8ebf-d4d2b8c56ba0	phone_number	claim.name
f11567e2-c53b-4600-8ebf-d4d2b8c56ba0	String	jsonType.label
527c9e4e-207c-4958-960e-a3700250596b	true	introspection.token.claim
527c9e4e-207c-4958-960e-a3700250596b	true	multivalued
527c9e4e-207c-4958-960e-a3700250596b	foo	user.attribute
527c9e4e-207c-4958-960e-a3700250596b	true	access.token.claim
527c9e4e-207c-4958-960e-a3700250596b	realm_access.roles	claim.name
527c9e4e-207c-4958-960e-a3700250596b	String	jsonType.label
5977026f-63fa-49fa-8199-ef1836218980	true	introspection.token.claim
5977026f-63fa-49fa-8199-ef1836218980	true	access.token.claim
ab6b6be3-4996-463d-9735-00e6d34149d4	true	introspection.token.claim
ab6b6be3-4996-463d-9735-00e6d34149d4	true	multivalued
ab6b6be3-4996-463d-9735-00e6d34149d4	foo	user.attribute
ab6b6be3-4996-463d-9735-00e6d34149d4	true	access.token.claim
ab6b6be3-4996-463d-9735-00e6d34149d4	resource_access.${client_id}.roles	claim.name
ab6b6be3-4996-463d-9735-00e6d34149d4	String	jsonType.label
32dc9fca-2b73-4616-bb91-938ad664cd0c	true	introspection.token.claim
32dc9fca-2b73-4616-bb91-938ad664cd0c	true	access.token.claim
3062ea3a-9c44-45a7-8ff2-81dd9c513ae5	true	introspection.token.claim
3062ea3a-9c44-45a7-8ff2-81dd9c513ae5	true	userinfo.token.claim
3062ea3a-9c44-45a7-8ff2-81dd9c513ae5	username	user.attribute
3062ea3a-9c44-45a7-8ff2-81dd9c513ae5	true	id.token.claim
3062ea3a-9c44-45a7-8ff2-81dd9c513ae5	true	access.token.claim
3062ea3a-9c44-45a7-8ff2-81dd9c513ae5	upn	claim.name
3062ea3a-9c44-45a7-8ff2-81dd9c513ae5	String	jsonType.label
67b80b3e-1f69-4729-85e5-c8a417a28042	true	introspection.token.claim
67b80b3e-1f69-4729-85e5-c8a417a28042	true	multivalued
67b80b3e-1f69-4729-85e5-c8a417a28042	foo	user.attribute
67b80b3e-1f69-4729-85e5-c8a417a28042	true	id.token.claim
67b80b3e-1f69-4729-85e5-c8a417a28042	true	access.token.claim
67b80b3e-1f69-4729-85e5-c8a417a28042	groups	claim.name
67b80b3e-1f69-4729-85e5-c8a417a28042	String	jsonType.label
a9922c7d-b179-4179-a8ea-3125763d7c2d	true	introspection.token.claim
a9922c7d-b179-4179-a8ea-3125763d7c2d	true	id.token.claim
a9922c7d-b179-4179-a8ea-3125763d7c2d	true	access.token.claim
609a843b-fadd-4a42-8ba1-588ee35b4111	true	introspection.token.claim
609a843b-fadd-4a42-8ba1-588ee35b4111	true	userinfo.token.claim
609a843b-fadd-4a42-8ba1-588ee35b4111	locale	user.attribute
609a843b-fadd-4a42-8ba1-588ee35b4111	true	id.token.claim
609a843b-fadd-4a42-8ba1-588ee35b4111	true	access.token.claim
609a843b-fadd-4a42-8ba1-588ee35b4111	locale	claim.name
609a843b-fadd-4a42-8ba1-588ee35b4111	String	jsonType.label
1dad7b5c-d41e-4452-b2d4-12a26a421b59	false	single
1dad7b5c-d41e-4452-b2d4-12a26a421b59	Basic	attribute.nameformat
1dad7b5c-d41e-4452-b2d4-12a26a421b59	Role	attribute.name
04e8d6e5-8f8d-4244-8f34-19709bd9ef08	true	introspection.token.claim
04e8d6e5-8f8d-4244-8f34-19709bd9ef08	true	userinfo.token.claim
04e8d6e5-8f8d-4244-8f34-19709bd9ef08	locale	user.attribute
04e8d6e5-8f8d-4244-8f34-19709bd9ef08	true	id.token.claim
04e8d6e5-8f8d-4244-8f34-19709bd9ef08	true	access.token.claim
04e8d6e5-8f8d-4244-8f34-19709bd9ef08	locale	claim.name
04e8d6e5-8f8d-4244-8f34-19709bd9ef08	String	jsonType.label
0b80f305-b494-4d79-8a48-4854fd454355	true	introspection.token.claim
0b80f305-b494-4d79-8a48-4854fd454355	true	userinfo.token.claim
0b80f305-b494-4d79-8a48-4854fd454355	middleName	user.attribute
0b80f305-b494-4d79-8a48-4854fd454355	true	id.token.claim
0b80f305-b494-4d79-8a48-4854fd454355	true	access.token.claim
0b80f305-b494-4d79-8a48-4854fd454355	middle_name	claim.name
0b80f305-b494-4d79-8a48-4854fd454355	String	jsonType.label
13b9cce0-9520-4827-b3c4-95bd3f38c629	true	introspection.token.claim
13b9cce0-9520-4827-b3c4-95bd3f38c629	true	userinfo.token.claim
13b9cce0-9520-4827-b3c4-95bd3f38c629	lastName	user.attribute
13b9cce0-9520-4827-b3c4-95bd3f38c629	true	id.token.claim
13b9cce0-9520-4827-b3c4-95bd3f38c629	true	access.token.claim
13b9cce0-9520-4827-b3c4-95bd3f38c629	family_name	claim.name
13b9cce0-9520-4827-b3c4-95bd3f38c629	String	jsonType.label
284ca781-d8c6-4b02-a23a-5f2efb22eb34	true	introspection.token.claim
284ca781-d8c6-4b02-a23a-5f2efb22eb34	true	userinfo.token.claim
284ca781-d8c6-4b02-a23a-5f2efb22eb34	picture	user.attribute
284ca781-d8c6-4b02-a23a-5f2efb22eb34	true	id.token.claim
284ca781-d8c6-4b02-a23a-5f2efb22eb34	true	access.token.claim
284ca781-d8c6-4b02-a23a-5f2efb22eb34	picture	claim.name
284ca781-d8c6-4b02-a23a-5f2efb22eb34	String	jsonType.label
565ca273-1285-4fde-89a1-ba3444c86396	true	introspection.token.claim
565ca273-1285-4fde-89a1-ba3444c86396	true	userinfo.token.claim
565ca273-1285-4fde-89a1-ba3444c86396	true	id.token.claim
565ca273-1285-4fde-89a1-ba3444c86396	true	access.token.claim
597f2f70-16b3-4dd2-9b07-a33eea41b182	true	introspection.token.claim
597f2f70-16b3-4dd2-9b07-a33eea41b182	true	userinfo.token.claim
597f2f70-16b3-4dd2-9b07-a33eea41b182	firstName	user.attribute
597f2f70-16b3-4dd2-9b07-a33eea41b182	true	id.token.claim
597f2f70-16b3-4dd2-9b07-a33eea41b182	true	access.token.claim
597f2f70-16b3-4dd2-9b07-a33eea41b182	given_name	claim.name
597f2f70-16b3-4dd2-9b07-a33eea41b182	String	jsonType.label
665533c7-bfbe-419f-a39b-4d07de0e9969	true	introspection.token.claim
665533c7-bfbe-419f-a39b-4d07de0e9969	true	userinfo.token.claim
665533c7-bfbe-419f-a39b-4d07de0e9969	updatedAt	user.attribute
665533c7-bfbe-419f-a39b-4d07de0e9969	true	id.token.claim
665533c7-bfbe-419f-a39b-4d07de0e9969	true	access.token.claim
665533c7-bfbe-419f-a39b-4d07de0e9969	updated_at	claim.name
665533c7-bfbe-419f-a39b-4d07de0e9969	long	jsonType.label
7628b0f4-ced6-4ef6-a9fd-34fbe3dd39dc	true	introspection.token.claim
7628b0f4-ced6-4ef6-a9fd-34fbe3dd39dc	true	userinfo.token.claim
7628b0f4-ced6-4ef6-a9fd-34fbe3dd39dc	website	user.attribute
7628b0f4-ced6-4ef6-a9fd-34fbe3dd39dc	true	id.token.claim
7628b0f4-ced6-4ef6-a9fd-34fbe3dd39dc	true	access.token.claim
7628b0f4-ced6-4ef6-a9fd-34fbe3dd39dc	website	claim.name
7628b0f4-ced6-4ef6-a9fd-34fbe3dd39dc	String	jsonType.label
ac861c55-2924-43e4-8e6c-dd8596f256ad	true	introspection.token.claim
ac861c55-2924-43e4-8e6c-dd8596f256ad	true	userinfo.token.claim
ac861c55-2924-43e4-8e6c-dd8596f256ad	zoneinfo	user.attribute
ac861c55-2924-43e4-8e6c-dd8596f256ad	true	id.token.claim
ac861c55-2924-43e4-8e6c-dd8596f256ad	true	access.token.claim
ac861c55-2924-43e4-8e6c-dd8596f256ad	zoneinfo	claim.name
ac861c55-2924-43e4-8e6c-dd8596f256ad	String	jsonType.label
b0ed88d9-1a0b-486a-8ffa-a54b56557b5b	true	introspection.token.claim
b0ed88d9-1a0b-486a-8ffa-a54b56557b5b	true	userinfo.token.claim
b0ed88d9-1a0b-486a-8ffa-a54b56557b5b	gender	user.attribute
b0ed88d9-1a0b-486a-8ffa-a54b56557b5b	true	id.token.claim
b0ed88d9-1a0b-486a-8ffa-a54b56557b5b	true	access.token.claim
b0ed88d9-1a0b-486a-8ffa-a54b56557b5b	gender	claim.name
b0ed88d9-1a0b-486a-8ffa-a54b56557b5b	String	jsonType.label
ce96c8da-ed38-42f1-829e-ca780429737d	true	introspection.token.claim
ce96c8da-ed38-42f1-829e-ca780429737d	true	userinfo.token.claim
ce96c8da-ed38-42f1-829e-ca780429737d	profile	user.attribute
ce96c8da-ed38-42f1-829e-ca780429737d	true	id.token.claim
ce96c8da-ed38-42f1-829e-ca780429737d	true	access.token.claim
ce96c8da-ed38-42f1-829e-ca780429737d	profile	claim.name
ce96c8da-ed38-42f1-829e-ca780429737d	String	jsonType.label
d1d8160e-7e02-445e-90fa-34165706c88d	true	introspection.token.claim
d1d8160e-7e02-445e-90fa-34165706c88d	true	userinfo.token.claim
d1d8160e-7e02-445e-90fa-34165706c88d	username	user.attribute
d1d8160e-7e02-445e-90fa-34165706c88d	true	id.token.claim
d1d8160e-7e02-445e-90fa-34165706c88d	true	access.token.claim
d1d8160e-7e02-445e-90fa-34165706c88d	preferred_username	claim.name
d1d8160e-7e02-445e-90fa-34165706c88d	String	jsonType.label
ed594df8-3555-4cc4-8578-e39fa473943d	true	introspection.token.claim
ed594df8-3555-4cc4-8578-e39fa473943d	true	userinfo.token.claim
ed594df8-3555-4cc4-8578-e39fa473943d	birthdate	user.attribute
ed594df8-3555-4cc4-8578-e39fa473943d	true	id.token.claim
ed594df8-3555-4cc4-8578-e39fa473943d	true	access.token.claim
ed594df8-3555-4cc4-8578-e39fa473943d	birthdate	claim.name
ed594df8-3555-4cc4-8578-e39fa473943d	String	jsonType.label
ff3f717f-a6a9-4ef2-82b2-f8b9928655da	true	introspection.token.claim
ff3f717f-a6a9-4ef2-82b2-f8b9928655da	true	userinfo.token.claim
ff3f717f-a6a9-4ef2-82b2-f8b9928655da	nickname	user.attribute
ff3f717f-a6a9-4ef2-82b2-f8b9928655da	true	id.token.claim
ff3f717f-a6a9-4ef2-82b2-f8b9928655da	true	access.token.claim
ff3f717f-a6a9-4ef2-82b2-f8b9928655da	nickname	claim.name
ff3f717f-a6a9-4ef2-82b2-f8b9928655da	String	jsonType.label
6f87ccb7-1f07-414c-8ce4-670c5fdfd725	true	introspection.token.claim
6f87ccb7-1f07-414c-8ce4-670c5fdfd725	true	userinfo.token.claim
6f87ccb7-1f07-414c-8ce4-670c5fdfd725	emailVerified	user.attribute
6f87ccb7-1f07-414c-8ce4-670c5fdfd725	true	id.token.claim
6f87ccb7-1f07-414c-8ce4-670c5fdfd725	true	access.token.claim
6f87ccb7-1f07-414c-8ce4-670c5fdfd725	email_verified	claim.name
6f87ccb7-1f07-414c-8ce4-670c5fdfd725	boolean	jsonType.label
cd7b8715-c904-43d4-8b54-9787bed9b799	true	introspection.token.claim
cd7b8715-c904-43d4-8b54-9787bed9b799	true	userinfo.token.claim
cd7b8715-c904-43d4-8b54-9787bed9b799	email	user.attribute
cd7b8715-c904-43d4-8b54-9787bed9b799	true	id.token.claim
cd7b8715-c904-43d4-8b54-9787bed9b799	true	access.token.claim
cd7b8715-c904-43d4-8b54-9787bed9b799	email	claim.name
cd7b8715-c904-43d4-8b54-9787bed9b799	String	jsonType.label
fa4d17f2-f9d2-4b13-8ed4-7d4f888bd911	formatted	user.attribute.formatted
fa4d17f2-f9d2-4b13-8ed4-7d4f888bd911	country	user.attribute.country
fa4d17f2-f9d2-4b13-8ed4-7d4f888bd911	true	introspection.token.claim
fa4d17f2-f9d2-4b13-8ed4-7d4f888bd911	postal_code	user.attribute.postal_code
fa4d17f2-f9d2-4b13-8ed4-7d4f888bd911	true	userinfo.token.claim
fa4d17f2-f9d2-4b13-8ed4-7d4f888bd911	street	user.attribute.street
fa4d17f2-f9d2-4b13-8ed4-7d4f888bd911	true	id.token.claim
fa4d17f2-f9d2-4b13-8ed4-7d4f888bd911	region	user.attribute.region
fa4d17f2-f9d2-4b13-8ed4-7d4f888bd911	true	access.token.claim
fa4d17f2-f9d2-4b13-8ed4-7d4f888bd911	locality	user.attribute.locality
681de82e-7d4d-402f-a912-ff374a351672	true	introspection.token.claim
681de82e-7d4d-402f-a912-ff374a351672	true	userinfo.token.claim
681de82e-7d4d-402f-a912-ff374a351672	phoneNumber	user.attribute
681de82e-7d4d-402f-a912-ff374a351672	true	id.token.claim
681de82e-7d4d-402f-a912-ff374a351672	true	access.token.claim
681de82e-7d4d-402f-a912-ff374a351672	phone_number	claim.name
681de82e-7d4d-402f-a912-ff374a351672	String	jsonType.label
bd44bf8c-4a93-452c-94ac-7500bf5d3c23	true	introspection.token.claim
bd44bf8c-4a93-452c-94ac-7500bf5d3c23	true	userinfo.token.claim
bd44bf8c-4a93-452c-94ac-7500bf5d3c23	phoneNumberVerified	user.attribute
bd44bf8c-4a93-452c-94ac-7500bf5d3c23	true	id.token.claim
bd44bf8c-4a93-452c-94ac-7500bf5d3c23	true	access.token.claim
bd44bf8c-4a93-452c-94ac-7500bf5d3c23	phone_number_verified	claim.name
bd44bf8c-4a93-452c-94ac-7500bf5d3c23	boolean	jsonType.label
09c30085-7cb1-4daa-95f8-c5e33c6186ec	true	introspection.token.claim
09c30085-7cb1-4daa-95f8-c5e33c6186ec	true	multivalued
09c30085-7cb1-4daa-95f8-c5e33c6186ec	foo	user.attribute
09c30085-7cb1-4daa-95f8-c5e33c6186ec	true	access.token.claim
09c30085-7cb1-4daa-95f8-c5e33c6186ec	resource_access.${client_id}.roles	claim.name
09c30085-7cb1-4daa-95f8-c5e33c6186ec	String	jsonType.label
4dc2546b-6b54-4e11-8436-fef4f029c837	true	introspection.token.claim
4dc2546b-6b54-4e11-8436-fef4f029c837	true	access.token.claim
d249e9c0-06ed-46a0-a932-8549c90d60f0	true	introspection.token.claim
d249e9c0-06ed-46a0-a932-8549c90d60f0	true	multivalued
d249e9c0-06ed-46a0-a932-8549c90d60f0	foo	user.attribute
d249e9c0-06ed-46a0-a932-8549c90d60f0	true	access.token.claim
d249e9c0-06ed-46a0-a932-8549c90d60f0	realm_access.roles	claim.name
d249e9c0-06ed-46a0-a932-8549c90d60f0	String	jsonType.label
06555e4c-43d1-4429-8c53-d38d22c62077	true	introspection.token.claim
06555e4c-43d1-4429-8c53-d38d22c62077	true	access.token.claim
5b588cc9-80b7-4868-b80a-14966be22ed4	true	introspection.token.claim
5b588cc9-80b7-4868-b80a-14966be22ed4	true	multivalued
5b588cc9-80b7-4868-b80a-14966be22ed4	foo	user.attribute
5b588cc9-80b7-4868-b80a-14966be22ed4	true	id.token.claim
5b588cc9-80b7-4868-b80a-14966be22ed4	true	access.token.claim
5b588cc9-80b7-4868-b80a-14966be22ed4	groups	claim.name
5b588cc9-80b7-4868-b80a-14966be22ed4	String	jsonType.label
d0bb618e-a9a6-489d-bf33-f95e4befe573	true	introspection.token.claim
d0bb618e-a9a6-489d-bf33-f95e4befe573	true	userinfo.token.claim
d0bb618e-a9a6-489d-bf33-f95e4befe573	username	user.attribute
d0bb618e-a9a6-489d-bf33-f95e4befe573	true	id.token.claim
d0bb618e-a9a6-489d-bf33-f95e4befe573	true	access.token.claim
d0bb618e-a9a6-489d-bf33-f95e4befe573	upn	claim.name
d0bb618e-a9a6-489d-bf33-f95e4befe573	String	jsonType.label
82c93633-2ef1-473a-b6a1-5daf5ae79bbd	true	introspection.token.claim
82c93633-2ef1-473a-b6a1-5daf5ae79bbd	true	id.token.claim
82c93633-2ef1-473a-b6a1-5daf5ae79bbd	true	access.token.claim
03e0a754-7e4f-4318-808e-d4d62e4ffbc5	true	introspection.token.claim
03e0a754-7e4f-4318-808e-d4d62e4ffbc5	true	userinfo.token.claim
03e0a754-7e4f-4318-808e-d4d62e4ffbc5	locale	user.attribute
03e0a754-7e4f-4318-808e-d4d62e4ffbc5	true	id.token.claim
03e0a754-7e4f-4318-808e-d4d62e4ffbc5	true	access.token.claim
03e0a754-7e4f-4318-808e-d4d62e4ffbc5	locale	claim.name
03e0a754-7e4f-4318-808e-d4d62e4ffbc5	String	jsonType.label
482f9b53-0935-4820-a492-feecbbb9b105	true	introspection.token.claim
482f9b53-0935-4820-a492-feecbbb9b105	true	userinfo.token.claim
482f9b53-0935-4820-a492-feecbbb9b105	emailOptIn	user.attribute
482f9b53-0935-4820-a492-feecbbb9b105	true	id.token.claim
482f9b53-0935-4820-a492-feecbbb9b105	false	lightweight.claim
482f9b53-0935-4820-a492-feecbbb9b105	true	access.token.claim
482f9b53-0935-4820-a492-feecbbb9b105	emailOptIn	claim.name
482f9b53-0935-4820-a492-feecbbb9b105	int	jsonType.label
92380b59-56eb-4427-b957-30d122fd9943	true	introspection.token.claim
92380b59-56eb-4427-b957-30d122fd9943	true	userinfo.token.claim
92380b59-56eb-4427-b957-30d122fd9943	fullName	user.attribute
92380b59-56eb-4427-b957-30d122fd9943	true	id.token.claim
92380b59-56eb-4427-b957-30d122fd9943	false	lightweight.claim
92380b59-56eb-4427-b957-30d122fd9943	true	access.token.claim
92380b59-56eb-4427-b957-30d122fd9943	fullName	claim.name
92380b59-56eb-4427-b957-30d122fd9943	String	jsonType.label
242f2fa5-41fe-41d2-bd51-09593d288911	AUTH_TIME	user.session.note
242f2fa5-41fe-41d2-bd51-09593d288911	true	introspection.token.claim
242f2fa5-41fe-41d2-bd51-09593d288911	true	id.token.claim
242f2fa5-41fe-41d2-bd51-09593d288911	true	access.token.claim
242f2fa5-41fe-41d2-bd51-09593d288911	auth_time	claim.name
242f2fa5-41fe-41d2-bd51-09593d288911	long	jsonType.label
5b0e35aa-bf5b-44c5-bd6b-8a81f120fff7	true	introspection.token.claim
5b0e35aa-bf5b-44c5-bd6b-8a81f120fff7	true	access.token.claim
1d0f4bc2-ecf8-4749-878f-ee25075ceff6	AUTH_TIME	user.session.note
1d0f4bc2-ecf8-4749-878f-ee25075ceff6	true	introspection.token.claim
1d0f4bc2-ecf8-4749-878f-ee25075ceff6	true	id.token.claim
1d0f4bc2-ecf8-4749-878f-ee25075ceff6	true	access.token.claim
1d0f4bc2-ecf8-4749-878f-ee25075ceff6	auth_time	claim.name
1d0f4bc2-ecf8-4749-878f-ee25075ceff6	long	jsonType.label
bd9a8289-2e89-45e4-9d51-ef7d99b485b2	true	introspection.token.claim
bd9a8289-2e89-45e4-9d51-ef7d99b485b2	true	access.token.claim
13312910-e27a-4b8c-974b-d2b4f8349393	AUTH_TIME	user.session.note
13312910-e27a-4b8c-974b-d2b4f8349393	true	introspection.token.claim
13312910-e27a-4b8c-974b-d2b4f8349393	true	id.token.claim
13312910-e27a-4b8c-974b-d2b4f8349393	true	access.token.claim
13312910-e27a-4b8c-974b-d2b4f8349393	auth_time	claim.name
13312910-e27a-4b8c-974b-d2b4f8349393	long	jsonType.label
d3246769-c8fa-4e42-9c18-c240ff010259	true	introspection.token.claim
d3246769-c8fa-4e42-9c18-c240ff010259	true	access.token.claim
94fac029-774d-4160-9fb3-60f385db20a4	AUTH_TIME	user.session.note
94fac029-774d-4160-9fb3-60f385db20a4	true	introspection.token.claim
94fac029-774d-4160-9fb3-60f385db20a4	true	id.token.claim
94fac029-774d-4160-9fb3-60f385db20a4	true	access.token.claim
94fac029-774d-4160-9fb3-60f385db20a4	auth_time	claim.name
94fac029-774d-4160-9fb3-60f385db20a4	long	jsonType.label
9ea96afe-9fbc-4dd8-a2c9-84912d64f033	true	introspection.token.claim
9ea96afe-9fbc-4dd8-a2c9-84912d64f033	true	access.token.claim
7bee9df0-1d9f-4fae-a7a4-3c0f8dde6965	true	introspection.token.claim
7bee9df0-1d9f-4fae-a7a4-3c0f8dde6965	true	access.token.claim
b44646d3-c973-4733-9f4d-bcfc9682307a	AUTH_TIME	user.session.note
b44646d3-c973-4733-9f4d-bcfc9682307a	true	introspection.token.claim
b44646d3-c973-4733-9f4d-bcfc9682307a	true	id.token.claim
b44646d3-c973-4733-9f4d-bcfc9682307a	true	access.token.claim
b44646d3-c973-4733-9f4d-bcfc9682307a	auth_time	claim.name
b44646d3-c973-4733-9f4d-bcfc9682307a	long	jsonType.label
24a305cb-3d70-42f6-8dfa-9230e9fecb43	client_id	user.session.note
24a305cb-3d70-42f6-8dfa-9230e9fecb43	true	introspection.token.claim
24a305cb-3d70-42f6-8dfa-9230e9fecb43	true	id.token.claim
24a305cb-3d70-42f6-8dfa-9230e9fecb43	true	access.token.claim
24a305cb-3d70-42f6-8dfa-9230e9fecb43	client_id	claim.name
24a305cb-3d70-42f6-8dfa-9230e9fecb43	String	jsonType.label
9a698d26-5e60-4a0e-bf1f-8614156771b2	clientHost	user.session.note
9a698d26-5e60-4a0e-bf1f-8614156771b2	true	introspection.token.claim
9a698d26-5e60-4a0e-bf1f-8614156771b2	true	id.token.claim
9a698d26-5e60-4a0e-bf1f-8614156771b2	true	access.token.claim
9a698d26-5e60-4a0e-bf1f-8614156771b2	clientHost	claim.name
9a698d26-5e60-4a0e-bf1f-8614156771b2	String	jsonType.label
c67657db-2363-413b-8824-2e1ae6fea7c6	clientAddress	user.session.note
c67657db-2363-413b-8824-2e1ae6fea7c6	true	introspection.token.claim
c67657db-2363-413b-8824-2e1ae6fea7c6	true	id.token.claim
c67657db-2363-413b-8824-2e1ae6fea7c6	true	access.token.claim
c67657db-2363-413b-8824-2e1ae6fea7c6	clientAddress	claim.name
c67657db-2363-413b-8824-2e1ae6fea7c6	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
f493d84c-5308-498f-afec-c6f4cfffd553	60	300	60	keycloak.v3	keycloak.v2	keycloak	t	f	0	keycloak.v2	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	80b8e421-a8d0-48c7-a471-5bdddf12de86	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	0ba17251-efd0-427d-9ab0-dae4e934a40d	3ae0a9e7-1c33-405f-bf5b-07af9ab31bb8	66c83497-7f4f-4bb2-a963-f712f4519120	eb164f98-3325-4540-9bf5-3f67e99ed183	d0f014fa-0d88-4543-be77-3dedab5e93dc	2592000	f	900	t	f	fe1910a0-ce2a-455c-ac27-b4054141d4ae	0	f	0	0	8eaee4b4-db59-489b-9ce3-217077d760ff
2256a568-ee44-4cb6-88fa-488d343b1bf5	60	300	300	\N	\N	\N	t	f	0	\N	test2	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	8fa603a5-4abf-42c7-8f8d-179bcd0d1820	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	f17fdeb3-6313-4e32-b352-6bf19c7de8a3	f9646b25-951c-499a-b3e6-bbdd07948b20	4240e704-7d9f-4071-8327-2979a9fad2ed	9f4f1ea1-68c2-44f2-ad65-f8d9f1868263	f8606255-568a-4266-aacf-006de0f0d009	2592000	f	900	t	f	0fd2b968-fe02-4967-982f-6c4c738c094c	0	f	0	0	aa1e55eb-ef79-4e0a-8817-2e8cd9ff6441
429ce2ec-99a2-44b6-9c27-36b18f46b8d3	60	300	300	\N	\N	\N	t	f	0	\N	test	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	854ad7cd-1eff-40da-870d-00e3dc34ceb0	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	12bb5f70-be1c-41cc-a773-70988d0d987e	be18abc9-79c3-44ea-b6b2-139dbc7db299	9c193f5c-a7ac-4007-ae6d-d84b2f1bfafc	216b8618-d4fc-4e7f-acec-cfe05025e7b6	115afaed-6d8f-4712-bdca-8b5aa323c6f1	2592000	f	900	t	f	4e4e75e6-cef2-47f1-ba83-b62acdb75f58	0	f	0	0	dc580ac0-3400-493e-b4e9-45350ffeb879
b4825e08-1ac5-43e9-990a-7556e882153a	60	300	300	\N	\N	\N	t	f	0	\N	test1	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	4260b713-6bb7-4cb2-9790-fe665558ba00	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	49945d46-dd92-4440-a7b4-553a1a9d68d5	3620b83e-2ca5-4721-83a6-ca16a73f7f3f	05fca361-73f0-4aea-9236-0a7b40610856	e1889b1c-067a-42d2-a4fa-184690cc575f	32ba0404-77e1-45e1-a1a2-40393f8dc0f9	2592000	f	900	t	f	7b75457a-c4c2-4bad-81e5-034f9357e58f	0	f	0	0	b848d658-ab02-420c-b827-c6c44cd852c4
5760f0e0-8dc4-453f-b407-19c01025187d	60	300	300			ol	t	t	86400	ol	olapps	0	\N	t	f	t	f	EXTERNAL	1800	36000	f	t	8695aa84-6272-4f88-bf3e-b4be5e55c8e8	1800	f	\N	t	t	t	f	0	1	30	6	HmacSHA1	totp	8f98653d-bc49-4b3c-b297-43d14d7840b4	e1786458-5657-4871-b724-3e97e5cf3c7f	8ec8ad2f-78c1-4b30-95c4-76bb0f48529f	982c10d6-5e7e-4365-bc73-b9255a2fce9c	987fb39d-dde7-4aa0-b100-c3ed19911cbd	2592000	f	900	t	f	5671c7ed-7dc1-44e9-b574-2687b5530130	0	f	0	0	25dc23c9-fc78-4647-97cd-149741a77307
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
bruteForceProtected	f493d84c-5308-498f-afec-c6f4cfffd553	false
permanentLockout	f493d84c-5308-498f-afec-c6f4cfffd553	false
maxTemporaryLockouts	f493d84c-5308-498f-afec-c6f4cfffd553	0
maxFailureWaitSeconds	f493d84c-5308-498f-afec-c6f4cfffd553	900
minimumQuickLoginWaitSeconds	f493d84c-5308-498f-afec-c6f4cfffd553	60
waitIncrementSeconds	f493d84c-5308-498f-afec-c6f4cfffd553	60
quickLoginCheckMilliSeconds	f493d84c-5308-498f-afec-c6f4cfffd553	1000
maxDeltaTimeSeconds	f493d84c-5308-498f-afec-c6f4cfffd553	43200
failureFactor	f493d84c-5308-498f-afec-c6f4cfffd553	30
realmReusableOtpCode	f493d84c-5308-498f-afec-c6f4cfffd553	false
firstBrokerLoginFlowId	f493d84c-5308-498f-afec-c6f4cfffd553	bec443cf-4bf5-4fb1-b3a3-a7ec90481f05
displayName	f493d84c-5308-498f-afec-c6f4cfffd553	Keycloak
displayNameHtml	f493d84c-5308-498f-afec-c6f4cfffd553	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	f493d84c-5308-498f-afec-c6f4cfffd553	RS256
offlineSessionMaxLifespanEnabled	f493d84c-5308-498f-afec-c6f4cfffd553	false
offlineSessionMaxLifespan	f493d84c-5308-498f-afec-c6f4cfffd553	5184000
bruteForceProtected	5760f0e0-8dc4-453f-b407-19c01025187d	false
permanentLockout	5760f0e0-8dc4-453f-b407-19c01025187d	false
maxTemporaryLockouts	5760f0e0-8dc4-453f-b407-19c01025187d	0
maxFailureWaitSeconds	5760f0e0-8dc4-453f-b407-19c01025187d	900
minimumQuickLoginWaitSeconds	5760f0e0-8dc4-453f-b407-19c01025187d	60
waitIncrementSeconds	5760f0e0-8dc4-453f-b407-19c01025187d	60
quickLoginCheckMilliSeconds	5760f0e0-8dc4-453f-b407-19c01025187d	1000
maxDeltaTimeSeconds	5760f0e0-8dc4-453f-b407-19c01025187d	43200
failureFactor	5760f0e0-8dc4-453f-b407-19c01025187d	30
realmReusableOtpCode	5760f0e0-8dc4-453f-b407-19c01025187d	false
defaultSignatureAlgorithm	5760f0e0-8dc4-453f-b407-19c01025187d	RS256
offlineSessionMaxLifespanEnabled	5760f0e0-8dc4-453f-b407-19c01025187d	false
offlineSessionMaxLifespan	5760f0e0-8dc4-453f-b407-19c01025187d	5184000
actionTokenGeneratedByAdminLifespan	5760f0e0-8dc4-453f-b407-19c01025187d	43200
actionTokenGeneratedByUserLifespan	5760f0e0-8dc4-453f-b407-19c01025187d	300
oauth2DeviceCodeLifespan	5760f0e0-8dc4-453f-b407-19c01025187d	600
oauth2DevicePollingInterval	5760f0e0-8dc4-453f-b407-19c01025187d	5
webAuthnPolicyRpEntityName	5760f0e0-8dc4-453f-b407-19c01025187d	keycloak
webAuthnPolicySignatureAlgorithms	5760f0e0-8dc4-453f-b407-19c01025187d	ES256
webAuthnPolicyRpId	5760f0e0-8dc4-453f-b407-19c01025187d	
webAuthnPolicyAttestationConveyancePreference	5760f0e0-8dc4-453f-b407-19c01025187d	not specified
webAuthnPolicyAuthenticatorAttachment	5760f0e0-8dc4-453f-b407-19c01025187d	not specified
webAuthnPolicyRequireResidentKey	5760f0e0-8dc4-453f-b407-19c01025187d	not specified
webAuthnPolicyUserVerificationRequirement	5760f0e0-8dc4-453f-b407-19c01025187d	not specified
webAuthnPolicyCreateTimeout	5760f0e0-8dc4-453f-b407-19c01025187d	0
webAuthnPolicyAvoidSameAuthenticatorRegister	5760f0e0-8dc4-453f-b407-19c01025187d	false
webAuthnPolicyRpEntityNamePasswordless	5760f0e0-8dc4-453f-b407-19c01025187d	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	5760f0e0-8dc4-453f-b407-19c01025187d	ES256
webAuthnPolicyRpIdPasswordless	5760f0e0-8dc4-453f-b407-19c01025187d	
webAuthnPolicyAttestationConveyancePreferencePasswordless	5760f0e0-8dc4-453f-b407-19c01025187d	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	5760f0e0-8dc4-453f-b407-19c01025187d	not specified
webAuthnPolicyRequireResidentKeyPasswordless	5760f0e0-8dc4-453f-b407-19c01025187d	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	5760f0e0-8dc4-453f-b407-19c01025187d	not specified
webAuthnPolicyCreateTimeoutPasswordless	5760f0e0-8dc4-453f-b407-19c01025187d	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	5760f0e0-8dc4-453f-b407-19c01025187d	false
cibaBackchannelTokenDeliveryMode	5760f0e0-8dc4-453f-b407-19c01025187d	poll
cibaExpiresIn	5760f0e0-8dc4-453f-b407-19c01025187d	120
cibaInterval	5760f0e0-8dc4-453f-b407-19c01025187d	5
cibaAuthRequestedUserHint	5760f0e0-8dc4-453f-b407-19c01025187d	login_hint
parRequestUriLifespan	5760f0e0-8dc4-453f-b407-19c01025187d	60
firstBrokerLoginFlowId	5760f0e0-8dc4-453f-b407-19c01025187d	182b2041-2e16-423a-9af7-e1c3a30d78f5
clientSessionIdleTimeout	5760f0e0-8dc4-453f-b407-19c01025187d	0
clientSessionMaxLifespan	5760f0e0-8dc4-453f-b407-19c01025187d	0
clientOfflineSessionIdleTimeout	5760f0e0-8dc4-453f-b407-19c01025187d	0
clientOfflineSessionMaxLifespan	5760f0e0-8dc4-453f-b407-19c01025187d	0
client-policies.profiles	5760f0e0-8dc4-453f-b407-19c01025187d	{"profiles":[]}
client-policies.policies	5760f0e0-8dc4-453f-b407-19c01025187d	{"policies":[]}
frontendUrl	5760f0e0-8dc4-453f-b407-19c01025187d	
acr.loa.map	5760f0e0-8dc4-453f-b407-19c01025187d	{}
displayName	5760f0e0-8dc4-453f-b407-19c01025187d	MIT Learn
displayNameHtml	5760f0e0-8dc4-453f-b407-19c01025187d	
olCanonicalHomeUrl	5760f0e0-8dc4-453f-b407-19c01025187d	http://open.odl.local:8062/
_browser_header.contentSecurityPolicyReportOnly	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	
_browser_header.xContentTypeOptions	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	nosniff
_browser_header.referrerPolicy	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	no-referrer
_browser_header.xRobotsTag	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	none
_browser_header.xFrameOptions	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	SAMEORIGIN
_browser_header.contentSecurityPolicy	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	1; mode=block
_browser_header.strictTransportSecurity	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	max-age=31536000; includeSubDomains
bruteForceProtected	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	false
permanentLockout	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	false
maxTemporaryLockouts	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	0
maxFailureWaitSeconds	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	900
minimumQuickLoginWaitSeconds	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	60
waitIncrementSeconds	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	60
quickLoginCheckMilliSeconds	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	1000
maxDeltaTimeSeconds	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	43200
failureFactor	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	30
realmReusableOtpCode	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	false
defaultSignatureAlgorithm	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	RS256
offlineSessionMaxLifespanEnabled	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	false
offlineSessionMaxLifespan	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	5184000
actionTokenGeneratedByAdminLifespan	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	43200
actionTokenGeneratedByUserLifespan	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	300
oauth2DeviceCodeLifespan	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	600
oauth2DevicePollingInterval	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	5
webAuthnPolicyRpEntityName	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	keycloak
webAuthnPolicySignatureAlgorithms	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	ES256
webAuthnPolicyRpId	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	
webAuthnPolicyAttestationConveyancePreference	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	not specified
webAuthnPolicyAuthenticatorAttachment	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	not specified
webAuthnPolicyRequireResidentKey	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	not specified
webAuthnPolicyUserVerificationRequirement	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	not specified
webAuthnPolicyCreateTimeout	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	0
webAuthnPolicyAvoidSameAuthenticatorRegister	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	false
webAuthnPolicyRpEntityNamePasswordless	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	ES256
webAuthnPolicyRpIdPasswordless	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	
webAuthnPolicyAttestationConveyancePreferencePasswordless	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	not specified
webAuthnPolicyRequireResidentKeyPasswordless	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	not specified
webAuthnPolicyCreateTimeoutPasswordless	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	false
cibaBackchannelTokenDeliveryMode	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	poll
cibaExpiresIn	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	120
cibaInterval	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	5
cibaAuthRequestedUserHint	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	login_hint
parRequestUriLifespan	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	60
firstBrokerLoginFlowId	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	836795b8-9f9e-44b8-96a6-5ef2cad92d9c
adminEventsExpiration	5760f0e0-8dc4-453f-b407-19c01025187d	86400
_browser_header.contentSecurityPolicyReportOnly	b4825e08-1ac5-43e9-990a-7556e882153a	
_browser_header.xContentTypeOptions	b4825e08-1ac5-43e9-990a-7556e882153a	nosniff
_browser_header.referrerPolicy	b4825e08-1ac5-43e9-990a-7556e882153a	no-referrer
_browser_header.xRobotsTag	b4825e08-1ac5-43e9-990a-7556e882153a	none
_browser_header.xFrameOptions	b4825e08-1ac5-43e9-990a-7556e882153a	SAMEORIGIN
_browser_header.contentSecurityPolicy	b4825e08-1ac5-43e9-990a-7556e882153a	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	b4825e08-1ac5-43e9-990a-7556e882153a	1; mode=block
_browser_header.strictTransportSecurity	b4825e08-1ac5-43e9-990a-7556e882153a	max-age=31536000; includeSubDomains
bruteForceProtected	b4825e08-1ac5-43e9-990a-7556e882153a	false
permanentLockout	b4825e08-1ac5-43e9-990a-7556e882153a	false
maxTemporaryLockouts	b4825e08-1ac5-43e9-990a-7556e882153a	0
maxFailureWaitSeconds	b4825e08-1ac5-43e9-990a-7556e882153a	900
minimumQuickLoginWaitSeconds	b4825e08-1ac5-43e9-990a-7556e882153a	60
waitIncrementSeconds	b4825e08-1ac5-43e9-990a-7556e882153a	60
quickLoginCheckMilliSeconds	b4825e08-1ac5-43e9-990a-7556e882153a	1000
maxDeltaTimeSeconds	b4825e08-1ac5-43e9-990a-7556e882153a	43200
failureFactor	b4825e08-1ac5-43e9-990a-7556e882153a	30
realmReusableOtpCode	b4825e08-1ac5-43e9-990a-7556e882153a	false
defaultSignatureAlgorithm	b4825e08-1ac5-43e9-990a-7556e882153a	RS256
offlineSessionMaxLifespanEnabled	b4825e08-1ac5-43e9-990a-7556e882153a	false
offlineSessionMaxLifespan	b4825e08-1ac5-43e9-990a-7556e882153a	5184000
actionTokenGeneratedByAdminLifespan	b4825e08-1ac5-43e9-990a-7556e882153a	43200
actionTokenGeneratedByUserLifespan	b4825e08-1ac5-43e9-990a-7556e882153a	300
oauth2DeviceCodeLifespan	b4825e08-1ac5-43e9-990a-7556e882153a	600
oauth2DevicePollingInterval	b4825e08-1ac5-43e9-990a-7556e882153a	5
webAuthnPolicyRpEntityName	b4825e08-1ac5-43e9-990a-7556e882153a	keycloak
webAuthnPolicySignatureAlgorithms	b4825e08-1ac5-43e9-990a-7556e882153a	ES256
webAuthnPolicyRpId	b4825e08-1ac5-43e9-990a-7556e882153a	
webAuthnPolicyAttestationConveyancePreference	b4825e08-1ac5-43e9-990a-7556e882153a	not specified
webAuthnPolicyAuthenticatorAttachment	b4825e08-1ac5-43e9-990a-7556e882153a	not specified
webAuthnPolicyRequireResidentKey	b4825e08-1ac5-43e9-990a-7556e882153a	not specified
webAuthnPolicyUserVerificationRequirement	b4825e08-1ac5-43e9-990a-7556e882153a	not specified
webAuthnPolicyCreateTimeout	b4825e08-1ac5-43e9-990a-7556e882153a	0
webAuthnPolicyAvoidSameAuthenticatorRegister	b4825e08-1ac5-43e9-990a-7556e882153a	false
webAuthnPolicyRpEntityNamePasswordless	b4825e08-1ac5-43e9-990a-7556e882153a	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	b4825e08-1ac5-43e9-990a-7556e882153a	ES256
webAuthnPolicyRpIdPasswordless	b4825e08-1ac5-43e9-990a-7556e882153a	
webAuthnPolicyAttestationConveyancePreferencePasswordless	b4825e08-1ac5-43e9-990a-7556e882153a	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	b4825e08-1ac5-43e9-990a-7556e882153a	not specified
webAuthnPolicyRequireResidentKeyPasswordless	b4825e08-1ac5-43e9-990a-7556e882153a	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	b4825e08-1ac5-43e9-990a-7556e882153a	not specified
webAuthnPolicyCreateTimeoutPasswordless	b4825e08-1ac5-43e9-990a-7556e882153a	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	b4825e08-1ac5-43e9-990a-7556e882153a	false
cibaBackchannelTokenDeliveryMode	b4825e08-1ac5-43e9-990a-7556e882153a	poll
cibaExpiresIn	b4825e08-1ac5-43e9-990a-7556e882153a	120
cibaInterval	b4825e08-1ac5-43e9-990a-7556e882153a	5
cibaAuthRequestedUserHint	b4825e08-1ac5-43e9-990a-7556e882153a	login_hint
parRequestUriLifespan	b4825e08-1ac5-43e9-990a-7556e882153a	60
firstBrokerLoginFlowId	b4825e08-1ac5-43e9-990a-7556e882153a	c6a6fabf-c7a8-4889-8fdf-d1df61729bc4
_browser_header.contentSecurityPolicyReportOnly	2256a568-ee44-4cb6-88fa-488d343b1bf5	
_browser_header.xContentTypeOptions	2256a568-ee44-4cb6-88fa-488d343b1bf5	nosniff
_browser_header.referrerPolicy	2256a568-ee44-4cb6-88fa-488d343b1bf5	no-referrer
_browser_header.xRobotsTag	2256a568-ee44-4cb6-88fa-488d343b1bf5	none
_browser_header.xFrameOptions	2256a568-ee44-4cb6-88fa-488d343b1bf5	SAMEORIGIN
_browser_header.contentSecurityPolicy	2256a568-ee44-4cb6-88fa-488d343b1bf5	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	2256a568-ee44-4cb6-88fa-488d343b1bf5	1; mode=block
_browser_header.strictTransportSecurity	2256a568-ee44-4cb6-88fa-488d343b1bf5	max-age=31536000; includeSubDomains
bruteForceProtected	2256a568-ee44-4cb6-88fa-488d343b1bf5	false
permanentLockout	2256a568-ee44-4cb6-88fa-488d343b1bf5	false
maxTemporaryLockouts	2256a568-ee44-4cb6-88fa-488d343b1bf5	0
maxFailureWaitSeconds	2256a568-ee44-4cb6-88fa-488d343b1bf5	900
minimumQuickLoginWaitSeconds	2256a568-ee44-4cb6-88fa-488d343b1bf5	60
waitIncrementSeconds	2256a568-ee44-4cb6-88fa-488d343b1bf5	60
quickLoginCheckMilliSeconds	2256a568-ee44-4cb6-88fa-488d343b1bf5	1000
maxDeltaTimeSeconds	2256a568-ee44-4cb6-88fa-488d343b1bf5	43200
failureFactor	2256a568-ee44-4cb6-88fa-488d343b1bf5	30
realmReusableOtpCode	2256a568-ee44-4cb6-88fa-488d343b1bf5	false
defaultSignatureAlgorithm	2256a568-ee44-4cb6-88fa-488d343b1bf5	RS256
offlineSessionMaxLifespanEnabled	2256a568-ee44-4cb6-88fa-488d343b1bf5	false
offlineSessionMaxLifespan	2256a568-ee44-4cb6-88fa-488d343b1bf5	5184000
actionTokenGeneratedByAdminLifespan	2256a568-ee44-4cb6-88fa-488d343b1bf5	43200
actionTokenGeneratedByUserLifespan	2256a568-ee44-4cb6-88fa-488d343b1bf5	300
oauth2DeviceCodeLifespan	2256a568-ee44-4cb6-88fa-488d343b1bf5	600
oauth2DevicePollingInterval	2256a568-ee44-4cb6-88fa-488d343b1bf5	5
webAuthnPolicyRpEntityName	2256a568-ee44-4cb6-88fa-488d343b1bf5	keycloak
webAuthnPolicySignatureAlgorithms	2256a568-ee44-4cb6-88fa-488d343b1bf5	ES256
webAuthnPolicyRpId	2256a568-ee44-4cb6-88fa-488d343b1bf5	
webAuthnPolicyAttestationConveyancePreference	2256a568-ee44-4cb6-88fa-488d343b1bf5	not specified
webAuthnPolicyAuthenticatorAttachment	2256a568-ee44-4cb6-88fa-488d343b1bf5	not specified
webAuthnPolicyRequireResidentKey	2256a568-ee44-4cb6-88fa-488d343b1bf5	not specified
webAuthnPolicyUserVerificationRequirement	2256a568-ee44-4cb6-88fa-488d343b1bf5	not specified
webAuthnPolicyCreateTimeout	2256a568-ee44-4cb6-88fa-488d343b1bf5	0
webAuthnPolicyAvoidSameAuthenticatorRegister	2256a568-ee44-4cb6-88fa-488d343b1bf5	false
webAuthnPolicyRpEntityNamePasswordless	2256a568-ee44-4cb6-88fa-488d343b1bf5	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	2256a568-ee44-4cb6-88fa-488d343b1bf5	ES256
webAuthnPolicyRpIdPasswordless	2256a568-ee44-4cb6-88fa-488d343b1bf5	
webAuthnPolicyAttestationConveyancePreferencePasswordless	2256a568-ee44-4cb6-88fa-488d343b1bf5	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	2256a568-ee44-4cb6-88fa-488d343b1bf5	not specified
webAuthnPolicyRequireResidentKeyPasswordless	2256a568-ee44-4cb6-88fa-488d343b1bf5	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	2256a568-ee44-4cb6-88fa-488d343b1bf5	not specified
webAuthnPolicyCreateTimeoutPasswordless	2256a568-ee44-4cb6-88fa-488d343b1bf5	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	2256a568-ee44-4cb6-88fa-488d343b1bf5	false
cibaBackchannelTokenDeliveryMode	2256a568-ee44-4cb6-88fa-488d343b1bf5	poll
cibaExpiresIn	2256a568-ee44-4cb6-88fa-488d343b1bf5	120
cibaInterval	2256a568-ee44-4cb6-88fa-488d343b1bf5	5
cibaAuthRequestedUserHint	2256a568-ee44-4cb6-88fa-488d343b1bf5	login_hint
parRequestUriLifespan	2256a568-ee44-4cb6-88fa-488d343b1bf5	60
firstBrokerLoginFlowId	2256a568-ee44-4cb6-88fa-488d343b1bf5	66c0da3b-2a03-4831-81ec-b6d3be1938b7
bruteForceStrategy	5760f0e0-8dc4-453f-b407-19c01025187d	MULTIPLE
organizationsEnabled	5760f0e0-8dc4-453f-b407-19c01025187d	false
_browser_header.contentSecurityPolicyReportOnly	5760f0e0-8dc4-453f-b407-19c01025187d	
_browser_header.xContentTypeOptions	5760f0e0-8dc4-453f-b407-19c01025187d	nosniff
_browser_header.referrerPolicy	5760f0e0-8dc4-453f-b407-19c01025187d	no-referrer
_browser_header.xRobotsTag	5760f0e0-8dc4-453f-b407-19c01025187d	none
_browser_header.xFrameOptions	5760f0e0-8dc4-453f-b407-19c01025187d	https://www.google.com
_browser_header.contentSecurityPolicy	5760f0e0-8dc4-453f-b407-19c01025187d	frame-src 'self' https://www.google.com;  frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	5760f0e0-8dc4-453f-b407-19c01025187d	1; mode=block
_browser_header.strictTransportSecurity	5760f0e0-8dc4-453f-b407-19c01025187d	max-age=31536000; includeSubDomains
cibaBackchannelTokenDeliveryMode	f493d84c-5308-498f-afec-c6f4cfffd553	poll
cibaExpiresIn	f493d84c-5308-498f-afec-c6f4cfffd553	120
cibaAuthRequestedUserHint	f493d84c-5308-498f-afec-c6f4cfffd553	login_hint
parRequestUriLifespan	f493d84c-5308-498f-afec-c6f4cfffd553	60
cibaInterval	f493d84c-5308-498f-afec-c6f4cfffd553	5
bruteForceStrategy	f493d84c-5308-498f-afec-c6f4cfffd553	MULTIPLE
organizationsEnabled	f493d84c-5308-498f-afec-c6f4cfffd553	false
actionTokenGeneratedByAdminLifespan	f493d84c-5308-498f-afec-c6f4cfffd553	43200
actionTokenGeneratedByUserLifespan	f493d84c-5308-498f-afec-c6f4cfffd553	300
oauth2DeviceCodeLifespan	f493d84c-5308-498f-afec-c6f4cfffd553	600
oauth2DevicePollingInterval	f493d84c-5308-498f-afec-c6f4cfffd553	5
clientSessionIdleTimeout	f493d84c-5308-498f-afec-c6f4cfffd553	0
clientSessionMaxLifespan	f493d84c-5308-498f-afec-c6f4cfffd553	0
clientOfflineSessionIdleTimeout	f493d84c-5308-498f-afec-c6f4cfffd553	0
clientOfflineSessionMaxLifespan	f493d84c-5308-498f-afec-c6f4cfffd553	0
webAuthnPolicyRpEntityName	f493d84c-5308-498f-afec-c6f4cfffd553	keycloak
webAuthnPolicySignatureAlgorithms	f493d84c-5308-498f-afec-c6f4cfffd553	ES256,RS256
webAuthnPolicyRpId	f493d84c-5308-498f-afec-c6f4cfffd553	
webAuthnPolicyAttestationConveyancePreference	f493d84c-5308-498f-afec-c6f4cfffd553	not specified
webAuthnPolicyAuthenticatorAttachment	f493d84c-5308-498f-afec-c6f4cfffd553	not specified
webAuthnPolicyRequireResidentKey	f493d84c-5308-498f-afec-c6f4cfffd553	not specified
webAuthnPolicyUserVerificationRequirement	f493d84c-5308-498f-afec-c6f4cfffd553	not specified
webAuthnPolicyCreateTimeout	f493d84c-5308-498f-afec-c6f4cfffd553	0
webAuthnPolicyAvoidSameAuthenticatorRegister	f493d84c-5308-498f-afec-c6f4cfffd553	false
webAuthnPolicyRpEntityNamePasswordless	f493d84c-5308-498f-afec-c6f4cfffd553	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	f493d84c-5308-498f-afec-c6f4cfffd553	ES256,RS256
webAuthnPolicyRpIdPasswordless	f493d84c-5308-498f-afec-c6f4cfffd553	
webAuthnPolicyAttestationConveyancePreferencePasswordless	f493d84c-5308-498f-afec-c6f4cfffd553	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	f493d84c-5308-498f-afec-c6f4cfffd553	not specified
webAuthnPolicyRequireResidentKeyPasswordless	f493d84c-5308-498f-afec-c6f4cfffd553	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	f493d84c-5308-498f-afec-c6f4cfffd553	not specified
webAuthnPolicyCreateTimeoutPasswordless	f493d84c-5308-498f-afec-c6f4cfffd553	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	f493d84c-5308-498f-afec-c6f4cfffd553	false
client-policies.profiles	f493d84c-5308-498f-afec-c6f4cfffd553	{"profiles":[]}
client-policies.policies	f493d84c-5308-498f-afec-c6f4cfffd553	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	f493d84c-5308-498f-afec-c6f4cfffd553	
_browser_header.xContentTypeOptions	f493d84c-5308-498f-afec-c6f4cfffd553	nosniff
_browser_header.referrerPolicy	f493d84c-5308-498f-afec-c6f4cfffd553	no-referrer
_browser_header.xRobotsTag	f493d84c-5308-498f-afec-c6f4cfffd553	none
_browser_header.xFrameOptions	f493d84c-5308-498f-afec-c6f4cfffd553	SAMEORIGIN
_browser_header.xXSSProtection	f493d84c-5308-498f-afec-c6f4cfffd553	1; mode=block
_browser_header.contentSecurityPolicy	f493d84c-5308-498f-afec-c6f4cfffd553	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	f493d84c-5308-498f-afec-c6f4cfffd553	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
f493d84c-5308-498f-afec-c6f4cfffd553	UPDATE_CONSENT_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	SEND_RESET_PASSWORD
f493d84c-5308-498f-afec-c6f4cfffd553	GRANT_CONSENT
f493d84c-5308-498f-afec-c6f4cfffd553	VERIFY_PROFILE_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	UPDATE_TOTP
f493d84c-5308-498f-afec-c6f4cfffd553	REMOVE_TOTP
f493d84c-5308-498f-afec-c6f4cfffd553	REVOKE_GRANT
f493d84c-5308-498f-afec-c6f4cfffd553	LOGIN_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	CLIENT_LOGIN
f493d84c-5308-498f-afec-c6f4cfffd553	RESET_PASSWORD_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	IMPERSONATE_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	CODE_TO_TOKEN_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	CUSTOM_REQUIRED_ACTION
f493d84c-5308-498f-afec-c6f4cfffd553	OAUTH2_DEVICE_CODE_TO_TOKEN_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	RESTART_AUTHENTICATION
f493d84c-5308-498f-afec-c6f4cfffd553	UPDATE_PROFILE_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	IMPERSONATE
f493d84c-5308-498f-afec-c6f4cfffd553	LOGIN
f493d84c-5308-498f-afec-c6f4cfffd553	UPDATE_PASSWORD_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	OAUTH2_DEVICE_VERIFY_USER_CODE
f493d84c-5308-498f-afec-c6f4cfffd553	CLIENT_INITIATED_ACCOUNT_LINKING
f493d84c-5308-498f-afec-c6f4cfffd553	USER_DISABLED_BY_PERMANENT_LOCKOUT
f493d84c-5308-498f-afec-c6f4cfffd553	OAUTH2_EXTENSION_GRANT
f493d84c-5308-498f-afec-c6f4cfffd553	TOKEN_EXCHANGE
f493d84c-5308-498f-afec-c6f4cfffd553	REGISTER
f493d84c-5308-498f-afec-c6f4cfffd553	LOGOUT
f493d84c-5308-498f-afec-c6f4cfffd553	AUTHREQID_TO_TOKEN
f493d84c-5308-498f-afec-c6f4cfffd553	DELETE_ACCOUNT_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	CLIENT_REGISTER
f493d84c-5308-498f-afec-c6f4cfffd553	IDENTITY_PROVIDER_LINK_ACCOUNT
f493d84c-5308-498f-afec-c6f4cfffd553	USER_DISABLED_BY_TEMPORARY_LOCKOUT
f493d84c-5308-498f-afec-c6f4cfffd553	UPDATE_PASSWORD
f493d84c-5308-498f-afec-c6f4cfffd553	DELETE_ACCOUNT
f493d84c-5308-498f-afec-c6f4cfffd553	FEDERATED_IDENTITY_LINK_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	CLIENT_DELETE
f493d84c-5308-498f-afec-c6f4cfffd553	IDENTITY_PROVIDER_FIRST_LOGIN
f493d84c-5308-498f-afec-c6f4cfffd553	VERIFY_EMAIL
f493d84c-5308-498f-afec-c6f4cfffd553	CLIENT_DELETE_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	CLIENT_LOGIN_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	RESTART_AUTHENTICATION_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	REMOVE_FEDERATED_IDENTITY_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	EXECUTE_ACTIONS
f493d84c-5308-498f-afec-c6f4cfffd553	TOKEN_EXCHANGE_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	PERMISSION_TOKEN
f493d84c-5308-498f-afec-c6f4cfffd553	SEND_IDENTITY_PROVIDER_LINK_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	EXECUTE_ACTION_TOKEN_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	SEND_VERIFY_EMAIL
f493d84c-5308-498f-afec-c6f4cfffd553	OAUTH2_EXTENSION_GRANT_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	OAUTH2_DEVICE_AUTH
f493d84c-5308-498f-afec-c6f4cfffd553	EXECUTE_ACTIONS_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	REMOVE_FEDERATED_IDENTITY
f493d84c-5308-498f-afec-c6f4cfffd553	OAUTH2_DEVICE_CODE_TO_TOKEN
f493d84c-5308-498f-afec-c6f4cfffd553	IDENTITY_PROVIDER_POST_LOGIN
f493d84c-5308-498f-afec-c6f4cfffd553	IDENTITY_PROVIDER_LINK_ACCOUNT_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	UPDATE_EMAIL
f493d84c-5308-498f-afec-c6f4cfffd553	OAUTH2_DEVICE_VERIFY_USER_CODE_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	REGISTER_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	REVOKE_GRANT_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	LOGOUT_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	UPDATE_EMAIL_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	EXECUTE_ACTION_TOKEN
f493d84c-5308-498f-afec-c6f4cfffd553	CLIENT_UPDATE_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	UPDATE_PROFILE
f493d84c-5308-498f-afec-c6f4cfffd553	AUTHREQID_TO_TOKEN_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	FEDERATED_IDENTITY_LINK
f493d84c-5308-498f-afec-c6f4cfffd553	CLIENT_REGISTER_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	SEND_VERIFY_EMAIL_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	SEND_IDENTITY_PROVIDER_LINK
f493d84c-5308-498f-afec-c6f4cfffd553	RESET_PASSWORD
f493d84c-5308-498f-afec-c6f4cfffd553	CLIENT_INITIATED_ACCOUNT_LINKING_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	OAUTH2_DEVICE_AUTH_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	UPDATE_CONSENT
f493d84c-5308-498f-afec-c6f4cfffd553	REMOVE_TOTP_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	VERIFY_EMAIL_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	SEND_RESET_PASSWORD_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	CLIENT_UPDATE
f493d84c-5308-498f-afec-c6f4cfffd553	IDENTITY_PROVIDER_POST_LOGIN_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	CUSTOM_REQUIRED_ACTION_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	UPDATE_TOTP_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	CODE_TO_TOKEN
f493d84c-5308-498f-afec-c6f4cfffd553	VERIFY_PROFILE
f493d84c-5308-498f-afec-c6f4cfffd553	GRANT_CONSENT_ERROR
f493d84c-5308-498f-afec-c6f4cfffd553	IDENTITY_PROVIDER_FIRST_LOGIN_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	UPDATE_CONSENT_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	SEND_RESET_PASSWORD
5760f0e0-8dc4-453f-b407-19c01025187d	GRANT_CONSENT
5760f0e0-8dc4-453f-b407-19c01025187d	VERIFY_PROFILE_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	UPDATE_TOTP
5760f0e0-8dc4-453f-b407-19c01025187d	REMOVE_TOTP
5760f0e0-8dc4-453f-b407-19c01025187d	REVOKE_GRANT
5760f0e0-8dc4-453f-b407-19c01025187d	LOGIN_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	CLIENT_LOGIN
5760f0e0-8dc4-453f-b407-19c01025187d	RESET_PASSWORD_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	IMPERSONATE_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	CODE_TO_TOKEN_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	CUSTOM_REQUIRED_ACTION
5760f0e0-8dc4-453f-b407-19c01025187d	OAUTH2_DEVICE_CODE_TO_TOKEN_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	RESTART_AUTHENTICATION
5760f0e0-8dc4-453f-b407-19c01025187d	UPDATE_PROFILE_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	IMPERSONATE
5760f0e0-8dc4-453f-b407-19c01025187d	LOGIN
5760f0e0-8dc4-453f-b407-19c01025187d	UPDATE_PASSWORD_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	OAUTH2_DEVICE_VERIFY_USER_CODE
5760f0e0-8dc4-453f-b407-19c01025187d	CLIENT_INITIATED_ACCOUNT_LINKING
5760f0e0-8dc4-453f-b407-19c01025187d	USER_DISABLED_BY_PERMANENT_LOCKOUT
5760f0e0-8dc4-453f-b407-19c01025187d	OAUTH2_EXTENSION_GRANT
5760f0e0-8dc4-453f-b407-19c01025187d	TOKEN_EXCHANGE
5760f0e0-8dc4-453f-b407-19c01025187d	REGISTER
5760f0e0-8dc4-453f-b407-19c01025187d	LOGOUT
5760f0e0-8dc4-453f-b407-19c01025187d	AUTHREQID_TO_TOKEN
5760f0e0-8dc4-453f-b407-19c01025187d	DELETE_ACCOUNT_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	CLIENT_REGISTER
5760f0e0-8dc4-453f-b407-19c01025187d	IDENTITY_PROVIDER_LINK_ACCOUNT
5760f0e0-8dc4-453f-b407-19c01025187d	USER_DISABLED_BY_TEMPORARY_LOCKOUT
5760f0e0-8dc4-453f-b407-19c01025187d	UPDATE_PASSWORD
5760f0e0-8dc4-453f-b407-19c01025187d	DELETE_ACCOUNT
5760f0e0-8dc4-453f-b407-19c01025187d	FEDERATED_IDENTITY_LINK_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	CLIENT_DELETE
5760f0e0-8dc4-453f-b407-19c01025187d	IDENTITY_PROVIDER_FIRST_LOGIN
5760f0e0-8dc4-453f-b407-19c01025187d	VERIFY_EMAIL
5760f0e0-8dc4-453f-b407-19c01025187d	CLIENT_DELETE_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	CLIENT_LOGIN_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	RESTART_AUTHENTICATION_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	REMOVE_FEDERATED_IDENTITY_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	EXECUTE_ACTIONS
5760f0e0-8dc4-453f-b407-19c01025187d	TOKEN_EXCHANGE_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	PERMISSION_TOKEN
5760f0e0-8dc4-453f-b407-19c01025187d	SEND_IDENTITY_PROVIDER_LINK_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	EXECUTE_ACTION_TOKEN_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	SEND_VERIFY_EMAIL
5760f0e0-8dc4-453f-b407-19c01025187d	OAUTH2_EXTENSION_GRANT_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	OAUTH2_DEVICE_AUTH
5760f0e0-8dc4-453f-b407-19c01025187d	EXECUTE_ACTIONS_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	REMOVE_FEDERATED_IDENTITY
5760f0e0-8dc4-453f-b407-19c01025187d	OAUTH2_DEVICE_CODE_TO_TOKEN
5760f0e0-8dc4-453f-b407-19c01025187d	IDENTITY_PROVIDER_POST_LOGIN
5760f0e0-8dc4-453f-b407-19c01025187d	IDENTITY_PROVIDER_LINK_ACCOUNT_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	UPDATE_EMAIL
5760f0e0-8dc4-453f-b407-19c01025187d	OAUTH2_DEVICE_VERIFY_USER_CODE_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	REGISTER_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	REVOKE_GRANT_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	LOGOUT_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	UPDATE_EMAIL_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	EXECUTE_ACTION_TOKEN
5760f0e0-8dc4-453f-b407-19c01025187d	CLIENT_UPDATE_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	UPDATE_PROFILE
5760f0e0-8dc4-453f-b407-19c01025187d	AUTHREQID_TO_TOKEN_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	FEDERATED_IDENTITY_LINK
5760f0e0-8dc4-453f-b407-19c01025187d	CLIENT_REGISTER_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	SEND_VERIFY_EMAIL_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	SEND_IDENTITY_PROVIDER_LINK
5760f0e0-8dc4-453f-b407-19c01025187d	RESET_PASSWORD
5760f0e0-8dc4-453f-b407-19c01025187d	CLIENT_INITIATED_ACCOUNT_LINKING_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	OAUTH2_DEVICE_AUTH_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	UPDATE_CONSENT
5760f0e0-8dc4-453f-b407-19c01025187d	REMOVE_TOTP_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	VERIFY_EMAIL_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	SEND_RESET_PASSWORD_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	CLIENT_UPDATE
5760f0e0-8dc4-453f-b407-19c01025187d	IDENTITY_PROVIDER_POST_LOGIN_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	CUSTOM_REQUIRED_ACTION_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	UPDATE_TOTP_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	CODE_TO_TOKEN
5760f0e0-8dc4-453f-b407-19c01025187d	VERIFY_PROFILE
5760f0e0-8dc4-453f-b407-19c01025187d	GRANT_CONSENT_ERROR
5760f0e0-8dc4-453f-b407-19c01025187d	IDENTITY_PROVIDER_FIRST_LOGIN_ERROR
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
429ce2ec-99a2-44b6-9c27-36b18f46b8d3	jboss-logging
b4825e08-1ac5-43e9-990a-7556e882153a	jboss-logging
2256a568-ee44-4cb6-88fa-488d343b1bf5	jboss-logging
5760f0e0-8dc4-453f-b407-19c01025187d	jboss-logging
f493d84c-5308-498f-afec-c6f4cfffd553	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	f493d84c-5308-498f-afec-c6f4cfffd553
password	password	t	t	5760f0e0-8dc4-453f-b407-19c01025187d
password	password	t	t	429ce2ec-99a2-44b6-9c27-36b18f46b8d3
password	password	t	t	b4825e08-1ac5-43e9-990a-7556e882153a
password	password	t	t	2256a568-ee44-4cb6-88fa-488d343b1bf5
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
5760f0e0-8dc4-453f-b407-19c01025187d		replyToDisplayName
5760f0e0-8dc4-453f-b407-19c01025187d	false	starttls
5760f0e0-8dc4-453f-b407-19c01025187d		auth
5760f0e0-8dc4-453f-b407-19c01025187d	1025	port
5760f0e0-8dc4-453f-b407-19c01025187d	mailpit	host
5760f0e0-8dc4-453f-b407-19c01025187d		replyTo
5760f0e0-8dc4-453f-b407-19c01025187d	nlevesq@mit.edu	from
5760f0e0-8dc4-453f-b407-19c01025187d		fromDisplayName
5760f0e0-8dc4-453f-b407-19c01025187d		envelopeFrom
5760f0e0-8dc4-453f-b407-19c01025187d	false	ssl
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
853be0b2-ad1a-4116-aff3-c10f318e9ad5	/realms/master/account/*
b43612df-590a-4e25-a38f-2f0de881be8f	/realms/master/account/*
d15c1b01-566a-4497-8bc9-3d9d87253ea1	/admin/master/console/*
37ffb6d7-4e38-4e14-a47f-6a5a85276f55	/realms/olapps/account/*
0eecf1c0-c127-4ca2-9327-459efbb9c681	/realms/olapps/account/*
44cee68c-7ad2-465c-b7e4-67db09369afc	/admin/olapps/console/*
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	http://ue.odl.local:4080/*
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	http://ue.odl.local:9080/*
20ab4f86-015d-4d03-9ca5-de7ab82277bf	/realms/test/account/*
f99d9cb1-4be5-4cd0-8061-e223ad552b74	/realms/test/account/*
838fe32e-5500-4989-8194-c83c43aa5617	/admin/test/console/*
d15c1b01-566a-4497-8bc9-3d9d87253ea1	/realms/master/scim/admin/frontend/*
44cee68c-7ad2-465c-b7e4-67db09369afc	/realms/olapps/scim/admin/frontend/*
838fe32e-5500-4989-8194-c83c43aa5617	/realms/test/scim/admin/frontend/*
df1eed9b-9772-4844-bf38-063fcfbf2c71	/realms/test1/account/*
bb4d8a91-43ec-4a96-8bec-800f920c8826	/realms/test1/account/*
3d21aefb-1d20-4d27-9756-3cce60b5e958	/admin/test1/console/*
3d21aefb-1d20-4d27-9756-3cce60b5e958	/realms/test1/scim/admin/frontend/*
75fc95fe-2c73-4934-a450-5d00669f5b97	/realms/test2/account/*
7f6732e2-e3c2-456a-9e4e-234ecab9072d	/realms/test2/account/*
797f6274-dc0a-4a46-8098-9e25decee64f	/admin/test2/console/*
797f6274-dc0a-4a46-8098-9e25decee64f	/realms/test2/scim/admin/frontend/*
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	/*
b2a0a790-59c5-4142-9d77-44932b1e8620	/*
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	https://api.learn.odl.local/*
473685f9-266f-4983-b2a5-156a6dc8468c	/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
cc6781c4-353f-48c7-98b5-ce5393dd7e97	VERIFY_EMAIL	Verify Email	f493d84c-5308-498f-afec-c6f4cfffd553	t	f	VERIFY_EMAIL	50
7229949b-d573-453c-bb1a-b773d6ecefd8	UPDATE_PROFILE	Update Profile	f493d84c-5308-498f-afec-c6f4cfffd553	t	f	UPDATE_PROFILE	40
e09797f4-2283-43e2-90aa-7ef4695539b9	CONFIGURE_TOTP	Configure OTP	f493d84c-5308-498f-afec-c6f4cfffd553	t	f	CONFIGURE_TOTP	10
2506a70c-bf36-4abd-ad17-6b74f35bc5a5	UPDATE_PASSWORD	Update Password	f493d84c-5308-498f-afec-c6f4cfffd553	t	f	UPDATE_PASSWORD	30
e731bb7d-7d19-4df9-8c8f-95a2135173ce	TERMS_AND_CONDITIONS	Terms and Conditions	f493d84c-5308-498f-afec-c6f4cfffd553	f	f	TERMS_AND_CONDITIONS	20
b2f916a2-f71f-43aa-b894-2b3f3380331f	delete_account	Delete Account	f493d84c-5308-498f-afec-c6f4cfffd553	f	f	delete_account	60
99b2569b-4d51-4afd-b4d6-f5b43be03035	delete_credential	Delete Credential	f493d84c-5308-498f-afec-c6f4cfffd553	t	f	delete_credential	100
cf791725-e12a-4b1f-89e6-0ece778d8e31	update_user_locale	Update User Locale	f493d84c-5308-498f-afec-c6f4cfffd553	t	f	update_user_locale	1000
5382a8a6-c8d2-4ad3-8ff3-a73959d69fbf	UPDATE_EMAIL	Update Email	f493d84c-5308-498f-afec-c6f4cfffd553	t	f	UPDATE_EMAIL	70
d0637815-b8e5-441d-b9e0-03074783f73c	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	f493d84c-5308-498f-afec-c6f4cfffd553	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	70
65e2c412-44f6-458a-9d9e-ab70fa75fe46	webauthn-register	Webauthn Register	f493d84c-5308-498f-afec-c6f4cfffd553	t	f	webauthn-register	70
459a1def-e148-4d17-ad9f-3483067c7d5f	webauthn-register-passwordless	Webauthn Register Passwordless	f493d84c-5308-498f-afec-c6f4cfffd553	t	f	webauthn-register-passwordless	80
62f98778-4736-4e3b-81b9-42f573d2e6c0	VERIFY_PROFILE	Verify Profile	f493d84c-5308-498f-afec-c6f4cfffd553	t	f	VERIFY_PROFILE	90
a9174c20-73a3-4430-8104-588472899e2f	VERIFY_EMAIL	Verify Email	5760f0e0-8dc4-453f-b407-19c01025187d	t	f	VERIFY_EMAIL	50
ac25092a-ba32-45ab-b3dd-8afbf948b459	UPDATE_PROFILE	Update Profile	5760f0e0-8dc4-453f-b407-19c01025187d	t	f	UPDATE_PROFILE	40
bca26857-530b-4fb0-9382-a6c8cb5029f3	CONFIGURE_TOTP	Configure OTP	5760f0e0-8dc4-453f-b407-19c01025187d	t	f	CONFIGURE_TOTP	10
e5e40b28-80bb-4729-8506-0d935c021beb	UPDATE_PASSWORD	Update Password	5760f0e0-8dc4-453f-b407-19c01025187d	t	f	UPDATE_PASSWORD	30
62be4efc-afaa-4eaf-a166-0eeb6ed18920	TERMS_AND_CONDITIONS	Terms and Conditions	5760f0e0-8dc4-453f-b407-19c01025187d	f	f	TERMS_AND_CONDITIONS	20
9d7c6bef-7095-46fe-a7a3-e0137f1dd8f8	delete_account	Delete Account	5760f0e0-8dc4-453f-b407-19c01025187d	f	f	delete_account	60
3548e1b3-c3a7-46bd-9555-c2fb10ea172e	delete_credential	Delete Credential	5760f0e0-8dc4-453f-b407-19c01025187d	t	f	delete_credential	100
845c1067-3966-44ce-b007-7ecc7b3f5afd	update_user_locale	Update User Locale	5760f0e0-8dc4-453f-b407-19c01025187d	t	f	update_user_locale	1000
56026f56-0866-4fb6-9ba5-c16a806e4ee7	UPDATE_EMAIL	Update Email	5760f0e0-8dc4-453f-b407-19c01025187d	t	f	UPDATE_EMAIL	70
33bb991c-712e-4136-8a97-a47de380c65d	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	5760f0e0-8dc4-453f-b407-19c01025187d	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	70
90652bd0-2410-45a6-978c-7b481ad720da	webauthn-register	Webauthn Register	5760f0e0-8dc4-453f-b407-19c01025187d	t	f	webauthn-register	70
e57b140d-3bff-4f5d-8e09-305c4a379ae1	webauthn-register-passwordless	Webauthn Register Passwordless	5760f0e0-8dc4-453f-b407-19c01025187d	t	f	webauthn-register-passwordless	80
942205e3-3b28-4e70-ad60-0f0a62bef3b5	VERIFY_PROFILE	Verify Profile	5760f0e0-8dc4-453f-b407-19c01025187d	t	f	VERIFY_PROFILE	90
07d85b7c-8a10-4090-be9d-79b26c499545	VERIFY_EMAIL	Verify Email	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	t	f	VERIFY_EMAIL	50
61f045e0-cf50-4603-a322-8ec48e37de61	UPDATE_PROFILE	Update Profile	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	t	f	UPDATE_PROFILE	40
475de4e6-708a-4564-891f-a3f9d4c256b9	CONFIGURE_TOTP	Configure OTP	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	t	f	CONFIGURE_TOTP	10
e850db5d-cad4-4f1b-b775-9f99f53661ed	UPDATE_PASSWORD	Update Password	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	t	f	UPDATE_PASSWORD	30
4d828369-728d-4ca3-aca6-8b7ff7372c53	TERMS_AND_CONDITIONS	Terms and Conditions	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	f	f	TERMS_AND_CONDITIONS	20
81ea282d-0441-4fb4-b1a9-fe7284d67704	delete_account	Delete Account	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	f	f	delete_account	60
08715c03-f9da-475e-998d-e26b3779e5f3	delete_credential	Delete Credential	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	t	f	delete_credential	100
325d0636-9422-46e0-bad5-32cd32ce9d6a	update_user_locale	Update User Locale	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	t	f	update_user_locale	1000
9b6ccd86-8e74-4277-9c8a-8bbe8784ba99	UPDATE_EMAIL	Update Email	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	t	f	UPDATE_EMAIL	70
c8643bf2-1009-49c0-83cd-c4aa482c5c0f	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	70
30fe93d7-deae-4825-a723-a933f66d926c	webauthn-register	Webauthn Register	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	t	f	webauthn-register	70
f53ede37-efb2-4e5d-a8e8-75e4a3542634	webauthn-register-passwordless	Webauthn Register Passwordless	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	t	f	webauthn-register-passwordless	80
1afa9c5e-8cd5-4d4a-8d6b-68488961e175	VERIFY_PROFILE	Verify Profile	429ce2ec-99a2-44b6-9c27-36b18f46b8d3	t	f	VERIFY_PROFILE	90
f7273a0a-edbe-45fa-ab6c-6761b6992174	VERIFY_EMAIL	Verify Email	b4825e08-1ac5-43e9-990a-7556e882153a	t	f	VERIFY_EMAIL	50
bdf1de7d-fbec-4fdb-950b-2702536e7a45	UPDATE_PROFILE	Update Profile	b4825e08-1ac5-43e9-990a-7556e882153a	t	f	UPDATE_PROFILE	40
efc6552b-42a6-4be2-a32d-9b71cd178cf2	CONFIGURE_TOTP	Configure OTP	b4825e08-1ac5-43e9-990a-7556e882153a	t	f	CONFIGURE_TOTP	10
ed5be9db-09d1-4372-8c78-6e5eb7cd5d80	UPDATE_PASSWORD	Update Password	b4825e08-1ac5-43e9-990a-7556e882153a	t	f	UPDATE_PASSWORD	30
bc519f07-ce92-47ae-a0ca-346cc04d44dd	TERMS_AND_CONDITIONS	Terms and Conditions	b4825e08-1ac5-43e9-990a-7556e882153a	f	f	TERMS_AND_CONDITIONS	20
21f66a5d-55c5-4c11-ac33-fae6dfaa1283	delete_account	Delete Account	b4825e08-1ac5-43e9-990a-7556e882153a	f	f	delete_account	60
aada1fe6-8ca3-49cc-90a3-cdefb157a7c9	delete_credential	Delete Credential	b4825e08-1ac5-43e9-990a-7556e882153a	t	f	delete_credential	100
81970778-fd56-401f-b124-b16bfb157ed7	update_user_locale	Update User Locale	b4825e08-1ac5-43e9-990a-7556e882153a	t	f	update_user_locale	1000
ff9cfa2b-5dfd-4a76-a3e9-4f12d047c4d6	UPDATE_EMAIL	Update Email	b4825e08-1ac5-43e9-990a-7556e882153a	t	f	UPDATE_EMAIL	70
ebf8e10d-e75f-4046-b447-9518291222f7	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	b4825e08-1ac5-43e9-990a-7556e882153a	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	70
84bed589-fa89-4b8c-a088-61f61b89e6a0	webauthn-register	Webauthn Register	b4825e08-1ac5-43e9-990a-7556e882153a	t	f	webauthn-register	70
271a7d83-a967-4ad9-a5ee-fe8bd14b2339	webauthn-register-passwordless	Webauthn Register Passwordless	b4825e08-1ac5-43e9-990a-7556e882153a	t	f	webauthn-register-passwordless	80
8ad9bb02-fcc4-4c27-8923-6b1a1ad89746	VERIFY_PROFILE	Verify Profile	b4825e08-1ac5-43e9-990a-7556e882153a	t	f	VERIFY_PROFILE	90
f1a7e08a-0a5e-4dd2-a72f-f426ee5a7f7c	VERIFY_EMAIL	Verify Email	2256a568-ee44-4cb6-88fa-488d343b1bf5	t	f	VERIFY_EMAIL	50
d2dd528f-dd7b-43b6-8aea-a979bf8caea3	UPDATE_PROFILE	Update Profile	2256a568-ee44-4cb6-88fa-488d343b1bf5	t	f	UPDATE_PROFILE	40
55ae8be1-ac6f-4a55-b768-070ef5d2e041	CONFIGURE_TOTP	Configure OTP	2256a568-ee44-4cb6-88fa-488d343b1bf5	t	f	CONFIGURE_TOTP	10
26bbeb10-5f51-47cd-8d19-155e33146203	UPDATE_PASSWORD	Update Password	2256a568-ee44-4cb6-88fa-488d343b1bf5	t	f	UPDATE_PASSWORD	30
f7d12d78-3de4-4ed9-addf-580303f29a7a	TERMS_AND_CONDITIONS	Terms and Conditions	2256a568-ee44-4cb6-88fa-488d343b1bf5	f	f	TERMS_AND_CONDITIONS	20
367f97aa-c223-4b86-81d1-5759b7d92a31	delete_account	Delete Account	2256a568-ee44-4cb6-88fa-488d343b1bf5	f	f	delete_account	60
0f947bce-3cfa-4929-b44c-97a6bab46eb2	delete_credential	Delete Credential	2256a568-ee44-4cb6-88fa-488d343b1bf5	t	f	delete_credential	100
0434e1fe-5dba-42ca-9165-24e7e0df165c	update_user_locale	Update User Locale	2256a568-ee44-4cb6-88fa-488d343b1bf5	t	f	update_user_locale	1000
4b002a77-047a-4476-97a2-4322a4e5c624	UPDATE_EMAIL	Update Email	2256a568-ee44-4cb6-88fa-488d343b1bf5	t	f	UPDATE_EMAIL	70
efd0ccdb-2cd7-495b-adfd-3b9d2252d724	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	2256a568-ee44-4cb6-88fa-488d343b1bf5	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	70
24c96f8d-5cd2-4ebf-9723-392326a638dc	webauthn-register	Webauthn Register	2256a568-ee44-4cb6-88fa-488d343b1bf5	t	f	webauthn-register	70
524037a8-4481-4ac1-ae70-2c056a89f222	webauthn-register-passwordless	Webauthn Register Passwordless	2256a568-ee44-4cb6-88fa-488d343b1bf5	t	f	webauthn-register-passwordless	80
3173e535-e0e5-4d01-95af-4d02f3676241	VERIFY_PROFILE	Verify Profile	2256a568-ee44-4cb6-88fa-488d343b1bf5	t	f	VERIFY_PROFILE	90
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
80b8e421-a8d0-48c7-a471-5bdddf12de86	f	0	1
0f393319-fded-4b0c-9711-a9ca8eeba66d	f	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
a1470590-d8df-4774-b7ec-abd7256f0727	map-role	\N	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
022d7a18-3f0d-48fb-bc70-89457fd375bb	map-role-client-scope	\N	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
4da00fb2-094e-4a31-8b39-3f8877e3ada6	map-role-composite	\N	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
4cc35ea5-1843-457a-8597-fbf57d5fe9e3	manage	\N	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
5682a52b-e07a-4c3b-9b77-618f99cbd613	view	\N	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
e87ef5a4-32ad-429b-afb3-1b2e4632542f	map-roles	\N	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
105973ab-4f31-4f60-b353-ffaf12b9832a	map-roles-client-scope	\N	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
067af5f2-86bc-4f6a-ba56-3a3dc76a108b	map-roles-composite	\N	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
8eef30a6-8d65-49db-ab63-0babf40bb377	configure	\N	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
e3b8a0a3-902d-4e91-8be6-68f78b966d7e	token-exchange	\N	0f393319-fded-4b0c-9711-a9ca8eeba66d	\N
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scim_client_resource_filtering; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_client_resource_filtering (id, scim_remote_provider_id, invert_filter_rule, resource_assignment, filter_type, property_name, comparator, comparator_value) FROM stdin;
56b67fb7-9c17-4577-9bb3-19ab8d019725	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	f	USERS	PROPERTY	email	CO	@
\.


--
-- Data for Name: scim_endpoint_create_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_endpoint_create_roles (scim_resource_type_id, role_id) FROM stdin;
\.


--
-- Data for Name: scim_endpoint_delete_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_endpoint_delete_roles (scim_resource_type_id, role_id) FROM stdin;
\.


--
-- Data for Name: scim_endpoint_get_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_endpoint_get_roles (scim_resource_type_id, role_id) FROM stdin;
\.


--
-- Data for Name: scim_endpoint_list_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_endpoint_list_roles (scim_resource_type_id, role_id) FROM stdin;
\.


--
-- Data for Name: scim_endpoint_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_endpoint_roles (scim_resource_type_id, role_id) FROM stdin;
\.


--
-- Data for Name: scim_endpoint_update_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_endpoint_update_roles (scim_resource_type_id, role_id) FROM stdin;
\.


--
-- Data for Name: scim_external_resource_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_external_resource_mapping (id, scim_remote_provider_id, realm_id, resource_assignment, local_resource_id, external_resource_id) FROM stdin;
a0a33bbc-cf84-4a9f-aee1-fe655bda83b2	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	d4cdfbec-5b6c-4155-9009-24442152ba71	18
aadcb2f4-220d-4070-8047-0ebfd2da18a0	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	b790034a-8da9-4c3a-a8c1-78591737f64d	19
d887191b-9218-401e-8320-162ff7311c94	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	3411c2c1-53f7-4b6a-8780-04caf43497cf	20
896deb8d-f979-4375-9f0a-91ae193a4d8a	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	eedbaf58-ceb5-48af-971f-80d9ed756932	21
690d6ab8-ba10-4ad2-b943-802fe5dfe267	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	afe2a3c8-bbb1-440c-b1f2-8ac7cfd31dd3	22
e48bf9d0-7d8d-43e1-a9c0-97d80b77e4d5	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	4d4ecff6-54a2-4926-a391-881a5c9d2137	23
e72da577-96a0-4cdb-ad16-821156744d3d	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	761022bd-f7a0-462e-9b47-180e371caf31	24
1dc6f039-5291-428b-b5d8-2d0e1921f72c	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	ff8c6822-a130-408e-98ce-1e083b2dfeca	25
11d82518-a016-4e64-b155-9f1444f0870e	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	950b2f4a-3004-4bc5-9d86-0fd0f156ac82	26
f94219a3-0539-4981-9bc8-e8505c01f207	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	964439e4-3fa5-442b-98f2-5629b10e54c6	27
2a55bb7c-ef9c-4679-8294-218de0bc4040	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	5c10f566-9160-4795-b2af-afc12f92b293	28
250772ff-8f9d-4de7-9788-e50b9ea772af	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	8c30ee8f-d153-40fa-b092-0378cf052288	29
ae38d2de-79f4-4a68-b3c5-a63e4ae12332	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	07e338d0-0827-4ba3-b350-5b55182d34dc	2
17c280ef-2ca3-4276-8f2b-52a14b3b7b60	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	3492d892-d606-436d-af14-4c1e303d43db	3
c4d34861-d0f4-4894-9840-6c7461ad4c8f	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	34d6d4de-a401-4b82-8b8d-7ba2e0b3a52a	4
a6c64400-0999-4e12-90cf-6372317f4935	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	3193f207-14e1-468c-9a60-12366b111b08	5
19ca402b-3c9f-420f-b6f5-7a134d1b9918	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	83ceeb5a-9e8f-4c63-b671-6d8f3560f890	6
a06f7077-f77f-4d9f-b501-974aa954273b	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	90586e33-9783-4143-ac23-e38f0665f1a9	7
be5fe627-aa80-43ff-a6a9-914c59d31f12	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	7463cbb2-b6ac-4383-b8d4-0abf0d3bf323	8
b04c9580-594d-4993-a886-aa5b6f30c1f1	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	c8db480e-8390-4496-a99e-93efca3c49db	9
813eb9dd-571b-4410-9b51-5b9a2e41e9d6	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	33362f14-57ae-4518-9140-9b69907bc721	10
ea40b0d1-1f70-44ce-bffe-93bb2359f519	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	fc20baea-ea1a-45b7-a801-3a126d93937d	11
dce5d1b5-223c-421d-bcd0-b7ae6e83d424	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	8778b977-06d5-479a-bd60-474903c6b024	12
841b3210-a805-4237-a565-b3eb0e3e5b0f	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	19be8373-0fbf-48c9-8d18-bbee1df65cfb	13
ef6c2bd7-b0de-4554-8dc9-fc4cf198cd3d	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	b7cf04e7-a16c-44fc-9d85-93f5bbda4f93	14
0c61a069-5e24-49b9-9b2a-79bfe710237b	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	fc01f525-4201-4005-b61e-6c3ad5d2b36e	15
2466f038-e0ad-4cd5-8a76-313eda1d76ea	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	489717d3-9c35-4de8-a8de-48848340b18a	1
526fff90-534f-4401-9eef-198cd3b89ee9	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	123d8d42-dbb7-40f2-9faf-9658a22924e0	30
e3d32f57-46d8-417b-b38b-33ad14e95d7e	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	40dec71f-adcb-48ac-af3c-606c6007158e	16
c7fc9d18-7b78-4379-9767-a8ec59e118b9	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	5760f0e0-8dc4-453f-b407-19c01025187d	USERS	534e938c-43b1-44a3-894c-4c9372316c9d	17
\.


--
-- Data for Name: scim_remote_authentication; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_remote_authentication (id, authentication_type, api_key_header_name, auth_token, client_id, client_secret, token_endpoint, keystore_bytes, keystore_type, keystore_password, scim_remote_provider_id) FROM stdin;
97600d07-371e-4a3e-a8af-b226aa6284b0	BEARER	\N	abc123	\N	\N	\N	\N	PKCS12	\N	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1
\.


--
-- Data for Name: scim_remote_operation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_remote_operation (id, resource_assignment, realm_id, resource_id, operation, path, value, created, scim_remote_provider_id, external_id, local_operation_type) FROM stdin;
174	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	ff8c6822-a130-408e-98ce-1e083b2dfeca	REPLACE	active	true	2024-12-10 15:54:43.879888	\N	\N	\N
84	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	19be8373-0fbf-48c9-8d18-bbee1df65cfb	REPLACE	fullName	Nathan Levesque	2024-11-08 16:01:10.738042	\N	\N	\N
85	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	19be8373-0fbf-48c9-8d18-bbee1df65cfb	REPLACE	emailOptIn	1	2024-11-08 16:01:10.745076	\N	\N	\N
178	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	a06d964e-7407-4b80-87f8-8ad3d0e6ff26	REPLACE	active	true	\N	\N	\N	\N
87	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	19be8373-0fbf-48c9-8d18-bbee1df65cfb	REPLACE	active	true	\N	\N	\N	\N
5	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	eedbaf58-ceb5-48af-971f-80d9ed756932	REPLACE	active	true	2024-10-25 20:25:03.779201	\N	\N	\N
6	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	eedbaf58-ceb5-48af-971f-80d9ed756932	REPLACE	emails.value	rhysyngsun+od2@gmail.com	2024-10-25 20:25:03.810378	\N	\N	\N
7	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	eedbaf58-ceb5-48af-971f-80d9ed756932	REPLACE	emailOptIn	\N	2024-10-25 20:25:03.857456	\N	\N	\N
8	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	3411c2c1-53f7-4b6a-8780-04caf43497cf	REPLACE	active	true	2024-10-25 20:25:03.924865	\N	\N	\N
9	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	3411c2c1-53f7-4b6a-8780-04caf43497cf	REPLACE	emails.value	rhysyngsun+od1@gmail.com	2024-10-25 20:25:03.946097	\N	\N	\N
10	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	3411c2c1-53f7-4b6a-8780-04caf43497cf	REPLACE	emailOptIn	\N	2024-10-25 20:25:03.983151	\N	\N	\N
11	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	afe2a3c8-bbb1-440c-b1f2-8ac7cfd31dd3	REPLACE	active	true	2024-10-25 20:46:18.549548	\N	\N	\N
12	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	afe2a3c8-bbb1-440c-b1f2-8ac7cfd31dd3	REPLACE	emails.value	rhysyngsun+od4@gmail.com	2024-10-25 20:46:18.578664	\N	\N	\N
13	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	afe2a3c8-bbb1-440c-b1f2-8ac7cfd31dd3	REPLACE	emailOptIn	1	2024-10-25 20:46:18.631058	\N	\N	\N
292	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	07e338d0-0827-4ba3-b350-5b55182d34dc	REPLACE	active	true	2025-01-03 17:47:20.790348	\N	\N	\N
293	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	07e338d0-0827-4ba3-b350-5b55182d34dc	REPLACE	emails.value	abc@localhost	2025-01-03 17:47:20.7904	\N	\N	\N
86	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	19be8373-0fbf-48c9-8d18-bbee1df65cfb	REPLACE	emails.value	rhysyngsun+1108241@gmail.com	2024-11-08 16:01:10.829345	\N	\N	\N
88	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	b7cf04e7-a16c-44fc-9d85-93f5bbda4f93	REPLACE	fullName	Nate	2024-11-13 16:35:43.359566	\N	\N	\N
89	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	b7cf04e7-a16c-44fc-9d85-93f5bbda4f93	REPLACE	emailOptIn	1	2024-11-13 16:35:43.366228	\N	\N	\N
179	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	489717d3-9c35-4de8-a8de-48848340b18a	REPLACE	active	true	2024-12-17 13:25:25.254994	\N	\N	\N
91	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	b7cf04e7-a16c-44fc-9d85-93f5bbda4f93	REPLACE	active	true	\N	\N	\N	\N
90	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	b7cf04e7-a16c-44fc-9d85-93f5bbda4f93	REPLACE	emails.value	rhysyngsun+1113241@gmail.com	2024-11-13 16:35:43.416265	\N	\N	\N
294	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	07e338d0-0827-4ba3-b350-5b55182d34dc	REPLACE	emailOptIn	0	2025-01-03 17:47:20.790447	\N	\N	\N
295	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	07e338d0-0827-4ba3-b350-5b55182d34dc	REPLACE	fullName	Jimmy	2025-01-03 17:47:20.790474	\N	\N	\N
124	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	fc01f525-4201-4005-b61e-6c3ad5d2b36e	REPLACE	active	true	\N	\N	\N	\N
121	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	fc01f525-4201-4005-b61e-6c3ad5d2b36e	REPLACE	emails.value	rhysyngsun+1122241@gmail.com	2024-11-22 21:35:51.680622	\N	\N	\N
122	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	fc01f525-4201-4005-b61e-6c3ad5d2b36e	REPLACE	emailOptIn	1	2024-11-22 21:35:51.680708	\N	\N	\N
123	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	fc01f525-4201-4005-b61e-6c3ad5d2b36e	REPLACE	fullName	Nathan	2024-11-22 21:35:51.680748	\N	\N	\N
180	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	489717d3-9c35-4de8-a8de-48848340b18a	REPLACE	emails.value	nlevesq@mit.edu	2024-12-17 13:25:25.259378	\N	\N	\N
175	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	ff8c6822-a130-408e-98ce-1e083b2dfeca	REPLACE	emails.value	rhysyngsun+test120924-1@gmail.com	\N	\N	\N	\N
176	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	ff8c6822-a130-408e-98ce-1e083b2dfeca	REPLACE	emailOptIn	1	\N	\N	\N	\N
177	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	ff8c6822-a130-408e-98ce-1e083b2dfeca	REPLACE	fullName	Nathan Lev	\N	\N	\N	\N
181	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	489717d3-9c35-4de8-a8de-48848340b18a	REPLACE	emailOptIn	0	2024-12-17 13:25:25.272059	\N	\N	\N
182	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	489717d3-9c35-4de8-a8de-48848340b18a	REPLACE	fullName	\N	2024-12-17 13:25:25.272253	\N	\N	\N
222	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	4d4ecff6-54a2-4926-a391-881a5c9d2137	REPLACE	active	true	2025-01-03 16:26:59.733695	\N	\N	\N
223	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	4d4ecff6-54a2-4926-a391-881a5c9d2137	REPLACE	emails.value	rhysyngsun+odtest1@gmail.com	2025-01-03 16:26:59.733745	\N	\N	\N
224	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	4d4ecff6-54a2-4926-a391-881a5c9d2137	REPLACE	emailOptIn	1	2025-01-03 16:26:59.733783	\N	\N	\N
225	USERS	5760f0e0-8dc4-453f-b407-19c01025187d	4d4ecff6-54a2-4926-a391-881a5c9d2137	REPLACE	fullName	Test Nathan	2025-01-03 16:26:59.733821	\N	\N	\N
\.


--
-- Data for Name: scim_remote_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_remote_provider (id, name, enabled, base_url, is_user_storage_provider, table_list_strategy, truststore_bytes, truststore_type, truststore_password, hostname_verifier_on, proxy_host, proxy_port, proxy_user, proxy_password, use_lower_case_filter_compare, request_timeout, connect_timeout, socket_timeout, filter_supported, filter_max_results, sort_supported, patch_supported, change_password_supported, bulk_supported, bulk_max_operations, bulk_max_payload_size, etag_supported, created, last_modified, send_local_id_in_request, send_external_id_in_request, max_patch_operations) FROM stdin;
00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	mit-learn-local	t	http://api.learn.odl.local:8063/scim/v2/	f	USER_ENTITY	\N	\N	\N	t	\N	\N	\N	\N	f	10	5	10	t	50	t	t	f	t	1000	1000000	f	2024-11-04 16:00:46.989939	2025-02-19 21:53:50.675409	f	t	0
\.


--
-- Data for Name: scim_remote_provider_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_remote_provider_mapping (realm_id, scim_remote_provider_id) FROM stdin;
5760f0e0-8dc4-453f-b407-19c01025187d	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1
\.


--
-- Data for Name: scim_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_resource (id, realm_id, type, component_id, external_id) FROM stdin;
\.


--
-- Data for Name: scim_resource_schema_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_resource_schema_mapping (id, resource_type_id, schema_id, is_extension, is_required) FROM stdin;
65cac48c-3922-433a-b0dc-697501e8539b	fd98e74e-8b65-425b-a61d-21babad6c72b	ecdbae39-a985-4a62-9c46-6f7fefd925de	f	f
6e02b537-b000-4a0d-be17-c075d2a4602f	fd98e74e-8b65-425b-a61d-21babad6c72b	84c8d0ea-2a20-4da0-8da2-923f23cf41b7	t	f
7e766653-942d-470a-8568-2577ce93a958	c96a57c2-03f7-4546-aa44-6e017d32bc8a	9c9fc6a9-1115-4b67-87be-27a9e415e0eb	f	f
f3012499-f7f9-417e-b0ad-5ae58ec56594	0628af7b-433c-4bfa-a27c-29599a7b2016	ec08ce58-9cc4-4f75-b534-c07216246716	f	f
3ff3dd91-5566-471c-9b45-e16cdc86a2db	ecd0f0d2-2203-4725-8b74-fdcd490fd178	9c9fc6a9-1115-4b67-87be-27a9e415e0eb	f	f
a4403294-3434-41c5-ad64-2a98abe5e2f8	f9a74b67-c5b0-403d-b551-f844fc9472a3	84c8d0ea-2a20-4da0-8da2-923f23cf41b7	t	f
4bd75ff6-4c0f-4fd6-ae5b-d24579dd0857	f9a74b67-c5b0-403d-b551-f844fc9472a3	ecdbae39-a985-4a62-9c46-6f7fefd925de	f	f
33b6ebcd-2ab1-4037-ad47-04e5390ae076	a75b39e6-b08e-4056-8aba-2261de49e2bd	ec08ce58-9cc4-4f75-b534-c07216246716	f	f
c262ea77-26be-48d2-a1b0-0821cc6f67b4	6e7fd6c7-4a9f-4835-820a-5258535d034b	ec08ce58-9cc4-4f75-b534-c07216246716	f	f
c8c8407d-d8f7-4e8e-8266-d62616d01b8d	249b440f-19be-4ca9-a1aa-6314237ae971	9c9fc6a9-1115-4b67-87be-27a9e415e0eb	f	f
022c540e-22ee-4e23-b52b-db36f6b5586b	e9d01f2b-6f41-4f4a-a218-3a783b4341fb	84c8d0ea-2a20-4da0-8da2-923f23cf41b7	t	f
ca025a91-9056-4d1e-b597-dfceb271c35f	e9d01f2b-6f41-4f4a-a218-3a783b4341fb	03d4ca93-22eb-48bb-a753-8c830d1c78ca	f	f
3d27264c-4a2a-4f17-9339-df347bc66b96	60337e6e-84c7-4002-b0ee-34607ed3dd33	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	f	f
4d5e2c9f-8727-4c52-95a4-5fe8322aa762	60337e6e-84c7-4002-b0ee-34607ed3dd33	d58f2c91-9e29-47b2-83c8-fa348bd72627	t	f
5b4b95c2-2ec4-4fcf-8b11-b5f97789e932	27ce7a03-c66e-43a7-ad04-07060668f471	a2ebaa96-46c5-43cf-83c6-7538cb3b4ce5	f	f
\.


--
-- Data for Name: scim_resource_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_resource_type (id, name, description, enabled, auto_filtering, auto_sorting, etag_enabled, disable_create, disable_get, disable_list, disable_update, disable_delete, require_authentication, service_provider_id, endpoint, is_default, is_or_on_roles, created, last_modified, scim_remote_provider_id, scim_client_update_strategy, attribute_naming_strategy, resource_assignment) FROM stdin;
fd98e74e-8b65-425b-a61d-21babad6c72b	User	User Account	t	f	f	f	f	f	f	f	f	t	\N	/Users	t	f	1729529661212	1729529661212	\N	\N	\N	\N
c96a57c2-03f7-4546-aa44-6e017d32bc8a	Group	Group	t	f	f	f	f	f	f	f	f	t	\N	/Groups	t	f	1729529661576	1729529661576	\N	\N	\N	\N
0628af7b-433c-4bfa-a27c-29599a7b2016	RealmRoles	Managing of Keycloak RealmRoles	t	f	f	f	f	f	f	f	f	t	\N	/RealmRoles	t	f	1729529661681	1729529661681	\N	\N	\N	\N
ecd0f0d2-2203-4725-8b74-fdcd490fd178	Group	Group	t	f	f	f	f	f	f	f	f	t	7a05e3dc-67a2-4d72-9e4a-d520817e5a7f	/Groups	f	f	1729530015714	1729530015714	\N	\N	\N	\N
f9a74b67-c5b0-403d-b551-f844fc9472a3	User	User Account	t	f	f	f	f	f	f	f	f	t	7a05e3dc-67a2-4d72-9e4a-d520817e5a7f	/Users	f	f	1729530015716	1729530015716	\N	\N	\N	\N
a75b39e6-b08e-4056-8aba-2261de49e2bd	RealmRoles	Managing of Keycloak RealmRoles	t	f	f	f	f	f	f	f	f	t	7a05e3dc-67a2-4d72-9e4a-d520817e5a7f	/RealmRoles	f	f	1729530015717	1729530015717	\N	\N	\N	\N
6e7fd6c7-4a9f-4835-820a-5258535d034b	RealmRoles	Managing of Keycloak RealmRoles	t	f	f	f	f	f	f	f	f	t	e9e02cbb-714f-4f8a-8be4-dcebe82aa427	/RealmRoles	f	f	1729531019307	1729531019307	\N	\N	\N	\N
249b440f-19be-4ca9-a1aa-6314237ae971	Group	Group	t	f	f	f	f	f	f	f	f	t	e9e02cbb-714f-4f8a-8be4-dcebe82aa427	/Groups	f	f	1729531019307	1729531019307	\N	\N	\N	\N
e9d01f2b-6f41-4f4a-a218-3a783b4341fb	User	User Account	t	f	f	f	f	f	f	f	f	t	e9e02cbb-714f-4f8a-8be4-dcebe82aa427	/Users	f	f	1729531019308	1729705255361	\N	\N	\N	\N
60337e6e-84c7-4002-b0ee-34607ed3dd33	User	User Account	t	f	f	f	f	f	f	f	f	f	\N	/Users	f	f	\N	\N	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	PATCH_RESOURCE	SIMPLE_NAME	USERS
27ce7a03-c66e-43a7-ad04-07060668f471	Group	Group	t	f	f	f	f	f	f	f	f	f	\N	/Groups	f	f	\N	\N	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1	PATCH_RESOURCE	SIMPLE_NAME	GROUPS
\.


--
-- Data for Name: scim_schema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_schema (id, modifiable, schema_id, name, description, created, last_modified, scim_remote_provider_id) FROM stdin;
ecdbae39-a985-4a62-9c46-6f7fefd925de	f	urn:ietf:params:scim:schemas:core:2.0:User	User	User Account	1729529660822	1729529660822	\N
84c8d0ea-2a20-4da0-8da2-923f23cf41b7	f	urn:ietf:params:scim:schemas:extension:enterprise:2.0:User	EnterpriseUser	Enterprise User	1729529660956	1729529660956	\N
9c9fc6a9-1115-4b67-87be-27a9e415e0eb	f	urn:ietf:params:scim:schemas:core:2.0:Group	Group	Group	1729529660981	1729529660981	\N
ec08ce58-9cc4-4f75-b534-c07216246716	f	urn:goldfish:params:scim:schemas:core:2.0:RealmRole	RealmRole	Representation of a RealmRole in Keycloak.	1729529661007	1729529661007	\N
03d4ca93-22eb-48bb-a753-8c830d1c78ca	t	urn:ietf:params:scim:schemas:core:2.0:User	LearnUser	User Account	1729705173194	1729705173194	\N
ca2d5c2d-a91f-44f0-869b-6340d5e316b9	f	urn:ietf:params:scim:schemas:core:2.0:User	User	User Account	1730736049885	1730736049885	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1
d58f2c91-9e29-47b2-83c8-fa348bd72627	f	urn:ietf:params:scim:schemas:extension:enterprise:2.0:User	EnterpriseUser	Enterprise User	1730736050037	1730736050037	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1
a2ebaa96-46c5-43cf-83c6-7538cb3b4ce5	f	urn:ietf:params:scim:schemas:core:2.0:Group	Group	Group	1730736050316	1730736050316	00cdcb48-e04a-4caf-8745-ae13ed0cc3e1
6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	t	urn:ietf:params:scim:schemas:core:2.0:User	User2	User Account	1738690456247	1738690456247	\N
\.


--
-- Data for Name: scim_schema_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_schema_attribute (id, schema_id, parent_attribute, modifiable, name, description, reference_types, canonical_values, scim_type, mutability, returned, uniqueness, multivalued, required, case_exact, min_length, max_length, min_items, max_items, pattern, minimum, maximum, multiple_of, ignore_in_filter_expression, default_value, not_before, not_after, created, last_modified, custom_attribute_name) FROM stdin;
ef6e2651-f0ea-4d72-8ded-476e162e25d1	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	id	Unique identifier for the SCIM Resource as defined by the Service Provider.	\N	\N	STRING	READ_ONLY	ALWAYS	SERVER	f	t	t	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660823	1729529660823	\N
36fe0471-c1f3-4f4c-985e-6b466c8b283c	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	externalId	A String that is an identifier for the resource as defined by the provisioning client.The service provider MUST always interpret the externalId as scoped to the provisioning domain.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	t	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660827	1729529660827	\N
7d1ca7a4-f3e1-4282-9dbd-0798fd9e89c6	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	userName	A service provider's unique identifier for the user, typically\nused by the user to directly authenticate to the service provider.Each User MUST include a non-empty userName value.  This identifier\nMUST be unique across the service provider's entire set of Users.	\N	\N	STRING	READ_WRITE	DEFAULT	SERVER	f	t	f	\N	\N	\N	\N	^(?!\\s*$).+	\N	\N	\N	f	\N	\N	\N	1729529660827	1729529660827	\N
fbf0f8cc-a7ed-41a5-990e-d313e2922d40	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	name	The components of the user's real name.Providers MAY return just the full name as a single string in the\nformatted sub-attribute, or they MAY return just the individual component attributes using the other sub-attributes, or they MAY\nreturn both.  If both variants are returned, they SHOULD be describing the same name, with the formatted name indicating how the\ncomponent attributes should be combined.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660828	1729529660828	\N
e2b428a6-15b4-433b-beb5-04159a502f48	ecdbae39-a985-4a62-9c46-6f7fefd925de	fbf0f8cc-a7ed-41a5-990e-d313e2922d40	f	formatted	The full name, including all middle names, titles, and suffixes as appropriate, formatted for display\n(e.g., 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660828	1729529660828	\N
25d28722-c616-457d-a334-6591d97307ea	ecdbae39-a985-4a62-9c46-6f7fefd925de	fbf0f8cc-a7ed-41a5-990e-d313e2922d40	f	familyName	The family name of the User, or last name in most Western languages (e.g., 'Jensen' given the full\nname 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660829	1729529660829	\N
81c6cfa6-919b-4d86-a431-edfb2c3746c0	ecdbae39-a985-4a62-9c46-6f7fefd925de	fbf0f8cc-a7ed-41a5-990e-d313e2922d40	f	givenName	The given name of the User, or first name in most Western languages (e.g., 'Barbara' given the\nfull name 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660829	1729529660829	\N
dd86200e-cf5b-45d1-a0af-3edc005bf4d4	ecdbae39-a985-4a62-9c46-6f7fefd925de	fbf0f8cc-a7ed-41a5-990e-d313e2922d40	f	middleName	The middle name(s) of the User (e.g., 'Jane' given the full name 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660830	1729529660830	\N
1d689792-daa1-4131-987b-151ae71ae54d	ecdbae39-a985-4a62-9c46-6f7fefd925de	fbf0f8cc-a7ed-41a5-990e-d313e2922d40	f	honorificPrefix	The honorific prefix(es) of the User, or title in most Western languages (e.g., 'Ms.' given the full name\n'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660830	1729529660830	\N
d9784977-fa09-46ee-9d96-8b44a1d1ae84	ecdbae39-a985-4a62-9c46-6f7fefd925de	fbf0f8cc-a7ed-41a5-990e-d313e2922d40	f	honorificSuffix	The honorific suffix(es) of the User, or suffix in most Western languages (e.g., 'III' given the full name\n'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660831	1729529660831	\N
76cf57f4-6a6d-4720-9aac-db57964f30c9	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	displayName	The name of the User, suitable for display\nto end-users.  The name SHOULD be the full name of the User being described, if known.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660831	1729529660831	\N
937c2484-a109-4d0b-9ef3-b74fdee3d11a	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	nickName	The casual way to address the user in real life, e.g., 'Bob' or 'Bobby' instead of 'Robert'.  This attribute\nSHOULD NOT be used to represent a User's username (e.g., 'bjensen' or 'mpepperidge').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660832	1729529660832	\N
07215787-0817-4a8e-9ce6-8e6e091eeb84	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	profileUrl	A fully qualified URL pointing to a page\nrepresenting the User's online profile.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660832	1729529660832	\N
ec3669f4-05cc-4507-82b2-53938e5cb533	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	title	The user's title, such as \\"Vice President.\\"	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660833	1729529660833	\N
a2c8a66f-e4c6-4a91-aff0-c6db806265c5	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	userType	Used to identify the relationship between the organization and the user.  Typical values used might be\n'Contractor', 'Employee', 'Intern', 'Temp', 'External', and 'Unknown', but any value may be used.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660834	1729529660834	\N
415cf077-8831-4189-96b4-6e01391babbc	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	preferredLanguage	Indicates the User's preferred written or\nspoken language.  Generally used for selecting a localized user interface; e.g., 'en_US' specifies the language English and country	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660834	1729529660834	\N
c785e6f7-4210-400a-92df-d5fea246f66e	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	locale	Used to indicate the User's default location\nfor purposes of localizing items such as currency, date time format, or numerical representations.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660834	1729529660834	\N
2c19e715-8690-4559-af93-b21a97b235cb	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	timezone	The User's time zone in the 'Olson' time zone\ndatabase format, e.g., 'America/Los_Angeles'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660835	1729529660835	\N
00ca9409-c0bb-4aa7-b66f-7f51ba28c8b1	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	active	A Boolean value indicating the User's administrative status.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660835	1729529660835	\N
bb766cf2-67f8-43fb-ade2-a4d7253685b8	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	password	The User's cleartext password.  This attribute is intended to be used as a means to specify an initial\npassword when creating a new User or to reset an existing User's password.	\N	\N	STRING	WRITE_ONLY	NEVER	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660835	1729529660835	\N
576c5f29-d52c-4062-845b-9ff94c27acf2	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	emails	Email addresses for the user.  The value SHOULD be canonicalized by the service provider, e.g.,\n'bjensen@example.com' instead of 'bjensen@EXAMPLE.COM'.Canonical type values of 'work', 'home', and 'other'.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660836	1729529660836	\N
628e1f06-4b26-4da8-8021-a93c779cdef3	ecdbae39-a985-4a62-9c46-6f7fefd925de	576c5f29-d52c-4062-845b-9ff94c27acf2	f	value	Email addresses for the user.  The value SHOULD be canonicalized by the service provider, e.g.,\n'bjensen@example.com' instead of 'bjensen@EXAMPLE.COM'.Canonical type values of 'work', 'home', and 'other'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660836	1729529660836	\N
1fa82393-3eab-48c1-9a5d-65a00b41e145	ecdbae39-a985-4a62-9c46-6f7fefd925de	576c5f29-d52c-4062-845b-9ff94c27acf2	f	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660836	1729529660836	\N
90950a29-746d-48c0-94e2-997df0897e13	9c9fc6a9-1115-4b67-87be-27a9e415e0eb	\N	f	id	Unique identifier for the SCIM Resource as defined by the Service Provider.	\N	\N	STRING	READ_ONLY	ALWAYS	SERVER	f	t	t	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660981	1729529660981	\N
97f789fb-78fa-4875-83ac-919da413fc61	ecdbae39-a985-4a62-9c46-6f7fefd925de	576c5f29-d52c-4062-845b-9ff94c27acf2	f	type	A label indicating the attribute's function, e.g., 'work' or 'home'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660837	1729529660837	\N
b705ddc5-40af-46b9-b7fc-ea47aac8a71c	ecdbae39-a985-4a62-9c46-6f7fefd925de	576c5f29-d52c-4062-845b-9ff94c27acf2	f	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the psreferred mailing address or primary email address.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660837	1729529660837	\N
edb755ed-918b-401c-a669-3fd5785b4775	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	phoneNumbers	Phone numbers for the User.  The value SHOULD be canonicalized by the service provider according to the\nformat specified in RFC 3966, e.g., 'tel:+1-201-555-0123'.Canonical type values of 'work', 'home', 'mobile', 'fax', 'pager	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660837	1729529660837	\N
78fc00fd-bf5b-4d6f-a65e-50bef6441d26	ecdbae39-a985-4a62-9c46-6f7fefd925de	edb755ed-918b-401c-a669-3fd5785b4775	f	value	Phone number of the User.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660838	1729529660838	\N
1ee3d435-34d3-4e9f-b66d-30377843b69f	ecdbae39-a985-4a62-9c46-6f7fefd925de	edb755ed-918b-401c-a669-3fd5785b4775	f	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660838	1729529660838	\N
5aae655e-f56f-4bcc-8956-07dafff29945	ecdbae39-a985-4a62-9c46-6f7fefd925de	edb755ed-918b-401c-a669-3fd5785b4775	f	type	A label indicating the attribute's function, e.g., 'work', 'home', 'mobile'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660839	1729529660839	\N
4596e2b8-544e-40b1-9c11-01a59e8e017a	ecdbae39-a985-4a62-9c46-6f7fefd925de	edb755ed-918b-401c-a669-3fd5785b4775	f	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the preferred\nphone number or primary phone number.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660839	1729529660839	\N
0f5f5fe2-20cc-4148-8b75-1c9e396dbac0	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	ims	Instant messaging addresses for the User.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660840	1729529660840	\N
324f4c2e-bf7c-4967-a895-276f45cfbae5	ecdbae39-a985-4a62-9c46-6f7fefd925de	0f5f5fe2-20cc-4148-8b75-1c9e396dbac0	f	value	Instant messaging address for the User.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660840	1729529660840	\N
b463e11d-c1b0-4928-bbbf-a515cbcb5141	ecdbae39-a985-4a62-9c46-6f7fefd925de	0f5f5fe2-20cc-4148-8b75-1c9e396dbac0	f	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660840	1729529660840	\N
3ad13002-5bb8-446d-a0be-e79291fef201	ecdbae39-a985-4a62-9c46-6f7fefd925de	0f5f5fe2-20cc-4148-8b75-1c9e396dbac0	f	type	A label indicating the attribute's function, e.g., 'aim', 'gtalk', 'xmpp'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660841	1729529660841	\N
ba7bb446-8580-4173-b3c4-16aa4bef547e	ecdbae39-a985-4a62-9c46-6f7fefd925de	0f5f5fe2-20cc-4148-8b75-1c9e396dbac0	f	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the preferred\nmessenger or primary messenger.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660841	1729529660841	\N
72e1c8f0-bd94-4676-8c4b-0ba57b4eca24	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	photos	URLs of photos of the User.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660841	1729529660841	\N
88f23f8b-d982-477d-a337-14c824db1cfa	ecdbae39-a985-4a62-9c46-6f7fefd925de	72e1c8f0-bd94-4676-8c4b-0ba57b4eca24	f	value	URLs of photos of the User.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660842	1729529660842	\N
68075ba2-2405-407d-9b5d-45ae4808d57a	ecdbae39-a985-4a62-9c46-6f7fefd925de	72e1c8f0-bd94-4676-8c4b-0ba57b4eca24	f	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660842	1729529660842	\N
9f6c0d9b-46d2-439e-aa25-7fbfb8356c1d	ecdbae39-a985-4a62-9c46-6f7fefd925de	72e1c8f0-bd94-4676-8c4b-0ba57b4eca24	f	type	A label indicating the attribute's function, i.e., 'photo' or 'thumbnail'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660842	1729529660842	\N
324e7582-c295-4cff-bff4-25ab082c8840	ecdbae39-a985-4a62-9c46-6f7fefd925de	72e1c8f0-bd94-4676-8c4b-0ba57b4eca24	f	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the preferred\nphone number or primary phone number. The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660843	1729529660843	\N
5ed2aeb2-67c5-4ffa-a0b0-b405c620096d	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	addresses	A physical mailing address for this User.\nCanonical type values of 'work', 'home', and 'other'.  This attribute is a complex type with the following sub-attributes.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660843	1729529660843	\N
8eed8b05-1f87-4beb-bf17-ee605bc5f3c5	ecdbae39-a985-4a62-9c46-6f7fefd925de	5ed2aeb2-67c5-4ffa-a0b0-b405c620096d	f	formatted	The full mailing address, formatted for display or use with a mailing label.  This attribute MAY contain\nnewlines.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660843	1729529660843	\N
48354a92-db31-49e3-8ac2-0489ef3a3bd7	ecdbae39-a985-4a62-9c46-6f7fefd925de	5ed2aeb2-67c5-4ffa-a0b0-b405c620096d	f	streetAddress	The full street address component, which may include house number, street name, P.O. box, and multi-line\nextended street address information.  This attribute MAY contain newlines.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660844	1729529660844	\N
5ce5fbcd-c258-4e82-844e-d1f39e434114	ecdbae39-a985-4a62-9c46-6f7fefd925de	5ed2aeb2-67c5-4ffa-a0b0-b405c620096d	f	locality	The city or locality component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660844	1729529660844	\N
b95cb3c2-dbc1-48b6-b233-ba970fc4e50b	ecdbae39-a985-4a62-9c46-6f7fefd925de	5ed2aeb2-67c5-4ffa-a0b0-b405c620096d	f	region	The state or region component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660844	1729529660844	\N
68473e9d-f67e-43af-9014-eaaaa8a618c0	ecdbae39-a985-4a62-9c46-6f7fefd925de	5ed2aeb2-67c5-4ffa-a0b0-b405c620096d	f	postalCode	The zip code or postal code component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660845	1729529660845	\N
19b44e64-d13b-4259-823a-40cf30d3399a	ecdbae39-a985-4a62-9c46-6f7fefd925de	5ed2aeb2-67c5-4ffa-a0b0-b405c620096d	f	country	The country name component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660845	1729529660845	\N
065fe93a-e798-4022-a035-cf2346c1c325	ecdbae39-a985-4a62-9c46-6f7fefd925de	5ed2aeb2-67c5-4ffa-a0b0-b405c620096d	f	type	A label indicating the attribute's function, e.g., 'work' or 'home'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660845	1729529660845	\N
19f4cb11-6115-42df-9a2d-8264e94278b3	ecdbae39-a985-4a62-9c46-6f7fefd925de	5ed2aeb2-67c5-4ffa-a0b0-b405c620096d	f	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.  The primary\nattribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660845	1729529660845	\N
c04db050-7c5f-4fa8-a6c3-7361c44fdae2	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	emailOptIn		\N	\N	INTEGER	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736103019	1730736103019	emailOptIn
43f4b370-ac09-4d39-83fd-89f880f45db3	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	groups	A list of groups to which the user belongs,\neither through direct membership, through nested groups, or dynamically calculated.	\N	\N	COMPLEX	READ_ONLY	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660846	1729529660846	\N
302bd2d9-709f-49ea-8b34-0509a93446c3	ecdbae39-a985-4a62-9c46-6f7fefd925de	43f4b370-ac09-4d39-83fd-89f880f45db3	f	value	The identifier of the User's group.	\N	\N	STRING	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660846	1729529660846	\N
2f39e140-3e54-4122-9c0d-ca3dca73ab60	ecdbae39-a985-4a62-9c46-6f7fefd925de	43f4b370-ac09-4d39-83fd-89f880f45db3	f	$ref	The uri of the corresponding 'Group' resource to which the user belongs.	resource	\N	REFERENCE	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660846	1729529660846	\N
8ddfdb2d-acad-46c6-ad34-388586354a68	ecdbae39-a985-4a62-9c46-6f7fefd925de	43f4b370-ac09-4d39-83fd-89f880f45db3	f	display	A human-readable name, primarily used for display purposes. READ-ONLY.	\N	\N	STRING	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660847	1729529660847	\N
d1ec1124-45c3-4e15-982c-9a54eb589ae4	ecdbae39-a985-4a62-9c46-6f7fefd925de	43f4b370-ac09-4d39-83fd-89f880f45db3	f	type	A label indicating the attribute's function, e.g., 'direct' or 'indirect'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660847	1729529660847	\N
4e123b2b-9a96-451e-ad88-d6ec0e2dd027	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	entitlements	A list of entitlements for the User that represent a thing the User has.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660847	1729529660847	\N
d81afb3a-d178-433d-88cc-2ac572480bed	ecdbae39-a985-4a62-9c46-6f7fefd925de	4e123b2b-9a96-451e-ad88-d6ec0e2dd027	f	value	The value of an entitlement.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660848	1729529660848	\N
3eb31177-cf28-4455-a32a-47c5da6c6c99	ecdbae39-a985-4a62-9c46-6f7fefd925de	4e123b2b-9a96-451e-ad88-d6ec0e2dd027	f	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660848	1729529660848	\N
fe32277c-7b63-4358-b609-5578492d909f	ecdbae39-a985-4a62-9c46-6f7fefd925de	4e123b2b-9a96-451e-ad88-d6ec0e2dd027	f	type	A label indicating the attribute's function.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660848	1729529660848	\N
eddba9f5-dc2a-489a-a923-f3cf1d7b251d	ecdbae39-a985-4a62-9c46-6f7fefd925de	4e123b2b-9a96-451e-ad88-d6ec0e2dd027	f	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.  The primary\nattribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660849	1729529660849	\N
18b31a85-3c69-4aef-bc5e-49e61003d6d9	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	roles	A list of roles for the User that collectively represent who the User is, e.g., 'Student', 'Faculty'.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660849	1729529660849	\N
bdcde3c3-5cfd-474a-8a86-9df27f42252a	ecdbae39-a985-4a62-9c46-6f7fefd925de	18b31a85-3c69-4aef-bc5e-49e61003d6d9	f	value	The value of a role.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660849	1729529660849	\N
728ba10e-9150-4a1d-b0f9-d9acc1e793fe	ecdbae39-a985-4a62-9c46-6f7fefd925de	18b31a85-3c69-4aef-bc5e-49e61003d6d9	f	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660850	1729529660850	\N
e76e748c-221b-47c9-9cfe-aaa528a7b324	ecdbae39-a985-4a62-9c46-6f7fefd925de	18b31a85-3c69-4aef-bc5e-49e61003d6d9	f	type	A label indicating the attribute's function.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660850	1729529660850	\N
afcf9052-faee-4361-9feb-feb48a9da76a	ecdbae39-a985-4a62-9c46-6f7fefd925de	18b31a85-3c69-4aef-bc5e-49e61003d6d9	f	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660850	1729529660850	\N
426880a3-61e2-4981-987c-175a3649fa1b	ecdbae39-a985-4a62-9c46-6f7fefd925de	\N	f	x509Certificates	A list of certificates issued to the User.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	SERVER	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660851	1729529660851	\N
7013cf8b-59e8-4d0a-881f-0d52260c518b	ecdbae39-a985-4a62-9c46-6f7fefd925de	426880a3-61e2-4981-987c-175a3649fa1b	f	value	The value of an X.509 certificate.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660851	1729529660851	\N
6228dbb6-3ca0-4afe-8ce0-ca2d4b19c0b3	ecdbae39-a985-4a62-9c46-6f7fefd925de	426880a3-61e2-4981-987c-175a3649fa1b	f	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660851	1729529660851	\N
caa664e2-d498-40f9-b0c0-6d57ef4d6fde	ecdbae39-a985-4a62-9c46-6f7fefd925de	426880a3-61e2-4981-987c-175a3649fa1b	f	type	A label indicating the attribute's function.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660852	1729529660852	\N
32f6cbde-e8d5-41f2-8951-7c06aeca30c6	ecdbae39-a985-4a62-9c46-6f7fefd925de	426880a3-61e2-4981-987c-175a3649fa1b	f	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660852	1729529660852	\N
1ead087e-f7c4-45b0-b27e-dbe0be106226	84c8d0ea-2a20-4da0-8da2-923f23cf41b7	\N	f	employeeNumber	Numeric or alphanumeric identifier assigned to a person, typically based on order of hire or association with an organization.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660956	1729529660956	\N
e1bfc9ad-8f3a-44a7-95aa-62e35cdbe1fb	84c8d0ea-2a20-4da0-8da2-923f23cf41b7	\N	f	costCenter	Identifies the name of a cost center.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660957	1729529660957	\N
9c4c690f-a83d-4e09-ade0-85ff158febeb	84c8d0ea-2a20-4da0-8da2-923f23cf41b7	\N	f	organization	Identifies the name of an organization.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660957	1729529660957	\N
d642f88b-54f6-4444-8b51-e5655eba4a0f	84c8d0ea-2a20-4da0-8da2-923f23cf41b7	\N	f	division	Identifies the name of a division.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660957	1729529660957	\N
f8752317-e439-4482-8e1f-18f580d4f3c7	84c8d0ea-2a20-4da0-8da2-923f23cf41b7	\N	f	department	Identifies the name of a department.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660958	1729529660958	\N
67225f56-e6ae-4a78-ad32-51787d63a5de	84c8d0ea-2a20-4da0-8da2-923f23cf41b7	\N	f	manager	The User's manager.  A complex type that optionally allows service providers to represent organizational hierarchy by referencing the 'id' attribute of another User.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660958	1729529660958	\N
fb703f26-3d87-41c9-bb89-9ae0205ca60f	84c8d0ea-2a20-4da0-8da2-923f23cf41b7	67225f56-e6ae-4a78-ad32-51787d63a5de	f	value	The id of the SCIM resource representing the User's manager.  REQUIRED.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	t	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660958	1729529660958	\N
6fc936b9-83bb-4473-94f8-35f99f103910	84c8d0ea-2a20-4da0-8da2-923f23cf41b7	67225f56-e6ae-4a78-ad32-51787d63a5de	f	$ref	The URI of the SCIM resource representing the User's manager.  REQUIRED.	resource	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660958	1729529660958	\N
9fb1691e-a673-4b49-b75f-2c47dd7182cd	84c8d0ea-2a20-4da0-8da2-923f23cf41b7	67225f56-e6ae-4a78-ad32-51787d63a5de	f	displayName	The displayName of the User's manager. OPTIONAL and READ-ONLY.	\N	\N	STRING	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660959	1729529660959	\N
960342de-25ad-4d09-8845-e5443e3cd97d	9c9fc6a9-1115-4b67-87be-27a9e415e0eb	\N	f	externalId	A String that is an identifier for the resource as defined by the provisioning client.The service provider MUST always interpret the externalId as scoped to the provisioning domain.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	t	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660982	1729529660982	\N
a7071d2e-d01a-4279-b00d-0f60855138b5	9c9fc6a9-1115-4b67-87be-27a9e415e0eb	\N	f	displayName	A human-readable name for the Group. REQUIRED.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	t	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660982	1729529660982	\N
ded59037-739f-4bf4-aea1-38b6a1418637	9c9fc6a9-1115-4b67-87be-27a9e415e0eb	\N	f	members	A list of members of the Group.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660982	1729529660982	\N
91e35dd2-b8ef-4c4b-8350-2ae2ba5e780d	9c9fc6a9-1115-4b67-87be-27a9e415e0eb	ded59037-739f-4bf4-aea1-38b6a1418637	f	value	Identifier of the member of this Group.	\N	\N	STRING	IMMUTABLE	DEFAULT	NONE	f	t	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660983	1729529660983	\N
2241aa38-b099-4b3c-aee6-284155746975	9c9fc6a9-1115-4b67-87be-27a9e415e0eb	ded59037-739f-4bf4-aea1-38b6a1418637	f	$ref	The uri corresponding to a SCIM resource that is a member of this Group.	resource	\N	REFERENCE	IMMUTABLE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660983	1729529660983	\N
4807391a-e4ee-4d29-8f76-d099bd78fff8	9c9fc6a9-1115-4b67-87be-27a9e415e0eb	ded59037-739f-4bf4-aea1-38b6a1418637	f	display	A human-readable name for the Member	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660984	1729529660984	\N
188b5a41-d08b-40eb-8954-3cc1a5137ded	9c9fc6a9-1115-4b67-87be-27a9e415e0eb	ded59037-739f-4bf4-aea1-38b6a1418637	f	type	A label indicating the type of resource, e.g. 'User' or 'Group'	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529660984	1729529660984	\N
ba69a8c0-208a-4e25-b85a-f97d9c629e48	ec08ce58-9cc4-4f75-b534-c07216246716	\N	f	id	The unique resource id.	\N	\N	STRING	READ_ONLY	ALWAYS	NONE	f	t	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529661007	1729529661007	\N
0efd85ca-53c6-45ed-bb59-29fe1b7ebad7	ec08ce58-9cc4-4f75-b534-c07216246716	\N	f	name	The name of the role	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	t	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729529661008	1729529661008	\N
aebed7ba-b6d0-465f-b190-7589ecd6e2c1	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	id	Unique identifier for the SCIM Resource as defined by the Service Provider.	\N	\N	STRING	READ_ONLY	ALWAYS	SERVER	f	t	t	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
d1542395-60dc-4e89-aaa4-07cf337a28af	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	externalId	A String that is an identifier for the resource as defined by the provisioning client.The service provider MUST always interpret the externalId as scoped to the provisioning domain.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	t	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
8228813f-4acb-4579-99e3-2a5cf0848fea	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	userName	A service provider's unique identifier for the user, typically\nused by the user to directly authenticate to the service provider.Each User MUST include a non-empty userName value.  This identifier\nMUST be unique across the service provider's entire set of Users.	\N	\N	STRING	READ_WRITE	DEFAULT	SERVER	f	t	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
2af5d67e-24e0-4003-a33a-957835cc208a	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	name	The components of the user's real name.Providers MAY return just the full name as a single string in the\nformatted sub-attribute, or they MAY return just the individual component attributes using the other sub-attributes, or they MAY\nreturn both.  If both variants are returned, they SHOULD be describing the same name, with the formatted name indicating how the\ncomponent attributes should be combined.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
fe13b084-d6d2-4b7d-8b5d-383458e97f29	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	2af5d67e-24e0-4003-a33a-957835cc208a	t	formatted	The full name, including all middle names, titles, and suffixes as appropriate, formatted for display\n(e.g., 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
987a4ec5-118d-4ef6-8534-eb2b76957a77	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	2af5d67e-24e0-4003-a33a-957835cc208a	t	familyName	The family name of the User, or last name in most Western languages (e.g., 'Jensen' given the full\nname 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
939691fc-f97e-444f-8342-76242415ec2e	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	2af5d67e-24e0-4003-a33a-957835cc208a	t	givenName	The given name of the User, or first name in most Western languages (e.g., 'Barbara' given the\nfull name 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
19ed1840-bfe0-4761-a674-2ff074f4237d	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	2af5d67e-24e0-4003-a33a-957835cc208a	t	middleName	The middle name(s) of the User (e.g., 'Jane' given the full name 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
aa7e9318-b770-4860-85fc-2c424972ce06	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	2af5d67e-24e0-4003-a33a-957835cc208a	t	honorificPrefix	The honorific prefix(es) of the User, or title in most Western languages (e.g., 'Ms.' given the full name\n'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
9c91b2f8-4b5f-4a58-ae27-d20fd0b193a4	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	2af5d67e-24e0-4003-a33a-957835cc208a	t	honorificSuffix	The honorific suffix(es) of the User, or suffix in most Western languages (e.g., 'III' given the full name\n'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
65d88ca9-0afd-44f6-8e8d-e956ee7f92f9	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	displayName	The name of the User, suitable for display\nto end-users.  The name SHOULD be the full name of the User being described, if known.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
eeb87095-a4a7-4e87-a241-bd29e1cf0ebc	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	nickName	The casual way to address the user in real life, e.g., 'Bob' or 'Bobby' instead of 'Robert'.  This attribute\nSHOULD NOT be used to represent a User's username (e.g., 'bjensen' or 'mpepperidge').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
61d84dd3-51a6-4300-9cca-42aaa183bcdd	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	profileUrl	A fully qualified URL pointing to a page\nrepresenting the User's online profile.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
69ff7c05-6a78-46e2-9bd3-8eae7385e7f6	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	title	The user's title, such as \\"Vice President.\\"	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
d17cd6e6-d0e2-417b-8d10-896cc8b1baf2	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	userType	Used to identify the relationship between the organization and the user.  Typical values used might be\n'Contractor', 'Employee', 'Intern', 'Temp', 'External', and 'Unknown', but any value may be used.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
a6604987-c1f5-4eed-bef0-01e23e3cac79	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	preferredLanguage	Indicates the User's preferred written or\nspoken language.  Generally used for selecting a localized user interface; e.g., 'en_US' specifies the language English and country	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
98b9a099-2499-437b-8dca-3d12f747f77c	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	locale	Used to indicate the User's default location\nfor purposes of localizing items such as currency, date time format, or numerical representations.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
38d7e311-bff7-4e64-a9da-665d23487871	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	timezone	The User's time zone in the 'Olson' time zone\ndatabase format, e.g., 'America/Los_Angeles'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
e6aac32d-0d61-4cb4-8aac-7c9494eb76e5	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	active	A Boolean value indicating the User's administrative status.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
8aa2a27c-db4c-49de-bc07-a1f738614ba6	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	password	The User's cleartext password.  This attribute is intended to be used as a means to specify an initial\npassword when creating a new User or to reset an existing User's password.	\N	\N	STRING	WRITE_ONLY	NEVER	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
0ef8e6f4-a047-43e9-b919-98c54477c09c	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	emails	Email addresses for the user.  The value SHOULD be canonicalized by the service provider, e.g.,\n'bjensen@example.com' instead of 'bjensen@EXAMPLE.COM'.Canonical type values of 'work', 'home', and 'other'.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
f71fa2e9-e3ab-4633-89de-c7fcd5865628	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	0ef8e6f4-a047-43e9-b919-98c54477c09c	t	value	Email addresses for the user.  The value SHOULD be canonicalized by the service provider, e.g.,\n'bjensen@example.com' instead of 'bjensen@EXAMPLE.COM'.Canonical type values of 'work', 'home', and 'other'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
2a3c967c-978e-47b6-b05f-c2c0aa2748c9	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	0ef8e6f4-a047-43e9-b919-98c54477c09c	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
939956e4-b90f-443d-854c-47baf4e2e0c3	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	0ef8e6f4-a047-43e9-b919-98c54477c09c	t	type	A label indicating the attribute's function, e.g., 'work' or 'home'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
bb1421af-bcdf-466a-b544-b51200677a51	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	0ef8e6f4-a047-43e9-b919-98c54477c09c	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the psreferred mailing address or primary email address.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
572bc080-127f-4b5f-887f-15a39bbbf3fc	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	phoneNumbers	Phone numbers for the User.  The value SHOULD be canonicalized by the service provider according to the\nformat specified in RFC 3966, e.g., 'tel:+1-201-555-0123'.Canonical type values of 'work', 'home', 'mobile', 'fax', 'pager	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
493a890b-0685-4ee9-96e5-c6ea4e313d0e	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	572bc080-127f-4b5f-887f-15a39bbbf3fc	t	value	Phone number of the User.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
9ab39cbd-2796-4b87-b40f-c035e473f673	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	572bc080-127f-4b5f-887f-15a39bbbf3fc	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
55658a4f-07fb-4723-900e-48b6f07650c8	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	572bc080-127f-4b5f-887f-15a39bbbf3fc	t	type	A label indicating the attribute's function, e.g., 'work', 'home', 'mobile'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
8b5f9217-0cbf-4ee9-8f76-f5f54e38917a	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	572bc080-127f-4b5f-887f-15a39bbbf3fc	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the preferred\nphone number or primary phone number.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
ec365d7e-708e-473b-9de1-40f13a99a8e5	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	ims	Instant messaging addresses for the User.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
7f574a3f-8b04-4eaf-ba1c-6e573b4c3b5a	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	ec365d7e-708e-473b-9de1-40f13a99a8e5	t	value	Instant messaging address for the User.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
0737853c-557c-4020-8267-8f12b6170d1b	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	ec365d7e-708e-473b-9de1-40f13a99a8e5	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
f9b3e723-1574-42fd-b7f6-d4f1aad06f37	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	ec365d7e-708e-473b-9de1-40f13a99a8e5	t	type	A label indicating the attribute's function, e.g., 'aim', 'gtalk', 'xmpp'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
57feb57a-cb66-4dc6-8949-1a26cf4053fd	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	ec365d7e-708e-473b-9de1-40f13a99a8e5	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the preferred\nmessenger or primary messenger.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
bc731a65-338e-4cd9-b0bd-79f83b978769	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	photos	URLs of photos of the User.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
ed25c52b-bf32-4a8e-85b4-4fd53b101118	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	bc731a65-338e-4cd9-b0bd-79f83b978769	t	value	URLs of photos of the User.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
93f1ed25-287c-4988-aa74-fc6b3b15a424	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	bc731a65-338e-4cd9-b0bd-79f83b978769	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
21e39361-208d-465e-92be-612f8e2cc1aa	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	bc731a65-338e-4cd9-b0bd-79f83b978769	t	type	A label indicating the attribute's function, i.e., 'photo' or 'thumbnail'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
5b84048b-a51c-4e5a-9ccc-e3f7e465f180	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	bc731a65-338e-4cd9-b0bd-79f83b978769	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the preferred\nphone number or primary phone number. The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
655b42c2-5900-4374-9c47-73c909cd553f	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	addresses	A physical mailing address for this User.\nCanonical type values of 'work', 'home', and 'other'.  This attribute is a complex type with the following sub-attributes.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
13999cdb-48b7-4395-a094-904d1781ce7b	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	655b42c2-5900-4374-9c47-73c909cd553f	t	formatted	The full mailing address, formatted for display or use with a mailing label.  This attribute MAY contain\nnewlines.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
33f15057-35ef-4597-a092-b9932405e3c4	03d4ca93-22eb-48bb-a753-8c830d1c78ca	e3af3ec6-a9c9-43b6-8865-0f7490c8e50d	t	value	Instant messaging address for the User.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173188	1729705173188	\N
2cf4ec51-9516-4207-ac43-ba3e1114716d	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	655b42c2-5900-4374-9c47-73c909cd553f	t	streetAddress	The full street address component, which may include house number, street name, P.O. box, and multi-line\nextended street address information.  This attribute MAY contain newlines.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
0420abe5-6cb8-4d1c-b324-48afe1afddcd	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	655b42c2-5900-4374-9c47-73c909cd553f	t	locality	The city or locality component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
c460018f-85b3-4604-be4c-5a3a2fbdd17e	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	655b42c2-5900-4374-9c47-73c909cd553f	t	region	The state or region component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
2bbcfd80-9fcb-4192-9a44-6abace4d5604	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	655b42c2-5900-4374-9c47-73c909cd553f	t	postalCode	The zip code or postal code component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
c6d642fa-394a-4676-a1c6-bb36e472f18c	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	655b42c2-5900-4374-9c47-73c909cd553f	t	country	The country name component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
649fcf43-3139-4ec1-a723-8a075ef80a88	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	655b42c2-5900-4374-9c47-73c909cd553f	t	type	A label indicating the attribute's function, e.g., 'work' or 'home'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
a3183e12-e22c-4f7e-9195-1eb7ad2ee89f	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	655b42c2-5900-4374-9c47-73c909cd553f	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.  The primary\nattribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
1adbf621-f4b6-430d-b89d-1e72adf76827	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	groups	A list of groups to which the user belongs,\neither through direct membership, through nested groups, or dynamically calculated.	\N	\N	COMPLEX	READ_ONLY	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
68c2f373-380f-469f-9bfe-a1d83f22d064	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	1adbf621-f4b6-430d-b89d-1e72adf76827	t	value	The identifier of the User's group.	\N	\N	STRING	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
651090b3-4462-49c5-a7c2-61785e139a91	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	1adbf621-f4b6-430d-b89d-1e72adf76827	t	$ref	The uri of the corresponding 'Group' resource to which the user belongs.	resource	\N	REFERENCE	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
bdb552d6-6cb7-493d-bdcd-dab9a1a09a84	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	1adbf621-f4b6-430d-b89d-1e72adf76827	t	display	A human-readable name, primarily used for display purposes. READ-ONLY.	\N	\N	STRING	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
bb9da54a-216a-4f96-82c3-2ec36514e839	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	1adbf621-f4b6-430d-b89d-1e72adf76827	t	type	A label indicating the attribute's function, e.g., 'direct' or 'indirect'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
5336b16f-5e9a-4f73-b7c0-ab4d5328a33d	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	entitlements	A list of entitlements for the User that represent a thing the User has.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
5eb2b586-25f8-40b4-a731-703fdf4cf368	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	5336b16f-5e9a-4f73-b7c0-ab4d5328a33d	t	value	The value of an entitlement.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
03221917-31d8-418a-8858-20fb6398e140	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	groups	A list of groups to which the user belongs,\neither through direct membership, through nested groups, or dynamically calculated.	\N	\N	COMPLEX	READ_ONLY	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173094	1729705173094	\N
5e718085-6d18-410a-8f57-410ed111d59d	03d4ca93-22eb-48bb-a753-8c830d1c78ca	03221917-31d8-418a-8858-20fb6398e140	t	value	The identifier of the User's group.	\N	\N	STRING	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173095	1729705173095	\N
b2453a7c-fbdd-4369-8d56-934e6ca5d0b0	03d4ca93-22eb-48bb-a753-8c830d1c78ca	03221917-31d8-418a-8858-20fb6398e140	t	$ref	The uri of the corresponding 'Group' resource to which the user belongs.	resource	\N	REFERENCE	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173100	1729705173100	\N
669c5f6a-04de-4ce7-a896-6903fe2c5d26	03d4ca93-22eb-48bb-a753-8c830d1c78ca	03221917-31d8-418a-8858-20fb6398e140	t	display	A human-readable name, primarily used for display purposes. READ-ONLY.	\N	\N	STRING	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173102	1729705173102	\N
7deca8b8-a83d-4caa-8f62-67a7353225d8	03d4ca93-22eb-48bb-a753-8c830d1c78ca	03221917-31d8-418a-8858-20fb6398e140	t	type	A label indicating the attribute's function, e.g., 'direct' or 'indirect'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173103	1729705173103	\N
f29c90d3-117c-443b-9de3-1df8a912f503	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	phoneNumbers	Phone numbers for the User.  The value SHOULD be canonicalized by the service provider according to the\nformat specified in RFC 3966, e.g., 'tel:+1-201-555-0123'.Canonical type values of 'work', 'home', 'mobile', 'fax', 'pager	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173105	1729705173105	\N
0430e1b9-4b47-40f4-93f9-de5de2051bff	03d4ca93-22eb-48bb-a753-8c830d1c78ca	f29c90d3-117c-443b-9de3-1df8a912f503	t	value	Phone number of the User.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173106	1729705173106	\N
87bca39b-87fc-4eb6-bdcb-49cde1a26f9c	03d4ca93-22eb-48bb-a753-8c830d1c78ca	f29c90d3-117c-443b-9de3-1df8a912f503	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173108	1729705173108	\N
7edcde73-5a83-4a58-a132-371d3ebb8021	03d4ca93-22eb-48bb-a753-8c830d1c78ca	f29c90d3-117c-443b-9de3-1df8a912f503	t	type	A label indicating the attribute's function, e.g., 'work', 'home', 'mobile'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173110	1729705173110	\N
9bb041fe-3128-43a7-a223-687d3d111441	03d4ca93-22eb-48bb-a753-8c830d1c78ca	f29c90d3-117c-443b-9de3-1df8a912f503	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the preferred\nphone number or primary phone number.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173111	1729705173111	\N
53041391-dcc9-48b4-99c8-9015853ec2b3	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	name	The components of the user's real name.Providers MAY return just the full name as a single string in the\nformatted sub-attribute, or they MAY return just the individual component attributes using the other sub-attributes, or they MAY\nreturn both.  If both variants are returned, they SHOULD be describing the same name, with the formatted name indicating how the\ncomponent attributes should be combined.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173112	1729705173112	\N
adbd9cc1-d14b-49a9-9dfd-c6390dbda97e	03d4ca93-22eb-48bb-a753-8c830d1c78ca	53041391-dcc9-48b4-99c8-9015853ec2b3	t	formatted	The full name, including all middle names, titles, and suffixes as appropriate, formatted for display\n(e.g., 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173113	1729705173113	\N
64ef8660-61f4-4826-ac19-4cd1c9897b89	03d4ca93-22eb-48bb-a753-8c830d1c78ca	53041391-dcc9-48b4-99c8-9015853ec2b3	t	familyName	The family name of the User, or last name in most Western languages (e.g., 'Jensen' given the full\nname 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173114	1729705173114	\N
59ed003b-7d63-44a2-9c11-e77c5d6703d9	03d4ca93-22eb-48bb-a753-8c830d1c78ca	53041391-dcc9-48b4-99c8-9015853ec2b3	t	givenName	The given name of the User, or first name in most Western languages (e.g., 'Barbara' given the\nfull name 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173115	1729705173115	\N
a1ffb22c-a2c5-400f-8d01-e94b09b4df09	03d4ca93-22eb-48bb-a753-8c830d1c78ca	53041391-dcc9-48b4-99c8-9015853ec2b3	t	middleName	The middle name(s) of the User (e.g., 'Jane' given the full name 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173116	1729705173116	\N
da5615ad-22fa-4e78-bdd8-d1fe8faa3eb3	03d4ca93-22eb-48bb-a753-8c830d1c78ca	53041391-dcc9-48b4-99c8-9015853ec2b3	t	honorificPrefix	The honorific prefix(es) of the User, or title in most Western languages (e.g., 'Ms.' given the full name\n'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173118	1729705173118	\N
fdc50e11-2958-46d0-b6c6-d3506848a882	03d4ca93-22eb-48bb-a753-8c830d1c78ca	53041391-dcc9-48b4-99c8-9015853ec2b3	t	honorificSuffix	The honorific suffix(es) of the User, or suffix in most Western languages (e.g., 'III' given the full name\n'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173119	1729705173119	\N
ad930401-58ec-4b12-8dbb-6ebeae2b45c9	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	id	Unique identifier for the SCIM Resource as defined by the Service Provider.	\N	\N	STRING	READ_ONLY	ALWAYS	SERVER	f	t	t	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173121	1729705173121	\N
a5a3069f-fedd-4c69-b64d-f3157c4da6aa	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	externalId	A String that is an identifier for the resource as defined by the provisioning client.The service provider MUST always interpret the externalId as scoped to the provisioning domain.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	t	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173122	1729705173122	\N
37850bca-1962-4067-b9b6-04790c9028be	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	userName	A service provider's unique identifier for the user, typically\nused by the user to directly authenticate to the service provider.Each User MUST include a non-empty userName value.  This identifier\nMUST be unique across the service provider's entire set of Users.	\N	\N	STRING	READ_WRITE	DEFAULT	SERVER	f	t	f	\N	\N	\N	\N	^(?!\\s*$).+	\N	\N	\N	f	\N	\N	\N	1729705173123	1729705173123	\N
d5421643-1c0c-4cfb-a35b-cd88425aabe4	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	nickName	The casual way to address the user in real life, e.g., 'Bob' or 'Bobby' instead of 'Robert'.  This attribute\nSHOULD NOT be used to represent a User's username (e.g., 'bjensen' or 'mpepperidge').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173126	1729705173126	\N
286eae18-e855-4729-8a89-c3c1ac6491a5	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	profileUrl	A fully qualified URL pointing to a page\nrepresenting the User's online profile.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173127	1729705173127	\N
1dc901f7-e142-4c88-9a33-0a1be380de3a	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	title	The user's title, such as \\"Vice President.\\"	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173129	1729705173129	\N
19186014-2d87-4c63-95fe-55abffef6617	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	userType	Used to identify the relationship between the organization and the user.  Typical values used might be\n'Contractor', 'Employee', 'Intern', 'Temp', 'External', and 'Unknown', but any value may be used.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173130	1729705173130	\N
719a0b61-df27-4faa-bab5-d203319883e7	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	preferredLanguage	Indicates the User's preferred written or\nspoken language.  Generally used for selecting a localized user interface; e.g., 'en_US' specifies the language English and country	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173130	1729705173130	\N
5a97d718-2d3a-40ce-85d3-21d089e49a2f	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	locale	Used to indicate the User's default location\nfor purposes of localizing items such as currency, date time format, or numerical representations.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173131	1729705173131	\N
5905dbaa-aad4-46b6-93cc-a5a42d003b05	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	timezone	The User's time zone in the 'Olson' time zone\ndatabase format, e.g., 'America/Los_Angeles'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173132	1729705173132	\N
67ed553c-3f11-4b61-bce8-a28e799266a5	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	active	A Boolean value indicating the User's administrative status.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173134	1729705173134	\N
704faeae-92b2-441c-ad0c-8a0eb5007371	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	password	The User's cleartext password.  This attribute is intended to be used as a means to specify an initial\npassword when creating a new User or to reset an existing User's password.	\N	\N	STRING	WRITE_ONLY	NEVER	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173135	1729705173135	\N
9483e5ec-65fa-417d-a0a4-ff802d193bea	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	addresses	A physical mailing address for this User.\nCanonical type values of 'work', 'home', and 'other'.  This attribute is a complex type with the following sub-attributes.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173136	1729705173136	\N
6f0567d3-b12b-4b6d-89b5-479eeffab59f	03d4ca93-22eb-48bb-a753-8c830d1c78ca	9483e5ec-65fa-417d-a0a4-ff802d193bea	t	formatted	The full mailing address, formatted for display or use with a mailing label.  This attribute MAY contain\nnewlines.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173137	1729705173137	\N
efb561da-d21d-4548-a138-c93da23a36a7	03d4ca93-22eb-48bb-a753-8c830d1c78ca	9483e5ec-65fa-417d-a0a4-ff802d193bea	t	streetAddress	The full street address component, which may include house number, street name, P.O. box, and multi-line\nextended street address information.  This attribute MAY contain newlines.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173138	1729705173138	\N
b0546a1f-7fed-4b3e-8c00-f5d3463ac7e7	03d4ca93-22eb-48bb-a753-8c830d1c78ca	9483e5ec-65fa-417d-a0a4-ff802d193bea	t	locality	The city or locality component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173139	1729705173139	\N
48942e80-670e-484d-9c21-ce9a03af6b8d	03d4ca93-22eb-48bb-a753-8c830d1c78ca	9483e5ec-65fa-417d-a0a4-ff802d193bea	t	region	The state or region component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173141	1729705173141	\N
2a1fd76f-6665-4aee-b707-fe5b6cc3a8dd	03d4ca93-22eb-48bb-a753-8c830d1c78ca	9483e5ec-65fa-417d-a0a4-ff802d193bea	t	postalCode	The zip code or postal code component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173142	1729705173142	\N
e3d9ab76-141a-4010-9261-4a48654661a8	03d4ca93-22eb-48bb-a753-8c830d1c78ca	9483e5ec-65fa-417d-a0a4-ff802d193bea	t	country	The country name component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173144	1729705173144	\N
5653313d-9efb-4207-a06b-c8d8335b53f7	03d4ca93-22eb-48bb-a753-8c830d1c78ca	9483e5ec-65fa-417d-a0a4-ff802d193bea	t	type	A label indicating the attribute's function, e.g., 'work' or 'home'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173145	1729705173145	\N
0b6b3951-96fa-499a-9662-37ac144fa2d3	03d4ca93-22eb-48bb-a753-8c830d1c78ca	9483e5ec-65fa-417d-a0a4-ff802d193bea	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.  The primary\nattribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173146	1729705173146	\N
534786f4-76b3-493d-91a3-403d0a5efcb4	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	photos	URLs of photos of the User.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173147	1729705173147	\N
401b355a-f4c8-4f2a-ae8d-f3f13d935280	03d4ca93-22eb-48bb-a753-8c830d1c78ca	534786f4-76b3-493d-91a3-403d0a5efcb4	t	value	URLs of photos of the User.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173148	1729705173148	\N
b2b1f6d6-6703-4390-878a-7d007d93375e	03d4ca93-22eb-48bb-a753-8c830d1c78ca	534786f4-76b3-493d-91a3-403d0a5efcb4	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173150	1729705173150	\N
1a31cd9b-da7b-40e0-8f2d-80b30b242fb5	03d4ca93-22eb-48bb-a753-8c830d1c78ca	534786f4-76b3-493d-91a3-403d0a5efcb4	t	type	A label indicating the attribute's function, i.e., 'photo' or 'thumbnail'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173152	1729705173152	\N
31d4aa9b-e8b4-4500-b8be-3f85bfb0c277	03d4ca93-22eb-48bb-a753-8c830d1c78ca	534786f4-76b3-493d-91a3-403d0a5efcb4	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the preferred\nphone number or primary phone number. The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173154	1729705173154	\N
ee9269b0-9e72-4324-bda5-457318841196	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	x509Certificates	A list of certificates issued to the User.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	SERVER	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173155	1729705173155	\N
89660ebd-4430-4db4-a4cb-19926928b7fb	03d4ca93-22eb-48bb-a753-8c830d1c78ca	ee9269b0-9e72-4324-bda5-457318841196	t	value	The value of an X.509 certificate.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173157	1729705173157	\N
a2e5248b-4d89-472f-a3de-1c6acf539295	03d4ca93-22eb-48bb-a753-8c830d1c78ca	ee9269b0-9e72-4324-bda5-457318841196	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173158	1729705173158	\N
57a4f36c-b546-48be-acc8-165d84bffff8	03d4ca93-22eb-48bb-a753-8c830d1c78ca	ee9269b0-9e72-4324-bda5-457318841196	t	type	A label indicating the attribute's function.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173159	1729705173159	\N
8731bb8d-39d9-4f35-a579-73139d5e1591	03d4ca93-22eb-48bb-a753-8c830d1c78ca	ee9269b0-9e72-4324-bda5-457318841196	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173160	1729705173160	\N
29e15b5a-2f6b-4e2d-bd5a-9eb366ff1cd9	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	entitlements	A list of entitlements for the User that represent a thing the User has.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173161	1729705173161	\N
7a7a4911-554d-41c6-95a7-00c5f6318a83	03d4ca93-22eb-48bb-a753-8c830d1c78ca	29e15b5a-2f6b-4e2d-bd5a-9eb366ff1cd9	t	value	The value of an entitlement.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173162	1729705173162	\N
b116ba71-a7b6-4c4e-9a38-22585ec3659b	03d4ca93-22eb-48bb-a753-8c830d1c78ca	29e15b5a-2f6b-4e2d-bd5a-9eb366ff1cd9	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173163	1729705173163	\N
7aa51490-c0a0-4ff3-bfd9-819fd157783c	03d4ca93-22eb-48bb-a753-8c830d1c78ca	29e15b5a-2f6b-4e2d-bd5a-9eb366ff1cd9	t	type	A label indicating the attribute's function.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173164	1729705173164	\N
0c2e2dc9-e86a-46cb-9b7a-bd4edfd65370	03d4ca93-22eb-48bb-a753-8c830d1c78ca	29e15b5a-2f6b-4e2d-bd5a-9eb366ff1cd9	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.  The primary\nattribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173165	1729705173165	\N
f76bb4cc-ed14-46cf-8fae-ea84df6d54a2	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	roles	A list of roles for the User that collectively represent who the User is, e.g., 'Student', 'Faculty'.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173170	1729705173170	\N
9afd44af-a0cf-4c25-972c-8653aec22cf8	03d4ca93-22eb-48bb-a753-8c830d1c78ca	f76bb4cc-ed14-46cf-8fae-ea84df6d54a2	t	value	The value of a role.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173171	1729705173171	\N
3a6ceef3-2287-4614-9d5e-e20ac66e5760	03d4ca93-22eb-48bb-a753-8c830d1c78ca	f76bb4cc-ed14-46cf-8fae-ea84df6d54a2	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173174	1729705173174	\N
d7927988-5917-43f0-9e97-470c31fce9a5	03d4ca93-22eb-48bb-a753-8c830d1c78ca	f76bb4cc-ed14-46cf-8fae-ea84df6d54a2	t	type	A label indicating the attribute's function.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173178	1729705173178	\N
5a95ae77-29a8-4e3d-a095-1a1803e00d2b	03d4ca93-22eb-48bb-a753-8c830d1c78ca	f76bb4cc-ed14-46cf-8fae-ea84df6d54a2	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173179	1729705173179	\N
e43dab69-378b-45cc-95c8-ea44a8db19a4	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	emails	Email addresses for the user.  The value SHOULD be canonicalized by the service provider, e.g.,\n'bjensen@example.com' instead of 'bjensen@EXAMPLE.COM'.Canonical type values of 'work', 'home', and 'other'.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173180	1729705173180	\N
94746b9a-15c3-40d9-b3c8-49d7b635dcb8	03d4ca93-22eb-48bb-a753-8c830d1c78ca	e43dab69-378b-45cc-95c8-ea44a8db19a4	t	value	Email addresses for the user.  The value SHOULD be canonicalized by the service provider, e.g.,\n'bjensen@example.com' instead of 'bjensen@EXAMPLE.COM'.Canonical type values of 'work', 'home', and 'other'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173181	1729705173181	\N
cde14e01-0dae-4e14-a6fb-191409638b63	03d4ca93-22eb-48bb-a753-8c830d1c78ca	e43dab69-378b-45cc-95c8-ea44a8db19a4	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173182	1729705173182	\N
e882fe38-0c61-4d2b-bd5c-938d04dc805e	03d4ca93-22eb-48bb-a753-8c830d1c78ca	e43dab69-378b-45cc-95c8-ea44a8db19a4	t	type	A label indicating the attribute's function, e.g., 'work' or 'home'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173183	1729705173183	\N
dd81390d-fb59-459f-93f0-cb48c7c4b8a9	03d4ca93-22eb-48bb-a753-8c830d1c78ca	e43dab69-378b-45cc-95c8-ea44a8db19a4	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the psreferred mailing address or primary email address.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173185	1729705173185	\N
e3af3ec6-a9c9-43b6-8865-0f7490c8e50d	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	ims	Instant messaging addresses for the User.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173187	1729705173187	\N
6a7ace4b-b6b2-471d-a9c8-a3b8775a7eec	03d4ca93-22eb-48bb-a753-8c830d1c78ca	e3af3ec6-a9c9-43b6-8865-0f7490c8e50d	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173189	1729705173189	\N
4130127d-0d33-4418-819d-3a18f809de3d	03d4ca93-22eb-48bb-a753-8c830d1c78ca	e3af3ec6-a9c9-43b6-8865-0f7490c8e50d	t	type	A label indicating the attribute's function, e.g., 'aim', 'gtalk', 'xmpp'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173192	1729705173192	\N
d767e89d-7bbd-4313-8058-73143dff2b95	03d4ca93-22eb-48bb-a753-8c830d1c78ca	e3af3ec6-a9c9-43b6-8865-0f7490c8e50d	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the preferred\nmessenger or primary messenger.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705173193	1729705173193	\N
f8992d7d-a250-41d6-b169-00660217f36a	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	5336b16f-5e9a-4f73-b7c0-ab4d5328a33d	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
ff924648-846a-4409-b9b2-7041e6247b8d	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	5336b16f-5e9a-4f73-b7c0-ab4d5328a33d	t	type	A label indicating the attribute's function.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
41797f9b-d9b9-4f6e-b311-ed13fe0ee8b5	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	5336b16f-5e9a-4f73-b7c0-ab4d5328a33d	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.  The primary\nattribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
562f5ab4-4035-49c2-afa1-a8750456cfc8	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	roles	A list of roles for the User that collectively represent who the User is, e.g., 'Student', 'Faculty'.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
2db92802-4238-4afb-8ce7-eb22e3b91b08	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	562f5ab4-4035-49c2-afa1-a8750456cfc8	t	value	The value of a role.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
6db14b05-08c7-46dc-be40-33eee1745335	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	562f5ab4-4035-49c2-afa1-a8750456cfc8	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
e8e73c5d-ba5e-4c27-96de-09cf67bbf6b2	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	562f5ab4-4035-49c2-afa1-a8750456cfc8	t	type	A label indicating the attribute's function.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
1abb01c7-90c5-4fa9-bede-b203f0bbf2cf	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	562f5ab4-4035-49c2-afa1-a8750456cfc8	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
fe2b67a6-9c30-4d8b-bee3-1a9cb56d2f28	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	x509Certificates	A list of certificates issued to the User.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	SERVER	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
1dd94bb0-dfd7-419a-92e7-5cc2b7741fe0	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	emailOptIn	email opt in	\N	\N	INTEGER	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729705213871	1729705213871	emailOptIn
62fb57ed-ce70-413e-a5f3-574ab01a387a	03d4ca93-22eb-48bb-a753-8c830d1c78ca	\N	t	displayName	The name of the User, suitable for displayto end-users.  The name SHOULD be the full name of the User being described, if known.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1729879743267	1729705222441	fullName
706c6c25-8b4c-4fa4-bc15-2990ce9ed7fe	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	fe2b67a6-9c30-4d8b-bee3-1a9cb56d2f28	t	value	The value of an X.509 certificate.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
2b474097-f10c-41e7-83bc-d19ce970db4b	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	fe2b67a6-9c30-4d8b-bee3-1a9cb56d2f28	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
a545e69c-ba41-4a1f-af35-781bfb169601	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	fe2b67a6-9c30-4d8b-bee3-1a9cb56d2f28	t	type	A label indicating the attribute's function.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
cbc5ca2c-b935-4fbc-bde3-e0408d42a328	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	fe2b67a6-9c30-4d8b-bee3-1a9cb56d2f28	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736049885	1730736049885	\N
99776084-c89e-41eb-b612-39e3b74f65a5	d58f2c91-9e29-47b2-83c8-fa348bd72627	\N	t	employeeNumber	Numeric or alphanumeric identifier assigned to a person, typically based on order of hire or association with an organization.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050037	1730736050037	\N
6e9d442f-9b6f-4b86-9c95-3250a737f420	d58f2c91-9e29-47b2-83c8-fa348bd72627	\N	t	costCenter	Identifies the name of a cost center.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050037	1730736050037	\N
cbd3d121-b669-431f-8c1b-28170c354dcd	d58f2c91-9e29-47b2-83c8-fa348bd72627	\N	t	organization	Identifies the name of an organization.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050037	1730736050037	\N
a9ef40eb-d821-43fb-bbed-7b3674eadb21	d58f2c91-9e29-47b2-83c8-fa348bd72627	\N	t	division	Identifies the name of a division.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050037	1730736050037	\N
91a9033c-0654-4069-8830-d5b887898238	d58f2c91-9e29-47b2-83c8-fa348bd72627	\N	t	department	Identifies the name of a department.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050037	1730736050037	\N
f0110c13-8d93-4eb8-bbd1-e98d204a9225	d58f2c91-9e29-47b2-83c8-fa348bd72627	\N	t	manager	The User's manager.  A complex type that optionally allows service providers to represent organizational hierarchy by referencing the 'id' attribute of another User.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050037	1730736050037	\N
d306346c-6bda-4701-affd-ec323d61b07b	d58f2c91-9e29-47b2-83c8-fa348bd72627	f0110c13-8d93-4eb8-bbd1-e98d204a9225	t	value	The id of the SCIM resource representing the User's manager.  REQUIRED.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	t	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050037	1730736050037	\N
c99ee217-ece2-4c22-bade-238d6231f370	d58f2c91-9e29-47b2-83c8-fa348bd72627	f0110c13-8d93-4eb8-bbd1-e98d204a9225	t	$ref	The URI of the SCIM resource representing the User's manager.  REQUIRED.	resource	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050037	1730736050037	\N
de49bdd2-ba91-4855-862a-56583c6cbca7	d58f2c91-9e29-47b2-83c8-fa348bd72627	f0110c13-8d93-4eb8-bbd1-e98d204a9225	t	displayName	The displayName of the User's manager. OPTIONAL and READ-ONLY.	\N	\N	STRING	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050037	1730736050037	\N
f1f61d66-1843-49e6-a074-fd22d1d9ec1e	a2ebaa96-46c5-43cf-83c6-7538cb3b4ce5	\N	t	id	Unique identifier for the SCIM Resource as defined by the Service Provider.	\N	\N	STRING	READ_ONLY	ALWAYS	SERVER	f	t	t	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050316	1730736050316	\N
85629a9d-6e2e-42eb-9559-c7716fd8ba8f	a2ebaa96-46c5-43cf-83c6-7538cb3b4ce5	\N	t	externalId	A String that is an identifier for the resource as defined by the provisioning client.The service provider MUST always interpret the externalId as scoped to the provisioning domain.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	t	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050316	1730736050316	\N
e07939da-9e91-4317-9fc4-56a811775877	a2ebaa96-46c5-43cf-83c6-7538cb3b4ce5	\N	t	displayName	A human-readable name for the Group. REQUIRED.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	t	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050316	1730736050316	\N
92925722-4273-4c38-82f9-d1ee64664e6a	a2ebaa96-46c5-43cf-83c6-7538cb3b4ce5	\N	t	members	A list of members of the Group.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050316	1730736050316	\N
0c855aed-5631-428d-82dc-57c50a8ea4a0	a2ebaa96-46c5-43cf-83c6-7538cb3b4ce5	92925722-4273-4c38-82f9-d1ee64664e6a	t	value	Identifier of the member of this Group.	\N	\N	STRING	IMMUTABLE	DEFAULT	NONE	f	t	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050316	1730736050316	\N
57a2fcab-aa30-473a-9c84-5cb929916758	a2ebaa96-46c5-43cf-83c6-7538cb3b4ce5	92925722-4273-4c38-82f9-d1ee64664e6a	t	$ref	The uri corresponding to a SCIM resource that is a member of this Group.	resource	\N	REFERENCE	IMMUTABLE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050316	1730736050316	\N
c7d041e5-c2c9-41bc-92f5-3f585562bed3	a2ebaa96-46c5-43cf-83c6-7538cb3b4ce5	92925722-4273-4c38-82f9-d1ee64664e6a	t	display	A human-readable name for the Member	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050316	1730736050316	\N
aeb4fae0-c236-4324-8888-35d053be6e55	a2ebaa96-46c5-43cf-83c6-7538cb3b4ce5	92925722-4273-4c38-82f9-d1ee64664e6a	t	type	A label indicating the type of resource, e.g. 'User' or 'Group'	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736050316	1730736050316	\N
379ca1f1-0ce3-451f-b011-84dd454dce48	ca2d5c2d-a91f-44f0-869b-6340d5e316b9	\N	t	fullName		\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1730736081672	1730736081672	fullName
2a519ff8-e5e4-4a2f-bc14-9042a9c93cc6	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	phoneNumbers	Phone numbers for the User.  The value SHOULD be canonicalized by the service provider according to the\nformat specified in RFC 3966, e.g., 'tel:+1-201-555-0123'.Canonical type values of 'work', 'home', 'mobile', 'fax', 'pager	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456229	1738690456229	\N
090f33e6-74cb-416a-a8ae-30708ac91683	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	2a519ff8-e5e4-4a2f-bc14-9042a9c93cc6	t	value	Phone number of the User.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456230	1738690456230	\N
725f7188-9069-4afd-b7e0-03b921a5bc47	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	2a519ff8-e5e4-4a2f-bc14-9042a9c93cc6	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456231	1738690456231	\N
935be19a-b46f-4140-a245-fe13628b0aa5	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	2a519ff8-e5e4-4a2f-bc14-9042a9c93cc6	t	type	A label indicating the attribute's function, e.g., 'work', 'home', 'mobile'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456232	1738690456232	\N
fc84311c-8877-4fcf-b9e8-e1f1131ac1cc	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	2a519ff8-e5e4-4a2f-bc14-9042a9c93cc6	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the preferred\nphone number or primary phone number.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456233	1738690456233	\N
777cf2f7-3ec5-4a98-9c5c-0d9873a514cb	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	x509Certificates	A list of certificates issued to the User.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	SERVER	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456233	1738690456233	\N
b2b27fa1-2050-453b-a2e3-63cbf08ec611	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	777cf2f7-3ec5-4a98-9c5c-0d9873a514cb	t	value	The value of an X.509 certificate.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456234	1738690456234	\N
ec5e32b3-3726-4672-8b8b-f5fe93811d3a	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	777cf2f7-3ec5-4a98-9c5c-0d9873a514cb	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456234	1738690456234	\N
9ee52078-1da4-4d57-b49d-595dc1cc7c58	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	777cf2f7-3ec5-4a98-9c5c-0d9873a514cb	t	type	A label indicating the attribute's function.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456234	1738690456234	\N
71986d04-3e38-47df-914c-0cabd30ca9d3	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	777cf2f7-3ec5-4a98-9c5c-0d9873a514cb	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456235	1738690456235	\N
a8bc6b8f-e271-46f7-b037-0b74951c36aa	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	name	The components of the user's real name.Providers MAY return just the full name as a single string in the\nformatted sub-attribute, or they MAY return just the individual component attributes using the other sub-attributes, or they MAY\nreturn both.  If both variants are returned, they SHOULD be describing the same name, with the formatted name indicating how the\ncomponent attributes should be combined.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456235	1738690456235	\N
eb7a7756-d12d-4f6f-9b70-43e97e416fe0	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	a8bc6b8f-e271-46f7-b037-0b74951c36aa	t	formatted	The full name, including all middle names, titles, and suffixes as appropriate, formatted for display\n(e.g., 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456235	1738690456235	\N
8cbefd8d-742d-4a76-9cf4-01b951ed36c0	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	a8bc6b8f-e271-46f7-b037-0b74951c36aa	t	familyName	The family name of the User, or last name in most Western languages (e.g., 'Jensen' given the full\nname 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456235	1738690456235	\N
ce37577c-a0a1-41b2-a89d-6da9bdc1e71c	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	a8bc6b8f-e271-46f7-b037-0b74951c36aa	t	givenName	The given name of the User, or first name in most Western languages (e.g., 'Barbara' given the\nfull name 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456236	1738690456236	\N
2288acb0-dbeb-46b2-94a3-15ac3a293b58	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	a8bc6b8f-e271-46f7-b037-0b74951c36aa	t	middleName	The middle name(s) of the User (e.g., 'Jane' given the full name 'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456236	1738690456236	\N
5e0b85c6-0e07-496b-a2cf-8b69ec4de0a8	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	a8bc6b8f-e271-46f7-b037-0b74951c36aa	t	honorificPrefix	The honorific prefix(es) of the User, or title in most Western languages (e.g., 'Ms.' given the full name\n'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456236	1738690456236	\N
1faff60a-4cc8-445c-9d37-4621862ad06b	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	a8bc6b8f-e271-46f7-b037-0b74951c36aa	t	honorificSuffix	The honorific suffix(es) of the User, or suffix in most Western languages (e.g., 'III' given the full name\n'Ms. Barbara J Jensen, III').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456236	1738690456236	\N
2bf56a7d-547c-4658-b62f-52bd6016e80b	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	entitlements	A list of entitlements for the User that represent a thing the User has.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456237	1738690456237	\N
3f1ee437-347e-41f5-906b-10dd2ae9b9fb	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	2bf56a7d-547c-4658-b62f-52bd6016e80b	t	value	The value of an entitlement.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456237	1738690456237	\N
6edddd69-4a51-4cdd-9fac-5b2e67b729f0	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	2bf56a7d-547c-4658-b62f-52bd6016e80b	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456237	1738690456237	\N
277d079c-5b43-449f-aa3a-8ab273b9facc	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	2bf56a7d-547c-4658-b62f-52bd6016e80b	t	type	A label indicating the attribute's function.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456237	1738690456237	\N
99d1fd30-825c-4502-98f1-4120aa36faad	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	2bf56a7d-547c-4658-b62f-52bd6016e80b	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.  The primary\nattribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456237	1738690456237	\N
531ebd99-cf29-4a8f-b681-288b1bb4a8b3	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	groups	A list of groups to which the user belongs,\neither through direct membership, through nested groups, or dynamically calculated.	\N	\N	COMPLEX	READ_ONLY	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456238	1738690456238	\N
78e9a1f1-e303-4775-9fb7-f9aa6286875f	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	531ebd99-cf29-4a8f-b681-288b1bb4a8b3	t	value	The identifier of the User's group.	\N	\N	STRING	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456238	1738690456238	\N
af9b9354-a427-4557-87fe-7e3dd0409868	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	531ebd99-cf29-4a8f-b681-288b1bb4a8b3	t	$ref	The uri of the corresponding 'Group' resource to which the user belongs.	resource	\N	REFERENCE	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456238	1738690456238	\N
5d25a49c-c147-4979-bf35-cc14e69f218a	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	531ebd99-cf29-4a8f-b681-288b1bb4a8b3	t	display	A human-readable name, primarily used for display purposes. READ-ONLY.	\N	\N	STRING	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456238	1738690456238	\N
c9f6090a-d812-4828-b938-05e29e3d6075	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	531ebd99-cf29-4a8f-b681-288b1bb4a8b3	t	type	A label indicating the attribute's function, e.g., 'direct' or 'indirect'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456238	1738690456238	\N
7fcc3997-78a0-474f-ae2c-d396b900c000	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	addresses	A physical mailing address for this User.\nCanonical type values of 'work', 'home', and 'other'.  This attribute is a complex type with the following sub-attributes.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456238	1738690456238	\N
90b306ef-4ab3-42d8-a22e-b0e84fdc44d4	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	7fcc3997-78a0-474f-ae2c-d396b900c000	t	formatted	The full mailing address, formatted for display or use with a mailing label.  This attribute MAY contain\nnewlines.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456238	1738690456238	\N
e0438752-4e0e-4450-aaef-9cec6c8c3f6b	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	7fcc3997-78a0-474f-ae2c-d396b900c000	t	streetAddress	The full street address component, which may include house number, street name, P.O. box, and multi-line\nextended street address information.  This attribute MAY contain newlines.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456239	1738690456239	\N
d80c2e59-a516-4cda-b32f-79e840342954	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	7fcc3997-78a0-474f-ae2c-d396b900c000	t	locality	The city or locality component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456239	1738690456239	\N
3d7c2d8b-8b24-4c66-9863-cae377d6b009	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	7fcc3997-78a0-474f-ae2c-d396b900c000	t	region	The state or region component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456239	1738690456239	\N
85b0343c-5984-4430-80c0-fccbbab70c29	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	7fcc3997-78a0-474f-ae2c-d396b900c000	t	postalCode	The zip code or postal code component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456239	1738690456239	\N
ef795f43-be8c-4f80-899c-251f17fc23e8	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	7fcc3997-78a0-474f-ae2c-d396b900c000	t	country	The country name component.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456240	1738690456240	\N
f1578261-4205-4916-a386-873537e1c32a	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	7fcc3997-78a0-474f-ae2c-d396b900c000	t	type	A label indicating the attribute's function, e.g., 'work' or 'home'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456240	1738690456240	\N
1a8cfd99-8973-41a8-9da2-9d7341ce3ac2	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	7fcc3997-78a0-474f-ae2c-d396b900c000	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.  The primary\nattribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456240	1738690456240	\N
9a5caf6f-6cdf-4e4a-8113-d045bd147255	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	photos	URLs of photos of the User.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456240	1738690456240	\N
3b2a272c-5b4f-4ef6-a4a4-ccfc2105b5d9	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	9a5caf6f-6cdf-4e4a-8113-d045bd147255	t	value	URLs of photos of the User.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456240	1738690456240	\N
f16a050e-fb93-420e-b16e-ff8f61256464	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	9a5caf6f-6cdf-4e4a-8113-d045bd147255	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456240	1738690456240	\N
81ee35c0-cc64-481a-922e-33877060bb82	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	9a5caf6f-6cdf-4e4a-8113-d045bd147255	t	type	A label indicating the attribute's function, i.e., 'photo' or 'thumbnail'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456241	1738690456241	\N
b43e6ebf-7341-41cb-a42f-3a24abf2f2a7	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	9a5caf6f-6cdf-4e4a-8113-d045bd147255	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the preferred\nphone number or primary phone number. The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456241	1738690456241	\N
554cebf4-80ae-4e69-ae0c-210620b1c915	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	roles	A list of roles for the User that collectively represent who the User is, e.g., 'Student', 'Faculty'.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456241	1738690456241	\N
410eaa08-7a54-4808-ba2d-d80fd11ca539	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	554cebf4-80ae-4e69-ae0c-210620b1c915	t	value	The value of a role.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456241	1738690456241	\N
fc899827-e644-4051-be3a-b08334451985	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	554cebf4-80ae-4e69-ae0c-210620b1c915	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456241	1738690456241	\N
9360315f-f9ed-4e76-be96-3400c3d149dc	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	554cebf4-80ae-4e69-ae0c-210620b1c915	t	type	A label indicating the attribute's function.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456241	1738690456241	\N
9c0a5732-82eb-40b3-a97c-3ce739244cd0	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	554cebf4-80ae-4e69-ae0c-210620b1c915	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456242	1738690456242	\N
4ebb06b4-6285-45ff-8b42-124e7b51e9a2	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	id	Unique identifier for the SCIM Resource as defined by the Service Provider.	\N	\N	STRING	READ_ONLY	ALWAYS	SERVER	f	t	t	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456242	1738690456242	\N
e4fe8a1d-473d-4828-a5f5-db8a9348787b	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	externalId	A String that is an identifier for the resource as defined by the provisioning client.The service provider MUST always interpret the externalId as scoped to the provisioning domain.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	t	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456242	1738690456242	\N
186e6ab4-db4c-457d-8655-022d799afffc	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	userName	A service provider's unique identifier for the user, typically\nused by the user to directly authenticate to the service provider.Each User MUST include a non-empty userName value.  This identifier\nMUST be unique across the service provider's entire set of Users.	\N	\N	STRING	READ_WRITE	DEFAULT	SERVER	f	t	f	\N	\N	\N	\N	^(?!\\s*$).+	\N	\N	\N	f	\N	\N	\N	1738690456242	1738690456242	\N
99a4ab10-c25b-49ba-b8c5-bae117274cc5	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	displayName	The name of the User, suitable for display\nto end-users.  The name SHOULD be the full name of the User being described, if known.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456242	1738690456242	\N
1b7baf6f-29c5-4efc-b75c-4ff3d89a0c26	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	nickName	The casual way to address the user in real life, e.g., 'Bob' or 'Bobby' instead of 'Robert'.  This attribute\nSHOULD NOT be used to represent a User's username (e.g., 'bjensen' or 'mpepperidge').	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456242	1738690456242	\N
6e1d62d1-8808-46a7-8579-578860e499d7	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	profileUrl	A fully qualified URL pointing to a page\nrepresenting the User's online profile.	external	\N	REFERENCE	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456243	1738690456243	\N
73f9fe51-bd26-45d9-a911-c387233e563b	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	title	The user's title, such as \\"Vice President.\\"	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456243	1738690456243	\N
8d549b67-80f5-420c-8265-053c8aec1a49	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	userType	Used to identify the relationship between the organization and the user.  Typical values used might be\n'Contractor', 'Employee', 'Intern', 'Temp', 'External', and 'Unknown', but any value may be used.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456243	1738690456243	\N
57890f76-6477-486c-b0f3-dc3665e68e2f	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	preferredLanguage	Indicates the User's preferred written or\nspoken language.  Generally used for selecting a localized user interface; e.g., 'en_US' specifies the language English and country	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456243	1738690456243	\N
d7ac0d7f-4cf6-46bc-9b20-ae841cd420e6	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	locale	Used to indicate the User's default location\nfor purposes of localizing items such as currency, date time format, or numerical representations.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456243	1738690456243	\N
a6e7dfc8-e935-42f3-94e8-e343bf708dac	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	timezone	The User's time zone in the 'Olson' time zone\ndatabase format, e.g., 'America/Los_Angeles'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456243	1738690456243	\N
002950cb-c08c-41a4-8918-f4864954eedd	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	active	A Boolean value indicating the User's administrative status.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456244	1738690456244	\N
d56135c8-4059-4fc9-97c8-04b7702f9a39	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	password	The User's cleartext password.  This attribute is intended to be used as a means to specify an initial\npassword when creating a new User or to reset an existing User's password.	\N	\N	STRING	WRITE_ONLY	NEVER	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456244	1738690456244	\N
f1bde76c-f8dd-4eb8-9749-c5d58be14aa3	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	emails	Email addresses for the user.  The value SHOULD be canonicalized by the service provider, e.g.,\n'bjensen@example.com' instead of 'bjensen@EXAMPLE.COM'.Canonical type values of 'work', 'home', and 'other'.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456244	1738690456244	\N
893ca455-f25b-4cc7-822e-0eb4dc93f95c	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	f1bde76c-f8dd-4eb8-9749-c5d58be14aa3	t	value	Email addresses for the user.  The value SHOULD be canonicalized by the service provider, e.g.,\n'bjensen@example.com' instead of 'bjensen@EXAMPLE.COM'.Canonical type values of 'work', 'home', and 'other'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456244	1738690456244	\N
0dd25710-6757-4ad7-b86d-eb94fb7c077f	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	f1bde76c-f8dd-4eb8-9749-c5d58be14aa3	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_ONLY	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456244	1738690456244	\N
cc8fdea6-fd78-4ced-a6ef-96be02decd0a	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	f1bde76c-f8dd-4eb8-9749-c5d58be14aa3	t	type	A label indicating the attribute's function, e.g., 'work' or 'home'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456244	1738690456244	\N
55b110e2-4dc5-4c24-85cf-d5cb77a2f7ea	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	f1bde76c-f8dd-4eb8-9749-c5d58be14aa3	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the psreferred mailing address or primary email address.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456245	1738690456245	\N
26430b51-3904-4655-b0c0-1428be93e0d2	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	\N	t	ims	Instant messaging addresses for the User.	\N	\N	COMPLEX	READ_WRITE	DEFAULT	NONE	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456246	1738690456246	\N
fa0664c9-dd63-4306-b4a1-3a498154b833	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	26430b51-3904-4655-b0c0-1428be93e0d2	t	value	Instant messaging address for the User.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456246	1738690456246	\N
03f6f58c-cac6-4afd-a671-15640b35cfdb	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	26430b51-3904-4655-b0c0-1428be93e0d2	t	display	A human-readable name, primarily used for display purposes.  READ-ONLY.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456246	1738690456246	\N
891fcaa7-46ce-4be6-b2af-012bde69333e	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	26430b51-3904-4655-b0c0-1428be93e0d2	t	type	A label indicating the attribute's function, e.g., 'aim', 'gtalk', 'xmpp'.	\N	\N	STRING	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456247	1738690456247	\N
0315a2df-967d-40b1-bb68-f04929dbb139	6bd6cc13-1cf4-40e0-94eb-68e43aca7a02	26430b51-3904-4655-b0c0-1428be93e0d2	t	primary	A Boolean value indicating the 'primary' or preferred attribute value for this attribute, e.g., the preferred\nmessenger or primary messenger.  The primary attribute value 'true' MUST appear no more than once.	\N	\N	BOOLEAN	READ_WRITE	DEFAULT	NONE	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	1738690456247	1738690456247	\N
\.


--
-- Data for Name: scim_service_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_service_provider (id, version, realm_id, enabled, filter_supported, filter_max_results, sort_supported, patch_supported, change_password_supported, bulk_supported, bulk_max_operations, bulk_max_payload_size, etag_supported, case_insensi_attr_validation, sails_point_workaround_active, ms_azure_patch_workarou_active, bulk_return_resources_enabled, bulk_return_resources_default, bulk_support_get, table_list_strategy, is_user_storage_provider, azure_patch_sub_val_wa_active, use_default_values_on_request, use_default_values_on_response, ignore_unknown_attributes, azure_patch_simp_val_wa_active, ignore_required_on_response, ignore_req_extension_response, created, last_modified, patch_return_resources, limit_client_access) FROM stdin;
7a05e3dc-67a2-4d72-9e4a-d520817e5a7f	1	f493d84c-5308-498f-afec-c6f4cfffd553	f	t	50	t	t	t	t	15	2097152	f	f	f	f	f	f	f	USER_ENTITY	f	f	t	t	f	f	f	f	1729530015659	1729530034550	f	f
e9e02cbb-714f-4f8a-8be4-dcebe82aa427	8	5760f0e0-8dc4-453f-b407-19c01025187d	t	t	50	t	t	t	t	100	2097152	f	f	f	f	f	f	f	USER_ENTITY	f	f	t	t	f	f	f	f	1729531019289	1729708160589	f	f
\.


--
-- Data for Name: scim_sp_authorized_clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scim_sp_authorized_clients (scim_service_provider_id, client_id) FROM stdin;
e9e02cbb-714f-4f8a-8be4-dcebe82aa427	b2a0a790-59c5-4142-9d77-44932b1e8620
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
b43612df-590a-4e25-a38f-2f0de881be8f	21fbca6f-0536-4f1d-b130-78f40e7c690b
b43612df-590a-4e25-a38f-2f0de881be8f	2bf90d1e-8a18-42d7-8dd3-92741165fb5b
0eecf1c0-c127-4ca2-9327-459efbb9c681	8a318305-aab0-4c58-8041-56dd8617ae51
0eecf1c0-c127-4ca2-9327-459efbb9c681	4b9db14e-b704-406d-9a5f-c8641feb087e
f99d9cb1-4be5-4cd0-8061-e223ad552b74	ef79cd14-9af3-4a7b-bdea-23b6d88fca0c
f99d9cb1-4be5-4cd0-8061-e223ad552b74	e6326423-af5c-430b-9610-c4ba3ae8fae5
bb4d8a91-43ec-4a96-8bec-800f920c8826	2f89427b-0757-4de1-9fb9-f43d42524645
bb4d8a91-43ec-4a96-8bec-800f920c8826	c365e7d1-9da3-485c-a4d7-f28833935964
7f6732e2-e3c2-456a-9e4e-234ecab9072d	27263657-f217-4348-84c4-6a24e1735d0f
7f6732e2-e3c2-456a-9e4e-234ecab9072d	e29d6bdc-e7da-4d33-b8e3-6b57aa4ac6c8
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
fullName	Nathan Levesque	34d6d4de-a401-4b82-8b8d-7ba2e0b3a52a	89c10d0d-08ba-4283-9794-15a8b9a3c89e	\N	\N	\N
emailOptIn	1	3492d892-d606-436d-af14-4c1e303d43db	ac12a30b-7cfb-4e0b-af01-fc8dfe011e2a	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+test9@gmail.com	123d8d42-dbb7-40f2-9faf-9658a22924e0	5efbfe8c-58d8-4f64-a4aa-42bbccb8bd9c	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	123d8d42-dbb7-40f2-9faf-9658a22924e0	46121f0c-1611-4071-a682-795f079cd145	\N	\N	\N
fullName	Nathan	489717d3-9c35-4de8-a8de-48848340b18a	3d111652-d186-48e8-8dd0-0d066f02c85f	\N	\N	\N
emailOptIn	1	d4cdfbec-5b6c-4155-9009-24442152ba71	a08b1a4f-9ce2-4682-b186-d817c71bf191	\N	\N	\N
fullName	Nathan 12	b790034a-8da9-4c3a-a8c1-78591737f64d	9526a17b-e76f-493a-8c70-bc3357f908f5	\N	\N	\N
emailOptIn	1	b790034a-8da9-4c3a-a8c1-78591737f64d	f8b4a066-7ab7-440f-be57-aa47d391d50b	\N	\N	\N
fullName	Nathan L t1	761022bd-f7a0-462e-9b47-180e371caf31	2456483a-e137-4436-b29c-eb593269735a	\N	\N	\N
emailOptIn	1	761022bd-f7a0-462e-9b47-180e371caf31	bbdb75a7-6247-4ada-9aea-019a58618bd4	\N	\N	\N
fullName	Nathan Levesque	534e938c-43b1-44a3-894c-4c9372316c9d	a66ae3fa-e44d-40be-97ab-98efb61b0a7f	\N	\N	\N
fullName	Nathan Levesque2	5c10f566-9160-4795-b2af-afc12f92b293	1c440ddd-fa99-4693-93b4-5dc1a444c1ec	\N	\N	\N
fullName	Nathan Lev	123d8d42-dbb7-40f2-9faf-9658a22924e0	67482499-d46c-4cc2-9192-4d4a09017dc7	\N	\N	\N
fullName	Nathan Levesque	950b2f4a-3004-4bc5-9d86-0fd0f156ac82	00031067-c298-42b6-aee5-84ebba6eafe7	\N	\N	\N
emailOptIn	1	950b2f4a-3004-4bc5-9d86-0fd0f156ac82	c7240691-9a9e-4fec-8910-8cc4b54ea1fb	\N	\N	\N
fullName	Nathan Levesque 11f	d4cdfbec-5b6c-4155-9009-24442152ba71	8c067218-4731-4d0f-83af-875be0918eb0	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1734538691014	07e338d0-0827-4ba3-b350-5b55182d34dc	1feed23f-bb41-48f3-ae1c-6bdc0f4cc360	\N	\N	\N
fullName	Natha	3492d892-d606-436d-af14-4c1e303d43db	d4e5571c-720a-4ee4-b6b2-cc8c53570078	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	abc@localhost	07e338d0-0827-4ba3-b350-5b55182d34dc	6268fa54-8092-446a-b166-99d6bb1d0e0c	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	07e338d0-0827-4ba3-b350-5b55182d34dc	4e772d52-e1f9-43bd-b346-e71d59d9524e	\N	\N	\N
fullName	Martha Stewart	eedbaf58-ceb5-48af-971f-80d9ed756932	9f9553f9-a8d1-47dd-aeaa-2d451581360b	\N	\N	\N
fullName	Billy the Kid	3411c2c1-53f7-4b6a-8780-04caf43497cf	baac89c6-1705-4569-8d5a-4aecd1e998c3	\N	\N	\N
fullName	Bobby Tables	afe2a3c8-bbb1-440c-b1f2-8ac7cfd31dd3	a91b56e9-e384-43a1-9bf3-c1485a8e84f1	\N	\N	\N
emailOptIn	1	afe2a3c8-bbb1-440c-b1f2-8ac7cfd31dd3	25b5928d-30d7-4c2f-a4a8-0e4a839e5475	\N	\N	\N
emailOptIn	1	3193f207-14e1-468c-9a60-12366b111b08	232be86d-9efe-4d6f-89f7-45b5ed0c8542	\N	\N	\N
fullName	Nathan test 1	964439e4-3fa5-442b-98f2-5629b10e54c6	e60306c4-e105-4a41-9d55-2699a7076155	\N	\N	\N
emailOptIn	1	964439e4-3fa5-442b-98f2-5629b10e54c6	7e22bffa-4d39-4d42-bdda-ef70f2275dac	\N	\N	\N
emailOptIn	1	8c30ee8f-d153-40fa-b092-0378cf052288	24de5a0d-cd1e-4cfa-8998-49f923fdcdb6	\N	\N	\N
fullName	Nathan L35	8c30ee8f-d153-40fa-b092-0378cf052288	ab3f7195-5ec8-49b1-bff0-d7ad1ea04170	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:groups.value[0]	f2a35d82-c9fe-4fef-abba-0a714b3c8217	07e338d0-0827-4ba3-b350-5b55182d34dc	8a05a721-1193-4d15-9301-7367828b252d	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:groups.display[0]	Discussions	07e338d0-0827-4ba3-b350-5b55182d34dc	181f176c-ccf1-4875-b16a-16056d266729	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:groups.type[0]	direct	07e338d0-0827-4ba3-b350-5b55182d34dc	207e093f-67ce-4196-aeb0-48f4fd164d57	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1736457837589	3492d892-d606-436d-af14-4c1e303d43db	294adef7-75eb-4490-8b9e-05d70198c275	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:name.familyName	khsd	3492d892-d606-436d-af14-4c1e303d43db	af3eb833-f797-45eb-9223-d59bebd359c2	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:name.givenName	Hurefk	3492d892-d606-436d-af14-4c1e303d43db	921132dc-3f7d-45cb-8964-a9e6662101c9	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	jackson@example.com	3492d892-d606-436d-af14-4c1e303d43db	0f025d7f-356c-44ad-b83a-0015d08a9e72	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	3492d892-d606-436d-af14-4c1e303d43db	0760f735-db1a-441f-8c60-c7ffad0fc090	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1727205568	489717d3-9c35-4de8-a8de-48848340b18a	801b7d84-47fc-4ef7-a738-cb23348e5ea1	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	nlevesq@mit.edu	489717d3-9c35-4de8-a8de-48848340b18a	9878006b-5181-41c6-953c-3f334f70c988	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	489717d3-9c35-4de8-a8de-48848340b18a	62f38f4f-eb4d-4d53-bf0c-08e3265b87f0	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1727114859766	34d6d4de-a401-4b82-8b8d-7ba2e0b3a52a	7f71ef10-77d2-45b8-afa7-beff825c3a5b	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:externalId	5	34d6d4de-a401-4b82-8b8d-7ba2e0b3a52a	ccf1ace8-53f7-4da6-a092-b546a4a3e70b	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+nopass@gmail.com	34d6d4de-a401-4b82-8b8d-7ba2e0b3a52a	1aef6a41-1336-41fe-bc94-52a0252121bd	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	34d6d4de-a401-4b82-8b8d-7ba2e0b3a52a	05e00f20-7fc6-4358-af86-735b3e6e3bec	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1730138767184	3193f207-14e1-468c-9a60-12366b111b08	a2b4f64f-f097-4463-9dfa-c45f34c46a64	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+1028242@gmail.com	3193f207-14e1-468c-9a60-12366b111b08	90b9eecc-a0d3-465d-b85f-e1df31345e93	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	3193f207-14e1-468c-9a60-12366b111b08	d091a21d-93ed-4545-93ba-80e6ef3134ca	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1730725144640	83ceeb5a-9e8f-4c63-b671-6d8f3560f890	7dc0e436-d8fd-48d2-a796-4af1a75412ff	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+1104241@gmail.com	83ceeb5a-9e8f-4c63-b671-6d8f3560f890	8b38a189-bd21-4ada-9ea7-180856eac9db	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	83ceeb5a-9e8f-4c63-b671-6d8f3560f890	4c48c23a-db2f-4820-9a3e-3e2a0a6a7b56	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1730739461721	90586e33-9783-4143-ac23-e38f0665f1a9	83fe9471-80a7-4837-933e-a22b39a5d3c0	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+1104242@gmail.com	90586e33-9783-4143-ac23-e38f0665f1a9	ecd16ded-fd3c-480c-bc63-48b2c9f6bff8	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	90586e33-9783-4143-ac23-e38f0665f1a9	fc411c75-e29f-4cef-947f-34a23256c6b3	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1730739848645	7463cbb2-b6ac-4383-b8d4-0abf0d3bf323	eea04e05-585a-44ec-8934-d8d2f0a460ae	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+1104243@gmail.com	7463cbb2-b6ac-4383-b8d4-0abf0d3bf323	b0761392-cf6a-4e69-8c81-5e41d879ef9d	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	7463cbb2-b6ac-4383-b8d4-0abf0d3bf323	c72d60a8-dc99-43e3-bdd8-f6fa2a629c09	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1730740186187	c8db480e-8390-4496-a99e-93efca3c49db	c19b4318-6eaa-4d43-900d-ab3cf554765c	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+1104244@gmail.com	c8db480e-8390-4496-a99e-93efca3c49db	a86a6d12-ffc5-4e5e-9147-7b89d049b64d	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	c8db480e-8390-4496-a99e-93efca3c49db	d3cd3038-038c-48c6-909c-ffedc1d256ee	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1730740281251	33362f14-57ae-4518-9140-9b69907bc721	1498e064-24cf-42d7-a283-53bc0c37e148	\N	\N	\N
fullName	Jimmy Bob	3193f207-14e1-468c-9a60-12366b111b08	70af33ee-2308-444f-9e6b-325ab6139484	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+1104245@gmail.com	33362f14-57ae-4518-9140-9b69907bc721	4b1e3672-80df-4ead-a237-5c7260383e53	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	33362f14-57ae-4518-9140-9b69907bc721	3fbcbc3b-8494-4fe1-be3b-6f50ee55ffdd	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1730923829062	fc20baea-ea1a-45b7-a801-3a126d93937d	67743dea-99b5-4d5f-be0a-c53710e5cc9b	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+1106241@gmail.com	fc20baea-ea1a-45b7-a801-3a126d93937d	f4b19c65-6c45-4234-836c-7acf1ee4d57f	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	fc20baea-ea1a-45b7-a801-3a126d93937d	24d54d87-e233-4047-9028-40b35f2e043c	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1730924699931	8778b977-06d5-479a-bd60-474903c6b024	90fe2e4b-e152-4d62-b4df-fca713f92942	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+1106242@gmail.com	8778b977-06d5-479a-bd60-474903c6b024	0c0e4932-f634-4ab8-8ce3-f196e29f8110	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	8778b977-06d5-479a-bd60-474903c6b024	ff32d325-ab2b-4ba2-a2bc-bc6aa68ff864	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1731081668277	19be8373-0fbf-48c9-8d18-bbee1df65cfb	e5a06ea7-4d1b-4752-a143-672db1e3efb0	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+1108241@gmail.com	19be8373-0fbf-48c9-8d18-bbee1df65cfb	9615e2fe-88bc-458f-8fe7-3d2acea90dd0	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	19be8373-0fbf-48c9-8d18-bbee1df65cfb	0afd15ad-3a2f-4a9a-9eac-d4e658292c66	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1731515741342	b7cf04e7-a16c-44fc-9d85-93f5bbda4f93	0696bd3b-5672-4458-be00-80d1b3e8cecf	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+1113241@gmail.com	b7cf04e7-a16c-44fc-9d85-93f5bbda4f93	17fdd427-4f65-4fba-8cc0-713d3f369831	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	b7cf04e7-a16c-44fc-9d85-93f5bbda4f93	d514657f-757b-43da-bd15-57785f156f88	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1732311351548	fc01f525-4201-4005-b61e-6c3ad5d2b36e	67ebbfb9-6e5f-41e1-a91f-2785860c1742	\N	\N	\N
emailOptIn	1	83ceeb5a-9e8f-4c63-b671-6d8f3560f890	fc830205-00d0-41ea-bbdb-aeaffb562bd6	\N	\N	\N
fullName	Nathan	83ceeb5a-9e8f-4c63-b671-6d8f3560f890	38f8e1f1-f24f-4322-8058-4b0a6aea332c	\N	\N	\N
fullName	Nathan 2	90586e33-9783-4143-ac23-e38f0665f1a9	13c9dd32-43b9-4077-b756-6643e0ddc87c	\N	\N	\N
emailOptIn	1	90586e33-9783-4143-ac23-e38f0665f1a9	6d826f09-e59a-42c9-9e7a-de2dfcb1dbd2	\N	\N	\N
fullName	Nathan L	7463cbb2-b6ac-4383-b8d4-0abf0d3bf323	a87179d2-1340-4c2f-b1af-293339c6db79	\N	\N	\N
emailOptIn	1	7463cbb2-b6ac-4383-b8d4-0abf0d3bf323	197a120e-d9d2-4806-a1f9-7e79a629e060	\N	\N	\N
fullName	Nathan New	c8db480e-8390-4496-a99e-93efca3c49db	c31bdbb2-9ec3-4d15-ad49-909fa40abe4f	\N	\N	\N
emailOptIn	1	c8db480e-8390-4496-a99e-93efca3c49db	5a67e169-6551-4611-9a03-ca4e68c38d6b	\N	\N	\N
fullName	Nathan Levesque	33362f14-57ae-4518-9140-9b69907bc721	6c2076ed-4e49-4400-9865-e24cccfd2fa5	\N	\N	\N
emailOptIn	0	33362f14-57ae-4518-9140-9b69907bc721	236db4af-c6fa-4d63-bb23-80bd9ef452aa	\N	\N	\N
fullName	Nathan	fc20baea-ea1a-45b7-a801-3a126d93937d	7470f3e7-76f3-45f1-a682-fc2d4c8abbf7	\N	\N	\N
emailOptIn	1	fc20baea-ea1a-45b7-a801-3a126d93937d	0630e16e-92ba-44ff-86ad-f12381c2d189	\N	\N	\N
fullName	Nathan	8778b977-06d5-479a-bd60-474903c6b024	a0597647-0e9f-4ec4-9cd2-ed9e71711a7a	\N	\N	\N
emailOptIn	1	8778b977-06d5-479a-bd60-474903c6b024	fa65ad05-e4f0-4ed6-86b1-66ae195d0b18	\N	\N	\N
fullName	Nathan Levesque	19be8373-0fbf-48c9-8d18-bbee1df65cfb	42b65b6b-301d-466c-9d63-aac5e74c27d0	\N	\N	\N
emailOptIn	1	19be8373-0fbf-48c9-8d18-bbee1df65cfb	0c85b106-94b6-43e7-8ec6-8f20b33b4936	\N	\N	\N
fullName	Nate	b7cf04e7-a16c-44fc-9d85-93f5bbda4f93	c9d3d2b3-18c2-489e-bf64-3557633cecca	\N	\N	\N
emailOptIn	1	b7cf04e7-a16c-44fc-9d85-93f5bbda4f93	72a1362e-11e0-4486-8316-963a65cc3173	\N	\N	\N
emailOptIn	1	fc01f525-4201-4005-b61e-6c3ad5d2b36e	361f55e1-0672-4ade-a91e-554a0e56455b	\N	\N	\N
fullName	Nathan	fc01f525-4201-4005-b61e-6c3ad5d2b36e	a34239ce-f502-43de-8bb7-329fdec8f062	\N	\N	\N
emailOptIn	1	40dec71f-adcb-48ac-af3c-606c6007158e	85860d60-c6ce-4420-b956-2cde74ab361f	\N	\N	\N
fullName	Nathan L	40dec71f-adcb-48ac-af3c-606c6007158e	beef242b-d7d4-4fd2-b92d-49bb2c1f3f0a	\N	\N	\N
emailOptIn	1	ff8c6822-a130-408e-98ce-1e083b2dfeca	4358231a-f6b7-42e8-b8ee-1dd53d604fc7	\N	\N	\N
fullName	Nathan Lev	ff8c6822-a130-408e-98ce-1e083b2dfeca	6180f32b-3a7d-4d1f-8ee3-2d13711ba991	\N	\N	\N
emailOptIn	0	489717d3-9c35-4de8-a8de-48848340b18a	e75eae54-d79e-4e1a-9020-f53829e84520	\N	\N	\N
emailOptIn	1	4d4ecff6-54a2-4926-a391-881a5c9d2137	b00ff984-1c87-4e28-84f1-8bbe6b4a9fa0	\N	\N	\N
fullName	Test Nathan	4d4ecff6-54a2-4926-a391-881a5c9d2137	5bb76873-3efc-483e-9d5b-fd4a446ecbb0	\N	\N	\N
emailOptIn	0	07e338d0-0827-4ba3-b350-5b55182d34dc	2ecff4fe-6db3-4016-a70f-d6f59dabd8ab	\N	\N	\N
fullName	Jimmy	07e338d0-0827-4ba3-b350-5b55182d34dc	22321922-e345-43a6-a6a2-3db4acf5608d	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+1122241@gmail.com	fc01f525-4201-4005-b61e-6c3ad5d2b36e	f4941c77-e368-4c52-9293-8cbb0e979de1	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	fc01f525-4201-4005-b61e-6c3ad5d2b36e	a8dbb1e6-e761-450a-8172-1e1d52e91d9e	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1733342197548	40dec71f-adcb-48ac-af3c-606c6007158e	25f80fa5-7766-49ad-8721-9f43b31bce5c	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+1204241@gmail.com	40dec71f-adcb-48ac-af3c-606c6007158e	7f755846-8cd0-4601-8aab-9a9dd95f4d0d	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	40dec71f-adcb-48ac-af3c-606c6007158e	e2890d1b-ccd1-4ddc-b345-e3964805abdd	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1723149071855	534e938c-43b1-44a3-894c-4c9372316c9d	fe951305-9a0e-4c61-ab7b-399873e9f5f1	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:name.familyName	Levesque	534e938c-43b1-44a3-894c-4c9372316c9d	0c4ede83-cd9b-4afe-9ce6-bb030c6b0970	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:name.givenName	Nathan2	534e938c-43b1-44a3-894c-4c9372316c9d	3d87c246-02ae-426c-a7ce-90b739df1d79	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun@gmail.com	534e938c-43b1-44a3-894c-4c9372316c9d	d2766401-71a9-4db0-97cd-dbf2fb34740d	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	534e938c-43b1-44a3-894c-4c9372316c9d	70485b6d-2bc2-4bdf-8a20-780088e0d5ea	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1728582214077	d4cdfbec-5b6c-4155-9009-24442152ba71	d1b02a4a-79b4-42d8-b28d-155234f0a30b	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:externalId	2	d4cdfbec-5b6c-4155-9009-24442152ba71	607d904d-6f89-40eb-b839-836e4102f908	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:name.givenName	dfg	d4cdfbec-5b6c-4155-9009-24442152ba71	2c04b937-17a2-4803-bc24-39560e7e0f3b	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+nl11@gmail.com	d4cdfbec-5b6c-4155-9009-24442152ba71	b9f7dae1-df96-4ada-9438-12b627229a5c	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	d4cdfbec-5b6c-4155-9009-24442152ba71	011bf0bd-df2b-42ac-82ec-ec60390801a5	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1728590759503	b790034a-8da9-4c3a-a8c1-78591737f64d	ea99d0a1-c25f-48c3-9044-0d3e185e2f0d	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:externalId	3	b790034a-8da9-4c3a-a8c1-78591737f64d	80d129ee-1273-462c-9398-d812e5e46eb0	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+nl12@gmail.com	b790034a-8da9-4c3a-a8c1-78591737f64d	da33ed7a-7f8d-4d33-b8fd-8d712f62cc7d	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	b790034a-8da9-4c3a-a8c1-78591737f64d	2bc8a059-70ca-4e51-8d72-749124f32afe	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1727206153	3411c2c1-53f7-4b6a-8780-04caf43497cf	b6806448-8f64-4591-854a-ac4af6982f24	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+od1@gmail.com	3411c2c1-53f7-4b6a-8780-04caf43497cf	4ad742ea-45bd-449a-86ee-a0299486af74	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	3411c2c1-53f7-4b6a-8780-04caf43497cf	4bfad690-151b-49cf-9105-67b5587c06de	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1727206170	eedbaf58-ceb5-48af-971f-80d9ed756932	3f2c261d-6130-48a9-8bbd-152863ae5d2a	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+od2@gmail.com	eedbaf58-ceb5-48af-971f-80d9ed756932	1443aaae-7e58-40c1-8ec0-5fa91649a6b1	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	eedbaf58-ceb5-48af-971f-80d9ed756932	b4fad89a-6d05-4fa1-973c-51351b01b931	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1729888656	afe2a3c8-bbb1-440c-b1f2-8ac7cfd31dd3	25d2ae9d-216f-4707-9628-adccb1879735	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+od4@gmail.com	afe2a3c8-bbb1-440c-b1f2-8ac7cfd31dd3	ec1ce6d3-415a-489c-8f63-4082f988b6b9	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	afe2a3c8-bbb1-440c-b1f2-8ac7cfd31dd3	5fcd50a4-4568-4dd2-939e-5f6392450b47	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1734442008590	4d4ecff6-54a2-4926-a391-881a5c9d2137	10059aed-bbdf-4bde-b97c-591ca63e3741	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+odtest1@gmail.com	4d4ecff6-54a2-4926-a391-881a5c9d2137	abdb0b8f-9138-4fd5-9f8d-f998d85a1896	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	4d4ecff6-54a2-4926-a391-881a5c9d2137	09a52ec5-2ddf-4553-a8b1-7df3b267ef22	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:groups.value[0]	f2a35d82-c9fe-4fef-abba-0a714b3c8217	4d4ecff6-54a2-4926-a391-881a5c9d2137	9bb4d33d-f11c-4a03-95c0-f816fc65bc69	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:groups.display[0]	Discussions	4d4ecff6-54a2-4926-a391-881a5c9d2137	a941e160-84fb-4642-b679-e70590eea4a0	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:groups.type[0]	direct	4d4ecff6-54a2-4926-a391-881a5c9d2137	994c0f97-9187-47dc-a922-a0e2b3b7b2f4	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1728659804233	761022bd-f7a0-462e-9b47-180e371caf31	11f44aa9-34f7-4691-9402-7efd1001295e	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:externalId	18	761022bd-f7a0-462e-9b47-180e371caf31	e0d96792-79d6-49cd-8733-003327c910dd	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+t1@gmail.com	761022bd-f7a0-462e-9b47-180e371caf31	04f43189-c32c-433b-8570-c3f268a0b41e	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	761022bd-f7a0-462e-9b47-180e371caf31	f96289e8-b33d-4fed-96d6-bdc78b5bb226	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1733846083872	ff8c6822-a130-408e-98ce-1e083b2dfeca	48b2662d-99bb-4279-b91a-5744b5a0e447	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+test120924-1@gmail.com	ff8c6822-a130-408e-98ce-1e083b2dfeca	ddadb626-4279-42e6-9b8c-285899da4ff2	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	ff8c6822-a130-408e-98ce-1e083b2dfeca	aacf1614-2f0a-43e6-8b4d-db77836d1c7a	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1729535982181	950b2f4a-3004-4bc5-9d86-0fd0f156ac82	95ab193f-2a18-4931-a7ea-0c41eec4c375	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+test13@gmail.com	950b2f4a-3004-4bc5-9d86-0fd0f156ac82	c6733b2f-7938-4fbd-8c8c-ad6e535361cc	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	950b2f4a-3004-4bc5-9d86-0fd0f156ac82	a24c09e0-619d-4408-99ae-8c4256bad4f2	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1730323772804	964439e4-3fa5-442b-98f2-5629b10e54c6	328651ee-a096-4713-bd4b-55e054af5b03	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+test1@gmail.com	964439e4-3fa5-442b-98f2-5629b10e54c6	bcd1c87f-b5b6-4395-9a4b-b7f57bcdfb7a	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	964439e4-3fa5-442b-98f2-5629b10e54c6	e0124e17-96db-436d-96e1-1391b151e6bb	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1726858396901	5c10f566-9160-4795-b2af-afc12f92b293	d808329a-273d-4c7a-b954-1ede691cfa7b	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:externalId	19	5c10f566-9160-4795-b2af-afc12f92b293	26a44c1b-1205-4cc7-b5c5-0e4822995e98	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+test4@gmail.com	5c10f566-9160-4795-b2af-afc12f92b293	d85e156d-6693-4c8c-896b-0a5560b94047	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	5c10f566-9160-4795-b2af-afc12f92b293	3b653fe6-debc-481f-b4b2-e6579f429a55	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1730483366443	8c30ee8f-d153-40fa-b092-0378cf052288	c909d793-2452-4417-be30-345da56d9233	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.value[0]	rhysyngsun+test77@gmail.com	8c30ee8f-d153-40fa-b092-0378cf052288	d43c3f36-4e25-4756-97c6-7357f981c6c8	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:User:emails.primary[0]	true	8c30ee8f-d153-40fa-b092-0378cf052288	d42455d2-8383-4b9e-826d-d3b4dec39016	\N	\N	\N
urn:ietf:params:scim:schemas:core:2.0:Meta:meta.lastModified	1729535856136	123d8d42-dbb7-40f2-9faf-9658a22924e0	095be263-7f9e-4b2c-8fdd-457a5c4e22cd	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
b4a8deab-e981-406c-a88d-272fb85c82c8	nlevesq@mit.edu	nlevesq@mit.edu	f	t	\N	\N	\N	f493d84c-5308-498f-afec-c6f4cfffd553	admin	1723148438095	\N	0
b4aa6522-3dfd-4de4-8949-c19d31250239	\N	218cf2bf-b5eb-4eb7-bf06-f5814ec16c8f	f	t	\N	\N	\N	b4825e08-1ac5-43e9-990a-7556e882153a	admin	1729530641197	\N	0
a06d964e-7407-4b80-87f8-8ad3d0e6ff26	\N	d061b7d9-4a7e-4fe8-9bfd-81ede495b73d	f	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	service-account-admin-cli	1734441386038	a172934f-a9e5-458f-9483-7dfc4d6e1991	0
07e338d0-0827-4ba3-b350-5b55182d34dc	abc@localhost	abc@localhost	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	abc@localhost	1734538691014	\N	0
3492d892-d606-436d-af14-4c1e303d43db	jackson@example.com	jackson@example.com	t	t	\N	Hurefk	khsd	5760f0e0-8dc4-453f-b407-19c01025187d	jackson@example.com	1736457837589	\N	0
489717d3-9c35-4de8-a8de-48848340b18a	nlevesq@mit.edu	nlevesq@mit.edu	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	nlevesq@mit.edu	1727205568	\N	0
34d6d4de-a401-4b82-8b8d-7ba2e0b3a52a	rhysyngsun+nopass@gmail.com	rhysyngsun+nopass@gmail.com	f	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	nopass	1727114859766	\N	0
3193f207-14e1-468c-9a60-12366b111b08	rhysyngsun+1028242@gmail.com	rhysyngsun+1028242@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+1028242@gmail.com	1730138767184	\N	0
83ceeb5a-9e8f-4c63-b671-6d8f3560f890	rhysyngsun+1104241@gmail.com	rhysyngsun+1104241@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+1104241@gmail.com	1730725144640	\N	0
90586e33-9783-4143-ac23-e38f0665f1a9	rhysyngsun+1104242@gmail.com	rhysyngsun+1104242@gmail.com	f	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+1104242@gmail.com	1730739461721	\N	0
7463cbb2-b6ac-4383-b8d4-0abf0d3bf323	rhysyngsun+1104243@gmail.com	rhysyngsun+1104243@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+1104243@gmail.com	1730739848645	\N	0
c8db480e-8390-4496-a99e-93efca3c49db	rhysyngsun+1104244@gmail.com	rhysyngsun+1104244@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+1104244@gmail.com	1730740186187	\N	0
33362f14-57ae-4518-9140-9b69907bc721	rhysyngsun+1104245@gmail.com	rhysyngsun+1104245@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+1104245@gmail.com	1730740281251	\N	0
fc20baea-ea1a-45b7-a801-3a126d93937d	rhysyngsun+1106241@gmail.com	rhysyngsun+1106241@gmail.com	f	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+1106241@gmail.com	1730923829062	\N	0
8778b977-06d5-479a-bd60-474903c6b024	rhysyngsun+1106242@gmail.com	rhysyngsun+1106242@gmail.com	f	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+1106242@gmail.com	1730924699931	\N	0
19be8373-0fbf-48c9-8d18-bbee1df65cfb	rhysyngsun+1108241@gmail.com	rhysyngsun+1108241@gmail.com	f	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+1108241@gmail.com	1731081668277	\N	0
b7cf04e7-a16c-44fc-9d85-93f5bbda4f93	rhysyngsun+1113241@gmail.com	rhysyngsun+1113241@gmail.com	f	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+1113241@gmail.com	1731515741342	\N	0
fc01f525-4201-4005-b61e-6c3ad5d2b36e	rhysyngsun+1122241@gmail.com	rhysyngsun+1122241@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+1122241@gmail.com	1732311351548	\N	0
40dec71f-adcb-48ac-af3c-606c6007158e	rhysyngsun+1204241@gmail.com	rhysyngsun+1204241@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+1204241@gmail.com	1733342197548	\N	0
534e938c-43b1-44a3-894c-4c9372316c9d	rhysyngsun@gmail.com	rhysyngsun@gmail.com	t	t	\N	Nathan2	Levesque	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun@gmail.com	1723149071855	\N	0
d4cdfbec-5b6c-4155-9009-24442152ba71	rhysyngsun+nl11@gmail.com	rhysyngsun+nl11@gmail.com	t	t	\N	dfg	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+nl11@gmail.com	1728582214077	\N	0
b790034a-8da9-4c3a-a8c1-78591737f64d	rhysyngsun+nl12@gmail.com	rhysyngsun+nl12@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+nl12@gmail.com	1728590759503	\N	0
3411c2c1-53f7-4b6a-8780-04caf43497cf	rhysyngsun+od1@gmail.com	rhysyngsun+od1@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+od1@gmail.com	1727206153	\N	0
eedbaf58-ceb5-48af-971f-80d9ed756932	rhysyngsun+od2@gmail.com	rhysyngsun+od2@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+od2@gmail.com	1727206170	\N	0
afe2a3c8-bbb1-440c-b1f2-8ac7cfd31dd3	rhysyngsun+od4@gmail.com	rhysyngsun+od4@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+od4@gmail.com	1729888656	\N	0
4d4ecff6-54a2-4926-a391-881a5c9d2137	rhysyngsun+odtest1@gmail.com	rhysyngsun+odtest1@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+odtest1@gmail.com	1734442008590	\N	0
761022bd-f7a0-462e-9b47-180e371caf31	rhysyngsun+t1@gmail.com	rhysyngsun+t1@gmail.com	f	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+t1@gmail.com	1728659804233	\N	0
ff8c6822-a130-408e-98ce-1e083b2dfeca	rhysyngsun+test120924-1@gmail.com	rhysyngsun+test120924-1@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+test120924-1@gmail.com	1733846083872	\N	0
950b2f4a-3004-4bc5-9d86-0fd0f156ac82	rhysyngsun+test13@gmail.com	rhysyngsun+test13@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+test13@gmail.com	1729535982181	\N	0
964439e4-3fa5-442b-98f2-5629b10e54c6	rhysyngsun+test1@gmail.com	rhysyngsun+test1@gmail.com	f	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+test1@gmail.com	1730323772804	\N	0
5c10f566-9160-4795-b2af-afc12f92b293	rhysyngsun+test4@gmail.com	rhysyngsun+test4@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+test4@gmail.com	1726858396901	\N	0
8c30ee8f-d153-40fa-b092-0378cf052288	rhysyngsun+test77@gmail.com	rhysyngsun+test77@gmail.com	t	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+test77@gmail.com	1730483366443	\N	0
123d8d42-dbb7-40f2-9faf-9658a22924e0	rhysyngsun+test9@gmail.com	rhysyngsun+test9@gmail.com	f	t	\N	\N	\N	5760f0e0-8dc4-453f-b407-19c01025187d	rhysyngsun+test9@gmail.com	1729535856136	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
f2a35d82-c9fe-4fef-abba-0a714b3c8217	4d4ecff6-54a2-4926-a391-881a5c9d2137	UNMANAGED
f2a35d82-c9fe-4fef-abba-0a714b3c8217	07e338d0-0827-4ba3-b350-5b55182d34dc	UNMANAGED
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
964439e4-3fa5-442b-98f2-5629b10e54c6	VERIFY_EMAIL
90586e33-9783-4143-ac23-e38f0665f1a9	VERIFY_EMAIL
fc20baea-ea1a-45b7-a801-3a126d93937d	VERIFY_EMAIL
8778b977-06d5-479a-bd60-474903c6b024	VERIFY_EMAIL
19be8373-0fbf-48c9-8d18-bbee1df65cfb	VERIFY_EMAIL
b7cf04e7-a16c-44fc-9d85-93f5bbda4f93	VERIFY_EMAIL
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
8eaee4b4-db59-489b-9ce3-217077d760ff	b4a8deab-e981-406c-a88d-272fb85c82c8
edc30253-7dcc-456a-8b45-698bcb7a4f13	b4a8deab-e981-406c-a88d-272fb85c82c8
6a904e2e-f3c9-472c-bf44-95d020efbbb4	b4a8deab-e981-406c-a88d-272fb85c82c8
ed4c4868-d0d3-4e11-9c47-64f9b29e2079	b4a8deab-e981-406c-a88d-272fb85c82c8
53d46425-1218-4a18-99c3-1a2ea59cdcc6	b4a8deab-e981-406c-a88d-272fb85c82c8
7eb43cc8-500f-41a5-a1f4-8af2f9357c72	b4a8deab-e981-406c-a88d-272fb85c82c8
b182889a-7dbf-4c40-912f-67763a28203e	b4a8deab-e981-406c-a88d-272fb85c82c8
dffff9e9-c020-4b1e-b13b-6e1eeddbc4d5	b4a8deab-e981-406c-a88d-272fb85c82c8
a5154a91-8a42-45c8-a8b5-f789e2f29b98	b4a8deab-e981-406c-a88d-272fb85c82c8
d5dd0a8a-d688-4895-ace6-eb7a48c3286b	b4a8deab-e981-406c-a88d-272fb85c82c8
09dd1b46-f079-4622-bd1e-eb0559eb8df2	b4a8deab-e981-406c-a88d-272fb85c82c8
c51eebd2-b5e1-41fe-89fa-a1a5d1c88ee8	b4a8deab-e981-406c-a88d-272fb85c82c8
ca327a3a-d462-49b4-aa31-a778923c4a7f	b4a8deab-e981-406c-a88d-272fb85c82c8
3393382f-8a01-4173-9212-3b6efd2b174a	b4a8deab-e981-406c-a88d-272fb85c82c8
c656a012-664f-47c6-b167-b35d6420531e	b4a8deab-e981-406c-a88d-272fb85c82c8
62688fd7-649d-4280-95fd-3c6bcf089398	b4a8deab-e981-406c-a88d-272fb85c82c8
1b3023fc-4784-41ce-9138-08c701368d5d	b4a8deab-e981-406c-a88d-272fb85c82c8
9febcf71-25cf-458b-8cd8-e66029b07a5c	b4a8deab-e981-406c-a88d-272fb85c82c8
860422ac-0fa5-4b32-bbe1-0bb020df02a4	b4a8deab-e981-406c-a88d-272fb85c82c8
25dc23c9-fc78-4647-97cd-149741a77307	534e938c-43b1-44a3-894c-4c9372316c9d
7dc1592d-953b-47b2-96e8-6b792c8f01c3	b4a8deab-e981-406c-a88d-272fb85c82c8
49a10d53-ea6c-4e6c-8d92-bf4a494180f6	b4a8deab-e981-406c-a88d-272fb85c82c8
072b4764-e708-4bbe-b6a8-f76d8674fbf5	b4a8deab-e981-406c-a88d-272fb85c82c8
96745421-d678-4a65-bcb9-72dc8d1d7962	b4a8deab-e981-406c-a88d-272fb85c82c8
4d73db27-7641-4d23-8f9c-e70008eca882	b4a8deab-e981-406c-a88d-272fb85c82c8
d33ef96b-aabe-444d-b33c-2b8b95139536	b4a8deab-e981-406c-a88d-272fb85c82c8
2fa5a6cd-d43a-4681-9efd-52dd4e95a217	b4a8deab-e981-406c-a88d-272fb85c82c8
9a54158b-c83d-417b-8698-0a60df58b296	b4a8deab-e981-406c-a88d-272fb85c82c8
afcccb55-78e6-402e-98ae-e0ab801969a8	b4a8deab-e981-406c-a88d-272fb85c82c8
f695f016-c55a-476d-a942-384571bdd698	b4a8deab-e981-406c-a88d-272fb85c82c8
1a1b159d-31da-48a2-8d00-8c2b8f188276	b4a8deab-e981-406c-a88d-272fb85c82c8
3a9c9b7b-d11b-4196-8137-0fa9721457f7	b4a8deab-e981-406c-a88d-272fb85c82c8
bf8db88d-703d-4ef0-abbf-0ca968f1a4b8	b4a8deab-e981-406c-a88d-272fb85c82c8
0e2378d0-1cee-409d-9350-ff1418dd53ea	b4a8deab-e981-406c-a88d-272fb85c82c8
8734e94f-1f04-4310-b2fa-8b5046dcb448	b4a8deab-e981-406c-a88d-272fb85c82c8
ed761718-c140-4f5a-8328-e45c657b0e87	b4a8deab-e981-406c-a88d-272fb85c82c8
a7d7fd57-bf99-4def-b5c9-5f7be0a1e4ed	b4a8deab-e981-406c-a88d-272fb85c82c8
25dc23c9-fc78-4647-97cd-149741a77307	5c10f566-9160-4795-b2af-afc12f92b293
25dc23c9-fc78-4647-97cd-149741a77307	34d6d4de-a401-4b82-8b8d-7ba2e0b3a52a
25dc23c9-fc78-4647-97cd-149741a77307	d4cdfbec-5b6c-4155-9009-24442152ba71
25dc23c9-fc78-4647-97cd-149741a77307	b790034a-8da9-4c3a-a8c1-78591737f64d
25dc23c9-fc78-4647-97cd-149741a77307	761022bd-f7a0-462e-9b47-180e371caf31
6a30e800-81ad-42b9-9bcf-f82b3ef0aa58	b4a8deab-e981-406c-a88d-272fb85c82c8
db6d0ecc-965b-4d9e-acbc-a3aed34e9d24	b4a8deab-e981-406c-a88d-272fb85c82c8
38a651d9-27c3-48db-ac00-454f0b2fcd9c	b4a8deab-e981-406c-a88d-272fb85c82c8
1d031beb-dcc7-4066-a4ed-ac972150b2f3	b4a8deab-e981-406c-a88d-272fb85c82c8
83f4c60b-2ea2-4f82-bc30-b75f407bd48c	b4a8deab-e981-406c-a88d-272fb85c82c8
f3a7f525-c735-4c0b-b6ee-f35399cafcb1	b4a8deab-e981-406c-a88d-272fb85c82c8
dc14d21e-5c6f-4c7d-9c47-63ccdf33260e	b4a8deab-e981-406c-a88d-272fb85c82c8
a76da85c-adc7-4465-b870-8f614a27aaa6	b4a8deab-e981-406c-a88d-272fb85c82c8
05eb3dc0-d554-45e5-901f-1af0c4eed0c6	b4a8deab-e981-406c-a88d-272fb85c82c8
c7d76103-617d-47e2-8850-4665a9c1dc83	b4a8deab-e981-406c-a88d-272fb85c82c8
16c21d2e-4e51-41be-bf7a-b7dde02625b0	b4a8deab-e981-406c-a88d-272fb85c82c8
ca8981f4-362c-4e96-91ee-568bf4f6a029	b4a8deab-e981-406c-a88d-272fb85c82c8
95576acc-012b-4bef-aba3-aafd399a3d14	b4a8deab-e981-406c-a88d-272fb85c82c8
8392ad62-fae8-4fef-89e9-d85a512af4e5	b4a8deab-e981-406c-a88d-272fb85c82c8
c0f932f5-2236-4688-9a21-71c6308b73ca	b4a8deab-e981-406c-a88d-272fb85c82c8
bacd1c49-e971-4209-89dc-6bfcbb13f612	b4a8deab-e981-406c-a88d-272fb85c82c8
7ba00ae6-1b4f-44f0-8dbc-fec5798dc93a	b4a8deab-e981-406c-a88d-272fb85c82c8
b848d658-ab02-420c-b827-c6c44cd852c4	b4aa6522-3dfd-4de4-8949-c19d31250239
264b0a1c-800c-4284-9679-f8e7d1b7ba05	b4a8deab-e981-406c-a88d-272fb85c82c8
25dc23c9-fc78-4647-97cd-149741a77307	123d8d42-dbb7-40f2-9faf-9658a22924e0
25dc23c9-fc78-4647-97cd-149741a77307	950b2f4a-3004-4bc5-9d86-0fd0f156ac82
528a3268-e600-441e-818f-f04499946c40	b4a8deab-e981-406c-a88d-272fb85c82c8
39abef73-21ab-4e13-a7bd-4f72730f0c94	b4a8deab-e981-406c-a88d-272fb85c82c8
e0ce877c-93fe-4efb-9f3b-e833a63d32f2	b4a8deab-e981-406c-a88d-272fb85c82c8
55eebbe9-9606-4c77-9ceb-fcdd4b5059ae	b4a8deab-e981-406c-a88d-272fb85c82c8
753c7960-27ac-471d-a9e1-3b9b71bfe645	b4a8deab-e981-406c-a88d-272fb85c82c8
5759a9a9-c0d2-44b6-9db5-50076cfdad92	b4a8deab-e981-406c-a88d-272fb85c82c8
4e18fd5b-74a6-4e2f-bb55-ca928dbb7592	b4a8deab-e981-406c-a88d-272fb85c82c8
60be092f-788b-4378-b1dd-037d454a7bd3	b4a8deab-e981-406c-a88d-272fb85c82c8
65938bef-99b8-4f4b-9b1d-c3bc7ccaec96	b4a8deab-e981-406c-a88d-272fb85c82c8
5ded3ac5-eb61-440f-aa4a-958ddb5a4581	b4a8deab-e981-406c-a88d-272fb85c82c8
a833f282-9c6a-48c8-b757-4c2bde15fdcd	b4a8deab-e981-406c-a88d-272fb85c82c8
15055946-24c4-4091-85f5-d86210e001b5	b4a8deab-e981-406c-a88d-272fb85c82c8
a5a2cb8d-d0e2-4718-a052-807f6019a3c5	b4a8deab-e981-406c-a88d-272fb85c82c8
05342de1-db31-4d31-b30c-138fc131019f	b4a8deab-e981-406c-a88d-272fb85c82c8
05e0e44f-cba9-4389-80a8-93d8c1238125	b4a8deab-e981-406c-a88d-272fb85c82c8
d0104005-974f-423d-8480-d82ac3d0d9a0	b4a8deab-e981-406c-a88d-272fb85c82c8
d9ab0443-2a16-4c4b-9c2a-801c1c2c7326	b4a8deab-e981-406c-a88d-272fb85c82c8
afb2da26-c32c-4293-8e70-ce44ea512d58	eedbaf58-ceb5-48af-971f-80d9ed756932
afb2da26-c32c-4293-8e70-ce44ea512d58	3411c2c1-53f7-4b6a-8780-04caf43497cf
afb2da26-c32c-4293-8e70-ce44ea512d58	afe2a3c8-bbb1-440c-b1f2-8ac7cfd31dd3
25dc23c9-fc78-4647-97cd-149741a77307	3193f207-14e1-468c-9a60-12366b111b08
25dc23c9-fc78-4647-97cd-149741a77307	964439e4-3fa5-442b-98f2-5629b10e54c6
25dc23c9-fc78-4647-97cd-149741a77307	8c30ee8f-d153-40fa-b092-0378cf052288
25dc23c9-fc78-4647-97cd-149741a77307	83ceeb5a-9e8f-4c63-b671-6d8f3560f890
25dc23c9-fc78-4647-97cd-149741a77307	90586e33-9783-4143-ac23-e38f0665f1a9
25dc23c9-fc78-4647-97cd-149741a77307	7463cbb2-b6ac-4383-b8d4-0abf0d3bf323
25dc23c9-fc78-4647-97cd-149741a77307	c8db480e-8390-4496-a99e-93efca3c49db
25dc23c9-fc78-4647-97cd-149741a77307	33362f14-57ae-4518-9140-9b69907bc721
25dc23c9-fc78-4647-97cd-149741a77307	fc20baea-ea1a-45b7-a801-3a126d93937d
25dc23c9-fc78-4647-97cd-149741a77307	8778b977-06d5-479a-bd60-474903c6b024
25dc23c9-fc78-4647-97cd-149741a77307	19be8373-0fbf-48c9-8d18-bbee1df65cfb
25dc23c9-fc78-4647-97cd-149741a77307	b7cf04e7-a16c-44fc-9d85-93f5bbda4f93
25dc23c9-fc78-4647-97cd-149741a77307	fc01f525-4201-4005-b61e-6c3ad5d2b36e
25dc23c9-fc78-4647-97cd-149741a77307	40dec71f-adcb-48ac-af3c-606c6007158e
25dc23c9-fc78-4647-97cd-149741a77307	ff8c6822-a130-408e-98ce-1e083b2dfeca
25dc23c9-fc78-4647-97cd-149741a77307	a06d964e-7407-4b80-87f8-8ad3d0e6ff26
7306b841-10ab-4c35-ac50-22745ad15d37	a06d964e-7407-4b80-87f8-8ad3d0e6ff26
ca068d6a-9a3a-4efa-88a3-4065ef2fb773	a06d964e-7407-4b80-87f8-8ad3d0e6ff26
152776e5-c698-4833-832a-29c8eb6d450b	a06d964e-7407-4b80-87f8-8ad3d0e6ff26
1f2e5693-fa9d-47ac-9bce-ba608f8315b8	a06d964e-7407-4b80-87f8-8ad3d0e6ff26
afb2da26-c32c-4293-8e70-ce44ea512d58	489717d3-9c35-4de8-a8de-48848340b18a
25dc23c9-fc78-4647-97cd-149741a77307	4d4ecff6-54a2-4926-a391-881a5c9d2137
25dc23c9-fc78-4647-97cd-149741a77307	07e338d0-0827-4ba3-b350-5b55182d34dc
25dc23c9-fc78-4647-97cd-149741a77307	3492d892-d606-436d-af14-4c1e303d43db
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
d15c1b01-566a-4497-8bc9-3d9d87253ea1	+
44cee68c-7ad2-465c-b7e4-67db09369afc	+
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	http://ue.odl.local:4080/*
27095cb3-6ac7-4c91-98d9-26ddaa1ae1ec	http://ue.odl.local:9080/*
838fe32e-5500-4989-8194-c83c43aa5617	+
3d21aefb-1d20-4d27-9756-3cce60b5e958	+
797f6274-dc0a-4a46-8098-9e25decee64f	+
b7d79f1e-1531-45dc-a1b3-bd8167a251f7	/*
b2a0a790-59c5-4142-9d77-44932b1e8620	/*
c5892f7b-1dc2-4d6d-bb4b-d0c8ab34baea	https://api.learn.odl.local/
473685f9-266f-4983-b2a5-156a6dc8468c	/*
\.


--
-- Name: scim_remote_operation_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scim_remote_operation_seq', 318, true);


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: scim_external_resource_mapping external_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_external_resource_mapping
    ADD CONSTRAINT external_id_unique UNIQUE (scim_remote_provider_id, realm_id, local_resource_id, resource_assignment);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: scim_external_resource_mapping pk_external_resource_map_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_external_resource_mapping
    ADD CONSTRAINT pk_external_resource_map_id PRIMARY KEY (id);


--
-- Name: scim_client_resource_filtering pk_resource_filtering_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_client_resource_filtering
    ADD CONSTRAINT pk_resource_filtering_id PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: scim_resource_schema_mapping pk_schema_resource_type_map_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_resource_schema_mapping
    ADD CONSTRAINT pk_schema_resource_type_map_id PRIMARY KEY (id);


--
-- Name: scim_schema_attribute pk_scim_attribute_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_schema_attribute
    ADD CONSTRAINT pk_scim_attribute_id PRIMARY KEY (id);


--
-- Name: scim_remote_authentication pk_scim_remote_auth_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_remote_authentication
    ADD CONSTRAINT pk_scim_remote_auth_id PRIMARY KEY (id);


--
-- Name: scim_remote_operation pk_scim_remote_op_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_remote_operation
    ADD CONSTRAINT pk_scim_remote_op_id PRIMARY KEY (id);


--
-- Name: scim_remote_provider pk_scim_remote_provider_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_remote_provider
    ADD CONSTRAINT pk_scim_remote_provider_id PRIMARY KEY (id);


--
-- Name: scim_resource pk_scim_resource; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_resource
    ADD CONSTRAINT pk_scim_resource PRIMARY KEY (id, realm_id, type, component_id, external_id);


--
-- Name: scim_resource_type pk_scim_resource_type_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_resource_type
    ADD CONSTRAINT pk_scim_resource_type_id PRIMARY KEY (id);


--
-- Name: scim_schema pk_scim_schema_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_schema
    ADD CONSTRAINT pk_scim_schema_id PRIMARY KEY (id);


--
-- Name: scim_service_provider pk_scim_service_provider_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_service_provider
    ADD CONSTRAINT pk_scim_service_provider_id PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: scim_service_provider scim_sp_realm_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_service_provider
    ADD CONSTRAINT scim_sp_realm_unique UNIQUE (realm_id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: ext_resource_local_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ext_resource_local_id_idx ON public.scim_external_resource_mapping USING btree (local_resource_id, realm_id);


--
-- Name: ext_resource_prov_realm_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ext_resource_prov_realm_idx ON public.scim_external_resource_mapping USING btree (scim_remote_provider_id, realm_id);


--
-- Name: ext_resource_realm_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ext_resource_realm_idx ON public.scim_external_resource_mapping USING btree (realm_id);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: remote_provider_auth_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX remote_provider_auth_idx ON public.scim_remote_authentication USING btree (scim_remote_provider_id);


--
-- Name: remote_provider_realm_1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX remote_provider_realm_1_idx ON public.scim_remote_provider_mapping USING btree (scim_remote_provider_id);


--
-- Name: remote_provider_realm_2_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX remote_provider_realm_2_idx ON public.scim_remote_provider_mapping USING btree (realm_id);


--
-- Name: remote_provider_rt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX remote_provider_rt_idx ON public.scim_resource_type USING btree (scim_remote_provider_id);


--
-- Name: remote_provider_schema_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX remote_provider_schema_idx ON public.scim_schema USING btree (scim_remote_provider_id);


--
-- Name: resource_type_provider_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX resource_type_provider_idx ON public.scim_resource_type USING btree (service_provider_id);


--
-- Name: resource_type_schema_map_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX resource_type_schema_map_idx ON public.scim_resource_schema_mapping USING btree (resource_type_id);


--
-- Name: scim_attribute_parent_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scim_attribute_parent_idx ON public.scim_schema_attribute USING btree (parent_attribute);


--
-- Name: scim_attribute_schema_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scim_attribute_schema_idx ON public.scim_schema_attribute USING btree (schema_id);


--
-- Name: scim_endpoint_create_roles_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scim_endpoint_create_roles_idx ON public.scim_endpoint_create_roles USING btree (scim_resource_type_id);


--
-- Name: scim_endpoint_delete_roles_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scim_endpoint_delete_roles_idx ON public.scim_endpoint_delete_roles USING btree (scim_resource_type_id);


--
-- Name: scim_endpoint_get_roles_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scim_endpoint_get_roles_idx ON public.scim_endpoint_get_roles USING btree (scim_resource_type_id);


--
-- Name: scim_endpoint_list_roles_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scim_endpoint_list_roles_idx ON public.scim_endpoint_list_roles USING btree (scim_resource_type_id);


--
-- Name: scim_endpoint_roles_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scim_endpoint_roles_idx ON public.scim_endpoint_roles USING btree (scim_resource_type_id);


--
-- Name: scim_endpoint_update_roles_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scim_endpoint_update_roles_idx ON public.scim_endpoint_update_roles USING btree (scim_resource_type_id);


--
-- Name: scim_sp_authorized_client_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scim_sp_authorized_client_idx ON public.scim_sp_authorized_clients USING btree (scim_service_provider_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: scim_schema_attribute attribute_schema_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_schema_attribute
    ADD CONSTRAINT attribute_schema_fk FOREIGN KEY (schema_id) REFERENCES public.scim_schema(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: scim_resource fk_scim_resource_component; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_resource
    ADD CONSTRAINT fk_scim_resource_component FOREIGN KEY (component_id) REFERENCES public.component(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: scim_resource fk_scim_resource_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_resource
    ADD CONSTRAINT fk_scim_resource_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- Name: scim_resource_schema_mapping resource_type_schema_map_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_resource_schema_mapping
    ADD CONSTRAINT resource_type_schema_map_fk FOREIGN KEY (resource_type_id) REFERENCES public.scim_resource_type(id);


--
-- Name: scim_resource_type resource_type_sp_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_resource_type
    ADD CONSTRAINT resource_type_sp_fk FOREIGN KEY (service_provider_id) REFERENCES public.scim_service_provider(id);


--
-- Name: scim_resource_schema_mapping schema_mapping_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_resource_schema_mapping
    ADD CONSTRAINT schema_mapping_fk FOREIGN KEY (schema_id) REFERENCES public.scim_schema(id);


--
-- Name: scim_endpoint_create_roles scim_endpoint_create_role_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_endpoint_create_roles
    ADD CONSTRAINT scim_endpoint_create_role_fk FOREIGN KEY (scim_resource_type_id) REFERENCES public.scim_resource_type(id);


--
-- Name: scim_endpoint_delete_roles scim_endpoint_delete_role_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_endpoint_delete_roles
    ADD CONSTRAINT scim_endpoint_delete_role_fk FOREIGN KEY (scim_resource_type_id) REFERENCES public.scim_resource_type(id);


--
-- Name: scim_endpoint_get_roles scim_endpoint_get_role_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_endpoint_get_roles
    ADD CONSTRAINT scim_endpoint_get_role_fk FOREIGN KEY (scim_resource_type_id) REFERENCES public.scim_resource_type(id);


--
-- Name: scim_endpoint_list_roles scim_endpoint_list_role_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_endpoint_list_roles
    ADD CONSTRAINT scim_endpoint_list_role_fk FOREIGN KEY (scim_resource_type_id) REFERENCES public.scim_resource_type(id);


--
-- Name: scim_endpoint_roles scim_endpoint_role_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_endpoint_roles
    ADD CONSTRAINT scim_endpoint_role_fk FOREIGN KEY (scim_resource_type_id) REFERENCES public.scim_resource_type(id);


--
-- Name: scim_endpoint_update_roles scim_endpoint_update_role_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_endpoint_update_roles
    ADD CONSTRAINT scim_endpoint_update_role_fk FOREIGN KEY (scim_resource_type_id) REFERENCES public.scim_resource_type(id);


--
-- Name: scim_remote_authentication scim_remote_provider_auth_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_remote_authentication
    ADD CONSTRAINT scim_remote_provider_auth_fk FOREIGN KEY (scim_remote_provider_id) REFERENCES public.scim_remote_provider(id);


--
-- Name: scim_remote_provider_mapping scim_remote_provider_realm_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_remote_provider_mapping
    ADD CONSTRAINT scim_remote_provider_realm_fk FOREIGN KEY (scim_remote_provider_id) REFERENCES public.scim_remote_provider(id);


--
-- Name: scim_resource_type scim_remote_provider_rt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_resource_type
    ADD CONSTRAINT scim_remote_provider_rt_fk FOREIGN KEY (scim_remote_provider_id) REFERENCES public.scim_remote_provider(id);


--
-- Name: scim_schema scim_remote_provider_schema_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_schema
    ADD CONSTRAINT scim_remote_provider_schema_fk FOREIGN KEY (scim_remote_provider_id) REFERENCES public.scim_remote_provider(id);


--
-- Name: scim_sp_authorized_clients scim_sp_authorized_client_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scim_sp_authorized_clients
    ADD CONSTRAINT scim_sp_authorized_client_fk FOREIGN KEY (scim_service_provider_id) REFERENCES public.scim_service_provider(id);


--
-- PostgreSQL database dump complete
--

