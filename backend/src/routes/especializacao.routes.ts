import { Router } from "express";
import { adicionarEspecializacao } from "../controllers/EspecializacaoController";
import { verificarToken, verificarAdmin, verificarPerfil } from "../middlewares/authMiddleware";

const router = Router();

/**
 * @swagger
 * /contas/especializacao:
 *   post:
 *     summary: Adiciona os dados específicos de uma conta
 *     description: Após a criação de uma conta bancária, esta rota permite cadastrar os dados específicos do tipo de conta escolhido. Dependendo do tipo informado, devem ser enviados campos diferentes em dados_especificos. Esta operação é restrita a administradores autenticados.
 *     tags:
 *       - Contas
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       description: Dados necessários para especialização da conta.
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               num_conta:
 *                 type: integer
 *                 description: Número da conta a ser especializada.
 *                 example: 55
 *               tipo_conta:
 *                 type: string
 *                 description: Tipo da conta que receberá os dados específicos.
 *                 enum:
 *                   - conta_corrente
 *                   - poupanca
 *                   - conta_especial
 *                 example: conta_corrente
 *               dados_especificos:
 *                 type: object
 *                 description: Objeto contendo os dados específicos do tipo de conta.
 *                 properties:
 *                   data_aniversario_contrato:
 *                     type: string
 *                     format: date
 *                     example: "2026-06-23"
 *                   taxa_juros:
 *                     type: number
 *                     format: float
 *                     example: 0.75
 *                   limite_credito:
 *                     type: number
 *                     format: float
 *                     example: 5000.00
 *             required:
 *               - num_conta
 *               - tipo_conta
 *               - dados_especificos
 *           examples:
 *             conta_corrente:
 *               summary: Conta Corrente
 *               value:
 *                 num_conta: 55
 *                 tipo_conta: conta_corrente
 *                 dados_especificos:
 *                   data_aniversario_contrato: "2026-06-23"
 *             poupanca:
 *               summary: Conta Poupança
 *               value:
 *                 num_conta: 56
 *                 tipo_conta: poupanca
 *                 dados_especificos:
 *                   taxa_juros: 0.75
 *             conta_especial:
 *               summary: Conta Especial
 *               value:
 *                 num_conta: 57
 *                 tipo_conta: conta_especial
 *                 dados_especificos:
 *                   limite_credito: 5000.00
 *     responses:
 *       201:
 *         description: Especialização cadastrada com sucesso.
 *       400:
 *         description: Tipo de conta inválido, dados específicos incompatíveis ou violação de regras de negócio.
 *       401:
 *         description: Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para administradores.
 *       404:
 *         description: Conta não encontrada.
 *       500:
 *         description: Erro interno do servidor.
 */

router.post("/contas/especializacao", verificarToken, verificarPerfil(['gerente']), adicionarEspecializacao);

export default router;