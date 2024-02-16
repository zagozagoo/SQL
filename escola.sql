CREATE DATABASE Escola
GO

Use Escola
go

DROP TABLE Aluno;
DROP TABLE Disciplina;
DROP TABLE Historico;
DROP TABLE Professor;
DROP TABLE Turma;

CREATE TABLE Aluno (
	Mat VARCHAR(36) PRIMARY KEY NOT NULL,
	Nome VARCHAR(255) NOT NULL,
	Endereco VARCHAR(255),
	Cidade Varchar(255)
)

CREATE TABLE Disciplina (
	CodDisc VARCHAR(36) PRIMARY KEY NOT NULL,
	NomeDisc VARCHAR(255) NOT NULL,
	CargarHor INT NOT NULL
)

CREATE TABLE Professor (
	CodProf VARCHAR(36) PRIMARY KEY NOT NULL,
	Nome VARCHAR(255) NOT NULL,
	Endereco VARCHAR(255),
	Cidade Varchar(255)
)

CREATE TABLE Turma (
	CodDisc VARCHAR(36) FOREIGN KEY REFERENCES Disciplina (CodDisc) NOT NULL,
	CodTurma VARCHAR(36) NOT NULL,
	CodProf VARCHAR(36) FOREIGN KEY REFERENCES Professor (CodProf) NOT NULL,
	Ano INT NOT NULL,
	Horario TIME,

	PRIMARY KEY(CodDisc, CodTurma, CodProf, Ano)
)

CREATE TABLE Historico (
	Mat VARCHAR(36) FOREIGN KEY REFERENCES Aluno (Mat) NOT NULL,
	CodDisc VARCHAR(36) NOT NULL,
	CodTurma VARCHAR(36) NOT NULL,
	CodProf VARCHAR(36) NOT NULL,
	Ano INT NOT NULL,
	Frequencia FLOAT NOT NULL,
	Nota FLOAT,

	PRIMARY KEY(Mat, CodDisc, CodTurma, CodProf, Ano),
	CONSTRAINT FK_Historico_Turma FOREIGN KEY (CodDisc, CodTurma, CodProf, Ano) REFERENCES Turma (CodDisc, CodTurma, CodProf, Ano)
)


