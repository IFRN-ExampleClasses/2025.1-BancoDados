/*
	FAZER UMA CONSULTA QUE RETORNE O NÚMERO DA MESA, O NOME DO GARÇOM QUE ATENDEU A MESA,
	A DATA DE ABERTURA DA COMANDA DA MESA, A DATA DE FECHAMENTO DA COMANDA DA MESA E O 
	TEMPO DE PERMANÊNCIA. ORDENE PELO NÚMERO DA MESA
*/

  SELECT comandas.numero_mesa,
		 (SELECT garcons.nome_garcom FROM barzinho.garcons WHERE comandas.cpf_garcom = garcons.cpf_garcom),
		 comandas.data_abertura,
		 comandas.data_fechamento,
		 (comandas.data_fechamento - comandas.data_abertura) AS "permanencia"
    FROM barzinho.comandas
ORDER BY comandas.numero_mesa;