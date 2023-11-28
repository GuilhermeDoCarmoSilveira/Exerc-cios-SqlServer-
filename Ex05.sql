CREATE DATABASE EX05

GO

USE EX05

GO

CREATE TABLE fornecedor (
    codigo      int             not null,
    nome        varchar(50)     not null,
    atividade   varchar(50)     not null,
    telefone    char(8)         not null,
    PRIMARY KEY (codigo)
)

GO

CREATE TABLE produto (
    codigo              int             not null,
    nome                varchar(50)     not null,
    valor_unitario      decimal(7, 2)   not null,
    quantidade_estoque  int             not null,
    descricao           varchar(50)     not null,
    codigo_fornecedor   int             not null,
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigo_fornecedor) REFERENCES fornecedor (codigo)
)

GO

CREATE TABLE cliente (
    codigo      int             not null,
    nome        varchar(50)     not null,
    logradouro  varchar(50)     not null,
    numero      int             not null,
    telefone    char(8)         not null,
    data_nasc   date            not null,
    PRIMARY KEY (codigo)
)

GO

CREATE TABLE pedido (
    codigo             int             not null,
    codigo_cliente     int             not null,
    codigo_produto     int             not null,
    quantidade         int             not null,
    previsao_entrega   date            not null,
    PRIMARY KEY (codigo, codigo_cliente, codigo_produto),
    FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo),
    FOREIGN KEY (codigo_produto) REFERENCES produto (codigo)
)

GO


INSERT INTO fornecedor (codigo, nome, atividade, telefone) VALUES 
  (1001, 'Estrela', 'Brinquedo', '41525898'),
  (1002, 'Lacta', 'Chocolate', '42698596'),
  (1003, 'Asus', 'Informática', '52014596'),
  (1004, 'Tramontina', 'Utensílios Domésticos','50563985'),
  (1005, 'Grow', 'Brinquedos', '47896325'),
  (1006, 'Mattel', 'Bonecos', '59865898')

GO

INSERT INTO cliente (codigo, nome, logradouro, numero, telefone, data_nasc) VALUES 
  (33601, 'Maria Clara', 'R. 1° de Abril', 870, '96325874', '2000-08-15'),
  (33602, 'Alberto Souza', 'R. XV de Novembro', 987, '95873625', '1985-02-02'),
  (33603, 'Sonia Silva', 'R. Voluntários da Pátria', 1151, '75418596', '1957-08-23'),
  (33604, 'José Sobrinho', 'Av. Paulista', 250, '85236547', '1986-12-09'),
  (33605, 'Carlos Camargo', 'Av. Tiquatira', 9652, '75896325', '1971-03-25')

GO

INSERT INTO produto (codigo, nome, valor_unitario, quantidade_estoque, descricao, codigo_fornecedor) VALUES 
  (1, 'Banco Imobiliário', 65.00, 15, 'Versão Super Luxo', 1001),
  (2, 'Puzzle 5000 peças', 50.00, 5, 'Mapas Mundo', 1005),
  (3, 'Faqueiro', 350.00, 0, '120 peças', 1004),
  (4, 'Jogo para churrasco', 75.00, 3, '7 peças', 1004),
  (5, 'Tablet', 750.00, 29, 'Tablet', 1003),
  (6, 'Detetive', 49.00, 0, 'Nova Versão do Jogo', 1001),
  (7, 'Chocolate com Paçoquinha', 6.00, 0, 'Barra', 1002),
  (8, 'Galak', 5.00, 65, 'Barra', 1002);

GO

INSERT INTO pedido (codigo, codigo_cliente, codigo_produto, quantidade, previsao_entrega) VALUES 
  (99001, 33601, 1, 1, '2012-06-07'),
  (99001, 33601, 2, 1, '2012-06-07'),
  (99001, 33601, 8, 3, '2012-06-07'),
  (99002, 33602, 2, 1, '2012-06-09'),
  (99002, 33602, 4, 3, '2012-06-09'),
  (99003, 33605, 5, 1, '2012-06-15')

 GO

 SELECT pe.quantidade, pe.quantidade * p.valor_unitario as ValorTotal, pe.quantidade * p.valor_unitario - CAST(((pe.quantidade * p.valor_unitario)*0.25)AS decimal(7,2)) as Valor25Desconto
 FROM pedido pe, produto p, cliente c
 WHERE c.codigo = pe.codigo_cliente
	   AND p.codigo = pe.codigo_produto
	   AND c.nome = 'Maria Clara'

GO

SELECT p.nome
FROM fornecedor f, produto p 
WHERE f.codigo = p.codigo_fornecedor
	  AND f.atividade like  '%Brinquedo%'
	  AND P.quantidade_estoque = 0

GO

SELECT cast(p.valor_unitario - (p.valor_unitario * 0.10)as decimal(7,2)) as Valor10Desconto
FROM fornecedor f, produto p 
WHERE f.codigo = p.codigo_fornecedor
	  AND f.atividade = 'chocolate'

GO

UPDATE produto
SET quantidade_estoque = 10
WHERE nome = 'Faqueiro'

GO

SELECT COUNT(codigo) as ClienteMaiorDe40
FROM cliente
WHERE DATEDIFF(YEAR, data_nasc, GETDATE()) > 40

GO

SELECT nome, telefone
FROM fornecedor
WHERE atividade LIKE '%Brinquedo%' OR atividade = 'Chocolate'

GO

SELECT nome, cast(valor_unitario - (valor_unitario * 0.25)as decimal(7,2)) as Valor25Desconto
FROM produto
WHERE valor_unitario < 50.00

GO

SELECT nome, cast(valor_unitario + (valor_unitario * 0.10)as decimal(7,2)) as Valor25Desconto
FROM produto
WHERE valor_unitario > 100.00

GO

SELECT cast(valor_unitario - (valor_unitario * 0.15)as decimal(7,2)) as Valor15Desconto
FROM pedido p, produto pr
WHERE pr.codigo = p.codigo_produto 
	 AND p.codigo = 99001

GO

SELECT DISTINCT p.codigo, c.nome, DATEDIFF(YEAR, data_nasc, GETDATE()) as Idade
FROM pedido p, cliente c
WHERE c.codigo = p.codigo_cliente
