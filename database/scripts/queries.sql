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