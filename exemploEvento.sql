USE master
go
CREATE DATABASE ets
go
USE ets
go


CREATE TABLE Sala (
  IDSala INT NOT NULL PRIMARY KEY,
  Nome VARCHAR(50) NOT NULL,
  Capacidade INT NOT NULL
);

go

-- Declarando os atributos
INSERT INTO Sala (IDSala, Nome, Capacidade) VALUES (1, 'Sala de TI', 20);
 
-- Não declarando atributos
INSERT INTO Sala VALUES (2, 'Sala de Reunião', 10);
 
-- Inserindo várias linhas
INSERT INTO Sala VALUES (3, 'Sala de palestras 1', 30), (4, 'Sala de aula', 15);

go

CREATE TABLE Evento (
  IDEvento INT NOT NULL PRIMARY KEY,
  IDSala INT NOT NULL FOREIGN KEY REFERENCES Sala(IDSala),
  Descricao VARCHAR(100) NOT NULL,
  DtHrInicio DATETIME NOT NULL,
  DtHrFim DATETIME NOT NULL
);

go


INSERT INTO Evento VALUES (
    1,
    1,
    'Aula de IoT',
    '2022-03-26 19:00',
    '2022-03-26 22:30'
);


select * from evento
