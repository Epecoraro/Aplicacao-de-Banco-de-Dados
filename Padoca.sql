-- Aula 08 08/10/25
 -- PRÁTICA
 -- Você foi contratado para criar um banco de dados para uma padaria que 
 -- precisa organizar e manipular informações sobre seus produtos, fornecedores e vendas. 

 -- PADARIA
 create table Padoca_Cliente (
	ID_Cliente int auto_increment primary key,
	Nome varchar(50) not null,
	Telefone varchar(20) not null,
	email varchar(80),
    cpf varchar(11) unique not null
);

create table Padoca_Produto (
	ID_Produto int auto_increment primary key,
	Nome_Produto varchar(20) not null,
	Descricao varchar(50) not null,
    Preco decimal(8,2) not null
);
    
create table Padoca_Fornecedor (
	ID_Fornecedor int auto_increment primary key,
	Nome_Fornecedor varchar(50) not null,
	Telefone varchar(20) not null,
	email varchar(80),
    ID_Produto int not null, 
    foreign key (ID_Produto) References Padoca_Produto(ID_Produto)
);

create table Padoca_Venda (
	ID_Venda int auto_increment primary key,
	Quantidade int not null,
    Preco decimal(8,2) not null,
	Observacao varchar(80) not null,
	Data_Venda date not null,
    ID_Cliente int not null,
	ID_Produto int not null,
    foreign key (ID_Cliente) References Padoca_Cliente(ID_Cliente),
    foreign key (ID_Produto) References Padoca_Produto(ID_Produto)
 );

  
  insert into Padoca_Cliente (Nome, Telefone, email, cpf)
	values
    ('Antonio Paulo','1188774455', 'antpaulo@email.com', '19854897650'),
    ('João Pedro', '1588996658', 'joaop@emai.com', '19854897651'),
    ('Maria Paula', '31225544789', 'marpaula@email.com', '19854897652'),
    ('Elisabete Fernanda', '3325447891', 'elifera@email.com', '19854897653');
    
insert into Padoca_Fornecedor (Nome_Fornecedor, Telefone, email, ID_Produto)
	values
    ('Visconti','1188774455', 'visconti@email.com', 1),
    ('Pé de Bolo', '1588996658', 'pdbolo@emai.com', 2);
    
    
insert into Padoca_Produto (Nome_Produto, Descricao, Preco)
	values
    ('Bolo de Fubá', 'Recheio de goiabada', 70),
    ('Bolo chocolate', 'Recheio de Brigadeiro', 100);

insert into Padoca_Venda (Quantidade, Preco, Observacao, Data_Venda, ID_Cliente, ID_Produto)
	values
    (1, 70,'Bolo de Fubá com recheio de goiabada', curdate(),3,1),
    (1, 100, 'Bolo chocolate com recheio de Brigadeiro', curdate(),4,2);


 select * from Padoca_Produto;
 select * from Padoca_Cliente;
 select * from Padoca_Fornecedor;
 select * from Padoca_Venda;
 
 -- 2) Listar nome e preço de todos os produtos cadastrados
  select 
 Nome_Produto,
 Preco
 from Padoca_Produto;
 
  -- 3) Listar nome e preço de todos os produtos cadastrados
  select 
 Nome_Fornecedor,
 Telefone,
 ID_Fornecedor
  from Padoca_Fornecedor;
  
  -- 4) Listar as vendas exibindo os nomes dos produtos e quantidade
 select
	p.Nome_produto,
    c.Quantidade
from
    Padoca_Venda as c
join
    Padoca_Produto as p on c.ID_Produto = p.ID_Produto;


 -- 5) Listar as vendas exibindo os nomes dos produtos, os nomes dos fornecedores e ID_Venda
 -- A solução adotada é válida pq eu não incluí ID_Fornecedor na venda, e tenho que inferir o fornecedor a partir do produto, ou seja, só funciona se 1 produto = 1 fornecedor:
 select
	p.Nome_produto,
    v.ID_Venda,
    f.Nome_Fornecedor
from
    Padoca_Venda as v
join
    Padoca_Produto as p on v.ID_Produto = p.ID_Produto
join
    Padoca_Fornecedor f on p.ID_Produto = f.ID_Produto;
    
 -- 6)Listar todas as vendas do Bolo de Fubá e o respectivo nome do fornecedor
 select 
	v.ID_Venda,
    p.Nome_Produto,
    f.Nome_Fornecedor
from 
	Padoca_Venda as v
join
    Padoca_Produto as p on v.ID_Produto = p.ID_Produto
join
	Padoca_Fornecedor f on p.ID_Produto = f.ID_Produto
WHERE
	p.Nome_Produto = 'Bolo de Fubá';
    
     
 -- 7)Listar todas as vendas do Bolo de Chocolate
 select
	v.ID_Venda,
    p.Nome_Produto,
    v.Quantidade,
    v.Data_Venda
from
	Padoca_Venda as v
join
	Padoca_Produto as p on v.ID_Produto = p.ID_Produto
WHERE
	p.Nome_Produto = 'Bolo chocolate';
    
     
 -- 8)Listar os produtos vendidos em 2025-01-03
 select
	v.ID_Venda,
    p.Nome_Produto,
    v.Quantidade,
    v.Data_Venda
from
	Padoca_Venda as v
join
	Padoca_Produto as p on v.ID_Produto = p.ID_Produto
WHERE
	v.Data_Venda = '2025-10-08';
   
 
  -- 9)Listar nome do produto, nome do fornecedor, telefone do fornecedor da venda nº 3
  select
	v.ID_Venda,
    p.Nome_Produto,
    f.Nome_Fornecedor,
    f.Telefone
from
	Padoca_Venda as v
join
	Padoca_Produto as p on v.ID_Produto = p.ID_Produto
join
	Padoca_Fornecedor as f on p.ID_Produto = f.ID_Produto
WHERE
	v.ID_Venda = 3;
    

    
  
  