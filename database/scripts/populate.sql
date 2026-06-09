USE equipe540863;

SET NAMES utf8mb4;

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE transacao;
TRUNCATE TABLE titularidade;
TRUNCATE TABLE conta_poupanca;
TRUNCATE TABLE conta_especial;
TRUNCATE TABLE conta_corrente;
TRUNCATE TABLE conta;
TRUNCATE TABLE email;
TRUNCATE TABLE telefone;
TRUNCATE TABLE dependente;
TRUNCATE TABLE cliente;
TRUNCATE TABLE funcionario;
TRUNCATE TABLE agencia;
TRUNCATE TABLE endereco;

SET FOREIGN_KEY_CHECKS = 1;

/* 
=========================================================
	ENDERECOS
=========================================================
*/

INSERT INTO endereco
(tipo_logradouro, nome_logradouro, numero, complemento, bairro, cidade, estado, cep)
VALUES
('Rua', 'das Acacias', '120', 'Apto 101', 'Centro', 'Sobral', 'CE', '62010010'),
('Avenida', 'Dom Jose', '450', NULL, 'Centro', 'Sobral', 'CE', '62011020'),
('Rua', 'Coronel Jose Inacio', '89', 'Casa', 'Centro', 'Sobral', 'CE', '62011100'),
('Travessa', 'do Carmo', '55', NULL, 'Campo dos Velhos', 'Sobral', 'CE', '62030000'),
('Rua', 'Padre Palhano', '700', 'Bloco B', 'Junco', 'Sobral', 'CE', '62030550'),
('Avenida', 'Lidia Pessoa', '980', NULL, 'Junco', 'Sobral', 'CE', '62031000'),
('Rua', 'Monsenhor Aloisio Pinto', '210', 'Casa 2', 'Expectativa', 'Sobral', 'CE', '62040120'),
('Alameda', 'das Flores', '15', NULL, 'Derby', 'Sobral', 'CE', '62050010'),
('Rua', 'Joaquim Ribeiro', '333', 'Fundos', 'Centro', 'Fortaleza', 'CE', '60010000'),
('Avenida', 'Beira Mar', '1500', 'Apto 1502', 'Meireles', 'Fortaleza', 'CE', '60165000'),
('Rua', 'Tiburcio Cavalcante', '777', NULL, 'Aldeota', 'Fortaleza', 'CE', '60125000'),
('Rua', 'Professor Costa Mendes', '1020', NULL, 'Benfica', 'Fortaleza', 'CE', '60020220'),
('Avenida', 'Washington Soares', '2500', 'Sala 12', 'Edson Queiroz', 'Fortaleza', 'CE', '60811000'),
('Rua', 'Sao Paulo', '50', NULL, 'Centro', 'Recife', 'PE', '50010020'),
('Avenida', 'Boa Viagem', '2200', 'Apto 904', 'Boa Viagem', 'Recife', 'PE', '51020000'),
('Rua', 'do Sol', '415', NULL, 'Santo Amaro', 'Recife', 'PE', '50100010'),
('Rua', 'Chile', '100', 'Loja 3', 'Comercio', 'Salvador', 'BA', '40010000'),
('Avenida', 'Sete de Setembro', '890', 'Apto 501', 'Vitoria', 'Salvador', 'BA', '40080100'),
('Rua', 'das Laranjeiras', '37', NULL, 'Pelourinho', 'Salvador', 'BA', '40026230'),
('Rua', 'Augusta', '150', 'Apto 82', 'Consolacao', 'Sao Paulo', 'SP', '01305000'),
('Avenida', 'Paulista', '2000', 'Conj. 1401', 'Bela Vista', 'Sao Paulo', 'SP', '01310000'),
('Rua', 'Vergueiro', '600', NULL, 'Liberdade', 'Sao Paulo', 'SP', '01504000'),
('Rua', 'da Carioca', '88', 'Sala 301', 'Centro', 'Rio de Janeiro', 'RJ', '20050008'),
('Avenida', 'Atlantica', '1702', 'Apto 704', 'Copacabana', 'Rio de Janeiro', 'RJ', '22021001'),
('Rua', 'Humaita', '440', NULL, 'Humaita', 'Rio de Janeiro', 'RJ', '22261001'),
('Rua', 'Afonso Pena', '320', NULL, 'Centro', 'Belo Horizonte', 'MG', '30130003'),
('Avenida', 'Cristovao Colombo', '1550', 'Apto 901', 'Funcionarios', 'Belo Horizonte', 'MG', '30140002'),
('Rua', 'da Bahia', '1200', 'Sala 804', 'Lourdes', 'Belo Horizonte', 'MG', '30160011'),
('Rua', 'XV de Novembro', '75', NULL, 'Centro', 'Curitiba', 'PR', '80020000'),
('Avenida', 'Sete de Setembro', '3100', 'Apto 1104', 'Agua Verde', 'Curitiba', 'PR', '80250000'),
('Rua', 'das Palmeiras', '190', NULL, 'Batel', 'Curitiba', 'PR', '80420020'),
('Rua', 'dos Andradas', '440', NULL, 'Centro Historico', 'Porto Alegre', 'RS', '90020004'),
('Avenida', 'Ipiranga', '5200', 'Bloco C', 'Partenon', 'Porto Alegre', 'RS', '90610000'),
('Rua', 'Silva Jardim', '980', NULL, 'Auxiliadora', 'Porto Alegre', 'RS', '90450071'),
('Rua', 'das Mangueiras', '12', NULL, 'Centro', 'Juazeiro do Norte', 'CE', '63010010'),
('Avenida', 'Padre Cicero', '1400', 'Loja 2', 'Triangulo', 'Juazeiro do Norte', 'CE', '63041145'),
('Rua', 'Santa Luzia', '245', NULL, 'Piraja', 'Juazeiro do Norte', 'CE', '63050550'),
('Rua', 'General Sampaio', '66', NULL, 'Centro', 'Caucaia', 'CE', '61600010'),
('Avenida', 'Contorno Norte', '500', 'Casa 1', 'Tabapua', 'Caucaia', 'CE', '61635000'),
('Rua', 'Nova Esperanca', '900', NULL, 'Jurema', 'Caucaia', 'CE', '61652000');

