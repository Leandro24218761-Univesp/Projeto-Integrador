CREATE TABLE usuarios (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(250),
  email VARCHAR(250),
  senha_hash VARCHAR(250),
  tipo_usuario ENUM('Doador', 'ONG'),
  ativo boolean,
  criado_em TIMESTAMP DEFAULT NOW()
);

CREATE TABLE sessoes (
  sid UUID PRIMARY KEY,
  id_usuario INT REFERENCES usuarios(id),
  criado_em TIMESTAMP,
  expira_em TIMESTAMP,
  ip VARCHAR(45),
  user_agent TEXT
);

CREATE TABLE ong (
  id_ong INT PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT REFERENCES usuarios(id),
  nome_fantasia VARCHAR(100),
  cnpj VARCHAR(20),
  site VARCHAR(100),
  status_aprovação VARCHAR(10)
);

CREATE TABLE campanha (
  id_campanha INT PRIMARY KEY AUTO_INCREMENT,
  id_ong INT REFERENCES ong(id_ong),
  titulo VARCHAR(100),
  descrição VARCHAR(300),
  status VARCHAR(10),
  criado_em TIMESTAMP,
  encerrado_em TIMESTAMP
);

CREATE TABLE tipo_item(
  id_tipo_item INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(200),
  descrição VARCHAR(200),
  unidade_medida VARCHAR(10)
);

CREATE TABLE campanha_item(
  id_ci INT PRIMARY KEY AUTO_INCREMENT,
  id_campanha INT REFERENCES campanha(id_campanha),
  id_tipo_item INT REFERENCES tipo_item(id_tipo_item),
  quantidade_meta INT,
  quandidade_arrecadada INT,
  observação VARCHAR(100)
);


CREATE TABLE imagens (
  id_img INT PRIMARY KEY AUTO_INCREMENT,
  tipo ENUM('perfil', 'ong', 'campanha'),
  image BLOB NOT NULL,
  usuario_id INT NULL,
  ong_id INT NULL,
  campanha_id INT NULL
);



CREATE TABLE conversa(
  id_conversa INT PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT REFERENCES usuarios(id),
  id_ong INT REFERENCES ong(id_ong),
  criado_em TIMESTAMP,
  ultima_mensagem_em TIMESTAMP
);

CREATE TABLE mensagem(
  id_mensagem INT PRIMARY KEY AUTO_INCREMENT,
  id_conversa INT REFERENCES conversa(id_conversa),
  id_remetente INT REFERENCES usuarios(id),
  conteudo VARCHAR(250),
  enviada_em TIMESTAMP,
  status ENUM('enviada', 'recebida', 'lida')
);


INSERT INTO usuarios(nome, email, senha_hash, tipo_usuario, ativo)
VALUES
('Astarion', 'astarion@bg3.com', 'aosidjfao300239jf', 'Doador', TRUE);

INSERT INTO imagens (tipo, image, usuario_id)
VALUES
('perfil', LOAD_FILE('/var/lib/mysql-files/Astarion.webp'), 1);
