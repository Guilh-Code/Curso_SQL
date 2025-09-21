-- Qual o dia com maior engajamento de cada aluno que iniciou o curso no dia 01?


WITH Aluno_Primeiro_Dia AS (
    -- Perfeito, sem alterações.
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

Aluno_Curso AS (
    -- Perfeito, sem alterações.
    SELECT
        IdCliente,
        substr(DtCriacao, 1, 10) AS Dia,
        count(IdTransacao) AS QtdeTransacoes
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25' AND DtCriacao < '2025-08-30'
    GROUP BY IdCliente, Dia
),

EngajamentoRankeado AS (
    -- PASSO 3: Juntamos e criamos o ranking para cada aluno
    SELECT
        t1.IdCliente,
        t2.Dia,
        t2.QtdeTransacoes,
        ROW_NUMBER() OVER(PARTITION BY t1.IdCliente ORDER BY t2.QtdeTransacoes DESC) as ranking
    FROM
        Aluno_Primeiro_Dia AS t1
    INNER JOIN
        Aluno_Curso AS t2 ON t1.IdCliente = t2.IdCliente
)

-- PASSO FINAL: Filtramos apenas os dias que ficaram em 1º lugar no ranking
SELECT
    IdCliente,
    Dia,
    QtdeTransacoes
FROM
    EngajamentoRankeado
WHERE
    ranking = 1;