CREATE DATABASE Clinica_veterinaria
GO
USE Clinica_veterinaria
GO
CREATE TABLE cliente (
idCliente			INT						NOT NULL,
nome				VARCHAR(150)			NOT NULL,
CPF					CHAR(11)				NOT NULL,
telefone			CHAR(11)				NOT NULL,
email				VARCHAR(100)			NOT NULL,
rua					VARCHAR(200)			NOT NULL,
bairro				VARCHAR(90)				NOT NULL,
cidade				VARCHAR(60)				NOT NULL,
estado				VARCHAR(20)				NOT NULL,
numero				INT						NOT NULL,
complemento			VARCHAR(100)			NULL
PRIMARY KEY (idCliente)
)
GO
CREATE TABLE animal (
idAnimal			INT						NOT NULL,
nome				VARCHAR(150)			NOT NULL,
tipo				VARCHAR(100)			NOT NULL,
enfermidades		VARCHAR(120)			NOT NULL,
idCliente			INT						NOT NULL
PRIMARY KEY(idAnimal),
FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
)
GO
CREATE TABLE veterinario (
idVeterinario		INT						NOT NULL,
nome				VARCHAR(150)			NOT NULL,
CRMV				VARCHAR(10)				NOT NULL,
telefone			CHAR(11)				NOT NULL,
email				VARCHAR(100)			NOT NULL
PRIMARY KEY(idVeterinario)
)
GO
CREATE TABLE atendimento (
idAnimal			INT						NOT NULL,
numVeterianarios	INT						NOT NULL,
idVeterinario		INT						NOT NULL
PRIMARY KEY(idAnimal, idVeterinario),
FOREIGN KEY (idAnimal) REFERENCES animal(idAnimal),
FOREIGN KEY (idVeterinario) REFERENCES veterinario(idVeterinario)
)
GO
-- Inserindo clientes
INSERT INTO cliente (idCliente, nome, CPF, telefone, email, rua, bairro, cidade, estado, numero, complemento)
VALUES 
(1, 'Ana Souza', '12345678901', '11987654321', 'ana@email.com', 'Rua das Flores', 'Centro', 'São Paulo', 'SP', 100, 'Apto 202'),
(2, 'Carlos Lima', '98765432100', '21987654321', 'carlos@email.com', 'Av. Brasil', 'Copacabana', 'Rio de Janeiro', 'RJ', 500, NULL),
(3, 'Mariana Costa', '11122233344', '31987654321', 'mariana@email.com', 'Rua das Palmeiras', 'Savassi', 'Belo Horizonte', 'MG', 250, 'Casa 2');

-- Inserindo animais
INSERT INTO animal (idAnimal, nome, tipo, enfermidades, idCliente)
VALUES 
(1, 'Rex', 'Cachorro', 'Nenhuma', 1),
(2, 'Mingau', 'Gato', 'Alergia', 2),
(3, 'Bolinha', 'Coelho', 'Problema dentário', 3);

-- Inserindo veterinários
INSERT INTO veterinario (idVeterinario, nome, CRMV, telefone, email)
VALUES 
(1, 'Dr. João Silva', 'SP12345', '11999998888', 'joao.silva@email.com'),
(2, 'Dra. Fernanda Rocha', 'RJ54321', '21999997777', 'fernanda.rocha@email.com');

-- Inserindo atendimentos
INSERT INTO atendimento (idAnimal, numVeterianarios, idVeterinario)
VALUES 
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(3, 2, 2);

-- CONSULTAS

-- selecione todos os clientes cadastrados.
SELECT * FROM cliente

-- Liste apenas os nomes e e-mails dos veterinários.
SELECT email FROM veterinario

-- Selecione os animais que pertencem ao cliente com idCliente = 1
SELECT 
	cliente.idCliente as id_cliente,
	animal.nome	as nome_animal
FROM cliente
INNER JOIN animal ON animal.idCliente = cliente.idCliente
WHERE cliente.idCliente = 1

-- Mostre os clientes que moram no estado de 'SP'.
SELECT * FROM cliente
WHERE estado = 'SP'

-- Liste os nomes dos animais e seus respectivos donos.
SELECT
	animal.nome as [nome do pet],
	animal.idCliente as [id do cliente],
	cliente.nome as [nome do cliente]
FROM animal
INNER JOIN cliente ON cliente.idCliente = animal.idCliente

-- Encontre todos os atendimentos realizados pelo veterinário com idVeterinario = 2.
SELECT * FROM atendimento
INNER JOIN veterinario ON veterinario.idVeterinario = atendimento.idVeterinario
WHERE veterinario.idVeterinario = 2

-- Liste os clientes que possuem um telefone que começa com '11'.
SELECT * FROM cliente
WHERE telefone LIKE '11%'

-- Mostre o nome dos veterinários que atenderam mais de um animal.
SELECT v.nome, COUNT(a.idAnimal) AS Total_Atendimentos
FROM atendimento atd
INNER JOIN veterinario v ON atd.idVeterinario = v.idVeterinario
INNER JOIN animal a ON atd.idAnimal = a.idAnimal
GROUP BY v.nome
HAVING COUNT(atd.idAnimal) > 1;

-- Liste os clientes que têm pelo menos um animal cadastrado.
SELECT DISTINCT c.nome 
FROM cliente c
INNER JOIN animal a ON c.idCliente = a.idCliente;

-- Mostre os animais que nunca tiveram atendimento registrado.
SELECT a.nome 
FROM animal a
LEFT JOIN atendimento atd ON a.idAnimal = atd.idAnimal
WHERE atd.idAnimal IS NULL;

