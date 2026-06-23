import { Router } from "express";
import { criarConta, getContas } from "../controllers/ContaController";
import { verificarToken, verificarAdmin } from "../middlewares/authMiddleware";

const router = Router();

/**
 * @swagger
 * /contas:
 *   get:
 *     summary: Lista todas as contas bancárias (Acesso Admin)
 *     tags:
 *       - Contas
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de contas retornada com sucesso.
 *       401:
 *         description: Acesso negado.
 *       403:
 *         description: Acesso restrito para Administradores.
 *
 *   post:
 *     summary: Cria uma nova conta bancária (Acesso Admin)
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
 *               num_ag:
 *                 type: integer
 *                 example: 999
 *               matricula_gerente:
 *                 type: integer
 *                 example: 1
 *               saldo:
 *                 type: number
 *                 format: float
 *                 example: 1500.50
 *               senha:
 *                 type: string
 *                 example: senhaConta456
 *               tipo_conta:
 *                 type: string
 *                 example: conta_corrente
 *             required:
 *               - num_ag
 *               - matricula_gerente
 *               - saldo
 *               - senha
 *               - tipo_conta
 *     responses:
 *       201:
 *         description: Conta criada com sucesso.
 *       401:
 *         description: Acesso negado.
 *       403:
 *         description: Acesso restrito para Administradores.
 *       500:
 *         description: Erro interno do servidor.
 */

router.get("/contas", verificarToken, verificarAdmin, getContas);
router.post("/contas", verificarToken, verificarAdmin, criarConta);

export default router;