/* 
=========================================================
	AGENCIAS
========================================================= 
*/
INSERT INTO agencia (nome_ag, sal_total, cidade)
VALUES
('Agencia Centro Sobral', 0.00, 'Sobral'),
('Agencia Aldeota Fortaleza', 0.00, 'Fortaleza'),
('Agencia Boa Viagem Recife', 0.00, 'Recife'),
('Agencia Paulista Sao Paulo', 0.00, 'Sao Paulo'),
('Agencia Centro Curitiba', 0.00, 'Curitiba'),
('Agencia Centro Juazeiro', 0.00, 'Juazeiro do Norte');

/* 
=========================================================
   FUNCIONARIOS
 =========================================================
*/

INSERT INTO funcionario
(num_ag, id_endereco, nome_completo, senha_hash, cargo, genero, data_nascimento, salario)
VALUES
(1, 1, 'Ana Paula Mendes', '$2y$10$func0001hashseguro', 'gerente', 'feminino', '1985-03-14', 8900.00),
(1, 2, 'Bruno Cesar Lima', '$2y$10$func0002hashseguro', 'atendente', 'masculino', '1992-07-21', 3200.00),
(1, 3, 'Carla Beatriz Nogueira', '$2y$10$func0003hashseguro', 'caixa', 'feminino', '1990-11-03', 3450.00),
(1, 4, 'Diego Fernandes Rocha', '$2y$10$func0004hashseguro', 'atendente', 'masculino', '1988-09-12', 3600.00),
(1, 5, 'Evelyn Sousa Matos', '$2y$10$func0005hashseguro', 'caixa', 'nao_binario', '1996-01-28', 3380.00),

(2, 9, 'Felipe Augusto Moraes', '$2y$10$func0006hashseguro', 'gerente', 'masculino', '1983-05-19', 9700.00),
(2, 10, 'Gabriela Teles Barros', '$2y$10$func0007hashseguro', 'atendente', 'feminino', '1994-04-17', 3100.00),
(2, 11, 'Henrique Vidal Castro', '$2y$10$func0008hashseguro', 'caixa', 'masculino', '1989-12-01', 3550.00),
(2, 12, 'Isadora Queiroz Freire', '$2y$10$func0009hashseguro', 'atendente', 'feminino', '1997-08-08', 2950.00),
(2, 13, 'Joao Victor Paiva', '$2y$10$func0010hashseguro', 'caixa', 'masculino', '1991-10-10', 3700.00),

(3, 14, 'Katia Regina Sales', '$2y$10$func0011hashseguro', 'gerente', 'feminino', '1981-02-27', 9400.00),
(3, 15, 'Lucas Prado Neves', '$2y$10$func0012hashseguro', 'atendente', 'masculino', '1993-06-30', 3050.00),
(3, 16, 'Marina Albuquerque Luz', '$2y$10$func0013hashseguro', 'caixa', 'feminino', '1990-03-09', 3650.00),

