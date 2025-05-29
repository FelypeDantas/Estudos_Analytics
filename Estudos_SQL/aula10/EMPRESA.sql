CREATE DATABASE empresa;
GO
USE empresa;
GO

CREATE TABLE empresa(
    numEmpresa          INT             PRIMARY KEY,
    numCGC              INT,
    nom                 VARCHAR(100),
    tipoAtiv            VARCHAR(100)
);

CREATE TABLE departamento(
    numEmpresa          INT             FOREIGN KEY empresa(numEmpresa),
    numDepartamento     INT             PRIMARY KEY,
    nomDepartamento     VARCHAR(100)
);

CREATE TABLE funcionario(
    nomeFuncionario     VARCHAR(150),
    numEmpresa          INT             FOREIGN KEY empresa(numEmpresa),
    numDepartamento     INT             FOREIGN KEY departamento(numDepartamento)
);

CREATE TABLE projeto(
    codProjeto          INT             PRIMARY KEY,
    nomeProjeto         VARCHAR(100)
);

CREATE TABLE funcionarioProjeto(   
    numFuncionario      VARCHAR(150) FOREIGN KEY funcionario(nomeFuncionario),
    codProjeto          INT          FOREIGN KEY projeto(codProjeto),
    dataAlocacao        DATE
);

SELECT * FROM empresa;
SELECT * FROM departamento;
SELECT * FROM funcionario;
SELECT * FROM projeto;
SELECT * FROM funcionarioProjeto;

