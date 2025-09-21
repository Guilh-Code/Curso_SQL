-- Qual o dia com maior engajamento de cada aluno que iniciou o curso no dia 01?


WITH Aluno_Primeiro_Dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

tb_dia_clientes AS (

    SELECT t1.IdCliente AS ClientesPrim,
           substr(t2.DtCriacao, 1, 10) AS dtDia,
           count(t2.IdTransacao) AS QtdeInteracoes

    FROM Aluno_Primeiro_Dia AS t1

    LEFT JOIN transacoes AS t2
    ON t1.IdCliente = t2.IdCliente
    AND DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'

    GROUP BY ClientesPrim, dtDia
),

tb_rn AS (

    SELECT *, 
        row_number() OVER (PARTITION BY ClientesPrim ORDER BY QtdeInteracoes DESC, dtDia) AS rn

    FROM tb_dia_clientes
)


SELECT * 
FROM tb_rn
WHERE rn = 1