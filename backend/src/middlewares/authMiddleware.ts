import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";

export interface AuthRequest extends Request {
  usuario?: any;
}

export const verificarToken = (req: AuthRequest, res: Response, next: NextFunction): void => {
  const authHeader = req.headers.authorization;

  // 1. Verifica se o cabeçalho existe
  if (!authHeader) {
    res.status(401).json({ erro: "Acesso negado. Token não fornecido." });
    return;
  }

  // 2. Separa a palavra "Bearer" do token
  const partes = authHeader.split(" ");
  const token = partes[1];

  // 3. A SOLUÇÃO: Verifica se o token realmente estava lá após o espaço
  if (!token) {
    res.status(401).json({ erro: "Formato de token inválido. Use: Bearer <token>" });
    return;
  }

  try {
    const decodificado = jwt.verify(token, process.env.JWT_SECRET as string);
    req.usuario = decodificado; 
    next(); 
  } catch (error) {
    res.status(401).json({ erro: "Token inválido ou expirado." });
  }
  
};

// Esse middleware só roda DEPOIS do verificarToken
export const verificarAdmin = (req: AuthRequest, res: Response, next: NextFunction): void => {
  // Lembra que no login do Admin nós colocamos { role: "DBA" } no token?
  if (req.usuario && req.usuario.role === "DBA") {
    next();
  } else {
    // Erro 403 (Forbidden): Você até é do banco, mas não tem permissão para isso.
    res.status(403).json({ erro: "Acesso restrito. Apenas Administradores (DBA) podem realizar esta ação." });
  }
};