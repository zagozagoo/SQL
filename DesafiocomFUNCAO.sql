
CREATE function fEventoAntigo (@busca VARCHAR(10))
RETURNS TABLE AS
RETURN
(
	select TOP 1 --vai usar o mais antigo
		E.Descricao as Evento,
		S.Nome as "Nome da Sala",
		COUNT(EP.IDPessoa) as Participação,
		Convert(varchar(10), E.DtHrInicio, 103) as "Data de Início",
		Convert(varchar(5), E.DtHrInicio, 108) as "Horário de Início"
	
	from Evento as E
		INNER JOIN Sala as S
		on E.IDSala = S.IDSala
		INNER JOIN EventoPessoa as EP
		on E.IDEvento = EP.IDEvento

	where
		E.Descricao like CONCAT('%', @busca,'%') --concatenar para inserir a palavra que quer achar 

	GROUP BY E.Descricao, S.Nome, E.DtHrInicio, E.IDEvento

	ORDER BY DtHrInicio
)

--Exemplo de uso:
SELECT * FROM dbo.fEventoAntigo('Palestra')
--não da pra rodar eles juntos
