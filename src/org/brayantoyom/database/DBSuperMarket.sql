
set global time_zone = '-6:00';

create database DBSuperMarket;
use DBSuperMarket;

create table Clientes (
    codigoCliente int primary key,
    NITCliente varchar(10),
    nombresCliente varchar(50),
    apellidosCliente varchar(50),
    direccionCliente varchar(150),
    telefonoCliente varchar(45),
    correoCliente varchar(45)
);

create table CargoEmpleado (
    codigoCargoEmpleado int primary key,
    nombresCargo varchar(45),
    descripcionCargo varchar(45)
);

create table TipoProducto(
    codigoTipoProducto int primary key,
    descripcion varchar(45)
);

create table Compras(
    numeroDocumento int primary key,
    fechaDocumento date,
    descripcion varchar(60),
    totalDocumento decimal(20,2)
);

delimiter $$

create procedure sp_agregarCliente(in codeCli int, in nitCli varchar(10), in nombresCli varchar(50), in apellidosCli varchar(50),in direcCli varchar(150), in telefonoCli varchar(45), in correoCli varchar(45))
begin
    insert into Clientes (codigoCliente, NITCliente, nombresCliente, apellidosCliente, direccionCliente, telefonoCliente, correoCliente)
    values (codeCli, nitCli, nombresCli, apellidosCli, direcCli, telefonoCli, correoCli);
end$$

delimiter ;

call sp_agregarCliente(1, '84851', 'Estuardo', 'Morales', 'Zona 8', '78945', 'esmorales@gmail.com'); 


delimiter $$

create procedure sp_listarCliente()
begin 
    select
        codigoCliente,
        NITCliente,
        apellidosCliente,
        nombresCliente,
        direccionCliente,
        telefonoCliente,
        correoCliente
    from Clientes;
end $$

delimiter ;

call sp_listarCliente();

delimiter $$

create procedure sp_buscarCliente(in nitCli varchar(10))
begin
    select
        codigoCliente,
        NITCliente,
        apellidosCliente,
        nombresCliente,
        direccionCliente,
        telefonoCliente,
        correoCliente
    from Clientes where NITCliente = nitCli;
end$$

delimiter ;

delimiter $$

create procedure sp_actualizarCliente(in codeCli int, in nitCli varchar(10), in nombresCli varchar(50), in apellidosCli varchar(50), in direcCli varchar(150), in telefonoCli varchar(45), in correoCli varchar(45))
begin
    update Clientes
    set
        NITCliente = nitCli,
        nombresCliente = nombresCli,
        apellidosCliente = apellidosCli,
        direccionCliente = direcCli,
        telefonoCliente = telefonoCli,
        correoCliente = correoCli
    where
        codigoCliente = codeCli;
end$$

delimiter ;

delimiter $$

create procedure sp_agregarCargoEmpleado(in codeCargoEmpleado int, in nombCargo varchar(45), in descripCargo varchar(45))
begin
    insert into CargoEmpleado (codigoCargoEmpleado, nombresCargo, descripcionCargo)
    values (codeCargoEmpleado, nombCargo, descripCargo);
end$$

delimiter ;

call sp_eliminarCliente(5);

delimiter $$

create procedure sp_agregarCargoEmpleado(in codeCargoEmpleado int, in nombCargo varchar(45), in descripCargo varchar(45))
begin
    insert into CargoEmpleado (codigoCargoEmpleado, nombresCargo, descripcionCargo)
    values (codeCargoEmpleado, nombCargo, descripCargo);
end$$

delimiter ;

call sp_agregarCargoEmpleado(1, 'Gerente', 'Responsable');

select * from CargoEmpleado;
select * from Clientes;


delimiter $$

create procedure sp_listarCargoEmpleado()
Begin
    Select
        codigoCargoEmpleado,
        nombresCargo,
        descripcionCargo
    From CargoEmpleado;
End$$

delimiter ;

delimiter $$

create procedure sp_buscarCargoEmpleado(in codeCargoEmpleado int)
begin
    select codigoCargoEmpleado, nombresCargo, descripcionCargo from CargoEmpleado where codigoCargoEmpleado = codeCargoEmpleado;
end$$

delimiter ;

delimiter $$

create procedure sp_actualizarCargoEmpleado(in codeCargoEmpleado int, in nombCargo varchar(45), in descripCargo varchar(45))
begin
    update CargoEmpleado
    set
        nombresCargo = nombCargo,
        descripcionCargo = descripCargo
    where
        codigoCargoEmpleado = codeCargoEmpleado;
end$$

delimiter ;

delimiter $$

create procedure sp_eliminarCargoEmpleado(in codeCargoEmpleado int)
begin
    delete from CargoEmpleado where codigoCargoEmpleado = codeCargoEmpleado;
end$$

delimiter ;

delimiter $$

create procedure sp_agregarTipoProducto(in codeProducto int, in descriProduc varchar(45))
begin
    insert into TipoProducto (codigoTipoProducto, descripcion)
    values (codeProducto, descriProduc);
end$$

delimiter ;


call sp_agregarTipoProducto(1, 'Alimento');

select * from TipoProducto;

delimiter $$

create procedure sp_listarTipoProducto()
begin
    select
        codigoTipoProducto,
        descripcion
    from TipoProducto;
end$$

delimiter ;

delimiter $$

create procedure sp_buscarTipoProducto(in codeTipo int)
begin
    select * from TipoProducto where codigoTipoProducto = codeTipo;
end$$

delimiter ;

delimiter $$

create procedure sp_actualizarTipoProducto(in codeTipo int, in descriProduc varchar(45))
begin
    update TipoProducto
    set
        descripcion = descriProduc
    where
        codigoTipoProducto = codeTipo;
end$$

delimiter ;

delimiter $$

create procedure sp_eliminarTipoProducto(in codeTipo int)
begin
    delete from TipoProducto where codigoTipoProducto = codeTipo;
end$$

delimiter ;

delimiter $$

create procedure sp_agregarCompra(in fechaDocument date, in descriProduc varchar(60), in totalDocument decimal(20,2))
begin
    insert into Compras (fechaDocumento, descripcion, totalDocumento)
    values (fechaDocument, descriProduc, totalDocument);
end$$

delimiter ;

delimiter $$

create procedure sp_listarCompras()
begin
    select * from Compras;
end$$

delimiter ;

delimiter $$

create procedure sp_buscarCompra(in numDocument int)
begin
    select * from Compras where numeroDocumento = numDocument;
end$$

delimiter ;

delimiter $$

create procedure sp_actualizarCompra(in numDocument int, in fechaDocument date, in descriProduc varchar(60), in totalDocument decimal(20,2))
begin
    update Compras
    set
        fechaDocumento = fechaDocument,
        descripcion = descriProduc,
        totalDocumento = totalDocument
    where
        numeroDocumento = numDocument;
end$$

delimiter ;

delimiter $$

create procedure sp_eliminarCompra(in numDocument int)
begin
    delete from Compras where numeroDocumento = numDocument;
end$$

delimiter ;
