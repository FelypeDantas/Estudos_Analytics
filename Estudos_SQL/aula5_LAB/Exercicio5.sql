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
CREATE PROCEDURE ListarTurmasPorPredioComCapacidadeReduzida
AS
BEGIN
    DECLARE 
        @NomePredio VARCHAR(40),
        @QtdTurmas INT;
    DECLARE Cursor_Predios CURSOR FOR
        SELECT TOP 4 
            P.NomePredio,
            COUNT(DISTINCT H.AnoSem + H.CodDepto + CAST(H.NumDisc AS VARCHAR) + H.SiglaTurma) AS QtdTurmas
        FROM Horario H
        INNER JOIN Sala S ON H.CodPred = S.CodPred AND H.NumSala = S.NumSala
        INNER JOIN Predio P ON S.CodPred = P.CodPred
        WHERE S.CapacidadeSala < 30
        GROUP BY P.NomePredio;

    OPEN Cursor_Predios;

    FETCH NEXT FROM Cursor_Predios INTO @NomePredio, @QtdTurmas;

    PRINT 'Nome do Prédio | Qtd de Turmas';

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @NomePredio + ' | ' + CAST(@QtdTurmas AS VARCHAR);
        FETCH NEXT FROM Cursor_Predios INTO @NomePredio, @QtdTurmas;
    END

    CLOSE Cursor_Predios;
    DEALLOCATE Cursor_Predios;
END;
GO

EXEC ListarTurmasPorPredioComCapacidadeReduzida;

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

EXEC ListarDisciplinasSalaoNobre;

SELECT DISTINCT D.COD_DEPARTAMENTO
FROM DEPARTAMENTO D
JOIN DISCIPLINA DI ON D.COD_DEPARTAMENTO = DI.COD_DEPARTAMENTO
JOIN TURMA T ON DI.ID_DISCIPLINA = T.ID_DISCIPLINA
WHERE T.SEMESTRE = '2002/1';

SELECT DISTINCT P.ID_PROFESSOR
FROM PROFESSOR P
JOIN TURMA T ON P.ID_PROFESSOR = T.ID_PROFESSOR
WHERE P.COD_DEPARTAMENTO = 'INF01'
  AND T.SEMESTRE = '2002/1';

SELECT HT.DIA_SEMANA, HT.HORA_INICIO, HT.NUM_HORAS
FROM PROFESSOR P
JOIN TURMA T ON P.ID_PROFESSOR = T.ID_PROFESSOR
JOIN HORARIO_TURMA HT ON T.ID_TURMA = HT.ID_TURMA
WHERE P.NOME_PROFESSOR = 'Antunes'
  AND T.SEMESTRE = '2002/1';

SELECT DISTINCT D.NOME_DEPARTAMENTO
FROM DEPARTAMENTO D
JOIN DISCIPLINA DI ON D.COD_DEPARTAMENTO = DI.COD_DEPARTAMENTO
JOIN TURMA T ON DI.ID_DISCIPLINA = T.ID_DISCIPLINA
JOIN ALOCACAO_TURMA_SALA ATS ON T.ID_TURMA = ATS.ID_TURMA
JOIN SALA S ON ATS.COD_PREDIO = S.COD_PREDIO AND ATS.NUMERO_SALA = S.NUMERO_SALA
WHERE T.SEMESTRE = '2002/1'
  AND S.NUMERO_SALA = '101'
  AND S.NOME_PREDIO = 'Informática - aulas';

SELECT P.ID_PROFESSOR
FROM PROFESSOR P
WHERE P.TITULO = 'Doutor'
  AND P.ID_PROFESSOR NOT IN (
    SELECT DISTINCT ID_PROFESSOR
    FROM TURMA
    WHERE SEMESTRE = '2002/1'
  );

