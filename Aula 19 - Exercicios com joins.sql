-- AULA 19 - NON-EQUAL JOINS

-- Desafio 1: Mapeamento de Departamentos
-- Problema: O RH precisa de um relatório que liste TODOS os departamentos e quem trabalha em cada um. 
-- O departamento 'Inovação' ainda não tem funcionários.
-- Tarefa: Escreva a consulta SQL que gera este relatório. 
-- O nome do funcionário deve aparecer como NULL para o departamento sem funcionários.

CREATE TABLE Empresa_Departamentos(
	ID_Dpto INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Nome VARCHAR(50) NOT NULL
);

	
CREATE TABLE Empresa_Funcionarios(
	ID_Func INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Departamento VARCHAR(50),
    Salario DECIMAL(10,2),
    ID_Dpto INT,
    FOREIGN KEY (ID_Dpto) REFERENCES Empresa_Departamentos(ID_Dpto)
);


CREATE TABLE Empresa_Salarios(
	ID_Sal INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Salario_Min DECIMAL(10,2) NOT NULL,
    Salario_Max DECIMAL(10,2) NOT NULL,
    Categoria VARCHAR(30),
    ID_Func INT,
    FOREIGN KEY (ID_Func) REFERENCES Empresa_Funcionarios(ID_Func)
);



INSERT INTO Empresa_Departamentos (Nome)
	VALUES
    ('Administração'),
    ('Atendimento ao Cliente'),
    ('Financeiro'),
    ('RH-Gestão de Pessoas'),
    ('Comercial'),
    ('Operacional'),
    ('Marketing'),
	('TI'),
    ('Jurídico'),
    ('Inovação');



INSERT INTO Empresa_Funcionarios (Nome, Departamento, Salario, ID_Dpto)
	VALUES
    ('Beatriz Paper','Administração',3500,1),
    ('Patrícia Goodfella','Atendimento ao Cliente',3500,2),
    ('João Coins','Financeiro',4000,3),
    ('Mary Jane','RH-Gestão de Pessoas',2500,4),
    ('José Seller','Comercial',3500,5),
    ('Pedro Seller','Comercial',4500,5),
    ('Paulo Hammer','Operacional',4000,6),
    ('Pablo Garantido','Marketing',2500,7),
    ('Ana Skill','TI',5500,8),
    ('Letícia Smart','TI',5500,8),
    ('Carlos Tramp','Jurídico',3500,9);
    
    
INSERT INTO Empresa_Salarios (Salario_Min, Salario_Max, Categoria)
    VALUES
		(1500, 3500, 'Júnior'),
        (4000, 8000, 'Pleno'),
        (8500, 15000, 'Sênior');
	
    SELECT * FROM Empresa_Departamentos;
    SELECT * FROM Empresa_Funcionarios;
    SELECT * FROM Empresa_Salarios;

-- Elaborar uma consulta SQL que liste TODOS os departamentos e quem trabalha em cada um.  
-- O nome do funcionário deve aparecer como NULL para o departamento sem funcionários.

-- (OBS: no JOIN a relação é estabelecida entre a FK da tabela de funcionários, com a PK da 
-- tabela departamentos, caso contrário o sistema segue a ordem de inserção dos nomes
-- dos departamentos, e os dados dos funcionários seriam inseridos naquela ordem)

SELECT 
d.Nome AS Departamento, 
f.Nome AS Nome_do_Funcionario 
FROM Empresa_Departamentos AS d
LEFT JOIN Empresa_Funcionarios AS f ON d.ID_Dpto=f.ID_Dpto ORDER BY d.nome ASC;


-- Desafio 2: Classificação de Salários
-- Tarefa: Escreva a consulta SQL que classifica cada funcionário de acordo com seu salario 
-- e o seu nível salarial (Junior, Pleno ou Senior)

SELECT 
    f.Nome AS Funcionario,
    f.Salario,
    s.Categoria
FROM Empresa_Funcionarios f
JOIN Empresa_Salarios s ON f.Salario BETWEEN s.Salario_Min AND s.Salario_Max
ORDER BY f.Salario DESC;


-- Título: Desafio 3: Relatório Específico
-- Tarefa: Escreva a consulta SQL para exibir o nome de todos os funcionários do nível 'Pleno' que trabalham no departamento de 'Comercial’.

SELECT 
    f.Nome AS Funcionario,
    f.Departamento,
    f.Salario,
    s.Categoria 
FROM Empresa_Funcionarios f
JOIN Empresa_Salarios s ON f.Salario BETWEEN s.Salario_Min AND s.Salario_Max
WHERE s.Categoria = 'Pleno' AND f.Departamento = 'Comercial';

    
    


