-- Quais clientes mais perderam pontos por Lover?

SELECT t1.IdCliente,
        sum(t1.QtdePontos) AS PontosPerdidos

FROM transacoes AS t1

INNER JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

INNER JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE t3.DescCateogriaProduto = 'lovers'
AND t1.QtdePontos < 0

GROUP BY t1.IdCliente

ORDER BY PontosPerdidos

LIMIT 5