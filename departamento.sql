create database ZagoTreinando
go

use ZagoTreinando
go

create table Departamento
(
	EDV Int primary key,
	NOME VarChar(255),
	LIDER VarChar(255),
	DATACONTRATACAO Date,
	SALARIO Float,
	DEPARTAMENTO Int foreign key references Departamento(IDDEPARTAMENTO)
)

create table Grade_Salarial
(
	GRADE Int primary key,
	SAL_MIN Int,
	SAL_MAX Int
)

INSERT INTO Departamento VALUES
(1, 'REMAN', 104),
(2, 'ICO', 101),
(3, 'ETS', 401),
(4, 'FCM', 303),
(5, 'INOVE', 303)

INSERT INTO Funcionario VALUES
(92890148, 'Edna Carvalho', 'Andrea', '1990-02-24', 19000, 1),
(92790062, 'João Manfredo', 'Andrea', '2001-09-26', 12500, 1),
(91004090, 'Débora Junior', 'Andrea', '1999-03-02', 15600, 1),
(94566222, 'Carla Rodrigues', 'Andrea', '1990-10-04', 20000, 1),
(96334100, 'Maciel Oliveira', 'Andrea', '1995-12-06', 16500, 1),
(97885245, 'Guilherme Gonçalves', 'Marcos', '2010-05-13', 9000, 2),
(92894706, 'Jessica Lima', 'Marcos', '2015-08-14', 25678, 2),
(98462157, 'Lorena Ray', 'Pietra', '2017-02-25', 1900, 3),
(91450032, 'Isabella Machado', 'Marcos', '1993-01-22', 10900, 2)

INSERT INTO Grade_Salarial VALUES
(1, 1500, 4000),
(2, 4001, 9000),
(3, 9001, 22000),
(4, 22001, 50000)
