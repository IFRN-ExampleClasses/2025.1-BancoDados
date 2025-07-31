-- --------------------------------------------------------------------------------
-- Criando a view "relatorio_comandas":
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


-- --------------------------------------------------------------------------------
-- Usando a view "relatorio_comandas":
SELECT * 
  FROM barzinho.relatorio_comandas
 WHERE relatorio_comandas.data_abertura BETWEEN '2025-06-08 18:00:00' AND '2025-06-09 02:00:00';