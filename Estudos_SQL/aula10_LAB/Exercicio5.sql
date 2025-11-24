-- Criação do banco
CREATE DATABASE prova;
GO

USE prova;
GO

-- ========================
-- Tabelas
-- ========================

CREATE TABLE Depto (
    CodDepto CHAR(5) PRIMARY KEY,
    NomeDepto VARCHAR(40) NOT NULL
);

CREATE TABLE Titulacao (
    CodTit INT PRIMARY KEY,
    NomeTit VARCHAR(40) NOT NULL
);

CREATE TABLE Professor (
    CodProf INT PRIMARY KEY,
    CodDepto CHAR(5) NOT NULL,
    CodTit INT NOT NULL,
    NomeProf VARCHAR(40) NOT NULL,
    CONSTRAINT FK_Professor_Depto FOREIGN KEY (CodDepto)
        REFERENCES Depto(CodDepto),
    CONSTRAINT FK_Professor_Titulacao FOREIGN KEY (CodTit)
        REFERENCES Titulacao(CodTit)
);

CREATE TABLE Disciplina (
    CodDepto CHAR(5),
    NumDisc INT,
    NomeDisc VARCHAR(100) NOT NULL,
    CreditoDisc INT NOT NULL,
    CONSTRAINT PK_Disciplina PRIMARY KEY (CodDepto, NumDisc),
    CONSTRAINT FK_Disciplina_Depto FOREIGN KEY (CodDepto)
        REFERENCES Depto(CodDepto)
);

CREATE TABLE PreReq (
    CodDeptoPreReq CHAR(5),
    NumDiscPreReq INT,
    CodDepto CHAR(5),
    NumDisc INT,
    CONSTRAINT PK_PreReq PRIMARY KEY (CodDeptoPreReq, NumDiscPreReq, CodDepto, NumDisc),
    CONSTRAINT FK_PreReq_DisciplinaPreReq FOREIGN KEY (CodDeptoPreReq, NumDiscPreReq)
        REFERENCES Disciplina(CodDepto, NumDisc),
    CONSTRAINT FK_PreReq_Disciplina FOREIGN KEY (CodDepto, NumDisc)
        REFERENCES Disciplina(CodDepto, NumDisc)
);

CREATE TABLE Turma (
    AnoSem INT,
    CodDepto CHAR(5),
    NumDisc INT,
    SiglaTurma CHAR(2),
    CapacidadeTurma INT,
    CONSTRAINT PK_Turma PRIMARY KEY (AnoSem, CodDepto, NumDisc, SiglaTurma),
    CONSTRAINT FK_Turma_Disciplina FOREIGN KEY (CodDepto, NumDisc)
        REFERENCES Disciplina(CodDepto, NumDisc)
);

CREATE TABLE ProfTurma (
    AnoSem INT,
    CodDepto CHAR(5),
    NumDisc INT,
    SiglaTurma CHAR(2),
    CodProf INT,
    CONSTRAINT PK_ProfTurma PRIMARY KEY (AnoSem, CodDepto, NumDisc, SiglaTurma, CodProf),
    CONSTRAINT FK_ProfTurma_Turma FOREIGN KEY (AnoSem, CodDepto, NumDisc, SiglaTurma)
        REFERENCES Turma(AnoSem, CodDepto, NumDisc, SiglaTurma),
    CONSTRAINT FK_ProfTurma_Professor FOREIGN KEY (CodProf)
        REFERENCES Professor(CodProf)
);

CREATE TABLE Predio (
    CodPred INT PRIMARY KEY,
    NomePredio VARCHAR(40) NOT NULL
);

CREATE TABLE Sala (
    CodPred INT,
    NumSala INT,
    DescricaoSala VARCHAR(40),
    CapacidadeSala INT,
    CONSTRAINT PK_Sala PRIMARY KEY (CodPred, NumSala),
    CONSTRAINT FK_Sala_Predio FOREIGN KEY (CodPred)
        REFERENCES Predio(CodPred)
);