(4, 20, 'Natasha Ribeiro Cunha', '$2y$10$func0014hashseguro', 'gerente', 'feminino', '1986-07-05', 11200.00),
(4, 21, 'Otavio Martins Leal', '$2y$10$func0015hashseguro', 'caixa', 'masculino', '1987-01-23', 4100.00),
(4, 22, 'Paulo Sergio Dias', '$2y$10$func0016hashseguro', 'atendente', 'masculino', '1995-09-14', 3300.00),

(5, 29, 'Quenia Furtado Alves', '$2y$10$func0017hashseguro', 'gerente', 'feminino', '1984-12-18', 9100.00),
(5, 30, 'Rafael Moreira Pinto', '$2y$10$func0018hashseguro', 'atendente', 'masculino', '1996-02-11', 2890.00),
(5, 31, 'Sara Cristina Gomes', '$2y$10$func0019hashseguro', 'caixa', 'feminino', '1992-05-25', 3500.00),

(6, 35, 'Tiago Henrique Sampaio', '$2y$10$func0020hashseguro', 'gerente', 'masculino', '1982-11-29', 8800.00),
(6, 36, 'Ursula Nascimento Brito', '$2y$10$func0021hashseguro', 'atendente', 'feminino', '1998-04-04', 2860.00),
(6, 37, 'Vinicius Arraes Feitosa', '$2y$10$func0022hashseguro', 'caixa', 'masculino', '1991-06-16', 3420.00),
(6, 38, 'Wesley Pontes Silva', '$2y$10$func0023hashseguro', 'atendente', 'masculino', '1990-08-20', 3000.00),
(6, 39, 'Yasmin Duarte Melo', '$2y$10$func0024hashseguro', 'caixa', 'feminino', '1997-03-13', 3340.00);


UPDATE agencia a
SET sal_total = (
    SELECT COALESCE(SUM(f.salario), 0)
    FROM funcionario f
    WHERE f.num_ag = a.num_ag
);

/*
=========================================================
	DEPENDENTES
=========================================================
*/
INSERT INTO dependente
(matricula_func, nome_completo, parentesco, data_nascimento)
VALUES
(1, 'Clara Mendes', 'filho_a', '2012-05-10'),
(1, 'Roberto Mendes', 'conjuge', '1984-01-15'),

(2, 'Helena Lima', 'filho_a', '2018-10-01'),

(3, 'Paulo Nogueira', 'genitor_a', '1960-09-22'),
(3, 'Rita Nogueira', 'genitor_a', '1962-07-07'),

(4, 'Daniel Rocha', 'conjuge', '1989-02-02'),
(4, 'Livia Rocha', 'filho_a', '2016-12-12'),
(4, 'Mateus Rocha', 'filho_a', '2019-03-20'),

(6, 'Bianca Moraes', 'conjuge', '1985-06-06'),
(6, 'Thiago Moraes', 'filho_a', '2014-04-14'),
(6, 'Luiza Moraes', 'filho_a', '2017-09-09'),

(7, 'Carlos Barros', 'genitor_a', '1959-11-30'),

(8, 'Valeria Castro', 'conjuge', '1990-08-18'),

(11, 'Sofia Sales', 'filho_a', '2011-01-25'),
(11, 'Samuel Sales', 'filho_a', '2015-06-17'),
(11, 'Renato Sales', 'conjuge', '1980-10-05'),

(14, 'Marta Cunha', 'conjuge', '1988-03-27'),

(17, 'Bruna Alves', 'filho_a', '2010-02-13'),
(17, 'Beatriz Alves', 'filho_a', '2013-12-24'),
(17, 'Breno Alves', 'filho_a', '2016-08-31'),
(17, 'Felix Alves', 'genitor_a', '1958-05-12'),

(20, 'Alice Sampaio', 'conjuge', '1983-07-19'),
(20, 'Joana Sampaio', 'filho_a', '2012-11-23'),

(21, 'Lourdes Brito', 'genitor_a', '1964-04-01'),

(24, 'Mirela Melo', 'conjuge', '1998-09-09');

