--Crie uma função cujo o retorno deverá ser um único select e retornar uma tabela com:
--1- Quantidade de pessoas presentes no primeiro evento (mais antigo) que ocorreu.
--2- Nome da sala em que esse evento ocorreu.
--3- A Função será chamada com um parâmetro de busca. Como Aula, Palestra ou Reunião.
--Nome Evento, Nome Sala, Qtd Pessoas, Data Início, Hora Início.

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

where E.Descricao like '%Palestra%'

GROUP BY E.Descricao, S.Nome, E.DtHrInicio, E.IDEvento

ORDER BY DtHrInicio
