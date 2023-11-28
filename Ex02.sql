CREATE DATABASE EX02

GO

USE EX02

GO

CREATE TABLE Carro (
placa		char(7)			not null,
marca		varchar(25)		not null,
modelo		varchar(25)		not null,
cor			varchar(25)		not null,
ano			int				not null
primary key(placa)
)

GO

CREATE TABLE Cliente (
nome		varchar(50)		not null,
logradouro	varchar(50)		not null,
numero		int				not null,
bairro		varchar(50)		not null,
telefone	char(11)		not null,
placaCarro	char(7)			not null
PRIMARY KEY(placaCarro)
foreign key	(placaCarro) references Carro (placa)
)

GO

CREATE TABLE Peca (
codigo		int				not null,
nome		varchar(50)		not null,
valor		decimal(7, 2)	not null,
PRIMARY KEY(codigo)
)

GO

CREATE TABLE Servico (
qtd				int				not null,
valor			decimal(7, 2)	not null,
dataServico		date			not null,
codigoPeca		int				not null,
placaCarro		char(7)			not null
PRIMARY KEY (dataServico, codigoPeca, placaCarro)
FOREIGN KEY (codigoPeca) REFERENCES Peca (codigo),
FOREIGN KEY (placaCarro) REFERENCES Carro (placa)
)

GO 

INSERT INTO Carro (placa, marca, modelo, cor, ano) VALUES 
  ('AFT9087', 'VW', 'Gol', 'Preto', 2007),
  ('DXO9876', 'Ford', 'Ka', 'Azul', 2000),
  ('EGT4631', 'Renault', 'Clio', 'Verde', 2004),
  ('LKM7380', 'Fiat', 'Palio', 'Prata', 1997),
  ('BCD7521', 'Ford', 'Fiesta', 'Preto', 1999)

GO

INSERT INTO Cliente (nome, logradouro, numero, bairro, telefone, placaCarro) VALUES 
  ('João Alves', 'R. Pereira Barreto', 1258, 'Jd. Oliveiras', '2154-9658', 'DXO9876'),
  ('Ana Maria', 'R. 7 de Setembro', 259, 'Centro', '9658-8541', 'LKM7380'),
  ('Clara Oliveira', 'Av. Nações Unidas', 10254, 'Pinheiros', '2458-9658', 'EGT4631'),
  ('José Simões', 'R. XV de Novembro', 36, 'Água Branca', '7895-2459', 'BCD7521'),
  ('Paula Rocha', 'R. Anhaia', 548, 'Barra Funda', '6958-2548', 'AFT9087');

GO 

INSERT INTO Peca (codigo, nome, valor) VALUES 
  (1, 'Vela', 70),
  (2, 'Correia Dentada', 125),
  (3, 'Trambulador', 90),
  (4, 'Filtro de Ar', 30)

GO

INSERT INTO Servico (placaCarro, qtd, codigoPeca, valor, dataServico)
VALUES 
  ('DXO9876', 1, 4, 280, '2020-08-01'),
  ('DXO9876', 4, 1, 30, '2020-08-01'),
  ('EGT4631', 3, 1, 90, '2020-08-02'),
  ('DXO9876', 2, 2, 125, '2020-08-07');


GO

SELECT cl.telefone
FROM Cliente cl, Carro c
WHERE c.placa = cl.placaCarro
	  AND c.modelo = 'ka'


GO

SELECT cl.logradouro + ' ' + CAST(cl.numero as varchar(10)) + ', ' + cl.bairro as Endereco
FROM Cliente cl, Carro c, Servico s
WHERE c.placa = cl.placaCarro
	  AND c.placa = s.placaCarro
	  AND s.dataServico = '2020-08-02'

GO

SELECT placa
FROM Carro
WHERE ano < 2001

GO

SELECT marca + ' ' + modelo + ' ' + cor AS CARRO
FROM Carro
WHERE ano > 2005

GO

SELECT codigo, nome
FROM Peca
WHERE valor < 80.00


