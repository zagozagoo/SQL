use master

if exists(select * from sys.databases where name = 'DomRamalho')
	drop database DomRamalho
go

create database DomRamalho
go

use DomRamalho
go

create table domTable (
	Id integer identity primary key,
	Nome varchar(100) not null,
	Sobrenome varchar(100) not null,
	Idade int not null
);
go

insert into domTable values ('luiz', 'zago', 18);
go

select * from domTable
go
