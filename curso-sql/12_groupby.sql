--SELECT IdProduto,
--        count(*)


--FROM transacao_produto

--GROUP BY IdProduto

SELECT IdCliente,
        sum(QtdePontos) AS QtdePontosPorCliente,
        count(IdTransacao) AS QtdeTransacoes

FROM transacoes

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'

GROUP BY IdCliente
HAVING QtdePontosPorCliente >= 4000

ORDER BY QtdePontosPorCliente DESC

LIMIT 10
