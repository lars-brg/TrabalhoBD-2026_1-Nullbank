# Dependências do Backend

Este documento descreve as principais dependências utilizadas no backend do projeto e a finalidade de cada uma delas.

## Instalação

### Dependências de Produção

```bash
npm install express cors dotenv mysql2 bcrypt jsonwebtoken
```

### Dependências de Desenvolvimento

```bash
npm install -D typescript ts-node-dev

npm install -D @types/node
npm install -D @types/express
npm install -D @types/cors
npm install -D @types/bcrypt
npm install -D @types/jsonwebtoken
```

### Inicialização do TypeScript

```bash
npx tsc --init
```

Este comando gera o arquivo `tsconfig.json`, responsável pelas configurações de compilação do TypeScript.

---

## express

```bash
npm install express
```

Framework web para Node.js utilizado para criar a API da aplicação.

### Utilização

- Criação de rotas.
- Processamento de requisições HTTP.
- Implementação de controladores.
- Integração com banco de dados.

### Exemplos

- `GET /clientes`
- `POST /usuarios`
- `PUT /contas/:id`
- `DELETE /transacoes/:id`

### Vantagens

- Simples e amplamente utilizado.
- Grande comunidade.
- Fácil integração com outras bibliotecas.
- Excelente para APIs REST.

---

## cors

```bash
npm install cors
```

Middleware responsável por controlar o compartilhamento de recursos entre diferentes origens (Cross-Origin Resource Sharing).

### Utilização

- Permitir que o frontend acesse a API.
- Configurar domínios autorizados.
- Controlar políticas de segurança relacionadas a requisições HTTP.

### Exemplo

Permitir que o frontend em `localhost:5173` consuma a API executada em outra porta.

---

## dotenv

```bash
npm install dotenv
```

Biblioteca utilizada para carregar variáveis de ambiente a partir de um arquivo `.env`.

### Utilização

- Configuração do banco de dados.
- Armazenamento de segredos.
- Configuração de portas e ambientes.

### Exemplos

```env
PORT=3000
DB_HOST=localhost
DB_USER=root
JWT_SECRET=minha_chave
```

### Vantagens

- Maior segurança.
- Facilita a configuração entre ambientes.
- Evita informações sensíveis no código-fonte.

---

## mysql2

```bash
npm install mysql2
```

Driver utilizado para comunicação entre a aplicação Node.js e o banco de dados MySQL.

### Utilização

- Execução de consultas SQL.
- Inserção, atualização e remoção de dados.
- Gerenciamento de conexões com o banco.

### Vantagens

- Compatível com MySQL 5.7+.
- Suporte a Promises.
- Melhor desempenho em relação ao driver mysql original.

---

## bcrypt

```bash
npm install bcrypt
```

Biblioteca utilizada para criptografia de senhas.

### Utilização

- Hash de senhas antes do armazenamento.
- Comparação segura durante autenticação.

### Benefícios

- Proteção contra vazamento de senhas.
- Algoritmo amplamente utilizado no mercado.
- Aumenta significativamente a segurança da aplicação.

---

## jsonwebtoken

```bash
npm install jsonwebtoken
```

Biblioteca utilizada para geração e validação de tokens JWT (JSON Web Tokens).

### Utilização

- Autenticação de usuários.
- Controle de sessões.
- Proteção de rotas privadas.

### Fluxo de uso

1. Usuário realiza login.
2. O backend gera um token JWT.
3. O frontend armazena o token.
4. O token é enviado em requisições autenticadas.
5. O backend valida o token antes de liberar acesso.

### Benefícios

- Stateless Authentication.
- Amplamente utilizado em APIs REST.
- Fácil integração com frontend e backend.

---

# Dependências de Desenvolvimento

As dependências abaixo são utilizadas apenas durante o desenvolvimento e não fazem parte da aplicação em produção.

---

## typescript

```bash
npm install -D typescript
```

Linguagem utilizada para adicionar tipagem estática ao JavaScript.

### Benefícios

- Maior segurança durante o desenvolvimento.
- Detecção precoce de erros.
- Melhor manutenção do código.
- Melhor experiência de desenvolvimento.

---

## ts-node-dev

```bash
npm install -D ts-node-dev
```

Ferramenta utilizada para executar aplicações TypeScript em modo de desenvolvimento.

### Funcionalidades

- Reinicialização automática ao salvar arquivos.
- Execução direta de arquivos TypeScript.
- Agilidade durante o desenvolvimento.

---

## @types/node

```bash
npm install -D @types/node
```

Fornece definições de tipos para as APIs do Node.js.

### Utilização

Permite que o TypeScript reconheça corretamente recursos como:

- `process`
- `fs`
- `path`
- `http`

---

## @types/express

```bash
npm install -D @types/express
```

Fornece tipagens TypeScript para o Express.

### Utilização

- Tipagem de Request.
- Tipagem de Response.
- Tipagem de Middlewares.

---

## @types/cors

```bash
npm install -D @types/cors
```

Fornece tipagens TypeScript para a biblioteca CORS.

---

## @types/bcrypt

```bash
npm install -D @types/bcrypt
```

Fornece tipagens TypeScript para a biblioteca bcrypt.

---

## @types/jsonwebtoken

```bash
npm install -D @types/jsonwebtoken
```

Fornece tipagens TypeScript para a biblioteca jsonwebtoken.

---

# Arquivos Gerados

## tsconfig.json

```bash
npx tsc --init
```

Gera o arquivo de configuração do TypeScript.

### Responsabilidades

- Definir versão do JavaScript de saída.
- Configurar diretórios de compilação.
- Habilitar verificações de tipo.
- Controlar comportamento do compilador.

### Importância

Este arquivo centraliza todas as configurações do ambiente TypeScript utilizado pelo backend.

---

# Critério de Escolha das Ferramentas

As tecnologias selecionadas foram escolhidas por serem amplamente utilizadas no desenvolvimento de APIs modernas, possuírem documentação consolidada, forte suporte da comunidade e compatibilidade com o requisito de utilização do banco de dados MySQL. Além disso, a combinação de Express, TypeScript e JWT fornece uma base robusta para a implementação de sistemas web seguros, escaláveis e de fácil manutenção.