import pool from "../config/database";

export const criar = async (conta: any) => {
  const { num_ag, matricula_gerente, saldo, senha_hash, tipo_conta } = conta;
  
  const [result] = await pool.query(
    "INSERT INTO conta (num_ag, matricula_gerente, saldo, senha_hash, tipo_conta) VALUES (?, ?, ?, ?, ?)",
    [num_ag, matricula_gerente, saldo || 0.00, senha_hash, tipo_conta]
  );
  
  return result;
};

export const listarTodas = async () => {
  // Retornamos os dados omitindo o senha_hash por segurança
  const [rows] = await pool.query("SELECT num_conta, num_ag, matricula_gerente, saldo, tipo_conta FROM conta");
  return rows;
};

export const atualizarConta = async (num_conta: number, dados: any) => {
  // Tiramos a 'senha' da desestruturação
  const { matricula_gerente, tipo_conta } = dados; 
  
  const [result] = await pool.query(
    // Tiramos a 'senha = ?' da query SQL e deixamos só os dados administrativos
    "UPDATE conta SET matricula_gerente = ?, tipo_conta = ? WHERE num_conta = ?",
    [matricula_gerente, tipo_conta, num_conta]
  );
  return result;
};

export const deletarConta = async (num_conta: number) => {
  const [result] = await pool.query(
    "DELETE FROM conta WHERE num_conta = ?",
    [num_conta]
  );
  return result;
};