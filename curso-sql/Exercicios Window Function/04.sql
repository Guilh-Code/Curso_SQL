-- Saldo de pontos acumulado de cada usuário

WITH tb_dtpontos AS (

    SELECT IdCliente,
        substr(DtCriacao, 1, 10) AS dtDia,
        SUM(QtdePontos) AS TotalPontos,
        SUM(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) AS pontosPos

    FROM transacoes
    GROUP BY IdCliente, dtDia
),

tb_acum AS (

    SELECT *,
        SUM(TotalPontos) OVER (PARTITION BY IdCliente ORDER BY dtDia) AS SaldoPontos,
        SUM(pontosPos) OVER (PARTITION BY IdCliente ORDER BY dtDia) AS TotalPontosPos

    FROM tb_dtpontos
) 

SELECT *
FROM tb_acum
