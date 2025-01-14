CREATE DATABASE ex05
GO
USE ex05
GO
CREATE TABLE fornecedor (
codigo			INT				NOT NULL,
nome			VARCHAR(50)		NOT NULL,
atividade		VARCHAR(80)		NOT NULL,
telefone		CHAR(8)			NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE cliente (
codigo			INT				NOT NULL,
nome			VARCHAR(50)		NOT NULL,
logradouro		VARCHAR(80)		NOT NULL,
numero			INT				NOT NULL,
telefone		CHAR(8)			NOT NULL,
data_nasc		DATE			NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE produto (
codigo			INT				NOT NULL,
nome			VARCHAR(50)		NOT NULL,
valor_unitario	DECIMAL(7,2)	NOT NULL,
qtd_estoque		INT				NOT NULL,
descricao		VARCHAR(80)		NOT NULL,
cod_forn		INT				NOT NULL
PRIMARY KEY(codigo)
FOREIGN KEY(cod_forn) REFERENCES fornecedor(codigo)
)
GO
CREATE TABLE pedido (
codigo			INT			NOT NULL,
cod_cli			INT			NOT NULL,
cod_prod		INT			NOT NULL,
quantidade		INT			NOT NULL,
previsao_ent	DATE		NOT NULL
PRIMARY KEY(codigo, cod_cli, cod_prod, previsao_ent)
FOREIGN KEY(cod_cli) REFERENCES cliente(codigo),
FOREIGN KEY(cod_prod) REFERENCES produto(codigo)
)
GO
INSERT INTO fornecedor VALUES (1001,'Estrela','Brinquedo','41525898')
INSERT INTO fornecedor VALUES (1002,'Lacta','Chocolate','42698596')
INSERT INTO fornecedor VALUES (1003,'Asus','Informática','52014596')
INSERT INTO fornecedor VALUES (1004,'Tramontina','Utensílios Domésticos','50563985')
INSERT INTO fornecedor VALUES (1005,'Grow','Brinquedos','47896325')
INSERT INTO fornecedor VALUES (1006,'Mattel','Bonecos','59865898')
INSERT INTO cliente VALUES (33601,'Maria Clara','R. 1° de Abril',870,'96325874','15/08/2000')
INSERT INTO cliente VALUES (33602,'Alberto Souza','R. XV de Novembro',987,'95873625','02/02/1985')
INSERT INTO cliente VALUES (33603,'Sonia Silva','R. Voluntários da Pátria',1151,'75418596','23/08/1957')
INSERT INTO cliente VALUES (33604,'José Sobrinho','Av. Paulista',250,'85236547','09/12/1986')
INSERT INTO cliente VALUES (33605,'Carlos Camargo','Av. Tiquatira',9652,'75896325','25/03/1971')
INSERT INTO produto VALUES (1,'Banco Imobiliário',65.00,15,'Versão Super Luxo',1001)
INSERT INTO produto VALUES (2,'Puzzle 5000 peças',50.00,5,'Mapas Mundo',1005)
INSERT INTO produto VALUES (3,'Faqueiro',350.00,0,'120 peças',1004)
INSERT INTO produto VALUES (4,'Jogo para churrasco',75.00,3,'7 peças',1004)
INSERT INTO produto VALUES (5,'Tablet',750.00,29,'Tablet',1003)
INSERT INTO produto VALUES (6,'Detetive',49.00,0,'Nova Versão do Jogo',1001)
INSERT INTO produto VALUES (7,'Chocolate com Paçoquinha',6.00,0,'Barra',1002)
INSERT INTO produto VALUES (8,'Galak',5.00,65,'Barra',1002)
INSERT INTO pedido VALUES (99001,33601,1,1,'07/03/2023')
INSERT INTO pedido VALUES (99001,33601,2,1,'07/03/2023')
INSERT INTO pedido VALUES (99001,33601,8,3,'07/03/2023')
INSERT INTO pedido VALUES (99002,33602,2,1,'09/03/2023')
INSERT INTO pedido VALUES (99002,33602,4,3,'09/03/2023')
INSERT INTO pedido VALUES (99003,33605,5,1,'15/03/2023')
GO
SELECT * FROM fornecedor
SELECT * FROM cliente
SELECT * FROM produto
SELECT * FROM pedido

-- 1. Consultar a quantidade, valor total e valor total com desconto (25%) dos itens comprados par Maria Clara.
SELECT 
    cliente.codigo AS num_cadastro,
    cliente.nome AS nome_cliente,
    pedido.quantidade AS quantidade,
    produto.valor_unitario AS valor_unitario,
    (pedido.quantidade * produto.valor_unitario) AS valor_total,
    (pedido.quantidade * produto.valor_unitario * 0.75) AS valor_com_desconto
FROM pedido
JOIN cliente ON pedido.cod_cli = cliente.codigo
JOIN produto ON pedido.cod_prod = produto.codigo
WHERE cliente.nome = 'Maria Clara';

-- 2. Consultar quais brinquedos não tem itens em estoque.
SELECT 
    produto.nome AS nome_produto,
    produto.qtd_estoque AS quantidade_estoque,
    fornecedor.nome AS nome_fornecedor
FROM produto
JOIN fornecedor ON produto.cod_forn = fornecedor.codigo
WHERE produto.qtd_estoque = 0
AND fornecedor.atividade LIKE '%Brinquedo%';

-- 3. Consultar quais nome e descrições de produtos que não estão em pedidos
SELECT 
    produto.nome AS nome_produto,
    produto.descricao AS descricao_produto
FROM produto
LEFT JOIN pedido ON produto.codigo = pedido.cod_prod
WHERE pedido.codigo IS NULL;

-- 4. Alterar a quantidade em estoque do faqueiro para 10 peças.
UPDATE produto
SET qtd_estoque = 10
WHERE nome = 'Faqueiro';

-- 5. Consultar Quantos clientes tem mais de 40 anos.
SELECT COUNT(*) AS numero_clientes_maior_40
FROM cliente
WHERE DATEDIFF(YEAR, cliente.data_nasc, GETDATE()) > 40;

-- 6. Consultar Nome e telefone (Formatado XXXX-XXXX) dos fornecedores de Brinquedos e Chocolate.
SELECT 
    fornecedor.nome AS nome_fornecedor,
    STUFF(STUFF(fornecedor.telefone, 5, 0, '-'), 9, 0, '-') AS telefone_formatado
FROM fornecedor
WHERE fornecedor.atividade IN ('Brinquedo', 'Chocolate');

-- 7. Consultar nome e desconto de 25% no preço dos produtos que custam menos de R$50,00
SELECT 
    produto.nome AS nome_produto,
    produto.valor_unitario AS valor_unitario,
    produto.valor_unitario * 0.75 AS valor_com_desconto
FROM produto
WHERE produto.valor_unitario < 50;

-- 8. Consultar nome e aumento de 10% no preço dos produtos que custam mais de R$100,00
SELECT 
    produto.nome AS nome_produto,
    produto.valor_unitario AS valor_unitario,
    produto.valor_unitario * 1.10 AS valor_com_aumento
FROM produto
WHERE produto.valor_unitario > 100;

-- 9. Consultar desconto de 15% no valor total de cada produto da venda 99001.
SELECT 
    produto.nome AS nome_produto,
    pedido.quantidade AS quantidade,
    produto.valor_unitario AS valor_unitario,
    pedido.quantidade * produto.valor_unitario AS valor_total,
    (pedido.quantidade * produto.valor_unitario) * 0.85 AS valor_com_desconto
FROM pedido
JOIN produto ON pedido.cod_prod = produto.codigo
WHERE pedido.codigo = 99001;

-- 10. Consultar Código do pedido, nome do cliente e idade atual do cliente
SELECT 
    pedido.codigo AS codigo_pedido,
    cliente.nome AS nome_cliente,
    DATEDIFF(YEAR, cliente.data_nasc, GETDATE()) - 
        CASE 
            WHEN MONTH(cliente.data_nasc) > MONTH(GETDATE()) 
                 OR (MONTH(cliente.data_nasc) = MONTH(GETDATE()) AND DAY(cliente.data_nasc) > DAY(GETDATE())) 
            THEN 1
            ELSE 0
        END AS idade_atual
FROM pedido
JOIN cliente ON pedido.cod_cli = cliente.codigo;

-- 11. Consultar o nome do fornecedor do produto mais caro
SELECT 
    fornecedor.nome AS nome_fornecedor
FROM produto
JOIN fornecedor ON produto.cod_forn = fornecedor.codigo
WHERE produto.valor_unitario = (SELECT MAX(valor_unitario) FROM produto);

-- 12. Consultar a média dos valores cujos produtos ainda estão em estoque
SELECT 
    AVG(produto.valor_unitario) AS media_valor_estoque
FROM produto
WHERE produto.qtd_estoque > 0;

--13. Consultar o nome do cliente, endereço composto por logradouro e número, o valor unitário do produto, o valor total (Quantidade * valor unitario) da compra do cliente de nome Maria Clara
SELECT 
    cliente.nome AS nome_cliente,
    CONCAT(cliente.logradouro, ' ', cliente.numero) AS endereco_completo,
    produto.valor_unitario AS valor_unitario,
    pedido.quantidade * produto.valor_unitario AS valor_total
FROM pedido
JOIN cliente ON pedido.cod_cli = cliente.codigo
JOIN produto ON pedido.cod_prod = produto.codigo
WHERE cliente.nome = 'Maria Clara';

-- 14. Considerando que o pedido de Maria Clara foi entregue 15/03/2023, consultar quantos dias houve de atraso. A cláusula do WHERE deve ser o nome da cliente.
SELECT 
    cliente.nome AS nome_cliente,
    DATEDIFF(DAY, pedido.previsao_ent, '2023-03-15') AS dias_atraso
FROM pedido
JOIN cliente ON pedido.cod_cli = cliente.codigo
WHERE cliente.nome = 'Maria Clara';

-- 15. Consultar qual a nova data de entrega para o pedido de Alberto% sabendo que se pediu 9 dias a mais. A cláusula do WHERE deve ser o nome do cliente. A data deve ser exibida no formato dd/mm/aaaa.
SELECT 
    cliente.nome AS nome_cliente,
    CONVERT(VARCHAR(10), DATEADD(DAY, 9, pedido.previsao_ent), 103) AS nova_data_entrega
FROM pedido
JOIN cliente ON pedido.cod_cli = cliente.codigo
WHERE cliente.nome = 'Alberto Souza';
