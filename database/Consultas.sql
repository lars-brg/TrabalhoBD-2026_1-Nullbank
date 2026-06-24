-- Consultas:

/*
    Professor,
    usamos <:nome_atributo> como uma forma
    de facilitar o preenchimento de valores nas nossas
    queries. No seu caso, quando for executar nossos
    scripts, substitua :nome_atributo  
    pelo valor do aributo requerido na questão em si.
*/

-- 1. Dado o nome / número de uma agência, deseja-se saber:

-- ==========================================
-- 1.1 Quais os funcionários, seus cargos e seus endereços, cidades, seus salários e o número de dependentes de cada um, 
-- podendo ser classificados por ordem alfabética de nomes ou de salários;
-- ==========================================

SELECT
    f.nome_completo,
    f.cargo,
    CONCAT(e.tipo_logradouro, ' ', e.nome_logradouro, ', ', e.numero, ' - ', e.bairro) AS endereco,
    e.cidade,
    f.salario,
    COUNT(d.nome_completo) AS dependentes
FROM funcionario f
JOIN agencia a ON a.num_ag = f.num_ag
LEFT JOIN endereco e ON e.id_endereco = f.id_endereco
LEFT JOIN dependente d ON d.matricula_func = f.matricula
WHERE 
    (:num_busca IS NULL OR :num_busca = '' OR f.num_ag = :num_busca)
    AND 
    (:nome_busca IS NULL OR :nome_busca = '' OR a.nome_ag = :nome_busca)
GROUP BY 
    f.matricula, 
    f.nome_completo, 
    f.cargo, 
    endereco, 
    e.cidade, 
    f.salario
ORDER BY 
    f.nome_completo ASC;

-- ==========================================
-- 1.2 Quais os clientes daquela agência, classificando-os por tipo de conta;
-- ==========================================

SELECT DISTINCT
    cli.nome_completo,
    cli.cpf,
    c.num_conta,
    c.tipo_conta
FROM cliente cli
JOIN titularidade t
    ON cli.cpf = t.cpf_cliente 
JOIN conta c
    ON c.num_conta = t.num_conta
JOIN agencia a 
    ON a.num_ag = c.num_ag
WHERE 
    (:num_busca IS NULL OR :num_busca = '' OR c.num_ag = :num_busca)
    AND 
    (:nome_busca IS NULL OR :nome_busca = '' OR a.nome_ag = :nome_busca)
ORDER BY 
    c.tipo_conta ASC, 
    cli.nome_completo ASC;

-- ==========================================
-- 1.3 Quais são as contas especiais com maior saldo devedor (mostrar todas as contas, 
-- ordenando do maior saldo devedor para o menor);
-- ==========================================

SELECT 
    c.num_conta,
    cli.nome_completo AS titular,
    c.saldo 
FROM conta c
JOIN agencia a 
    ON c.num_ag = a.num_ag
JOIN titularidade t 
    ON c.num_conta = t.num_conta
JOIN cliente cli 
    ON t.cpf_cliente = cli.cpf
WHERE 
    c.tipo_conta = 'conta_especial' 
    AND c.saldo < 0
    AND (:num_busca IS NULL OR :num_busca = '' OR c.num_ag = :num_busca)
    AND (:nome_busca IS NULL OR :nome_busca = '' OR a.nome_ag = :nome_busca)
ORDER BY 
    c.saldo ASC;

-- ==========================================
-- 1.4 Quais são as contas poupança com maior saldo positivo, classificando-as;
-- ==========================================

SELECT DISTINCT
    c.num_conta,
    cli.nome_completo AS titular,
    c.saldo
FROM conta c
JOIN agencia a 
    ON c.num_ag = a.num_ag
JOIN titularidade t 
    ON c.num_conta = t.num_conta
JOIN cliente cli 
    ON t.cpf_cliente = cli.cpf
WHERE 
    c.tipo_conta = 'poupança'
    AND c.saldo > 0        
    AND (:num_busca IS NULL OR :num_busca = '' OR c.num_ag = :num_busca)
    AND (:nome_busca IS NULL OR :nome_busca = '' OR a.nome_ag = :nome_busca)
ORDER BY 
    c.saldo DESC;

-- ==========================================
-- 1.5 Quais as contas correntes com maior número de transações na última semana (últimos 7 dias), 
-- no último mês (últimos 30 dias) e no último ano (últimos 365 dias);
-- ==========================================

SELECT 
    c.num_conta,
    cli.nome_completo AS titular_principal,
    COUNT(CASE WHEN t.data_hora >= NOW() - INTERVAL 7 DAY THEN 1 END) AS transacoes_7_dias,
    COUNT(CASE WHEN t.data_hora >= NOW() - INTERVAL 30 DAY THEN 1 END) AS transacoes_30_dias,
    COUNT(CASE WHEN t.data_hora >= NOW() - INTERVAL 365 DAY THEN 1 END) AS transacoes_365_dias
