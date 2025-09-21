-- Quem iniciou o curso no primeiro dia, em média assistiu quantas aulas?


WITH tb_primeiro_dia AS (

    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

tb_dias_curso AS (

    SELECT  IdCliente, 
            substr(DtCriacao, 1, 10) AS QtdeDias
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) >= '2025-08-25'
    AND substr(DtCriacao, 1, 10) < '2025-08-30'

    GROUP BY IdCliente, QtdeDias
),

tb_join AS (

    SELECT t1.IdCliente AS primCliente,
           t2.QtdeDias
    FROM tb_primeiro_dia AS t1

    LEFT JOIN tb_dias_curso AS t2
    ON t1.IdCliente = t2.IdCliente
),

tb_aulas AS (

    SELECT primCliente,
        count(DISTINCT QtdeDias) AS QtdeAulas
    FROM tb_join

    GROUP BY primCliente
)

SELECT ROUND(avg(QtdeAulas), 2) AS Média
FROM tb_aulas