CREATE TABLE Horario (
    AnoSem INT,
    CodDepto CHAR(5),
    NumDisc INT,
    SiglaTurma CHAR(2),
    DiaSemana INT,           -- 1=Dom, 2=Seg... até 7
    HoraInicio INT,          -- Ex: 800, 1030, 1400
    NumSala INT,
    CodPred INT,
    NumHoras INT,
    CONSTRAINT PK_Horario PRIMARY KEY (AnoSem, CodDepto, NumDisc, SiglaTurma, DiaSemana, HoraInicio),
    CONSTRAINT FK_Horario_Turma FOREIGN KEY (AnoSem, CodDepto, NumDisc, SiglaTurma)
        REFERENCES Turma(AnoSem, CodDepto, NumDisc, SiglaTurma),
    CONSTRAINT FK_Horario_Sala FOREIGN KEY (CodPred, NumSala)
        REFERENCES Sala(CodPred, NumSala)
);

INSERT INTO Depto (CodDepto, NomeDepto) VALUES
('INF01', 'Informática'),
('MAT01', 'Matemática'),
('FIS01', 'Física'),
('QUI01', 'Química'),
('BIO01', 'Biologia'),
('POL01', 'Polimeros'),
('ENG01', 'Engenharia'),
('ADM01', 'Administração'),
('DIR01', 'Direito');

INSERT INTO Titulacao (CodTit, NomeTit) VALUES
(1, 'Mestrado'),
(2, 'Doutorado'),
(3, 'Especialização'),
(4, 'Livre-Docência'),
(5, 'Pós-Doutorado');

INSERT INTO Professor (CodProf, CodDepto, CodTit, NomeProf) VALUES
(1001, 'INF01', 2, 'Carlos Silva'),
(1002, 'INF01', 1, 'Maria Oliveira'),
(1003, 'MAT01', 2, 'João Pereira'),
(1004, 'MAT01', 3, 'Ana Santos'),
(1005, 'FIS01', 2, 'Paulo Costa'),
(1006, 'FIS01', 4, 'Laura Ramos'),
(1007, 'QUI01', 1, 'Pedro Almeida'),
(1008, 'BIO01', 2, 'Ricardo Lima'),
(1009, 'POL01', 3, 'Sandra Gomes'),
(1010, 'ENG01', 2, 'Marcos Fernandes'),
(1011, 'ADM01', 5, 'Fernanda Souza'),
(1012, 'DIR01', 2, 'Luiz Silva');

INSERT INTO Predio (CodPred, NomePredio) VALUES
(1, 'Central'),
(2, 'Salão Nobre'),
(3, 'Bloco A'),
(4, 'Bloco B');

INSERT INTO Sala (CodPred, NumSala, DescricaoSala, CapacidadeSala) VALUES
(1, 101, 'Sala 101', 25),
(1, 102, 'Sala 102', 40),
(2, 201, 'Salão Nobre', 100),
(3, 301, 'Laboratório 1', 20),
(3, 302, 'Laboratório 2', 18),
(4, 401, 'Sala Pequena', 28);

INSERT INTO Disciplina (CodDepto, NumDisc, NomeDisc, CreditoDisc) VALUES
('INF01', 1, 'Algoritmos', 4),
('INF01', 2, 'Estruturas de Dados', 4),
('INF01', 3, 'Banco de Dados', 4),
('MAT01', 1, 'Cálculo I', 4),
('MAT01', 2, 'Álgebra Linear', 4),
('FIS01', 1, 'Física I', 4);

INSERT INTO PreReq VALUES
('INF01', 1, 'INF01', 2),
('INF01', 1, 'INF01', 3),
('INF01', 2, 'INF01', 3),
('MAT01', 1, 'MAT01', 2);

INSERT INTO Turma (AnoSem, CodDepto, NumDisc, SiglaTurma, CapacidadeTurma) VALUES
(20251, 'INF01', 1, 'A', 40),
(20251, 'INF01', 2, 'A', 40),
(20251, 'INF01', 3, 'A', 40),
(20251, 'MAT01', 1, 'A', 35);

