import pool from "../config/database";

export const realizarTransferencia = async (num_conta_origem: number, num_conta_destino: number, valor: number) => {
  const connection = await pool.getConnection();
  
  try {
    await connection.beginTransaction();

    // O gatilho 'trg_impede_saldo_negativo' vai checar se tem saldo antes de deixar isso acontecer.
    await connection.query(
      "INSERT INTO transacao (num_conta, tipo_transacao, valor, data_hora) VALUES (?, 'transferencia', ?, NOW())",
      [num_conta_origem, valor]
    );

    // O gatilho verá 'deposito' e fará a ADIÇÃO no saldo da conta destino.
    await connection.query(
      "INSERT INTO transacao (num_conta, tipo_transacao, valor, data_hora) VALUES (?, 'deposito', ?, NOW())",
      [num_conta_destino, valor]
    );

    // Se o banco de dados aceitou tudo sem disparar erros, confirmamos!
    await connection.commit();
    return { sucesso: true };

  } catch (error) {
    // Se o MySQL gritar que não tem saldo (via Trigger), ele cai aqui e desfaz tudo!
    await connection.rollback();
    throw error;
  } finally {
    connection.release();
  }
};