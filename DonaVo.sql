-- Aula 06 05/10/25
create database DB_03360A_EdisonPec; -- Criar o BD indicado

use DB_03360A_EdisonPec; -- Entra no BD criado

-- Criar as tabelas dentro do BD
create table DonaVo_Cliente (
	ID_Cliente int auto_increment primary key,
	Nome varchar(50) not null,
	Telefone varchar(20) not null,
	email varchar(80),
);

create table DonaVo_Pedido (
	ID_Pedido int auto_increment primary key,
	Quantidade int not null,
	Descricao varchar(150) not null,
	Observacao varchar(80) not null,
	Data_Pedido date not null,
	ID_Cliente int not null,
	foreign key (ID_Cliente) References DonaVo_Cliente(ID_Cliente)
 );

alter table DonaVo_Pedido change column Data_Pecido Data_Pedido date; -- Foi corrigido um erro de digitação no nome da coluna.

-- Aula 06 06/10/25
-- COMANDOS (PARA TESTES DE MESA DO QUE FOI DESENVOLVIDO NO FRONT-END)
-- QUERIES
show databases; -- Mostra todas as tabelas de todos os Schemas

show tables; -- Mostra as tabelas do meu Schema

describe DonaVo_Cliente; -- Mostra a estrutura da referida tabela

describe DonaVo_Pedido;-- No caso dessa tabela, a coluna Key mostra a 
-- informação MUL, que significa que é uma chave múltipla (nesse caso uma FK)

-- INSERT INDIVIDUAL
insert into DonaVo_Cliente(Nome, Telefone, email)
	values
    ('Maria Silva', '16587854852', 'marias@email.com');
insert into DonaVo_Cliente(Nome, Telefone)
	values
    ('João Paulo', '1155887745');

-- INSERT EM BLOCO
insert into DonaVo_Cliente (Nome, Telefone, email)
	values
    ('Paulo João','1188774455', 'pauloj@email.com'),
    ('João Pedro', '1588996658', 'joaop@emai.com'),
    ('Pedro Henrique', '31225544789', 'pedroh@email.com'),
    ('Henrique Jose', '3325447891', 'henriquej@email.com');
    
insert into DonaVo_Pedido (Quantidade, Descricao, Observacao, Data_Pedido, ID_Cliente)
	values
    (1,'Bolo de Cenoura Cobertura Chocolate', 'Sem Açúcar',curdate(),1),
    (2,'Bolo Red Velvet', 'Recheio de Frutas Vermelhas',curdate(),1),
    (1,'Bolo de Coco','Cobertura de Chocolate',curdate(),2),
    (1,'Bolo Brigadeiro','Recheio de Morango',curdate(),2),
    (1,'Bolo Chocolate com Cobertura de Coco','Com Cereja',curdate(),3),
    (2,'Bolo de Leite Ninho','Recheio Abacaxi',curdate(),3),
    (1,'Bolo Floresta Negra','Confeitado',curdate(),5);
    
    
-- SELECT (VERIFICAÇÃO DOS DADOS DAS TABELAS e Relatórios)
select * from DonaVo_Cliente;

select * from DonaVo_Pedido;

select * from DonaVo_Cliente
	order by Nome
	asc
	limit 3;

select * from DonaVo_Pedido
	order by Data_Pedido
	asc
    limit 3;

-- JOIN (Criando relatórios com informações de mais de uma tabela - para fazer join tem que ter uma tabela com PK e outra com FK...comece as tabelas com com FK; a ordem dos select influencia na ordem do relatório)
select
	p.ID_Pedido, -- (p e c são apelidos ou aliases)
    p.Quantidade,
    p.Descricao,
    p.Observacao,
    p.Data_Pedido,
    c.Nome
    from
    DonaVo_Pedido as p
    join
    DonaVo_Cliente as c on p.ID_Cliente = c.ID_Cliente;

-- JOIN + WHERE + LIKE
select
	p.ID_Pedido,
    p.Quantidade,
    p.Descricao,
    p.Observacao,
    p.Data_Pedido,
    c.Nome
    from DonaVo_Pedido as p
    join DonaVo_Cliente as c on p.ID_Cliente = c.ID_Cliente
    where c.Nome like 'João%'; -- O % seleciona todos os registros que tenha o termo João
    
