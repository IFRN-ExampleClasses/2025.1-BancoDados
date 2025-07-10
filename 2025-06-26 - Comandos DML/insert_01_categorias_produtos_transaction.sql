DO
$$
DECLARE
    -- Variáveis
    categorias_produtos RECORD;
    categoria_json JSONB;
    categorias_produtos_json JSONB := '[ 
        {"descricao": "Bebidas Alcoólicas"},
        {"descricao": "Bebidas Não Alcoólicas"},
        {"descricao": "Porções"},
        {"descricao": "Petiscos"},
        {"descricao": "Sanduíches"},
        {"descricao": "Sobremesas"},
        {"descricao": "Cervejas Artesanais"},
        {"descricao": "Drinks Especiais"},
        {"descricao": "Comidas Típicas"},
        {"descricao": "Tabacaria"}
    ]'::jsonb;

    total INT;
    idx INT;
    v_sqlstate TEXT;
    v_sqlerrm TEXT;

BEGIN
    -- Calcula o total de itens no JSON
    total := jsonb_array_length(categorias_produtos_json);

    -- Loop para inserir cada categoria
    FOR idx IN 0..total - 1 LOOP
        -- Pega o item atual do array JSON
        categoria_json := categorias_produtos_json->idx;

        -- Converte JSON para RECORD com campo 'descricao'
        SELECT * INTO categorias_produtos
        FROM jsonb_to_record(categoria_json)
        AS x(descricao VARCHAR(100));

        BEGIN
            -- Insere no banco de dados
            INSERT INTO barzinho.categorias_produtos (descricao)
            VALUES (categorias_produtos.descricao);

            RAISE NOTICE 'Categoria de Produto inserida com sucesso: %', categorias_produtos.descricao;

        EXCEPTION WHEN OTHERS THEN
            -- Captura e exibe detalhes do erro
            GET STACKED DIAGNOSTICS
                v_sqlstate = RETURNED_SQLSTATE,
                v_sqlerrm = MESSAGE_TEXT;

            RAISE NOTICE 'Erro ao inserir Categoria de Produto: % | Código: % | Mensagem: %',
                categorias_produtos.descricao, v_sqlstate, v_sqlerrm;
        END;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
