import swaggerJSDoc from "swagger-jsdoc";
import swaggerUi from "swagger-ui-express";
import { Express } from "express";

const options = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "NullBank API",
      version: "1.0.0",
      description: "Documentação interativa da API do sistema bancário NullBank.",
    },
    servers: [
      {
        url: "http://localhost:3000/api",
        description: "Servidor de Desenvolvimento",
      },
    ],
  },
  // Aqui dizemos onde o Swagger deve procurar pelos comentários das rotas
  apis: ["./src/routes/*.ts"], 
};

const swaggerSpec = swaggerJSDoc(options);

export const setupSwagger = (app: Express) => {
  // Cria a rota /api-docs que vai hospedar a interface gráfica
  app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));
};