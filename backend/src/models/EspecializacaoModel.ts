// Aqui foi criado três funções separadas, uma para cada tipo de conta.

import pool from "../config/database";

export const criarCorrente = async (num_conta: number, data_aniversario: string) => {
  const [result] = await pool.query(
    "INSERT INTO conta_corrente (num_conta, data_aniversario_contrato) VALUES (?, ?)",
    [num_conta, data_aniversario]
  );
  return result;
};

export const criarPoupanca = async (num_conta: number, taxa_juros: number) => {
  const [result] = await pool.query(
    "INSERT INTO conta_poupanca (num_conta, taxa_juros) VALUES (?, ?)",
    [num_conta, taxa_juros]
  );
  return result;
};

export const criarEspecial = async (num_conta: number, limite_credito: number) => {
  const [result] = await pool.query(
    "INSERT INTO conta_especial (num_conta, limite_credito) VALUES (?, ?)",
    [num_conta, limite_credito]
  );
  return result;
};