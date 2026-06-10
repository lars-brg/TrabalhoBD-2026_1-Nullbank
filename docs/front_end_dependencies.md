# Dependências do Frontend

Este documento descreve as principais dependências utilizadas no frontend do projeto e a finalidade de cada uma delas.

## Instalação

```bash
npm install react-router-dom
npm install axios

npm install @mui/material
npm install @emotion/react
npm install @emotion/styled
npm install @mui/icons-material

npm install react-hook-form

npm install react-toastify
```

---

## react-router-dom

```bash
npm install react-router-dom
```

Biblioteca responsável pelo gerenciamento de rotas da aplicação React.

### Utilização
- Navegação entre páginas sem recarregar a aplicação.
- Definição de rotas protegidas.
- Controle de parâmetros na URL.
- Organização da estrutura de páginas.

### Exemplos
- `/login`
- `/dashboard`
- `/usuarios`
- `/clientes/:id`

---

## axios

```bash
npm install axios
```

Cliente HTTP utilizado para comunicação entre o frontend e o backend.

### Utilização
- Envio de requisições GET, POST, PUT e DELETE.
- Consumo da API da aplicação.
- Tratamento centralizado de erros.
- Configuração de autenticação via token.

### Vantagens
- API simples e intuitiva.
- Suporte a interceptadores.
- Configuração global de URL base.
- Melhor tratamento de respostas e erros.

---

## Material UI (MUI)

```bash
npm install @mui/material
npm install @emotion/react
npm install @emotion/styled
npm install @mui/icons-material
```

Biblioteca de componentes baseada no Material Design da Google.

### @mui/material

Fornece componentes visuais prontos para uso, como:

- Buttons
- TextFields
- Tables
- Cards
- Dialogs
- AppBars
- Menus

### @emotion/react e @emotion/styled

Dependências responsáveis pela estilização dos componentes do MUI.

### @mui/icons-material

Biblioteca de ícones compatíveis com o Material Design.

### Vantagens

- Interface moderna e profissional.
- Componentes acessíveis e responsivos.
- Grande quantidade de componentes prontos.
- Redução do tempo de desenvolvimento.

---

## react-hook-form

```bash
npm install react-hook-form
```

Biblioteca para gerenciamento e validação de formulários.

### Utilização

- Formulários de login.
- Cadastro de usuários.
- Edição de informações.
- Validação de campos.

### Vantagens

- Melhor desempenho.
- Menor quantidade de código.
- Fácil integração com React.
- Validação simplificada.

---

## react-toastify

```bash
npm install react-toastify
```

Biblioteca utilizada para exibir notificações temporárias ao usuário.

### Utilização

- Mensagens de sucesso.
- Alertas de erro.
- Avisos informativos.
- Feedback após operações da aplicação.

### Exemplos

- "Login realizado com sucesso."
- "Usuário cadastrado."
- "Erro ao conectar com o servidor."
- "Operação concluída."

### Vantagens

- Fácil implementação.
- Notificações não intrusivas.
- Personalização visual.
- Melhor experiência do usuário.