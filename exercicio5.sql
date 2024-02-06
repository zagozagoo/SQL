-- 5) Preciso controlar se as reuniões estão sendo realizadas nas salas com a capacidade correta.
-- Liste as Salas, Eventos, Capacidade das salas e Quantidade de Participantes.
--Crie uma coluna chamada "Avaliação da Capacidade" com dados como: "Ultrapassou o limite", "Limite ok". Dica: Use "Case When"

select
	S.Nome as Sala,
	E.Descricao,
	S.Capacidade,
	COUNT(EP.IDPessoa) as Participação,

	CASE
		WHEN (S.Capacidade >= COUNT(EP.IDPessoa)) THEN 'Limite OK'
		ELSE 'Ultrapassou o limite'
	END as "Avaliação da Capacidade"

from Evento as E
	INNER JOIN Sala as S
	on E.IDSala = S.IDSala
	INNER JOIN EventoPessoa as EP
	on E.IDEvento = EP.IDEvento

GROUP BY S.Nome, E.Descricao, S.Capacidade
