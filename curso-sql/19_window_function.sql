
WITH tb_cliente_dia AS (

    SELECT IdCliente,
        substr(DtCriacao, 1, 10) AS dtDia,
        count(DISTINCT IdTransacao) AS QtdeTransacoes

    FROM transacoes

    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'

    GROUP BY IdCliente, dtDia
),

tb_lag AS (

    SELECT *,
        SUM(QtdeTransacoes) OVER (PARTITION BY IdCliente ORDER BY dtDia) AS Acum,
        lag(QtdeTransacoes) OVER (PARTITION BY IdCliente  ORDER BY dtDia) AS lagTransacao
    FROM tb_cliente_dia
)

SELECT *,
        ROUND(1. * QtdeTransacoes / lagTransacao, 2) AS Engaj

FROM tb_lag