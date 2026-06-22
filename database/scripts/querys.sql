-- ==========================================
-- Dado o nome / número de uma agência, deseja-se saber:
-- Quais os funcionários, seus cargos e seus endereços, cidades, seus salários e o número de dependentes de cada um, 
-- podendo ser classificados por ordem alfabética de nomes ou de salários;
-- ==========================================

SELECT
    f.nome_completo,
    f.cargo,

    CONCAT(
        e.tipo_logradouro, ' ',
        e.nome_logradouro, ', ',
        e.numero
    ) AS endereco,

    e.cidade,
    f.salario,

    COUNT(d.nome_completo) AS dependentes
FROM funcionario f
JOIN agencia a
    ON a.num_ag = f.num_ag
LEFT JOIN endereco e
    ON e.id_endereco = f.id_endereco
LEFT JOIN dependente d
    ON d.matricula_func = f.matricula
WHERE f.num_ag = ?
GROUP BY 
    f.matricula,
    f.nome_completo,
    f.cargo,
    e.tipo_logradouro,
    e.nome_logradouro,
    e.numero,
    e.cidade,
    f.salario
ORDER BY 
    f.nome_completo;

-- ==========================================
-- Quais os clientes daquela agência, classificando-os por tipo de conta;
-- ==========================================

SELECT
    cli.nome_completo,
    cli.cpf,
    c.num_conta,
    c.tipo_conta
FROM cliente cli
JOIN titularidade t
    ON cli.cpf = t.cpf_cliente 
JOIN conta c
    ON c.num_conta = t.num_conta
WHERE c.num_ag = ?
ORDER BY c.tipo_conta, cli.nome_completo;

-- ==========================================
-- Quais são as contas especiais com maior saldo devedor (mostrar todas as contas, 
-- ordenando do maior saldo devedor para o menor);
-- ==========================================

SELECT 
    num_conta,
    saldo 
FROM conta
WHERE tipo_conta = 'conta_especial'
    AND saldo < 0
ORDER BY saldo ASC;

-- ==========================================
-- Quais são as contas poupança com maior saldo positivo, classificando-as;
-- ==========================================

SELECT 
    num_conta,
    saldo
FROM conta
WHERE tipo_conta = 'poupança'
ORDER BY saldo DESC;

-- ==========================================
-- Quais as contas correntes com maior número de transações na última semana (últimos 7 dias), 
-- no último mês (últimos 30 dias) e no último ano (últimos 365 dias);
-- ==========================================

    -- Últimos 7 dias
SELECT 
    c.num_conta,
	COUNT(*) AS qtd_transacoes
FROM conta c
JOIN transacao t
	ON t.num_conta = c.num_conta
WHERE c.tipo_conta = 'conta_corrente'
	AND t.data_hora >= NOW() - INTERVAL 7 DAY
GROUP BY c.num_conta
ORDER BY qtd_transacoes DESC;

    -- Últimos 30 dias
SELECT 
    c.num_conta,
	COUNT(*) AS qtd_transacoes
FROM conta c
JOIN transacao t
	ON t.num_conta = c.num_conta
WHERE c.tipo_conta = 'conta_corrente'
	AND t.data_hora >= NOW() - INTERVAL 30 DAY
GROUP BY c.num_conta
ORDER BY qtd_transacoes DESC;

    -- Últimos 365 dias
SELECT 
    c.num_conta,
	COUNT(*) AS qtd_transacoes
FROM conta c
JOIN transacao t
	ON t.num_conta = c.num_conta
WHERE c.tipo_conta = 'conta_corrente'
	AND t.data_hora >= NOW() - INTERVAL 365 DAY
GROUP BY c.num_conta
ORDER BY qtd_transacoes DESC;

-- ==========================================
-- Quais as contas com maior volume (valor total) de movimentações na última semana (últimos 7 dias), 
-- no último mês (últimos 30 dias) e no último ano (últimos 365 dias);
-- ==========================================

	-- Últimos 7 dias

SELECT
	c.num_conta,
	SUM(t.valor) AS volume_movimentado
FROM conta c
JOIN transacao t
	ON t.num_conta = c.num_conta
WHERE t.data_hora >= NOW() - INTERVAL 7 DAY
GROUP BY c.num_conta
ORDER BY volume_movimentado DESC;

	-- Últimos 30 dias

SELECT
	c.num_conta,
	SUM(t.valor) AS volume_movimentado
FROM conta c
JOIN transacao t
	ON t.num_conta = c.num_conta
WHERE t.data_hora >= NOW() - INTERVAL 30 DAY
GROUP BY c.num_conta
ORDER BY volume_movimentado DESC;

	-- Últimos 365 dias

SELECT
	c.num_conta,
	SUM(t.valor) AS volume_movimentado
FROM conta c
JOIN transacao t
	ON t.num_conta = c.num_conta
WHERE t.data_hora >= NOW() - INTERVAL 365 DAY
GROUP BY c.num_conta
ORDER BY volume_movimentado DESC;

-- ==========================================
-- Dado um cliente (seu CPF), deseja-se saber: 
-- Quais as contas do mesmo, com seus tipos, suas agências, seus gerentes e seus saldos atuais;
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
WHERE t.cpf_cliente = ?;

-- ==========================================
-- Quais os nomes dos clientes e seus CPFs com os quais aquele cliente possui contas conjuntas; 
-- ==========================================

SELECT DISTINCT 
	c2.nome_completo,
	c2.cpf
FROM titularidade t1
JOIN titularidade t2
ON t1.num_conta = t2.num_conta 
JOIN cliente c2 
ON c2.cpf = t2.cpf_cliente
WHERE t1.cpf_cliente = ?
AND t2.cpf_cliente <> ?; 
