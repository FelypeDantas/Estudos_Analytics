CREATE DATABASE exercicio1
GO
USE exercicio1
GO
CREATE TABLE aluno(
RA				INT					NOT NULL,
nome			VARCHAR(80)			NOT NULL,
sobrenome		VARCHAR(80)			NOT NULL,
rua				VARCHAR(150)		NOT NULL,
numero			INT					NOT NULL,
bairro			VARCHAR(100)		NOT NULL,
CEP				INT					NOT NULL,
telefone		CHAR(8)				NOT NULL
PRIMARY KEY(RA)
)
GO
CREATE TABLE curso(
codigo			INT				NOT NULL,
nome			VARCHAR(30)		NOT NULL,
cargaHoraria	INT				NOT NULL,
turno			CHAR(5)			NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE disciplina(
codigo			INT				NOT NULL,
nome			VARCHAR(30)		NOT NULL,
cargaHoraria	INT				NOT NULL,
turno			CHAR(5)			NOT NULL,
semestre		INT				NOT NULL
PRIMARY KEY(codigo)
)
GO
INSERT INTO aluno VALUES(12345,'Jose','Silva','Almirante Noronha',236,'Jardim São Paulo',1589000,'69875287')
INSERT INTO aluno VALUES(12346,'Ana','Maria Bastos','Anhaia',1568,'Barra Funda',3569000,'25698526')
INSERT INTO aluno VALUES(12347,'Mario','Santos','XV de Novembro',1841,'Centro',1020030,'')
INSERT INTO aluno VALUES(12348,'Marcia','Neves','Voluntários da Patria',255,'Santana',2785090,'78964152')
INSERT INTO curso VALUES(1,'Informática',2800,'Tarde')
INSERT INTO curso VALUES(2,'Informática',2800,'Noite')
INSERT INTO curso VALUES(3,'Logistica',2650,'Tarde')
INSERT INTO curso VALUES(4,'Logistica',2650,'Noite')
INSERT INTO curso VALUES(5,'Plásticos',2500,'Tarde')
INSERT INTO curso VALUES(6,'Plásticos',2500,'Noite')
INSERT INTO disciplina VALUES(1,'Informática',4,'Tarde',1)
INSERT INTO disciplina VALUES(2,'Informática',4,'Noite',1)
INSERT INTO disciplina VALUES(3,'Quimica',4,'Tarde',1)
INSERT INTO disciplina VALUES(4,'Quimica',4,'Noite',1)
INSERT INTO disciplina VALUES(5,'Banco de Dados I',2,'Tarde',3)
INSERT INTO disciplina VALUES(6,'Banco de Dados I',2,'Noite',3)
INSERT INTO disciplina VALUES(7,'Estrutura de Dados',4,'Tarde',4)
INSERT INTO disciplina VALUES(8,'Estrutura de Dados',4,'Noite',4)
GO
SELECT * FROM aluno
SELECT * FROM curso
SELECT * FROM disciplina

-- 1. Nome e sobrenome, como nome completo dos Alunos Matriculados
SELECT
	CONCAT(aluno.nome, ' ', aluno.sobrenome) AS Nome_Completo
FROM aluno

-- 2. Rua, nº , Bairro e CEP como Endereço do aluno que não tem telefone				
SELECT
	aluno.rua AS rua,
	aluno.numero AS numero,
	aluno.bairro AS bairro,
	aluno.CEP AS CEP
FROM aluno
WHERE aluno.telefone = ''

-- 3. Telefone do aluno com RA 12348		
SELECT
	aluno.telefone
FROM aluno
WHERE aluno.RA LIKE '%12348%'

-- 4. Nome e Turno dos cursos com 2800 horas			
SELECT
	curso.nome,
	curso.turno
FROM curso
WHERE curso.cargaHoraria LIKE '%2800%'

-- 5. O semestre do curso de Banco de Dados I noite			
SELECT
	disciplina.semestre
FROM disciplina
WHERE disciplina.codigo = 6
