CREATE DATABASE EX04

GO

USE EX04

GO

CREATE TABLE cliente (
    cpf         char(11)    not null,
    nome        varchar(50) not null,
    telefone    char(9)     not null,
    PRIMARY KEY (cpf)
)

GO

CREATE TABLE fornecedor (
    id            int             not null,
    nome          varchar(50)     not null,
    logradouro    varchar(50)     not null,
    numero        int             not null,
    complemento   varchar(50),
    cidade        varchar(50)     not null,
    PRIMARY KEY (id)
)

GO

CREATE TABLE produto (
    codigo      int             not null,
    descricao   varchar(50)     not null,
    fornecedor  int             not null,
    preco       decimal(7, 2)   not null,
    PRIMARY KEY (codigo),
    FOREIGN KEY (fornecedor) REFERENCES fornecedor (id)
)

GO

CREATE TABLE venda (
    codigo          int             not null,
    produto         int             not null,
    cliente         char(11)        not null,
    quantidade      int             not null,
    valor_total     decimal(7, 2)   not null,
    data            date            not null,
    PRIMARY KEY (codigo),
    FOREIGN KEY (produto) REFERENCES produto (codigo),
    FOREIGN KEY (cliente) REFERENCES cliente (cpf)
)

GO

INSERT INTO cliente (cpf, nome, telefone)
VALUES 
  ('34578909290', 'Julio Cesar', '8273-6541'),
  ('25186533710', 'Maria Antonia', '8765-2314'),
  ('87627315416', 'Luiz Carlos', '6128-9012'),
  ('79182639800', 'Paulo Cesar', '9076-5273');

GO

INSERT INTO fornecedor (id, nome, logradouro, numero, complemento, cidade)
VALUES 
  (1, 'LG', 'Rod. Bandeirantes', 70000, 'Km 70', 'Itapeva'),
  (2, 'Asus', 'Av. Nações Unidas', 10206, 'Sala 225', 'São Paulo'),
  (3, 'AMD', 'Av. Nações Unidas', 10206, 'Sala 1095', 'São Paulo'),
  (4, 'Leadership', 'Av. Nações Unidas', 10206, 'Sala 87', 'São Paulo'),
  (5, 'Inno', 'Av. Nações Unidas', 10206, 'Sala 34', 'São Paulo')

GO

INSERT INTO produto (codigo, descricao, fornecedor, preco)
VALUES 
  (1, 'Monitor 19 pol.', 1, 449.99),
  (2, 'Netbook 1GB Ram 4 Gb HD', 2, 699.99),
  (3, 'Gravador de DVD - Sata', 1, 99.99),
  (4, 'Leitor de CD', 1, 49.99),
  (5, 'Processador - Phenom X3 - 2.1GHz', 3, 349.99),
  (6, 'Mouse', 4, 19.99),
  (7, 'Teclado', 4, 25.99),
  (8, 'Placa de Video - Nvidia 9800 GTX - 256MB/256 bits', 5, 599.99)

GO

INSERT INTO venda (codigo, produto, cliente, quantidade, valor_total, data)
VALUES 
  (1, 1, '25186533710', 1, 449.99, '2009-09-03'),
  (2, 4, '25186533710', 1, 49.99, '2009-09-03'),
  (3, 5, '25186533710', 1, 349.99, '2009-09-03'),
  (4, 6, '79182639800', 4, 79.96, '2009-09-06'),
  (5, 8, '87627315416', 1, 599.99, '2009-09-06'),
  (6, 3, '87627315416', 1, 99.99, '2009-09-06'),
  (7, 7, '87627315416', 1, 25.99, '2009-09-06'),
  (8, 2, '34578909290', 2, 1399.98, '2009-09-08')

 GO

 SELECT CONVERT(varchar(10),data,103) AS DataVenda
 FROM venda
 WHERE codigo = 4

GO

ALTER table fornecedor
ADD telefone char(8)

GO

UPDATE fornecedor
SET telefone = '72165371'
WHERE id = 1

GO

UPDATE fornecedor
SET telefone = '87153738'
WHERE id = 2

GO

UPDATE fornecedor
SET telefone = '36546289'
WHERE id = 4

GO

SELECT nome, logradouro + ', ' + CAST(numero as varchar(10)) + ' - ' + complemento + ' - ' + cidade as Endereço
FROM fornecedor
ORDER BY NOME ASC

GO

SELECT p.descricao, v.quantidade, v.valor_total
FROM cliente c, produto p, venda v
WHERE c.cpf = v.cliente
	  AND p.codigo = v.produto
	  AND C.nome = 'Julio Cesar'

GO

SELECT CONVERT(varchar(10), v.data,103) as Data, v.valor_total
FROM venda V, cliente C
WHERE c.cpf = v.cliente
	  AND C.nome = 'Paulo Cesar'

GO

SELECT descricao, preco
FROM produto
ORDER BY preco DESC