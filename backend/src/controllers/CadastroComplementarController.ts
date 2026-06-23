import { Request, Response } from "express";
import * as CadastroComplementarModel from "../models/CadastroComplementarModel";

export const adicionarTelefone = async (req: Request, res: Response): Promise<any> => {
  try {
    await CadastroComplementarModel.criarTelefone(req.body);
    return res.status(201).json({ mensagem: "Telefone cadastrado com sucesso!" });
  } catch (error: any) {
    console.error("Erro ao cadastrar telefone:", error);
    if (error.code === 'ER_CHECK_CONSTRAINT_VIOLATED') {
      return res.status(400).json({ erro: "Formato de telefone inválido. Deve conter apenas números (10 ou 11 dígitos)." });
    }
    return res.status(500).json({ erro: "Erro interno ao salvar telefone." });
  }
};

export const adicionarEmail = async (req: Request, res: Response): Promise<any> => {
  try {
    await CadastroComplementarModel.criarEmail(req.body);
    return res.status(201).json({ mensagem: "Email cadastrado com sucesso!" });
  } catch (error: any) {
    console.error("Erro ao cadastrar email:", error);
    if (error.code === 'ER_CHECK_CONSTRAINT_VIOLATED') {
      return res.status(400).json({ erro: "Formato de email inválido." });
    }
    if (error.code === 'ER_DUP_ENTRY') {
      return res.status(400).json({ erro: "Este endereço de email já está cadastrado." });
    }
    return res.status(500).json({ erro: "Erro interno ao salvar email." });
  }
};

export const adicionarDependente = async (req: Request, res: Response): Promise<any> => {
  try {
    await CadastroComplementarModel.criarDependente(req.body);
    return res.status(201).json({ mensagem: "Dependente cadastrado com sucesso!" });
  } catch (error: any) {
    console.error("Erro ao cadastrar dependente:", error);
    if (error.code === 'ER_DUP_ENTRY') {
      return res.status(400).json({ erro: "Este dependente já está cadastrado para este funcionário." });
    }
    return res.status(500).json({ erro: "Erro interno ao salvar dependente." });
  }
};