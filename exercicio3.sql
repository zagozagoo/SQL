-- 3) Controlar qual dia e por quanto tempo cada sala foi usada por cada reunião. Dica: Use DateDiff
select
S.Nome as "Nome da Sala",
Convert(varchar(10), E.DtHrInicio, 103) as "Data",
DATEDIFF (Hour, E.DtHrInicio, E.DtHrFim) as "Duração em Horas"

from Evento as E
	INNER JOIN Sala as S
	on E.IDSala = S.IDSala
