-- =====================================================
-- NullBank - Criação do Banco de Dados
-- PostgreSQL
-- =====================================================

-- =========================
-- ENUMS
-- =========================

CREATE TYPE cargo_enum AS ENUM (
    'GERENTE',
    'CAIXA',
    'ATENDENTE',
    'ANALISTA',
    'DIRETOR'
);

CREATE TYPE parentesco_enum AS ENUM (
    'PAI',
    'MAE',
    'FILHO',
    'FILHA',
    'CONJUGE',
    'OUTRO'
);

CREATE TYPE tipo_conta_enum AS ENUM (
    'CORRENTE',
    'POUPANCA',
    'SALARIO'
);

CREATE TYPE tipo_titular_enum AS ENUM (
    'TITULAR',
    'DEPENDENTE'
);

CREATE TYPE tipo_transacao_enum AS ENUM (
    'DEPOSITO',
    'SAQUE',
    'PIX',
    'TRANSFERENCIA',
    'PAGAMENTO'
);

-- =========================
-- AGENCIA
-- =========================

CREATE TABLE agencia (
    num_ag INTEGER PRIMARY KEY,
    nome_ag VARCHAR(100) NOT NULL,
    sal_total DECIMAL(15,2) NOT NULL DEFAULT 0,
    cidade VARCHAR(100) NOT NULL
);

-- =========================
-- FUNCIONARIO
-- =========================

CREATE TABLE funcionario (
    matricula INTEGER PRIMARY KEY,

    num_ag INTEGER NOT NULL,

    nome_completo VARCHAR(150) NOT NULL,
    cargo cargo_enum NOT NULL,
    salario DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_funcionario_agencia
        FOREIGN KEY (num_ag)
        REFERENCES agencia(num_ag)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =========================
-- DEPENDENTE
-- =========================

CREATE TABLE dependente (
    id_dependente SERIAL PRIMARY KEY,

    matricula_func INTEGER NOT NULL,

    nome_completo VARCHAR(150) NOT NULL,
    parentesco parentesco_enum NOT NULL,

    CONSTRAINT fk_dependente_funcionario
        FOREIGN KEY (matricula_func)
        REFERENCES funcionario(matricula)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =========================
-- CLIENTE
-- =========================

CREATE TABLE cliente (
    cpf CHAR(11) PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL
);

-- =========================
-- TELEFONE
-- =========================

CREATE TABLE telefone (
    id_telefone SERIAL PRIMARY KEY,

    cpf_cliente CHAR(11) NOT NULL,

    numero VARCHAR(11) NOT NULL,

    CONSTRAINT fk_telefone_cliente
        FOREIGN KEY (cpf_cliente)
        REFERENCES cliente(cpf)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =========================
-- EMAIL
-- =========================

CREATE TABLE email (
    id_email SERIAL PRIMARY KEY,

    cpf_cliente CHAR(11) NOT NULL,

    endereco VARCHAR(254) NOT NULL UNIQUE,

    CONSTRAINT fk_email_cliente
        FOREIGN KEY (cpf_cliente)
        REFERENCES cliente(cpf)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =========================
-- CONTA
-- =========================

CREATE TABLE conta (
    num_conta INTEGER PRIMARY KEY,

    num_ag INTEGER NOT NULL,
    matricula_gerente INTEGER NOT NULL,

    saldo DECIMAL(15,2) NOT NULL DEFAULT 0,

    tipo_conta tipo_conta_enum NOT NULL,

    CONSTRAINT fk_conta_agencia
        FOREIGN KEY (num_ag)
        REFERENCES agencia(num_ag)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_conta_gerente
        FOREIGN KEY (matricula_gerente)
        REFERENCES funcionario(matricula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =========================
-- TITULARIDADE
-- =========================

CREATE TABLE titularidade (

    num_conta INTEGER NOT NULL,
    cpf_cliente CHAR(11) NOT NULL,

    tipo_titular tipo_titular_enum NOT NULL,

    PRIMARY KEY (num_conta, cpf_cliente),

    CONSTRAINT fk_titularidade_conta
        FOREIGN KEY (num_conta)
        REFERENCES conta(num_conta)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_titularidade_cliente
        FOREIGN KEY (cpf_cliente)
        REFERENCES cliente(cpf)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =========================
-- TRANSACAO
-- =========================

CREATE TABLE transacao (
    num_transacao INTEGER PRIMARY KEY,

    num_conta INTEGER NOT NULL,

    tipo_transacao tipo_transacao_enum NOT NULL,

    valor DECIMAL(15,2) NOT NULL CHECK (valor > 0),

    CONSTRAINT fk_transacao_conta
        FOREIGN KEY (num_conta)
        REFERENCES conta(num_conta)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =========================
-- ÍNDICES
-- =========================

CREATE INDEX idx_funcionario_agencia
ON funcionario(num_ag);

CREATE INDEX idx_dependente_funcionario
ON dependente(matricula_func);

CREATE INDEX idx_telefone_cliente
ON telefone(cpf_cliente);

CREATE INDEX idx_email_cliente
ON email(cpf_cliente);

CREATE INDEX idx_conta_agencia
ON conta(num_ag);

CREATE INDEX idx_conta_gerente
ON conta(matricula_gerente);

CREATE INDEX idx_titularidade_cliente
ON titularidade(cpf_cliente);

CREATE INDEX idx_transacao_conta
ON transacao(num_conta);