-- init-schema.sql

-- Connect to the app database
\c cv_web_db;

-- Create schema for app data
CREATE SCHEMA IF NOT EXISTS cv_web_schema AUTHORIZATION postgres;

-- Grant all privileges to postgres (or another app user)
GRANT ALL ON SCHEMA cv_web_schema TO postgres;

--- Create a new app user
CREATE ROLE app_user WITH LOGIN PASSWORD 'password'; --- pragma: allowlist secret

GRANT CONNECT ON DATABASE cv_web_db TO app_user;
GRANT USAGE ON SCHEMA cv_web_schema TO app_user;
GRANT CREATE ON SCHEMA cv_web_schema TO app_user;