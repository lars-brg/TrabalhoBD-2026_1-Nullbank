-- ==========================================
-- O montante total do salário de uma agência (sal_total) deve ser calculado 
-- e atualizado a cada inserção, atualização ou remoção de um funcionário na respectiva agência. 
-- ==========================================
DELIMITER $$
CREATE TRIGGER funcionario_admissao                     -- GATILHO DE ADMISSÃO (INSERT)
AFTER INSERT ON funcionario
FOR EACH ROW
BEGIN
    UPDATE agencia
    SET sal_total = sal_total + NEW.salario
    WHERE num_ag = NEW.num_ag;
END $$

CREATE TRIGGER funcionario_demissao                 -- GATILHO DE DEMISSÃO(DELETE)
AFTER DELETE ON funcionario
FOR EACH ROW
BEGIN
    UPDATE agencia
    SET sal_total = sal_total - OLD.salario
    WHERE num_ag = OLD.num_ag;
END;

CREATE TRIGGER funcionario_atualizacao                     -- GATILHO DE ATUALIZAÇÃO (UPDATE)
AFTER UPDATE ON funcionario
FOR EACH ROW
BEGIN
    IF OLD.num_ag != NEW.num_ag THEN
        UPDATE agencia SET sal_total = sal_total - OLD.salario WHERE num_ag = OLD.num_ag;
        UPDATE agencia SET sal_total = sal_total + NEW.salario WHERE num_ag = NEW.num_ag;
    ELSE
        UPDATE agencia SET sal_total = sal_total - OLD.salario + NEW.salario WHERE num_ag = NEW.num_ag;
    END IF;
END $$

CREATE TRIGGER trg_verificar_saldo                     -- GATILHO DE SALDO NEGATIVO NA CONTA
BEFORE UPDATE ON conta
FOR EACH ROW
BEGIN
    DECLARE v_limite DECIMAL(15,2);

    IF NEW.saldo < 0 THEN
        IF NEW.tipo_conta != 'conta_especial' THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Operação negada: Apenas contas especiais podem ter saldo negativo.';
        ELSE
            SELECT limite_credito INTO v_limite FROM conta_especial WHERE num_conta = NEW.num_conta;
            SET v_limite = IFNULL(v_limite, 0);

            IF NEW.saldo < -v_limite THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Operação negada: O valor ultrapassa o limite de crédito da conta especial.';
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

-- ==========================================
-- O cliente pode possuir várias contas, mas é restrito a, no máximo, uma conta por agência. 
-- ==========================================
DELIMITER $$
CREATE TRIGGER uma_conta_por_agencia                    -- GATILHO DE MÁXIMO DE UMA CONTA POR AGÊNCIA
BEFORE INSERT ON titularidade
FOR EACH ROW 
BEGIN
    DECLARE v_quantidade_contas INT;
    DECLARE v_agencia_da_conta MEDIUMINT UNSIGNED;
    
    SELECT num_ag INTO v_agencia_da_conta               -- Descobre qual é a agência da conta que estão tentando vincular
    FROM conta 
    WHERE num_conta = NEW.num_conta;

    SELECT COUNT(*) INTO v_quantidade_contas            -- Conta quantas contas o cliente já tem cadastrada nessa mesma agência
    FROM titularidade t
    JOIN conta c ON t.num_conta = c.num_conta
    WHERE t.cpf_cliente = NEW.cpf_cliente 
      AND c.num_ag = v_agencia_da_conta;

    
    IF v_quantidade_contas > 0 THEN                     -- Se já tiver 1 ou mais, bloqueia a operação
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Operação cancelada: O cliente já possui uma conta nesta agência.';
    END IF;
END $$

CREATE TRIGGER trg_uma_conta_por_agencia_update
BEFORE UPDATE ON titularidade
FOR EACH ROW
BEGIN
    DECLARE v_qtd INT;
    DECLARE v_agencia INT;

    SELECT num_ag
    INTO v_agencia
    FROM conta
    WHERE num_conta = NEW.num_conta;

    SELECT COUNT(*)
    INTO v_qtd
    FROM titularidade t
    JOIN conta c
        ON c.num_conta = t.num_conta
    WHERE t.cpf_cliente = NEW.cpf_cliente
      AND c.num_ag = v_agencia
      AND NOT (
            t.cpf_cliente = OLD.cpf_cliente
        AND t.num_conta = OLD.num_conta
      );

    IF v_qtd > 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Cliente já possui conta nesta agência';

    END IF;
