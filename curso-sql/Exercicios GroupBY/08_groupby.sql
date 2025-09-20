-- Qual o produto com mais pontos transacionados?

SELECT IdProduto,
        sum(VlProduto * QtdeProduto) AS TotalPontos,
        sum(QtdeProduto) AS QtdeVenda

FROM transacao_produto

GROUP BY 1

ORDER BY 2 DESC
