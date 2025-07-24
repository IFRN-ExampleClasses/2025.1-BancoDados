DO
$$
DECLARE
    comanda RECORD;
    comandas_json JSONB;
    idx INT;
    total INT;
    v_sqlstate TEXT;
    v_sqlerrm TEXT;
BEGIN
    -- Lista de comandas a serem inseridas
    comandas_json := '[
        {"data_abertura": "2025-07-01 18:15:00", "data_fechamento": "2025-07-01 20:45:00", "numero_mesa": 5, "cpf_garcom": "11122233344"},
        {"data_abertura": "2025-07-01 19:00:00", "data_fechamento": "2025-07-01 21:30:00", "numero_mesa": 3, "cpf_garcom": "22233344455"},
        {"data_abertura": "2025-07-02 17:50:00", "data_fechamento": "2025-07-02 19:20:00", "numero_mesa": 8, "cpf_garcom": "33344455566"},
        {"data_abertura": "2025-07-02 20:10:00", "data_fechamento": "2025-07-03 00:15:00", "numero_mesa": 12, "cpf_garcom": "44455566677"},
        {"data_abertura": "2025-07-03 18:40:00", "data_fechamento": "2025-07-03 19:45:00", "numero_mesa": 2, "cpf_garcom": "55566677788"},
        {"data_abertura": "2025-07-03 21:00:00", "data_fechamento": "2025-07-04 00:05:00", "numero_mesa": 10, "cpf_garcom": "11122233344"},
        {"data_abertura": "2025-07-04 17:30:00", "data_fechamento": "2025-07-04 19:00:00", "numero_mesa": 7, "cpf_garcom": "22233344455"},
        {"data_abertura": "2025-05-04 20:45:00", "data_fechamento": "2025-05-05 01:15:00", "numero_mesa": 14, "cpf_garcom": "33344455566"},
        {"data_abertura": "2025-05-05 18:10:00", "data_fechamento": "2025-05-05 19:00:00", "numero_mesa": 1, "cpf_garcom": "44455566677"},
        {"data_abertura": "2025-05-05 20:00:00", "data_fechamento": "2025-05-06 00:20:00", "numero_mesa": 4, "cpf_garcom": "55566677788"},
        {"data_abertura": "2025-07-06 18:25:00", "data_fechamento": "2025-07-06 19:40:00", "numero_mesa": 15, "cpf_garcom": "11122233344"},
        {"data_abertura": "2025-05-06 20:30:00", "data_fechamento": "2025-05-07 00:10:00", "numero_mesa": 6, "cpf_garcom": "22233344455"}
    ]'::jsonb;

    total := jsonb_array_length(comandas_json);

    FOR idx IN 0..total - 1 LOOP
        SELECT *
        INTO comanda
        FROM jsonb_to_record(comandas_json->idx)
        AS x(data_abertura TIMESTAMP, data_fechamento TIMESTAMP, numero_mesa INT, cpf_garcom TEXT);

        BEGIN
            INSERT INTO barzinho.comandas (
                data_abertura,
                data_fechamento,
                numero_mesa,
                cpf_garcom
            ) VALUES (
                comanda.data_abertura,
                comanda.data_fechamento,
                comanda.numero_mesa,
                comanda.cpf_garcom
            );

            RAISE NOTICE 'Comanda inserida com sucesso: mesa %', comanda.numero_mesa;

        EXCEPTION WHEN OTHERS THEN
            GET STACKED DIAGNOSTICS
                v_sqlstate = RETURNED_SQLSTATE,
                v_sqlerrm = MESSAGE_TEXT;

            RAISE NOTICE 'Erro ao inserir comanda da mesa % | Código: % | Mensagem: %',
                comanda.numero_mesa, v_sqlstate, v_sqlerrm;
        END;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
