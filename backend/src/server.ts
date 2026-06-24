import express from "express";

const app = express();

app.use(express.json());

app.get("/", (_, res) => {
  res.send("NullBank API");
});

app.listen(3000, () => {
  console.log("Servidor rodando na porta 3000");
});