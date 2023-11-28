CREATE DATABASE EX03

GO

USE EX03

GO

CREATE TABLE Paciente (
    CPF         char(11)        not null,
    Nome        varchar(50)     not null,
    Rua         varchar(50)     not null,
    Numero      int             not null,
    Bairro      varchar(50)     not null,
    Telefone    char(8),
    Data_Nasc   date            not null,
    PRIMARY KEY (CPF)
)

GO

CREATE TABLE Medico (
    Codigo          int             not null,
    Nome            varchar(50)     not null,
    Especialidade   varchar(50)     not null,
    PRIMARY KEY (Codigo)
)

GO

CREATE TABLE Prontuario (
    Data            date            not null,
    CPFPaciente     char(11)        not null,
    CodigoMedico    int             not null,
    Diagnostico     varchar(50)     not null,
    Medicamento     varchar(50)     not null,
    PRIMARY KEY (Data, CPFPaciente, CodigoMedico),
    FOREIGN KEY (CPFPaciente) REFERENCES Paciente (CPF),
    FOREIGN KEY (CodigoMedico) REFERENCES Medico (Codigo)
)

GO

INSERT INTO Paciente(CPF, Nome, Rua, Numero, Bairro, Telefone, Data_Nasc)
VALUES 
  ('35454562890', 'José Rubens', 'Campos Salles', 2750, 'Centro', '21450998', '1954-10-18'),
  ('29865439810', 'Ana Claudia', 'Sete de Setembro', 178, 'Centro', '97382764', '1960-05-29'),
  ('82176534800', 'Marcos Aurélio', 'Timóteo Penteado', 236, 'Vila Galvão', '68172651', '1980-09-24'),
  ('12386758770', 'Maria Rita', 'Castello Branco', 7765, 'Vila Rosália', NULL, '1975-03-30'),
  ('92173458910', 'Joana de Souza', 'XV de Novembro', 298, 'Centro', '21276578', '1944-04-24')

GO

INSERT INTO Medico (Codigo, Nome, Especialidade)
VALUES 
  (1, 'Wilson Cesar', 'Pediatra'),
  (2, 'Marcia Matos', 'Geriatra'),
  (3, 'Carolina Oliveira', 'Ortopedista'),
  (4, 'Vinicius Araujo', 'Clínico Geral')

GO

INSERT INTO Prontuario(Data, CPFPaciente, CodigoMedico, Diagnostico, Medicamento)
VALUES 
  ('2020-09-10', '35454562890', 2, 'Reumatismo', 'Celebra'),
  ('2020-09-10', '92173458910', 2, 'Renite Alérgica', 'Allegra'),
  ('2020-09-12', '29865439810', 1, 'Inflamação de garganta', 'Nimesulida'),
  ('2020-09-13', '35454562890', 2, 'H1N1', 'Tamiflu'),
  ('2020-09-15', '82176534800', 4, 'Gripe', 'Resprin'),
  ('2020-09-15', '12386758770', 3, 'Braço Quebrado', 'Dorflex + Gesso')

GO

SELECT Nome + ' - ' + Rua + ' ' + CAST(Numero as varchar(10)) + ', ' + Bairro as Endereco
FROM Paciente
WHERE DATEDIFF(YEAR, Data_Nasc, GETDATE()) > 50

GO

SELECT Especialidade
FROM Medico
WHERE Nome = 'Carolina Oliveira'

GO

SELECT Medicamento
FROM Prontuario
WHERE Diagnostico = 'Reumatismo'

GO

SELECT Diagnostico, Medicamento
FROM Prontuario p, Paciente pc
WHERE pc.CPF = p.CPFPaciente
	  AND pc.Nome = 'José Rubens'

GO

SELECT DISTINCT m.Nome,
	   CASE WHEN (LEN(M.Especialidade) > 3) THEN
			SUBSTRING(M.Especialidade, 1, 3) + '.'
	   ELSE
			M.Especialidade
	   END AS Especialidade
FROM Medico m, Paciente pc , Prontuario p
WHERE pc.CPF = p.CPFPaciente
	  AND M.Codigo = p.CodigoMedico
	  AND PC.Nome = 'José Rubens'

GO

SELECT SUBSTRING(pc.CPF,1, 3) + '.' + SUBSTRING(pc.CPF,4, 3) + '.' + SUBSTRING(pc.CPF,7, 3) + '-' + SUBSTRING(pc.CPF,10, 2) as Cpf,
	   pc.Nome, pc.Rua + ', ' + CAST(pc.Numero as varchar(10)) + ' - ' + pc.Bairro as Endereco,
	   CASE WHEN pc.Telefone is null THEN
				'-'
	   ELSE
				pc.Numero
	   END AS Telefone
FROM Medico m, Paciente pc , Prontuario p
WHERE pc.CPF = p.CPFPaciente
	  AND m.Codigo = p.CodigoMedico
	  AND M.Nome like '%vinicius%'

GO

SELECT DATEDIFF(DAY,p.Data, GETDATE()) as QtdDias
FROM Prontuario p, Paciente pc
WHERE pc.CPF = p.CPFPaciente
	  AND pc.Nome like '%Maria Rita%'

GO

UPDATE Paciente
SET Telefone = '98345621'
WHERE Nome = 'Maria Rita'

GO 

UPDATE Paciente
SET Rua = 'Voluntários da Pátria', Numero = 1980, Bairro = 'Jd. Aeroporto'
WHERE Nome = 'Joana de Souza'


