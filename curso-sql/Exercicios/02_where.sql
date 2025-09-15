-- Lista de pedidos realizados no fim de semana;

SELECT *,

       strftime('%w', datetime(substr(DtAtualizacao, 1, 19))) AS FinalDeSemana

FROM clientes

WHERE FinalDeSemana IN ('0', '6')