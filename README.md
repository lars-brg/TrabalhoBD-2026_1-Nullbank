# NullBank - Sistema de Controle Bancário

O **NullBank** é um sistema de gestão bancária desenvolvido como projeto final para a disciplina de Banco de Dados (2026.1) da UFC - Campus Sobral [1]. O sistema permite a gestão de agências, funcionários, clientes e a realização de operações financeiras complexas com integridade garantida por regras de negócio automatizadas diretamente no banco de dados.

## 🛠️ Tecnologias Utilizadas

### **Banco de Dados**
*   **SGBD:** MySQL (versão 8.0.46)
*   **Modelagem (CASE):** MySQL Workbench para o desenvolvimento do DER e Script DDL.
*   **Driver de Conexão:** `mysql2` (v3.22.5).

### **Backend & API**
*   **Ambiente de Execução:** Node.js com TypeScript (v6.0.3).
*   **Framework Web:** Express (v5.2.1).
*   **Documentação Interativa:** Swagger (`swagger-jsdoc` e `swagger-ui-express`).

### **Segurança & Autenticação**
*   **Criptografia de Senhas:** `bcrypt` (v6.0.0), atendendo à obrigatoriedade de armazenamento de senhas com hash criptográfico seguro.
*   **Controle de Acesso:** `jsonwebtoken` (JWT v9.0.3), implementando os níveis de permissão exigidos (DBA, Gerente, Atendente, Caixa e Cliente).

## 📂 Estrutura de Diretórios

```text
NullBank_BD/
├── backend/                # API REST em Node.js/TypeScript
├── database/               # Artefatos do Banco de Dados
│   ├── modelagem/          # Arquivo de modelagem (.mwb) do Workbench
│   ├── scripts/            # Scripts individuais de execução
│   │   ├── create.sql      # Criação das tabelas e restrições (DDL)
│   │   ├── populate.sql    # Script de povoamento (Dados Iniciais)
│   │   ├── triggers.sql    # Gatilhos de automação
|   |   ├── queries         # Consultas requeridas no documento
│   │   └── views.sql       # Visões de relatórios
│   └── Consultas.sql       # Arquivo unificado para avaliação
├── docs/                   # Documentação em PDF (Especificações)
└── README.md               # Guia principal
```
## 🗄️ Detalhes da Pasta Database

#### Consultas.sql (Arquivo de Avaliação)
Seguindo o **item 6** das regras de entrega, este arquivo centraliza toda a inteligência do banco de dados para conferência do professor.

**Instrução para Correção:**
Para facilitar a execução e o teste dos relatórios, as consultas foram estruturadas utilizando o padrão de parâmetros nomeados (ex: `:num_agencia` ou `:cpf_cliente`). Ao realizar os testes, basta substituir esses termos pelos valores reais desejados para visualizar os resultados processados. 

Fizemos isso pq como requisito do sistema, as queries são para valores quaisquer e genéricos, por isso não poderíamos fazer as queries com um valor em específico. Na hora de executar as queries, susbistitua esses valores de busca pelo valor do atributo em si.

O arquivo contempla integralmente:
*   **Grupos 1, 2 e 3:** Todas as buscas parametrizadas por Agência, Cliente e Cidade conforme os requisitos do sistema [2-4].
*   **Views (4, 5 e 9):** Inclui visões para listagem de contas por gerente e geração de dados de movimentações no estilo extrato para períodos de 7, 30 e 365 dias [4-6].
*   **Triggers (6 e 7):** Automação para o cálculo do montante salarial da agência (`sal_total`) e atualização automática do saldo das contas baseada no conjunto de transações [5].
*   **Transação (8):** Implementação da lógica atômica para transferência entre contas, garantindo o débito na origem e o crédito no destino de forma segura [6].

#### Scripts de Povoamento (scripts/populate.sql)
Este arquivo é fundamental para o teste do sistema, populando o banco de dados da equipe (**equipe540863**) com dados fictícios suficientes para validar todos os relatórios [1]. Ele inclui:

*   Múltiplas agências e funcionários com cargos definidos e salários base que respeitam o mínimo de **R$ 2.286,00**.
*   Clientes com cadastros completos, incluindo endereços, telefones, e-mails e diferentes modalidades de contas: **Corrente, Poupança e Especial**.
*   Um histórico detalhado de transações utilizado para validar as regras de negócio automáticas de saldo e limites de crédito.



