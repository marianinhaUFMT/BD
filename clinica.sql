CREATE DATABASE CLINICA;
USE CLINICA;

-- tabela medico
CREATE TABLE Medico 
(
	crm 					CHAR(10),
	nome 					VARCHAR(100) NOT NULL,
	telefone 				VARCHAR(11) NOT NULL,
    PRIMARY KEY(crm)
);

-- tabela especialidade
CREATE TABLE Especialidade
(
	id_espec   				INT,
    nome_espec 				CHAR(20),
    PRIMARY KEY (id_espec)
);

-- tabela medico_especialidade
CREATE TABLE Medico_Especialidade
(
	crm						CHAR(10),		
	id_espec				INT,
    PRIMARY KEY(crm, id_espec),
    FOREIGN KEY (crm) REFERENCES Medico(crm),
    FOREIGN KEY (id_espec) REFERENCES Especialidade(id_espec)
);

-- tabela recepcionista
CREATE TABLE Recepcionista 
(
	id_recepcionista 		INT,
	cpf 					CHAR(11) UNIQUE NOT NULL,
	nome 					VARCHAR(100) NOT NULL,
	telefone 				VARCHAR(11) NOT NULL,
    PRIMARY KEY(id_recepcionista)
);

-- tabela convenio medico (plano)
CREATE TABLE Convenio 
(
	id_plano 				INT,
	nome 					VARCHAR(50) NOT NULL,
	porcentagem_cobertura 	DECIMAL (5, 2) NOT NULL,
    PRIMARY KEY(id_plano),
	CONSTRAINT chp_porcentagem 
		CHECK (porcentagem_cobertura BETWEEN 0 AND 100)
);
    
-- tabela paciente
CREATE TABLE Paciente 
(
	cpf 				CHAR(11),
    nome 				VARCHAR(100) NOT NULL,
    data_nascimento 	DATE NOT NULL,
    telefone 			VARCHAR(11),
    endereco 			VARCHAR(100),
    id_plano 			INT,
    PRIMARY KEY(cpf),
    FOREIGN KEY (id_plano) REFERENCES Convenio(id_plano)
);
    
-- tabela procedimento
CREATE TABLE Procedimento 
(
	id_procedimento 	INT,
    nome 				VARCHAR(50) NOT NULL,
    valor 				DECIMAL (10, 2) NOT NULL,
    -- coloquei inteiro para estimar quantos minutos de duracao
    duracao 			INT NOT NULL,
    PRIMARY KEY(id_procedimento)
);

-- tabela consulta
CREATE TABLE Consulta 
(
	id_consulta 		INT,
    data_consulta 		DATE NOT NULL,
    hora 				TIME NOT NULL,
    situacao 			ENUM("agendada", "concluida", "cancelada") NOT NULL,
    id_pac 				CHAR(11) NOT NULL,
    id_recep 			INT NOT NULL,
    id_med 				CHAR(10) NOT NULL,
    PRIMARY KEY(id_consulta),
    FOREIGN KEY (id_pac) REFERENCES Paciente(cpf),
    FOREIGN KEY (id_recep) REFERENCES Recepcionista(id_recepcionista),
    FOREIGN KEY (id_med) REFERENCES Medico(crm)
);

-- tabela pagamento
CREATE TABLE Pagamento 
(
	id_pagamento 		INT,
    valor 				DECIMAL (10, 2) NOT NULL,
    forma_pagamento 	ENUM("cartao", "dinheiro", "boleto") NOT NULL,
    situacao 			ENUM("pago", "pendente", "cancelado") NOT NULL,
	id_consulta 		INT NOT NULL,
    id_plano 			INT,
    PRIMARY KEY(id_pagamento),
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta),
    FOREIGN KEY (id_plano) REFERENCES Convenio(id_plano)
);
	
-- tabela associativa consulta_procedimento
CREATE TABLE Consulta_Procedimento 
(
	id_consulta 		INT,
    id_procedimento 	INT,
    PRIMARY KEY (id_consulta, id_procedimento),
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta),
    FOREIGN KEY (id_procedimento) REFERENCES Procedimento(id_procedimento)
);
    
-- insercoes convenio
INSERT INTO Convenio VALUES
(1, 'Unimed', 80.00),
(2, 'Amil', 70.00),
(3, 'SulAmérica', 75.00),
(4, 'Bradesco Saúde', 85.00),
(5, 'Porto Seguro', 65.00),
(6, 'Hapvida', 60.00),
(7, 'NotreDame', 90.00),
(8, 'Intermédica', 55.00),
(9, 'Golden Cross', 70.00),
(10, 'Medial', 80.00);

