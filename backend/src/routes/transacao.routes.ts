import { Router } from "express";
import { transferir } from "../controllers/TransacaoController";
import { verificarToken, verificarPerfil } from "../middlewares/authMiddleware";

const router = Router();

/**
 * @swagger
 * /transacoes/transferencia:
 *   post:
 *     summary: Realiza uma transferência entre duas contas (Acesso Caixa)
 *     tags:
 *       - Transações
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               num_conta_origem:
 *                 type: integer
 *                 example: 55
 *               num_conta_destino:
 *                 type: integer
 *                 example: 56
 *               valor:
 *                 type: number
 *                 format: float
 *                 example: 150.50
 *             required:
 *               - num_conta_origem
 *               - num_conta_destino
 *               - valor
 *     responses:
 *       200:
 *         description: Transferência realizada com sucesso.
 *       400:
 *         description: Erro de validação (saldo insuficiente, conta inexistente ou dados inválidos).
 *       401:
 *         description: Acesso negado. Token não fornecido ou inválido.
 *       403:
 *         description: Acesso negado. Apenas usuários com perfil Caixa podem realizar transferências.
 *       500:
 *         description: Erro interno do servidor.
 */

// POST: Apenas o perfil CAIXA pode fazer a transferência
router.post("/transacoes/transferencia", verificarToken, verificarPerfil(['caixa']), transferir);

export default router;