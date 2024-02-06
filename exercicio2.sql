-- 2) Encontre: Nome dos participantes responsáveis, Descrição e Data do Evento, Nome da sala.
select
	P.Nome as Nomes,
	E.Descricao as "Descrição do Evento",
	Convert(varchar(10), E.DtHrInicio, 103) as "Data",
	S.Nome as "Nome da Sala"

from Evento as E
INNER JOIN EventoPessoa as EP  --INNER JOIN: Só puxa o que tem FK, o que é null ele não pega
	on E.IDEvento = EP.IDEvento
INNER JOIN Pessoa as P
	on EP.IDPessoa = P.IDPessoa
INNER JOIN Sala as S
	on E.IDSala = S.IDSala

WHERE EP.PapelEvento = 'Responsavel'


Select count(*) from EventoPessoa -- ver quantos respondaveis tinham, pra fazer prova real
Where PapelEvento = 'Responsavel'

select distinct(PapelEvento) from EventoPessoa -- pega todos os papeis do evento sem repetição, ja que nao lemnrei quais tinha