-- insercoes paciente
INSERT INTO Paciente VALUES
('12345678901', 'Ana Silva', '1990-05-15', '11987654321', 'Rua A, 123', 1),
('23456789012', 'Bruno Costa', '1985-08-22', '11976543210', 'Rua B, 456', 2),
('34567890123', 'Carla Souza', '1992-03-10', '11965432109', 'Rua C, 789', NULL),
('45678901234', 'Diego Lima', '1988-11-30', '11954321098', 'Rua D, 101', 3),
('56789012345', 'Elisa Santos', '1995-07-25', '11943210987', 'Rua E, 202', 4),
('67890123456', 'Fábio Almeida', '1983-02-18', '11932109876', 'Rua F, 303', 5),
('78901234567', 'Giselle Ferreira', '1991-09-05', '11921098765', 'Rua G, 404', NULL),
('89012345678', 'Hugo Mendes', '1987-12-12', '11910987654', 'Rua H, 505', 6),
('90123456789', 'Ingrid Oliveira', '1993-04-20', '11909876543', 'Rua I, 606', 7),
('01234567890', 'João Pereira', '1989-06-15', '11998765432', 'Rua J, 707', 8),
('98765432100', 'Pedro Miguel', '2023-04-14', '64999315390', 'Rua C, 481', NULL);

-- insercoes medico
INSERT INTO Medico VALUES
('CRM123', 'Dr. Marcos Ribeiro', '11987654321' ),
('CRM124', 'Dra. Lúcia Mendes', '11976543210' ),
('CRM125', 'Dr. Rafael Gomes', '11965432109' ),
('CRM126', 'Dra. Sofia Almeida', '11954321098'),
('CRM127', 'Dr. Thiago Costa', '11943210987'),
('CRM128', 'Dra. Vanessa Lima', '11932109876'),
('CRM129', 'Dr. André Souza', '11921098765'),
('CRM130', 'Dra. Beatriz Santos', '11910987654'),
('CRM131', 'Dr. Carlos Ferreira', '11909876543'),
('CRM132', 'Dra. Daniela Oliveira', '11998765432');

-- insercoes especialidade
INSERT INTO Especialidade VALUES
(1,'Cardiologia'),
(2,'Pediatria'),
(3, 'Ortopedia'),
(4, 'Ginecologia'),
(5, 'Neurologia'),
(6, 'Dermatologia'),
(7, 'Endocrinologia'),
(8, 'Urologia'),
(9, 'Psiquiatria'),
(10, 'Oftalmologia');

-- insercoes medico_especialidade
INSERT INTO Medico_Especialidade VALUES
('CRM123', 1),
('CRM124', 2),
('CRM125', 3),
('CRM126', 4),
('CRM127', 5),
('CRM128', 6),
('CRM129', 7),
('CRM130', 8),
('CRM131', 9),
('CRM132', 10);

-- insercoes recepcionista
INSERT INTO Recepcionista VALUES
(1, '11122233344', 'Clara Mendes', '11987654321'),
(2, '22233344455', 'Eduardo Silva', '11976543210'),
(3, '33344455566', 'Fernanda Costa', '11965432109'),
(4, '44455566677', 'Gustavo Lima', '11954321098'),
(5, '55566677788', 'Helena Souza', '11943210987'),
(6, '66677788899', 'Igor Almeida', '11932109876'),
(7, '77788899900', 'Juliana Santos', '11921098765'),
(8, '88899900011', 'Kléber Ferreira', '11910987654'),
(9, '99900011122', 'Larissa Oliveira', '11909876543'),
(10, '00011122233', 'Marcelo Pereira', '11998765432');

-- insercoes consulta
INSERT INTO Consulta VALUES
(1, '2025-05-01', '09:00:00', 'agendada', '12345678901', 1, 'CRM123'),
(2, '2025-05-01', '10:00:00', 'agendada', '23456789012', 2, 'CRM124'),
(3, '2025-04-15', '14:00:00', 'concluida', '34567890123' ,3, 'CRM125'),
(4, '2025-05-02', '11:00:00', 'agendada', '45678901234', 4, 'CRM126'),
(5, '2025-04-20', '15:00:00', 'concluida', '56789012345', 5, 'CRM127'),
(6, '2025-05-03', '09:30:00', 'agendada', '67890123456', 6, 'CRM128'),
(7, '2025-04-25', '16:00:00', 'concluida', '78901234567', 7, 'CRM129'),
(8, '2025-05-04', '10:30:00', 'agendada', '89012345678', 8, 'CRM130'),
(9, '2025-04-30', '13:00:00', 'concluida', '90123456789', 9, 'CRM131'),
(10, '2025-05-05', '14:30:00', 'agendada', '01234567890', 10, 'CRM132'),
(11, '2025-04-29', '08:00:00', 'agendada', '23456789012', 2, 'CRM123'),
(12, '2025-04-30', '09:00:00', 'agendada', '34567890123', 3, 'CRM123'),
(13, '2025-05-01', '11:00:00', 'agendada', '45678901234', 4, 'CRM123'),
(14, '2025-05-02', '10:00:00', 'agendada', '56789012345', 5, 'CRM123'),
(15, '2025-05-03', '13:00:00', 'agendada', '67890123456', 6, 'CRM123');

