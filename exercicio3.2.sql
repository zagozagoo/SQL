-- 3.2) Quanto tempo (Minutos) cada sala foi ou será utilizada no total?
select 
S.Nome as "Nome da Sala",
SUM(DATEDIFF (MINUTE, E.DtHrInicio, E.DtHrFim)) as "Duração em Minutos Totais"

from Evento as E
	INNER JOIN Sala as S
	on E.IDSala = S.IDSala
GROUP BY
	S.Nome
