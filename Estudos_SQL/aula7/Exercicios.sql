create database exercicio13 
go
use exercicio13
go
create table empresa(
id int identity not null primary key,
nome varchar(50))
go
create table carro(
id int identity(1001,1) not null primary key,
marca varchar(50),
modelo varchar(50), 
idEmpresa int
foreign key (idEmpresa) references empresa(id))
go
create table viagem(
idCarro int not null,
distanciaPercorrida decimal(7,2),
data datetime not null
primary key (idCarro, data)
foreign key (idCarro) references carro(id))
go
insert into empresa(nome) values
('Empresa 1'),
('Empresa 2'),
('Empresa 3'),
('Empresa 4'),
('Empresa 5'),
('Empresa 6')
go
insert into carro(idEmpresa, marca, modelo) values
(1,'Fiat', 'Uno'),
(1,'Renault', 'Sandero'),
(1,'Chevrolet','Celta'),
(1,'Fiat', 'Palio'),
(1,'Peugeot','307'),
(1,'Renault', 'Duster'),
(2,'Fiat', 'Bravo'),
(2,'Renault', 'Logan'),
(4,'Peugeot','207'),
(4,'Renault', 'Duster'),
(6,'Chevrolet','Celta'),
(6,'Fiat', 'Doblo'),
(6,'Volksvagen', 'Jetta')
go
INSERT INTO viagem VALUES
(1006,97,CAST(N'2022-05-01' AS Date)),
(1005,2090,CAST(N'2022-05-02' AS Date)),
(1005,3387,CAST(N'2022-05-03' AS Date)),
(1005,487,CAST(N'2022-05-04' AS Date)),
(1004,3141,CAST(N'2022-05-05' AS Date)),
(1006,1895,CAST(N'2022-05-06' AS Date)),
(1005,3050,CAST(N'2022-05-07' AS Date)),
(1003,1974,CAST(N'2022-05-08' AS Date)),
(1005,1779,CAST(N'2022-05-09' AS Date)),
(1006,1727,CAST(N'2022-05-10' AS Date)),
(1002,641,CAST(N'2022-05-11' AS Date)),
(1004,1577,CAST(N'2022-05-12' AS Date)),
(1003,2697,CAST(N'2022-05-13' AS Date)),
(1005,832,CAST(N'2022-05-14' AS Date)),
(1002,2033,CAST(N'2022-05-15' AS Date)),
(1003,1930,CAST(N'2022-05-16' AS Date)),
(1005,2606,CAST(N'2022-05-17' AS Date)),
(1002,1424,CAST(N'2022-05-18' AS Date)),
(1005,2484,CAST(N'2022-05-19' AS Date)),
(1005,2711,CAST(N'2022-05-20' AS Date)),
(1003,3049,CAST(N'2022-05-21' AS Date)),
(1003,2446,CAST(N'2022-05-22' AS Date)),
(1003,1307,CAST(N'2022-05-23' AS Date)),
(1003,778,CAST(N'2022-05-24' AS Date)),
(1003,2202,CAST(N'2022-05-25' AS Date)),
(1004,2571,CAST(N'2022-05-26' AS Date)),
(1005,2736,CAST(N'2022-05-27' AS Date)),
(1003,3128,CAST(N'2022-05-28' AS Date)),
(1002,2513,CAST(N'2022-05-29' AS Date)),
(1006,1201,CAST(N'2022-05-30' AS Date)),
(1002,3319,CAST(N'2022-05-31' AS Date)),
(1006,2755,CAST(N'2022-06-01' AS Date)),
(1004,864,CAST(N'2022-06-02' AS Date)),
(1004,1833,CAST(N'2022-06-03' AS Date)),
(1004,1265,CAST(N'2022-06-04' AS Date)),
(1006,1670,CAST(N'2022-06-05' AS Date)),
(1006,3037,CAST(N'2022-06-06' AS Date)),
(1004,3134,CAST(N'2022-06-07' AS Date)),
(1002,358,CAST(N'2022-06-08' AS Date)),
(1003,2531,CAST(N'2022-06-09' AS Date)),
(1004,1515,CAST(N'2022-06-10' AS Date)),
(1005,3461,CAST(N'2022-06-11' AS Date)),
(1001,2963,CAST(N'2022-06-12' AS Date)),
(1003,2240,CAST(N'2022-06-13' AS Date)),
(1004,3403,CAST(N'2022-06-14' AS Date)),
(1001,621,CAST(N'2022-06-15' AS Date)),
(1005,1264,CAST(N'2022-06-16' AS Date)),
(1006,1121,CAST(N'2022-06-17' AS Date)),
(1005,88,CAST(N'2022-06-18' AS Date)),
(1006,2721,CAST(N'2022-06-19' AS Date)),
(1001,1146,CAST(N'2022-06-20' AS Date)),
(1005,515,CAST(N'2022-06-21' AS Date)),
(1005,3060,CAST(N'2022-06-22' AS Date)),
(1006,641,CAST(N'2022-06-23' AS Date)),
(1004,2037,CAST(N'2022-06-24' AS Date)),
(1006,2595,CAST(N'2022-06-25' AS Date)),
(1001,3064,CAST(N'2022-06-26' AS Date)),
(1002,2551,CAST(N'2022-06-27' AS Date)),
(1005,1380,CAST(N'2022-06-28' AS Date)),
(1001,611,CAST(N'2022-06-29' AS Date)),
(1002,2759,CAST(N'2022-06-30' AS Date)),
(1001,537,CAST(N'2022-07-01' AS Date)),
(1003,2581,CAST(N'2022-07-02' AS Date)),
(1004,3289,CAST(N'2022-07-03' AS Date)),
(1005,3335,CAST(N'2022-07-04' AS Date)),
(1004,3273,CAST(N'2022-07-05' AS Date)),
(1005,1736,CAST(N'2022-07-06' AS Date)),
(1006,2259,CAST(N'2022-07-07' AS Date)),
(1006,2269,CAST(N'2022-07-08' AS Date)),
(1002,2881,CAST(N'2022-07-09' AS Date)),
(1005,888,CAST(N'2022-07-10' AS Date)),
(1003,476,CAST(N'2022-07-11' AS Date)),
(1006,2944,CAST(N'2022-07-12' AS Date)),
(1002,373,CAST(N'2022-07-13' AS Date)),
(1005,1885,CAST(N'2022-07-14' AS Date)),
(1005,3416,CAST(N'2022-07-15' AS Date)),
(1004,1370,CAST(N'2022-07-16' AS Date)),
(1005,560,CAST(N'2022-07-17' AS Date)),
(1002,657,CAST(N'2022-07-18' AS Date)),
(1006,297,CAST(N'2022-07-19' AS Date)),
(1001,1661,CAST(N'2022-07-20' AS Date)),
(1005,2218,CAST(N'2022-07-21' AS Date)),
(1003,381,CAST(N'2022-07-22' AS Date)),
(1005,3284,CAST(N'2022-07-23' AS Date)),
(1004,771,CAST(N'2022-07-24' AS Date)),
(1002,1583,CAST(N'2022-07-25' AS Date)),
(1005,1841,CAST(N'2022-07-26' AS Date)),
(1005,2210,CAST(N'2022-07-27' AS Date)),
(1001,1512,CAST(N'2022-07-28' AS Date)),
(1004,1913,CAST(N'2022-07-29' AS Date)),
(1003,1065,CAST(N'2022-07-30' AS Date)),
(1006,3109,CAST(N'2022-07-31' AS Date)),
(1005,3393,CAST(N'2022-08-01' AS Date)),
(1003,1791,CAST(N'2022-08-02' AS Date)),
(1004,2652,CAST(N'2022-08-03' AS Date)),
(1002,1588,CAST(N'2022-08-04' AS Date)),
(1004,3154,CAST(N'2022-08-05' AS Date)),
(1005,2322,CAST(N'2022-08-06' AS Date)),
(1005,2750,CAST(N'2022-08-07' AS Date)),
(1006,460,CAST(N'2022-08-08' AS Date)),
(1004,465,CAST(N'2022-08-09' AS Date)),
(1006,2459,CAST(N'2022-08-10' AS Date)),
(1006,2354,CAST(N'2022-08-11' AS Date)),
(1006,1320,CAST(N'2022-08-12' AS Date)),
(1001,1478,CAST(N'2022-08-13' AS Date)),
(1003,2736,CAST(N'2022-08-14' AS Date)),
(1004,1908,CAST(N'2022-08-15' AS Date)),
(1005,1823,CAST(N'2022-08-16' AS Date)),
(1002,3202,CAST(N'2022-08-17' AS Date)),
(1001,2952,CAST(N'2022-08-18' AS Date)),
(1002,339,CAST(N'2022-08-19' AS Date)),
(1006,1092,CAST(N'2022-08-20' AS Date)),
(1003,1607,CAST(N'2022-08-21' AS Date)),
(1002,991,CAST(N'2022-08-22' AS Date)),
(1001,2123,CAST(N'2022-08-23' AS Date)),
(1001,1963,CAST(N'2022-08-24' AS Date)),
(1001,3359,CAST(N'2022-08-25' AS Date)),
(1006,119,CAST(N'2022-08-26' AS Date)),
(1003,1635,CAST(N'2022-08-27' AS Date)),
(1001,364,CAST(N'2022-08-28' AS Date)),
(1001,2672,CAST(N'2022-08-29' AS Date)),
(1005,324,CAST(N'2022-08-30' AS Date)),
(1002,1402,CAST(N'2022-08-31' AS Date)),
(1004,2902,CAST(N'2022-09-01' AS Date)),
(1004,1842,CAST(N'2022-09-02' AS Date)),
(1001,1113,CAST(N'2022-09-03' AS Date)),
(1005,373,CAST(N'2022-09-04' AS Date)),
(1002,157,CAST(N'2022-09-05' AS Date)),
(1002,1816,CAST(N'2022-09-06' AS Date)),
(1001,2413,CAST(N'2022-09-07' AS Date)),
(1003,1702,CAST(N'2022-09-08' AS Date)),
(1002,1871,CAST(N'2022-09-09' AS Date)),
(1006,3234,CAST(N'2022-09-10' AS Date)),
(1006,3165,CAST(N'2022-09-11' AS Date)),
(1004,360,CAST(N'2022-09-12' AS Date)),
(1004,1491,CAST(N'2022-09-13' AS Date)),
(1006,2653,CAST(N'2022-09-14' AS Date)),
(1002,886,CAST(N'2022-09-15' AS Date)),
(1001,1567,CAST(N'2022-09-16' AS Date)),
(1002,2642,CAST(N'2022-09-17' AS Date)),
(1006,1839,CAST(N'2022-09-18' AS Date)),
(1002,3418,CAST(N'2022-09-19' AS Date)),
(1004,1959,CAST(N'2022-09-20' AS Date)),
(1001,540,CAST(N'2022-09-21' AS Date)),
(1003,2510,CAST(N'2022-09-22' AS Date)),
(1002,2916,CAST(N'2022-09-23' AS Date)),
(1001,1519,CAST(N'2022-09-24' AS Date)),
(1006,241,CAST(N'2022-09-25' AS Date)),
(1003,728,CAST(N'2022-09-26' AS Date)),
(1003,1511,CAST(N'2022-09-27' AS Date)),
(1004,1738,CAST(N'2022-09-28' AS Date)),
(1002,646,CAST(N'2022-09-29' AS Date)),
(1003,253,CAST(N'2022-09-30' AS Date)),
(1006,2714,CAST(N'2022-10-01' AS Date)),
(1001,2114,CAST(N'2022-10-02' AS Date)),
(1004,725,CAST(N'2022-10-03' AS Date)),
(1010,348,CAST(N'2022-09-01' AS Date)),
(1008,194,CAST(N'2022-09-02' AS Date)),
(1012,1250,CAST(N'2022-09-03' AS Date)),
(1007,1291,CAST(N'2022-09-04' AS Date)),
(1009,1879,CAST(N'2022-09-05' AS Date)),
(1007,2466,CAST(N'2022-09-06' AS Date)),
(1010,900,CAST(N'2022-09-07' AS Date)),
(1011,2743,CAST(N'2022-09-08' AS Date)),
(1011,769,CAST(N'2022-09-09' AS Date)),
(1010,3284,CAST(N'2022-09-10' AS Date)),
(1009,811,CAST(N'2022-09-11' AS Date)),
(1010,434,CAST(N'2022-09-12' AS Date)),
(1007,1271,CAST(N'2022-09-13' AS Date)),
(1008,1492,CAST(N'2022-09-14' AS Date)),
(1008,3047,CAST(N'2022-09-15' AS Date)),
(1007,2305,CAST(N'2022-09-16' AS Date)),
(1007,2886,CAST(N'2022-09-17' AS Date)),
(1008,3226,CAST(N'2022-09-18' AS Date)),
(1011,1542,CAST(N'2022-09-19' AS Date)),
(1007,2150,CAST(N'2022-09-20' AS Date)),
(1011,1897,CAST(N'2022-09-21' AS Date)),
(1011,3022,CAST(N'2022-09-22' AS Date)),
(1007,3495,CAST(N'2022-09-23' AS Date)),
(1011,365,CAST(N'2022-09-24' AS Date)),
(1007,3265,CAST(N'2022-09-25' AS Date)),
(1011,2938,CAST(N'2022-09-26' AS Date)),
(1012,2136,CAST(N'2022-09-27' AS Date)),
(1008,891,CAST(N'2022-09-28' AS Date)),
(1011,833,CAST(N'2022-09-29' AS Date)),
(1009,1528,CAST(N'2022-09-30' AS Date)),
(1008,952,CAST(N'2022-10-01' AS Date)),
(1007,2310,CAST(N'2022-10-02' AS Date)),
(1008,1657,CAST(N'2022-10-03' AS Date)),
(1007,2007,CAST(N'2022-10-04' AS Date)),
(1007,2657,CAST(N'2022-10-05' AS Date)),
(1007,1509,CAST(N'2022-10-06' AS Date)),
(1010,737,CAST(N'2022-10-07' AS Date)),
(1008,2156,CAST(N'2022-10-08' AS Date)),
(1008,3263,CAST(N'2022-10-09' AS Date)),
(1007,1329,CAST(N'2022-10-10' AS Date)),
(1007,140,CAST(N'2022-10-11' AS Date)),
(1010,1701,CAST(N'2022-10-12' AS Date)),
(1009,3300,CAST(N'2022-10-13' AS Date)),
(1010,1324,CAST(N'2022-10-14' AS Date)),
(1011,1936,CAST(N'2022-10-15' AS Date)),
(1010,2961,CAST(N'2022-10-16' AS Date)),
(1007,781,CAST(N'2022-10-17' AS Date)),
(1012,3296,CAST(N'2022-10-18' AS Date)),
(1007,174,CAST(N'2022-10-19' AS Date)),
(1012,2894,CAST(N'2022-10-20' AS Date)),
(1009,2965,CAST(N'2022-10-21' AS Date)),
(1010,452,CAST(N'2022-10-22' AS Date)),
(1012,2077,CAST(N'2022-10-23' AS Date)),
(1009,2581,CAST(N'2022-10-24' AS Date)),
(1011,1503,CAST(N'2022-10-25' AS Date)),
(1008,1382,CAST(N'2022-10-26' AS Date)),
(1012,3379,CAST(N'2022-10-27' AS Date)),
(1010,351,CAST(N'2022-10-28' AS Date)),
(1007,553,CAST(N'2022-10-29' AS Date)),
(1011,1660,CAST(N'2022-10-30' AS Date)),
(1008,1045,CAST(N'2022-10-31' AS Date)),
(1008,1919,CAST(N'2022-11-01' AS Date)),
(1010,922,CAST(N'2022-11-02' AS Date)),
(1010,2983,CAST(N'2022-11-03' AS Date)),
(1012,1229,CAST(N'2022-11-04' AS Date)),
(1010,3083,CAST(N'2022-11-05' AS Date)),
(1010,1318,CAST(N'2022-11-06' AS Date)),
(1011,3018,CAST(N'2022-11-07' AS Date)),
(1011,2227,CAST(N'2022-11-08' AS Date)),
(1011,3304,CAST(N'2022-11-09' AS Date)),
(1011,2078,CAST(N'2022-11-10' AS Date)),
(1008,3388,CAST(N'2022-11-11' AS Date)),
(1007,1136,CAST(N'2022-11-12' AS Date)),
(1007,2043,CAST(N'2022-11-13' AS Date)),
(1009,2224,CAST(N'2022-11-14' AS Date)),
(1007,1413,CAST(N'2022-11-15' AS Date)),
(1008,496,CAST(N'2022-11-16' AS Date)),
(1008,3370,CAST(N'2022-11-17' AS Date)),
(1008,1524,CAST(N'2022-11-18' AS Date)),
(1008,2996,CAST(N'2022-11-19' AS Date)),
(1007,502,CAST(N'2022-11-20' AS Date)),
(1010,2314,CAST(N'2022-11-21' AS Date)),
(1007,1946,CAST(N'2022-11-22' AS Date)),
(1007,1042,CAST(N'2022-11-23' AS Date)),
(1007,141,CAST(N'2022-11-24' AS Date)),
(1011,1967,CAST(N'2022-11-25' AS Date)),
(1012,585,CAST(N'2022-11-26' AS Date)),
(1010,737,CAST(N'2022-11-27' AS Date)),
(1010,504,CAST(N'2022-11-28' AS Date)),
(1011,2351,CAST(N'2022-11-29' AS Date)),
(1008,1046,CAST(N'2022-11-30' AS Date)),
(1008,3117,CAST(N'2022-12-01' AS Date)),
(1008,229,CAST(N'2022-12-02' AS Date)),
(1008,3079,CAST(N'2022-12-03' AS Date)),
(1011,339,CAST(N'2022-12-04' AS Date)),
(1010,2335,CAST(N'2022-12-05' AS Date)),
(1007,3139,CAST(N'2022-12-06' AS Date)),
(1011,1632,CAST(N'2022-12-07' AS Date)),
(1010,3253,CAST(N'2022-12-08' AS Date)),
(1010,265,CAST(N'2022-12-09' AS Date))		
go
select * from carro
select * from empresa
select * from viagem

