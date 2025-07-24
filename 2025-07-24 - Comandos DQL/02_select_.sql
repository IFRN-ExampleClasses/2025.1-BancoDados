-- -----------------------------------------------------------------------------------------
-- EXEMPLO 01
-- Listando as comandas que não possuem itens solicitados (USANDO SUB-CONSULTA)
  SELECT comandas.id_comanda,
		 comandas.numero_mesa,
		 comandas.cpf_garcom

    FROM barzinho.comandas

   WHERE comandas.id_comanda NOT IN (  SELECT DISTINCT itens_comandas.id_comanda 
 			    				  		 FROM barzinho.itens_comandas 
									 ORDER BY itens_comandas.id_comanda)

ORDER BY comandas.id_comanda;


-- -----------------------------------------------------------------------------------------
-- EXEMPLO 02
-- Listando as comandas que não possuem itens solicitados (USANDO SUB-CONSULTA)
  SELECT comandas.id_comanda,
		 comandas.numero_mesa,
		 comandas.cpf_garcom

	FROM barzinho.comandas

   WHERE (SELECT COUNT(*) 
		    FROM barzinho.itens_comandas 
		   WHERE itens_comandas.id_comanda = comandas.id_comanda) = 0

ORDER BY comandas.id_comanda;



-- -----------------------------------------------------------------------------------------
-- EXEMPLO 03
-- Listando as comandas que não possuem itens solicitados (USANDO LEFT JOIN)
   SELECT comandas.id_comanda,
          comandas.numero_mesa,
          comandas.cpf_garcom
		  
     FROM barzinho.comandas

LEFT JOIN barzinho.itens_comandas ON comandas.id_comanda = itens_comandas.id_comanda
   
    WHERE itens_comandas.id_comanda IS NULL

 ORDER BY comandas.id_comanda;