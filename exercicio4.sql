-- 4) Encontre a quantidade de eventos que cada pessoa participou. Os que mais participaram, aparecem por primeiro (Decrescente). 
--Deve aparecer "0" para quem nunca participou (1 Ocorrência).
select
	P.Nome as Nomes,
	COUNT(EP.IDPessoa) as Participação
	
from EventoPessoa as EP
	RIGHT JOIN Pessoa as P -- Nesse caso tem que usar RIGHT, pois algumas pessoas não participaram mas precisam estar na tabela
	on EP.IDPessoa = P.IDPessoa

GROUP BY P.Nome -- nesse caso não tem fórmula então pode usar P.Nome ao invés de "Nomes"

ORDER BY Participação DESC-- como no "participação eu usei a formula COUNT, só pode usar o apelido "participação", não o EP.IDPessoa