--Exercícios
--1)Apresentar marca e modelo de carro e a soma total da distância percorrida pelos carros,
--em viagens, de uma dada empresa, ordenado pela distância percorrida
SELECT
	carro.marca AS marca,
	carro.modelo AS modelo,
	SUM(viagem.distanciaPercorrida) AS [distancia soma total]
FROM carro
INNER JOIN viagem ON viagem.idCarro = carro.id
INNER JOIN empresa ON empresa.id = carro.idEmpresa
GROUP BY carro.marca, carro.modelo
ORDER BY [distancia soma total] DESC

--2)Apresentar nome das empresas cuja soma total da distância percorrida pelos carros,
--em viagens, é superior a 50000 km
SELECT
	empresa.nome AS [nome empresa],
	SUM(viagem.distanciaPercorrida) AS [distancia percorrida]
FROM empresa
INNER JOIN carro ON carro.idEmpresa = empresa.id
INNER JOIN viagem ON viagem.idCarro = carro.id
GROUP BY empresa.nome
HAVING  SUM(viagem.distanciaPercorrida) > 50000

--3)Apresentar nome das empresas cuja soma total da distância percorrida pelos carros
--e a media das distâncias percorridas por seus carros em viagens.
--A média deve ser exibida em uma coluna chamada mediaDist e com 2 casas decimais apenas.
--Deve-se ordenar a saída pela média descrescente
SELECT
	empresa.nome AS [nome da empresa],
	SUM(viagem.distanciaPercorrida) AS [distancia percorrida],
	FORMAT(AVG(viagem.distanciaPercorrida), 'N2') AS mediaDist
