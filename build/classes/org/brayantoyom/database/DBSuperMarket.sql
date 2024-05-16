
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

create procedure sp_agregarClientes(
    in _codigoCliente int, in _nombresClientes varchar(50), in _apellidosCliente varchar(50),
    in _NITCliente varchar(10), in _telefonoCliente varchar(45), in _direccionCliente varchar(150),
    in _correoCliente varchar(45)
)
begin
    insert into Clientes (codigoCliente, nombresClientes, apellidosCliente, NITCliente, telefonoCliente, direccionCliente, correoCliente)
    values (_codigoCliente, _nombresClientes, _apellidosCliente, _NITCliente, _telefonoCliente, _direccionCliente, _correoCliente);
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

create procedure sp_buscarClientes(in _codigoCliente int)
begin
    select * from Clientes where codigoCliente = _codigoCliente;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_BuscarClientes(2);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_actualizarClientes(
    in _codigoCliente int, in _nombresClientes varchar(50), in _apellidosCliente varchar(50),
    in _NITCliente varchar(10), in _telefonoCliente varchar(45), in _direccionCliente varchar(150),
    in _correoCliente varchar(45)
)
begin
    update Clientes
    set
        NITCliente = _NITCliente,
        nombresClientes = _nombresClientes,
        apellidosCliente = _apellidosCliente,
        direccionCliente = _direccionCliente,
        telefonoCliente = _telefonoCliente,
        correoCliente = _correoCliente
    where
        codigoCliente = _codigoCliente;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_ActualizarClientes(1, 'Junior', 'Hernandez', '478423', '8794', 'Zona 9', 'jhernandez@gmail.com');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_eliminarClientes(in _codigoCliente int)
begin
    delete from Clientes where codigoCliente = _codigoCliente;
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

call sp_buscarCargoEmpleado(2);

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

call sp_actualizarCargoEmpleado(2, 'Suplente', 'Encargado');

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
    select * from TipoProducto where codeTipoProducto = codeTipoProducto;
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
        IDTipoProducto = codeTipoProducto;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_actualizarTipoProducto(2, 'Carros de Japón');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_eliminarTipoProducto(in codeTipoProducto int)
begin
    delete from TipoProducto where IDTipoProducto = codeTipoProducto;
end$$

delimiter ;	

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_eliminarTipoProducto(1);


-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_agregarCompra(
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

create procedure sp_buscarCompra(in _numDocumento int)
begin
    select * from Compras where numDocumento = _numDocumento;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_buscarCompra(2);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_actualizarCompra(
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

call sp_actualizarCompra(2, '2085-06-08', 'Compra de imanes', 950.00);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_eliminarCompra(in _numDocumento int)
begin
    delete from Compras where numDocumento = _numDocumento;
end$$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_eliminarCompra(3);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_agregarProveedor (
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

call sp_agregarProveedor(1, 'Iman de calidad', 'S.A.', '84897', '65471', 'Zona 10, calle 1', 'iman@gmail.com' , 'Iman de calidad', 'Eduardo Melina', 'www.iman.com');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_listarProveedores()
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

call sp_listarProveedores();

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_buscarProveedor (in _IDProveedor int)
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

call sp_buscarProveedor(1);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_eliminarProveedor (in _IDProveedor int)
begin
    delete from Proveedores
    where IDProveedor = _IDProveedor;
end $$

delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_eliminarProveedor(1);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_actualizarProveedores(
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

 call sp_actualizarProveedores(2, 'Esteban', 'Molina', '487158', '35471', 'Zona 12', 'Freegol@gmail.com' , 'Programa x', 'Si bro' , 'www.Freegol.com');
 
 -- ---------------------------------------------------------------------------------------------------------------------------
