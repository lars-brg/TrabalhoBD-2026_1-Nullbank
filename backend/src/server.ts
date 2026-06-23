import express from "express";

import authRoutes from "./routes/auth.routes";
import funcionarioRoutes from "./routes/funcionario.routes";
import clienteRoutes from "./routes/cliente.routes";
import contaRoutes from "./routes/conta.routes";
import agenciaRoutes from "./routes/agencia.routes";
import titularidadeRoutes from "./routes/titularidade.routes";

import cors from "cors";
import dotenv from "dotenv";
import { setupSwagger } from "./config/swagger";


dotenv.config();

const app = express();
app.use(cors()); // Libera o acesso para o front-end
app.use(express.json());

setupSwagger(app);

app.use("/api", agenciaRoutes);         // Plugando as rotas (Todas terão o prefixo /api)
app.use("/api", authRoutes);
app.use("/api", funcionarioRoutes);
app.use("/api", clienteRoutes);
app.use("/api", contaRoutes);
app.use("/api", titularidadeRoutes);

app.get("/", (_, res) => {
  res.send("NullBank API está rodando");
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});