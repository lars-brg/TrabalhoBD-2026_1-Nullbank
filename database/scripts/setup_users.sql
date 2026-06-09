-- Criando o usuário ADMIN
CREATE USER 'Admin'@'%' IDENTIFIED BY 'Root';

-- Concede acesso total e irrestrito a todas as tabelas do seu banco, conforme exigido
GRANT ALL PRIVILEGES ON equipe540683.* TO 'Admin'@'%';

-- Aplica as mudanças
FLUSH PRIVILEGES;

-- Criando o usuário da aplicação
CREATE USER 'nullbank_app'@'%' IDENTIFIED BY 'uma_senha_segura';

-- Permissões limitadas apenas ao necessário para o funcionamento do sistema [2, 4]
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON equipe540683.* TO 'nullbank_app'@'%';
FLUSH PRIVILEGES;