INSERT INTO ProfTurma VALUES
(20251, 'INF01', 1, 'A', 1001),
(20251, 'INF01', 2, 'A', 1002),
(20251, 'INF01', 3, 'A', 1001),
(20251, 'MAT01', 1, 'A', 1003);

INSERT INTO Horario VALUES
(20251, 'INF01', 1, 'A', 2, 800, 201, 2, 2),    -- Salão Nobre
(20251, 'INF01', 2, 'A', 4, 1000, 201, 2, 2),   -- Salão Nobre
(20251, 'INF01', 3, 'A', 6, 1400, 301, 3, 2),   -- Sala pequena
(20251, 'MAT01', 1, 'A', 3, 900, 401, 4, 2);    -- Capacidade < 30


-- TURMA A
-- CRIAR PROCEDURE COM APENAS UMA QUERY DE CURSOR PARA SELECIONAR:
-- A quantidade de professores que tem turmas no 1o. semestre de 2025, 
-- agrupados por nome de Titulação, cujo o nome do departamento seja diferente de 'Polimeros'. 
-- Listar apenas 3 titulações distintas.
CREATE PROCEDURE ListarProfessoresPorTitulacao
AS
BEGIN
    DECLARE 
        @NomeTit VARCHAR(40),
        @QtdProfessores INT;

    -- Cursor para selecionar os dados desejados (limite de 3 titulações)
    DECLARE Cursor_Titulacoes CURSOR FOR
        SELECT TOP 3
            T.NomeTit,
            COUNT(DISTINCT P.CodProf) AS QtdProfessores
        FROM Professor P
        INNER JOIN Titulacao T ON P.CodTit = T.CodTit
        INNER JOIN ProfTurma PT ON P.CodProf = PT.CodProf
        INNER JOIN Turma TU ON PT.AnoSem = TU.AnoSem 
                            AND PT.CodDepto = TU.CodDepto 
                            AND PT.NumDisc = TU.NumDisc 
                            AND PT.SiglaTurma = TU.SiglaTurma
        INNER JOIN Depto D ON P.CodDepto = D.CodDepto
        WHERE TU.AnoSem = 20251
          AND D.NomeDepto <> 'Polimeros'
        GROUP BY T.NomeTit;

    OPEN Cursor_Titulacoes;

    FETCH NEXT FROM Cursor_Titulacoes INTO @NomeTit, @QtdProfessores;

    PRINT 'Nome da Titulação | Qtd de Professores';

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @NomeTit + ' | ' + CAST(@QtdProfessores AS VARCHAR);
        FETCH NEXT FROM Cursor_Titulacoes INTO @NomeTit, @QtdProfessores;
    END

    CLOSE Cursor_Titulacoes;
    DEALLOCATE Cursor_Titulacoes;
END;
GO

EXEC ListarProfessoresPorTitulacao;

-- TURMA B

-- CRIAR PROCEDURE COM APENAS UMA QUERY DE CURSOR PARA SELECIONAR:
-- Selecionar a quantidade de turmas e nome do predio que tenham horarios em salas 
-- cujo a capacidade seja inferior a 30. Listar no máximo 4 prédios distintos.
GO
CREATE PROCEDURE ListarDisciplinasSalaoNobre
AS
BEGIN
    DECLARE 
        @NomeDisc VARCHAR(100),
        @NomeProf VARCHAR(40);

    -- Cursor para selecionar os dados
    DECLARE Cursor_Disciplinas CURSOR FOR
        SELECT TOP 3 
            D.NomeDisc,
            P.NomeProf
        FROM Horario H
        INNER JOIN Sala S ON H.CodPred = S.CodPred AND H.NumSala = S.NumSala
        INNER JOIN Turma T ON H.AnoSem = T.AnoSem AND H.CodDepto = T.CodDepto 
                            AND H.NumDisc = T.NumDisc AND H.SiglaTurma = T.SiglaTurma
        INNER JOIN ProfTurma PT ON T.AnoSem = PT.AnoSem AND T.CodDepto = PT.CodDepto 
                                 AND T.NumDisc = PT.NumDisc AND T.SiglaTurma = PT.SiglaTurma
        INNER JOIN Professor P ON PT.CodProf = P.CodProf
        INNER JOIN Disciplina D ON T.CodDepto = D.CodDepto AND T.NumDisc = D.NumDisc
        INNER JOIN Depto DP ON D.CodDepto = DP.CodDepto
        WHERE S.DescricaoSala = 'Salão Nobre'
          AND DP.NomeDepto = 'Informática'
        ORDER BY D.NomeDisc;

    OPEN Cursor_Disciplinas;

    FETCH NEXT FROM Cursor_Disciplinas INTO @NomeDisc, @NomeProf;

    PRINT 'Nome da Disciplina | Nome do Professor';

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @NomeDisc + ' | ' + @NomeProf;
        FETCH NEXT FROM Cursor_Disciplinas INTO @NomeDisc, @NomeProf;
    END

    CLOSE Cursor_Disciplinas;
    DEALLOCATE Cursor_Disciplinas;
