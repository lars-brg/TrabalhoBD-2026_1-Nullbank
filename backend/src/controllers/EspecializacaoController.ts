import { Request, Response } from "express";
import * as EspecializacaoModel from "../models/EspecializacaoModel";

export const adicionarEspecializacao = async (req: Request, res: Response): Promise<any> => {
  const { num_conta, tipo_conta, dados_especificos } = req.body;

  try {
    if (tipo_conta === "conta_corrente") {
      await EspecializacaoModel.criarCorrente(num_conta, dados_especificos.data_aniversario_contrato);
    } else if (tipo_conta === "poupanca") {
      await EspecializacaoModel.criarPoupanca(num_conta, dados_especificos.taxa_juros);
    } else if (tipo_conta === "conta_especial") {
      await EspecializacaoModel.criarEspecial(num_conta, dados_especificos.limite_credito);
    } else {
      return res.status(400).json({ erro: "Tipo de conta inválido." });
    }

    return res.status(201).json({ mensagem: `Especialização de ${tipo_conta} criada com sucesso para a conta ${num_conta}!` });
  } catch (error: any) {
    console.error("Erro ao criar especialização:", error);
    
    // Tratamento para a restrição CHECK do banco de dados (Valores negativos)
    if (error.code === 'ER_CHECK_CONSTRAINT_VIOLATED') {
      return res.status(400).json({ erro: "Violação de regra: Valores como taxas ou limites não podem ser negativos." });
    }

    return res.status(500).json({ erro: "Erro interno ao salvar especialização." });
  }
};