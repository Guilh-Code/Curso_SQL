-- Qual mês tivemos mais lista de presença assinada?

SELECT 
        count(DISTINCT t1.IdTransacao) AS QtdeTransacoes,
        substr(t1.DtCriacao, 1, 7) AS AnoMes,
        t3.DescProduto

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE t3.DescProduto = 'Lista de presença' 

GROUP BY AnoMes

ORDER BY QtdeTransacoes DESC

