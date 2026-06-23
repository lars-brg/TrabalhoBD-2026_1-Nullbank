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

/* ==========================================
    View de saldo consolidado por cliente
*/ ==========================================

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
