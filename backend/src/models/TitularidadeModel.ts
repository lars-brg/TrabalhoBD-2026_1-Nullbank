import pool from "../config/database";

export const vincular = async (titularidade: any) => {
  const { num_conta, cpf_cliente, tipo_titular } = titularidade;
  
  const [result] = await pool.query(
    "INSERT INTO titularidade (num_conta, cpf_cliente, tipo_titular) VALUES (?, ?, ?)",
    [num_conta, cpf_cliente, tipo_titular]
  );
  
  return result;
};

export const listarPorConta = async (num_conta: number) => {
  const [rows] = await pool.query(
    "SELECT num_conta, cpf_cliente, tipo_titular FROM titularidade WHERE num_conta = ?",
    [num_conta]
  );
  return rows;
};