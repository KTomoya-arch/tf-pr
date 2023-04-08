locals {
  env_str = "dev"
  region  = "asia-northeast1"
}

locals {
  host_project = "worx-${local.env_str}"

  service_projects = {
    engine   = "worx-engine-${local.env_str}"
    labor    = "worx-labor-${local.env_str}"
    personal = "worx-personal-${local.env_str}"
    mynumber = "worx-mynumber-${local.env_str}"
  }
}

locals {
  secret_keys_bff_engine = {
    apollo = "APOLLO_KEY"
    auth0  = "AUTH0_CLIENT_SECRET"
    redis  = "REDIS_PASSWORD"
  }

  secret_keys_bff_personal = {
    apollo  = "APOLLO_KEY"
    auth0   = "AUTH0_CLIENT_SECRET"
    redis   = "REDIS_PASSWORD"
    session = "PERSONAL_SESSION_SECRET"
  }

  secret_keys_bff_labor = {
    apollo = "APOLLO_KEY"
    auth0  = "AUTH0_CLIENT_SECRET"
    redis  = "REDIS_PASSWORD"
    slack  = "slackwebhook"
  }

  secret_keys_bff_mynumber = {
    apollo = "APOLLO_KEY"
    auth0  = "AUTH0_CLIENT_SECRET"
    redis  = "REDIS_PASSWORD"
  }
}

locals {
  secret_keys_be = {
    account_db_pswd             = "ACCOUNT_DB_PASSWORD"
    account_db_user             = "ACCOUNT_DB_USER"
    account_auth0_client_secret = "ACCOUNT_SERVICE_AUTH0_CLIENT_SECRET"
    alert_common_webhook        = "alert-common-${local.env_str}-webhook"
    alert_engine_webhook        = "alert-engine-${local.env_str}-webhook"
    alert_labor_mgmt_webhook    = "alert-labormanagement-${local.env_str}-webhook"
    alert_personal_webhook      = "alert-personal-${local.env_str}-webhook"
    apollo_api_key_engine       = "APOLLO_API_KEY_ENGINE"
    apollo_api_key_labor_mgmt   = "APOLLO_API_KEY_LABOR_MANAGEMENT"
    apollo_api_key_mynumber     = "APOLLO_API_KEY_MYNUMBER"
    apollo_api_key_personal     = "APOLLO_API_KEY_PERSONAL"
    apollo_schema_reporting     = "APOLLO_SCHEMA_REPORTING"
    composer_auth_json          = "COMPOSER_AUTH_JSON"
    custom_import_db_pswd       = "CUSTOM_IMPORT_DB_PASSWORD"
    custom_import_db_user       = "CUSTOM_IMPORT_DB_USER"
    datadog_api_key             = "DATADOG_API_KEY"
    developer_db_pswd           = "DEVELOPER_DB_PASSWORD"
    developer_db_user           = "DEVELOPER_DB_USER"
    egov_authorization          = "EGOV_AUTHORIZATION"
    egov_client_id              = "EGOV_CLIENT_ID"
    employee_api_link_db_pswd   = "EMPLOYEE_API_LINK_DB_PASSWORD"
    employee_api_link_db_user   = "EMPLOYEE_API_LINK_DB_USER"
    employee_db_pswd            = "EMPLOYEE_DB_PASSWORD"
    employee_db_user            = "EMPLOYEE_DB_USER"
    express_session_secrets     = "EXPRESS_SESSION_SECRETS"
    gdrive_batch_token          = "GDRIVE_BATCH_TOKEN"
    freee_client_secret         = "FREEE_CLIENT_SECRET"
    labor_db_pswd               = "LABOR_DB_PASSWORD"
    labor_db_user               = "LABOR_DB_USER"
    labor_ea_db_pswd            = "LABOR_EA_DB_PASSWORD"
    labor_ea_db_user            = "LABOR_EA_DB_USER"
    migration_db_pswd           = "MIGRATION_DB_PASSWORD"
    migration_db_user           = "MIGRATION_DB_USER"
    mynumber_db_pswd            = "MYNUMBER_DB_PASSWORD"
    mynumber_db_user            = "MYNUMBER_DB_USER"
    nalysys_npmrc               = "NALYSYS_NPMRC"
    personal_db_pswd            = "PERSONAL_DB_PASSWORD"
    personal_db_user            = "PERSONAL_DB_USER"
    postgres_super_user_pswd    = "POSTGRES_SUPER_USER_PASS"
    salary_db_pswd              = "SALARY_DB_PASSWORD"
    sendgrid_api_key            = "SENDGRID_API_KEY"
    slack_webhook               = "slackwebhook"
    storage_db_pswd             = "STORAGE_DB_PASSWORD"
    survey_db_pswd              = "SURVEY_DB_PASSWORD"
    survey_db_user              = "SURVEY_DB_USER"
    tmp_token_api_key           = "TEMPORARY_TOKEN_API_KEY"
    worx_db_pswd                = "WORX_DB_PASSWORD"
    worx_jwt_secret             = "WORX_JWT_SECRET"
    worx_npmrc                  = "WORX_NPMRC"
  }
}