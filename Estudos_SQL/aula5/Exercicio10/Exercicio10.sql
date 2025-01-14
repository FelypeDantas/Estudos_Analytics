CREATE DATABASE exercicio10
GO
USE exercicio10
GO
CREATE TABLE medicamentos(
codigo								INT							IDENTITY(1,1),
nome								VARCHAR(160)				NOT NULL,
apresentacao						VARCHAR(100)				NOT NULL,
unidade_de_cadastro					VARCHAR(90)					NOT NULL,
preco_proposto						DECIMAL(10, 3)				NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE cliente(
CPF									CHAR(11)					NOT NULL,
nome								VARCHAR(150)				NOT NULL,
rua									VARCHAR(100)				NOT NULL,
numero								INT							NOT NULL,
bairro								VARCHAR(80)					NOT NULL,
telefone							INT							NOT NULL
PRIMARY KEY(CPF)
)
GO
CREATE TABLE venda(
nota_fiscal							INT							NOT NULL,
CPF_do_cliente						CHAR(11)					NOT NULL,
codigo_medicamentos					INT							NOT NULL,
qtd									INT							NOT NULL,
valor								DECIMAL(10, 2)				NOT NULL,
data								DATE						NOT NULL
PRIMARY KEY(nota_fiscal, CPF_do_cliente, codigo_medicamentos)
FOREIGN KEY(codigo_medicamentos) REFERENCES medicamentos(codigo),
FOREIGN KEY(CPF_do_cliente) REFERENCES cliente(CPF)
)
GO
INSERT INTO medicamentos VALUES('Acetato de medroxiprogesterona', ' 150 mg/ml', ' Ampola', 6.700)
INSERT INTO medicamentos VALUES('Aciclovir', ' 200mg/comp.',  'Comprimido', 0.280)
INSERT INTO medicamentos VALUES('Ácido Acetilsalicílico', '500mg/comp.', 'Comprimido', 0.035)
INSERT INTO medicamentos VALUES('Ácido Acetilsalicílico', '100mg/comp.', 'Comprimido', 0.030)
INSERT INTO medicamentos VALUES('Ácido Fólico', '5mg/comp.', 'Comprimido', 0.054)
INSERT INTO medicamentos VALUES('Albendazol', '400mg/comp. mastigável', 'Comprimido', 0.560)
INSERT INTO medicamentos VALUES('Alopurinol', '100mg/comp.', 'Comprimido', 0.080)
INSERT INTO medicamentos VALUES('Amiodarona', '200mg/comp.', 'Comprimido', 0.200)
INSERT INTO medicamentos VALUES('Amitriptilina(Cloridrato)', '25mg/comp.', 'Comprimido', 0.220)
INSERT INTO medicamentos VALUES('Amoxicilina', '500mg/cáps.', 'Cápsula', 0.190)
INSERT INTO cliente VALUES('34390898700', 'Maria Zélia', 'Anhaia', 65, 'Barra Funda', 92103762)
INSERT INTO cliente VALUES('21345986290', 'Roseli Silva', 'Xv. De Novembro', 987, 'Centro', 82198763)
INSERT INTO cliente VALUES('86927981825', 'Carlos Campos', 'Voluntários da Pátria', 1276, 'Santana', 98172361)
INSERT INTO cliente VALUES('31098120900', 'João Perdizes', 'Carlos de Campos', 90, 'Pari', 61982371)
INSERT INTO venda VALUES(31501, '86927981825', 10, 3, 0.57, '2020-11-01')
INSERT INTO venda VALUES(31501, '86927981825', 2, 10, 2.8, '2020-11-01')
INSERT INTO venda VALUES(31501, '86927981825', 5, 30, 1.05, '2020-11-01')
INSERT INTO venda VALUES(31501, '86927981825', 8, 30, 6.6, '2020-11-01')
INSERT INTO venda VALUES(31502, '34390898700', 8, 15, 3, '2020-11-01')
INSERT INTO venda VALUES(31502, '34390898700', 2, 10, 2.8, '2020-11-01')
INSERT INTO venda VALUES(31502, '34390898700', 9, 10, 2.2, '2020-11-01')
INSERT INTO venda VALUES(31503, '31098120900', 1, 20, 134, '2020-11-02')
GO
SELECT * FROM medicamentos
SELECT * FROM cliente
SELECT * FROM venda

-- Nome, apresentação, unidade e valor unitário dos remédios que ainda não foram vendidos. Caso a unidade de cadastro seja comprimido, mostrar Comp.							
SELECT
	medicamentos.nome AS [NOME DO MEDICAMENTO],
	medicamentos.apresentacao AS [APRESENTAÇÃO],
	CASE
		WHEN medicamentos.unidade_de_cadastro = 'Comprimido' THEN 'Comp.'
		ELSE medicamentos.unidade_de_cadastro
	END AS [UNIDADE],
	medicamentos.preco_proposto AS [valor unitário]
FROM medicamentos
RIGHT OUTER JOIN venda ON venda.codigo_medicamentos = medicamentos.codigo

-- Nome dos clientes que compraram Amiodarona		
SELECT
	cliente.nome AS [nome do cliente]
FROM cliente
INNER JOIN venda ON venda.CPF_do_cliente = cliente.CPF
INNER JOIN medicamentos ON medicamentos.codigo = venda.codigo_medicamentos
WHERE medicamentos.nome LIKE '%Amiodarona%'

-- CPF do cliente, endereço concatenado, nome do medicamento (como nome de remédio),  
-- apresentação do remédio, unidade, preço proposto, quantidade vendida e valor total dos remédios
-- vendidos a Maria Zélia											
SELECT
	cliente.CPF AS [CPF do Cliente],
	CONCAT(cliente.bairro, ', ', cliente.rua, ', ', cliente.numero) AS [Endereço],
	medicamentos.nome AS [nome dos medicamentos],
	medicamentos.apresentacao AS [Apresentação do medicamento],
	medicamentos.unidade_de_cadastro AS [unidade de medicamento],
	medicamentos.preco_proposto AS [preço proposto],
	venda.qtd AS [Quantidade vendidas],
	venda.valor AS [valor total]
FROM cliente
INNER JOIN venda ON venda.CPF_do_cliente = cliente.CPF
INNER JOIN medicamentos ON medicamentos.codigo = venda.codigo_medicamentos
WHERE cliente.nome LIKE '%Maria Zélia%'

-- Data de compra, convertida, de Carlos Campos		
SELECT
	FORMAT(venda.data, 'dd/MM/yyyy') AS [data da compra]
FROM venda
INNER JOIN cliente ON cliente.CPF = venda.CPF_do_cliente
WHERE cliente.nome LIKE '%Carlos Campos%'

-- Alterar o nome da  Amitriptilina(Cloridrato) para Cloridrato de Amitriptilina			
UPDATE medicamentos
SET nome = 'Cloridrato de Amitriptilina'
WHERE nome = 'Amitriptilina (Cloridrato)'
