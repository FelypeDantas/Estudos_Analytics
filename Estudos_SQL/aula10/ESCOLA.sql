/*criação do banco ESCOLA*/

create database ESCOLA;
use ESCOLA;


create table tabalunos(
matricula int auto_increment primary key,
nome varchar(30) not null,
sexo char(1) default "M",
datanasc date,
curso char(3),
nota1 decimal(5,2),
nota2 decimal(5,2)
);


/*insere dados na tabela*/
insert into tabalunos (nome,datanasc,curso,nota1,nota2) values
("Renato Paiva", "1998-10-10","ADS",6,7),
("Marcelo Guimaraes","1997-10-20", "SEG", 5,8),
("Alexandre Cardoso", "1998-01-10","ADS", 8, 10),
("Carlos Carvalho","1996-05-20", "SEG", 6.5, 8.5),
("Paulo Pavanini", "1995-08-15","ADS", 7,9);


insert into tabalunos (nome, sexo,datanasc, curso, nota1, nota2) values
("Mariana Menezes", "F","1998-12-25","ADS", 4,8),
("Deise Guimaraes","F", "1997-01-25","SEG", 5, 8),
("Ana Luiza Santos","F", "1996-05-13","JOG",8,8.5),
("Vera Mendes","F","1997-11-01","COM",6,6.5),
("Juliana Santos","F", "1998-08-20","ADS",8,4);