FROM empresa
INNER JOIN carro ON carro.idEmpresa = empresa.id
INNER JOIN viagem ON viagem.idCarro = carro.id
GROUP BY empresa.nome
ORDER BY mediaDist DESC

--4)Apresentar nome das empresas cujos carro percorreram a maior distância dentre as cadastradas
SELECT
	empresa.nome AS [nome empresa],
	viagem.distanciaPercorrida AS [distancia percorrida]
FROM empresa
INNER JOIN carro ON carro.idEmpresa = empresa.id
INNER JOIN viagem ON viagem.idCarro = carro.id
WHERE viagem.distanciaPercorrida IN (
	SELECT MAX(distanciaPercorrida)
	FROM viagem
)

--5)Apresentar nome das empresas e a quantidade de carros cadastrados para cada empresa
--Desde que a empresa tenha 3 ou mais carros
--A saída deve ser ordenada pela quantidade de carros, descrescente
SELECT
	empresa.nome AS [nome da empresa],
	COUNT(carro.id) AS [quantidade carros]
FROM empresa
INNER JOIN carro ON carro.idEmpresa = empresa.id
GROUP BY empresa.nome
HAVING COUNT(carro.id) >= 3
ORDER BY [quantidade carros] DESC

--6)Consultar Nomes das empresas que não tem carros cadastrados
SELECT
	empresa.nome AS [nome empresa]
