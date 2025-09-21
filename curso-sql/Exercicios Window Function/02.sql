-- Quantidade de usuários cadastrados (absoluto e acumulado) ao longo do tempo?

WITH tb_cadastrados AS (

    SELECT substr(DtCriacao, 1, 10) AS dtDia,
        count(DISTINCT IdCliente) AS QtdeCadastrados 
    FROM clientes
    GROUP BY dtDia
),

tb_acumulada AS (

    SELECT *,
        SUM(QtdeCadastrados) OVER (ORDER BY dtDia) AS QtdeCadasAcum

    FROM tb_cadastrados
)

SELECT *
FROM tb_acumulada;
-- WHERE QtdeCadasAcum > 3000
-- LIMIT 1