-- insercoes procedimento
INSERT INTO Procedimento VALUES
(1, 'Raio-X', 150.00, 15),
(2, 'Exame de Sangue', 100.00, 10),
(3, 'Sutura', 200.00, 30),
(4, 'Eletrocardiograma', 120.00, 20),
(5, 'Ultrassom', 180.00, 25),
(6, 'Endoscopia', 300.00, 40),
(7, 'Ressonância Magnética', 500.00, 45),
(8, 'Consulta Especializada', 250.00, 30),
(9, 'Fisioterapia', 80.00, 50),
(10, 'Teste Ergométrico', 200.00, 35);

-- link de consulta procedimento
INSERT INTO Consulta_Procedimento VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 9),
(9, 10);

-- insercoes pagamento
INSERT INTO Pagamento VALUES
(1, 150.00, 'cartao', 'pago', 1, NULL),
(2, 100.00, 'dinheiro', 'pago', 2, 2),
(3, 200.00, 'boleto', 'pendente', 3, NULL),
(4, 120.00, 'cartao', 'pago', 4, 3),
(5, 180.00, 'dinheiro', 'pago', 5, NULL),
(6, 300.00, 'cartao', 'pago', 6, 5),
(7, 500.00, 'boleto', 'pendente', 7, NULL),
(8, 250.00, 'cartao', 'pago', 8, 7),
(9, 80.00, 'dinheiro', 'pago', 9, NULL),
(10, 200.00, 'cartao', 'pago', 10, 8);

-- listar todas as consultas agendadas para um determinado medico em um dia especifico
SELECT C.id_consulta, C.data_consulta, C.hora, P.nome AS paciente, C.situacao
FROM Consulta C
JOIN Paciente P ON C.id_pac = P.cpf
WHERE C.id_med = 'CRM123' AND C.data_consulta = '2025-05-01' AND C.situacao = 'agendada';

-- contar quantas consultas cada medico realizou no ultimo mes
SELECT M.crm, M.nome, COUNT(C.id_consulta) AS total_consultas
FROM Medico M
LEFT JOIN Consulta C 
  ON M.crm = C.id_med 
  AND C.data_consulta BETWEEN '2025-03-28' AND '2025-04-28'
  AND C.situacao = 'concluida'
GROUP BY M.crm, M.nome;

-- encontrar os pacientes que nunca tiveram uma consulta agendada (todos os pacientes tem consulta)
SELECT P.cpf, P.nome
FROM Paciente P
LEFT JOIN Consulta C ON P.cpf = C.id_pac
WHERE C.id_consulta IS NULL;

-- listar os procedimentos realizados em uma consulta especifica
SELECT P.id_procedimento, P.nome, P.valor, P.duracao
FROM Procedimento P
JOIN Consulta_Procedimento CP ON P.id_procedimento = CP.id_procedimento
WHERE CP.id_consulta = 2;

-- calcular o total pago por cada paciente nos ultimos 3 meses
SELECT P.cpf, P.nome, SUM(Pg.valor) AS total_pago
FROM Paciente P
JOIN Consulta C ON P.cpf = C.id_pac
LEFT JOIN Pagamento Pg ON C.id_consulta = Pg.id_consulta AND Pg.situacao = 'pago'
WHERE C.data_consulta BETWEEN '2025-01-28' AND '2025-04-28'
GROUP BY P.cpf, P.nome;

-- identificar os convenios que cobrem mais de 50% do valor das consultas
SELECT id_plano, nome, porcentagem_cobertura
FROM Convenio
WHERE porcentagem_cobertura > 50;

-- listar todos os pacientes atendidos por um determinado medico
SELECT DISTINCT P.cpf, P.nome
FROM Paciente P
JOIN Consulta C ON P.cpf = C.id_pac
WHERE C.id_med = 'CRM123';

-- mostrar o faturamento total do ultimo mes, considerando apenas pagamentos concluidos
SELECT SUM(valor) AS faturamento_total
FROM Pagamento Pg
WHERE Pg.situacao = 'pago' AND Pg.id_consulta IN (
    SELECT id_consulta FROM Consulta WHERE data_consulta BETWEEN '2025-03-28' AND '2025-04-28');

-- encontrar os medicos que possuem mais de 5 consultas marcadas para a proxima semana
SELECT M.crm, M.nome, COUNT(C.id_consulta) AS total_consultas
FROM Medico M
JOIN Consulta C ON M.crm = C.id_med
WHERE C.data_consulta BETWEEN '2025-04-29' AND '2025-05-05' AND C.situacao = 'agendada'
GROUP BY M.crm, M.nome
HAVING COUNT(C.id_consulta) > 5;

-- listar os pacientes que mais gastaram na clinica nos ultimos 6 meses
SELECT P.cpf, P.nome, SUM(Pg.valor) AS total_gasto
FROM Paciente P
JOIN Consulta C ON P.cpf = C.id_pac
JOIN Pagamento Pg ON C.id_consulta = Pg.id_consulta
WHERE C.data_consulta BETWEEN '2024-11-28' AND '2025-05-28' AND Pg.situacao = 'pago'
GROUP BY P.cpf, P.nome
ORDER BY total_gasto DESC;
