CREATE DATABASE FORNECIMENTO;
GO

USE FORNECIMENTO;
GO

-- Tabela de Peças
CREATE TABLE peca (
    codPeca      CHAR(2)       PRIMARY KEY,
    nomePeca     VARCHAR(20),
    corPeca      VARCHAR(30),
    pesoPeca     INT,
    cidadePeca   VARCHAR(30)
);
GO

-- Tabela de Fornecedores
CREATE TABLE fornecedores (
    codFornec     CHAR(2)      PRIMARY KEY,
    nomeFornec    VARCHAR(20), -- Corrigido nome da coluna
    statusFornec  INT,
    cidadeFornec  VARCHAR(30)
);
GO

-- Tabela de Embarques
CREATE TABLE embarq (
    codPeca      CHAR(2),
    codFornec    CHAR(2),
    qtdEmbarq    INT,
    PRIMARY KEY (codPeca, codFornec),
    FOREIGN KEY (codPeca) REFERENCES peca(codPeca),
    FOREIGN KEY (codFornec) REFERENCES fornecedores(codFornec)
);
GO

-- Inserções na tabela peca
INSERT INTO peca (codPeca, nomePeca, corPeca, pesoPeca, cidadePeca)
VALUES 
    ('P1', 'Eixo', 'Cinza', 10, 'Poa'),
    ('P2', 'Rolamento', 'Preto', 16, 'Rio'),
    ('P3', 'Mancal', 'Verde', 30, 'São Paulo');
GO

-- Inserções na tabela fornecedores
INSERT INTO fornecedores (codFornec, nomeFornec, statusFornec, cidadeFornec)
VALUES 
    ('F1', 'Silva', 5, 'São Paulo'),
    ('F2', 'Souza', 10, 'Rio'),
    ('F3', 'Alvares', 5, 'São Paulo'),
    ('F4', 'Tavares', 8, 'Rio');
GO

-- Inserções na tabela embarq
INSERT INTO embarq (codPeca, codFornec, qtdEmbarq)
VALUES 
    ('P1', 'F1', 300),
    ('P1', 'F2', 400),
    ('P1', 'F3', 200),
    ('P2', 'F1', 300),
    ('P2', 'F4', 350);
GO

SELECT COUNT(codFornec) AS total_fornecedores
FROM fornecedores;

SELECT COUNT(DISTINCT cidadeFornec) AS total_cidades
FROM fornecedores;

SELECT COUNT(codFornec) AS fornecedores_com_cidade
FROM fornecedores
WHERE cidadeFornec IS NOT NULL;

SELECT MAX(qtdEmbarq) AS quantidade_maxima_embarcada
FROM embarq;

SELECT codFornec, COUNT(*) AS total_embarques
FROM embarq
GROUP BY codFornec;

SELECT codFornec, COUNT(*) AS total_embarques_maior_300
FROM embarq
WHERE qtdEmbarq > 300
GROUP BY codFornec;

SELECT f.codFornec, f.nomeFornec, SUM(e.qtdEmbarq) AS total_pecas_cinza
FROM embarq e
JOIN peca p ON e.codPeca = p.codPeca
JOIN fornecedores f ON e.codFornec = f.codFornec
WHERE p.corPeca = 'Cinza'
GROUP BY f.codFornec, f.nomeFornec;

SELECT f.codFornec, f.nomeFornec, SUM(e.qtdEmbarq) AS total_pecas_embarcadas
FROM embarq e
JOIN fornecedores f ON e.codFornec = f.codFornec
GROUP BY f.codFornec, f.nomeFornec
ORDER BY total_pecas_embarcadas DESC;

SELECT 
    e.codFornec,
    SUM(e.qtdEmbarq) AS total_pecas_cinzas
FROM embarq e
JOIN peca p ON e.codPeca = p.codPeca
WHERE p.corPeca = 'Cinza'
GROUP BY e.codFornec
HAVING SUM(e.qtdEmbarq) > 500;
