-- Dentre os clientes de janeiro/2025, quantos assistiram o curso de SQL?

WITH clientes_jan AS (

    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 7) = '2025-01'
),

curso_aulas AS (

    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'
)


SELECT count(t1.IdCliente) AS ClientesJan,
       count(t2.IdCliente) AS ClientesCurso 

FROM clientes_jan AS t1

LEFT JOIN curso_aulas AS t2
ON t1.IdCliente = t2.IdCliente;


-- Segundo opção MAIS DIRETA


WITH tb_clientes_janeiro AS (

    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 7) = '2025-01'
)

SELECT count(DISTINCT t1.IdCliente) AS ClienteJan,
       count(DISTINCT t2.IdCliente) AS ClienteCurso
FROM tb_clientes_janeiro AS t1

LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente
AND DtCriacao >= '2025-08-25'
AND DtCriacao < '2025-08-30';