-- Aula 07 07/10/25
use DB_03360A_EdisonPec;

-- Mostrando os pedidos do cliente com ID = 3
select
	p.ID_Pedido,
    p.Quantidade,
    p.Descricao,
    p.Observacao,
    p.Data_Pedido,
    c.Nome
    from DonaVo_Pedido as p
    join DonaVo_Cliente as c on p.ID_Cliente = c.ID_Cliente
    where c.ID_Cliente = 3;

-- Mostrando os pedidos com palavras chave na descrição ou observação

select
	c.Nome,
    p.ID_Pedido,
    p.Descricao,
    p.Observacao,
    c.email
    from DonaVo_Pedido as p
    join DonaVo_Cliente as c on p.ID_Cliente = c.ID_Cliente
    where p.Descricao like '%Chocolate%';


select
	c.Nome,
    c.Telefone,
    p.Descricao,
    p.Data_Pedido
    from DonaVo_Pedido as p
    join DonaVo_Cliente as c on p.ID_Cliente = c.ID_Cliente
    where p.Observacao like '%confeitado%';
    
 -- Fazendo atualizações nas tabelas   
 
 select * from DonaVo_Cliente;
 
 select * from DonaVo_Cliente where email is null;
 
 update
	DonaVo_Cliente
    set email = 'joaops@email.com'
    where ID_Cliente = 2; -- Se não especificar o cliente, ele altera todos os emails da tabela para esse declarado.
    

select * from DonaVo_Pedido;

update
	DonaVo_Pedido
    set Observacao = 'Com Morango'
    where Observacao = 'Com Cereja';

-- Mostrando qual cliente tem cadastro, mas não fez nenhum pedido
select c.*,
	p.ID_Cliente
    from DonaVo_Cliente as c
    left join DonaVo_Pedido as p on c.ID_Cliente = p.ID_Cliente
    where p.ID_Cliente is null;
    
-- Excluindo esse cliente (exclusão em cascata se houvesse outras tabelas com registros)
delete from DonaVo_Cliente
where ID_Cliente = 6;


-- COMANDOS RELACIONADOS A ESTRUTURA DA TABELA
describe DonaVo_Pedido;

-- Adicionando uma nova coluna (alterando a estrutura da tabela)
alter table DonaVo_Pedido add Preco decimal(8,2);

select * from DonaVo_Pedido;

-- Limpando totalmente os dados da tabela (sem cláusula WHERE), sem apagar a tabela
create table DonaVo_Produto (
	ID_Produto int,
    Nome varchar(50)
);

insert into DonaVo_Produto (ID_Produto, Nome)
values
	(10,'Pafaruso'),
    (20,'Arruela'),
	(30,'Prego'),
	(40,'Martelo');
  
  select * from DonaVo_Produto;
  
  truncate table DonaVo_Produto; 
  
  -- Apagando a tabela

insert into DonaVo_Produto (ID_Produto, Nome)
values
	(10,'Pafaruso'),
    (20,'Arruela'),
	(30,'Prego'),
	(40,'Martelo');
  
 drop table DonaVo_Produto;

  -- DEFININDO (CRIANDO) USUÁRIOS QUE TERÃO ACESSO DO BANCO DE DADOS E ESTABELECENDO HIERARQUIA DE ACESSO E DE TRANSAÇÕES
  
  -- Criando o usuário
  create user 'Edison' @'%' identified by 'Power!1@2#3$4pwd'; -- O % indica que o usuario não será identificado pelo IP, mas por senha

  select user, host from mysql.user where user = 'Edison';
  
  -- Atribuindo previlégios (datá erro pq não temos previlégio para dar permissões para qualquer usuário. Só o DBA - administrador pode fazer isso)
    grant select on DB_03360A_EdisonPec to 'Edison' @'%';
    
    flush privileges; -- Confirma e ativa imediatamente todos os previlégios atribuídos (sem necessidade de reinicializar o servidor). Não precisa usar para criar e remover usuários.
    
    -- Remover usuário
    drop user 'Edison' @'%';
    
    
    
