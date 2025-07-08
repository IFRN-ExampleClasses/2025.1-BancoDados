DO
$$
DECLARE
    produto RECORD;
    produtos_json jsonb;
    idx INT;
    total INT;
    v_sqlstate TEXT;
    v_sqlerrm TEXT;
BEGIN
   -- Lê o conteúdo do arquivo JSON na máquina onde o Postgres roda
   produtos_json := pg_read_file('C:/Users/charl/OneDrive - IFRN/(IFRN) DIATINF/(2025.1) Aulas/TEC.0022 - Banco de Dados (NCT)/2025.1-BancoDados/2025-06-26 - Comandos DML/dados_produtos.json')::jsonb;

   total := jsonb_array_length(produtos_json);

   FOR idx IN 0..total - 1 LOOP
		produto := jsonb_populate_record(NULL::RECORD, produtos_json->idx);

		BEGIN
			INSERT INTO barzinho.produtos (nome_produto, preco_unitario, id_categoria)
				VALUES (
					produto->>'nome',
					(produto->>'preco')::NUMERIC,
					(produto->>'categoria')::INTEGER
				);
				
			RAISE NOTICE 'Produto inserido com sucesso: %', produto->>'nome';

		EXCEPTION WHEN OTHERS THEN
			GET STACKED DIAGNOSTICS
				v_sqlstate = RETURNED_SQLSTATE,
					v_sqlerrm = MESSAGE_TEXT;

			RAISE NOTICE 'Erro ao inserir produto: % | Código: % | Mensagem: %',
				produto->>'nome', v_sqlstate, v_sqlerrm;
		END;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
