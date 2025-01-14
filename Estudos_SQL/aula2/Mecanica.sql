CREATE DATABASE mecanica
GO
USE mecanica
GO
CREATE TABLE peca (
ID          INT            NOT NULL,
nome        VARCHAR(30)    NOT NULL,
preco       DECIMAL(4,2)   NOT NULL,
estoque     INT            NOT NULL
PRIMARY KEY(ID)
)
GO
CREATE TABLE categoria(
ID          INT            NOT NULL,
categoria   VARCHAR(10)    NOT NULL,
valorHora   DECIMAL(4,2)   NOT NULL
PRIMARY KEY(ID)
)
GO
CREATE TABLE funcionario(
ID            INT              NOT NULL,
nome          VARCHAR(100)     NOT NULL,
logradouro    VARCHAR(200)     NOT NULL,
numero        INT              NOT NULL,
telefone      CHAR(11)         NOT NULL,
categoriaHab  VARCHAR(2)       NOT NULL,
categoriaID   INT              NOT NULL
PRIMARY KEY(ID),
FOREIGN KEY(categoriaID) REFERENCES categoria(ID)
)
GO
CREATE TABLE cliente(
ID            INT           NOT NULL,
nome          VARCHAR(100)  NOT NULL,
logradouro    VARCHAR(200)  NOT NULL,
numero        INT           NOT NULL,
CEP           CHAR(8)       NOT NULL,
complemento   VARCHAR(255)  NOT NULL
PRIMARY KEY(ID)
)
GO
CREATE TABLE telefone (
IDcliente    INT            NOT NULL,
telefone     VARCHAR(11)    NOT NULL
PRIMARY KEY(IDcliente, telefone),
FOREIGN KEY(IDcliente) REFERENCES cliente(ID)
)
GO
CREATE TABLE veiculo(
placa            CHAR(7)     NOT NULL,
marca            VARCHAR(30) NOT NULL,
modelo           VARCHAR(30) NOT NULL,
cor              VARCHAR(15) NOT NULL,
anoFabricacao    INT         NOT NULL,
anoModelo        INT         NOT NULL,
dataAquisicao    DATE        NOT NULL,
clienteID        INT         NOT NULL,
PRIMARY KEY(placa),
FOREIGN KEY(clienteID) REFERENCES cliente(ID)
)
GO
CREATE TABLE reparo(
veiculoPlaca     CHAR(7)       NOT NULL,
funcionarioID    INT           NOT NULL,
pecaID           INT           NOT NULL,
dataReparo       DATE          NOT NULL,
custoTotal       DECIMAL(4,2)  NOT NULL,
tempo            INT           NOT NULL
PRIMARY KEY(veiculoPlaca, funcionarioID, pecaID, dataReparo),
FOREIGN KEY(veiculoPlaca) REFERENCES veiculo(placa),
FOREIGN KEY (funcionarioID) REFERENCES funcionario(ID),
FOREIGN KEY(pecaID) REFERENCES peca(ID)
)

SELECT * FROM peca
SELECT * FROM categoria
SELECT * FROM funcionario
SELECT * FROM cliente
SELECT * FROM telefone
SELECT * FROM veiculo
SELECT * FROM reparo