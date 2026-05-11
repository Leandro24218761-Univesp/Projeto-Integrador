-- 1. TIPOS DE ITENS
INSERT INTO tipos_de_itens (nome) VALUES ('Roupas'), ('Calçados');

-- 2. USUÁRIOS (Doador e ONG)
INSERT INTO usuarios (nome, email, senha, tipo_usuario) VALUES 
('Emerson Silva', 'emerson@email.com', '123', 'doador'),
('ONG Exemplo', 'contato@ong.org', '123', 'ong');

-- 3. ONGS (Ligada ao usuário ID 2)
INSERT INTO ongs (nome_instituicao, fk_usuario) VALUES ('ONG Exemplo', 2);

-- 4. CAMPANHAS (Ligada à ONG ID 1)
INSERT INTO campanhas (nome, descricao, fk_ong) VALUES ('Campanha Inverno', 'Coleta de agasalhos', 1);

-- 5. DOAÇÕES (Ligada ao Doador ID 1 e Categoria ID 1)
INSERT INTO doacoes (titulo, descricao, tamanho, fk_usuario, fk_categoria, imagem_url) VALUES 
('Casaco Azul', 'Casaco de lã em ótimo estado', 'G', 1, 1, 'https://images.unsplash.com/photo-1591195853828-11db59a44f6b');
