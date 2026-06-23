-- Criando o usuário ADMIN
CREATE USER 'Admin'@'%' IDENTIFIED BY 'Root';

GRANT ALL PRIVILEGES ON equipe540863.* TO 'Admin'@'%';

FLUSH PRIVILEGES;

-- Criando o usuário da aplicação
CREATE USER 'nullbank_app'@'%' IDENTIFIED BY '538427';

GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON equipe540863.* TO 'nullbank_app'@'%';
FLUSH PRIVILEGES;