END $$

DELIMITER ;

-- ==========================================
-- O saldo não pode ficar negativado em nenhum momento, exceto no caso de 
-- uma "conta especial", contanto que esteja dentro do limite de crédito. 
-- ==========================================
DELIMITER $$
CREATE TRIGGER trg_impede_saldo_negativo                            -- GATILHO DE IMPEDIR SALDO NEGATIVO
BEFORE INSERT ON transacao
FOR EACH ROW 
BEGIN
    DECLARE v_saldo_atual DECIMAL(15,2);
    DECLARE v_tipo_da_conta VARCHAR(50);
    DECLARE v_limite DECIMAL(15,2) DEFAULT 0.00;

    
    SELECT saldo, tipo_conta                                        -- Busca o saldo atual e o tipo da conta
    INTO v_saldo_atual, v_tipo_da_conta 
    FROM conta 
    WHERE num_conta = NEW.num_conta;

   
    IF v_tipo_da_conta = 'conta_especial' THEN                      -- Se for conta especial, busca o limite de crédito na tabela filha
        SELECT limite_credito
        INTO v_limite
        FROM conta_especial
        WHERE num_conta = NEW.num_conta;
    END IF;

    
    IF NEW.tipo_transacao IN ('saque', 'pagamento', 'transferencia', 'pix') THEN   -- Avalia se a transação for de saída de dinheiro
        
        
        IF (v_saldo_atual - NEW.valor) < (-v_limite) THEN                   -- Verifica se o saldo final vai estourar o limite negativo
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Operação negada: Saldo insuficiente ou Limite de Crédito excedido para esta operação.';
        END IF;
        
    END IF;
END $$

CREATE TRIGGER trg_impede_saldo_negativo_update
BEFORE UPDATE ON transacao
FOR EACH ROW
BEGIN

    DECLARE v_saldo_atual DECIMAL(15,2);
    DECLARE v_saldo_simulado DECIMAL(15,2);
    DECLARE v_limite DECIMAL(15,2) DEFAULT 0;
    DECLARE v_tipo_conta VARCHAR(30);

    SELECT saldo, tipo_conta
    INTO v_saldo_atual, v_tipo_conta
    FROM conta
    WHERE num_conta = NEW.num_conta;

    IF v_tipo_conta = 'conta_especial' THEN

        SELECT limite_credito
        INTO v_limite
        FROM conta_especial
        WHERE num_conta = NEW.num_conta;

        SET v_limite = IFNULL(v_limite,0);

    END IF;

    SET v_saldo_simulado = v_saldo_atual;

    IF OLD.tipo_transacao IN
       ('saque','pagamento','transferencia','pix')
    THEN
        SET v_saldo_simulado =
            v_saldo_simulado + OLD.valor;
    ELSE
        SET v_saldo_simulado =
            v_saldo_simulado - OLD.valor;
    END IF;

    IF NEW.tipo_transacao IN
       ('saque','pagamento','transferencia','pix')
    THEN
        SET v_saldo_simulado =
            v_saldo_simulado - NEW.valor;
    ELSE
        SET v_saldo_simulado =
            v_saldo_simulado + NEW.valor;
    END IF;

    IF v_tipo_conta <> 'conta_especial'
       AND v_saldo_simulado < 0
    THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Operação negada: saldo insuficiente.';

    END IF;

    IF v_tipo_conta = 'conta_especial'
       AND v_saldo_simulado < -v_limite
    THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Operação negada: limite de crédito excedido.';

    END IF;

END $$

DELIMITER ;

