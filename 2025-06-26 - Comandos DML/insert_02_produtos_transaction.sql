DO
$$
DECLARE
    -- Define explicitamente os campos esperados no RECORD
    produto RECORD;
    produtos_json JSONB;
    idx INT;
    total INT;
    v_sqlstate TEXT;
    v_sqlerrm TEXT;
BEGIN
	-- Lista de produtos a serem inseridos (AQUI DENTRO AGORA)
	produtos_json := '[
	  {"nome": "Cerveja Heineken Long Neck", "preco": 9.50, "categoria": 1},
	  {"nome": "Caipirinha de Limão", "preco": 12.00, "categoria": 8},
	  {"nome": "Porção de Batata Frita", "preco": 18.00, "categoria": 3},
	  {"nome": "Refrigerante Lata", "preco": 6.00, "categoria": 2},
	  {"nome": "Hambúrguer Artesanal", "preco": 22.00, "categoria": 5},
	  {"nome": "Cerveja Skol 600ml", "preco": 7.50, "categoria": 1},
	  {"nome": "Água com Gás", "preco": 4.00, "categoria": 2},
	  {"nome": "Espetinho de Frango", "preco": 8.00, "categoria": 4},
	  {"nome": "Calabresa Acebolada", "preco": 19.00, "categoria": 3},
	  {"nome": "Caipiroska de Morango", "preco": 15.00, "categoria": 8},
	  {"nome": "Pastel de Queijo", "preco": 7.00, "categoria": 4},
	  {"nome": "Cerveja Brahma Duplo Malte", "preco": 8.00, "categoria": 1},
	  {"nome": "Porção de Mandioca Frita", "preco": 17.00, "categoria": 3},
	  {"nome": "Suco Natural de Laranja", "preco": 8.00, "categoria": 2},
	  {"nome": "Cachaça Artesanal", "preco": 10.00, "categoria": 1},
	  {"nome": "Bolinho de Feijoada", "preco": 9.50, "categoria": 4},
	  {"nome": "Milkshake de Chocolate", "preco": 12.00, "categoria": 6},
	  {"nome": "Combo de Mini Burgers", "preco": 25.00, "categoria": 5},
	  {"nome": "Porção de Torresmo", "preco": 16.00, "categoria": 3},
	  {"nome": "Negroni", "preco": 18.00, "categoria": 8},
	  {"nome": "Batida de Coco", "preco": 11.00, "categoria": 8},
	  {"nome": "Queijo Coalho na Brasa", "preco": 10.00, "categoria": 4},
	  {"nome": "Brigadeiro Gourmet", "preco": 5.00, "categoria": 6},
	  {"nome": "Churros com Doce de Leite", "preco": 8.00, "categoria": 6},
	  {"nome": "Pastel de Carne Seca", "preco": 8.00, "categoria": 4},
	  {"nome": "Cerveja IPA 500ml", "preco": 14.00, "categoria": 7},
	  {"nome": "Porção de Frango à Passarinho", "preco": 20.00, "categoria": 3},
	  {"nome": "Guaraná Natural", "preco": 6.50, "categoria": 2},
	  {"nome": "Espetinho de Coração", "preco": 9.00, "categoria": 4},
	  {"nome": "Tábua de Frios", "preco": 28.00, "categoria": 9},
	  {"nome": "Brownie com Sorvete", "preco": 10.00, "categoria": 6},
	  {"nome": "Shot de Tequila", "preco": 9.00, "categoria": 1},
	  {"nome": "Suco Detox", "preco": 9.00, "categoria": 2},
	  {"nome": "Hambúrguer com Bacon", "preco": 23.00, "categoria": 5},
	  {"nome": "Porção de Polenta Frita", "preco": 17.00, "categoria": 3},
	  {"nome": "Gin Tônica", "preco": 17.00, "categoria": 8},
	  {"nome": "Doce de Abóbora com Coco", "preco": 7.00, "categoria": 6},
	  {"nome": "Pipoca Artesanal", "preco": 5.00, "categoria": 4},
	  {"nome": "Linguiça Artesanal Acebolada", "preco": 20.00, "categoria": 9},
	  {"nome": "Cerveja Stout 500ml", "preco": 15.00, "categoria": 7},
	  {"nome": "Drink de Maracujá com Rum", "preco": 16.00, "categoria": 8},
	  {"nome": "Água Tônica", "preco": 5.50, "categoria": 2},
	  {"nome": "Bolinho de Bacalhau", "preco": 12.00, "categoria": 4},
	  {"nome": "Empanada Chilena", "preco": 10.00, "categoria": 9},
	  {"nome": "Ice de Limão", "preco": 10.00, "categoria": 1},
	  {"nome": "Rapadura com Queijo", "preco": 6.00, "categoria": 6},
	  {"nome": "Vodka Nacional Dose", "preco": 7.00, "categoria": 1},
	  {"nome": "Havana com Coca-Cola", "preco": 15.00, "categoria": 8},
	  {"nome": "Narguilé com Essência Maçã", "preco": 30.00, "categoria": 10},
	  {"nome": "Charuto Cubano", "preco": 40.00, "categoria": 10}
	]'::jsonb;

    total := jsonb_array_length(produtos_json);

    FOR idx IN 0..total - 1 LOOP
        -- Preenche o RECORD com os campos desejados
        SELECT *
        INTO produto
        FROM jsonb_to_record(produtos_json->idx)
        AS x(nome TEXT, preco NUMERIC, categoria INTEGER);

        BEGIN
            -- Insere no banco de dados
            INSERT INTO barzinho.produtos (nome_produto, preco_unitario, id_categoria)
            VALUES (
                produto.nome,
                produto.preco,
                produto.categoria
            );

            RAISE NOTICE 'Produto inserido com sucesso: %', produto.nome;

        EXCEPTION WHEN OTHERS THEN
            GET STACKED DIAGNOSTICS
                v_sqlstate = RETURNED_SQLSTATE,
                v_sqlerrm = MESSAGE_TEXT;

            RAISE NOTICE 'Erro ao inserir produto: % | Código: % | Mensagem: %',
                produto.nome, v_sqlstate, v_sqlerrm;
        END;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
