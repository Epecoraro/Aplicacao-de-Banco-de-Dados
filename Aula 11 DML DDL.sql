-- AULA 11 - DDL, DML E TCL

CREATE TABLE Escola_Alunos (
	AlunoID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Sobrenome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    DataNascimento DATE,
    Ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE Escola_Cursos (
	CursoID INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(200) NOT NULL,
    Descrição TEXT, -- TEXT Não tem um limite máximo de tamanho definido pelo usuário, permitindo o armazenamento de grandes volumes de texto. 
    CargaHoraria INT,
    Preco DECIMAL(10,2)
);

ALTER TABLE Escola_Cursos CHANGE COLUMN `Descrição` `Descricao` TEXT;
SHOW TABLES;
DESCRIBE Escola_Alunos;
DESCRIBE Escola_Cursos;

-- INSERINDO DADOS NA TABELA DE ALUNOS
INSERT INTO Escola_Alunos (Nome, Sobrenome, email, DataNascimento)
	VALUES ('Ana', 'Costa', 'ana.costa@email.com', '2000-01-10');

INSERT INTO Escola_Alunos (Nome, Sobrenome, email, DataNascimento, Ativo)
	VALUES ('Pedro', 'Lima', 'pedro.lima@email.com', '1998-03-22', FALSE); -- Pedro será inativo

INSERT INTO Escola_Alunos (Nome, Sobrenome, email) -- Data de nascimento será nula
	VALUES ('Mariana', 'Souza', 'mariana.s@email.com');

INSERT INTO Escola_Alunos (Nome, Sobrenome, email, DataNascimento)
	VALUES ('Carlos', 'Gomes', 'carlos.g@email.com', '2001-11-05');

SELECT * FROM Escola_Alunos;


-- INSERINDO DADOS NA TABELA DE CURSOS
INSERT INTO Escola_Cursos (Titulo, Descricao, CargaHoraria, Preco)
	VALUES ('Introdução ao SQL', 'Curso básico de SQL para iniciantes', 40, 299.90);

INSERT INTO Escola_Cursos (Titulo, Descricao, CargaHoraria, Preco)
	VALUES ('Desenvolvimento Web com Python', 'Aprenda a criar aplicações web com Python e Django', 80, 599.90); 

INSERT INTO Escola_Cursos (Titulo, Descricao, CargaHoraria, Preco)
	VALUES ('Banco de Dados Avançado', 'Tópicos avançados em otimização e modelagem', 60, 450);
    
SELECT * FROM Escola_Cursos;

-- AULA 12 (CONTINUAÇÃO DA AULA 11)

-- CORRIGINDO UM EMAIL COM UPDATE (e COMMIT implícito/explícito)
UPDATE Escola_Alunos SET email = 'pedro.novo.email@email.com' WHERE AlunoID = 2;
-- Uma maneira de confirmar o ID do Pedro
SELECT * FROM Escola_Alunos WHERE NOME = 'Pedro';

-- Ativar (está cursando) um Aluno com UPDATE e Transação Explícita (START TRANSACTION ou BEGIN), COMMIT, ROLLBACK) 

BEGIN; -- fica em espera no Banco de Dados até o comando COMMIT (tem que executar antes do update)
-- Desativar a aluna Mariana e usar uma transação para demonstrar o ROLLBACK
UPDATE Escola_Alunos SET Ativo = FALSE WHERE AlunoID = 3;
-- Verificar a alteração antes de fazer o COMMIT (opcional, mas bom para demonstração)
SELECT Nome, Ativo FROM Escola_Alunos WHERE Nome = 'Mariana';
-- Revertendo a alteração de UPDATE
ROLLBACK;

BEGIN;
-- Atualizar Múltiplos Campos 
UPDATE Escola_Cursos SET 
	CargaHoraria = 45,
    Preco = 320.00
WHERE CursoID = 1;
COMMIT; -- Caso não esteja no modo auto-commit

-- Excluir Pedro, mas depois vamos reverter a operação para demonstrar o ROLLBACK
SELECT * FROM Escola_Alunos WHERE Nome = 'Pedro';

BEGIN;
-- Excluir Pedro
DELETE FROM Escola_Alunos WHERE AlunoID = 2;
ROLLBACK;