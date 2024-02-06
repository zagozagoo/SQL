-- 1) Encontrar as 3 salas com maior capacidade.
select
	top 3 * from Sala order by Capacidade desc
