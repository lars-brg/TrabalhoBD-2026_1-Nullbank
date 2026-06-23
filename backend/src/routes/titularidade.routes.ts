import { Router } from "express";
import { vincularTitular } from "../controllers/TitularidadeController";
import { verificarToken, verificarAdmin } from "../middlewares/authMiddleware";

const router = Router();

/**
 * @swagger
 * /titularidades:
 *   post:
 *     summary: Vincula um cliente a uma conta bancária (Acesso Admin)
 *     tags:
 *       - Contas
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               num_conta:
 *                 type: integer
 *                 example: 1
 *               cpf_cliente:
 *                 type: string
 *                 example: "12345678900"
 *               tipo_titular:
 *                 type: string
 *                 enum:
 *                   - titular_1
 *                   - titular_2
 *                 example: titular_1
 *             required:
 *               - num_conta
 *               - cpf_cliente
 *               - tipo_titular
 *     responses:
 *       201:
 *         description: Cliente vinculado com sucesso.
 *       400:
 *         description: Erro de violação de regra.
 *       401:
 *         description: Acesso negado. Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para Administradores.
 *       500:
 *         description: Erro interno do servidor.
 */

router.post("/titularidades", verificarToken, verificarAdmin, vincularTitular);

export default router;