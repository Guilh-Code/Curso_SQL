-- Qual o total de pontos trocados no Stream Elements em Junho de 2025?

SELECT sum(t1.QtdePontos) AS PontosTrocados

FROM transacoes AS t1

INNER JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

INNER JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE t1.DtCriacao >= '2025-06-01'
AND t1.DtCriacao < '2025-07-01'
AND t3.DescProduto = 'Troca de Pontos StreamElements'

