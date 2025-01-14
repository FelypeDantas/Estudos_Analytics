CREATE DATABASE plataforma_projetos
GO
USE plataforma_projetos
GO
CREATE TABLE projects(
id						INT			     NOT NULL IDENTITY(10001,1),
name_project			VARCHAR(45)      NOT NULL,
description_project		VARCHAR(45)      NULL,
date_project			DATE			 NOT NULL CHECK(date_project > '01/09/2014')
PRIMARY KEY(id)
)
GO
CREATE TABLE users(
id				INT					NOT NULL IDENTITY(1,1),
name_user		VARCHAR(45)			NOT NULL,
username		VARCHAR(45)			NOT NULL,
password_user	VARCHAR(45)			NOT NULL DEFAULT '123mudar',
email			VARCHAR(45)			NOT NULL
CONSTRAINT username_unique UNIQUE(username), 
PRIMARY KEY (id)
)
GO
ALTER TABLE users
DROP CONSTRAINT username_unique;
GO
ALTER TABLE users
ALTER COLUMN username VARCHAR(10) NOT NULL;
GO
ALTER TABLE users
ADD CONSTRAINT username_unique UNIQUE(username);
GO
ALTER TABLE users 
ALTER COLUMN password_user VARCHAR(8) NOT NULL;
GO
CREATE TABLE users_has_projects(
users_id		INT			NOT NULL,
projects_id		INT			NOT NULL
PRIMARY KEY(users_id, projects_id)
FOREIGN KEY(users_id) REFERENCES users(id),
FOREIGN KEY(projects_id) REFERENCES projects(id)
)
GO
INSERT INTO users VALUES
('Maria',	'Rh_maria',	'123mudar','maria@empresa.com'),
('Paulo',   'Ti_paulo', '123@456', 'paulo@empresa.com'),
('Ana',     'Rh_ana',   '123mudar','ana@empresa.com'),
('Clara',   'Ti_clara', '123mudar','clara@empresa.com'),
('Aparecido','Rh_apareci','55@!cido','aparecido@empresa.com')
GO
INSERT INTO projects VALUES
('Re-folha',		'Refatoração das Folhas', '05/09/2014'),
('Manutenção PCs',	'Manutenção PCs',	      '06/09/2014'),
('Auditoria',        NULL,                    '07/09/2014')
GO
INSERT INTO users_has_projects VALUES
(1,10001),
(5,10001),
(3,10003),
(4,10002),
(2,10002)

UPDATE projects SET
date_project = '12/09/2014'
WHERE name_project LIKE '%Manutenção PCs%'

UPDATE users SET
username = 'Rh_cido'
WHERE name_user = 'Aparecido'
--------------------

UPDATE users SET
password_user = '888@*'
WHERE username = 'Rh_maria' AND password_user = '123mudar'
-------------

DELETE FROM users_has_projects
WHERE users_id = 2 AND projects_id = 10002