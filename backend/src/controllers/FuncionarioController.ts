import { Request, Response } from "express";
import bcrypt from "bcrypt";
import * as FuncionarioModel from "../models/FuncionarioModel";

export const criarFuncionario = async (req: Request, res: Response): Promise<any> => {
  const { num_ag, nome_completo, senha, cargo, data_nascimento, salario } = req.body;

  try {
    // Transforma a senha limpa em um hash complexo
    const saltRounds = 10;
    const senha_hash = await bcrypt.hash(senha, saltRounds);

    const novoFuncionario = {
      num_ag,
      nome_completo,
      senha_hash,
      cargo,
      data_nascimento,
      salario
    };

    await FuncionarioModel.criar(novoFuncionario);

    return res.status(201).json({ mensagem: "Funcionário cadastrado com sucesso!" });
  } catch (error) {
    console.error("Erro ao criar funcionário:", error);
    return res.status(500).json({ erro: "Erro interno ao cadastrar funcionário." });
  }
};