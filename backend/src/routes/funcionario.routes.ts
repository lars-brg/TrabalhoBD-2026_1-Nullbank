import { Router } from "express";
import { criarFuncionario } from "../controllers/FuncionarioController";
import { verificarToken, verificarPerfil } from "../middlewares/authMiddleware";

const router = Router();

/**
 * @swagger
 * /funcionarios:
 *   post:
 *     summary: Cadastra um novo funcionário
 *     description: Cria um novo funcionário vinculado a uma agência bancária. Apenas administradores autenticados podem realizar esta operação.
 *     tags:
 *       - Funcionários
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       description: Dados necessários para cadastro do funcionário.
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               num_ag:
 *                 type: integer
 *                 description: Número da agência onde o funcionário irá trabalhar.
 *                 example: 999
 *               nome_completo:
 *                 type: string
 *                 description: Nome completo do funcionário.
 *                 example: João Silva
 *               senha:
 *                 type: string
 *                 description: Senha inicial de acesso do funcionário.
 *                 example: senhaSegura123
 *               cargo:
 *                 type: string
 *                 description: Cargo exercido pelo funcionário.
 *                 example: caixa
 *               data_nascimento:
 *                 type: string
 *                 format: date
 *                 description: Data de nascimento do funcionário.
 *                 example: "1990-05-15"
 *               salario:
 *                 type: number
 *                 format: float
 *                 description: Salário do funcionário.
 *                 example: 3500.00
 *             required:
 *               - num_ag
 *               - nome_completo
 *               - senha
 *               - cargo
 *               - data_nascimento
 *               - salario
 *           example:
 *             num_ag: 999
 *             nome_completo: João Silva
 *             senha: senhaSegura123
 *             cargo: caixa
 *             data_nascimento: "1990-05-15"
 *             salario: 3500.00
 *     responses:
 *       201:
 *         description: Funcionário cadastrado com sucesso.
 *       400:
 *         description: Dados inválidos ou campos obrigatórios ausentes.
 *       401:
 *         description: Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para administradores.
 *       404:
 *         description: Agência não encontrada.
 *       409:
 *         description: Funcionário já cadastrado.
 *       500:
 *         description: Erro interno do servidor.
 */

router.post("/funcionarios", verificarToken, verificarPerfil(['gerente']), criarFuncionario);
export default router;