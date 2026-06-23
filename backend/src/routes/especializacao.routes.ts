import { Router } from "express";
import { adicionarEspecializacao } from "../controllers/EspecializacaoController";
import { verificarToken, verificarAdmin } from "../middlewares/authMiddleware";

const router = Router();

/**
 * @swagger
 * /contas/especializacao:
 *   post:
 *     summary: Adiciona os detalhes específicos de uma conta (Corrente, Poupança ou Especial)
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
 *                 example: 55
 *               tipo_conta:
 *                 type: string
 *                 enum:
 *                   - conta_corrente
 *                   - poupanca
 *                   - conta_especial
 *                 example: conta_corrente
 *               dados_especificos:
 *                 type: object
 *                 description: Envie data_aniversario_contrato, taxa_juros ou limite_credito dependendo do tipo da conta.
 *                 example:
 *                   data_aniversario_contrato: "2026-06-23"
 *             required:
 *               - num_conta
 *               - tipo_conta
 *               - dados_especificos
 *     responses:
 *       201:
 *         description: Especialização salva com sucesso.
 *       400:
 *         description: Erro de violação de limite ou tipo de conta inválido.
 *       401:
 *         description: Acesso negado. Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para Administradores.
 *       500:
 *         description: Erro interno do servidor.
 */

router.post("/contas/especializacao", verificarToken, verificarAdmin, adicionarEspecializacao);

export default router;