-- Quantidade de transações Acumuladas ao longo do tempo?

WITH dt_dias AS (

    SELECT substr(DtCriacao, 1, 10) AS dtDia,
        count(DISTINCT IdTransacao) AS Qtdetransacoes 

    FROM transacoes
    GROUP BY dtDia
),

dt_acumaludas AS (

    SELECT *,
        SUM(Qtdetransacoes) OVER (ORDER BY dtDia) AS QtdeAcum

    FROM dt_dias
)

SELECT * 
FROM dt_acumaludas

--SELECT *
--FROM dt_acumaludas
--WHERE QtdeAcum > 100000
--ORDER BY QtdeAcum
--LIMIT 1
