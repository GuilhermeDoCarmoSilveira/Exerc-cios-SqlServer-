CREATE DATABASE EX06

GO

USE EX06

GO

CREATE TABLE motorista (
    codigo          int             not null,
    nome            varchar(50)     not null,
    data_nascimento date            not null,
    naturalidade    varchar(50)     not null,
    PRIMARY KEY (codigo)
)

GO

CREATE TABLE onibus (
    placa        char(7)         not null,
    marca        varchar(50)     not null,
    ano          int             not null,
    descricao    varchar(50)     not null,
    PRIMARY KEY (placa)
)

GO

CREATE TABLE viagem (
    codigo           int             not null,
    onibus           char(7)         not null,
    motorista        int             not null,
    hora_saida       varchar(5)      not null,
    hora_chegada     varchar(5)      not null,
    destino          varchar(50)     not null,
    PRIMARY KEY (codigo),
    FOREIGN KEY (onibus) REFERENCES onibus (placa),
    FOREIGN KEY (motorista) REFERENCES motorista (codigo)
)

GO

INSERT INTO motorista (codigo, nome, data_nascimento, naturalidade)
VALUES 
  (12341, 'Julio Cesar', '1978-04-18', 'São Paulo'),
  (12342, 'Mario Carmo', '2002-07-29', 'Americana'),
  (12343, 'Lucio Castro', '1969-12-01', 'Campinas'),
  (12344, 'André Figueiredo', '1999-05-14', 'São Paulo'),
  (12345, 'Luiz Carlos', '2001-01-09', 'São Paulo');

GO

INSERT INTO onibus (placa, marca, ano, descricao)
VALUES 
  ('adf0965', 'Mercedes', 1999, 'Leito'),
  ('bhg7654', 'Mercedes', 2002, 'Sem Banheiro'),
  ('dtr2093', 'Mercedes', 2001, 'Ar Condicionado'),
  ('gui7625', 'Volvo', 2001, 'Ar Condicionado');

GO

INSERT INTO viagem (codigo, onibus, motorista, hora_saida, hora_chegada, destino)
VALUES 
  (101, 'adf0965', 12343, '10h', '12h', 'Campinas'),
  (102, 'gui7625', 12341, '7h', '12h', 'Araraquara'),
  (103, 'bhg7654', 12345, '14h', '22h', 'Rio de Janeiro'),
  (104, 'dtr2093', 12344, '18h', '21h', 'Sorocaba');

GO

SELECT hora_chegada, hora_saida
FROM viagem

GO

SELECT M.nome
FROM motorista m, viagem v
WHERE m.codigo = v.motorista
	  AND V.destino = 'Sorocaba'

GO

SELECT o.descricao
FROM onibus o, viagem v
WHERE o.placa = v.onibus
	  AND V.destino = 'Rio de Janeiro'

GO

SELECT o.descricao, o.marca, o.ano
FROM onibus o, motorista m, viagem v
WHERE o.placa = v.onibus
	  AND m.codigo = v.motorista
	  AND m.nome = 'Luiz Carlos'

GO

SELECT nome, DATEDIFF(YEAR, data_nascimento , GETDATE()) AS Idade, naturalidade
FROM motorista
WHERE DATEDIFF(YEAR, data_nascimento , GETDATE()) > 30