import { Router } from "express";
import { criarConta, getContas, editarConta, removerConta } from "../controllers/ContaController";
import { verificarToken, verificarPerfil } from "../middlewares/authMiddleware";

const router = Router();
/**
 * @swagger
 * /contas:
 *   get:
 *     summary: Lista todas as contas bancárias
 *     description: Retorna todas as contas cadastradas no sistema bancário, incluindo informações básicas como número da conta, agência, gerente responsável, saldo e tipo da conta. Esta operação é restrita a administradores autenticados.
 *     tags:
 *       - Contas
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de contas retornada com sucesso.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   num_conta:
 *                     type: integer
 *                     example: 55
 *                   num_ag:
 *                     type: integer
 *                     example: 999
 *                   matricula_gerente:
 *                     type: integer
 *                     example: 1
 *                   saldo:
 *                     type: number
 *                     format: float
 *                     example: 1500.50
 *                   tipo_conta:
 *                     type: string
 *                     example: conta_corrente
 *             example:
 *               - num_conta: 55
 *                 num_ag: 999
 *                 matricula_gerente: 1
 *                 saldo: 1500.50
 *                 tipo_conta: conta_corrente
 *       401:
 *         description: Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para administradores.
 *       500:
 *         description: Erro interno do servidor.
 *
 *   post:
 *     summary: Cria uma nova conta bancária
 *     description: Cria uma nova conta bancária associada a uma agência e a um gerente responsável. Esta operação é restrita a administradores autenticados.
 *     tags:
 *       - Contas
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       description: Dados necessários para criação da conta.
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               num_ag:
 *                 type: integer
 *                 description: Número da agência responsável pela conta.
 *                 example: 999
 *               matricula_gerente:
 *                 type: integer
 *                 description: Matrícula do gerente responsável pela conta.
 *                 example: 1
 *               saldo:
 *                 type: number
 *                 format: float
 *                 description: Saldo inicial da conta.
 *                 example: 1500.50
 *               senha:
 *                 type: string
 *                 description: Senha de acesso da conta.
 *                 example: senhaConta456
 *               tipo_conta:
 *                 type: string
 *                 description: Tipo da conta a ser criada.
 *                 enum:
 *                   - conta_corrente
 *                   - poupanca
 *                   - conta_especial
 *                 example: conta_corrente
 *             required:
 *               - num_ag
 *               - matricula_gerente
 *               - saldo
 *               - senha
 *               - tipo_conta
 *           example:
 *             num_ag: 999
 *             matricula_gerente: 1
 *             saldo: 1500.50
 *             senha: senhaConta456
 *             tipo_conta: conta_corrente
 *     responses:
 *       201:
 *         description: Conta criada com sucesso.
 *       400:
 *         description: Dados inválidos ou campos obrigatórios ausentes.
 *       401:
 *         description: Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para administradores.
 *       404:
 *         description: Agência ou gerente não encontrado.
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