END;
GO

-- Criar um prédio
INSERT INTO Predio (CodPred, NomePredio)
VALUES (10, 'Prédio Principal');

-- Criar a sala Salão Nobre
INSERT INTO Sala (CodPred, NumSala, DescricaoSala, CapacidadeSala)
VALUES (10, 101, 'Salão Nobre', 100);

-- Criar disciplina INF01 / 101
INSERT INTO Disciplina (CodDepto, NumDisc, NomeDisc, CreditoDisc)
VALUES ('INF01', 101, 'Programação Avançada', 4);

-- Criar turma 20251 - INF01 101 - A
INSERT INTO Turma (AnoSem, CodDepto, NumDisc, SiglaTurma, CapacidadeTurma)
VALUES (20251, 'INF01', 101, 'A', 50);

-- Associar professor 1001 à turma
INSERT INTO ProfTurma (AnoSem, CodDepto, NumDisc, SiglaTurma, CodProf)
VALUES (20251, 'INF01', 101, 'A', 1001);

-- Criar horário na sala Salão Nobre
INSERT INTO Horario (AnoSem, CodDepto, NumDisc, SiglaTurma, DiaSemana, HoraInicio, NumSala, CodPred, NumHoras)
VALUES (20251, 'INF01', 101, 'A', 2, 800, 101, 10, 2);



    -- Cursor para selecionar os dados
    DECLARE Cursor_Disciplinas CURSOR FOR
        SELECT TOP 3 
            D.NomeDisc,
            P.NomeProf
        FROM Horario H
        INNER JOIN Sala S ON H.CodPred = S.CodPred AND H.NumSala = S.NumSala
        INNER JOIN Turma T ON H.AnoSem = T.AnoSem AND H.CodDepto = T.CodDepto 
                            AND H.NumDisc = T.NumDisc AND H.SiglaTurma = T.SiglaTurma
        INNER JOIN ProfTurma PT ON T.AnoSem = PT.AnoSem AND T.CodDepto = PT.CodDepto 
                                 AND T.NumDisc = PT.NumDisc AND T.SiglaTurma = PT.SiglaTurma
        INNER JOIN Professor P ON PT.CodProf = P.CodProf
        INNER JOIN Disciplina D ON T.CodDepto = D.CodDepto AND T.NumDisc = D.NumDisc
        INNER JOIN Depto DP ON D.CodDepto = DP.CodDepto
        WHERE S.DescricaoSala = 'Salão Nobre'
          AND DP.NomeDepto = 'Informática'
        ORDER BY D.NomeDisc;

    OPEN Cursor_Disciplinas;

    FETCH NEXT FROM Cursor_Disciplinas INTO @NomeDisc, @NomeProf;

    PRINT 'Nome da Disciplina | Nome do Professor';

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @NomeDisc + ' | ' + @NomeProf;
        FETCH NEXT FROM Cursor_Disciplinas INTO @NomeDisc, @NomeProf;
    END

    CLOSE Cursor_Disciplinas;
    DEALLOCATE Cursor_Disciplinas;
