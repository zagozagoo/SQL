CREATE DATABASE LojaDomDois
GO

USE LojaDomDois
GO

CREATE TABLE Cliente (
	IdCliente INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	CPF VARCHAR(11) NOT NULL,
	Nome VARCHAR(255) NOT NULL,
	Endereço VARCHAR(255) NOT NULL
)

CREATE TABLE NotaFiscal (
	IdNotaFiscal INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	IdCliente INT FOREIGN KEY REFERENCES Cliente (IdCliente) NOT NULL,
	Numero INT NOT NULL
)

CREATE TABLE Produto (
	IdProduto INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	Descricao VARCHAR(255) NOT NULL,
	Unidade CHAR(2) NOT NULL
)

CREATE TABLE Estoque (
	IdEstoque INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	Endereco VARCHAR(255) NOT NULL
)

CREATE TABLE EstoqueProduto (
	IdEstoque INT FOREIGN KEY REFERENCES Estoque (IdEstoque) NOT NULL,
	IdProduto INT FOREIGN KEY REFERENCES Produto (IdProduto) NOT NULL,
	Valor FLOAT NOT NULL,
	Quantidade FLOAT NOT NULL
)

CREATE TABLE NotaFiscalItem
(
	IdNotaFiscal INT FOREIGN KEY REFERENCES NotaFiscal (IdNotaFiscal) NOT NULL,
	IdItem INT NOT NULL,
	IdProduto INT FOREIGN KEY REFERENCES Produto (IdProduto) NOT NULL,
	ValorUnit FLOAT NOT NULL,
	Quantidade INT NOT NULL,
	Desconto INT,
	
	PRIMARY KEY (IdNotaFiscal, IdItem, IdProduto)
)

INSERT INTO Produto VALUES
('Bomba Injetora', 'UN'),
('Bico de Bomba Injetora', 'UN'),
('Pudim de Leite Condensado', 'UN'),
('Energético Monster', 'UN')

INSERT INTO Cliente VALUES
('08513060984', 'André Luis Pereira da Luz', 'Francisco Raitani 7081')

INSERT INTO NotaFiscal VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10)

INSERT INTO NotaFiscalItem VALUES
(1, 1, 1, 25.00, 10, 5),
(1, 2, 2, 13.50, 3, NULL),
(1, 3, 3, 15.00, 2, NULL),
(1, 4, 4, 10.00, 1, NULL)

--Exercício 1A:
select	IdNotaFiscal,
		IdItem,
		IdProduto,
		ValorUnit
from NotaFiscalItem

where Desconto IS NULL

--Exercício 1B:
select	IdNotaFiscal,
		IdItem,
		IdProduto,
		ValorUnit,
		ValorUnit - (ValorUnit*(Desconto/100)) as ValorVendido
from NotaFiscalItem

where Desconto IS NOT NULL

--Exercício 1C:
UPDATE NotaFiscalItem set Desconto = 0 where Desconto IS NULL

--Exercício 1D:
select	IdNotaFiscal,
		IdItem,
		IdProduto,
		ValorUnit,
		Quantidade * ValorUnit as ValorTotal,
		Desconto,
		ValorUnit - (ValorUnit*(Desconto/100)) as ValorVendido
from NotaFiscalItem

--Exercício 1E:
