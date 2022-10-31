use ecommerce;
-- CODE 1  //consulta e modificação da base de dados

set @@autocommit = 0;

start transaction;
	select concat(Fname,' ',Minit,' ',Lname) as nome,  orderStatus, orderDescription
		from clients inner join orders on idClient = idOrderClient;
commit;

start transaction;
	update orders set sendValue = 200 where idOrder = 5;
commit;

-- CODE 2 // transação com procedure

set @@autocommit = 0;
start transaction;
	delimiter $
	create procedure insert_product()
	begin
		insert into product(Pname, category, avaliation)
					values('Cubo Mágico','Brinquedos',5);
		update product set avaliation = 4.3 where idProduct = 8;
	end $
	
    savepoint insercao_product;
    
    create procedure alter_product()
		begin
			update product set avaliation = 4.3 where idProduct = 8;
	end $
    delimiter ;
    
    rollback to savepoint insercao_product;
    
commit;

-- CODE 3
-- cd C:\Program Files\MySQL\MySQL Server 8.0\bin
-- mysqldump --user root --password --databases ecommerce > ecommerce_backup.sql
-- mysql --user root --password  < ecommerce_backup.sql
-- mysqldump --routines --triggers -u root -p company > company_backup.sql
-- mysql --user root --password  < company_backup.sql


