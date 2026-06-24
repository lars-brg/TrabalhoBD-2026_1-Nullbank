import { Request, Response } from "express";
import jwt from "jsonwebtoken";
import bcrypt from "bcrypt"; // Descomentamos a biblioteca!
import pool from "../config/database";

export const login = async (req: Request, res: Response): Promise<any> => {
  const { identificador, senha } = req.body;

  try {
    // ==========================================
    // 1. REGRA DO ADMINISTRADOR / DBA
    // ==========================================
    if (identificador === "Admin" && senha === "Root") {
      const token = jwt.sign(
        { identificador: "Admin", cargo: "DBA" }, 
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
    // Checamos se o identificador digitado é apenas um número (Matrícula)
    if (!isNaN(Number(identificador))) {
      const [rows]: any = await pool.query(
        "SELECT matricula, cargo, senha_hash FROM funcionario WHERE matricula = ?",
        [identificador]
      );

      // Se achou o funcionário no banco
      if (rows.length > 0) {
        const funcionario = rows[0];
        
        // Compara a senha digitada em texto limpo com o Hash do banco
        const senhaValida = await bcrypt.compare(senha, funcionario.senha_hash);

        if (senhaValida) {
          // Gera o crachá (Token) guardando a matrícula e o CARGO exato dele
          const token = jwt.sign(
            { identificador: funcionario.matricula, cargo: funcionario.cargo },
            process.env.JWT_SECRET as string,
            { expiresIn: "8h" }
          );

          return res.status(200).json({ 
            mensagem: `Login realizado com sucesso. Bem-vindo, ${funcionario.cargo}!`, 
            token 
          });
        }
      }
    }

    // ==========================================
    // 3. REGRA DO CLIENTE (CPF) - Espaço reservado para o futuro
    // ==========================================
    
    // Se não for Admin e falhou na busca/senha de funcionário:
    return res.status(401).json({ erro: "Credenciais inválidas. Verifique seu identificador e senha." });

  } catch (error) {
    console.error("Erro no login:", error);
    return res.status(500).json({ erro: "Erro interno no servidor durante a autenticação" });
  }
};