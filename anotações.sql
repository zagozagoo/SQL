select * from Evento
where Descricao like 'Aula%' -- tudo que começar com 'Aula' vai aparecer

-- Também funciona como where Descricao like '%de%'  -> tudo que tever 'de' no meio vai aparecer
-------------------------------------------------------------------------------------------------
--1.Usar variáveis:
--Declaração de variável:
DECLARE @NomeVariavel TipoDado;
--Atribuição de valor:
SET @NomeVariavel = Valor;
--OU
DECLARE @NomeVariavel INT;
SET @NomeVariavel = 10;
SELECT Coluna FROM Tabela WHERE Coluna = @NomeVariavel;

--2.Comandos de exclusão, delete exclui permanentemente
DELETE FROM Tabela WHERE idade < 18;

--3. CASE WHEN
SELECT 
    Nome,
    Idade,
    CASE 
        WHEN Idade < 18 THEN 'Menor de idade'
        WHEN Idade >= 18 AND Idade < 65 THEN 'Adulto'
        ELSE 'Idoso'
    END AS FaixaEtaria
FROM Tabela;

--4.LIKE Selecionar registros onde o nome começa com 'Jo'
SELECT Nome FROM Tabela WHERE Nome LIKE 'Jo%';

--5.Alteração de dados, Atualizar o salário para 10% a mais para todos os funcionários
UPDATE Funcionarios SET Salario = Salario * 1.1;

--6.Alteração de estruturas, add uma nova coluna 'Email' à tabela 'Clientes'
ALTER TABLE Clientes ADD Email VARCHAR(100);

--7. Trigger
CREATE TRIGGER TriggerExemplo ON Tabela
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Seu código aqui
    PRINT 'Operação realizada na tabela';
END;


--EXEMPLO TRIGGER:
-- Criar tabela de Pedidos
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY,
    ClienteID INT,
    ValorTotal DECIMAL(10, 2),
    StatusPedido VARCHAR(50)
);

-- Criar tabela de HistóricoPedidos
CREATE TABLE HistóricoPedidos (
    RegistroID INT PRIMARY KEY,
    PedidoID INT,
    AçãoRealizada VARCHAR(100),
    DataAção DATETIME
);

-- Criar o trigger
CREATE TRIGGER TR_Pedidos_AfterUpdate ON Pedidos
AFTER UPDATE
AS
BEGIN
    -- Inserir no HistóricoPedidos após uma atualização na tabela Pedidos
    INSERT INTO HistóricoPedidos (PedidoID, AçãoRealizada, DataAção)
    SELECT
        d.PedidoID,
        'Atualização - Novo Status: ' + i.StatusPedido,
        GETDATE()
    FROM
        inserted i
    JOIN
        deleted d ON i.PedidoID = d.PedidoID;
END;

-- Exemplo de uso
-- Atualizar o status de um pedido na tabela Pedidos
UPDATE Pedidos SET StatusPedido = 'Enviado' WHERE PedidoID = 1;

-- Consultar o HistóricoPedidos para verificar a entrada gerada pelo trigger
SELECT * FROM HistóricoPedidos;


--8. Ordenaçao de dados, selecionar nomes de clientes ordenados alfabeticamente
SELECT Nome FROM Clientes ORDER BY Nome ASC;

--9. AND OR NOT
-- Selecionar clientes do sexo feminino com idade maior que 25
SELECT * FROM Clientes WHERE Sexo = 'Feminino' AND Idade > 25;

-- Selecionar clientes do sexo masculino ou com idade menor que 18
SELECT * FROM Clientes WHERE Sexo = 'Masculino' OR Idade < 18;

-- Selecionar clientes do sexo masculino com idade maior que 21
SELECT * FROM Clientes WHERE Sexo = 'Masculino' AND NOT Idade <= 21;

--10.SUB-SELECT, selecionar todos os clientes que fizeram pelo menos um pedido
SELECT Nome FROM Clientes
WHERE ClienteID IN (SELECT DISTINCT ClienteID FROM Pedidos);

--11. operadores de comparação
-- Selecionar funcionários com salário maior que 5000
SELECT * FROM Funcionarios WHERE Salario > 5000;

-- Selecionar produtos com preço entre 10 e 50
SELECT * FROM Produtos WHERE Preco BETWEEN 10 AND 50;

-- Selecionar clientes que não são do sexo masculino
SELECT * FROM Clientes WHERE Sexo <> 'Masculino';

--12. count, sum e max
-- Contar o número de pedidos feitos por cada cliente
SELECT ClienteID, COUNT(*) AS NumeroDePedidos
FROM Pedidos
GROUP BY ClienteID;

-- Calcular o total de vendas para cada produto
SELECT ProdutoID, SUM(Quantidade * PrecoUnitario) AS TotalVendas
FROM DetalhesPedidos
GROUP BY ProdutoID;

-- Encontrar o produto mais caro
SELECT MAX(Preco) AS PrecoMaximo
FROM Produtos;


--13. junção de entidades
-- Selecionar detalhes de pedidos com informações de produtos e clientes
SELECT D.*, P.Nome AS NomeProduto, C.Nome AS NomeCliente
FROM DetalhesPedidos D
JOIN Produtos P ON D.ProdutoID = P.ProdutoID
JOIN Clientes C ON D.ClienteID = C.ClienteID;

--14. Agrupamento de dados, contar o número de pedidos feitos por cada status
SELECT StatusPedido, COUNT(*) AS NumeroDePedidos
FROM Pedidos
GROUP BY StatusPedido;

--15. Where
-- Selecionar produtos com preço maior que 50 e quantidade em estoque maior que 10
SELECT * FROM Produtos WHERE Preco > 50 AND QuantidadeEstoque > 10;

-- Selecionar pedidos feitos por um cliente específico
SELECT * FROM Pedidos WHERE ClienteID = 1;

--16. PK FK
-- Criar tabela de Clientes com chave primária
CREATE TABLE Clientes
(
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Email VARCHAR(255)
)

-- Criar tabela de Pedidos com chave primária e chave estrangeira
CREATE TABLE Pedidos
(
    PedidoID INT PRIMARY KEY,
    ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
    DataPedido DATE,
    ValorTotal DECIMAL(10, 2)
)

--17. inserção de dados
-- Inserir um cliente
INSERT INTO Clientes (ClienteID, Nome, Email)
VALUES (1, 'João Silva', 'joao@email.com');

-- Inserir um pedido associado ao cliente
INSERT INTO Pedidos (PedidoID, ClienteID, DataPedido, ValorTotal)
VALUES (101, 1, '2024-02-14', 100.00);

--18. criar entidades
-- Criar uma tabela de Produtos
CREATE TABLE Produtos
(
    ProdutoID INT PRIMARY KEY,
    NomeProduto VARCHAR(100),
    Preco DECIMAL(10, 2)
)

--19.criar e usar banco de dados
-- Criar um banco de dados
CREATE DATABASE NomeDoBancoDeDados;

-- Usar o banco de dados recém-criado
USE NomeDoBancoDeDados;

-- Criar tabelas dentro do banco de dados
CREATE TABLE Exemplo (
    Coluna1 INT,
    Coluna2 VARCHAR(50)
);












