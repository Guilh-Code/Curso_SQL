-- Em 2024, quantas transações de Lovers tivemos?

SELECT 
        count(DISTINCT t1.IdTransacao) AS QtdeTransacoes2024,
        count(DISTINCT t1.IdCliente) AS QtdePessoas,
        t3.DescCateogriaProduto

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE DtCriacao >= '2024-01-01'
AND DtCriacao < '2025-01-01'
--AND t3.DescCateogriaProduto = 'lovers'

GROUP BY t3.DescCateogriaProduto

ORDER BY QtdeTransacoes2024 DESC
