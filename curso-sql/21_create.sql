

DROP TABLE IF EXISTS relatorio_diario;

CREATE TABLE IF NOT EXISTS relatorio_diario AS 

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
FROM dt_acumaludas;

SELECT * FROM relatorio_diario;