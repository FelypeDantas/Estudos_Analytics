CREATE DATABASE livraria
GO
USE livraria
GO
CREATE TABLE Autores (
AutorID				INT				IDENTITY(1,1),
Nome				VARCHAR(100)	NOT NULL,
Nacionalidade		VARCHAR(50)
PRIMARY KEY(AutorID)
)
GO
CREATE TABLE Livros (
LivroID				INT				 IDENTITY(1,1),
Titulo				VARCHAR(150)	 NOT NULL,
AutorID				INT			     NOT NULL,
Preco				DECIMAL(10, 2),
Estoque				INT
PRIMARY KEY(LivroID)
FOREIGN KEY (AutorID) REFERENCES Autores(AutorID)
)
GO
CREATE TABLE Vendas (
VendaID				INT				IDENTITY(1,1),
LivroID				INT				NOT NULL,
DataVenda			DATE			NOT NULL,
Quantidade			INT,
Total				DECIMAL(10, 2)
PRIMARY KEY(VendaID)
FOREIGN KEY (LivroID) REFERENCES Livros(LivroID)
)
GO
-- Tabela Autores
INSERT INTO Autores (Nome, Nacionalidade)
VALUES 
('J.K. Rowling', 'Britânica'),
('George R.R. Martin', 'Americana'),
('J.R.R. Tolkien', 'Britânica');
GO
-- Tabela Livros
INSERT INTO Livros (Titulo, AutorID, Preco, Estoque)
VALUES 
('Harry Potter e a Pedra Filosofal', 1, 35.90, 50),
('Game of Thrones', 2, 49.90, 20),
('O Senhor dos Anéis', 3, 59.90, 30),
('Harry Potter e a Câmara Secreta', 1, 39.90, 40);
GO
-- Tabela Vendas
INSERT INTO Vendas (LivroID, DataVenda, Quantidade, Total)
VALUES 
(1, '2024-01-10', 2, 71.80),
(2, '2024-02-15', 1, 49.90),
(3, '2024-03-01', 3, 179.70),
(1, '2024-03-10', 1, 35.90),
(4, '2024-03-20', 2, 79.80);
GO
--
SELECT * FROM Autores
-- Liste todos os livros disponíveis, incluindo o título e o preço.
SELECT * FROM Livros
SELECT * FROM Vendas

-- Encontre todos os autores de nacionalidade britânica.
SELECT
	Autores.Nome AS [NOME DO AUTOR],
	Autores.Nacionalidade AS [NACIONALIDADE DO AUTOR]
FROM Autores
WHERE Autores.Nacionalidade LIKE '%britânica%'

-- Liste todos os livros cujo preço seja maior que 40.
SELECT
	Livros.Titulo AS [titulo da obra],
	Livros.Preco AS preco
FROM Livros
WHERE Livros.Preco > 40

-- Mostre as vendas realizadas no mês de março de 2024.
SELECT *
FROM Vendas
WHERE MONTH(DataVenda) = 3 AND YEAR(DataVenda) = 2024;

-- Calcule o total arrecadado com todas as vendas.
SELECT
	SUM(Vendas.Total) AS [SOMA TOTAL]
FROM Vendas

-- Encontre o livro com maior quantidade de vendas.
SELECT 
    Livros.Titulo AS [TITULO DO LIVRO], 
    SUM(Vendas.Quantidade) AS [QUANTIDADE DE VENDAS]
FROM Livros
INNER JOIN Vendas ON Vendas.LivroID = Livros.LivroID
GROUP BY Livros.Titulo
HAVING SUM(Vendas.Quantidade) = (
    SELECT MAX(TotalVendas)
    FROM (
        SELECT SUM(Quantidade) AS TotalVendas
        FROM Vendas
        GROUP BY LivroID
    ) AS Subconsulta
);

-- Mostre o nome do autor e o título do livro correspondente em uma única consulta.
SELECT
	Livros.Titulo AS [TITULO DO LIVRO],
	Autores.Nome AS [AUTOR DO LIVRO]
FROM Livros
INNER JOIN Autores ON Autores.AutorID = Livros.AutorID

-- Liste todas as vendas junto com os títulos dos livros vendidos.
SELECT
	Vendas.VendaID AS [VENDA],
	Livros.Titulo AS [TITULO DO LIVRO]
FROM Vendas
INNER JOIN Livros ON Livros.LivroID = Vendas.LivroID


-- Liste os livros em ordem decrescente de preço.
SELECT
	*
FROM Livros
ORDER BY Livros.Preco DESC

-- Encontre os 3 livros com maior estoque disponível.
SELECT
	Livros.Titulo AS TITULO,
	Livros.Estoque AS ESTOQUE
FROM Livros
ORDER BY Livros.Estoque DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY


-- Atualize o preço de "Harry Potter e a Pedra Filosofal" para 37.90.
UPDATE Livros
SET Preco = 37.90
WHERE Preco = 35.90

-- Delete todas as vendas realizadas antes de fevereiro de 2024.
DELETE Vendas
WHERE MONTH(DataVenda) < 2 AND YEAR(DataVenda) < 2024