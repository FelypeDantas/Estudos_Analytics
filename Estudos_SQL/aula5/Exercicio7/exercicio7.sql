CREATE DATABASE exercicio7
GO
USE exercicio7
GO
CREATE TABLE clientes(
rg				VARCHAR(9)				NOT NULL,
cpf				VARCHAR(11)				NOT NULL,
nome			VARCHAR(100)			NOT NULL,
logradouro		VARCHAR(80)				NOT NULL,
numero			INT						NOT NULL
PRIMARY KEY(rg)
)
GO
CREATE TABLE pedido(
nota_fiscal		INT						IDENTITY(1001, 1),
valor			INT						NOT NULL,
data			DATE					NOT NULL,
rg_Cliente		VARCHAR(9)				NOT NULL
PRIMARY KEY(nota_fiscal)
FOREIGN KEY(rg_Cliente) REFERENCES clientes(rg)
)
GO
CREATE TABLE _fornecedor(
codigo			INT						IDENTITY(1,1),
nome			VARCHAR(30)				NOT NULL,
logradouro		VARCHAR(100)			NOT NULL,
numero			INT						NULL,
pais			VARCHAR(5)				NOT NULL,
area			INT						NOT NULL,
telefone		INT						NULL,
cnpj			INT						NULL,
cidade			VARCHAR(40)				NULL,
transporte		VARCHAR(30)				NULL,
moeda			VARCHAR(5)				NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE mercadoria(
codigo			INT						IDENTITY(10,1),
descricao		VARCHAR(60)				NOT NULL,
preco			INT						NOT NULL,
quantidade		INT						NOT NULL,
cod_Fornecedor	INT						NOT NULL
PRIMARY KEY(codigo)
FOREIGN KEY(cod_Fornecedor) REFERENCES _fornecedor(codigo)
)
GO
INSERT INTO clientes VALUES('29531844', '34519878040', 'Luiz André', 'R. Astorga', 500)
INSERT INTO clientes VALUES('13514996x', '84984285630', 'Maria Luiza', 'R. Piauí', 174)
INSERT INTO clientes VALUES('121985541', '23354997310', 'Ana Barbara', 'Av. Jaceguai', 1141)
INSERT INTO clientes VALUES('23987746x', '43587669920', 'Marcos Alberto', 'R. Quinze', 22)
INSERT INTO pedido VALUES(754, '2018-04-01', '121985541')
INSERT INTO pedido VALUES(350, '2018-04-02', '121985541')
INSERT INTO pedido VALUES(30, '2018-04-02', '29531844')
INSERT INTO pedido VALUES(1500, '2018-04-03', '13514996x')
INSERT INTO _fornecedor VALUES('Clone',	'Av. Nações Unidas, 12000', 12000, 'BR', 55, 1141487000, NULL, 'São Paulo', NULL, 'R$')
INSERT INTO _fornecedor VALUES('Logitech', '28th Street, 100', 100, 'USA', 1, 2127695100, NULL, NULL, 'Avião', 'US$')
INSERT INTO _fornecedor VALUES('LG', 'Rod. Castello Branco', NULL, 'BR', 55, 800664400, '4159978100001', 'Sorocaba', NULL, 'R$')
INSERT INTO _fornecedor VALUES('PcChips', 'Ponte da Amizade', NULL, 'PY', 595, NULL, NULL, NULL, 'Navio', 'US$')
INSERT INTO mercadoria VALUES('Mouse', 24, 30, 1)
INSERT INTO mercadoria VALUES('Teclado', 50, 20, 1)
INSERT INTO mercadoria VALUES('Cx. De Som', 30, 8, 2)
INSERT INTO mercadoria VALUES('Monitor 17', 350, 4, 3)
INSERT INTO mercadoria VALUES('Notebook', 1500, 7, 4)
GO
SELECT * FROM clientes
SELECT * FROM pedido
SELECT * FROM _fornecedor
SELECT * FROM mercadoria

ALTER TABLE _fornecedor
ALTER COLUMN cnpj VARCHAR(14);

-- Pede-se: (Quando o endereço concatenado não tiver número, colocar só o logradouro e o país, quando tiver colocar, também o número)										
SELECT 
    CASE 
        WHEN _fornecedor.numero IS NULL OR _fornecedor.numero = '' THEN 
            _fornecedor.logradouro + ', ' + _fornecedor.pais 
        ELSE 
            _fornecedor.logradouro + ' ' + CAST(_fornecedor.numero AS VARCHAR(10)) + ', ' + _fornecedor.pais  
    END AS endereco_completo
FROM _fornecedor;

-- Nota: (CPF deve vir sempre mascarado no formato XXX.XXX.XXX-XX e RG Sempre com um traçao antes do último dígito (Algo como XXXXXXXX-X), mas alguns tem 8 e outros 9 dígitos)													
SELECT 
    -- Formatação do CPF
    CASE 
        WHEN LEN(CAST(clientes.cpf AS VARCHAR)) = 11 THEN 
            CONCAT(SUBSTRING(CAST(clientes.cpf AS VARCHAR), 1, 3), '.', 
                   SUBSTRING(CAST(clientes.cpf AS VARCHAR), 4, 3), '.', 
                   SUBSTRING(CAST(clientes.cpf AS VARCHAR), 7, 3), '-', 
                   SUBSTRING(CAST(clientes.cpf AS VARCHAR), 10, 2))
        ELSE 
            'CPF Inválido'
    END AS cpf_formatado
FROM clientes;

SELECT 
    -- Formatação do RG
    CASE 
        WHEN LEN(CAST(clientes.rg AS VARCHAR)) = 9 THEN 
            CONCAT(SUBSTRING(CAST(clientes.rg AS VARCHAR), 1, 8), '-', SUBSTRING(CAST(rg AS VARCHAR), 9, 1))
        WHEN LEN(CAST(clientes.rg AS VARCHAR)) = 8 THEN 
            CONCAT(SUBSTRING(CAST(clientes.rg AS VARCHAR), 1, 7), '-', SUBSTRING(CAST(rg AS VARCHAR), 8, 1))
        ELSE 
            'RG Inválido'
    END AS rg_formatado
FROM clientes;

-- Consultar 10% de desconto no pedido 1003		
SELECT
	pedido.valor - (pedido.valor * 0.10) AS desconto
FROM pedido
WHERE pedido.nota_fiscal = '1003'

-- Consultar 5% de desconto em pedidos com valor maior de R$700,00			
SELECT
	pedido.valor - (pedido.valor * 0.05) AS desconto
FROM
	pedido
WHERE pedido.valor > 700

-- Consultar e atualizar aumento de 20% no valor de marcadorias com estoque menor de 10					
SELECT
	mercadoria.descricao AS nome,
	mercadoria.quantidade AS qtd,
	mercadoria.preco + (mercadoria.preco * 0.20) AS preco
FROM mercadoria
WHERE mercadoria.quantidade < 10

-- Data e valor dos pedidos do Luiz		
SELECT
	pedido.data AS data,
	pedido.valor AS valor
FROM
	pedido
INNER JOIN
	clientes ON clientes.rg = pedido.rg_Cliente
WHERE clientes.nome LIKE '%Luiz%'

-- CPF, Nome e endereço concatenado do cliente de nota 1004			
SELECT
	clientes.cpf AS CPF,
	clientes.nome AS nome,
	CONCAT(clientes.logradouro, ', ', clientes.numero)
FROM clientes
INNER JOIN pedido ON pedido.rg_Cliente = clientes.rg
WHERE pedido.nota_fiscal = '1004'

-- País e meio de transporte da Cx. De som		
SELECT
	_fornecedor.pais AS pais,
	_fornecedor.transporte AS [Meio de Transporte]
FROM _fornecedor
INNER JOIN mercadoria ON mercadoria.cod_Fornecedor = _fornecedor.codigo
WHERE mercadoria.descricao = 'Cx. De som'

-- Nome e Quantidade em estoque dos produtos fornecidos pela Clone			
SELECT
	mercadoria.descricao AS [nome da mercadoria],
	mercadoria.quantidade AS [quantidade em estoque]
FROM mercadoria
INNER JOIN _fornecedor ON _fornecedor.codigo = mercadoria.cod_Fornecedor
WHERE _fornecedor.nome LIKE '%Clone%'

-- Endereço concatenado e telefone dos fornecedores do monitor. (Telefone brasileiro (XX)XXXX-XXXX ou XXXX-XXXXXX (Se for 0800), Telefone Americano (XXX)XXX-XXXX)												
SELECT 
    CONCAT(
        _fornecedor.pais, '-', _fornecedor.cidade, ', ', _fornecedor.logradouro, ', ', _fornecedor.numero
    ) AS Endereco_Completo,
    CASE
        WHEN CAST(telefone AS VARCHAR) LIKE '0800%' THEN CAST(telefone AS VARCHAR)
        WHEN LEN(CAST(telefone AS VARCHAR)) = 10 THEN CONCAT('(', LEFT(CAST(telefone AS VARCHAR), 2), ')', SUBSTRING(CAST(telefone AS VARCHAR), 3, 4), '-', RIGHT(CAST(telefone AS VARCHAR), 4))
        WHEN LEN(CAST(telefone AS VARCHAR)) = 11 THEN CONCAT('(', LEFT(CAST(telefone AS VARCHAR), 2), ')', SUBSTRING(CAST(telefone AS VARCHAR), 3, 5), '-', RIGHT(CAST(telefone AS VARCHAR), 4))
        WHEN LEN(CAST(telefone AS VARCHAR)) = 12 THEN CONCAT('+', LEFT(CAST(telefone AS VARCHAR), 1), '(', SUBSTRING(CAST(telefone AS VARCHAR), 2, 3), ')', SUBSTRING(CAST(telefone AS VARCHAR), 5, 3), '-', RIGHT(CAST(telefone AS VARCHAR), 4))
        ELSE CAST(telefone AS VARCHAR)
    END AS Telefone_Formatado
FROM 
    _fornecedor;

-- Tipo de moeda que se compra o notebook		
SELECT
	_fornecedor.moeda AS [tipo moeda],
	mercadoria.descricao AS [mercadoria]
FROM _fornecedor
INNER JOIN mercadoria ON mercadoria.cod_Fornecedor = _fornecedor.codigo
WHERE mercadoria.descricao LIKE '%notebook%'

-- Considerando que hoje é 03/02/2019, há quantos dias foram feitos os pedidos e, criar uma coluna que escreva Pedido antigo para pedidos feitos há mais de 6 meses e pedido recente para os outros														
SELECT
	pedido.nota_fiscal AS pedido,
	pedido.data AS data,
	DATEDIFF(DAY, pedido.data, '2019-02-03') AS [dias desde o pedido],
	CASE
		WHEN DATEDIFF(DAY, pedido.data, '2019-02-03') > 180 THEN 'Pedido Antigo'
		ELSE 'Pedido Recente'
	END AS tipoPedido
FROM pedido

-- Nome e Quantos pedidos foram feitos por cada cliente			
SELECT
    clientes.nome AS [nome do cliente],
    COUNT(pedido.nota_fiscal) AS [quantidade de pedidos]
FROM clientes
INNER JOIN pedido ON pedido.rg_Cliente = clientes.rg
WHERE pedido.nota_fiscal > 0
GROUP BY clientes.nome

-- RG,CPF,Nome e Endereço dos cliente cadastrados que Não Fizeram pedidos				
SELECT
    clientes.rg AS [RG],
    clientes.cpf AS [CPF],
    clientes.nome AS [Nome],
    CONCAT(clientes.logradouro, ',', clientes.numero) AS [Endereço]
FROM clientes
LEFT JOIN pedido ON pedido.rg_Cliente = clientes.rg
WHERE pedido.nota_fiscal IS NULL