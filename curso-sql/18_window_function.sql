WITH tb_sumario_dia AS (

    SELECT substr(DtCriacao, 1, 10) AS dtDia,
        count(DISTINCT IdTransacao) AS QtdeTransacao 

    FROM transacoes

    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'

    GROUP BY dtDia
)

SELECT *,
       SUM(QtdeTransacao) OVER (ORDER BY dtDia) AS qtdeTransacaoAcum

FROM tb_sumario_dia