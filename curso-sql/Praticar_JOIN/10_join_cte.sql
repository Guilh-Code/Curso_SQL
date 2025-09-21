--SELECT 
--       substr(DtCriacao, 1, 10) AS dtDia,
--       count(DISTINCT IdCliente) AS QtdeClientes
--FROM transacoes
--WHERE DtCriacao >= '2025-08-25'
--AND DtCriacao < '2025-08-30'
--GROUP BY dtDia

-- Como foi a curva de Churn do Curso de SQL?

WITH tb_clientes_d1 AS (

    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

tb_join AS (

    SELECT 
        substr(t2.DtCriacao, 1, 10) AS dtDia,
        count(DISTINCT t1.IdCliente) AS qtdeCliente,
        ROUND(1. * count(DISTINCT t1.IdCliente) / (SELECT count(*) FROM tb_clientes_d1), 2) AS pctRetenção,
        ROUND(1 - 1. * count(DISTINCT t1.IdCliente) / (SELECT count(*) FROM tb_clientes_d1), 2) AS pctChurn

    FROM tb_clientes_d1 AS t1

    LEFT JOIN transacoes AS t2
    ON t1.IdCliente = t2.IdCliente

    WHERE t2.DtCriacao >= '2025-08-25'
    AND t2.DtCriacao < '2025-08-30'

    GROUP BY dtDia
)

SELECT * FROM tb_join