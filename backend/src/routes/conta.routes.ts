import { Router } from "express";
import { criarConta, getContas, editarConta, removerConta } from "../controllers/ContaController";
import { verificarToken, verificarPerfil } from "../middlewares/authMiddleware";

const router = Router();
/**
 * @swagger
 * /contas:
 *   get:
 *     summary: Lista todas as contas bancárias (Acesso Gerente, Atendente, Caixa)
 *     tags:
 *       - Contas
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de contas retornada com sucesso.
 *       401:
 *         description: Acesso negado. Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito aos perfis autorizados.
 *
 *   post:
 *     summary: Cria uma nova conta bancária (Acesso Gerente)
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
 *                 example: 5
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
 *         description: Acesso negado. Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito. Apenas Gerentes podem realizar esta ação.
 *       500:
 *         description: Erro interno do servidor.
 *
 * /contas/{id}:
 *   put:
 *     summary: Atualiza os dados de uma conta (Acesso Gerente)
 *     tags:
 *       - Contas
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: Número da conta
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               matricula_gerente:
 *                 type: integer
 *                 example: 1
 *               tipo_conta:
 *                 type: string
 *                 example: conta_corrente
 *               senha:
 *                 type: string
 *                 example: novaSenha123
 *     responses:
 *       200:
 *         description: Conta atualizada com sucesso.
 *       401:
 *         description: Acesso negado. Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito.
 *       404:
 *         description: Conta não encontrada.
 *
 *   delete:
 *     summary: Remove uma conta do sistema (Acesso Gerente)
 *     tags:
 *       - Contas
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: Número da conta
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Conta removida com sucesso.
 *       401:
 *         description: Acesso negado. Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito.
 *       404:
 *         description: Conta não encontrada.
 */

// GET: Atendentes e Gerentes podem consultar os dados (e Caixas também, por lógica bancária)
router.get("/contas", verificarToken, verificarPerfil(['gerente', 'atendente', 'caixa']), getContas);

// POST: Apenas o Gerente pode ABRIR contas
router.post("/contas", verificarToken, verificarPerfil(['gerente']), criarConta);

// PUT: Apenas Gerentes podem alterar dados da conta
router.put("/contas/:id", verificarToken, verificarPerfil(['gerente']), editarConta);

// DELETE: Apenas Gerentes podem remover contas
router.delete("/contas/:id", verificarToken, verificarPerfil(['gerente']), removerConta);

export default router;