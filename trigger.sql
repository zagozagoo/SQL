--CRIAR TRIGGER QUE BURLE A INTEGRIDADE REFERENCIAL
-- ele vaiexcluir uma pessoadas tabelas

CREATE TRIGGER TriggerMataOsFilhos
ON Pessoa -- É a tabela à qual o trigger se aplica.
INSTEAD OF delete
AS
BEGIN
	DELETE EventoPessoa
	WHERE IDPessoa in  
	(
		select IDPessoa from deleted
	)

	DELETE Pessoa
	WHERE IDPessoa in
	(
		SELECT IDPessoa FROM Deleted
	)
END

--Para confirmar se tem linhas com tal ID , no caso tinha 3
SELECT IDPessoa from Pessoa
SELECT Count(IDPessoa) from EventoPessoa
WHERE IDPessoa = '00VNJ1HVT04T'

--Agora deletamos, 3 linhas excluidas, deu certo!!!
DELETE Pessoa
WHERE IDPessoa = '00VNJ1HVT04T'


-- Exemplo de uso:	
DELETE Pessoa
WHERE IDPessoa in (10, 11, 12)
