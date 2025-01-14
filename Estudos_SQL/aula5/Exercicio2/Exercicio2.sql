CREATE DATABASE exercicio2
GO
USE exercicio2
GO
CREATE TABLE carro(
placa					CHAR(7)				NOT NULL,
marca					VARCHAR(15)			NOT NULL,
modelo					VARCHAR(15)			NOT NULL,
cor						VARCHAR(10)			NOT NULL,
ano						INT					NOT NULL
PRIMARY KEY(placa)
)
GO
CREATE TABLE pecas(
codigo					INT					NOT NULL,
nome					VARCHAR(40)			NOT NULL,
valor					INT					NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE servico(
carro					CHAR(7)				NOT NULL,
peca					INT					NOT NULL,
quantidade				INT					NOT NULL,
valor					INT					NOT NULL,
dia						DATE				NOT NULL
PRIMARY KEY(carro, peca, dia),
FOREIGN KEY (carro) REFERENCES carro(placa),
FOREIGN KEY (peca) REFERENCES pecas(codigo)
)
GO
CREATE TABLE cliente(
carro					CHAR(7)				NOT NULL,
nome					VARCHAR(150)		NOT NULL,
logradouro				VARCHAR(200)		NOT NULL,
numero					INT					NOT NULL,
bairro					VARCHAR(80)			NOT NULL,
telefone				CHAR(9)				NOT NULL
PRIMARY KEY(carro),
FOREIGN KEY (carro) REFERENCES carro(placa)
)
GO
INSERT INTO carro VALUES('AFT9087', 'VW', 'Gol', 'Preto', 2007)
INSERT INTO carro VALUES('DXO9876', 'Ford', 'Ka', 'Azul', 2000)
INSERT INTO carro VALUES('EGT4631', 'Renault', 'Clio', 'Verde', 2004)
INSERT INTO carro VALUES('LKM7380', 'Fiat', 'Palio', 'Prata', 1997)
INSERT INTO carro VALUES('BCD7521', 'Ford', 'Fiesta', 'Preto', 1999)
INSERT INTO pecas VALUES(1, 'Vela', 70)
INSERT INTO pecas VALUES(2, 'Correia Dentada', 125)
INSERT INTO pecas VALUES(3, 'Trambulador', 90)
INSERT INTO pecas VALUES(4, 'Filtro de ar', 30)
INSERT INTO servico VALUES('DXO9876', 1, 4, 280, '2020-08-01')
INSERT INTO servico VALUES('DXO9876', 4, 1, 30, '2020-08-01')
INSERT INTO servico VALUES('EGT4631', 3, 1, 90, '2020-08-02')
INSERT INTO servico VALUES('DXO9876', 2, 1, 125, '2020-08-07')
INSERT INTO cliente VALUES('DXO9876', 'João Alves',	'R.	Pereira Barreto', 1258, 'Jd. Oliveiras', '2154-9658')
INSERT INTO cliente VALUES('LKM7380', 'Ana Maria', 'R. 7 de Setembro', 259, 'Centro', '9658-8541')
INSERT INTO cliente VALUES('EGT4631', 'Clara Oliveira', 'Av. Nações Unidas', 10254, 'Pinheiros', '2458-9658')
INSERT INTO cliente VALUES('BCD7521', 'José Simões', 'R. XV de Novembro', 36, 'Água Branca', '7895-2459')
INSERT INTO cliente VALUES('AFT9087', 'Paula Rocha', 'R. Anhaia', 548, 'Barra Funda', '6958-2548')
GO
SELECT * FROM carro
SELECT * FROM pecas
SELECT * FROM servico
SELECT * FROM cliente

-- 1. Telefone do dono do carro Ka, Azul	
SELECT
	cliente.nome AS 'Nome Cliente',
	cliente.telefone AS telefone
FROM cliente
WHERE cliente.carro LIKE '%DXO9876%'

-- 2. Endereço concatenado do cliente que fez o serviço do dia 2020-08-02				
SELECT 
    CONCAT(cliente.logradouro, ', ', cliente.bairro, ', ', cliente.numero) AS endereco
FROM cliente
JOIN 
    servico ON cliente.carro = servico.carro
WHERE 
    servico.dia = CONVERT(DATE, '2020-08-02', 120);

-- 3. Placas dos carros de anos anteriores a 2001		
SELECT
	carro.ano AS ano,
	carro.placa AS placa
FROM carro
WHERE carro.ano < 2001
ORDER BY carro.ano

-- 5. Marca, modelo e cor, concatenado dos carros posteriores a 2005				
SELECT
	CONCAT(carro.marca, ', ', carro.modelo, ', ', carro.cor) AS carro
FROM carro
WHERE carro.ano > 2005

-- 6. Código e nome das peças que custam menos de R$80,00			
SELECT
	pecas.codigo AS codigo,
	pecas.nome AS nome
FROM pecas
WHERE pecas.valor < 80
