-- 3)

use master

if exists(select * from sys.databases where name = 'Mundo3')
	drop database Mundo3
go

create database Mundo3
go

use Mundo3
go

create table TabelaPais
(
	Pais VarChar(35) primary key,
	Continente VarChar(35),
	Populacao_Em_Milhoes float,
	PIB_Em_Milhoes float,
	Expect_Vida float
)

create table TabelaCidade
(
	Cidade VarChar(35) primary key,
	Pais VarChar(35) foreign key references TabelaPais(Pais),
	Populacao_Em_Milhoes float,
	Capital Bit
)

create table TabelaRio
(
	Rio VarChar(35) primary key,
	Nascente VarChar(35) foreign key references TabelaPais(Pais),
	Pais VarChar(35) foreign key references TabelaPais(Pais),
	Comprimento_KM float
)

INSERT INTO TabelaPais VALUES
('Canada', 'America do Norte', 38.25, 1.9, 82),
('Mexico', 'America do Norte', 126.7, 1.65, 75),
('Brasil', 'America do Sul', 214.3, 1.608, 75.5),
('USA', 'America do Norte', 331.9, 21.43, 76.1),
('China', 'Asia', 1444.2, 14.34, 83),
('Alemanha', 'Europa', 83.2, 4.1, 78.1)

INSERT INTO TabelaCidade VALUES
('Washington', 'USA', 3.3, 1),
('Monterrey', 'Mexico', 2.0, 0),
('Brasilia', 'Brasil', 1.5, 1),
('São Paulo', 'Brasil', 15.0,0),
('Ottawa', 'Canada', 0.8, 1),
('Cid. Mexico', 'Mexico', 14.1, 1),
('Pequim', 'China', 21.5, 1)

INSERT INTO TabelaRio VALUES
('St. Lawrence', 'USA', 'USA', 3.3),
('Grande', 'USA', 'Mexico', 2.0),
('Parana', 'Brasil', 'Brasil',1.5),
('Mississipi', 'USA', 'USA', 15.0)


--4) Para cada continente retorne o PIB médio de seus países.
 Select 
	TabelaPais.Continente as Continente,
	ROUND(SUM (PIB_Em_Milhoes) / COUNT(TabelaPais.Pais), 2) as 'PIB Médio'
 from TabelaPais

 GROUP BY TabelaPais.Continente


 --5) Mostre o continente no qual o rio mais extenso está localizado
SELECT TOP 1
    TR.Comprimento_KM,
    TP.Continente,
    TR.Rio

FROM TabelaRio AS TR
INNER JOIN TabelaPais AS TP
ON TR.Pais = TP.Pais
ORDER BY TR.Comprimento_KM DESC


 --6)Crie uma trigger que seja ativada ao excluir um país.
 -- A trigger deve remover todas as cidades e rios relacionados com o país excluído

CREATE TRIGGER fRemoveRelacionados
ON TabelaPais
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @DeletedPais VARCHAR(35)
    SELECT @DeletedPais = Pais FROM DELETED

    DELETE FROM TabelaCidade WHERE Pais = @DeletedPais
    DELETE FROM TabelaRio WHERE Pais = @DeletedPais
END

 --7) Crie uma função chamada SearchPais que receberá como parâmetro uma palavra/letra que será
 -- utilizada como base para pesquisar no banco de dados um país que comece com o parâmetro inserido.

create function fSeachPais (@busca VarChar(70))
Returns table as
return
(
	Select * from TabelaPais

	where TabelaPais. Pais like CONCAT (@busca, '%')
)

--Exemplo de uso:
SELECT * FROM dbo.fSeachPais('C')


--8) Crie uma coluna na tabela Pais com o valor do PIB per capita.

ALTER TABLE TabelaPais ADD PIB float

update TabelaPais SET PIB = PIB_Em_Milhoes / Populacao_Em_Milhoes

select * from TabelaPais


-- 9) Liste as Cidades, Países, População e uma coluna chamada “Situação População” com dados como: “Acima da média” e “Abaixo ou igual à média”
SELECT
    TC.Cidade,
    TP.Pais,
    TC.Populacao_Em_Milhoes,
    CASE
        WHEN TC.Populacao_Em_Milhoes > (SELECT AVG(Populacao_Em_Milhoes) FROM TabelaCidade) THEN 'Acima da media'
        ELSE 'Abaixo ou igual a media'
    END AS Situacao_Populacao
FROM TabelaCidade AS TC
INNER JOIN TabelaPais AS TP ON TC.Pais = TP.Pais
