-- Clientes mais antigos, tem mais frequência de transação?

SELECT t1.IdCliente,
        CAST(julianday('now') - julianday(substr(t1.DtCriacao, 1, 19)) AS INT) AS IdadeBase,
        count(t2.IdTransacao) AS QtdeTransacoes


FROM clientes AS t1

LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente

GROUP BY t1.IdCliente, IdadeBase

ORDER BY QtdeTransacoes DESC