END;

EXEC ListarDisciplinasSalaoNobre;

SELECT DISTINCT D.CodDepto
FROM Depto D
JOIN DISCIPLINA DI ON D.CodDepto = DI.CodDepto
JOIN TURMA T ON DI.NumDisc = T.NumDisc
WHERE T.AnoSem = 2002/1;

SELECT DISTINCT P.CodProf
FROM PROFESSOR P
JOIN TURMA T ON P.CodDepto = T.CodDepto
WHERE P.CodDepto = 'INF01'
  AND T.AnoSem = 2002/1;

SELECT D.NomeDisc
FROM Disciplina D
LEFT JOIN PreReq PR 
    ON D.CodDepto = PR.CodDepto AND D.NumDisc = PR.NumDisc
WHERE PR.CodDeptoPreReq IS NULL;

SELECT D.NomeDisc
FROM Disciplina D
JOIN PreReq PR 
    ON D.CodDepto = PR.CodDepto AND D.NumDisc = PR.NumDisc
GROUP BY D.CodDepto, D.NumDisc, D.NomeDisc
HAVING COUNT(*) >= 2;

CREATE TABLE Tabela_Log_Professor (
    IDLog INT IDENTITY(1,1) PRIMARY KEY,
    Usuario VARCHAR(100),
    CodProf INT,
    TipoOperacao VARCHAR(10),
    DataHora DATETIME
);


-- Inserção de teste
INSERT INTO Professor (CodProf, CodDepto, CodTit, NomeProf)
VALUES (1001, 'INF01', 1, 'Carlos Silva');

-- Atualização de teste
UPDATE Professor
SET NomeProf = 'Carlos Silva Jr.'
WHERE CodProf = 1001;

-- Exclusão de teste
DELETE FROM Professor
WHERE CodProf = 1001;

-- Verificar o log
SELECT * FROM Tabela_Log_Professor;

-- 1. Obter os nomes docentes cuja titulação tem código diferente de 3.
SELECT NomeProf
FROM Professor
WHERE CodTit <> 3;

-- 2. Nomes dos departamentos que têm turmas que, em 2002/1, têm aulas na sala 101 do prédio ‘Informática - aulas’.
SELECT DISTINCT NomeDepto
FROM Depto
NATURAL JOIN Disciplina
NATURAL JOIN Turma
NATURAL JOIN Horario
NATURAL JOIN Sala
NATURAL JOIN Predio
WHERE NomePredio = 'Informática - aulas'
  AND NumSala = 101
  AND AnoSem = '2002/1';

-- Nome dos departamentos e suas disciplinas com > 3 créditos (mostrar depto mesmo sem disciplinas assim).
SELECT D.NomeDepto, Di.NomeDisc
FROM Depto D
LEFT JOIN Disciplina Di ON D.CodDepto = Di.CodDepto
    AND Di.CreditoDisc > 3;

-- Professores que possuem horários conflitantes.
SELECT DISTINCT P.NomeProf
FROM Professor P
JOIN ProfTurma PT ON P.CodProf = PT.CodProf
JOIN Horario H1 ON PT.AnoSem = H1.AnoSem
               AND PT.CodDepto = H1.CodDepto
               AND PT.NumDisc = H1.NumDisc
               AND PT.SiglaTurma = H1.SiglaTurma
JOIN Horario H2 ON H1.AnoSem = H2.AnoSem
               AND H1.DiaSem = H2.DiaSem
               AND H1.HoraInicio = H2.HoraInicio
               AND (
                    H1.CodDepto <> H2.CodDepto OR
                    H1.NumDisc  <> H2.NumDisc  OR
                    H1.SiglaTurma <> H2.SiglaTurma
               );

-- Disciplinas com pré-requisitos (usando joins explícitas).
SELECT D.NomeDisc AS Disciplina,
       P.NomeDisc AS PreRequisito
FROM Disciplina D
JOIN Prereq R
    ON D.CodDepto = R.CodDepto
   AND D.NumDisc  = R.NumDisc
