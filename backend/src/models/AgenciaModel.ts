import pool from "../config/database";

export const listarTodas = async () => {
  // O [rows] tira os dados brutos de dentro da resposta complexa do MySQL
  const [rows] = await pool.query("SELECT * FROM agencia");
  return rows;
};