-- ==========================================
-- A atualização do saldo deve ser feita de forma automática refletindo o conjunto de transações.
-- ==========================================
DELIMITER $$
CREATE TRIGGER atualiza_saldo_insert                                                       -- GATILHO ATUALIZAÇÃO DE SALDO AUTOMÁTICO
AFTER INSERT ON transacao
FOR EACH ROW
BEGIN
    
    IF NEW.tipo_transacao IN ('deposito', 'estorno') THEN                           -- Se for ENTRADA de dinheiro, SOMA no saldo
        UPDATE conta
        SET saldo = saldo + NEW.valor
        WHERE num_conta = NEW.num_conta;
        
    
    ELSEIF NEW.tipo_transacao IN ('saque', 'pagamento', 'pix', 'transferencia') THEN -- Se for SAÍDA de dinheiro, SUBTRAI do saldo
        UPDATE conta
        SET saldo = saldo - NEW.valor
        WHERE num_conta = NEW.num_conta;
    END IF;
END $$
DELIMITER ;

-- ==========================================
-- Update da transação
-- ==========================================

DELIMITER $$

CREATE TRIGGER trg_update_transacao
AFTER UPDATE ON transacao
FOR EACH ROW
BEGIN

    UPDATE conta
    SET saldo = saldo +
    CASE
        WHEN OLD.tipo_transacao IN 
            ('saque','pagamento','transferencia', 'pix') THEN OLD.valor
    ELSE -OLD.valor
    END
    +
    CASE
        WHEN NEW.tipo_transacao IN 
            ('deposito','estorno') THEN NEW.valor
        ELSE -NEW.valor
    END
    WHERE num_conta = NEW.num_conta;

END $$

CREATE TRIGGER trg_bloqueia_mudanca_conta
BEFORE UPDATE ON transacao
FOR EACH ROW
BEGIN

    IF OLD.num_conta <> NEW.num_conta THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Não é permitido alterar a conta de uma transação';
    END IF;

END $$

DELIMITER ;

-- ==========================================
-- Quando houver remoção de alguma transação
-- ==========================================

DELIMITER $$
CREATE TRIGGER trg_delete_transacao
AFTER DELETE ON transacao
FOR EACH ROW
BEGIN
    IF OLD.tipo_transacao IN ('deposito','estorno') THEN
        UPDATE conta
        SET saldo = saldo - OLD.valor
        WHERE num_conta = OLD.num_conta;
    ELSE
        UPDATE conta
        SET saldo = saldo + OLD.valor
        WHERE num_conta = OLD.num_conta;
    END IF;
END $$

DELIMITER ;


 -- _ Início da Alteração depois da entrega: _

-- ==========================================
-- GATILHO: Gerar num_transacao sequencial por conta
-- ==========================================
DELIMITER $$

CREATE TRIGGER trg_auto_num_transacao
BEFORE INSERT ON transacao
FOR EACH ROW
BEGIN
    DECLARE v_proximo_num INT;

    -- Pega o maior número de transação atual desta conta e soma 1
    -- Se for a primeira transação (NULL), o IFNULL transforma em 0, resultando em 1
    SELECT IFNULL(MAX(num_transacao), 0) + 1
    INTO v_proximo_num
    FROM transacao
    WHERE num_conta = NEW.num_conta;

    -- Atribui o valor calculado à nova linha antes dela ser salva
    SET NEW.num_transacao = v_proximo_num;
END $$

DELIMITER ;

-- ==========================================
-- GATILHO: Limite de 5 dependentes por funcionário
-- ==========================================
DELIMITER $$

CREATE TRIGGER trg_limite_dependentes
BEFORE INSERT ON dependente
FOR EACH ROW
BEGIN
    DECLARE qtd INT;

    SELECT COUNT(*)
    INTO qtd
    FROM dependente
    WHERE matricula_func = NEW.matricula_func;

    IF qtd >= 5 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Operação cancelada: Funcionário já possui o máximo de 5 dependentes.';
    END IF;
END $$

DELIMITER ;

-- ==========================================
-- GATILHO: O gerente da conta deve pertencer à mesma agência da conta
-- ==========================================
DELIMITER $$

CREATE TRIGGER trg_gerente_mesma_agencia
BEFORE INSERT ON conta
FOR EACH ROW
BEGIN
    DECLARE v_agencia_gerente INT;

    SELECT num_ag
    INTO v_agencia_gerente
    FROM funcionario
    WHERE matricula = NEW.matricula_gerente;

    IF v_agencia_gerente <> NEW.num_ag THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Operação cancelada: O gerente deve pertencer à mesma agência da conta.';
    END IF;
END $$

DELIMITER ;

 -- _ Fim da Alteração depois da entrega: _