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

/**
 * Middleware para verificar se o cargo do funcionário logado tem permissão.
 * @param perfisPermitidos Array com os cargos que podem acessar a rota.
 */

export const verificarPerfil = (perfisPermitidos: string[]) => {
  return (req: Request, res: Response, next: NextFunction): any => {
    // O verificarToken anterior deve ter salvo os dados decodificados do JWT aqui
    const usuario = (req as any).usuario;

    if (!usuario) {
      return res.status(401).json({ erro: "Usuário não autenticado no sistema." });
    }

    // Acesso VIP: O Admin mestre sempre passa direto
    if (usuario.identificador === "Admin") {
      return next();
    }

    // Se o usuário não tem cargo (ex: é um cliente logado) ou o cargo não está na lista
    if (!usuario.cargo || !perfisPermitidos.includes(usuario.cargo)) {
      return res.status(403).json({ 
        erro: `Acesso negado (403 Forbidden). Esta ação requer um dos seguintes perfis: ${perfisPermitidos.join(", ")}. Seu perfil atual não tem autorização.` 
      });
    }

    // Se o cargo está na lista, pode passar!
    next();
  };
};