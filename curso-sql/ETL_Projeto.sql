CREATE TABLE tb_projeto AS 

WITH tb_transacoes AS (

    SELECT IdTransacao,
           idCliente,
           QtdePontos,
           datetime(substr(DtCriacao, 1, 19)) AS DtCriacao,
           julianday('now') - julianday(substr(DtCriacao, 1, 10)) AS diffDate,
           CAST(strftime('%H', substr(DtCriacao, 1, 19)) AS INTEGER) AS dtHora

    FROM transacoes
),

tb_cliente AS (

    SELECT idCliente,
           datetime(substr(DtCriacao, 1, 19)) AS DtCriacao,
           julianday('now') - julianday(substr(DtCriacao, 1, 10)) AS IdadeBase
    
    FROM clientes
),

tb_sumario_transacoes AS (

    SELECT idCliente,

        count(DISTINCT IdTransacao) AS qtdeTransacoesVida,
        count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS qtdeTransacoes56,
        count(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS qtdeTransacoes28,
        count(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS qtdeTransacoes14,
        count(CASE WHEN diffDate <= 7 THEN IdTransacao END) AS qtdeTransacoes7,

        sum(qtdePontos) AS saldoPontos,

        ROUND(min(diffDate), 2) AS DiasUltimaInteracao,

        sum(CASE WHEN qtdePontos > 0 THEN qtdePontos ELSE 0 END) AS qtdePontosPosVida,
        sum(CASE WHEN qtdePontos > 0 AND diffDate <= 56 THEN qtdePontos ELSE 0 END) AS QtdePontosPos56,
        sum(CASE WHEN qtdePontos > 0 AND diffDate <= 28 THEN qtdePontos ELSE 0 END) AS QtdePontosPos28,
        sum(CASE WHEN qtdePontos > 0 AND diffDate <= 14 THEN qtdePontos ELSE 0 END) AS QtdePontosPos14,
        sum(CASE WHEN qtdePontos > 0 AND diffDate <=  7 THEN qtdePontos ELSE 0 END) AS QtdePontosPos7,

        sum(CASE WHEN qtdePontos < 0 THEN qtdePontos ELSE 0 END) AS qtdePontosNegVida,
        sum(CASE WHEN qtdePontos < 0 AND diffDate <= 56 THEN qtdePontos ELSE 0 END) AS QtdePontosNeg56,
        sum(CASE WHEN qtdePontos < 0 AND diffDate <= 28 THEN qtdePontos ELSE 0 END) AS QtdePontosNeg28,
        sum(CASE WHEN qtdePontos < 0 AND diffDate <= 14 THEN qtdePontos ELSE 0 END) AS QtdePontosNeg14,
        sum(CASE WHEN qtdePontos < 0 AND diffDate <=  7 THEN qtdePontos ELSE 0 END) AS QtdePontosNeg7

    FROM tb_transacoes
    GROUP BY idCliente
),

tb_transacao_produto AS (

    SELECT t1.*,
        t2.IdProduto,
        t3.DescNomeProduto,
        t3.DescCategoriaProduto

    FROM tb_transacoes AS t1

    LEFT JOIN transacao_produto AS t2
    ON t1.IdTransacao = t2.IdTransacao

    LEFT JOIN produtos AS t3
    ON t2.IdProduto = t3.IdProduto
),

tb_cliente_produto AS (

    SELECT idCliente,
        DescNomeProduto,
        count(*) AS QtdeVida,
        count( CASE WHEN diffDate <= 56 THEN IdTransacao END) AS qtde56,
        count( CASE WHEN diffDate <= 28 THEN IdTransacao END) AS qtde28,
        count( CASE WHEN diffDate <= 14 THEN IdTransacao END) AS qtde14,
        count( CASE WHEN diffDate <= 7 THEN IdTransacao END) AS  qtde7

    FROM tb_transacao_produto
    GROUP BY idCliente, DescNomeProduto
),

tb_cliente_produto_rn AS (

    SELECT *,
        row_number() OVER (PARTITION BY idCliente ORDER BY QtdeVida DESC) AS rnVida,
        row_number() OVER (PARTITION BY idCliente ORDER BY Qtde56 DESC) AS rn56,
        row_number() OVER (PARTITION BY idCliente ORDER BY Qtde28 DESC) AS rn28,
        row_number() OVER (PARTITION BY idCliente ORDER BY Qtde14 DESC) AS rn14,
        row_number() OVER (PARTITION BY idCliente ORDER BY Qtde7 DESC) AS rn7

    FROM tb_cliente_produto
),

tb_cliente_dia AS (

    SELECT IdCliente,
        strftime('%w', DtCriacao) AS dtDia,
        count(*) AS QtdeTransacao

    FROM tb_transacoes
    WHERE diffDate <= 28
    GROUP BY idCliente, dtDia
),

tb_cliente_dia_rn AS (

    SELECT *,
        row_number() OVER (PARTITION BY idCliente ORDER BY QtdeTransacao DESC) AS rnDia

    FROM tb_cliente_dia
),

tb_cliente_periodo AS (

    SELECT
        idCliente,

        CASE 
            WHEN dtHora BETWEEN 7 AND 12 THEN 'Manhã'
            WHEN dtHora BETWEEN 13 AND 18 THEN 'Tarde'
            WHEN dtHora BETWEEN 19 AND 23 THEN 'Noite'
            ELSE 'Madrugada'
        END AS periodo,
        
        count(*) AS QtdeTransacao

    FROM tb_transacoes
    WHERE diffDate <= 28

    GROUP BY 1, 2
),

tb_cliente_periodo_rn AS (

    SELECT *,
        row_number() OVER ( PARTITION BY idCliente ORDER BY QtdeTransacao DESC) AS rnPeriodo

    FROM tb_cliente_periodo
),


tb_join AS (

    SELECT t1.*,
        ROUND(t2.IdadeBase, 2) AS IdadeBase,
        t3.DescNomeProduto AS produtoVida,
        t4.DescNomeProduto AS produto56,
        t5.DescNomeProduto AS produto28,
        t6.DescNomeProduto AS produto14,
        t7.DescNomeProduto AS produto7,
        COALESCE(t8.dtDia, -1) AS dtDia,
        COALESCE(t9.periodo, 'Sem Informação') AS PeriodoMaisTransacao28

    FROM tb_sumario_transacoes AS t1

    LEFT JOIN tb_cliente AS t2
    ON t1.idCliente = t2.idCliente

    LEFT JOIN tb_cliente_produto_rn AS t3
    ON t1.idCliente = t3.idCliente
    AND t3.rnVida = 1

    LEFT JOIN tb_cliente_produto_rn AS t4
    ON t1.idCliente = t4.idCliente
    AND t4.rn56 = 1

    LEFT JOIN tb_cliente_produto_rn AS t5
    ON t1.idCliente = t5.idCliente
    AND t5.rn28 = 1

    LEFT JOIN tb_cliente_produto_rn AS t6
    ON t1.idCliente = t6.idCliente
    AND t6.rn14 = 1

    LEFT JOIN tb_cliente_produto_rn AS t7
    ON t1.idCliente = t7.idCliente
    AND t7.rn7 = 1

    LEFT JOIN tb_cliente_dia_rn AS t8
    ON t1.idCliente = t8.idCliente
    AND rnDia = 1

    LEFT JOIN tb_cliente_periodo_rn AS t9
    ON t1.idCliente = t9.idCliente
    AND rnPeriodo = 1
)

SELECT *,
       1. * qtdeTransacoes28 / qtdeTransacoesVida AS engajamento28Vida

FROM tb_join
