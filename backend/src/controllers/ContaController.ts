import { Request, Response } from "express";
import bcrypt from "bcrypt";
import * as ContaModel from "../models/ContaModel";

export const criarConta = async (req: Request, res: Response): Promise<any> => {
  const { num_ag, matricula_gerente, saldo, senha, tipo_conta } = req.body;

  try {
    const saltRounds = 10;
    const senha_hash = await bcrypt.hash(senha, saltRounds);

    const novaConta = {
      num_ag,
      matricula_gerente,
      saldo,
      senha_hash,
      tipo_conta
    };

    await ContaModel.criar(novaConta);

    return res.status(201).json({ mensagem: "Conta bancária criada com sucesso!" });
  } catch (error) {
    console.error("Erro ao criar conta:", error);
    return res.status(500).json({ erro: "Erro interno ao criar conta." });
  }
};

export const getContas = async (req: Request, res: Response): Promise<any> => {
  try {
    const contas = await ContaModel.listarTodas();
    return res.status(200).json(contas);
  } catch (error) {
    console.error("Erro ao listar contas:", error);
    return res.status(500).json({ erro: "Erro interno ao buscar contas." });
  }
};


export const editarConta = async (req: Request, res: Response): Promise<any> => {
const num_conta = parseInt(req.params.id as string);  
  try {
    const resultado: any = await ContaModel.atualizarConta(num_conta, req.body);
    
    if (resultado.affectedRows === 0) {
      return res.status(404).json({ erro: "Conta não encontrada para atualização." });
    }
    
    return res.status(200).json({ mensagem: "Dados da conta atualizados com sucesso!" });
  } catch (error) {
    console.error("Erro ao atualizar conta:", error);
    return res.status(500).json({ erro: "Erro interno ao atualizar a conta." });
  }
};

export const removerConta = async (req: Request, res: Response): Promise<any> => {
const num_conta = parseInt(req.params.id as string);  
  try {
    const resultado: any = await ContaModel.deletarConta(num_conta);
    
    if (resultado.affectedRows === 0) {
      return res.status(404).json({ erro: "Conta não encontrada para remoção." });
    }
    
    return res.status(200).json({ mensagem: "Conta encerrada e removida com sucesso!" });
  } catch (error: any) {
    console.error("Erro ao remover conta:", error);
    // Erro de Chave Estrangeira (ex: tentar apagar conta que tem movimentações)
    if (error.code === 'ER_ROW_IS_REFERENCED_2') {
      return res.status(400).json({ erro: "Não é possível remover esta conta pois ela possui dependências (titulares, especializações ou transações)." });
    }
    return res.status(500).json({ erro: "Erro interno ao remover a conta." });
  }
};