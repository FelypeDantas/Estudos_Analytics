CREATE DATABASE locadora;
GO
USE locadora;
GO
CREATE TABLE filme(
id		INT			NOT NULL,
titulo  VARCHAR(40)	NOT NULL,
ano		INT			NULL CHECK(ano <= 2021) -- Verifica se o ano do filme é menor igual a 2021
PRIMARY KEY(id)
)
GO
CREATE TABLE estrela(
id		INT				NOT NULL,
nome	VARCHAR(50)		NOT NULL
PRIMARY KEY(id)
)
GO
CREATE TABLE filme_estrela(
filme_id		INT		NOT NULL,
estrela_id		INT		NOT NULL
PRIMARY KEY(filme_id, estrela_id)
FOREIGN KEY(filme_id) REFERENCES filme(id),
FOREIGN KEY(estrela_id) REFERENCES estrela(id)
)
GO
CREATE TABLE dvd(
num					INT     NOT NULL,
data_fabricacao		DATE	NOT NULL CHECK(data_fabricacao < GETDATE()),
filme_id			INT		NOT NULL
PRIMARY KEY(num)
FOREIGN KEY(filme_id) REFERENCES filme(id)
)
GO
CREATE TABLE cliente(
num_cadastro		INT				NOT NULL,
nome				VARCHAR(70)		NOT NULL,
logradouro			VARCHAR(150)	NOT NULL,
num					INT				NOT NULL CHECK(NUM > 0),
cep					CHAR(8)			NULL CHECK(LEN(cep) = 8)
PRIMARY KEY(num_cadastro)
)
GO
CREATE TABLE locacao(
dvd_num			INT				NOT NULL,
cliente_num		INT				NOT NULL,
data_locacao	DATE			NOT NULL DEFAULT(CONVERT(DATE, GETDATE(), 103)),
data_devolucao	DATE			NOT NULL,
valor			DECIMAL(7,2)	NOT NULL CHECK(valor > 0)
PRIMARY KEY(dvd_num, cliente_num,data_locacao),
FOREIGN KEY(dvd_num) REFERENCES dvd(num),
FOREIGN KEY(cliente_num) REFERENCES cliente(num_cadastro),
CONSTRAINT dt_dev_maior_dt_locacao
								CHECK(data_devolucao > data_locacao)
)
---------------------
GO
ALTER TABLE estrela
ADD nome_real VARCHAR(80) NULL;
GO
ALTER TABLE filme
ALTER COLUMN titulo VARCHAR(80) NOT NULL;
-----------------------------------------
INSERT INTO filme VALUES
(1001, 'Whiplash', 2015),
(1002, 'Birdman', 2015),
(1003, 'Interestelar',2014),
(1004, 'A Culpa é das estrelas',2014),
(1005, 'Alexandre e o Dia Terrível, Horrível, Espantoso e Horrosso',2014),
(1006, 'Sing', 2016)
GO
INSERT INTO estrela VALUES
(9901, 'Michael Keaton', 'Michael John Douglas'),
(9902, 'Emma Stone', 'Emily Jean Stone'),
(9903, 'Miles Teller', NULL),
(9904, 'Steve Carell', 'Steven John Carell'),
(9905, 'Jennifer Garner', 'Jennifer Anne Garner')

GO
INSERT INTO filme_estrela VALUES
(1002, 9901),
(1002, 9902),
(1001, 9903),
(1005, 9904),
(1005, 9905)
GO
INSERT INTO dvd VALUES
(10001, '2020-12-02', 1001), 
(10002, '2019-10-18', 1002),
(10003, '2020-04-03', 1003),
(10004, '2020-12-02', 1001),
(10005, '2019-10-18', 1004),
(10006, '2020-04-03', 1002),
(10007, '2020-12-02', 1005),
(10008, '2019-10-18', 1002),
(10009, '2020-04-03', 1003)
---------------------------
GO
INSERT INTO cliente VALUES
(5501, 'Matilde Luz', 'Rua Síria', 150, '03086040'),
(5502, 'Carlos Carreiro', 'Rua Bartolomeu Aires',1250, '04419110'),
(5503, 'Daniel Ramalho', 'Rua Itajutiba', 169, NULL),
(5504, 'Roberta Bento', 'Rua Jayme Von Rosenburg', 36, NULL),
(5505, 'Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110')
---
GO
INSERT INTO locacao VALUES
(10001, 5502, '2021-02-18', '2021-02-21', 3.50),
(10009, 5502, '2021-02-18', '2021-02-21', 3.50),
(10002, 5503, '2021-02-18', '2021-02-19', 3.50),
(10002, 5505, '2021-02-20', '2021-02-23', 3.00),
(10004, 5505, '2021-02-20', '2021-02-23', 3.00),
(10005, 5505, '2021-02-20', '2021-02-23', 3.00),
(10001, 5501, '2021-02-24', '2021-02-26', 3.50),
(10008, 5501, '2021-02-24', '2021-02-26', 3.50)
----------------
GO
UPDATE cliente SET
cep = '08411150'
WHERE num_cadastro = 5503
GO
UPDATE cliente SET
cep = '02918190'
WHERE num_cadastro = 5504
GO
UPDATE locacao SET
valor = 3.25
WHERE cliente_num = 5502 AND data_locacao = '2021-02-18'
GO
UPDATE locacao SET
valor = 3.10
WHERE cliente_num = 5501 AND data_locacao = '2021-02-24'
GO
UPDATE dvd SET
data_fabricacao = '2019-07-14'
WHERE num = 10005
GO
UPDATE estrela SET
nome_real = 'Miles Alexander Teller'
WHERE nome = 'Miles Teller'
GO
DELETE from filme
WHERE titulo = 'Sing'
-----------------------

GO
SELECT titulo AS filmes_de_2014 from filme 
WHERE ano = 2014
GO
SELECT id, ano from filme
WHERE titulo LIKE 'Birdman%'
GO
SELECT id,ano from filme
WHERE titulo LIKE '%plash'
GO
SELECT id,nome,nome_real from estrela
WHERE nome LIKE 'Steve%'
GO
SELECT filme_id,
CONVERT(CHAR(10),data_fabricacao, 103) as fab
from dvd
WHERE data_fabricacao > '2019-12-31'
GO
SELECT dvd_num,
data_locacao,
data_devolucao,
valor,
valor+2.00 as multa_acrescimo FROM locacao
WHERE cliente_num = 5505
GO
SELECT logradouro, num , cep from cliente
WHERE nome = 'Matilde Luz'
GO
SELECT nome_real from estrela
WHERE nome = 'Michael Keaton'
GO
SELECT num_cadastro, nome, 
logradouro + ', N° ' + CAST(num as varchar) + ', CEP ' + CAST(cep as varchar) as end_comp
FROM cliente
WHERE num_cadastro >= 550