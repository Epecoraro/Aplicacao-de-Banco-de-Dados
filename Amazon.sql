 -- Aula 09 09/10/25

use DB_03360A_EdisonPec;


create table Amazon_Cliente(
	ID int auto_increment primary key,
    nome varchar(50) not null,
    telefone varchar(20),
    email varchar(80),
    data_nasc date
);

show tables;

drop table Amazon_Cliente;

-- Demonstração do comando alter table (inserir coluna)
alter table Amazon_Cliente add column ativo boolean default true;

-- Comando para exibir tabela única
describe Amazon_Cliente;

-- Alterar a informação de uma coluna (conteúdo e nome)
alter table Amazon_Cliente modify column nome varchar(60);
alter table Amazon_Cliente change column telefone celular varchar(20);

