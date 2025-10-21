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

CREATE TRIGGER TR_Professor_Log
ON Professor
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- INSERT (apenas registros que estão em INSERTED e não em DELETED)
    INSERT INTO Tabela_Log_Professor (Usuario, CodProf, TipoOperacao, DataHora)
    SELECT 
        SUSER_SNAME(),
        I.CodProf,
        'INSERT',
        GETDATE()
    FROM INSERTED I
    LEFT JOIN DELETED D ON I.CodProf = D.CodProf
    WHERE D.CodProf IS NULL;

    -- UPDATE (registros que estão tanto em INSERTED quanto em DELETED)
    INSERT INTO Tabela_Log_Professor (Usuario, CodProf, TipoOperacao, DataHora)
    SELECT 
        SUSER_SNAME(),
        I.CodProf,
        'UPDATE',
        GETDATE()
    FROM INSERTED I
    INNER JOIN DELETED D ON I.CodProf = D.CodProf;

    -- DELETE (registros que estão em DELETED e não em INSERTED)
    INSERT INTO Tabela_Log_Professor (Usuario, CodProf, TipoOperacao, DataHora)
    SELECT 
        SUSER_SNAME(),
        D.CodProf,
        'DELETE',
        GETDATE()
    FROM DELETED D
    LEFT JOIN INSERTED I ON D.CodProf = I.CodProf
    WHERE I.CodProf IS NULL;
END;
GO


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

--  CRIAR TRIGGER QUE: IMPEÇA A INCLUSAO DE PROFESSOR SEM TITULO DE DOUTORADO

CREATE TRIGGER TR_Professor_ImpedeSemDoutorado
ON Professor
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM INSERTED i
        WHERE i.CodTit <> 3  -- Ajuste o código para o seu CodTit de Doutorado
    )
    BEGIN
        RAISERROR('Inserção bloqueada: somente professores com titulação de Doutorado podem ser incluídos.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Se todos têm Doutorado, permite inserir normalmente
    INSERT INTO Professor (CodProf, CodDepto, CodTit, NomeProf)
    SELECT CodProf, CodDepto, CodTit, NomeProf
    FROM INSERTED;
END;
GO

