CREATE DATABASE livraria
GO
USE livraria

CREATE TABLE livro(
codigo	  INT              NOT NULL  IDENTITY(100001, 100),
nome	    VARCHAR(200)     NOT NULL,
lingua    VARCHAR(10)      NOT NULL  DEFAULT('PT-BR'),
ano       INT              NOT NULL  CHECK(ano >= 1990)
PRIMARY KEY(codigo)
)
GO
CREATE TABLE autor(
ID_autor     INT            NOT NULL   IDENTITY(2351, 1),
nome         VARCHAR(100)   NOT NULL   UNIQUE,
data_nasc    DATE           NOT NULL,
pais_nasc    VARCHAR(50)    NOT NULL   CHECK(UPPER(pais_nasc) = 'Alemanha' OR UPPER(pais_nasc) = 'Brasil' OR UPPER(pais_nasc) = 'Estados Unidos' OR UPPER(pais_nasc) = 'Inglaterra'),
biografia    VARCHAR(255)   NOT NULL
PRIMARY KEY(ID_autor)
)
GO
CREATE TABLE livro_autor(
livrocodigo                  INT    NOT NULL,
autorID                      INT    NOT NULL
PRIMARY KEY(livrocodigo, autorID),
FOREIGN KEY(livrocodigo) REFERENCES livro(codigo),
FOREIGN KEY(autorID) REFERENCES autor(ID_autor)
)
GO
CREATE TABLE editora(
ID_editora       INT            NOT NULL   IDENTITY(491, 16),
nome             VARCHAR(70)    NOT NULL   UNIQUE,
telefone         VARCHAR(11)    NOT NULL   CHECK(LEN(telefone) = 10),
logradouro       VARCHAR(200)   NOT NULL,
numero           INT            NOT NULL   CHECK(numero > 0),
CEP              CHAR(8)        NOT NULL   CHECK(LEN(CEP) = 8),
complemento      VARCHAR(255)   NOT NULL
PRIMARY KEY(ID_editora)
)
GO
CREATE TABLE edicao(
isbn            CHAR(13)       NOT NULL  CHECK(LEN(isbn) = 13) ,
preco           DECIMAL(4,2)   NOT NULL  CHECK(preco >= 0.0),
ano             INT            NOT NULL  CHECK(ano >= 1993),
numero_paginas  INT            NOT NULL  CHECK(numero_paginas > 15),
qtd_estoque     INT            NOT NULL
PRIMARY KEY(isbn)
)
GO
CREATE TABLE editora_edicao_livro(
editoraID      INT          NOT NULL,
edicaoISBN     CHAR(13)     NOT NULL,
livrocodigo    INT          NOT NULL
PRIMARY KEY(editoraID, edicaoISBN, livrocodigo)
FOREIGN KEY(editoraID)   REFERENCES editora(ID_editora),
FOREIGN KEY(edicaoISBN)  REFERENCES edicao(isbn),
FOREIGN KEY(livrocodigo) REFERENCES livro(codigo)  
)

SELECT * FROM livro
SELECT * FROM autor
SELECT * FROM livro_autor
SELECT * FROM editora
SELECT * FROM edicao
SELECT * FROM editora_edicao_livro
