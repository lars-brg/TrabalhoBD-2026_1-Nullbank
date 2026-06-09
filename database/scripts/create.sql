-- =========================
-- 1. BANCO
-- =========================
CREATE DATABASE IF NOT EXISTS equipe540863;
USE equipe540863;

-- =========================
-- 2. TABELAS BASE
-- =========================

CREATE TABLE endereco (
    id_endereco INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo_logradouro VARCHAR(20),
    nome_logradouro VARCHAR(150),
    numero VARCHAR(10),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep CHAR(8)
) ENGINE=InnoDB;

CREATE TABLE agencia (
    num_ag MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome_ag VARCHAR(100) NOT NULL,
    sal_total DECIMAL(15,2) NOT NULL,
    cidade VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- =========================
-- 3. FUNCIONARIO
-- =========================

CREATE TABLE funcionario (
    matricula INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    num_ag MEDIUMINT UNSIGNED NOT NULL,
    id_endereco INT UNSIGNED,
    nome_completo VARCHAR(150) NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    cargo ENUM('gerente','atendente','caixa') NOT NULL,
    genero ENUM('masculino','feminino','nao_binario'),
    data_nascimento DATE NOT NULL,
    salario DECIMAL(10,2) CHECK (salario >= 2286.00) NOT NULL,

    CONSTRAINT fk_funcionario_agencia
        FOREIGN KEY (num_ag)
        REFERENCES agencia(num_ag)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_funcionario_endereco
        FOREIGN KEY (id_endereco)
        REFERENCES endereco(id_endereco)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB;

-- =========================
-- 4. CLIENTE
-- =========================

CREATE TABLE cliente (
    cpf CHAR(11) PRIMARY KEY,
    id_endereco INT UNSIGNED,
    nome_completo VARCHAR(150) NOT NULL,
    rg VARCHAR(15) UNIQUE,
    orgao_emissor VARCHAR(20),
    uf_rg CHAR(2),
    data_nascimento DATE NOT NULL,

    CONSTRAINT fk_cliente_endereco
        FOREIGN KEY (id_endereco)
        REFERENCES endereco(id_endereco)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB;

-- =========================
-- 5. ENTIDADES DEPENDENTES
-- =========================

CREATE TABLE dependente (
    matricula_func INT UNSIGNED,
    nome_completo VARCHAR(150) NOT NULL,
    parentesco ENUM('filho_a','conjuge','genitor_a') NOT NULL,
    data_nascimento DATE,

    PRIMARY KEY (matricula_func, nome_completo),

    CONSTRAINT fk_dependente_funcionario
        FOREIGN KEY (matricula_func)
        REFERENCES funcionario(matricula)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE telefone (
    id_telefone INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cpf_cliente CHAR(11) NOT NULL,
    numero VARCHAR(11) NOT NULL,
    descricao VARCHAR(30),

    CONSTRAINT fk_telefone_cliente
        FOREIGN KEY (cpf_cliente)
        REFERENCES cliente(cpf)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE email (
    id_email INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cpf_cliente CHAR(11) NOT NULL,
    endereco_email VARCHAR(254) NOT NULL,
    descricao VARCHAR(30),

    CONSTRAINT fk_email_cliente
        FOREIGN KEY (cpf_cliente)
        REFERENCES cliente(cpf)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- =========================
-- 6. CONTA
-- =========================

CREATE TABLE conta (
    num_conta INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    num_ag MEDIUMINT UNSIGNED NOT NULL,
    matricula_gerente INT UNSIGNED NOT NULL,
    saldo DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    senha_hash VARCHAR(255) NOT NULL,
    tipo_conta ENUM('conta_corrente','poupanca','conta_especial') NOT NULL,

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
) ENGINE=InnoDB;

-- =========================
-- 7. ESPECIALIZAÇÃO CONTA
-- =========================

CREATE TABLE conta_poupanca (
    num_conta INT UNSIGNED PRIMARY KEY,
    taxa_juros DECIMAL(5,2) NOT NULL CHECK (taxa_juros >= 0),

    CONSTRAINT fk_cp_conta
        FOREIGN KEY (num_conta)
        REFERENCES conta(num_conta)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE conta_especial (
    num_conta INT UNSIGNED PRIMARY KEY,
    limite_credito DECIMAL(15,2) NOT NULL CHECK (limite_credito >= 0),

    CONSTRAINT fk_ce_conta
        FOREIGN KEY (num_conta)
        REFERENCES conta(num_conta)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE conta_corrente (
    num_conta INT UNSIGNED PRIMARY KEY,
    data_aniversario_contrato DATE,

    CONSTRAINT fk_cc_conta
        FOREIGN KEY (num_conta)
        REFERENCES conta(num_conta)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- =========================
-- 8. TITULARIDADE (N:N)
-- =========================

CREATE TABLE titularidade (
    num_conta INT UNSIGNED NOT NULL,
    cpf_cliente CHAR(11) NOT NULL,
    tipo_titular ENUM('titular_1','titular_2') NOT NULL,

    PRIMARY KEY (num_conta, cpf_cliente),
    UNIQUE (num_conta, tipo_titular),

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
) ENGINE=InnoDB;

-- =========================
-- 9. TRANSACOES
-- =========================

CREATE TABLE transacao (
    num_conta INT UNSIGNED NOT NULL,
    num_transacao INT UNSIGNED NOT NULL,
    tipo_transacao ENUM('deposito','saque','transferencia','pix','pagamento','estorno') NOT NULL,
    valor DECIMAL(15,2) CHECK (valor > 0) NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (num_conta, num_transacao),

    CONSTRAINT fk_transacao_conta
        FOREIGN KEY (num_conta)
        REFERENCES conta(num_conta)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;