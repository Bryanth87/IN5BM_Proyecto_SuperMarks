
set global time_zone = '-6:00';
-- drop database if exists dbsupermarket;
create database DBSuperMarket;
use DBSuperMarket;

create table Clientes (

	codigoCliente int primary key,
    nombresClientes varchar (50),
    apellidosCliente varchar (50),
	NITCliente varchar (10),	
	telefonoCliente varchar (45),
	direccionCliente varchar(150),
	correoCliente varchar (45)

);
 -- ----------------------------------------------
 
create table CargoEmpleado (

	codigoCargoEmpleado int primary key,
    nombresCargo varchar (45),
    descripcionCargo varchar (45)
    
);

-- ----------------------------------------------

create table TipoProducto(

	codigoTipoProducto int primary key,
    descripcion varchar (45)
    
);

-- ---------------------------------------------

create table Compras(

    numDocumento int primary key,
    fechaDocumento date,
    descripcion varchar(60),
    totalDocumento decimal(20,2)
    
);

-- ----------------------------------------------

create table Proveedores(

	codigoProveedor int primary key,
    nombresProveedor varchar(50),
    apellidosProveedor varchar (50),
    NITProveedor varchar(10),
    telefonoProveedor varchar (45),
    direccionProveedor varchar (150),
    correoProveedor varchar(45),
    razonSocial varchar (45),
    contactoPrincipal varchar (100),
    paginaWeb varchar(45)
    
);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_agregarClientes(
    in codeCliente int, in nombClientes varchar(50), in apeCliente varchar(50),
    in NITCli varchar(10), in teleCliente varchar(45), in direcCliente varchar(150),
    in correoCli varchar(45)
)
begin
    insert into Clientes (codigoCliente, nombresClientes, apellidosCliente, NITCliente, telefonoCliente, direccionCliente, correoCliente)
    values (codeCliente, nombClientes, apeCliente, NITCli, teleCliente, direcCliente, correoCli);
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_AgregarClientes(1, 'Enrique', 'Arriaga', '84791', '47951', 'Zona 1', 'earriaga@gmail.com');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_listarClientes()
begin
    select codigoCliente, nombresClientes, apellidosCliente, NITCliente, telefonoCliente, direccionCliente, correoCliente from Clientes;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_listarClientes();

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_buscarClientes(in codeCliente int)
begin
    select * from Clientes where codigoCliente = codeCliente;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_BuscarClientes(2);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_actualizarClientes(
    in codeCliente int, in nombClientes varchar(50), in apeCliente varchar(50),
    in NITCli varchar(10), in teleCliente varchar(45), in direcCliente varchar(150),
    in correoCli varchar(45)
)
begin
    update Clientes
    set
        NITCliente = NITCli,
        nombresClientes = nombClientes,
        apellidosCliente = apeCliente,
        direccionCliente = direcCliente,
        telefonoCliente = teleCliente,
        correoCliente = correoCli
    where
        codigoCliente = codeCliente;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_ActualizarClientes(1, 'Junior', 'Hernandez', '478423', '8794', 'Zona 9', 'jhernandez@gmail.com');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_eliminarClientes(in codeCliente int)
begin
    delete from Clientes where codigoCliente = codeCliente;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_eliminarClientes(3);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_agregarCargoEmpleado(
    in codegoCargoEmpleado int, in nombCargo varchar(45), in descripCargo varchar(45)
)
begin
    insert into CargoEmpleado (codigoCargoEmpleado, nombresCargo, descripcionCargo)
    values (codegoCargoEmpleado, nombCargo, descripCargo);
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_agregarCargoEmpleado(1, 'Gerente', 'Es de ventas');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_listarCargoEmpleado()
begin
    select codigoCargoEmpleado, nombresCargo, descripcionCargo from CargoEmpleado;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_listarCargoEmpleado();

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_buscarCargoEmpleado(in codeCargoEmpleado int)
begin
    select * from CargoEmpleado where codigoCargoEmpleado = codeCargoEmpleado;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_buscarCargoEmpleado(1);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_actualizarCargoEmpleado(
    in codeCargoEmpleado int, in nombCargo varchar(45), in descripCargo varchar(45)
)
begin
    update CargoEmpleado
    set
        nombresCargo = nombCargo,
        descripcionCargo = descripCargo
    where
        codigoCargoEmpleado = codeCargoEmpleado;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_actualizarCargoEmpleado(1, 'Suplente', 'Encargado');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_eliminarCargoEmpleado(in codeCargoEmpleado int)
begin
    delete from CargoEmpleado where codigoCargoEmpleado = codeCargoEmpleado;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_eliminarCargoEmpleado(3);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_agregarTipoProducto(
    in codeProducto int, in descripTipo varchar(45)
)
begin
    insert into TipoProducto (codigoTipoProducto, descripcion)
    values (codeProducto, descripTipo);
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_agregarTipoProducto(1, 'Computadoras de Corea del Sur');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_listarTipoProducto()
begin
    select codigoTipoProducto, descripcion from TipoProducto;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_listarTipoProducto();

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_buscarTipoProducto(in codeTipoProducto int)
begin
    select * from TipoProducto where codigoTipoProducto = codeTipoProducto;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_buscarTipoProducto(2);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_actualizarTipoProducto(
    in codeTipoProducto int, in descripTipo varchar(45)
)
begin
    update TipoProducto
    set
        descripcion = descripTipo
    where
        codigoTipoProducto = codeTipoProducto;
