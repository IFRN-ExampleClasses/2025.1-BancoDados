DO
$$
DECLARE
   item_comanda RECORD;
   itens_comanda_json JSONB;
   idx INT;
   total INT;
   v_sqlstate TEXT;
   v_sqlerrm TEXT;
BEGIN
	-- Lista de itens de comandas a serem inseridos
	itens_comanda_json := '[
		{"id_comanda": 1, "id_produto": 12, "quantidade": 3},
		{"id_comanda": 1, "id_produto": 27, "quantidade": 1},
		{"id_comanda": 1, "id_produto": 5, "quantidade": 2},
		{"id_comanda": 1, "id_produto": 33, "quantidade": 1},
		{"id_comanda": 1, "id_produto": 9, "quantidade": 4},
		{"id_comanda": 1, "id_produto": 21, "quantidade": 2},
		{"id_comanda": 2, "id_produto": 2, "quantidade": 2},
		{"id_comanda": 2, "id_produto": 41, "quantidade": 1},
		{"id_comanda": 2, "id_produto": 18, "quantidade": 3},
		{"id_comanda": 2, "id_produto": 7, "quantidade": 1},
		{"id_comanda": 2, "id_produto": 25, "quantidade": 2},
		{"id_comanda": 2, "id_produto": 13, "quantidade": 1},
		{"id_comanda": 3, "id_produto": 44, "quantidade": 5},
		{"id_comanda": 3, "id_produto": 30, "quantidade": 1},
		{"id_comanda": 3, "id_produto": 8, "quantidade": 2},
		{"id_comanda": 3, "id_produto": 1, "quantidade": 3},
		{"id_comanda": 3, "id_produto": 21, "quantidade": 1},
		{"id_comanda": 3, "id_produto": 50, "quantidade": 2},
		{"id_comanda": 4, "id_produto": 19, "quantidade": 2},
		{"id_comanda": 4, "id_produto": 6, "quantidade": 4},
		{"id_comanda": 4, "id_produto": 3, "quantidade": 1},
		{"id_comanda": 4, "id_produto": 10, "quantidade": 3},
		{"id_comanda": 4, "id_produto": 17, "quantidade": 1},
		{"id_comanda": 4, "id_produto": 39, "quantidade": 2},
		{"id_comanda": 4, "id_produto": 11, "quantidade": 2},
		{"id_comanda": 5, "id_produto": 29, "quantidade": 4},
		{"id_comanda": 5, "id_produto": 23, "quantidade": 1},
		{"id_comanda": 5, "id_produto": 35, "quantidade": 2},
		{"id_comanda": 5, "id_produto": 48, "quantidade": 3},
		{"id_comanda": 5, "id_produto": 15, "quantidade": 1},
		{"id_comanda": 5, "id_produto": 7, "quantidade": 4},
		{"id_comanda": 6, "id_produto": 14, "quantidade": 2},
		{"id_comanda": 6, "id_produto": 20, "quantidade": 1},
		{"id_comanda": 6, "id_produto": 9, "quantidade": 3},
		{"id_comanda": 6, "id_produto": 4, "quantidade": 1},
		{"id_comanda": 6, "id_produto": 30, "quantidade": 2},
		{"id_comanda": 6, "id_produto": 50, "quantidade": 5},
		{"id_comanda": 7, "id_produto": 1, "quantidade": 4},
		{"id_comanda": 7, "id_produto": 11, "quantidade": 3},
		{"id_comanda": 7, "id_produto": 22, "quantidade": 1},
		{"id_comanda": 7, "id_produto": 17, "quantidade": 2},
		{"id_comanda": 7, "id_produto": 6, "quantidade": 1},
		{"id_comanda": 7, "id_produto": 38, "quantidade": 2},
		{"id_comanda": 8, "id_produto": 12, "quantidade": 3},
		{"id_comanda": 8, "id_produto": 25, "quantidade": 2},
		{"id_comanda": 8, "id_produto": 19, "quantidade": 1},
		{"id_comanda": 8, "id_produto": 43, "quantidade": 4},
		{"id_comanda": 8, "id_produto": 37, "quantidade": 1},
		{"id_comanda": 8, "id_produto": 5, "quantidade": 2},
		{"id_comanda": 8, "id_produto": 16, "quantidade": 1},
		{"id_comanda": 9, "id_produto": 3, "quantidade": 5},
		{"id_comanda": 9, "id_produto": 28, "quantidade": 1},
		{"id_comanda": 9, "id_produto": 9, "quantidade": 2},
		{"id_comanda": 9, "id_produto": 44, "quantidade": 3},
		{"id_comanda": 9, "id_produto": 7, "quantidade": 1},
		{"id_comanda": 10, "id_produto": 13, "quantidade": 4},
		{"id_comanda": 10, "id_produto": 22, "quantidade": 1},
		{"id_comanda": 10, "id_produto": 34, "quantidade": 2},
		{"id_comanda": 10, "id_produto": 5, "quantidade": 3},
		{"id_comanda": 10, "id_produto": 47, "quantidade": 2},
		{"id_comanda": 10, "id_produto": 8, "quantidade": 1},
		{"id_comanda": 11, "id_produto": 15, "quantidade": 4},
		{"id_comanda": 11, "id_produto": 2, "quantidade": 3},
		{"id_comanda": 11, "id_produto": 33, "quantidade": 1},
		{"id_comanda": 11, "id_produto": 6, "quantidade": 2},
		{"id_comanda": 11, "id_produto": 9, "quantidade": 1},
		{"id_comanda": 12, "id_produto": 21, "quantidade": 3},
		{"id_comanda": 12, "id_produto": 48, "quantidade": 2},
		{"id_comanda": 12, "id_produto": 37, "quantidade": 4},
		{"id_comanda": 12, "id_produto": 5, "quantidade": 1},
		{"id_comanda": 12, "id_produto": 10, "quantidade": 3},
		{"id_comanda": 13, "id_produto": 19, "quantidade": 2},
		{"id_comanda": 13, "id_produto": 29, "quantidade": 1},
		{"id_comanda": 13, "id_produto": 42, "quantidade": 3},
		{"id_comanda": 13, "id_produto": 14, "quantidade": 2},
		{"id_comanda": 14, "id_produto": 33, "quantidade": 1},
		{"id_comanda": 14, "id_produto": 5, "quantidade": 4},
		{"id_comanda": 14, "id_produto": 8, "quantidade": 3},
		{"id_comanda": 14, "id_produto": 26, "quantidade": 2},
		{"id_comanda": 14, "id_produto": 11, "quantidade": 1},
		{"id_comanda": 15, "id_produto": 3, "quantidade": 4},
		{"id_comanda": 15, "id_produto": 17, "quantidade": 2},
		{"id_comanda": 15, "id_produto": 21, "quantidade": 1},
		{"id_comanda": 15, "id_produto": 44, "quantidade": 3},
		{"id_comanda": 15, "id_produto": 12, "quantidade": 2},
		{"id_comanda": 15, "id_produto": 9, "quantidade": 1},
		{"id_comanda": 16, "id_produto": 4, "quantidade": 3},
		{"id_comanda": 16, "id_produto": 20, "quantidade": 1},
		{"id_comanda": 16, "id_produto": 27, "quantidade": 4},
		{"id_comanda": 16, "id_produto": 7, "quantidade": 2},
		{"id_comanda": 16, "id_produto": 15, "quantidade": 1},
		{"id_comanda": 17, "id_produto": 13, "quantidade": 3},
		{"id_comanda": 17, "id_produto": 5, "quantidade": 2},
		{"id_comanda": 17, "id_produto": 11, "quantidade": 1},
		{"id_comanda": 17, "id_produto": 30, "quantidade": 4},
		{"id_comanda": 17, "id_produto": 2, "quantidade": 3},
		{"id_comanda": 18, "id_produto": 18, "quantidade": 5},
		{"id_comanda": 18, "id_produto": 24, "quantidade": 2},
		{"id_comanda": 18, "id_produto": 6, "quantidade": 1},
		{"id_comanda": 18, "id_produto": 45, "quantidade": 3},
		{"id_comanda": 18, "id_produto": 39, "quantidade": 2},
		{"id_comanda": 18, "id_produto": 9, "quantidade": 1},
		{"id_comanda": 19, "id_produto": 31, "quantidade": 4},
		{"id_comanda": 19, "id_produto": 5, "quantidade": 2},
		{"id_comanda": 19, "id_produto": 27, "quantidade": 1},
		{"id_comanda": 19, "id_produto": 20, "quantidade": 3},
		{"id_comanda": 19, "id_produto": 12, "quantidade": 2},
		{"id_comanda": 20, "id_produto": 14, "quantidade": 1},
		{"id_comanda": 20, "id_produto": 33, "quantidade": 3},
		{"id_comanda": 20, "id_produto": 48, "quantidade": 4},
		{"id_comanda": 20, "id_produto": 10, "quantidade": 2},
		{"id_comanda": 20, "id_produto": 23, "quantidade": 1},
		{"id_comanda": 20, "id_produto": 7, "quantidade": 3}
	]'::jsonb;

   total := jsonb_array_length(itens_comanda_json);

   FOR idx IN 0..total - 1 LOOP
      SELECT *
      INTO item_comanda
      FROM jsonb_to_record(itens_comanda_json->idx)
         AS x(id_comanda INT, id_produto INT, quantidade INT);

      BEGIN
         INSERT INTO barzinho.itens_comandas (
            id_comanda,
            id_produto,
            quantidade
         ) VALUES (
            item_comanda.id_comanda,
            item_comanda.id_produto,
            item_comanda.quantidade
         );

         RAISE NOTICE 'Item inserido com sucesso: Comanda %, Produto %, Quantidade %',
            item_comanda.id_comanda, item_comanda.id_produto, item_comanda.quantidade;

      EXCEPTION WHEN OTHERS THEN
         GET STACKED DIAGNOSTICS
            v_sqlstate = RETURNED_SQLSTATE,
            v_sqlerrm = MESSAGE_TEXT;

         RAISE NOTICE 'Erro ao inserir item: Comanda %, Produto %, Quantidade % | Código: % | Mensagem: %',
            item_comanda.id_comanda, item_comanda.id_produto, item_comanda.quantidade, v_sqlstate, v_sqlerrm;
      END;
   END LOOP;
END;
$$ LANGUAGE plpgsql;
