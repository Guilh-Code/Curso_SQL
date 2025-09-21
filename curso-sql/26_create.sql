-- DROP TABLE IF EXISTS clientes_28;

CREATE TABLE IF NOT EXISTS clientes_28 (

    IdCliente varchar(250) PRIMARY KEY,  
    Qtdetransacoes INTEGER
);

DELETE FROM clientes_28;

INSERT INTO clientes_28
SELECT IdCliente,
       count(DISTINCT IdTransacao) AS Qtdetransacoes

FROM transacoes
WHERE julianday('now') - julianday(substr(DtCriacao, 1, 10)) <= 28
GROUP BY IdCliente
;

SELECT * FROM clientes_28;