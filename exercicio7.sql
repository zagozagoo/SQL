--7. Com o código feito no exercício 5, que foi classificado com "ok" ou "ultrapassado" das pessoas que confirmaram estar presentes no evento.
--Encontre com Sub-Select, os eventos que iriam ter um limite ultrapassado, mas que não tiveram por causa de algumas pessoas que faltaram no dia.
--Crie uma VIEW para salvar esse Select.

select
	S.Nome as Sala,
	E.Descricao,
	S.Capacidade,
	COUNT(EP.IDPessoa) as 'Total de Convidados',
	(
		SELECT -- Esse sub-select é para criar a nova coluna de pessoas presentes
			COUNT(EP2.IDPessoa)
		FROM Evento E2
			INNER JOIN Sala as S2
			on E2.IDSala = S2.IDSala
			INNER JOIN EventoPessoa as EP2
			on E2.IDEvento = EP2.IDEvento
		WHERE
			EP2.Presenca = 1 AND
			E2.IDEvento = E.IDEvento
		GROUP BY
			E2.IDEvento,
			S2.Capacidade
		HAVING
			COUNT(EP2.IDPessoa) <= S2.Capacidade
	) as 'Pessoas Presentes'	

from Evento as E
	INNER JOIN Sala as S
	on E.IDSala = S.IDSala
	INNER JOIN EventoPessoa as EP
	on E.IDEvento = EP.IDEvento

GROUP BY S.Nome, E.Descricao, S.Capacidade, E.IDEvento
HAVING
	COUNT(EP.IDPessoa) > S.Capacidade AND
	E.IDEvento IN (
		SELECT
			E2.IDEvento
		FROM Evento E2
			INNER JOIN Sala as S2
			on E2.IDSala = S2.IDSala
			INNER JOIN EventoPessoa as EP2
			on E2.IDEvento = EP2.IDEvento
		WHERE
			EP2.Presenca = 1
		GROUP BY
			E2.IDEvento,
			S2.Capacidade
		HAVING
			COUNT(EP2.IDPessoa) <= S2.Capacidade
	)
