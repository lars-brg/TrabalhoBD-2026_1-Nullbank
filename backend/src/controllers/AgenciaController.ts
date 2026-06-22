import { Request, Response } from "express";
import * as AgenciaModel from "../models/AgenciaModel";

export const getAgencias = async (req: Request, res: Response) => {
  try {
    const agencias = await AgenciaModel.listarTodas();
    res.status(200).json(agencias);
  } catch (error) {
    console.error("Erro ao buscar agências:", error);
    res.status(500).json({ erro: "Erro interno do servidor ao buscar agências" });
  }
};