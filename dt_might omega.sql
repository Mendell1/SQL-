-- Criando o banco de dados dt_might
CREATE DATABASE dt_might;

-- Selecionando o banco de dados dt_might
USE dt_might;



-- Tabela de usuários
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de jogos
CREATE TABLE games (
    id_jogo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    sobre TEXT,
    desenvolvedor VARCHAR(100),
    plataforma VARCHAR(50),
    preco DECIMAL(10,2),
    data_lancamento DATE,
    requisitos_sistema TEXT,
    requisitos_recomendados TEXT,
    jogo_capa VARCHAR(255), -- Caminho para a imagem da capa
    jogo_thumbnail VARCHAR(255), -- Caminho para a thumbnail
    jogo_apr VARCHAR(255), -- Caminho para gifs ou vídeos de apresentação
    jogo_sobre VARCHAR(255), -- Caminho para gifs ou vídeos da categoria "sobre"
    jogo_banner VARCHAR(255), -- Caminho para o banner
    jogo_print VARCHAR(255) -- Caminho para o banner
);



-- Tabela de jogos em destaque
CREATE TABLE game_destaque (
    id_destaque INT AUTO_INCREMENT PRIMARY KEY,
    id_jogo INT NOT NULL,
    FOREIGN KEY (id_jogo) REFERENCES games(id_jogo) ON DELETE CASCADE
);

-- Tabela de lançamentos de jogos
CREATE TABLE launches (
    id_lancamento INT AUTO_INCREMENT PRIMARY KEY,
    id_jogo INT NOT NULL,
    FOREIGN KEY (id_jogo) REFERENCES games(id_jogo) ON DELETE CASCADE
);

-- Tabela de banners
CREATE TABLE banners (
    id_banner INT AUTO_INCREMENT PRIMARY KEY,
    id_jogo INT NOT NULL,
    FOREIGN KEY (id_jogo) REFERENCES games(id_jogo) ON DELETE CASCADE
);

-- Tabela de distribuidoras
CREATE TABLE distributors (
    id_distribuidora INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Tabela de jogos e distribuidoras (relacionamento)
CREATE TABLE distributor_games (
    id_distribuidora INT NOT NULL,
    id_jogo INT NOT NULL,
    FOREIGN KEY (id_distribuidora) REFERENCES distributors(id_distribuidora) ON DELETE CASCADE,
    FOREIGN KEY (id_jogo) REFERENCES games(id_jogo) ON DELETE CASCADE,
    PRIMARY KEY (id_distribuidora, id_jogo)
);

-- Tabela de carrinho de compras
CREATE TABLE cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    game_id INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES games(id_jogo) ON DELETE CASCADE
);

-- Tabela de pedidos
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    data_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Tabela de itens do pedido
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    game_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES games(id_jogo) ON DELETE CASCADE
);

CREATE TABLE nuvem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_jogo INT NOT NULL,
    tipo_midia ENUM('jpg', 'jpeg', 'png', 'gif', 'mp4', 'webp') NOT NULL, -- Tipo de mídia (imagem ou vídeo)
    categoria ENUM('capa', 'thumbnail', 'print', 'apr', 'sobre', 'banner') NOT NULL, -- Categoria do arquivo
    caminho_arquivo VARCHAR(255) NOT NULL, -- Caminho para o arquivo armazenado
    FOREIGN KEY (id_jogo) REFERENCES games(id_jogo) ON DELETE CASCADE
);


CREATE TABLE launches (
    id_lancamento INT AUTO_INCREMENT PRIMARY KEY,
    id_jogo INT NOT NULL,
    FOREIGN KEY (id_jogo) REFERENCES games(id_jogo) ON DELETE CASCADE
);

CREATE TABLE sub_sobres (
    id_sub_sobre INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador único para cada sub-sobre
    id_jogo INT NOT NULL,                         -- Relacionamento com o jogo (id_jogo)
    titulo VARCHAR(255) NOT NULL,                 -- Título do sub-sobre
    texto TEXT,                                   -- Texto do sub-sobre
    imagem VARCHAR(255),                          -- Caminho da imagem associada ao sub-sobre
    FOREIGN KEY (id_jogo) REFERENCES games(id_jogo) ON DELETE CASCADE -- Chave estrangeira
);

-- desativa medidas de segurança que impede que vc apague as coisas o 1 liga de novo --
SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

-- desativa as chaves estrangeiras --
SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 1;

-- deletar os arquivos dentro do banco--
DELETE FROM order_items WHERE game_id IN (SELECT id_jogo FROM games);
DELETE FROM cart WHERE game_id IN (SELECT id_jogo FROM games);
DELETE FROM distributor_games WHERE id_jogo IN (SELECT id_jogo FROM games);
DELETE FROM launches WHERE id_jogo IN (SELECT id_jogo FROM games);
DELETE FROM game_destaque WHERE id_jogo IN (SELECT id_jogo FROM games);
DELETE FROM banners WHERE id_jogo IN (SELECT id_jogo FROM games);
DELETE FROM nuvem WHERE id_jogo IN (SELECT id_jogo FROM games);
DELETE FROM sub_sobres WHERE id_jogo IN (SELECT id_jogo FROM games);
DELETE FROM games;

-- para começar do 1 de novo o id--
ALTER TABLE games AUTO_INCREMENT = 1;
ALTER TABLE order_items AUTO_INCREMENT = 1;
ALTER TABLE cart AUTO_INCREMENT = 1;
ALTER TABLE distributor_games AUTO_INCREMENT = 1;
ALTER TABLE launches AUTO_INCREMENT = 1;
ALTER TABLE game_destaque AUTO_INCREMENT = 1;
ALTER TABLE banners AUTO_INCREMENT = 1;
ALTER TABLE nuvem AUTO_INCREMENT = 1;
ALTER TABLE sub_sobres AUTO_INCREMENT = 1;

SHOW TABLES;  -- Exibe todas as tabelas no banco de dados

DESCRIBE games;  -- Descreve a estrutura da tabela games

SELECT * FROM games;


