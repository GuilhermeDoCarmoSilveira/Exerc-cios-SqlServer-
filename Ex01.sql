CREATE DATABASE EX01

GO

USE EX01

GO

CREATE TABLE Aluno (
ra			int				not null,
nome		varchar(30)		not null,
sobrenome	varchar(30)		not null,
rua			varchar(50)		not null,
numero		int				not null,
bairro		varchar(30)		not null,
cep			char(8)			not null,
telefone	char(11)		null
PRIMARY KEY(ra)
)

GO

CREATE TABLE Curso (
codigoCurso		int				not null,
nome			varchar(30)		not null,
cargaHoraria	int				not null,
turno			varchar(20)		not null
PRIMARY KEY(codigoCurso)
)

GO

CREATE TABLE Disciplina (
codigoDisciplina			int			not null,
nome					varchar(30)		not null,
cargaHoraria			int				not null,
turno					varchar(20)		not null,
semestre				int				not null
PRIMARY KEY(codigoDisciplina)
)


INSERT INTO Aluno VALUES
(12345, 'José', 'Silva', 'Almirante Noronha',236 ,'Jardim São Paulo', '1589000', '69875287'),
(12346,	'Ana',	'Maria Bastos',	'Anhaia', 1568,	'Barra Funda', '3569000', '25698526'),
(12348,	'Marcia', 'Neves', 'Voluntários da Patria',	225, 'Santana', '2785090', '78964152')

GO

INSERT INTO Aluno VALUES 
(12347,	'Mario', 'Santos', 'XV de Novembro', '1841', 'Centro', '1020030', NULL)	

GO

INSERT INTO Curso VALUES
(1, 'Informática', 2800, 'Tarde'),
(2,	'Informática',	2800, 'Noite'),
(3,	'Logística', 2650, 'Tarde'),
(4, 'Logística', 2650, 'Noite'),
(5,	'Plásticos', 2500, 'Tarde'),
(6,	'Plásticos', 2500, 'Noite')

GO

INSERT INTO Disciplina VALUES
(1,	'Informática', 4, 'Tarde',	1),
(2,	'Informática', 4, 'Noite',	1),
(3,	'Quimica', 4, 'Tarde',	1),
(4, 'Quimica', 4, 'Noite',	1),
(5, 'Banco de Dados I',2, 'Tarde',	3),
(6, 'Banco de Dados I',2, 'Noite',	3),
(7,	'Estrutura de Dados',4,	'Tarde',	4),
(8,	'Estrutura de Dados',4,	'Noite'	,4)


GO

SELECT nome + sobrenome AS NomeCompleto
FROM Aluno

GO

SELECT rua + ', '+ cast(numero as varchar(10)) + ' ' + bairro + ', '+ cep
FROM Aluno
WHERE telefone is null

GO

SELECT telefone
FROM Aluno
WHERE ra = 12348

GO

SELECT nome, turno
FROM Curso
WHERE cargaHoraria = 2800

GO

SELECT semestre
FROM Disciplina
WHERE nome = 'Banco de Dados I' AND turno = 'Noite'


