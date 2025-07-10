DO
$$
DECLARE
    garcom RECORD;
    garcons_json JSONB;
    total INT;
    idx INT;
    v_sqlstate TEXT;
    v_sqlerrm TEXT;
BEGIN
    -- Lista de garçons a serem inseridos
    garcons_json := '[
        {"cpf_garcom": "11122233344", "nome_garcom": "Space Ghost"},
        {"cpf_garcom": "22233344455", "nome_garcom": "Falcão Azul"},
        {"cpf_garcom": "33344455566", "nome_garcom": "Penélope Charmosa"},
        {"cpf_garcom": "44455566677", "nome_garcom": "Pepe Legal"},
        {"cpf_garcom": "55566677788", "nome_garcom": "Jonny Quest"}
    ]'::jsonb;

    total := jsonb_array_length(garcons_json);

    FOR idx IN 0..total - 1 LOOP
        -- Converte o JSON para RECORD com os campos desejados
        SELECT *
        INTO garcom
        FROM jsonb_to_record(garcons_json->idx)
        AS x(cpf_garcom TEXT, nome_garcom TEXT);

        BEGIN
            -- Insere no banco de dados no esquema barzinho
            INSERT INTO barzinho.garcons (cpf_garcom, nome_garcom)
            VALUES (
                garcom.cpf_garcom,
                garcom.nome_garcom
            );

            RAISE NOTICE 'Garçom inserido com sucesso: %', garcom.nome_garcom;

        EXCEPTION WHEN OTHERS THEN
            GET STACKED DIAGNOSTICS
                v_sqlstate = RETURNED_SQLSTATE,
                v_sqlerrm = MESSAGE_TEXT;

            RAISE NOTICE 'Erro ao inserir garçom: % | Código: % | Mensagem: %',
                garcom.nome_garcom, v_sqlstate, v_sqlerrm;
        END;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
