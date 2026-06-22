import pool from "../config/database";

export const criar = async (funcionario: any) => {
  const { num_ag, nome_completo, senha_hash, cargo, data_nascimento, salario } = funcionario;
  
  const [result] = await pool.query(
    "INSERT INTO funcionario (num_ag, nome_completo, senha_hash, cargo, data_nascimento, salario) VALUES (?, ?, ?, ?, ?, ?)",
    [num_ag, nome_completo, senha_hash, cargo, data_nascimento, salario]
  );
  
  return result;
};