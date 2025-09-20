-- Qual o produto mais transacionado?

SELECT IdProduto,
        COUNT(IdTransacaoProduto) AS QtdeTransacoes

FROM transacao_produto

GROUP BY IdProduto

ORDER BY QtdeTransacoes DESC

LIMIT 1;



SELECT IdProduto, DescProduto, DescCateogriaProduto

FROM produtos

WHERE IdProduto = 5

ORDER BY IdProduto;