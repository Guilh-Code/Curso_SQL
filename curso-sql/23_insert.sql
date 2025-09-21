DELETE FROM relatorio_diario;

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

INSERT INTO relatorio_diario

SELECT * 
FROM dt_acumaludas;

SELECT * FROM relatorio_diario;
