CREATE DATABASE exercicio4
GO
USE exercicio4
GO
CREATE TABLE cliente(
CPF					VARCHAR(12)					NOT NULL,
nome				VARCHAR(150)				NOT NULL,
telefone			VARCHAR(9)					NOT NULL
PRIMARY KEY(CPF)
)
GO
CREATE TABLE fornecedor(
id					INT							NOT NULL,
nome				VARCHAR(100)				NOT NULL,
logradouro			VARCHAR(170)				NOT NULL,
numero				INT							NOT NULL,
complemento			VARCHAR(20)					NOT NULL,
cidade				VARCHAR(80)					NOT NULL
PRIMARY KEY(id)
)
GO
CREATE TABLE produto(
codigo				INT							NOT NULL,
descricao			VARCHAR(200)				NOT NULL,
fornecedor			INT							NOT NULL,
preco				DECIMAL(10,2)				NOT NULL
PRIMARY KEY(codigo)
FOREIGN KEY(fornecedor) REFERENCES fornecedor(id)
)
GO
CREATE TABLE venda(
codigo				INT							NOT NULL,
produto				INT							NOT NULL,
cliente				VARCHAR(12)					NOT NULL,
quantidade			INT							NOT NULL,
valor_total			DECIMAL(10,2)				NOT NULL,
data				DATE						NOT NULL
PRIMARY KEY(codigo, produto, cliente)
FOREIGN KEY(produto)	REFERENCES produto(codigo),
FOREIGN KEY(cliente)	REFERENCES cliente(CPF)	
)
GO
INSERT INTO cliente VALUES('345789092-90', 'Julio Cesar', '8273-6541')
INSERT INTO cliente VALUES('251865337-10', 'Maria Antonia', '8765-2314')
INSERT INTO cliente VALUES('876273154-16', 'Luiz Carlos', '6128-9012')
INSERT INTO cliente VALUES('791826398-00', 'Paulo Cesar', '9076-5273')
INSERT INTO fornecedor VALUES(1, 'LG', 'Rod. Bandeirantes', 70000, 'Km 70', 'Itapeva')
INSERT INTO fornecedor VALUES(2, 'Asus', 'Av. Nações Unidas', 10206, 'Sala 225', 'São Paulo')
INSERT INTO fornecedor VALUES(3, 'AMD', 'Av. Nações Unidas', 10206, 'Sala 1095', 'São Paulo')
INSERT INTO fornecedor VALUES(4, 'Leadership', 'Av. Nações Unidas', 10206, 'Sala 87', 'São Paulo')
INSERT INTO fornecedor VALUES(5, 'Inno', 'Av. Nações Unidas', 10206, 'Sala 34', 'São Paulo')
INSERT INTO produto VALUES(1, 'Monitor 19 pol.', 1, 449.99)
INSERT INTO produto VALUES(2, 'Netbook 1GB Ram 4 Gb HD', 2, 699.99)
INSERT INTO produto VALUES(3, 'Gravador de DVD - Sata', 1, 99.99)
INSERT INTO produto VALUES(4, 'Leitor de CD', 1, 49.99)
INSERT INTO produto VALUES(5, 'Processador - Phenom X3 - 2.1GHz', 3, 349.99)
INSERT INTO produto VALUES(6, 'Mouse', 4, 19.99)
INSERT INTO produto VALUES(7, 'Teclado', 4, 25.99)
INSERT INTO produto VALUES(8, 'Placa de Video - Nvidia 9800 GTX - 256MB/256 bits', 5, 599.99)
INSERT INTO venda VALUES(1,	1,	'251865337-10',	1,	449.99,	'2009-3-9')
INSERT INTO venda VALUES(1,	4,	'251865337-10',	1,	49.99,	'2009-3-9')
INSERT INTO venda VALUES(1,	5,	'251865337-10',	1,	349.99,	'2009-3-9')
INSERT INTO venda VALUES(2,	6,	'791826398-00',	4,	79.96,	'2009-6-9')
INSERT INTO venda VALUES(3,	8,	'876273154-16',	1,	599.99,	'2009-6-9')
INSERT INTO venda VALUES(3,	3,	'876273154-16',	1,	99.99,	'2009-6-9')
INSERT INTO venda VALUES(3,	7,	'876273154-16',	1,	25.99,	'2009-6-9')
INSERT INTO venda VALUES(4,	2,	'345789092-90',	2,	1399.98,	'2009-8-9')
GO
SELECT * FROM cliente
SELECT * FROM fornecedor
SELECT * FROM produto
SELECT * FROM venda

-- 1. Consultar no formato dd/mm/aaaa:	Data da Venda 4		
SELECT 
    FORMAT(data, 'dd/MM/yyyy') AS data_formatada
FROM 
    venda
WHERE 
    codigo = 4;

-- 2. Inserir na tabela Fornecedor, a coluna Telefone e os seguintes dados:			
-- 1	7216-5371		
-- 2	8715-3738		
-- 4	3654-6289	
ALTER TABLE fornecedor
ADD Telefone VARCHAR(15);
GO
UPDATE fornecedor
SET Telefone = '7216-5371'
WHERE id = 1;
GO
UPDATE fornecedor
SET Telefone = '8715-3738'	
WHERE id = 2;
GO
UPDATE fornecedor
SET Telefone = '3654-6289'
WHERE id = 3
GO
SELECT * FROM fornecedor

-- 3. Consultar por ordem alfabética de nome, o nome, o enderço concatenado e o telefone dos fornecedores						
SELECT
	fornecedor.nome AS nome_forncedor,
	CONCAT(fornecedor.cidade, ', ', fornecedor.logradouro, ', ', fornecedor.numero, ', ', fornecedor.complemento) AS endereco,
	fornecedor.Telefone AS telefone
FROM
	fornecedor
WHERE fornecedor.id > 0
ORDER BY fornecedor.nome

-- 4. Produto, quantidade e valor total do comprado por Julio Cesar				
SELECT
	venda.valor_total AS valor,
	venda.quantidade AS quantidade,
	produto.descricao AS produto
FROM venda
INNER JOIN produto ON produto.codigo = venda.produto
INNER JOIN cliente ON cliente.CPF = venda.cliente
WHERE cliente.nome LIKE '%Julio Cesar%'

-- 5. Data, no formato dd/mm/aaaa e valor total do produto comprado por  Paulo Cesar						
SELECT
	FORMAT(venda.data, 'dd/mm/yyyy') AS Data,
	venda.valor_total AS valor
FROM venda
INNER JOIN cliente ON cliente.CPF = venda.cliente
WHERE cliente.nome LIKE '%Paulo Cesar%'

-- 6. Consultar, em ordem decrescente, o nome e o preço de todos os produtos 						
SELECT
	produto.descricao AS nome,
	produto.preco AS preco
FROM produto
WHERE produto.descricao != ''
ORDER BY produto.descricao