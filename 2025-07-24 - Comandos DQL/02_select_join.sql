/*
	FAZER UMA CONSULTA QUE RETORNE OS ITENS DO CARDAPIO QUE FORAM PEDIDOS (NOME DO PRODUTO, 
	NOME DA CATEGORIA, QUANTIDADE E VALOR DO PRODUTO), O NÚMERO DA MESA E O NOME DO GARÇOM 
	QUE ATENDEU A MESA. 
	
	LISTE APENAS AS MESAS ATENDIDAS NO DIA 08/06/2025
*/

 SELECT comandas.id_comanda,
 		produtos.nome_produto,
		categorias_produtos.descricao,
		itens_comandas.quantidade,
		itens_comandas.preco_unitario,
		comandas.numero_mesa,
		comandas.data_abertura,
		garcons.nome_garcom

   FROM barzinho.itens_comandas
   
   JOIN barzinho.produtos 				ON itens_comandas.id_produto = produtos.id_produto
   JOIN barzinho.categorias_produtos 	ON produtos.id_categoria = categorias_produtos.id_categoria
   JOIN barzinho.comandas 				ON itens_comandas.id_comanda = comandas.id_comanda
   JOIN barzinho.garcons 				ON comandas.cpf_garcom = garcons.cpf_garcom

  --WHERE comandas.data_abertura BETWEEN '2025-06-08 18:00:00' AND '2025-06-09 02:00:00';
