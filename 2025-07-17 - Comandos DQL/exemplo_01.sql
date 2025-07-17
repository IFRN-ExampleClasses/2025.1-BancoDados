--SELECT * FROM barzinho.garcons ORDER BY nome_garcom;

/*
SELECT produtos.nome_produto, 
  		 produtos.preco_unitario, 
		 produtos.id_categoria 
    FROM barzinho.produtos
--   WHERE produtos.id_categoria = 6 OR produtos.id_categoria = 8 OR produtos.id_categoria = 9
   WHERE produts.id_categoria IN (6, 8, 9)
ORDER BY produtos.nome_produto;
*/

  SELECT produtos.nome_produto AS "produto",
  		 produtos.preco_unitario AS "preço",
		 --produtos.id_categoria,
	     (SELECT categorias_produtos.descricao FROM barzinho.categorias_produtos 
		   WHERE produtos.id_categoria = categorias_produtos.id_categoria) AS "categoria"
    FROM barzinho.produtos
ORDER BY produtos.nome_produto;



