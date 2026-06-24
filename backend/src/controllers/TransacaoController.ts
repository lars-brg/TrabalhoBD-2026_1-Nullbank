import { Request, Response } from "express";
import * as TransacaoModel from "../models/TransacaoModel";

export const transferir = async (req: Request, res: Response): Promise<any> => {
  const { num_conta_origem, num_conta_destino, valor } = req.body;

  if (valor <= 0) {
    return res.status(400).json({ erro: "O valor da transferência deve ser maior que zero." });
  }

  if (num_conta_origem === num_conta_destino) {
    return res.status(400).json({ erro: "Não é possível transferir para a mesma conta." });
  }

  try {
    await TransacaoModel.realizarTransferencia(num_conta_origem, num_conta_destino, valor);
    return res.status(200).json({ mensagem: "Transferência realizada com sucesso!" });
  } catch (error: any) {
    console.error("Erro na transferência:", error.message);
    // Retorna a mensagem exata do throw new Error do Model (ex: Saldo insuficiente)
    return res.status(400).json({ erro: error.message || "Erro ao processar a transferência." });
  }
};