/*
=========================================================
	CLIENTES
========================================================= 
*/
INSERT INTO cliente
(cpf, id_endereco, nome_completo, rg, orgao_emissor, uf_rg, data_nascimento)
VALUES
('11111111101', 6,  'Adriana Martins Lopes', '200112345', 'SSP', 'CE', '1991-04-15'),
('11111111102', 7,  'Bernardo Farias Souza', '200212346', 'SSP', 'CE', '1987-09-20'),
('11111111103', 8,  'Camila Duarte Nunes', '200312347', 'SSP', 'CE', '1995-01-07'),
('11111111104', 17, 'Daniela Cruz Araujo', 'MG1234567', 'SSP', 'BA', '1990-10-30'),
('11111111105', 18, 'Eduardo Pacheco Lima', 'BA998877', 'SSP', 'BA', '1984-12-01'),
('11111111106', 19, 'Fernanda Melo Reis', 'BA776655', 'SSP', 'BA', '1998-06-22'),
('11111111107', 23, 'Gustavo Teixeira Campos', 'RJ445566', 'DETRAN', 'RJ', '1979-02-14'),
('11111111108', 24, 'Helena Cardoso Pinto', 'RJ112233', 'IFP', 'RJ', '1988-11-11'),
('11111111109', 25, 'Igor Salles Moura', 'RJ778899', 'SSP', 'RJ', '1993-08-19'),
('11111111110', 26, 'Julia Vasconcelos Braga', 'MG223344', 'SSP', 'MG', '1996-03-03'),
('11111111111', 27, 'Kleber Antonio Rezende', 'MG556677', 'SSP', 'MG', '1982-07-25'),
('11111111112', 28, 'Larissa Porto Vidal', 'MG889900', 'PC', 'MG', '1999-05-17'),
('11111111113', 32, 'Marcelo Araujo Tavares', 'RS101010', 'SSP', 'RS', '1985-01-29'),
('11111111114', 33, 'Nathalia Freitas Rosa', 'RS202020', 'SSP', 'RS', '1992-02-08'),
('11111111115', 34, 'Osvaldo Cezar Menezes', 'RS303030', 'SSP', 'RS', '1975-09-09'),
('11111111116', 35, 'Priscila Barros Monte', 'CE454545', 'SSP', 'CE', '1994-04-04'),
('11111111117', 36, 'Ramon de Oliveira Costa', 'CE565656', 'SSP', 'CE', '1986-06-06'),
('11111111118', 37, 'Simone Ribeiro Paes', 'CE676767', 'SSP', 'CE', '1991-12-12'),
('11111111119', 38, 'Tadeu Nobre Ferreira', 'CE787878', 'SSP', 'CE', '1980-08-08'),
('11111111120', 39, 'Viviane Moraes Aguiar', 'CE898989', 'SSP', 'CE', '1997-07-07'),
('11111111121', 40, 'William Gadelha Soares', 'CE909090', 'SSP', 'CE', '1989-05-05'),
('11111111122', 20, 'Aline Rocha Pimentel', 'SP121212', 'SSP', 'SP', '1993-09-13'),
('11111111123', 21, 'Brenda Miki Tanaka', 'SP232323', 'SSP', 'SP', '1990-01-21'),
('11111111124', 22, 'Caio Henrique Lobo', 'SP343434', 'SSP', 'SP', '1981-10-10'),
('11111111125', 29, 'Debora Vieira Chagas', 'PR454545', 'SSP', 'PR', '1995-02-02'),
('11111111126', 30, 'Enzo Miguel Ferraz', 'PR565656', 'SSP', 'PR', '2000-03-14'),
('11111111127', 31, 'Flavia Regina Pires', 'PR676767', 'SSP', 'PR', '1988-04-18'),
('11111111128', 9,  'Gilberto Nunes Porto', 'CE787800', 'SSP', 'CE', '1978-11-30'),
('11111111129', 10, 'Heloisa Sampaio Cunha', 'CE797900', 'SSP', 'CE', '1996-12-19'),
('11111111130', 11, 'Ivan Douglas Barreto', 'CE808000', 'SSP', 'CE', '1983-07-01');

