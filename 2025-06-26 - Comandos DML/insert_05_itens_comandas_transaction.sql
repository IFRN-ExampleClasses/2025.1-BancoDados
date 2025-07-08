DO
$$
DECLARE
   item_comanda RECORD;
   itens_comanda_json jsonb;
   idx INT := 0;
	id_comanda INT;
	id_produto INT;
	quantidade INT;
   total INT;
   v_sqlstate TEXT;
   v_sqlerrm TEXT;
BEGIN
	-- Lê o conteúdo do arquivo JSON na máquina onde o Postgres roda
   itens_comanda_json := pg_read_file('C://Users//charl//OneDrive - IFRN//(IFRN) DIATINF//(2025.1) Aulas//TEC.0022 - Banco de Dados (NCT)//2025.1-BancoDados//2025-06-26 - Comandos DML//dados_itens_comandas.json')::jsonb;

   total := jsonb_array_length(itens_comanda_json);

   FOR idx IN 0..total - 1 LOOP
		item_comanda := jsonb_populate_record(NULL::RECORD, itens_comanda_json->idx);

      BEGIN
			INSERT INTO barzinho.iten_comandas (id_comanda, id_produto, quantidade)
					VALUES (
							item_comanda->>'id_comanda',
							item_comanda->>'id_produto',
							item_comanda->>'quantidade'
					);

			RAISE NOTICE 'Item da Comanda inserido com sucesso: %', itens_comanda_json->idx;

		EXCEPTION WHEN OTHERS THEN
			GET STACKED DIAGNOSTICS
				v_sqlstate = RETURNED_SQLSTATE,
				v_sqlerrm = MESSAGE_TEXT;

			RAISE NOTICE 'Erro ao inserir item da comanda: % | Código: % | Mensagem: %',
				itens_comanda_json->idx, v_sqlstate, v_sqlerrm;
		END;
	END LOOP;
END;
$$ LANGUAGE plpgsql;
