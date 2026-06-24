import { Router } from "express";
import { criarConta, getContas } from "../controllers/ContaController";
import { verificarToken, verificarAdmin } from "../middlewares/authMiddleware";

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
 */

router.get("/contas", verificarToken, verificarAdmin, getContas);
router.post("/contas", verificarToken, verificarAdmin, criarConta);

export default router;