/*
=========================================================
	TELEFONES
========================================================= 
*/
INSERT INTO telefone (cpf_cliente, numero, descricao) VALUES
('11111111101', '88999990001', 'celular1'),
('11111111101', '8836110001', 'residencial'),
('11111111102', '85999880002', 'celular1'),
('11111111103', '88999990003', 'celular1'),
('11111111103', '88999990033', 'celular2'),
('11111111104', '71988880004', 'celular1'),
('11111111105', '7133330005', 'comercial'),
('11111111106', '71977770006', 'celular1'),
('11111111107', '21999990007', 'celular1'),
('11111111108', '2133220008', 'residencial'),
('11111111109', '21988880009', 'celular1'),
('11111111110', '31999990010', 'celular1'),
('11111111110', '3133330010', 'comercial'),
('11111111111', '31977770011', 'celular1'),
('11111111112', '31966660012', 'celular1'),
('11111111113', '51999990013', 'celular1'),
('11111111114', '51988880014', 'celular1'),
('11111111115', '5133330015', 'residencial'),
('11111111116', '88999990016', 'celular1'),
('11111111116', '8833330016', 'comercial'),
('11111111117', '88999990017', 'celular1'),
('11111111118', '88999990018', 'celular1'),
('11111111119', '85999990019', 'celular1'),
('11111111120', '85988880020', 'celular1'),
('11111111121', '85977770021', 'celular1'),
('11111111122', '11999990022', 'celular1'),
('11111111123', '11988880023', 'celular1'),
('11111111124', '1133330024', 'comercial'),
('11111111125', '41999990025', 'celular1'),
('11111111126', '41988880026', 'celular1'),
('11111111127', '41977770027', 'celular1'),
('11111111128', '85966660028', 'celular1'),
('11111111129', '85955550029', 'celular1'),
('11111111130', '85944440030', 'celular1'),
('11111111130', '8533330030', 'residencial');

/* 
=========================================================
	EMAILS
========================================================= 
*/
INSERT INTO email (cpf_cliente, endereco_email, descricao) VALUES
('11111111101', 'adriana.lopes@gmail.com', 'particular'),
('11111111101', 'adriana.martins@empresa.com', 'comercial'),
('11111111102', 'bernardo.fsouza@yahoo.com', 'particular'),
('11111111103', 'camila.nunes@outlook.com', 'particular'),
('11111111104', 'daniela.araujo@gmail.com', 'particular'),
('11111111105', 'eduardo.lima@corpbank.com', 'comercial'),
('11111111106', 'fernanda.reis@gmail.com', 'particular'),
('11111111107', 'gustavo.campos@uol.com.br', 'particular'),
('11111111108', 'helena.pinto@gmail.com', 'particular'),
('11111111109', 'igor.moura@hotmail.com', 'particular'),
('11111111110', 'julia.braga@gmail.com', 'particular'),
('11111111111', 'kleber.rezende@consultor.com', 'comercial'),
('11111111112', 'larissa.vidal@yahoo.com', 'particular'),
('11111111113', 'marcelo.tavares@gmail.com', 'particular'),
('11111111114', 'nathalia.rosa@empresa.com.br', 'comercial'),
('11111111115', 'osvaldo.menezes@gmail.com', 'particular'),
('11111111116', 'priscila.monte@gmail.com', 'particular'),
('11111111117', 'ramon.costa@outlook.com', 'particular'),
('11111111118', 'simone.paes@gmail.com', 'particular'),
('11111111119', 'tadeu.ferreira@provedor.com', 'particular'),
('11111111120', 'viviane.aguiar@gmail.com', 'particular'),
('11111111121', 'william.soares@gmail.com', 'particular'),
('11111111122', 'aline.pimentel@startup.io', 'comercial'),
('11111111123', 'brenda.tanaka@gmail.com', 'particular'),
('11111111124', 'caio.lobo@empresa.com', 'comercial'),
('11111111125', 'debora.chagas@gmail.com', 'particular'),
('11111111126', 'enzo.ferraz@outlook.com', 'particular'),
('11111111127', 'flavia.pires@gmail.com', 'particular'),
('11111111128', 'gilberto.porto@provedor.com', 'particular'),
('11111111129', 'heloisa.cunha@gmail.com', 'particular'),
('11111111130', 'ivan.barreto@empresa.com.br', 'comercial');

/*
=========================================================
	CONTAS
========================================================= 
*/
INSERT INTO conta
(num_ag, matricula_gerente, saldo, senha_hash, tipo_conta)
VALUES
(1, 1, 0.00, '$2y$10$conta0001hashseguro', 'conta_corrente'),
(1, 1, 0.00, '$2y$10$conta0002hashseguro', 'poupanca'),
(1, 1, 0.00, '$2y$10$conta0003hashseguro', 'conta_especial'),
(1, 1, 0.00, '$2y$10$conta0004hashseguro', 'conta_corrente'),
(1, 1, 0.00, '$2y$10$conta0005hashseguro', 'poupanca'),