## 📐 Modelagem do Banco de Dados (.mwb)

O arquivo original de modelagem, essencial para a visualização do Diagrama Entidade-Relacionamento (DER) e para a validação da estrutura lógica do sistema, encontra-se no seguinte diretório:

*   **Diretório:** `database/modelagem/`
*   **Arquivo:** `equipe540863.mwb`

Este arquivo do **MySQL Workbench** é um item obrigatório da entrega, mas também disponibilizamos uma versão em pdf da modelagem para visualização mais rápida da modelagem durante o desenvolvimento do projeto.


## Guia de Conexão: MySQL Workbench & Aiven (NullBank)

Para realizar a entrega final e garantir o funcionamento das regras de negócio automatizadas, siga as instruções de conexão e configuração abaixo.

### 1. Parâmetros de Conexão no MySQL Workbench

> ⚠️ **Observação Importante**
> 
> Estamos utilizando um servidor online (**Aiven**) para a hospedagem do banco de dados. Essa abordagem foi escolhida como alternativa para não exigir o uso do **Docker** (que está disponível nativamente apenas para Linux ou Windows via WSL).
> 
> Por se tratar de um **plano gratuito (free tier)**, o Aiven pode eventualmente suspender ou desligar o servidor por inatividade. Caso a API não consiga se conectar ao banco, por favor, entre em contato com a equipe para reativá-lo.

Ao criar uma nova conexão no MySQL Workbench, preencha os campos na aba **Parameters** e **SSL** com as seguintes informações:

#### Aba: Parameters
*   **Connection Name:** NullBank_Aiven (ou nome de sua preferência)
*   **Connection Method:** Standard (TCP/IP)
*   **Hostname:** `nullbank-db-equipe504863.a.aivencloud.com`
*   **Port:** `26466`
*   **Username:** `Admin`
*   **Password:** Clique em *Store in Vault...* e insira `Root`
*   **Default Schema:** `equipe540863` (ou deixe em branco para ver todos os bancos)

#### Aba: SSL
*   **SSL Mode:** Escolha a opção `Require` (equivalente ao REQUIRED solicitado).

---

### 2. Configuração e Povoamento do Banco de Dados

Conforme exigido pelo edital e pelos scripts da equipe, o banco de dados deve ser configurado seguindo esta ordem rigorosa de execução para garantir a integridade das chaves estrangeiras e gatilhos.

Entretando, você não precisa executar esses comandos porque o banco online já está populado, mas caso queira criar o banco novamente, delete o banco e siga as instruções:

1.  **Nome do Banco:** Certifique-se de que o banco de dados principal seja nomeado como **`equipe540863`**.
2.  **Estrutura (DDL):** Execute primeiro o arquivo `database/create.sql` para criar as tabelas (Agência, Funcionário, Cliente, etc.) e as restrições de integridade.
3. **Triggers** Execute o arquivo de triggers para garantir a confiabilidade lógica da criação de entidades no momento de popular o banco.
4.  **Dados Iniciais:** Popule o banco executando o script `database/inserts.sql`. Isso é essencial para validar as consultas de relatório.
5.  **Relatórios e Consultas:** Finalize criando as visões de relatório através do arquivo `database/views.sql` [8].

---

## Executando o sistema


### 🚀 Guia de Execução do Sistema (API)

Após configurar a conexão no MySQL Workbench e garantir que o banco de dados na nuvem (Aiven) está ativo, siga estas etapas para rodar a aplicação:

#### 1. Navegação e Preparação

Abra o terminal na pasta raiz do projeto e navegue até o diretório do backend:

```bash
cd backend
```

### 2. Instalação de Dependências
Certifique-se de ter o Node.js versão 25 (ou superior) instalado. Execute o comando abaixo para instalar todas as bibliotecas necessárias (Express, Driver MySQL2, Bcrypt, JWT, etc.):

```bash
npm install
```

