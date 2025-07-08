DO
$$
DECLARE
	categoria_produto RECORD;
    categorias_produtos_json JSONB;
    total INT;
    idx INT;
    descricao_categoria TEXT;
    v_sqlstate TEXT;
    v_sqlerrm TEXT;
BEGIN
   -- Lê o conteúdo do arquivo JSON na máquina onde o Postgres roda
   categorias_produtos_json := pg_read_file('C:/Users/charl/OneDrive - IFRN/(IFRN) DIATINF/(2025.1) Aulas/TEC.0022 - Banco de Dados (NCT)/2025.1-BancoDados/2025-06-26 - Comandos DML/dados_categorias_produtos.json')::jsonb;

   -- Calcula o total de itens no arquivo JSON
   total := jsonb_array_length(categorias_produtos_json);

   -- Loop para inserir as categorias
   FOR idx IN 0..total - 1 LOOP
      -- Converte cada item JSON para um registro
      categoria_produto := jsonb_populate_record(NULL::RECORD, categorias_produtos_json->idx);

      BEGIN
         -- Insere o valor no banco de dados
         INSERT INTO barzinho.produtos (descricao_categoria)
         VALUES (categoria_produto->>'descricao_categoria');

         RAISE NOTICE 'Categoria de Produto inserido com sucesso: %', categoria_produto->>'descricao_categoria';

      EXCEPTION WHEN OTHERS THEN
         -- Captura e exibe o erro
         GET STACKED DIAGNOSTICS
            v_sqlstate = RETURNED_SQLSTATE,
            v_sqlerrm = MESSAGE_TEXT;

         RAISE NOTICE 'Erro ao inserir Categoria de Produto: % | Código: % | Mensagem: %',
            categoria_produto->>'descricao_categoria', v_sqlstate, v_sqlerrm;
      END;
   END LOOP;
END;
$$ LANGUAGE plpgsql;
