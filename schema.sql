CREATE TABLE usuarios (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(250) NOT NULL,
  email VARCHAR(250) UNIQUE NOT NULL,
  senha_hash VARCHAR(255) NOT NULL,
  tipo_usuario ENUM('Doador', 'ONG') NOT NULL,
  ativo boolean NOT NULL,
  criado_em DATETIME DEFAULT NOW() NOT NULL
);

CREATE TABLE sessoes (
  sid UUID PRIMARY KEY,
  id_usuario INT NOT NULL,
  criado_em DATETIME NOT NULL,
  expira_em DATETIME NOT NULL,
  ip VARCHAR(16) NOT NULL,
  user_agent VARCHAR(100),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

CREATE TABLE ongs (
  id_ong INT PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  nome_fantasia VARCHAR(100) UNIQUE NOT NULL,
  cnpj VARCHAR(18) UNIQUE NOT NULL,
  site VARCHAR(100) UNIQUE NULL,
  status_aprovação ENUM('Aprovado', 'Reprovado', 'Em análise') NOT NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

CREATE TABLE campanhas (
  id_campanha INT PRIMARY KEY AUTO_INCREMENT,
  id_ong INT NOT NULL,
  titulo VARCHAR(100) NOT NULL,
  descrição VARCHAR(300) NOT NULL,
  status ENUM('Aberta', 'Encerrada', 'Cancelada') NOT NULL,
  criado_em DATETIME NOT NULL,
  encerrado_em DATETIME,
  FOREIGN KEY (id_ong) REFERENCES ongs(id_ong)
);

CREATE TABLE tipo_itens(
  id_tipo_item INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(200) NOT NULL,
  descrição VARCHAR(200),
  unidade_medida VARCHAR(10) NOT NULL
);

CREATE TABLE campanha_itens(
  id_ci INT PRIMARY KEY AUTO_INCREMENT,
  id_campanha INT NOT NULL,
  id_tipo_item INT NOT NULL,
  quantidade_meta INT NOT NULL,
  quantidade_arrecadada INT,
  observação VARCHAR(100),
  FOREIGN KEY (id_campanha) REFERENCES campanhas(id_campanha),
  FOREIGN KEY (id_tipo_item) REFERENCES tipo_itens(id_tipo_item)
);

CREATE TABLE imagens (
  id_img INT PRIMARY KEY AUTO_INCREMENT,
  tipo ENUM('perfil', 'ong', 'campanha') NOT NULL,
  url VARCHAR(100) UNIQUE NOT NULL,
  id_usuario INT,
  id_ong INT,
  campanha_id INT,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
  FOREIGN KEY (id_ong) REFERENCES ongs(id_ong),
  FOREIGN KEY (campanha_id) REFERENCES campanhas(id_campanha)
);

CREATE TABLE conversas(
  id_conversa INT PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  id_ong INT NOT NULL,
  criado_em DATETIME,
  ultima_mensagem_em DATETIME,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
  FOREIGN KEY (id_ong) REFERENCES ongs(id_ong)
);

CREATE TABLE mensagens(
  id_mensagem INT PRIMARY KEY AUTO_INCREMENT,
  id_conversa INT NOT NULL,
  id_remetente INT NOT NULL,
  conteudo VARCHAR(250),
  enviada_em DATETIME,
  status ENUM('enviada', 'recebida', 'lida'),
  FOREIGN KEY (id_remetente) REFERENCES usuarios(id),
  FOREIGN KEY (id_conversa) REFERENCES conversas(id_conversa)
);

