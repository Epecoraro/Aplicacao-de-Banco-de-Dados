-- AULA 15 - CONSULTAS COM INNER JOIN

-- Criar 3 tabelas (PRODUTOS, VENDAS e FORNECEDORES) DE UMA PAPELARIA (CHAMADA PAPIRO)

CREATE TABLE PAPIRO_PRODUTOS(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Preco DECIMAL(8,2) NOT NULL,
    Estoque INT,
    Fornecedor_ID INT,
    FOREIGN KEY (Fornecedor_ID) REFERENCES PAPIRO_FORNECEDORES(ID)
);

INSERT INTO PAPIRO_PRODUTOS (Nome, Preco, Estoque, Fornecedor_ID)
SELECT 'Resma A4', 50, 85, f.ID FROM PAPIRO_FORNECEDORES f WHERE f.Nome = 'Suzano';

INSERT INTO PAPIRO_PRODUTOS (Nome, Preco, Estoque, Fornecedor_ID)
SELECT 'Lápis preto HB', 8, 200, f.ID FROM PAPIRO_FORNECEDORES f WHERE f.Nome = 'Faber Castell';

INSERT INTO PAPIRO_PRODUTOS (Nome, Preco, Estoque, Fornecedor_ID)
SELECT 'Caneta BIC Azul', 3, 285, f.ID FROM PAPIRO_FORNECEDORES f WHERE f.Nome = 'BIC Amazônia';

INSERT INTO PAPIRO_PRODUTOS (Nome, Preco, Estoque, Fornecedor_ID)
SELECT 'Caderno Espiral Pautado 200 folhas', 50, 200, f.ID FROM PAPIRO_FORNECEDORES f WHERE f.Nome = 'Tilibra';

-- OUTRA OPÇÃO SERIA COMBINAR O SELECT FROM COM O UNION ALL UM UNION ALL
INSERT INTO PAPIRO_PRODUTOS (Nome, Preco, Estoque, Fornecedor_ID)
SELECT '1/2 Resma A4', 25, 85, f.ID FROM PAPIRO_FORNECEDORES f WHERE f.Nome = 'Suzano'
UNION ALL
SELECT 'Grafite 0.9mm', 10.50, 120, f.ID FROM PAPIRO_FORNECEDORES f WHERE f.Nome = 'Faber Castell'
UNION ALL
SELECT 'Cartolina Branca', 3.50, 300, f.ID FROM PAPIRO_FORNECEDORES f WHERE f.Nome = 'Suzano';


SELECT * FROM PAPIRO_PRODUTOS;


CREATE TABLE PAPIRO_VENDAS(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    ProdutoID INT,
    FOREIGN KEY (ProdutoID) REFERENCES PAPIRO_PRODUTOS(ID),
    Quantidade INT,
    Data_Venda DATETIME
);

INSERT INTO PAPIRO_VENDAS (ProdutoID, Quantidade, Data_Venda)
	VALUES
	(1, 2, '2025-10-17'),
    (2, 1, '2025-10-16'),
	(3, 3, '2025-10-16'),
    (4, 1, '2025-10-15'),
    (5, 4, '2025-10-15'),
    (6, 1, '2025-10-14'),
    (7, 10, '2025-10-14');

SELECT * FROM PAPIRO_VENDAS;

CREATE TABLE PAPIRO_FORNECEDORES(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50)
);

INSERT INTO PAPIRO_FORNECEDORES (Nome) VALUES ('Suzano');
INSERT INTO PAPIRO_FORNECEDORES (Nome) VALUES ('Faber Castell');
INSERT INTO PAPIRO_FORNECEDORES (Nome) VALUES ('BIC Amazônia');
INSERT INTO PAPIRO_FORNECEDORES (Nome) VALUES ('Tilibra');
    
    
SELECT * FROM PAPIRO_FORNECEDORES;

-- CONSULTAS

-- 1) Exibir o nome dos produtos e o nome do fornecedor de cada um
-- A ligação entre as tabelas deve ser feita pelas chaves estrangeiras, e não pelos nomes.
-- Porque na tabela PAPIRO_PRODUTOS, o campo Fornecedor_ID é uma chave estrangeira que aponta para PAPIRO_FORNECEDORES.ID

SELECT a.Nome AS NomePRODUTOS, f.Nome AS NomeFORNECEDORES
FROM PAPIRO_PRODUTOS AS a
INNER JOIN PAPIRO_FORNECEDORES AS f ON a.Fornecedor_ID = f.ID;

-- Pode-se deixar sem chaves estrangeiras, mas não deveria em um banco relacional bem projetado.
-- O que acontece se, nesse caso, não declarar as chaves estrangeiras?
-- 1 - O MySQL não vai impedir a inserção de um produto com um Fornecedor_ID que não existe
-- 2 - O banco não vai indicar se o usuário apagar um fornecedor que ainda tem produtos associados
-- 3 - Os JOINs ainda funcionarão, desde que se indique as colunas corretas (por exemplo, ON a.Fornecedor_ID = f.ID).
-- Ou seja, funciona, mas o banco deixa de proteger a integridade dos dados.


-- 2) Listar os produtos vendidos com suas quantidades e data da venda
-- Como o campo que liga as tabelas é PAPIRO_VENDAS.ProdutoID = PAPIRO_PRODUTOS.ID, basta fazer um JOIN entre essas duas tabelas.

SELECT 
    p.Nome AS Produto,
    v.Quantidade,
    v.Data_Venda
FROM PAPIRO_VENDAS AS v
INNER JOIN PAPIRO_PRODUTOS AS p ON v.ProdutoID = p.ID;


-- 3) Ver o nome do produto, preço do produto e o nome do fornecedor
SELECT 
    p.Nome AS Produto,
    p.Preco AS Preco,
    f.Nome AS Fornecedor
FROM PAPIRO_PRODUTOS AS p
JOIN PAPIRO_FORNECEDORES AS f ON p.Fornecedor_ID = f.ID;


-- 4) Exibir produtos com estoque abaixo de 200 unidades e seus fornecedores

SELECT 
    p.Nome AS Produto,
    p.Estoque,
    f.Nome AS Fornecedor
FROM PAPIRO_PRODUTOS AS p
JOIN PAPIRO_FORNECEDORES AS f ON p.Fornecedor_ID = f.ID WHERE p.Estoque < 200;


-- 5) Listar as 5 últimas vendas exibindo por data decrescente, a quantidade o nome do produto e o fornecedor
SELECT 
    v.Data_Venda,
    v.Quantidade,
    p.Nome AS Produto,
    f.Nome AS Fornecedor
FROM PAPIRO_VENDAS AS v
JOIN PAPIRO_PRODUTOS AS p ON v.ProdutoID = p.ID
JOIN PAPIRO_FORNECEDORES AS f ON p.Fornecedor_ID = f.ID
ORDER BY v.Data_Venda DESC LIMIT 5;
