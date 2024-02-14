--Crie uma tabela log para armazenar todas as ocorrências de inserção que ocorrer na tabela cliente.
--Crie uma trigger que fará
use LojaDom

CREATE TABLE Log (
Data DATETIME,
Operacao VARCHAR(50), -- Ex: Inserção
Observacao VARCHAR(255)
PRIMARY KEY (Data, Operacao)) -- Os dois juntos são PK

create trigger tInserirPessoaLog --tem que executar ele separado se nao o sql coringa
	on TABELA_DE_CLIENTES
AFTER insert
as

BEGIN
	DECLARE @cpf VarChar(11) --coloca o resultado do select dentro de uma variavel para burlar o concat que a microsoft tava chorando
	SET @cpf = (select CPF from inserted)

	DECLARE @nome VarChar(100)
	SET @nome = (select NOME from inserted)

	INSERT INTO Log VALUES
	(
		GETDATE(),
		'Inserção',
		CONCAT('Inserindo Cliente CPF: ', @cpf,' Nome: ', @nome) --usa o cocact pra usar um dado fixo, no caso Cliente, e juntar com um dado que eu vou colocar agora
	)
END



insert into TABELA_DE_CLIENTES (CPF, NOME) values --inserir apenas cpf e nome, nao todos os valores
('08363535959','Vitoria Zagodois')

select * from Log --log e nao TABELA_DE_CLIENTES pq vamos ver se o trigger funciona
