-- Dos clientes que começaram SQL no primeiro dia, quantos chegaram ao 5o dia?

SELECT 
        count(DISTINCT IdCliente) AS Clientes5ºDia

FROM transacoes AS t1

WHERE t1.IdCliente IN (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
)
AND substr(t1.DtCriacao, 1, 10) = '2025-08-29';



SELECT count(DISTINCT IdCliente) AS Clientes1ºDia
FROM transacoes
WHERE substr(DtCriacao, 1, 10) = '2025-08-25';