SELECT DISTINCT S.COD_PREDIO, S.NUMERO_SALA
FROM SALA S
WHERE EXISTS (
    SELECT 1
    FROM TURMA T
    JOIN DISCIPLINA D ON T.ID_DISCIPLINA = D.ID_DISCIPLINA
    JOIN ALOCACAO_TURMA_SALA ATS ON ATS.ID_TURMA = T.ID_TURMA
    JOIN HORARIO_TURMA HT ON HT.ID_TURMA = T.ID_TURMA
    WHERE T.SEMESTRE = '2002/1'
      AND D.COD_DEPARTAMENTO = 'Informática'
      AND HT.DIA_SEMANA = 2
      AND ATS.COD_PREDIO = S.COD_PREDIO AND ATS.NUMERO_SALA = S.NUMERO_SALA
)
AND EXISTS (
    SELECT 1
    FROM TURMA T
    JOIN PROFESSOR P ON T.ID_PROFESSOR = P.ID_PROFESSOR
    JOIN ALOCACAO_TURMA_SALA ATS ON ATS.ID_TURMA = T.ID_TURMA
    JOIN HORARIO_TURMA HT ON HT.ID_TURMA = T.ID_TURMA
    WHERE T.SEMESTRE = '2002/1'
      AND P.NOME_PROFESSOR = 'Antunes'
      AND HT.DIA_SEMANA = 4
      AND ATS.COD_PREDIO = S.COD_PREDIO AND ATS.NUMERO_SALA = S.NUMERO_SALA
);

SELECT HT.DIA_SEMANA, HT.HORA_INICIO, HT.NUM_HORAS
FROM TURMA T
JOIN HORARIO_TURMA HT ON T.ID_TURMA = HT.ID_TURMA
JOIN ALOCACAO_TURMA_SALA ATS ON T.ID_TURMA = ATS.ID_TURMA
JOIN PROFESSOR P ON T.ID_PROFESSOR = P.ID_PROFESSOR
WHERE P.NOME_PROFESSOR = 'Antunes'
  AND T.SEMESTRE = '2002/1'
  AND ATS.NUMERO_SALA = '101'
  AND ATS.COD_PREDIO = '43423';

SELECT DISTINCT P.ID_PROFESSOR, P.NOME_PROFESSOR, DP.NOME_DEPARTAMENTO AS DEPT_ORIGEM, DO.NOME_DEPARTAMENTO AS DEPT_OUTRO
FROM PROFESSOR P
JOIN DEPARTAMENTO DP ON P.COD_DEPARTAMENTO = DP.COD_DEPARTAMENTO
JOIN TURMA T ON P.ID_PROFESSOR = T.ID_PROFESSOR
JOIN DISCIPLINA D ON T.ID_DISCIPLINA = D.ID_DISCIPLINA
JOIN DEPARTAMENTO DO ON D.COD_DEPARTAMENTO = DO.COD_DEPARTAMENTO
WHERE DP.COD_DEPARTAMENTO <> DO.COD_DEPARTAMENTO;

SELECT DISTINCT P.NOME_PROFESSOR, T1.ID_TURMA AS TURMA1, T2.ID_TURMA AS TURMA2
FROM PROFESSOR P
JOIN TURMA T1 ON P.ID_PROFESSOR = T1.ID_PROFESSOR
JOIN HORARIO_TURMA H1 ON T1.ID_TURMA = H1.ID_TURMA
JOIN TURMA T2 ON P.ID_PROFESSOR = T2.ID_PROFESSOR
JOIN HORARIO_TURMA H2 ON T2.ID_TURMA = H2.ID_TURMA
WHERE T1.ID_TURMA < T2.ID_TURMA
  AND T1.SEMESTRE = T2.SEMESTRE
  AND H1.DIA_SEMANA = H2.DIA_SEMANA
  AND H1.HORA_INICIO = H2.HORA_INICIO;

SELECT D1.NOME_DISCIPLINA AS DISCIPLINA, D2.NOME_DISCIPLINA AS PR

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


