import { Router } from "express";
import {
  adicionarTelefone,
  adicionarEmail,
  adicionarDependente
} from "../controllers/CadastroComplementarController";
import { verificarToken, verificarAdmin } from "../middlewares/authMiddleware";

const router = Router();

/**
 * @swagger
 * /clientes/telefone:
 *   post:
 *     summary: Adiciona um telefone a um cliente (Acesso Admin)
 *     tags:
 *       - Clientes
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               cpf_cliente:
 *                 type: string
 *                 example: "12345678900"
 *               numero:
 *                 type: string
 *                 example: "88999998888"
 *               descricao:
 *                 type: string
 *                 example: "Celular Pessoal"
 *             required:
 *               - cpf_cliente
 *               - numero
 *               - descricao
 *     responses:
 *       201:
 *         description: Telefone adicionado com sucesso.
 *       401:
 *         description: Acesso negado. Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para Administradores.
 *       500:
 *         description: Erro interno do servidor.
 */
router.post(
  "/clientes/telefone",
  verificarToken,
  verificarAdmin,
  adicionarTelefone
);

/**
 * @swagger
 * /clientes/email:
 *   post:
 *     summary: Adiciona um email a um cliente (Acesso Admin)
 *     tags:
 *       - Clientes
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               cpf_cliente:
 *                 type: string
 *                 example: "12345678900"
 *               endereco_email:
 *                 type: string
 *                 format: email
 *                 example: "maria@email.com"
 *               descricao:
 *                 type: string
 *                 example: "Trabalho"
 *             required:
 *               - cpf_cliente
 *               - endereco_email
 *               - descricao
 *     responses:
 *       201:
 *         description: Email adicionado com sucesso.
 *       401:
 *         description: Acesso negado. Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para Administradores.
 *       500:
 *         description: Erro interno do servidor.
 */
router.post(
  "/clientes/email",
  verificarToken,
  verificarAdmin,
  adicionarEmail
);

/**
 * @swagger
 * /funcionarios/dependente:
 *   post:
 *     summary: Adiciona um dependente a um funcionário (Acesso Admin)
 *     tags:
 *       - Funcionários
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               matricula_func:
 *                 type: integer
 *                 example: 1
 *               nome_completo:
 *                 type: string
 *                 example: "Pedro Oliveira Ramos"
 *               parentesco:
 *                 type: string
 *                 enum:
 *                   - filho_a
 *                   - conjuge
 *                   - genitor_a
 *                 example: filho_a
 *               data_nascimento:
 *                 type: string
 *                 format: date
 *                 example: "2015-03-12"
 *             required:
 *               - matricula_func
 *               - nome_completo
 *               - parentesco
 *               - data_nascimento
 *     responses:
 *       201:
 *         description: Dependente adicionado com sucesso.
 *       401:
 *         description: Acesso negado. Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para Administradores.
 *       500:
 *         description: Erro interno do servidor.
 */
router.post(
  "/funcionarios/dependente",
  verificarToken,
  verificarAdmin,
  adicionarDependente
);

export default router;