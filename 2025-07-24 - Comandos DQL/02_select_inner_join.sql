/*
	FAZER UMA CONSULTA QUE RETORNE OS ITENS DO CARDAPIO QUE FORAM PEDIDOS (NOME DO PRODUTO, 
	NOME DA CATEGORIA, QUANTIDADE E VALOR DO PRODUTO), O NÚMERO DA MESA E O NOME DO GARÇOM 
	QUE ATENDEU A MESA. 
	
	LISTE APENAS AS MESAS ATENDIDAS NO DIA 08/06/2025
*/

 SELECT comandas.id_comanda,
		comandas.numero_mesa,
		comandas.data_abertura,
		garcons.nome_garcom,
 		produtos.nome_produto,
		categorias_produtos.descricao,
		itens_comandas.quantidade,
		itens_comandas.preco_unitario

   FROM barzinho.comandas
   
   INNER JOIN barzinho.garcons 				ON garcons.cpf_garcom = comandas.cpf_garcom 
   INNER JOIN barzinho.itens_comandas 		ON itens_comandas.id_comanda = comandas.id_comanda
   INNER JOIN barzinho.produtos 			ON produtos.id_produto = itens_comandas.id_produto 
   INNER JOIN barzinho.categorias_produtos 	ON produtos.id_categoria = categorias_produtos.id_categoria

  --WHERE comandas.data_abertura BETWEEN '2025-06-08 18:00:00' AND '2025-06-09 02:00:00';
