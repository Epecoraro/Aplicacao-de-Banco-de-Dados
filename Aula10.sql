
 
-- 1 CRIAR UMA TABELA COM O NOME ERRADO PARA SIMULAR UM ERRO
-- Objetivo: praticar DROP criando algo errado de propósito
-- Dica: use um nome errado (ex: COMIDAZ_FAVORITAS) e veja como corrigir depois
 
create table COMIDAZ_FAVORITAS
(
	ID_Comida int auto_increment primary key,
    Nome_Comida varchar(50)
);


-- 2 APAGAR A TABELA COM NOME ERRADO USANDO DROP
-- Objetivo: remover a tabela incorreta
-- Dica: DROP apaga tudo (estrutura e dados), cuidado ao usar
 
 drop table COMIDAZ_FAVORITAS;
 
 
-- 3 CRIAR NOVAMENTE A TABELA COM O NOME CORRETO
-- Objetivo: recriar a tabela com o nome certo e colunas básicas
-- Dica: defina tipos e tamanhos de dados corretos desde o início

create table COMIDAS_FAVORITAS
(
	ID_Comida int auto_increment primary key,
    Nome_Comida varchar(50),
    Origem varchar(50)
);
 
-- 4 ADICIONAR UMA NOVA COLUNA QUE ESQUECEMOS USANDO ALTER TABLE
-- Objetivo: adicionar a coluna NOTA INT
-- Dica: use ALTER TABLE nome_tabela ADD nome_coluna tipo
 
 alter table COMIDAS_FAVORITAS add column Nota int;
 
 
-- 5 INSERIR CINCO REGISTROS NA TABELA
-- Objetivo: praticar INSERT com múltiplas linhas
-- Dica: use INSERT INTO ... VALUES (...), (...);
 
 insert into COMIDAS_FAVORITAS (Nome_Comida, Origem, Nota)
	Values
		('Macarrao', 'Itália', 10),
        ('Peixe assado', 'América do Sul', 10),
        ('Abacaxi', 'América do Sul', 10),
        ('Bolacha', 'São Paulo', 10),
        ('Biscoito', 'Rio de Janeiro', 10);
	
 
-- 6 VERIFICAR SE OS DADOS FORAM INSERIDOS
-- Objetivo: confirmar com SELECT se os dados estão corretos
-- Dica: use SELECT * FROM nome_tabela;
 
 select * from COMIDAS_FAVORITAS;
 
-- 7 LIMPAR TODA A TABELA USANDO TRUNCATE
-- Objetivo: apagar todos os registros rapidamente
-- Dica: TRUNCATE é mais rápido que DELETE e reinicia o AUTO_INCREMENT
 
 truncate table COMIDAS_FAVORITAS;
 

-- 8 CONFERIR QUE A TABELA ESTÁ VAZIA MAS A ESTRUTURA PERMANECE
-- Objetivo: testar SELECT e confirmar que a estrutura ainda existe
-- Dica: use SELECT COUNT(*) e SHOW CREATE TABLE

 select * from COMIDAS_FAVORITAS;
 select count(*) COMIDAS_FAVORITAS;
 show create table COMIDAS_FAVORITAS;
 
  
-- 9 LIMPAR TODA A TABELA USANDO DELETE (não reinicia o contador - AUTO_INCREMENT)
-- Objetivo: apagar todos os registros rapidamente
-- Dica: TRUNCATE é mais rápido que DELETE e reinicia o AUTO_INCREMENT

delete from COMIDAS_FAVORITAS;

-- 10 DELETAR A COLUNA NOTA
-- Dica: ALTER TABLE NOME DA TABLE COLUMN COLUNA;

ALTER TABLE COMIDAS_FAVORITAS DROP COLUMN NOTA;
 
 