import { Router } from "express";
import { criarCliente, getClientes } from "../controllers/ClienteController";
import { verificarToken, verificarPerfil } from "../middlewares/authMiddleware";

const router = Router();
/**
 * @swagger
 * /clientes:
 *   get:
 *     summary: Lista todos os clientes do banco
 *     description: Retorna os dados cadastrais de todos os clientes registrados no sistema. Esta operação é restrita a administradores autenticados.
 *     tags:
 *       - Clientes
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de clientes retornada com sucesso.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   cpf:
 *                     type: string
 *                     example: "12345678900"
 *                   nome_completo:
 *                     type: string
 *                     example: "Maria Oliveira"
 *                   data_nascimento:
 *                     type: string
 *                     format: date
 *                     example: "1985-10-20"
 *             example:
 *               - cpf: "12345678900"
 *                 nome_completo: "Maria Oliveira"
 *                 data_nascimento: "1985-10-20"
 *       401:
 *         description: Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para administradores.
 *       500:
 *         description: Erro interno do servidor.
 *
 *   post:
 *     summary: Cadastra um novo cliente
 *     description: Cria um novo cliente no sistema bancário. Esta operação é restrita a administradores autenticados.
 *     tags:
 *       - Clientes
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       description: Dados necessários para criação do cliente.
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               cpf:
 *                 type: string
 *                 description: CPF do cliente.
 *                 example: "12345678900"
 *               nome_completo:
 *                 type: string
 *                 description: Nome completo do cliente.
 *                 example: "Maria Oliveira"
 *               data_nascimento:
 *                 type: string
 *                 format: date
 *                 description: Data de nascimento do cliente.
 *                 example: "1985-10-20"
 *               senha:
 *                 type: string
 *                 description: Senha inicial de acesso do cliente.
 *                 example: "senhaCliente123"
 *               id_endereco:
 *                 type: integer
 *                 description: Identificador do endereço previamente cadastrado.
 *                 example: 999
 *             required:
 *               - cpf
 *               - nome_completo
 *               - data_nascimento
 *               - senha
 *               - id_endereco
 *           example:
 *             cpf: "12345678900"
 *             nome_completo: "Maria Oliveira"
 *             data_nascimento: "1985-10-20"
 *             senha: "senhaCliente123"
 *             id_endereco: 999
 *     responses:
 *       201:
 *         description: Cliente cadastrado com sucesso.
 *       400:
 *         description: Dados inválidos ou campos obrigatórios ausentes.
 *       401:
 *         description: Token não fornecido ou inválido.
 *       403:
 *         description: Acesso restrito para administradores.
 *       409:
 *         description: CPF já cadastrado no sistema.
 *       500:
 *         description: Erro interno do servidor.
 */

router.get("/clientes", verificarToken, verificarPerfil(['gerente']), getClientes);
router.post("/clientes", verificarToken, verificarPerfil(['gerente']), criarCliente);

export default router;