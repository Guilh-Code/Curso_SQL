-- Quais clientes assinaram a lista de presença no dia 2025/08/25?

SELECT  
        DISTINCT t1.IdCliente

FROM transacoes AS t1

INNER JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

INNER JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE t1.DtCriacao LIKE '2025-08-25%'
AND t3.DescProduto = 'Lista de presença'
