-- 6) Verificar os equipamentos que estão disponíveis para atribuição
select
  Nome as 'Equipamento',
  Tipo
from Equipamento
WHERE IDSala is NULL
