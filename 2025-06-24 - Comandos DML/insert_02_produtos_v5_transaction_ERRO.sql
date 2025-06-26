DO
$$
DECLARE
    v_sqlstate TEXT;
    v_sqlerrm TEXT;
BEGIN
    BEGIN
        -- Inserção de produtos
        INSERT INTO barzinho.produtos (nome_produto, preco_unitario, id_categoria) VALUES
        ('Cerveja Heineken Long Neck', 9.50, 1),
        ('Caipirinha de Limão', 12.00, 8),
        ('Porção de Batata Frita', 18.00, 3),
        ('Refrigerante Lata', 6.00, 2),
        ('Hambúrguer Artesanal', 22.00, 5),
        ('Cerveja Skol 600ml', 7.50, 1),
        ('Água com Gás', 4.00, 2),
        ('Espetinho de Frango', 8.00, 4),
        ('Calabresa Acebolada', 19.00, 3),
        ('Caipiroska de Morango', 15.00, 8),
        ('Pastel de Queijo', 7.00, 4),
        ('Cerveja Brahma Duplo Malte', 8.00, 1),
        ('Porção de Mandioca Frita', 17.00, 3),
        ('Suco Natural de Laranja', 8.00, 2),
        ('Cachaça Artesanal', 10.00, 1),
        ('Bolinho de Feijoada', 9.50, 4),
        ('Milkshake de Chocolate', 12.00, 6),
        ('Combo de Mini Burgers', 25.00, 5),
        ('Porção de Torresmo', 16.00, 3),
        ('Negroni', 18.00, 8),
        ('Batida de Coco', 11.00, 8),
        ('Queijo Coalho na Brasa', 10.00, 4),
        ('Brigadeiro Gourmet', 5.00, 6),
        ('Churros com Doce de Leite', 8.00, 6),
        ('Pastel de Carne Seca', 8.00, 4),
        ('Cerveja IPA 500ml', 14.00, 7),
        ('Porção de Frango à Passarinho', 20.00, 3),
        ('Guaraná Natural', 6.50, 2),
        ('Espetinho de Coração', 9.00, 4),
        ('Tábua de Frios', 28.00, 9),
        ('Brownie com Sorvete', 10.00, 6),
        ('Shot de Tequila', 9.00, 1),
        ('Suco Detox', 9.00, 2),
        ('Hambúrguer com Bacon', 23.00, 5),
        ('Porção de Polenta Frita', 17.00, 12), -- Simulando uma linha que pode causar erro
        ('Gin Tônica', 17.00, 8),
        ('Doce de Abóbora com Coco', 7.00, 6),
        ('Pipoca Artesanal', 5.00, 4),
        ('Linguiça Artesanal Acebolada', 20.00, 9),
        ('Cerveja Stout 500ml', 15.00, 7),
        ('Drink de Maracujá com Rum', 16.00, 8),
        ('Água Tônica', 5.50, 2),
        ('Bolinho de Bacalhau', 12.00, 4),
        ('Empanada Chilena', 10.00, 9),
        ('Ice de Limão', 10.00, 1),
        ('Rapadura com Queijo', 6.00, 6),
        ('Vodka Nacional Dose', 7.00, 1),
        ('Havana com Coca-Cola', 15.00, 8),
        ('Narguilé com Essência Maçã', 30.00, 10),
        ('Charuto Cubano', 40.00, 11);  -- Simulando uma linha que pode causar erro
        
        COMMIT;
        RAISE NOTICE 'Todos os produtos foram inseridos com sucesso.';
    EXCEPTION
        WHEN OTHERS THEN
            GET STACKED DIAGNOSTICS
                v_sqlstate = RETURNED_SQLSTATE,
                v_sqlerrm = MESSAGE_TEXT;
                
            ROLLBACK;
            RAISE NOTICE 'Erro ao inserir produtos. Transação desfeita.';
            RAISE NOTICE 'Código do erro: %, mensagem: %', v_sqlstate, v_sqlerrm;
    END;
END;
$$ LANGUAGE plpgsql;
