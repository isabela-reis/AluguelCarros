drop database if exists AluguelCarros;
create database AluguelCarros;
use AluguelCarros;

create table Veiculos(
id                    int                auto_increment		primary key,
Modelo				  varchar (30)       not null,
Placa                 int  (7)           not null,
Ano                   YEAR               not null,
Condutor_id           int				 not null	        references Condutores(id)   
);

create table Condutores(
id                    int                auto_increment		primary key,
NomeCondutor          varchar (30)       not null,
Cpf                   int (11)           not null,
Cnh                   int (9),
Placa_id              int				 not null	        references Veiculos(id)
);										

create table Viagens(
id                    int                auto_increment		primary key,
DataSaida             date,               
DataAtual             datetime,               
Condutor_id           int				 not null	        references Condutores(id),
Placa_id              int				 not null	        references Veiculos(Placa),
CidadeO               varchar(30)        not null	        references Distancia(CidadeOrigem),
CidadeD               varchar(30)     	 not null	        references Distancia(CidadeDestino)
);

create table Distancia(
CidadeOrigem         varchar(30)       		    	        references Cidade(id),
CidadeDestino        varchar(30)		         	        references Cidade(id),
DistanciaKm          int                                    check (DistanciaKm > 0),

check (CidadeDestino  != CidadeOrigem),
primary key (CidadeOrigem, CidadeDestino)
);

create table Cidade(
id                   int                auto_increment		primary key,
Nome                 varchar (30)       not null,  
Populacao            varchar (30)       not null,  
Fundacao             date               not null,
AreaCidade           int                not null 
);

create table Alteracoes(
id                     int			   	 primary key			auto_increment,
nomeTabela             varchar(60)       not null,
nomeUsuario            varchar(60)       not null,
ultimaAtualizacao      datetime          not null, 
ocorrencia             varchar(60)
);

insert into Veiculos (id, Modelo, Placa, Ano, Condutor_id) values
(1, 'BMW', 1111111, 2001, 10),
(2, 'Mercedes-Benz', 2222222, 2002, 20),
(3, 'Land Rover', 3333333, 2003, 30),
(4, 'Volvo', 4444444, 2004, 40),
(5, 'Porsche', 5555555, 2005, 55);

insert into Condutores (id, NomeCondutor, Cpf, Cnh, Placa_id) values
(10, 'Lia', 1111111111, null, 1111111),
(20, 'Clair', 222222222, 020202020, 2222222),
(30, 'Lucy', 333333333, 030303030, 3333333),
(40, 'Lorelai', 444444444, 040404040, 4444444),
(50, 'Rachel', 555555555, 050505050, 5555555);

insert into Distancia(CidadeOrigem, CidadeDestino, DistanciaKm) values
(1, 2, null),
(1, 3, 103),
(1, 4, 52),
(1, 5, 87),
(2, 3, 247),
(2, 4, 272),
(2, 5, 261),
(3, 4, 108),
(3, 5, 83),
(4, 5, 41);

insert into Cidade(id, Nome, Populacao, Fundacao, AreaCidade) values
(1, 'Sorocaba', '1000', '1654-08-15', 450),
(2, 'Bauru', '2000', '1896-08-01', 673),
(3, 'São Paulo', '3000', '1554-01-25',  248),
(4, 'Salto', '4000', '1698-06-16', 134),
(5, 'Campinas', '5000', '1774-07-14', 794);

insert into Viagens (id, DataSaida, DataAtual, Condutor_id, Placa_id, CidadeO, CidadeD) values
(001, '2022-11-22', sysdate(),  10, 1111111, 'Sorocaba', 'Bauru'),
(002, '2022-11-21', sysdate(),  20, 2222222, 'Sorocaba', 'São Paulo'),
(003, '2022-11-22', sysdate(), 30, 3333333, 'Sorocaba', 'Salto'),
(004, '2022-11-23', sysdate(), 40, 4444444, 'Sorocaba', 'Campinas'),
(005, '2022-11-24', sysdate(), 50, 5555555, 'Bauru', 'São Paulo'),
(006, '2022-11-25', sysdate(), 10, 6666666, 'Bauru', 'Salto'),
(007, '2022-11-26', sysdate(), 20, 7777777, 'Bauru', 'Campinas'),
(008, '2022-11-27', sysdate(), 30, 8888888, 'São Paulo', 'Salto'),
(009, '2022-11-28', sysdate(), 40, 1111111, 'São Paulo', 'Campinas'),
(0010,'2022-11-29', sysdate(), 50, 9999999, 'Salto', 'Campinas');

