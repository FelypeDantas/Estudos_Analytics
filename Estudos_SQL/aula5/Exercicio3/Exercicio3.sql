CREATE DATABASE exercicio3
GO
USE exercicio3
GO
CREATE TABLE paciente(
cpf					VARCHAR(11)			NOT NULL,
nome				VARCHAR(150)		NOT NULL,
rua					VARCHAR(100)		NOT NULL,
numero				INT					NOT NULL,
bairro				VARCHAR(100)		NOT NULL,
telefone			CHAR(8)				NULL,
data_nasc			DATE				NOT NULL
PRIMARY KEY(cpf)
)
GO
CREATE TABLE medico(
codigo				INT					NOT NULL,
nome				VARCHAR(150)		NOT NULL,
especialidade		VARCHAR(100)		NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE prontuario(
dataProntuario		DATE				NOT NULL,
CPF_Paciente		VARCHAR(11)			NOT NULL,
codigo_medico		INT					NOT NULL,
diagnostico			VARCHAR(100)		NOT NULL,
medicamento			VARCHAR(120)		NOT NULL
PRIMARY KEY(dataProntuario, CPF_Paciente, codigo_medico)
FOREIGN KEY (CPF_Paciente) REFERENCES paciente(cpf),
FOREIGN KEY (codigo_medico) REFERENCES medico(codigo)
)
GO
INSERT INTO paciente VALUES('35454562890', 'José Rubens', 'Campos Salles', 2750, 'Centro', '21450998', '1954-10-18')
INSERT INTO paciente VALUES('29865439810', 'Ana Claudia', 'Sete de Setembro', 178, 'Centro', '97382764', '1960-05-29')
INSERT INTO paciente VALUES('82176534800', 'Marcos Aurélio', 'Timóteo Penteado', 236, 'Vila Galvão', '68172651', '1980-09-24')
INSERT INTO paciente VALUES('12386758770', 'Maria Rita', 'Castello Branco', 7765, 'Vila Rosália', NULL, '1975-03-30')
INSERT INTO paciente VALUES('92173458910', 'Joana de Souza', 'XV de Novembro', 298, 'Centro', '21276578', '1944-04-24')
INSERT INTO medico VALUES(1, 'Wilson Cesar', 'Pediatra')
INSERT INTO medico VALUES(2, 'Marcia Matos', 'Geriatra')
INSERT INTO medico VALUES(3, 'Carolina Oliveira', 'Ortopedista')
INSERT INTO medico VALUES(4, 'Vinicius Araujo', 'Clínico Geral')
INSERT INTO prontuario VALUES('2020-09-10', '35454562890', 2, 'Reumatismo', 'Celebra')
INSERT INTO prontuario VALUES('2020-09-10', '92173458910', 2, 'Renite Alérgica', 'Allegra')
INSERT INTO prontuario VALUES('2020-09-12', '29865439810', 1, 'Inflamação de garganta', 'Nimesulida')
INSERT INTO prontuario VALUES('2020-09-13', '35454562890', 2, 'H1N1', 'Tamiflu')
INSERT INTO prontuario VALUES('2020-09-15', '82176534800', 4, 'Gripe', 'Resprin')
INSERT INTO prontuario VALUES('2020-09-15', '12386758770', 3, 'Braço Quebrado', 'Dorflex + Gesso')
GO
SELECT * FROM paciente
SELECT * FROM medico
SELECT * FROM prontuario

-- 1. Nome e Endereço (concatenado) dos pacientes com mais de 50 anos				
SELECT
	paciente.nome AS nome,
	CONCAT(paciente.bairro, ', ', paciente.rua, ', ', paciente.numero) AS endereco
FROM paciente
WHERE DATEDIFF(YEAR, paciente.data_nasc, GETDATE()) < 50

-- 2. Qual a especialidade de Carolina Oliveira		
SELECT
	medico.especialidade AS especialidade
FROM medico
WHERE medico.nome LIKE '%Carolina Oliveira'

-- 3. Qual medicamento receitado para reumatismo			
SELECT
	prontuario.medicamento AS medicamento
FROM prontuario
WHERE prontuario.diagnostico LIKE '%reumatismo%'