(2, 6, 0.00, '$2y$10$conta0006hashseguro', 'conta_corrente'),
(2, 6, 0.00, '$2y$10$conta0007hashseguro', 'conta_especial'),
(2, 6, 0.00, '$2y$10$conta0008hashseguro', 'poupanca'),
(2, 6, 0.00, '$2y$10$conta0009hashseguro', 'conta_corrente'),
(2, 6, 0.00, '$2y$10$conta0010hashseguro', 'conta_especial'),

(3, 11, 0.00, '$2y$10$conta0011hashseguro', 'conta_corrente'),
(3, 11, 0.00, '$2y$10$conta0012hashseguro', 'poupanca'),
(3, 11, 0.00, '$2y$10$conta0013hashseguro', 'conta_especial'),

(4, 14, 0.00, '$2y$10$conta0014hashseguro', 'conta_corrente'),
(4, 14, 0.00, '$2y$10$conta0015hashseguro', 'poupanca'),
(4, 14, 0.00, '$2y$10$conta0016hashseguro', 'conta_especial'),
(4, 14, 0.00, '$2y$10$conta0017hashseguro', 'conta_corrente'),

(5, 17, 0.00, '$2y$10$conta0018hashseguro', 'conta_corrente'),
(5, 17, 0.00, '$2y$10$conta0019hashseguro', 'poupanca'),
(5, 17, 0.00, '$2y$10$conta0020hashseguro', 'conta_especial'),

(6, 20, 0.00, '$2y$10$conta0021hashseguro', 'conta_corrente'),
(6, 20, 0.00, '$2y$10$conta0022hashseguro', 'poupanca'),
(6, 20, 0.00, '$2y$10$conta0023hashseguro', 'conta_especial'),
(6, 20, 0.00, '$2y$10$conta0024hashseguro', 'conta_corrente'),
(6, 20, 0.00, '$2y$10$conta0025hashseguro', 'poupanca');

/*
=========================================================
	ESPECIALIZACOES DE CONTA
========================================================= 
*/
INSERT INTO conta_corrente (num_conta, data_aniversario_contrato) VALUES
(1, '2024-01-10'),
(4, '2023-06-05'),
(6, '2022-09-14'),
(9, '2025-02-20'),
(11, '2024-03-03'),
(14, '2021-12-12'),
(17, '2025-01-25'),
(18, '2023-11-30'),
(21, '2024-07-07'),
(24, '2025-04-15');

INSERT INTO conta_poupanca (num_conta, taxa_juros) VALUES
(2, 0.45),
(5, 0.52),
(8, 0.48),
(12, 0.50),
(15, 0.57),
(19, 0.46),
(22, 0.51),
(25, 0.49);

INSERT INTO conta_especial (num_conta, limite_credito) VALUES
(3, 1500.00),
(7, 2500.00),
(10, 5000.00),
(13, 1800.00),
(16, 7000.00),
(20, 2200.00),
(23, 1200.00);

/*
=========================================================
	TITULARIDADE
========================================================= 
*/
INSERT INTO titularidade (num_conta, cpf_cliente, tipo_titular) VALUES
(1, '11111111101', 'titular_1'),
(2, '11111111101', 'titular_1'),
(3, '11111111102', 'titular_1'),
(4, '11111111103', 'titular_1'),
(5, '11111111116', 'titular_1'),

(6, '11111111128', 'titular_1'),
(7, '11111111129', 'titular_1'),
(8, '11111111130', 'titular_1'),
(9, '11111111122', 'titular_1'),
(10, '11111111123', 'titular_1'),

(11, '11111111104', 'titular_1'),
(12, '11111111105', 'titular_1'),
(13, '11111111106', 'titular_1'),

(14, '11111111124', 'titular_1'),
(15, '11111111111', 'titular_1'),
(16, '11111111112', 'titular_1'),
(17, '11111111110', 'titular_1'),

(18, '11111111125', 'titular_1'),
(19, '11111111126', 'titular_1'),
(20, '11111111127', 'titular_1'),

(21, '11111111117', 'titular_1'),
(22, '11111111118', 'titular_1'),
(23, '11111111119', 'titular_1'),
(24, '11111111120', 'titular_1'),
(25, '11111111121', 'titular_1'),

/* contas conjuntas */
(6, '11111111102', 'titular_2'),
(11, '11111111107', 'titular_2'),
(14, '11111111123', 'titular_2'),
(18, '11111111115', 'titular_2'),
(21, '11111111103', 'titular_2'),
(24, '11111111130', 'titular_2');

