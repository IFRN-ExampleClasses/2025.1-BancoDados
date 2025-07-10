DO
$$
DECLARE
    garcom RECORD;
    garcons_json jsonb;
    cpf_garcon TEXT;
    nome_garcom TEXT;
    v_sqlstate TEXT;
    v_sqlerrm TEXT;
BEGIN
	-- Lê o conteúdo do arquivo JSON na máquina onde o Postgres roda
   garcons_json := pg_read_file('C://Users//charl//OneDrive - IFRN//(IFRN) DIATINF//(2025.1) Aulas//TEC.0022 - Banco de Dados (NCT)//2025.1-BancoDados//2025-06-26 - Comandos DML//dados_garcons.json')::jsonb;

   total := jsonb_array_length(garcons_json);

   FOR idx IN 0..total - 1 LOOP
		garcom := jsonb_populate_record(NULL::RECORD, garcons_json->cpf_garcon);

		BEGIN
			INSERT INTO barzinho.garcons (cpf_garcom, nome_garcom)
				VALUES (
					garcom->>'cpf_garcom',
               garcom->>'nome_garcom'
				);

			RAISE NOTICE 'Garçom inserido com sucesso: %', garcom->>'nome_garcom';

		EXCEPTION WHEN OTHERS THEN
			GET STACKED DIAGNOSTICS
				v_sqlstate = RETURNED_SQLSTATE,
            v_sqlerrm = MESSAGE_TEXT;

			RAISE NOTICE 'Erro ao inserir gargom: % | Código: % | Mensagem: %',
				garcom->>'nome_garcom', v_sqlstate, v_sqlerrm;
		END;
	END LOOP;
END;
$$ LANGUAGE plpgsql;