FROM empresa
LEFT OUTER JOIN carro ON carro.idEmpresa = empresa.id
WHERE carro.id IS NULL

--7)Consultar Marca e modelos dos carros que não fizeram viagens
SELECT DISTINCT
	carro.marca AS [MARCA DO CARRO],
	carro.modelo AS [MODELO DO CARRO]
FROM carro
LEFT OUTER JOIN viagem ON viagem.idCarro = carro.id

--8)Consultar quantas viagens foram feitas por cada carro (marca e modelo) de cada empresa
--em ordem ascendente de nome de empresa e descendente de quantidade
SELECT
    carro.marca AS [MARCA DO CARRO],
    carro.modelo AS [MODELO DO CARRO],
    COUNT(viagem.data) AS viagens,
    empresa.nome AS empresa
FROM carro
INNER JOIN viagem ON viagem.idCarro = carro.id
INNER JOIN empresa ON empresa.id = carro.idEmpresa
GROUP BY carro.marca, carro.modelo, empresa.nome
ORDER BY empresa.nome ASC, viagens DESC;

--9) Consultar o nome da empresa, a marca e o modelo do carro, a distância percorrida
--e o valor total ganho por viagem, sabendo que para distâncias inferiores a 1000 km, o valor é R$10,00
--por km e para viagens superiores a 1000 km, o valor é R$15,00 por km.
SELECT DISTINCT
    empresa.nome AS [NOME DA EMPRESA],
    carro.marca AS [MARCA DO CARRO],
    carro.modelo AS [MODELO DO CARRO],
    viagem.distanciaPercorrida AS distancia,
    CASE
        WHEN viagem.distanciaPercorrida < 1000 THEN viagem.distanciaPercorrida * 10
        ELSE viagem.distanciaPercorrida * 15
    END AS valor_total
