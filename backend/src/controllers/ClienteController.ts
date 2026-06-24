import { Request, Response } from "express";
import * as ClienteModel from "../models/ClienteModel";

export const criarCliente = async (req: Request, res: Response): Promise<any> => {
  const { cpf, nome_completo, data_nascimento, id_endereco } = req.body;

  try {
    const novoCliente = {
      cpf,
      nome_completo,
      data_nascimento,
      id_endereco
    };

    await ClienteModel.criar(novoCliente);

    return res.status(201).json({ mensagem: "Cliente cadastrado com sucesso!" });
  } catch (error) {
    console.error("Erro ao criar cliente:", error);
    return res.status(500).json({ erro: "Erro interno ao cadastrar cliente." });
  }
};

export const getClientes = async (req: Request, res: Response): Promise<any> => {
  try {
    const clientes = await ClienteModel.listarTodos();
    return res.status(200).json(clientes);
  } catch (error) {
    console.error("Erro ao listar clientes:", error);
    return res.status(500).json({ erro: "Erro interno ao buscar clientes." });
  }
};