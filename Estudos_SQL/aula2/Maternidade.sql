CREATE DATABASE maternidade
GO
USE maternidade
GO
CREATE TABLE mae (
IDmae           INT            NOT NULL    IDENTITY(1001, 1),
nome            VARCHAR(60)    NOT NULL,
logradouro      VARCHAR(100)   NOT NULL,
numero          INT            NOT NULL    CHECK(numero > 0),
CEP             CHAR(8)        NOT NULL    CHECK(LEN(CEP) = 8),
complemento     VARCHAR(200)   NOT NULL,
telefone        CHAR(10)       NOT NULL    CHECK(LEN(telefone) = 10),
data_nasc       DATE           NOT NULL
PRIMARY KEY(IDmae)
)
GO
CREATE TABLE medico (
CRMnumero            INT             NOT NULL,
CRMUF                CHAR(2)         NOT NULL,
nome                 VARCHAR(60)     NOT NULL,
telefone_celular     CHAR(11)        NOT NULL   CHECK(LEN(telefone_celular) = 11) UNIQUE,
especialidade        VARCHAR(30)     NOT NULL
PRIMARY KEY(CRMnumero, CRMUF)
)
GO
CREATE TABLE bebe (
IDbebe         INT            NOT NULL    IDENTITY(1, 1),
nome           VARCHAR(60)    NOT NULL,
datanasc      DATE           NOT NULL    DEFAULT('2024-09-10'),
altura         DECIMAL(7,2)   NOT NULL    CHECK(altura > 0),
peso           DECIMAL(4,3)   NOT NULL    CHECK(altura > 0),
maeIDmae      INT            NOT NULL
PRIMARY KEY(IDbebe),
FOREIGN KEY(maeIDmae) REFERENCES mae(IDmae)
)
GO
CREATE TABLE bebe_medico (
bebeIDbebe       INT       NOT NULL,
medicoCRMnumero  INT       NOT NULL,
medicoCRMUF      CHAR(2)   NOT NULL
PRIMARY KEY(bebeIDbebe, medicoCRMnumero, medicoCRMUF)
FOREIGN KEY(bebeIDbebe) REFERENCES bebe(IDbebe),
FOREIGN KEY(medicoCRMnumero, medicoCRMUF) REFERENCES medico(CRMnumero, CRMUF) 
)
GO
SELECT * FROM mae
SELECT * FROM medico
SELECT * FROM bebe
SELECT * FROM bebe_medico

--INSERCOES
INSERT INTO mae VALUES
('Maria Leda', 'Rua Pacajas', 212, '08421110', 'Casa 01', '2938239197', '1990-11-02')