/*
=========================================================
	TRANSACOES
========================================================= 
*/
INSERT INTO transacao
(num_conta, num_transacao, tipo_transacao, valor, data_hora)
VALUES
-- Conta 1
(1, 1, 'deposito', 2500.00, '2025-09-10 09:15:00'),
(1, 2, 'pagamento', 320.50, '2025-10-03 14:20:00'),
(1, 3, 'pix', 450.00, '2026-05-15 08:00:00'),
(1, 4, 'saque', 200.00, '2026-06-10 11:10:00'),
(1, 5, 'deposito', 700.00, '2026-06-18 16:45:00'),

-- Conta 2
(2, 1, 'deposito', 5000.00, '2025-08-01 10:00:00'),
(2, 2, 'deposito', 800.00, '2025-12-12 12:30:00'),
(2, 3, 'pix', 350.00, '2026-06-19 09:40:00'),

-- Conta 3 especial
(3, 1, 'deposito', 1000.00, '2025-07-07 10:10:00'),
(3, 2, 'saque', 900.00, '2025-08-08 13:00:00'),
(3, 3, 'pagamento', 700.00, '2026-01-17 15:25:00'),
(3, 4, 'estorno', 150.00, '2026-01-20 10:00:00'),

-- Conta 4
(4, 1, 'deposito', 1800.00, '2026-02-11 08:15:00'),
(4, 2, 'transferencia', 250.00, '2026-03-02 18:05:00'),
(4, 3, 'pix', 120.00, '2026-06-01 07:44:00'),
(4, 4, 'pagamento', 90.00, '2026-06-17 20:10:00'),

-- Conta 5
(5, 1, 'deposito', 9000.00, '2024-12-20 09:00:00'),
(5, 2, 'deposito', 1500.00, '2025-06-21 09:00:00'),
(5, 3, 'deposito', 600.00, '2026-06-20 12:00:00'),

-- Conta 6 conjunta
(6, 1, 'deposito', 3000.00, '2025-03-10 11:00:00'),
(6, 2, 'pagamento', 450.00, '2025-04-11 11:00:00'),
(6, 3, 'saque', 600.00, '2026-05-05 15:30:00'),
(6, 4, 'pix', 700.00, '2026-06-16 09:45:00'),
(6, 5, 'deposito', 1200.00, '2026-06-20 18:20:00'),

-- Conta 7 especial
(7, 1, 'deposito', 2000.00, '2025-09-09 09:09:00'),
(7, 2, 'transferencia', 1000.00, '2025-10-10 10:10:00'),
(7, 3, 'pagamento', 2200.00, '2026-04-14 17:17:00'),
(7, 4, 'estorno', 200.00, '2026-04-15 09:00:00'),

-- Conta 8
(8, 1, 'deposito', 4300.00, '2025-11-01 10:00:00'),
(8, 2, 'pix', 250.00, '2026-06-03 13:10:00'),
(8, 3, 'deposito', 900.00, '2026-06-18 13:10:00'),

-- Conta 9
(9, 1, 'deposito', 1500.00, '2026-01-01 09:00:00'),
(9, 2, 'saque', 200.00, '2026-01-08 10:00:00'),
(9, 3, 'saque', 180.00, '2026-05-22 11:00:00'),
(9, 4, 'pix', 75.00, '2026-06-19 21:30:00'),

-- Conta 10 especial
(10, 1, 'deposito', 10000.00, '2025-05-05 08:00:00'),
(10, 2, 'pagamento', 2500.00, '2025-06-06 14:00:00'),
(10, 3, 'transferencia', 4000.00, '2026-02-02 10:10:00'),
(10, 4, 'saque', 1200.00, '2026-06-11 16:50:00'),

-- Conta 11 conjunta
(11, 1, 'deposito', 7000.00, '2025-02-14 08:00:00'),
(11, 2, 'pagamento', 800.00, '2025-03-01 09:30:00'),
(11, 3, 'deposito', 1500.00, '2025-12-25 12:10:00'),
(11, 4, 'pix', 450.00, '2026-06-15 07:00:00'),
(11, 5, 'saque', 1000.00, '2026-06-20 19:20:00'),

-- Conta 12
(12, 1, 'deposito', 2200.00, '2026-01-12 15:00:00'),
(12, 2, 'deposito', 600.00, '2026-05-10 10:00:00'),
(12, 3, 'pix', 400.00, '2026-06-19 10:00:00'),

