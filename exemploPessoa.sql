USE master
go
CREATE DATABASE ets
go
USE ets
go

CREATE TABLE Pessoa (
  IDPessoa INT NOT NULL PRIMARY KEY,
  Nome VARCHAR(250) NOT NULL,
  Categoria VARCHAR(20) NOT NULL
);
go

-- Declarando os atributos
INSERT INTO Pessoa (IDPessoa, Nome, Categoria) VALUES (1, 'duda', 'lindatrabalhadora');
 
-- Não declarando atributos
INSERT INTO Pessoa VALUES (2, 'dom', 'maluqueteATLETAA');
 
-- Inserindo várias linhas
INSERT INTO Pessoa VALUES (3, 'zago', 'iconicademais'), (4, 'Rosa', 'charmosobobo');
go

select * from Pessoa

CREATE TABLE EventoPessoa (
    IDEventoPessoa INT NOT NULL PRIMARY KEY,
    IDEvento INT NOT NULL FOREIGN KEY REFERENCES Evento(IDEvento),
    IDPessoa INT NOT NULL FOREIGN KEY REFERENCES Pessoa(IDPessoa),
    PapelEvento VARCHAR(75) NOT NULL,
    Presenca VARCHAR(15) NOT NULL
);

CREATE TABLE EventoEquipamento (
    IDEventoEquipamento INT NOT NULL PRIMARY KEY,
    IDEvento INT NOT NULL FOREIGN KEY REFERENCES Evento(IDEvento),
    IDEquipamento INT NOT NULL FOREIGN KEY REFERENCES Equipamento(IDEquipamento)
