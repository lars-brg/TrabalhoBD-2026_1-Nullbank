import { Router } from "express";
import { getAgencias } from "../controllers/AgenciaController";

const router = Router();


/**
 * @swagger
 * /agencias:
 *   get:
 *     summary: Lista todas as agências do banco
 *     tags:
 *       - Agências
 *     responses:
 *       200:
 *         description: Sucesso. Retorna um array de agências.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   num_ag:
 *                     type: integer
 *                     example: 1
 *                   nome_ag:
 *                     type: string
 *                     example: Agência Central
 *                   cidade:
 *                     type: string
 *                     example: Sobral
 *       500:
 *         description: Erro interno do servidor.
 */

router.get("/agencias", getAgencias);

export default router;