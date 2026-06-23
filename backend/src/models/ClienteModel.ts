import pool from "../config/database";

export const criar = async (cliente: any) => {
  // Ajuste os campos abaixo caso sua tabela "cliente" no MySQL tenha colunas diferentes
  const { cpf, nome_completo, data_nascimento, senha_hash, id_endereco } = cliente;
  
  const [result] = await pool.query(
    "INSERT INTO cliente (cpf, nome_completo, data_nascimento, senha_hash, id_endereco) VALUES (?, ?, ?, ?, ?)",
    [cpf, nome_completo, data_nascimento, senha_hash, id_endereco]
  );
  
  return result;
};

export const listarTodos = async () => {
  const [rows] = await pool.query("SELECT cpf, nome_completo, data_nascimento, id_endereco FROM cliente");
  return rows;
};