import { Router } from "express";
import {
  adicionarTelefone,
  adicionarEmail,
  adicionarDependente
} from "../controllers/CadastroComplementarController";
import { verificarToken, verificarAdmin, verificarPerfil } from "../middlewares/authMiddleware";

const router = Router();

/**
 * @swagger
 * /clientes/telefone:
 *   post:
 *     summary: Adiciona um telefone a um cliente
 *     description: Associa um novo telefone a um cliente já cadastrado no sistema. Esta operação é restrita a administradores autenticados.
 *     tags:
 *       - Clientes
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       description: Dados do telefone a ser cadastrado.
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               cpf_cliente:
 *                 type: string
 *                 description: CPF do cliente que receberá o telefone.
 *                 example: "12345678900"
 *               numero:
 *                 type: string
 *                 description: Número de telefone do cliente.
 *                 example: "88999998888"
 *               descricao:
 *                 type: string
 *                 description: Identificação do telefone.
 *                 example: "Celular Pessoal"
 *             required:
 *               - cpf_cliente
 *               - numero
 *               - descricao
 *           example:
 *             cpf_cliente: "12345678900"
 *             numero: "88999998888"
 *             descricao: "Celular Pessoal"
 *     responses:
 *       201:
 *         description: Telefone adicionado com sucesso.
 *       400:
 *         description: Dados inválidos ou incompletos.
 *       401:
 *         description: Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para administradores.
 *       404:
 *         description: Cliente não encontrado.
 *       500:
 *         description: Erro interno do servidor.
 */

router.post(
  "/clientes/telefone",
  verificarToken,
  verificarPerfil(['gerente']),
  adicionarTelefone
);
/**
 * @swagger
 * /clientes/telefone:
 *   post:
 *     summary: Adiciona um telefone a um cliente
 *     description: Associa um novo telefone a um cliente já cadastrado no sistema. Esta operação é restrita a administradores autenticados.
 *     tags:
 *       - Clientes
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       description: Dados do telefone a ser cadastrado.
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               cpf_cliente:
 *                 type: string
 *                 description: CPF do cliente que receberá o telefone.
 *                 example: "12345678900"
 *               numero:
 *                 type: string
 *                 description: Número de telefone do cliente.
 *                 example: "88999998888"
 *               descricao:
 *                 type: string
 *                 description: Identificação do telefone.
 *                 example: "Celular Pessoal"
 *             required:
 *               - cpf_cliente
 *               - numero
 *               - descricao
 *           example:
 *             cpf_cliente: "12345678900"
 *             numero: "88999998888"
 *             descricao: "Celular Pessoal"
 *     responses:
 *       201:
 *         description: Telefone adicionado com sucesso.
 *       400:
 *         description: Dados inválidos ou incompletos.
 *       401:
 *         description: Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para administradores.
 *       404:
 *         description: Cliente não encontrado.
 *       500:
 *         description: Erro interno do servidor.
 */
router.post(
  "/clientes/email",
  verificarToken,
  verificarPerfil(['gerente']),
  adicionarEmail
);
/**
 * @swagger
 * /funcionarios/dependente:
 *   post:
 *     summary: Adiciona um dependente a um funcionário
 *     description: Cadastra um dependente vinculado a um funcionário existente. Esta operação é restrita a administradores autenticados.
 *     tags:
 *       - Funcionários
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       description: Dados do dependente a ser cadastrado.
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               matricula_func:
 *                 type: integer
 *                 description: Matrícula do funcionário responsável pelo dependente.
 *                 example: 1
 *               nome_completo:
 *                 type: string
 *                 description: Nome completo do dependente.
 *                 example: "Pedro Oliveira Ramos"
 *               parentesco:
 *                 type: string
 *                 description: Grau de parentesco com o funcionário.
 *                 enum:
 *                   - filho_a
 *                   - conjuge
 *                   - genitor_a
 *                 example: filho_a
 *               data_nascimento:
 *                 type: string
 *                 format: date
 *                 description: Data de nascimento do dependente.
 *                 example: "2015-03-12"
 *             required:
 *               - matricula_func
 *               - nome_completo
 *               - parentesco
 *               - data_nascimento
 *           example:
 *             matricula_func: 1
 *             nome_completo: "Pedro Oliveira Ramos"
 *             parentesco: filho_a
 *             data_nascimento: "2015-03-12"
 *     responses:
 *       201:
 *         description: Dependente cadastrado com sucesso.
 *       400:
 *         description: Dados inválidos ou incompletos.
 *       401:
 *         description: Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para administradores.
 *       404:
 *         description: Funcionário não encontrado.
 *       500:
 *         description: Erro interno do servidor.
 */
router.post(
  "/funcionarios/dependente",
  verificarToken,
  verificarPerfil(['gerente']),
  adicionarDependente
);

export default router;