-- init.sql - Scripts de inicialização do PostgreSQL
-- Este script é executado quando o container PostgreSQL inicia pela primeira vez

-- Criar extensões padrão
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "hstore";
CREATE EXTENSION IF NOT EXISTS "pg_stat_statements";

-- Criar schema para aplicação
CREATE SCHEMA IF NOT EXISTS app_schema;

-- Configurar permissões padrão
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO appuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO appuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT EXECUTE ON FUNCTIONS TO appuser;

-- Tabela para auditoria de health check
CREATE TABLE IF NOT EXISTS health_checks (
    id SERIAL PRIMARY KEY,
    check_time TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(10) DEFAULT 'OK',
    message TEXT
);

-- Inserir registro inicial
INSERT INTO health_checks (status, message) VALUES ('OK', 'Database initialized successfully');