-- Intervalos
-- de 0 a 500          -> Ponei
-- de 501 a 1000       -> Ponei Premium
-- de 1001 a 5000      -> Mago Aprendiz
-- de 5001 a 10000     -> Mago Mestre
-- +10001              -> Mago Supremo

SELECT IdCliente, 
       QtdePontos,

        CASE
            WHEN QtdePontos <= 500 THEN 'Ponei'
        END    

FROM clientes

ORDER BY QtdePontos DESC

