-- Quantidade de transações Acumuladas ao longo do tempo?

WITH TransacoesPorMes AS (
    -- PASSO 1: É a sua query original, que conta as transações POR mês. Perfeito!
    SELECT
        substr(DtCriacao, 1, 7) AS Mes,
        count(IdTransacao) AS QtdeTransacoesNoMes
    FROM
        transacoes
    GROUP BY
        Mes
)
-- PASSO 2: Agora, usamos o resultado anterior para calcular a soma acumulada
SELECT
    Mes,
    QtdeTransacoesNoMes,
    SUM(QtdeTransacoesNoMes) OVER (ORDER BY Mes) AS TransacoesAcumuladas
FROM
    TransacoesPorMes
ORDER BY
    Mes;