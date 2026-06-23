import { Router } from "express";
import { criarCliente, getClientes } from "../controllers/ClienteController";
import { verificarToken, verificarAdmin } from "../middlewares/authMiddleware";

const router = Router();
/**
 * @swagger
 * /clientes:
 *   get:
 *     summary: Lista todos os clientes do banco (Acesso Admin)
 *     tags:
 *       - Clientes
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de clientes retornada com sucesso.
 *       401:
 *         description: Acesso negado. Token não fornecido.
 *       403:
 *         description: Acesso restrito para Administradores.
 *
 *   post:
 *     summary: Cadastra um novo cliente (Acesso Admin)
 *     tags:
 *       - Clientes
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               cpf:
 *                 type: string
 *                 example: "12345678900"
 *               nome_completo:
 *                 type: string
 *                 example: "Maria Oliveira"
 *               data_nascimento:
 *                 type: string
 *                 format: date
 *                 example: "1985-10-20"
 *               senha:
 *                 type: string
 *                 example: "senhaCliente123"
 *               id_endereco:
 *                 type: integer
 *                 example: 999
 *             required:
 *               - cpf
 *               - nome_completo
 *               - data_nascimento
 *               - senha
 *               - id_endereco
 *     responses:
 *       201:
 *         description: Cliente cadastrado com sucesso.
 *       401:
 *         description: Acesso negado. Token não fornecido.
 *       403:
 *         description: Acesso restrito para Administradores.
 *       500:
 *         description: Erro interno do servidor.
 */

router.get("/clientes", verificarToken, verificarAdmin, getClientes);
router.post("/clientes", verificarToken, verificarAdmin, criarCliente);

export default router;