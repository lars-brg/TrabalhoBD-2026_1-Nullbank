import { Router } from "express";
import { vincularTitular } from "../controllers/TitularidadeController";
import { verificarToken, verificarAdmin } from "../middlewares/authMiddleware";

const router = Router();

/**
 * @swagger
 * /titularidades:
 *   post:
 *     summary: Vincula um cliente a uma conta bancária
 *     description: Associa um cliente a uma conta bancária como titular principal ou secundário. Esta operação é restrita a administradores autenticados.
 *     tags:
 *       - Contas
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       description: Dados necessários para vincular um cliente a uma conta.
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               num_conta:
 *                 type: integer
 *                 description: Número da conta bancária.
 *                 example: 1
 *               cpf_cliente:
 *                 type: string
 *                 description: CPF do cliente que será vinculado à conta.
 *                 example: "12345678900"
 *               tipo_titular:
 *                 type: string
 *                 description: Define se o cliente será titular principal ou secundário da conta.
 *                 enum:
 *                   - titular_1
 *                   - titular_2
 *                 example: titular_1
 *             required:
 *               - num_conta
 *               - cpf_cliente
 *               - tipo_titular
 *           example:
 *             num_conta: 1
 *             cpf_cliente: "12345678900"
 *             tipo_titular: titular_1
 *     responses:
 *       201:
 *         description: Cliente vinculado à conta com sucesso.
 *       400:
 *         description: Violação de regra de negócio ou dados inválidos.
 *       401:
 *         description: Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para administradores.
 *       404:
 *         description: Conta ou cliente não encontrado.
 *       409:
 *         description: Cliente já vinculado à conta ou limite de titulares atingido.
 *       500:
 *         description: Erro interno do servidor.
 */

router.post("/titularidades", verificarToken, verificarAdmin, vincularTitular);

export default router;