FROM conta c
JOIN transacao t 
    ON t.num_conta = c.num_conta
JOIN titularidade tit 
    ON c.num_conta = tit.num_conta
JOIN cliente cli 
    ON tit.cpf_cliente = cli.cpf
JOIN agencia a 
    ON c.num_ag = a.num_ag
WHERE 
    c.tipo_conta = 'conta_corrente' 
    AND tit.tipo_titular = 'titular_1'
    AND (:num_busca IS NULL OR :num_busca = '' OR c.num_ag = :num_busca)
    AND (:nome_busca IS NULL OR :nome_busca = '' OR a.nome_ag = :nome_busca)
GROUP BY 
    c.num_conta, 
    cli.nome_completo
ORDER BY 
    transacoes_7_dias DESC;


-- ==========================================
-- 1.6. Quais as contas com maior volume (valor total) de movimentações na última semana (últimos 7 
-- dias), no último mês (últimos 30 dias) e no último ano (últimos 365 dias);o
-- ==========================================

SELECT 
    c.num_conta,
    cli.nome_completo AS titular_principal,
    SUM(CASE WHEN t.data_hora >= NOW() - INTERVAL 7 DAY THEN t.valor ELSE 0 END) AS volume_7_dias,
    SUM(CASE WHEN t.data_hora >= NOW() - INTERVAL 30 DAY THEN t.valor ELSE 0 END) AS volume_30_dias,
    SUM(CASE WHEN t.data_hora >= NOW() - INTERVAL 365 DAY THEN t.valor ELSE 0 END) AS volume_365_dias
FROM conta c
JOIN transacao t 
    ON t.num_conta = c.num_conta
JOIN titularidade tit 
    ON c.num_conta = tit.num_conta
JOIN cliente cli 
    ON tit.cpf_cliente = cli.cpf
JOIN agencia a 
    ON c.num_ag = a.num_ag
WHERE 
    tit.tipo_titular = 'titular_1'
    AND (:num_busca IS NULL OR :num_busca = '' OR c.num_ag = :num_busca)
    AND (:nome_busca IS NULL OR :nome_busca = '' OR a.nome_ag = :nome_busca)
GROUP BY 
    c.num_conta, 
    cli.nome_completo
ORDER BY 
    volume_7_dias DESC;

-- ==========================================
-- 2. Dado um cliente (seu CPF), deseja-se saber:
-- 2.1 Quais as contas do mesmo, com seus tipos, suas agências, seus gerentes e seus saldos atuais;
-- ==========================================

SELECT
	c.num_conta,
	c.tipo_conta,
	c.saldo,

    a.num_ag,
	a.nome_ag,

	f.nome_completo AS gerente
FROM titularidade t
JOIN conta c ON c.num_conta = t.num_conta
JOIN agencia a ON  a.num_ag = c.num_ag
JOIN funcionario f
ON f.matricula = c.matricula_gerente
WHERE t.cpf_cliente = :cpf_busca;

-- ==========================================
-- 2.2 Quais os nomes dos clientes e seus CPFs com os quais aquele cliente possui contas conjuntas; 
-- ==========================================

SELECT DISTINCT 
	c2.nome_completo,
	c2.cpf
FROM titularidade t1
JOIN titularidade t2
ON t1.num_conta = t2.num_conta 
JOIN cliente c2 
ON c2.cpf = t2.cpf_cliente
WHERE t1.cpf_cliente = :cpf_busca
AND t2.cpf_cliente <> :cpf_busca;

-- ==========================================
-- 2.3. Contas correntes de um cliente (por CPF) com maior número de transações
-- Períodos: 7, 30 e 365 dias
-- ==========================================

SELECT 
    c.num_conta,
    COUNT(CASE WHEN t.data_hora >= NOW() - INTERVAL 7 DAY THEN 1 END) AS transacoes_7_dias,
    COUNT(CASE WHEN t.data_hora >= NOW() - INTERVAL 30 DAY THEN 1 END) AS transacoes_30_dias,
    COUNT(CASE WHEN t.data_hora >= NOW() - INTERVAL 365 DAY THEN 1 END) AS transacoes_365_dias
FROM titularidade tit
JOIN conta c 
    ON tit.num_conta = c.num_conta
LEFT JOIN transacao t 
    ON c.num_conta = t.num_conta
WHERE 
    tit.cpf_cliente = :cpf_busca
    AND c.tipo_conta = 'conta_corrente'
GROUP BY 
    c.num_conta
ORDER BY 
    transacoes_7_dias DESC;


-- ==========================================
-- 2.4. Volume total de movimentações por conta de um cliente (por CPF)
-- Períodos: 7, 30 e 365 dias (Todas as contas do cliente)
-- ==========================================

