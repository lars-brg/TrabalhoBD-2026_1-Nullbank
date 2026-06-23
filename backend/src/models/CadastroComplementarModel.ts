// Aqui é realizada as inserções nas três tabelas correspondentes (telefone, email e dependentes).

import pool from "../config/database";

export const criarTelefone = async (telefone: any) => {
  const { cpf_cliente, numero, descricao } = telefone;
  const [result] = await pool.query(
    "INSERT INTO telefone (cpf_cliente, numero, descricao) VALUES (?, ?, ?)",
    [cpf_cliente, numero, descricao]
  );
  return result;
};

export const criarEmail = async (email: any) => {
  const { cpf_cliente, endereco_email, descricao } = email;
  const [result] = await pool.query(
    "INSERT INTO email (cpf_cliente, endereco_email, descricao) VALUES (?, ?, ?)",
    [cpf_cliente, endereco_email, descricao]
  );
  return result;
};

export const criarDependente = async (dependente: any) => {
  const { matricula_func, nome_completo, parentesco, data_nascimento } = dependente;
  const [result] = await pool.query(
    "INSERT INTO dependente (matricula_func, nome_completo, parentesco, data_nascimento) VALUES (?, ?, ?, ?)",
    [matricula_func, nome_completo, parentesco, data_nascimento]
  );
  return result;
};