end$$

delimiter ;
	
-- ---------------------------------------------------------------------------------------------------------------------------

call sp_actualizarTipoProducto(2, 'Carros de Japón');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_eliminarTipoProducto(in codeTipoProducto int)
begin
    delete from TipoProducto where codigoTipoProducto = codeTipoProducto;
end$$

delimiter ;	

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_eliminarTipoProducto(3);


-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_agregarCompra(
	in numbCompras int,
    in fechaCompras date,
    in descripcionCompras varchar(60),
    in totalCompras decimal(20,2)
)
begin
    insert into Compras (numDocumento,fechaDocumento, descripcion, totalDocumento)
    values (numbCompras,fechaCompras, descripcionCompras, totalCompras);
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_agregarCompra(1, '2019-07-08', 'Compra de herramientas', 450.00);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_listarCompras()
begin
    select numDocumento,fechaDocumento,descripcion,totalDocumento from Compras;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_listarCompras();

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_buscarCompra(in numbCompras int)
begin
    select * from Compras where numDocumento = numbCompras;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_buscarCompra(2);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_actualizarCompra(
    in numbCompras int,
    in fechaCompras date,
    in descripcionCompras varchar(60),
    in totalCompras decimal(20,2)
)
begin
    update Compras
    set
        fechaDocumento = fechaCompras,
        descripcion = descripcionCompras,
        totalDocumento = totalCompras
    where
        numDocumento = numbCompras;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_actualizarCompra(2, '2085-06-08', 'Compra de imanes', 950.00);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_eliminarCompra(in numbCompras int)
begin
    delete from Compras where numDocumento = numbCompras;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_eliminarCompra(3);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_agregarProveedor (
    in codeProveedor int,
    in nombProveedor varchar(50),
    in apelProveedor varchar(50),
    in NITPro varchar(10),
    in teleProveedor varchar(45),
    in direcProveedor varchar(150),
    in correoPro varchar(45),
    in razSocial varchar(45),
    in contacPrincipal varchar(100),
    in pageWeb varchar(45)
)
begin
    insert into Proveedores (
        codigoProveedor, nombresProveedor, apellidosProveedor, NITProveedor, 
        telefonoProveedor, direccionProveedor, correoProveedor, razonSocial, 
        contactoPrincipal, paginaWeb
    )
    values (
        codeProveedor, nombProveedor, apelProveedor, NITPro, 
        teleProveedor, direcProveedor, correoPro, razSocial, 
        contacPrincipal, pageWeb
    );
end $$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_agregarProveedor(1, 'Iman de calidad', 'S.A.', '84897', '65471', 'Zona 10, calle 1', 'iman@gmail.com', 'Iman de calidad', 'Eduardo Melina', 'www.iman.com');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_listarProveedores()
begin
    select
        codigoProveedor,
        nombresProveedor,
        apellidosProveedor,
        NITProveedor,
        telefonoProveedor,
        direccionProveedor,
        correoProveedor,
        razonSocial,
        contactoPrincipal,
        paginaWeb
    from
        Proveedores;
end $$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_listarProveedores();

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_buscarProveedor (in codeProveedor int)
begin
    select
        codigoProveedor,
        nombresProveedor,
        apellidosProveedor,
        NITProveedor,
        telefonoProveedor,
        direccionProveedor,
        correoProveedor,
        razonSocial,
        contactoPrincipal,
        paginaWeb
    from
        Proveedores
    where
        codigoProveedor = codeProveedor;
end $$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_buscarProveedor(1);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_eliminarProveedor (in codeProveedor int)
begin
    delete from Proveedores
    where codigoProveedor = codeProveedor;
end $$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_eliminarProveedor(3);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_actualizarProveedores(
    in codeProveedor int,
    in nombProveedor varchar(50),
    in apelProveedor varchar(50),
    in NITPro varchar(10),
    in teleProveedor varchar(45),
    in direcProveedor varchar(150),
    in correoPro varchar(45),
    in razSocial varchar(45),
    in contacPrincipal varchar(100),
    in pageWeb varchar(45)
)
begin
    update Proveedores
    set
        nombresProveedor = nombProveedor,
        apellidosProveedor = apelProveedor,
        NITProveedor = NITPro,
        telefonoProveedor = teleProveedor,
        direccionProveedor = direcProveedor,
        correoProveedor = correoPro,
        razonSocial = razSocial,
        contactoPrincipal = contacPrincipal,
        paginaWeb = pageWeb
    where
        codigoProveedor = codeProveedor;
end $$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_actualizarProveedores(2, 'Esteban', 'Molina', '487158', '35471', 'Zona 12', 'Freegol@gmail.com', 'Programa x', 'Si bro', 'www.Freegol.com');

-- ---------------------------------------------------------------------------------------------------------------------------
