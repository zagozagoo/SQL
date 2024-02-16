create database ZagoTreinando
go

use ZagoTreinando
go

create table Departamento
(
	IDDEPARTAMENTO Int primary key,
	NOME VarCHar(255),
	LOCALDEPARTAMENTO INT
)

create table Funcionario
(
	EDV Int primary key,
	NOME VarChar(255),
	LIDER VarChar(255),
	DATACONTRATACAO Date,
	SALARIO Float,
	DEPARTAMENTO Int foreign key references Departamento(IDDEPARTAMENTO)
)

create table Grade_Salarial
(
	GRADE Int primary key,
	SAL_MIN Int,
	SAL_MAX Int
)

INSERT INTO Departamento VALUES
(1, 'REMAN', 104),
(2, 'ICO', 101),
(3, 'ETS', 401),
(4, 'FCM', 303),
(5, 'INOVE', 303)

INSERT INTO Funcionario VALUES
(92890148, 'Edna Carvalho', 'Andrea', '1990-02-24', 19000, 1),
(92790062, 'João Manfredo', 'Andrea', '2001-09-26', 12500, 1),
(91004090, 'Débora Junior', 'Andrea', '1999-03-02', 15600, 1),
(94566222, 'Carla Rodrigues', 'Andrea', '1990-10-04', 20000, 1),
(96334100, 'Maciel Oliveira', 'Andrea', '1995-12-06', 16500, 1),
(97885245, 'Guilherme Gonçalves', 'Marcos', '2010-05-13', 9000, 2),
(92894706, 'Jessica Lima', 'Marcos', '2015-08-14', 25678, 2),
(98462157, 'Lorena Ray', 'Pietra', '2017-02-25', 1900, 3),
(91450032, 'Isabella Machado', 'Marcos', '1993-01-22', 10900, 2)

INSERT INTO Grade_Salarial VALUES
(1, 1500, 4000),
(2, 4001, 9000),
(3, 9001, 22000),
(4, 22001, 50000)


-- 1. Exiba o nome (departamento) o maior, menor e média salarial de cada departamento
select
	D.NOME as Departamento,
	ROUND (MIN (F.SALARIO), 2) as 'Salário mínimo',-- 2 pra arredondar pra dois numeros apos a vírgula
	ROUND (MAX (F.SALARIO), 2) as 'Salário máximo',
	ROUND (AVG (F.SALARIO), 2) as 'Média Salarial'

from Departamento as D
	LEFT JOIN Funcionario as F --left join para mostrar todos os departamentos, ja que eu nao fiz todo o banco e tem departamento com salrio nulo
	on D.IDDEPARTAMENTO = F.DEPARTAMENTO

-- NAO ESQUECE DE FAZER GROUP QUANDO TIVER FUNÇÃO AGREGADOREA, MIN, MAX, AVG
GROUP BY D.NOME -- só coloca no group by o que não é agregador


-- 2. crie uma função que irá exibir o nome (setor), a quantidade de funcionários que existem em cada setor com o salário maior que o parâmetro passado

create function fQuantidadeFuncionário (@busca Int)
Returns table as
return
(
	select
		D.NOME as Setor,
		COUNT (F.EDV) as 'Qtd. Funcionários'

	from Departamento as D
	INNER JOIN Funcionario as F
	on D.IDDEPARTAMENTO = F.DEPARTAMENTO
	
	where F.SALARIO > @busca

	GROUP BY D.NOME
)
 --Exemplo de uso:
SELECT * from dbo.fQuantidadeFuncionário(10000)


-- 3. Verifique o nome, lider, mes/ano de contratação e grade salarial do funcionario mais velho.
-- NÃO usar join ou variáveis (usar subselect, order by, and, or ou not)

select TOP 1
	F.NOME,
	F.LIDER,
	CONVERT(VarChar(7), F.DATACONTRATACAO, 33) as 'Mês/Ano contratação',
	(
		SELECT
			GRADE
		FROM Grade_Salarial where SAL_MIN <= F.SALARIO and SAL_MAX >= F.SALARIO --seleciona a grade somente os salarios que estao entre o MIN e o MAX
	) as 'Grade Salarial'
	
from Funcionario as F
	
ORDER BY F.DATACONTRATACAO ASC

-- 4. Para evitar problemas futuros, geralmente os dados não são excluídos de um banco, mas são inativados. Com isso, modifique a tabela de funcionários,
-- adicionando uma nova coluna "Ativo" que possuirá o valor 1 caso seja atual colaborador e 0 para antigo colaborador.
-- faça com que toda vez que tentam usar o DELETE em algum funcionario, ele apenas seja inativado
-- usar trigger, alteração de dados e alteração de estruturas

ALTER table Funcionario ADD Ativo bit

select * from Funcionario
update Funcionario set Ativo = 1

create trigger tDesativar on Funcionario
INSTEAD OF delete
as
begin
	UPDATE Funcionario SET Ativo = 0 where EDV in (select EDV from deleted) -- in para ver as pessoas que foram deletadas
end

delete from Funcionario where EDV = '91004090' -- isso trasformou esse funcionario em ativo 0


-- 5. exiba o nome de todos os funcionários que começam com a letra "J", mostre também uma segunda coluna "Atual" com o valor de "Ativo" ou "Inativo"
-- de acordo com a coluna criada no exercício 4 . Usar strings e verificação de valores
select 
	F.NOME as 'Funcionario',

	CASE
		WHEN F.Ativo = 0 THEN 'Inativo'
		ELSE 'Ativo'
	END as Atual

from Funcionario as F
	where NOME like 'J%'


-- 6. A líder Andrea abriu o próprio negócio e levou seus liderados com ele. "Delete" esses funcionários do banco, some o valor dos seus salários e
-- reparta igualmente entre o restante dos funcionários do setor, atualizando a tabela. Usar comandos de exclusão, variáveis e alteração de dados

DECLARE @somaDosSalarios AS INT
SET @somaDosSalarios =
(
	SELECT 
		SUM (SALARIO)
	from Funcionario where LIDER = 'Andrea'
)
GO

DECLARE @setor AS INT
SET @setor = 
(
	SELECT Distinct(Departamento) From Funcionario where LIDER = 'Andrea' -- distinct pra nao aparecer o 1 (departamento reman) várias vezes, apenas uma
)
GO

DELETE from Funcionario where LIDER = 'Andrea'
GO

DECLARE @numeroDePessoas AS INT
SET @numeroDePessoas = 
(
	SELECT
		COUNT(EDV)
	from Funcionario 
)
GO

UPDATE Funcionario SET SALARIO = SALARIO + (@somaDosSalarios / @numeroDePessoas) where Departamento = @setor
GO

select * from Funcionario
GO