FROM carro
INNER JOIN viagem ON viagem.idCarro = carro.id
INNER JOIN empresa ON empresa.id = carro.idEmpresa;

--10) Apresentar o nome da empresa e a média de distância percorrida por seus carros. 
-- A saída da média deve ter até 2 casas decimais e deve ser ordenada pela média da distância percorrida 
SELECT
	empresa.nome AS [NOME DA EMPRESA],
	FORMAT(AVG(viagem.distanciaPercorrida), 'N2') AS [média da distância]
FROM empresa
INNER JOIN carro ON carro.idEmpresa = empresa.id
INNER JOIN viagem ON viagem.idCarro = carro.id
GROUP BY empresa.nome
ORDER BY AVG(viagem.distanciaPercorrida);

--11) Apresentar marca e modelo do carro, além do nome da empresa e a data no formato (DD/MM/AAAA) do carro que fez a última viagem dentre os cadastrados
WITH UltimaViagem AS (
    SELECT
        carro.marca AS [MARCA DO CARRO],
        carro.modelo AS [MODELO DO CARRO],
        empresa.nome AS [NOME DA EMPRESA],
        viagem.data AS [DATA DA VIAGEM],
        ROW_NUMBER() OVER (ORDER BY viagem.data DESC) AS rn
    FROM empresa
    INNER JOIN carro ON carro.idEmpresa = empresa.id
    INNER JOIN viagem ON viagem.idCarro = carro.id
)
SELECT
    [MARCA DO CARRO],
    [MODELO DO CARRO],
    [NOME DA EMPRESA],
    FORMAT([DATA DA VIAGEM], 'dd/MM/yyyy') AS [DATA DA ÚLTIMA VIAGEM]
FROM UltimaViagem
WHERE rn = 1;

--12) Considerando que hoje é 01/01/2023, apresentar a marca e o modelo do carro,
-- além do nome da empresa e a quantidade de dias da viagem, dos carros que tiveram viagens
-- nos últimos 3 meses. Ordenar (todos ascendentes) por quantidade de dias, marca, modelo e 
-- nome da empresa.
SELECT
    carro.marca AS [MARCA DO CARRO],
    carro.modelo AS [MODELO DO CARRO],
    empresa.nome AS [NOME DA EMPRESA],
    DATEDIFF(DAY, viagem.data, '2023-01-01') AS [QUANTIDADE DE DIAS DA VIAGEM]
FROM empresa
INNER JOIN carro ON carro.idEmpresa = empresa.id
INNER JOIN viagem ON viagem.idCarro = carro.id
WHERE viagem.data >= '2022-10-01' 
ORDER BY [QUANTIDADE DE DIAS DA VIAGEM] ASC, carro.marca ASC, carro.modelo ASC, empresa.nome ASC;

