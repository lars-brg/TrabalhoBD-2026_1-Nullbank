import { Router } from "express";
import { login } from "../controllers/AuthController";

const router = Router();
/**
 * @swagger
 * /auth/login:
 *   post:
 *     summary: Autentica um usuário
 *     description: Realiza a autenticação de um Administrador, Funcionário ou Cliente. Em caso de sucesso, retorna um token JWT que deverá ser enviado no cabeçalho Authorization das rotas protegidas.
 *     tags:
 *       - Autenticação
 *     requestBody:
 *       required: true
 *       description: Credenciais de acesso do usuário.
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               identificador:
 *                 type: string
 *                 description: Identificador do usuário (nome do administrador, CPF do cliente ou matrícula do funcionário).
 *                 example: Admin
 *               senha:
 *                 type: string
 *                 description: Senha do usuário.
 *                 example: Root
 *             required:
 *               - identificador
 *               - senha
 *           example:
 *             identificador: Admin
 *             senha: Root
 *     responses:
 *       200:
 *         description: Login realizado com sucesso.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 token:
 *                   type: string
 *                   description: Token JWT utilizado para autenticação das demais rotas.
 *                   example: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
 *                 role:
 *                   type: string
 *                   description: Perfil do usuário autenticado.
 *                   example: admin
 *             example:
 *               token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
 *               role: admin
 *       400:
 *         description: Dados da requisição inválidos ou incompletos.
 *       401:
 *         description: Credenciais inválidas.
 *       500:
 *         description: Erro interno do servidor.
 */

router.post("/auth/login", login);

export default router;