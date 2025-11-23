CREATE DATABASE deadlock;
USE deadlock;

CREATE TABLE contas (
    id INT PRIMARY KEY,
    saldo DECIMAL(10,2)
) ENGINE=InnoDB;

INSERT INTO contas VALUES (1, 1000.00);
INSERT INTO contas VALUES (2, 2000.00);

COMMIT;

-- Inicia uma transação
START TRANSACTION;

-- Bloqueia a linha da conta 1
UPDATE contas 
SET saldo = saldo + 100 
WHERE id = 1;

-- NÃO dar commit!
-- Aguarda enquanto criamos a situação de deadlock

-- Tenta atualizar a linha que está bloqueada pela Sessão 2
UPDATE contas 
SET saldo = saldo - 50 
WHERE id = 2;

-- Aqui a Sessão 1 fica travada até ocorrer o deadlock

-- Inicia uma transação
START TRANSACTION;

-- Bloqueia a linha da conta 2
UPDATE contas 
SET saldo = saldo + 200 
WHERE id = 2;

-- NÃO dar commit!
-- Aguarda para gerar o deadlock

-- Tenta atualizar a linha que está bloqueada pela Sessão 1
UPDATE contas 
SET saldo = saldo - 80 
WHERE id = 1;

-- Aqui acontecerá o deadlock e esta sessão receberá o erro:
-- ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
