import { Request, Response } from "express";
import jwt from "jsonwebtoken";
// import bcrypt from "bcrypt"; // Usaremos em breve para os funcionários/clientes
import pool from "../config/database";

export const login = async (req: Request, res: Response): Promise<any> => {
  // O usuário envia o identificador (Login, CPF ou Matrícula) e a senha
  const { identificador, senha } = req.body;

  try {
    // ==========================================
    // 1. REGRA DO ADMINISTRADOR / DBA
    // ==========================================
    // "sempre com login: Admin e senha: Root"
    if (identificador === "Admin" && senha === "Root") {
      // Gera o "crachá" do Admin
      const token = jwt.sign(
        { id: "admin", role: "DBA" }, 
        process.env.JWT_SECRET as string, 
        { expiresIn: "8h" }
      );
      
      return res.status(200).json({ 
        mensagem: "Acesso de Administrador liberado", 
        token 
      });
    }

    // ==========================================
    // 2. REGRA DO FUNCIONÁRIO (Matrícula)
    // ==========================================
    // Se o identificador for um número menor (matrícula), buscamos na tabela funcionario
    // Aqui usaremos bcrypt.compare() no futuro para checar a senha_hash!
    
    // ==========================================
    // 3. REGRA DO CLIENTE (CPF)
    // ==========================================
    // Se o identificador tiver 11 caracteres (CPF), buscamos na tabela cliente
    
    
    // Se não caiu em nenhuma regra acima ou a senha estava errada:
    return res.status(401).json({ erro: "Credenciais inválidas. Verifique seu identificador e senha." });

  } catch (error) {
    console.error("Erro no login:", error);
    return res.status(500).json({ erro: "Erro interno no servidor durante a autenticação" });
  }
};