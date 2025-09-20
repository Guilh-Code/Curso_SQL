-- Quantos produtos são de rpg?

SELECT DescCateogriaProduto,
        COUNT(DescCateogriaProduto) AS QtdeProdutos

FROM produtos

-- WHERE DescCateogriaProduto = 'rpg'

GROUP BY DescCateogriaProduto
