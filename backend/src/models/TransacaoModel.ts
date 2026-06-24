import pool from "../config/database";

export const realizarTransferencia = async (num_conta_origem: number, num_conta_destino: number, valor: number) => {
  // Em vez de pool.query direto, pegamos uma conexão dedicada para a transação
  const connection = await pool.getConnection();
  
  try {
    // Inicia a transação ACID
    await connection.beginTransaction();

    // 1. Checar saldo e bloquear a linha da origem (FOR UPDATE)
    const [linhasOrigem]: any = await connection.query(
      "SELECT saldo FROM conta WHERE num_conta = ? FOR UPDATE",
      [num_conta_origem]
    );

    if (linhasOrigem.length === 0) throw new Error("Conta de origem não encontrada.");
    if (Number(linhasOrigem[0].saldo) < valor) throw new Error("Saldo insuficiente para transferência.");

    // 2. Checar se o destino existe e bloquear a linha (FOR UPDATE)
    const [linhasDestino]: any = await connection.query(
      "SELECT num_conta FROM conta WHERE num_conta = ? FOR UPDATE",
      [num_conta_destino]
    );
    
    if (linhasDestino.length === 0) throw new Error("Conta de destino não encontrada.");

    // 3. Debitar da Origem
    await connection.query(
      "UPDATE conta SET saldo = saldo - ? WHERE num_conta = ?",
      [valor, num_conta_origem]
    );

    // 4. Creditar no Destino
    await connection.query(
      "UPDATE conta SET saldo = saldo + ? WHERE num_conta = ?",
      [valor, num_conta_destino]
    );

    // Se chegou até aqui sem erros, confirma as alterações no banco!
    await connection.commit();
    return { sucesso: true };

  } catch (error) {
    // Se deu QUALQUER erro (ex: saldo insuficiente), desfaz tudo imediatamente!
    await connection.rollback();
    throw error;
  } finally {
    // Libera a conexão de volta para o pool
    connection.release();
  }
};