-- Qual dia da semana quem mais pedidos em 2025?

SELECT
        strftime('%w', datetime(substr(DtCriacao, 1, 10))) AS DiaDaSemana,
            
        count(IdTransacao) AS PedidosPorDia

FROM transacoes

WHERE DtCriacao > '2024-12-31'

GROUP BY 1

ORDER BY 2 DESC
