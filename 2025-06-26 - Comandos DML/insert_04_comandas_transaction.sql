-- OBSERVAÇÃO: Será necessário alterar o tipo dos campos "data_abertura" e
-- "data_fechamento" para TIMESTAMP na tabela "comandas" antes de executar
-- esse script

DO
$$
DECLARE
   comanda RECORD;
   comandas_json jsonb;
   idx INT := 0;
	data_abertura TIMESTAMP;
	data_fechamento TIMESTAMP;
	numero_mesa INT;
	cpf_garcom TEXT;
   total INT;
   v_sqlstate TEXT;
   v_sqlerrm TEXT;
BEGIN
	-- Lê o conteúdo do arquivo JSON na máquina onde o Postgres roda
   comandas_json := pg_read_file('C:/Users/charl/OneDrive - IFRN/(IFRN) DIATINF/(2025.1) Aulas/TEC.0022 - Banco de Dados (NCT)/2025.1-BancoDados/2025-06-26 - Comandos DML/dados_comandas.json')::jsonb;

   total := jsonb_array_length(comandas_json);

   FOR idx IN 0..total - 1 LOOP
		comanda := jsonb_populate_record(NULL::RECORD, comandas_json->idx);

      BEGIN
			INSERT INTO barzinho.comandas (data_abertura, data_fechamento, v, cpf_garcom)
					VALUES (
							(comanda->>'data_abertura')::TIMESTAMP,
							(comanda->>'data_fechamento')::TIMESTAMP,
							(comanda->>'numero_mesa')::NUMERIC,
							(comanda->>'cpf_garcom')
					);

			RAISE NOTICE 'Comanda inserido com sucesso: %', comanda->>'idx';

		EXCEPTION WHEN OTHERS THEN
			GET STACKED DIAGNOSTICS
				v_sqlstate = RETURNED_SQLSTATE,
				v_sqlerrm = MESSAGE_TEXT;

			RAISE NOTICE 'Erro ao inserir comanda: % | Código: % | Mensagem: %',
				comanda->>'idx', v_sqlstate, v_sqlerrm;
		END;
	END LOOP;
END;
$$ LANGUAGE plpgsql;