JOIN Disciplina P
    ON R.CodDeptoPre = P.CodDepto
   AND R.NumDiscPre  = P.NumDisc;

-- Todas as disciplinas (mesmo sem pré-requisito)
SELECT D.NomeDisc AS Disciplina,
       P.NomeDisc AS PreRequisito
FROM Disciplina D
LEFT JOIN Prereq R
    ON D.CodDepto = R.CodDepto
   AND D.NumDisc  = R.NumDisc
LEFT JOIN Disciplina P
    ON R.CodDeptoPre = P.CodDepto
   AND R.NumDiscPre  = P.NumDisc;

-- Disciplinas cujo pré-requisito também tem pré-requisito
SELECT D.NomeDisc AS Disciplina,
       P1.NomeDisc AS PreRequisito,
       P2.NomeDisc AS PreRequisitoDoPreRequisito
FROM Disciplina D
JOIN Prereq R1
    ON D.CodDepto = R1.CodDepto
   AND D.NumDisc  = R1.NumDisc
JOIN Disciplina P1
    ON R1.CodDeptoPre = P1.CodDepto
   AND R1.NumDiscPre  = P1.NumDisc
JOIN Prereq R2
    ON P1.CodDepto = R2.CodDepto
   AND P1.NumDisc  = R2.NumDisc
JOIN Disciplina P2
    ON R2.CodDeptoPre = P2.CodDepto
   AND R2.NumDiscPre  = P2.NumDisc;

-- Tabela com níveis de pré-requisitos (até 3 níveis) — UNION ALL
-- Nível 1
SELECT D.NomeDisc, P1.NomeDisc AS PreReq, 1 AS Nivel
FROM Disciplina D
JOIN Prereq R1 ON D.CodDepto = R1.CodDepto AND D.NumDisc = R1.NumDisc
JOIN Disciplina P1 ON R1.CodDeptoPre = P1.CodDepto AND R1.NumDiscPre = P1.NumDisc

UNION ALL

-- Nível 2
SELECT D.NomeDisc, P2.NomeDisc AS PreReq, 2 AS Nivel
FROM Disciplina D
JOIN Prereq R1 ON D.CodDepto = R1.CodDepto AND D.NumDisc = R1.NumDisc
JOIN Disciplina P1 ON R1.CodDeptoPre = P1.CodDepto AND R1.NumDiscPre = P1.NumDisc
JOIN Prereq R2 ON P1.CodDepto = R2.CodDepto AND P1.NumDisc = R2.NumDisc
JOIN Disciplina P2 ON R2.CodDeptoPre = P2.CodDepto AND R2.NumDiscPre = P2.NumDisc

UNION ALL

-- Nível 3
SELECT D.NomeDisc, P3.NomeDisc AS PreReq, 3 AS Nivel
FROM Disciplina D
JOIN Prereq R1 ON D.CodDepto = R1.CodDepto AND D.NumDisc = R1.NumDisc
JOIN Disciplina P1 ON R1.CodDeptoPre = P1.CodDepto AND R1.NumDiscPre = P1.NumDisc
JOIN Prereq R2 ON P1.CodDepto = R2.CodDepto AND P1.NumDisc = R2.NumDisc
JOIN Disciplina P2 ON R2.CodDeptoPre = P2.CodDepto AND R2.NumDiscPre = P2.NumDisc
JOIN Prereq R3 ON P2.CodDepto = R3.CodDepto AND P2.NumDisc = R3.NumDisc
JOIN Disciplina P3 ON R3.CodDeptoPre = P3.CodDepto AND R3.NumDiscPre = P3.NumDisc;

-- Professores com título vazio e que NÃO ministraram aulas em 2001/2 (com NATURAL JOIN)
SELECT CodProf
FROM Professor
WHERE CodTit IS NULL OR CodTit = ''
EXCEPT
SELECT CodProf
FROM Professor
NATURAL JOIN ProfTurma
WHERE AnoSem = '2001/2';





