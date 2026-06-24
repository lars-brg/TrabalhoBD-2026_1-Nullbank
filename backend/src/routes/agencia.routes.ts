import { Router } from "express";
import { getAgencias } from "../controllers/AgenciaController";
import { verificarPerfil, verificarToken } from "../middlewares/authMiddleware";

const router = Router();


/**
 * @swagger
 * /agencias:
 *   get:
 *     summary: Lista todas as agências do banco
 *     description: Retorna todas as agências cadastradas no sistema bancário, incluindo informações básicas de identificação e localização.
 *     tags:
 *       - Agências
 *     responses:
 *       200:
 *         description: Lista de agências retornada com sucesso.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   num_ag:
 *                     type: integer
 *                     description: Número identificador da agência.
 *                     example: 1
 *                   nome_ag:
 *                     type: string
 *                     description: Nome da agência.
 *                     example: Agência Central
 *                   cidade:
 *                     type: string
 *                     description: Cidade onde a agência está localizada.
 *                     example: Sobral
 *             example:
 *               - num_ag: 1
 *                 nome_ag: Agência Central
 *                 cidade: Sobral
 *               - num_ag: 2
 *                 nome_ag: Agência Fortaleza Centro
 *                 cidade: Fortaleza
 *       500:
 *         description: Erro interno do servidor.
 */

router.get("/agencias", verificarToken, verificarPerfil(['gerente']), getAgencias);

export default router;