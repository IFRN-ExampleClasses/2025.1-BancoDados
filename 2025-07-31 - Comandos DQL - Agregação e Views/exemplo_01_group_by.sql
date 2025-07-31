-- --------------------------------------------------------------------------------
-- Contando a quantidade de registros da tabela "itens_comandas":
SELECT COUNT(*) FROM barzinho.itens_comandas;


-- --------------------------------------------------------------------------------
-- Exibindo o ID da comanda e quantos itens a comanda tem (SUB-CONSULTAS):
  SELECT comandas.id_comanda,
  		 comandas.numero_mesa,
		 comandas.data_abertura,
		 comandas.data_fechamento,

		 (SELECT garcons.nome_garcom
		    FROM barzinho.garcons
		   WHERE comandas.cpf_garcom = garcons.cpf_garcom),
		   
		 (SELECT COUNT(itens_comandas.id_comanda)
		    FROM barzinho.itens_comandas 
		   WHERE comandas.id_comanda = itens_comandas.id_comanda) AS "qt_itens",
 		
		 (SELECT SUM(itens_comandas.preco_unitario * itens_comandas.quantidade)
		    FROM barzinho.itens_comandas 
	 	   WHERE comandas.id_comanda = itens_comandas.id_comanda) AS "valor_comanda"

    FROM barzinho.comandas
   
ORDER BY comandas.id_comanda;


-- --------------------------------------------------------------------------------
-- Exibindo o ID da comanda e quantos itens a comanda tem (JOIN + GROUP BY):
  SELECT comandas.id_comanda,
  		 comandas.numero_mesa,
		 comandas.data_abertura,
		 comandas.data_fechamento,

		 garcons.nome_garcom,
		 
   		 COUNT(itens_comandas.id_comanda) AS "qt_itens",
 		 SUM(itens_comandas.preco_unitario * itens_comandas.quantidade) AS "valor_comanda"

	FROM barzinho.comandas

	JOIN barzinho.itens_comandas ON comandas.id_comanda = itens_comandas.id_comanda
	JOIN barzinho.garcons		 ON comandas.cpf_garcom = garcons.cpf_garcom

GROUP BY comandas.id_comanda, comandas.numero_mesa, comandas.data_abertura,
		 comandas.data_fechamento, garcons.nome_garcom

ORDER BY comandas.id_comanda;
   