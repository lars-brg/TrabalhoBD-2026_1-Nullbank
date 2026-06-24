import { Request, Response } from "express";
import * as TitularidadeModel from "../models/TitularidadeModel";

export const vincularTitular = async (req: Request, res: Response): Promise<any> => {
  const { num_conta, cpf_cliente, tipo_titular } = req.body;

  try {
    const novaTitularidade = {
      num_conta,
      cpf_cliente,
      tipo_titular
    };

    await TitularidadeModel.vincular(novaTitularidade);

    return res.status(201).json({ mensagem: "Cliente vinculado à conta com sucesso!" });
  } catch (error: any) {
    console.error("Erro ao vincular titularidade:", error);
    
    // Tratamento amigável para o erro de Unique Constraint (quando tenta colocar dois Titular 1, por exemplo)
    if (error.code === 'ER_DUP_ENTRY') {
       return res.status(400).json({ erro: "Violação de regra: Esta conta já possui este tipo de titular ou este cliente já está vinculado a ela." });
    }

    return res.status(500).json({ erro: "Erro interno ao vincular titularidade." });
  }
};