SELECT 
    c.num_conta,
    c.tipo_conta,
    SUM(CASE WHEN t.data_hora >= NOW() - INTERVAL 7 DAY THEN t.valor ELSE 0 END) AS volume_7_dias,
    SUM(CASE WHEN t.data_hora >= NOW() - INTERVAL 30 DAY THEN t.valor ELSE 0 END) AS volume_30_dias,
    SUM(CASE WHEN t.data_hora >= NOW() - INTERVAL 365 DAY THEN t.valor ELSE 0 END) AS volume_365_dias
FROM titularidade tit
JOIN conta c 
    ON tit.num_conta = c.num_conta
LEFT JOIN transacao t 
    ON c.num_conta = t.num_conta
WHERE 
    tit.cpf_cliente = :cpf_busca
GROUP BY 
    c.num_conta, 
    c.tipo_conta
ORDER BY 
    volume_7_dias DESC;

/*  
============================================
    3. Dada uma cidade, deseja-se saber:
============================================
*/ 

/*  
============================================
-- 3.1. Quais os nomes e endereços dos clientes que moram naquela cidade, ordenando-os por idade;
============================================
*/ 

SELECT
    c.nome_completo, 
    CONCAT(e.tipo_logradouro, ' ', e.nome_logradouro, ', ', e.numero, ' - ', e.bairro, ', ', e.cidade, ' ', e.estado) AS endereco_completo,
    TIMESTAMPDIFF(YEAR, c.data_nascimento, CURDATE()) AS idade
FROM cliente AS c
INNER JOIN endereco AS e ON e.id_endereco=c.id_endereco
WHERE cidade = :cidade_busca
ORDER BY idade DESC;

/*  
============================================
    3.2. Quais os nomes, endereços, cargos, salários e agências dos funcionários que trabalham naquela 
    cidade, agrupando-os por agência, por cargo e por salário;
============================================
*/ 

SELECT 
    f.nome_completo, 
    CONCAT(ed.tipo_logradouro, ' ', ed.nome_logradouro, ', ', ed.numero, ' - ', ed.bairro) AS endereco_residencial,
    f.cargo, 
    f.salario, 
    a.nome_ag AS agencia
FROM funcionario f
JOIN agencia a ON f.num_ag = a.num_ag
JOIN endereco ed ON f.id_endereco = ed.id_endereco
WHERE a.cidade = :cidade_busca
ORDER BY a.nome_ag, f.cargo, f.salario;


/*  
============================================
    3.3. Quais os nomes das agências e o salário montante total dos funcionários que trabalham 
    naquelas agências, ordenando-os por salário montante total
============================================
*/ 

SELECT 
    nome_ag, 
    sal_total AS montante_salarial_total
FROM agencia
WHERE cidade = :cidade_busca
ORDER BY sal_total DESC;


-- Views

/* 
==========================================
    View para listar os dados das contas de um gerente, com seus tipos, saldos e clientes 

    Questão número (4)
==========================================
*/ 

CREATE VIEW vw_contas_gerente AS
SELECT
    f.matricula,
    f.nome_completo AS gerente,

    c.num_conta,
    c.tipo_conta,
    c.saldo,

    cli.cpf,
    cli.nome_completo AS cliente
FROM conta c
JOIN funcionario f
ON f.matricula = c.matricula_gerente

JOIN titularidade t
ON t.num_conta = c.num_conta

JOIN cliente cli
ON cli.cpf = t.cpf_cliente;

/* 
==========================================
    View para listar, para cada conta, todos os dados das movimentações das mesmas (estilo extrato, podem ser na última semana (últimos 7 dias),  
    no último mês (últimos 30 dias) e no último ano (últimos 365 dias);

    Questão número (5)
==========================================
*/

CREATE VIEW vw_extrato_conta AS
SELECT
    c.num_conta,
    c.tipo_conta,
    
    tr.num_transacao,
    tr.tipo_transacao,
    tr.valor,
    tr.data_hora
FROM conta c
JOIN transacao tr
ON tr.num_conta = c.num_conta;

/* 
==========================================
    View de saldo consolidado por cliente
==========================================
*/

CREATE VIEW vw_saldo_cliente AS
SELECT
    cli.cpf,
    cli.nome_completo,
    SUM(c.saldo) AS saldo_total
FROM cliente cli
JOIN titularidade t
ON t.cpf_cliente = cli.cpf
JOIN conta c
ON c.num_conta = t.num_conta
GROUP BY cli.cpf;


-- Triggers 

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

CREATE TRIGGER funcionario_demissao                     -- GATILHO DE DEMISSÃO (DELETE)
AFTER DELETE ON funcionario
FOR EACH ROW
BEGIN
    UPDATE agencia
    SET sal_total = sal_total - OLD.salario
    WHERE num_ag = OLD.num_ag;
END $$
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
