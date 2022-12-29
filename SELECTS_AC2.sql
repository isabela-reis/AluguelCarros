#######################   FUNCTION    ###############################
# 3 - Crie uma function que, dado a placa do veículo, retorna quantas viagens já fez.

 delimiter $ 
 create function QtdViagens(Placa int  (7))
	returns int  (7) deterministic 
       return (select count(Placa)
             from Veiculos 
              join Viagens on Veiculos.Placa = Viagens.Placa_id
			   where Placa_id = Placa) $

 select QtdViagens ('1111111');

####################     PROCEDURE       ##########################

# 4 - Crie uma procedure que, recebe apenas 4 parâmetros: cidade de orgiem, destino, 
# condutor e veículo e registra uma viagem com data de saída no dia seguinte.

 delimiter $
 create procedure RegistraViagem(
 Condutor_id     int,
 Placa_id        int,
 CidadeO         varchar(30), 
 CidadeD         varchar(30)
 )

 begin 

 insert into Viagens values 
 (null, (CURDATE()+1), sysdate(), Condutor_id, Placa_id, CidadeO, CidadeD);
 end$
 delimiter ;

 call  RegistraViagem(10,88888888,1,5 );
 
select * from Viagens

#############################  SELECT  #####################################

#10 - Selecione todos os condutores sem CNH informada.

select NomeCondutor from Condutores 
group by Cnh = null

#############################  SELECT AUTORELACIONAMENTO  #####################################

#8 - Selecione as distâncias entre todos os pares de cidade, scuja distância é conhecida.

select A.Nome, B.Nome, DistanciaKm 
	from Cidade A 
	join Distancia S on S.CidadeOrigem = A.id 
	join Cidade B on S.CidadeDestino = B.id
    where A.Nome != B.Nome and DistanciaKm !=0
order by A.Nome asc

############################  VIEW   ######################################

7 - Crie uma view que exibe os detalhes de todas as viagens, como nome das cidades, 
nome do condutor, placa e nome do veículo, data e etc.

create or replace view ExibeViagens as 
	select NomeCondutor, Cpf, Cnh, Placa, Modelo, DataSaida, CidadeO, CidadeD
    from Veiculos
    inner join Viagens on Veiculos.Condutor_id = Viagens.Condutor_id
    left join Condutores on Veiculos.Condutor_id = Condutores.id
    order by NomeCondutor;
    
    select * from ExibeViagens;

################################## TRIGGER ##########################################

#5 - Sempre que uma viagem for alterada, registre essa ocorrência em uma tabela apropriada.

delimiter $

create trigger ALteracaoInsert before insert on Viagens 
	for each row
	begin
    insert into Alteracoes values (null,'Viagens', user(), sysdate(), 'insert');
end $

delimiter ;

delimiter $

create trigger AlteracaoDelete before delete on Viagens 
	for each row
	begin
    insert into Alteracoes values (null,'Viagens', user(), sysdate(), 'Delete');
end $

delimiter ;

delimiter $

create trigger AlteracaoUpdate before update on Viagens 
	for each row
	begin
    insert into Alteracoes values (null,'Viagens', user(), sysdate(), 'Update');
end $

delimiter ;

update Viagens set Placa_id=2222222 where id=1;

insert into Viagens (id, DataSaida, DataAtual, Condutor_id, Placa_id, CidadeO, CidadeD) values
(011, '2022-11-28', sysdate(),  10, 1234567, 'Sorocaba', 'Campinas');

delete from Viagens where id = 011;

#select * from Viagens

select * from ALteracoes

######################### FUNCTION ##########################################

#9 - Crie uma função que dado duas cidades, retorna a distância entre elas, 
#ou lance um erro caso a distância ou as cidades não estiverem previamente definidas.

 delimiter $ 
 create function DistanciaCidades(CidadeO int, CidadeD int)
	returns int deterministic 
 
        return (select DistanciaKm from Distancia
		where CidadeOrigem = CidadeO and CidadeDestino = CidadeD)$
        			
delimiter ;

select DistanciaCidades (1,3);

#OBS: Não consegui fazer a parte o if funcionar, ele pede pra colocar um ponto o virgula depois do where, mas aí a function deixa de ser válida. 

#if (select DistanciaKm from Distancia) = null  or  (select Cidadeorigem from Distancia) = null or (select CidadeDestino from Distancia) = null 
            #then return 
						#signal SQLSTATE '30000' 
						#set MESSAGE_TEXT = "Valor inválido",
						#MYSQL_ERRNO = 505;

