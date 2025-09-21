-- Qual o dia da semana mais ativo de cada usuário?

WITH td_semana_cliente AS (

    SELECT IdCliente,
        strftime('%w', substr(DtCriacao, 1, 10)) AS dtDia,
        count(DISTINCT IdTransacao) Qtdetransacao 

    FROM transacoes
    GROUP BY IdCliente, dtDia
),

tb_dias AS (

    SELECT *,
        CASE
            WHEN dtDia = '1' THEN 'Segunda-Feira'
            WHEN dtDia = '2' THEN 'Terça-Feira'
            WHEN dtDia = '3' THEN 'Quarta-Feira'
            WHEN dtDia = '4' THEN 'Quinta-Feira'
            WHEN dtDia = '5' THEN 'Sexta-Feira'
            WHEN dtDia = '6' THEN 'Sábado'
            ELSE 'Domingo'
        END AS descdiaSemana,
        row_number() OVER (PARTITION BY IdCliente ORDER BY Qtdetransacao DESC) AS rn

    FROM td_semana_cliente
)

SELECT *

FROM tb_dias
WHERE rn = 1