-- Conta 13 especial
(13, 1, 'deposito', 500.00, '2025-10-01 08:00:00'),
(13, 2, 'pagamento', 1100.00, '2026-01-09 08:00:00'),
(13, 3, 'estorno', 100.00, '2026-01-10 08:00:00'),

-- Conta 14 conjunta
(14, 1, 'deposito', 12000.00, '2025-07-15 10:30:00'),
(14, 2, 'transferencia', 1500.00, '2025-09-18 15:40:00'),
(14, 3, 'pagamento', 950.00, '2026-04-01 09:05:00'),
(14, 4, 'saque', 500.00, '2026-06-18 13:20:00'),
(14, 5, 'pix', 600.00, '2026-06-20 14:10:00'),

-- Conta 15
(15, 1, 'deposito', 8000.00, '2025-08-08 08:08:00'),
(15, 2, 'deposito', 500.00, '2026-06-17 08:08:00'),

-- Conta 16 especial
(16, 1, 'deposito', 3500.00, '2025-06-06 06:06:00'),
(16, 2, 'pagamento', 6000.00, '2026-02-21 11:00:00'),
(16, 3, 'estorno', 500.00, '2026-02-22 11:00:00'),

-- Conta 17
(17, 1, 'deposito', 2600.00, '2026-03-14 09:00:00'),
(17, 2, 'pagamento', 300.00, '2026-03-18 09:00:00'),
(17, 3, 'pix', 900.00, '2026-06-19 22:00:00'),

-- Conta 18 conjunta
(18, 1, 'deposito', 4100.00, '2025-01-03 10:00:00'),
(18, 2, 'saque', 500.00, '2025-02-03 10:00:00'),
(18, 3, 'deposito', 950.00, '2026-06-12 10:00:00'),
(18, 4, 'pagamento', 250.00, '2026-06-19 10:00:00'),

-- Conta 19
(19, 1, 'deposito', 6200.00, '2025-04-04 14:00:00'),
(19, 2, 'deposito', 300.00, '2026-06-18 14:00:00'),

-- Conta 20 especial
(20, 1, 'deposito', 1800.00, '2025-05-01 12:00:00'),
(20, 2, 'pagamento', 2500.00, '2026-01-15 12:00:00'),
(20, 3, 'estorno', 120.00, '2026-01-16 12:00:00'),

-- Conta 21 conjunta
(21, 1, 'deposito', 3300.00, '2025-11-11 11:11:00'),
(21, 2, 'pix', 200.00, '2026-05-30 11:11:00'),
(21, 3, 'saque', 600.00, '2026-06-18 11:11:00'),
(21, 4, 'deposito', 500.00, '2026-06-20 11:11:00'),

-- Conta 22
(22, 1, 'deposito', 7900.00, '2025-12-12 12:12:00'),
(22, 2, 'deposito', 400.00, '2026-06-16 12:12:00'),

-- Conta 23 especial
(23, 1, 'deposito', 900.00, '2025-10-10 10:10:00'),
(23, 2, 'pagamento', 1800.00, '2026-02-02 10:10:00'),
(23, 3, 'estorno', 200.00, '2026-02-03 10:10:00'),

-- Conta 24 conjunta
(24, 1, 'deposito', 5100.00, '2025-09-01 09:00:00'),
(24, 2, 'transferencia', 1300.00, '2025-09-10 09:00:00'),
(24, 3, 'pix', 350.00, '2026-06-18 09:00:00'),
(24, 4, 'pagamento', 420.00, '2026-06-20 09:00:00'),

-- Conta 25
(25, 1, 'deposito', 2750.00, '2026-01-20 16:00:00'),
(25, 2, 'deposito', 1250.00, '2026-06-19 16:00:00');

/*
=========================================================
	ATUALIZACAO DE SALDO DAS CONTAS
========================================================= 
*/
UPDATE conta c
SET c.saldo = (
    SELECT COALESCE(SUM(
        CASE
            WHEN t.tipo_transacao IN ('deposito', 'pix', 'estorno') THEN t.valor
            WHEN t.tipo_transacao IN ('saque', 'transferencia', 'pagamento') THEN -t.valor
            ELSE 0
        END
    ), 0)
    FROM transacao t
    WHERE t.num_conta = c.num_conta
);

/* 
=========================================================
	AJUSTES DE CONSISTENCIA VISUAL
========================================================= 
*/
UPDATE agencia a
SET sal_total = (
    SELECT COALESCE(SUM(f.salario), 0)
    FROM funcionario f
    WHERE f.num_ag = a.num_ag
);

COMMIT;
