
set global time_zone = '-6:00';
drop database if exists DBSuperMarket;
create database DBSuperMarket;
use DBSuperMarket;

create table Clientes (

	IDClientes int primary key,
    nombreClientes varchar (50),
    apellidosClientes varchar (50),
	NITClientes varchar (10),
	telefonoClientes varchar (45),
	direccionClientes varchar(150),
	correoClientes varchar (45)

);
 -- ----------------------------------------------
 
create table CargoEmpleado (

	IDCargoEmpleado int primary key,
    nombreCargo varchar (45),
    descripcionCargo varchar (45)
    
);

-- ----------------------------------------------

create table TipoProducto(

	IDTipoProducto int primary key,
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

	IDProveedor int primary key,
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

create procedure sp_AgregarClientes(in IDClientes int,in nombreClientes varchar(50), in apellidosClientes varchar(50), in NITClientes varchar(10),in telefonoClientes varchar(45), in direccionClientes varchar(150), in correoClientes varchar(45)
)
begin
    insert into Clientes (IDClientes, nombreClientes, apellidosClientes, NITClientes, telefonoClientes, direccionClientes, correoClientes)
    values (IDClientes, nombreClientes, apellidosClientes, NITClientes, telefonoClientes, direccionClientes, correoClientes);
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_AgregarClientes(1, 'Enrique', 'Arriaga', '84791', '47951', 'Zona 1', 'earriaga@gmail.com');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_ListarClientes()
begin
    select IDClientes, nombreClientes, apellidosClientes, NITClientes, telefonoClientes, direccionClientes, correoClientes from Clientes;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_ListarClientes();

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_BuscarClientes(in _IDClientes int)
begin
    select * from Clientes where IDClientes = _IDClientes;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_BuscarClientes(2);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_ActualizarClientes(
    in _IDClientes int, in nombreClientes varchar(50), in apellidosClientes varchar(50),
    in NITClientes varchar(10), in telefonoClientes varchar(150), in direccionClientes varchar(150),
    in correoClientes varchar(45))
begin
    update Clientes
    set
        NITClientes = NITClientes,
        nombreClientes = nombreClientes,
        apellidosClientes = apellidosClientes,
        direccionClientes = direccionClientes,
        telefonoClientes = telefonoClientes,
        correoClientes = correoClientes
    where
        IDClientes = _IDClientes;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_ActualizarClientes(1, 'Junior', 'Hernandez', '478423', '8794', 'Zona 9', 'jhernandez@gmail.com');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_EliminarClientes(in _IDClientes int)
begin
    delete from Clientes where IDClientes = _IDClientes;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_EliminarClientes(1);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_AgregarCargoEmpleado(
    in IDCargoEmpleado int, in nombreCargo varchar(45), in descripcionCargo varchar(45)
)
begin
    insert into CargoEmpleado (IDCargoEmpleado,nombreCargo, descripcionCargo)
    values (IDCargoEmpleado,nombreCargo, descripcionCargo);
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_AgregarCargoEmpleado(1, 'Gerente', 'Es de ventas');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_ListarCargoEmpleado()
begin
    select IDCargoEmpleado, nombreCargo,descripcionCargo from CargoEmpleado;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_ListarCargoEmpleado();

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_BuscarCargoEmpleado(in _IDCargoEmpleado int)
begin
    select * from CargoEmpleado where IDCargoEmpleado = _IDCargoEmpleado;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_BuscarCargoEmpleado(2);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_ActualizarCargoEmpleado(
    in _IDCargoEmpleado int, in nombreCargo varchar(45), in descripcionCargo varchar(45)
)
begin
    update CargoEmpleado
    set
        nombreCargo = nombreCargo,
        descripcionCargo = descripcionCargo
    where
        IDCargoEmpleado = _IDCargoEmpleado;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_ActualizarCargoEmpleado(2, 'Suplente', 'Encargado');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_EliminarCargoEmpleado(in _IDCargoEmpleado int)
begin
    delete from CargoEmpleado where IDCargoEmpleado = _IDCargoEmpleado;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_EliminarCargoEmpleado(1);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_AgregarTipoProducto(
    in IDTipoProducto int, in descripcion varchar(45)
)
begin
    insert into TipoProducto (IDTipoProducto,descripcion)
    values (IDTipoProducto,descripcion);
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_AgregarTipoProducto(1, 'Computadoras de Corea del Sur');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_ListarTipoProducto()
begin
    select IDTipoProducto, descripcion from TipoProducto;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_ListarTipoProducto();

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_BuscarTipoProducto(in _IDTipoProducto int)
begin
    select * from TipoProducto where IDTipoProducto = _IDTipoProducto;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_BuscarTipoProducto(2);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_ActualizarTipoProducto(
    in _IDTipoProducto int, in descripcion varchar(45)
)
begin
    update TipoProducto
    set
        descripcion = descripcion
    where
        IDTipoProducto = _IDTipoProducto;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_ActualizarTipoProducto(2, 'Carros de Japón');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_EliminarTipoProducto(in _IDTipoProducto int)
begin
    delete from TipoProducto where IDTipoProducto = _IDTipoProducto;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_EliminarTipoProducto(1);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_AgregarCompra(
	in numDocumento int,
    in fechaDocumento date,
    in descripcion varchar(60),
    in totalDocumento decimal(20,2)
)
begin
    insert into Compras (numDocumento,fechaDocumento, descripcion, totalDocumento)
    values (numDocumento,fechaDocumento, descripcion, totalDocumento);
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_AgregarCompra(1, '2019-07-08', 'Compra de herramientas', 450.00);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_ListarCompras()
begin
    select numDocumento,fechaDocumento,descripcion,totalDocumento from Compras;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_ListarCompras();

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_BuscarCompra(in _numDocumento int)
begin
    select * from Compras where numDocumento = _numDocumento;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_BuscarCompra(2);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_ActualizarCompra(
    in _numDocumento int,
    in fechaDocumento date,
    in descripcion varchar(60),
    in totalDocumento decimal(20,2)
)
begin
    update Compras
    set
        fechaDocumento = fechaDocumento,
        descripcion = descripcion,
        totalDocumento = totalDocumento
    where
        numDocumento = _numDocumento;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_ActualizarCompra(2, '2085-06-08', 'Compra de imanes', 950.00);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_EliminarCompra(in _numDocumento int)
begin
    delete from Compras where numDocumento = _numDocumento;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_EliminarCompra(3);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_AgregarProveedor (
    in IDProveedor int,
    in nombresProveedor varchar(50),
    in apellidosProveedor varchar(50),
    in NITProveedor varchar(10),
    in telefonoProveedor varchar(45),
    in direccionProveedor varchar(150),
    in correoProveedor varchar(45),
    in razonSocial varchar(45),
    in contactoPrincipal varchar(100),
    in paginaWeb varchar(45))
begin
    insert into Proveedores (IDProveedor, nombresProveedor, apellidosProveedor, NITProveedor, telefonoProveedor, direccionProveedor, correoProveedor, razonSocial, contactoPrincipal, paginaWeb)
    values (IDProveedor, nombresProveedor, apellidosProveedor, NITProveedor, telefonoProveedor, direccionProveedor, correoProveedor, razonSocial, contactoPrincipal, paginaWeb);
end $$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_AgregarProveedor(1, 'Iman de calidad', 'S.A.', '84897', '65471', 'Zona 10, calle 1', 'iman@gmail.com' , 'Iman de calidad', 'Eduardo Melina', 'www.iman.com');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_ListarProveedores()
begin
    select
        IDProveedor,
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

call sp_ListarProveedores();

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_BuscarProveedor (in _IDProveedor int)
begin
    select
        IDProveedor,
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
        IDProveedor = _IDProveedor;
end $$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_BuscarProveedor(1);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_EliminarProveedor (in _IDProveedor int)
begin
    delete from Proveedores
    where IDProveedor = _IDProveedor;
end $$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_EliminarProveedor(1);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_ActualizarProveedores(
    in _IDProveedor int,
    in nombresProveedor varchar(50),
    in apellidosProveedor varchar(50),
    in NITProveedor varchar(10),
    in telefonoProveedor varchar(45),
    in direccionProveedor varchar(150),
    in correoProveedor varchar(45),
    in razonSocial varchar(45),
    in contactoPrincipal varchar(100),
    in paginaWeb varchar(45))
begin
    update Proveedores
    set
        nombresProveedor = nombresProveedor,
        apellidosProveedor = apellidosProveedor,
        NITProveedor = NITProveedor,
        telefonoProveedor = telefonoProveedor,
        direccionProveedor = direccionProveedor,
        correoProveedor = correoProveedor,
        razonSocial = razonSocial,
        contactoPrincipal = contactoPrincipal,
        paginaWeb = paginaWeb
    where
        IDProveedor = _IDProveedor;
end $$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

 call sp_ActualizarProveedores(2, 'Esteban', 'Molina', '487158', '35471', 'Zona 12', 'Freegol@gmail.com' , 'Programa x', 'Si bro' , 'www.Freegol.com');
 
 -- ---------------------------------------------------------------------------------------------------------------------------
