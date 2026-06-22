import { Router } from "express";
import { criarFuncionario } from "../controllers/FuncionarioController";
import { verificarToken, verificarAdmin } from "../middlewares/authMiddleware"; // Importou os dois

const router = Router();

/**
 * @swagger
 * /funcionarios:
 *   post:
 *     summary: Cadastra um novo funcionário (Acesso Admin)
 *     tags:
 *       - Funcionários
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
 *               nome_completo:
 *                 type: string
 *                 example: João Silva
 *               senha:
 *                 type: string
 *                 example: senhaSegura123
 *               cargo:
 *                 type: string
 *                 example: caixa
 *               data_nascimento:
 *                 type: string
 *                 format: date
 *                 example: "1990-05-15"
 *               salario:
 *                 type: number
 *                 format: float
 *                 example: 3500.00
 *             required:
 *               - num_ag
 *               - nome_completo
 *               - senha
 *               - cargo
 *               - data_nascimento
 *               - salario
 *     responses:
 *       201:
 *         description: Funcionário cadastrado com sucesso.
 *       500:
 *         description: Erro interno do servidor.
 */

router.post("/funcionarios", verificarToken, verificarAdmin, criarFuncionario);

export default router;