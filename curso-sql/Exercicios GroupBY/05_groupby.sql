-- Qual o valor médio de pontos positivos por dia?

SELECT sum(QtdePontos) AS TotalPontos,

        COUNT(DISTINCT substr(DtCriacao, 1, 10)) AS QtdeDiasUnicos,

        sum(QtdePontos) / COUNT(DISTINCT substr(DtCriacao, 1, 10)) AS MediaPontos
        
FROM transacoes

WHERE QtdePontos > 0;


SELECT substr(DtCriacao, 1, 10) AS dtDia,
        AVG(QtdePontos) AS AVGPontosDia

FROM transacoes

WHERE QtdePontos > 0

GROUP BY 1

ORDER BY 2;