### 3. Configuração das Variáveis de Ambiente
Para que a API se conecte ao servidor remoto, configure o arquivo de ambiente:

  1. Localize o arquivo .env.example na pasta backend.
  2. Renomeie-o para .env.
  3. Certifique-se de que as credenciais da Aiven (Hostname, Port, User e Password) estejam preenchidas corretamente conforme os dados de conexão fornecidos.

  Preencha a .env dessa forma:

    # Configurações do Servidor
    PORT=3000

    # Conexão com o Banco de Dados (Aiven Cloud)
    DB_HOST=HOST_NO_PDF
    DB_PORT=PORTA_NO_PDF
    DB_USER=USUARIO_NO_PDF
    DB_PASSWORD=SENHA_NO_pDF
    DB_NAME=BANCO_NO_PDF

    # Segurança e Autenticação
    JWT_SECRET=super_senha_secreta_nullbank_2026

### 4. Inicialização do Servidor
Inicie o servidor em modo de desenvolvimento utilizando o script configurado no projeto:

```
npm run dev
```

O sistema deve confirmar a inicialização, operando geralmente na porta 3000.

### 5. Acesso à Documentação (Swagger)
Com o servidor rodando, você pode testar todos os endpoints e níveis de acesso através da documentação interativa:

    Swagger UI: http://localhost:3000/api-docs

🛡️ Lembretes Importantes

    Níveis de Acesso: Utilize o login Admin e senha Root para acesso total (DBA). Para outros perfis, utilize as matrículas de funcionários ou CPFs de clientes cadastrados no script de povoamento.
    Segurança: Todas as senhas são processadas com hash criptográfico seguro antes de serem persistidas no banco de dados.
    Regras de Negócio: O sistema aplicará automaticamente as triggers de atualização de saldo e montante salarial da agência durante os testes na API.

Como é uma API, você pode usar seu programa de consumo e testes de API favoritos, basta utilizar as rotas documentadas pelo swagger. Nós recomendamos o posman.


📖 Documentação da API
Após iniciar o servidor, acesse o Swagger UI:

    http://localhost:3000/api-docs

⚖️ Regras de Negócio Implementadas (Database)
O projeto utiliza Triggers e Constraints para garantir a consistência dos dados:

    Salário Base: O salário dos funcionários não pode ser inferior a R$ 2.286,00.
    Contas Conjuntas: Máximo de 2 titulares por conta.
    Dependentes: Limite de 5 dependentes por funcionário.
    Limite de Contas: Apenas uma conta de cada tipo por agência para o mesmo cliente.
    Atualização Automática: O montante salarial da agência (sal_total) é recalculado automaticamente via Trigger em qualquer mudança na equipe.
    Gestão de Saldo: O saldo é atualizado por transações e nunca pode ficar negativo, exceto em contas especiais dentro do limite.

🔐 Níveis de Acesso

    Administrador (DBA): Acesso total (Login: Admin, Senha: Root).
    Gerente: Gestão de funcionários, dependentes e abertura de contas.
    Atendente: Consulta de dados de contas.
    Caixa: Realização de transações financeiras na sua agência.
    Cliente: Acesso aos dados de suas próprias contas via CPF e senha.

🔗 Links para Download

    MySQL Server: dev.mysql.com/downloads/mysql/
    MySQL Workbench: dev.mysql.com/downloads/workbench/
    Node.js: nodejs.org
    Repositório Online Recomendado: https://aiven.io/

## Autores
<table>
  <tr>
    <td align="center"><a href="https://github.com/lars-brg"><img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/118675951?v=4" width="100px;" alt=""/><br /><sub><b>Lara Braga</b></sub></a><br />🖱
    <td align="center"><a href="https://github.com/RyamLael"><img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/128926385?v=4" width="100px;" alt=""/><br /><sub><b>Ryam Lael Oliveira</b></sub></a><br />🖱
    <td align="center"><a href="https://github.com/Miguel-Edson"><img style="border-radius: 50%;" src="https://media.licdn.com/dms/image/v2/D4D03AQFtILnptJjTyA/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1713018411022?e=1746057600&v=beta&t=2RPrLkepgdsXLmUjYzZOcYfZMQzqH1_FQ5KFw5_Zuis" width="100px;" alt=""/><br /><sub><b>Miguel Edson Ramos</b></sub></a><br />🖱
  </tr>
</table>
