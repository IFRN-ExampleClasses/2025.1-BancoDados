-- Criando o esquema BARZINHO
create schema barzinho;

-- Criando a tabela CATEGORIAS_PRODUTOS
create table barzinho.categorias_produtos (
	id_categoria 	serial,
	descricao		varchar(40) not null,
	
	constraint pk_categorias_produtos primary key (id_categoria)
);

-- Criando a tabela GARCONS
create table barzinho.garcons(
	cpf_garcom		varchar(11),
	nome_garcom		varchar(50) not null,
	
	constraint pk_garcons primary key (cpf_garcom)
);

-- Criando a tabela PRODUTOS
create table barzinho.produtos(
	id_produto		serial,
	nome_produto	varchar(80),
	preco_unitario	money,
	id_categoria	integer,
	
	constraint pk_produtos primary key (id_produto),
	constraint fk_produtos_categorias_produtos foreign key (id_categoria)
		references barzinho.categorias_produtos (id_categoria)
);

-- Criando a tabela COMANDAS
create table barzinho.comandas(
	id_comanda		serial,
	data_abertura	date,
	data_fechamento	date,
	preco_unitario	money,
	numero_mesa		integer,
	cpf_garcom		varchar(11),
	
	constraint pk_comandas primary key (id_comanda),
	constraint fk_comandas_garcons foreign key (cpf_garcom)
		references barzinho.garcons (cpf_garcom)
);

-- Criando a tabela ITENS_COMANDAS
create table barzinho.itens_comandas(
	id_item_comanda		serial,
	id_comanda			integer,
	id_produto			integer,
	quantidade			integer,
	preco_unitario		money,
	
	constraint pk_itens_comandas primary key (id_item_comanda),
	constraint fk_items_comandas_produtos foreign key (id_produto)
		references barzinho.produtos (id_produto),
	constraint fk_items_comandas_comandas foreign key (id_comanda)
		references barzinho.comandas (id_comanda)
);


/*
-- Alterar tipo de MONEY para NUMERIC na tabela PRODUTOS
-- Caso haja valores no campo PRECO_UNITARIO (MANEIRA HARDCORE)

-- Adicionando um novo campo com o tipo desejado
ALTER TABLE barzinho.produtos ADD COLUMN novo_preco_unitario NUMERIC;

-- Atualizando o novo campo com os dados do campo antigo
UPDATE barzinho.produtos SET novo_preco_unitario = preco_unitario::numeric;

-- Apagar o campo antigo
ALTER TABLE barzinho.produtos DROP COLUMN preco_unitario;

-- Renomear o novo campo com o nome do campo antigo
ALTER TABLE barzinho.produtos RENAME COLUMN novo_preco_unitario TO preco_unitario;
*/

-- Alterar tipo de MONEY para NUMERIC na tabela PRODUTOS
-- Caso haja valores no campo PRECO_UNITARIO (MANEIRA EASY)
alter table barzinho.produtos
	alter column preco_unitario set data type numeric
	using preco_unitario::numeric;


-- Adicionando uma nova restrição (CONSTRAINT)
-- na tabela PRODUTOS
alter table barzinho.produtos
	add constraint chk_produtos_preco_unitario check (preco_unitario >= 0);


-- Alterar tipo de MONEY para NUMERIC na tabela ITENS_COMANDAS
-- Caso haja valores no campo PRECO_UNITARIO (MANEIRA EASY)
alter table barzinho.itens_comandas
	alter column preco_unitario set data type numeric
	using preco_unitario::numeric;


-- Adicionando uma nova restrição (CONSTRAINT)
-- na tabela ITENS_COMANDAS
alter table barzinho.itens_comandas
	add constraint chk_itens_comandas_preco_unitario check (preco_unitario >= 0);

-- Excluindo o campo PRECO_UNITARIO da tabela COMANDAS
alter table barzinho.comandas
	drop column preco_unitario;
	
	