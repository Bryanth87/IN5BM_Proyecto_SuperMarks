
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

-- ----------------------------------------------

create table Productos (
    codigoProducto varchar(15) primary key,
    descripProducto varchar(45),
    precioUnitario decimal(10,2),
    precioDocena decimal(10,2),
    precioMayor decimal(10,2),
    existencia int,
    codigoTipoProducto int,
    codigoProveedor int,
    Foreign key (codigoTipoProducto) references TipoProducto(codigoTipoProducto),
    Foreign key (codigoProveedor) references Proveedores(codigoProveedor)
);

-- ------------------------------------------------

create table Empleados (
    codigoEmpleado int primary key,
    nombresEmpleado varchar(45),
    apellidosEmpleado varchar(45),
    sueldoEmpleado decimal(10,2),
    direccionEmpleado varchar(150),
    turnoEmpleado varchar(15),
    codigoCargoEmpleado int,
    Foreign key (codigoCargoEmpleado) references CargoEmpleado(codigoCargoEmpleado)
);

-- ------------------------------------------------

create table Factura (
    numeroFactura int primary key,
    estadoFactura varchar(45),
    totalFactura decimal(10,2),
    fechaFactura varchar(45),
    codigoCliente int,
    codigoCargoEmpleado int,
    Foreign key (codigoCliente) references Clientes(codigoCliente),
    Foreign key (codigoCargoEmpleado) references CargoEmpleado(codigoCargoEmpleado)
);

-- ------------------------------------------------

create table DetalleFactura (
    codigoDetalleFactura int primary key,
    precioUnitario decimal(10,2),
    cantidadDetalleFactura int,
    numeroFactura int,
    codigoProducto varchar(15),
    Foreign key (numeroFactura) references Factura(numeroFactura),
    Foreign key (codigoProducto) references Productos(codigoProducto)
);

-- ------------------------------------------------

create table DetalleCompra (
    codigoDetalleCompra int primary key,
    costoUnitario decimal(10,2),
    cantidadDetallaCompra int,
    codigoProducto varchar(15),
    numDocumento int,
    Foreign key (codigoProducto) references Productos(codigoProducto),
    Foreign key (numDocumento) references Compras(numDocumento)
);

-- ------------------------------------------------

create table TelefonoProveedor (
    codigoTelefonoProveedor int primary key,
    numeroPrincipal varchar(8),
    numeroSecundario varchar(8),
    observaciones varchar(45),
    codigoProveedor int,
    Foreign key (codigoProveedor) references Proveedores(codigoProveedor)
);

-- ------------------------------------------------

create table EmailProveedor (
    codigoEmailProveedor int primary key,
    emailProveedor varchar(45),
    descripcionEmailProveedor varchar(100),
    codigoProveedor int,
    Foreign key (codigoProveedor) references Proveedores(codigoProveedor)
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

-- ---------------------------- Productos -----------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_agregarProductos(
in codeProducto varchar(15),
in descriProduc varchar(45), 
in precioUni decimal(10,2), 
in precioDoce decimal(10,2),
in precioMay decimal(10,2), 
in existencias int, 
in codeTipoProducto int, 
in codeProveedor int

)
begin
    insert into Productos (codigoProducto, descripProducto, precioUnitario, precioDocena, precioMayor, existencia, codigoTipoProducto, codigoProveedor)
    values (codeProducto, descriProduc, precioUni, precioDoce, precioMay, existencias, codeTipoProducto, codeProveedor);
    
end$$
delimiter ;

-- ----------------------------------------------------------------------------------------

call sp_agregarProductos('50', 'Computadora de escritorio', 550.00, 2.00, 0.00, 50, 1, 1);

-- ----------------------------------------------------------------------------------------

delimiter $$
create procedure sp_listarProductos()
begin
    select codigoProducto, descripProducto, precioUnitario, precioDocena, precioMayor, existencia, codigoTipoProducto, codigoProveedor from Productos;
end$$
delimiter ;

-- ----------------------------------------------------------------------------------------

call sp_listarProductos();

-- ----------------------------------------------------------------------------------------

delimiter $$

create procedure sp_buscarProductos(in codeProducto varchar(15))
begin
    select * from Productos where codigoProducto = codeProducto;
end$$

delimiter ;

-- ----------------------------------------------------------------------------------------

call sp_buscarProductos('49');

-- ----------------------------------------------------------------------------------------

Delimiter $$

Create procedure sp_actualizarProducto(
    in codeProducto varchar(15), 
    in descProducto varchar(45), 
    in precUnitario decimal(10,2),
    in precDoce decimal(10,2), 
    in precMay decimal(10,2), 
    in existenciaPro int, 
    in codeTipoProducto int, 
    in codeProveedor int
)
Begin
    update Productos
    set
        descripProducto = descProducto,
        precioUnitario = precUnitario,
        precioDocena = precDoce,
        precioMayor = precMay,
        existencia = existenciaPro,
        codigoTipoProducto = codeTipoProducto,
        codigoProveedor = codeProveedor
    where
        codigoProducto = codeProducto;
end$$

Delimiter ;

call sp_actualizarProducto('8791', 'Descripción del producto', 9.00, 12.00, 45.00, 150, 2, 2);

-- ----------------------------------------------------------------------------------------

delimiter $$

create procedure sp_eliminarProductos(in codeProducto varchar(15))
begin
    delete from Productos where codigoTipoProducto = codeProducto;
end$$

delimiter ;

-- ------------------------------ ----------------------------------------------------------

call sp_EliminarProductos('4');

-- -----------------------Empleados------------------------------------------------------------------

delimiter $$

create procedure sp_agregarEmpleados(
in codeEmpleados int,
in nombEmpleado varchar(45), 
in apelEmpleado varchar(45), 
in sueldoEmple decimal(10,2),
in direccionEmple varchar(150), 
in turnoEmple varchar(15), 
in codeCargoEmpleado int
)
begin
    insert into Empleados (codigoEmpleado, nombresEmpleado, apellidosEmpleado, sueldoEmpleado, direccionEmpleado, turnoEmpleado, codigoCargoEmpleado)
    values (codeEmpleados, nombEmpleado, apelEmpleado, sueldoEmple, direccionEmple, turnoEmple, codeCargoEmpleado);
end$$

delimiter ;
 
-- -------------------------------------------------------------------------------

call sp_agregarEmpleados(1,'Fernando', 'Mendez', 2200.00, 'Zona 9', 'Si', 1);

-- -------------------------------------------------------------------------------

delimiter $$

create procedure sp_listarEmpleados()
begin
    select codigoEmpleado, nombresEmpleado, apellidosEmpleado, sueldoEmpleado, direccionEmpleado, turnoEmpleado, codigoCargoEmpleado from Empleados;
end$$

delimiter ;

-- --------------------------------------------------------------------------------

call sp_listarEmpleados();

-- --------------------------------------------------------------------------------

delimiter $$

create procedure sp_buscarEmpleados(in codeEmpleado int)
begin
    select * from Empleados where codigoEmpleado = codeEmpleado;
end$$

delimiter ;

-- --------------------------------------------------------------------------------

call sp_BuscarProductos(1);

-- --------------------------------------------------------------------------------

delimiter $$

create procedure sp_actualizarEmpleados(
    in codeEmpleado int, 
    in nombEmpleado varchar(45), 
    in apelEmpleado varchar(45),
    in suelEmpleado decimal(10,2), 
    in direcEmpleado varchar(150),
    in turnoEmple varchar(15),
    in codeCargoEmpleado int)
begin
    update Empleados
    set
        nombresEmpleado = nombEmpleado,
        apellidosEmpleado = apelEmpleado,
        sueldoEmpleado = suelEmpleado,
        direccionEmpleado = direcEmpleado,
        codigoCargoEmpleado = codeCargoEmpleado
    where
        codigoCargoEmpleado = codeCargoEmpleado;
end$$

delimiter ;

-- ----------------------------------------------------------------------------

delimiter $$

create procedure sp_eliminarEmpleados(in codeEmpleado int)
begin
    delete from Empleados where codigoEmpleado = codeEmpleado;
end$$

delimiter ;

-- --------------------------Factura----------------------------------------------------

delimiter $$

create procedure sp_agregarFactura(
    in numFactura int, 
    in estaFac varchar(45), 
    in totFac decimal(10,2), 
    in fecFac varchar(45), 
    in codeCliente int, 
    in codeEmpleado int
)
begin
    insert into Factura (numeroFactura, estadoFactura, totalFactura, fechaFactura, codigoCliente, codigoCargoEmpleado)
    values (numFactura, estaFac, totFac, fecFac, codeCliente, codeEmpleado);
end$$

delimiter ;

-- -----------------------------------------------------------

call sp_AgregarFactura(1, 'Pendiente', 150.75, '2024-05-16', 2, 2);

-- -----------------------------------------------------------

delimiter $$

create procedure sp_listarFactura()
begin
    select numeroFactura, estadoFactura, totalFactura, fechaFactura, codigoCliente, codigoCargoEmpleado from Factura;
end$$

delimiter ;

-- -----------------------------------------------------------

call sp_listarFactura();

-- -----------------------------------------------------------

delimiter $$

create procedure sp_buscarFactura(in numFactura int)
begin
    select * from Factura where numeroFactura = numFactura;
end$$

delimiter ;

-- ----------------------------------------------------------

call sp_buscarFactura(1);

-- -----------------------------------------------------------
delimiter $$

create procedure sp_actualizarFactura(
    in numFactura int, 
    in estafac varchar(45), 
    in totalFac decimal(10,2),
    in fechaFac varchar(45), 
    in codeCliente int, 
    in codeEmpleado int)
begin
    update Factura
    set
        estadoFactura = estado,
        totalFactura = totalFac,
        fechaFactura = fechaFac,
        codigoCliente = codeCliente,
        codigoCargoEmpleado = codeEmpleado
    where
        numeroFactura = numFactura;
end$$

delimiter ;

-- ----------------------------------------------------------------------

call sp_actualizarFactura(2, 'Ocupado', 3500.00, '2024-04-16', 2, 2);

-- -----------------------------------------------------------------------

delimiter $$

create procedure sp_eliminarFactura(in numFactura int)
begin
    delete from Factura where numeroFactura = numFactura;
end$$

delimiter ;

call sp_eliminarFactura(1);

-- -----------------------------DetalleFactura------------------------------------------------

delimiter $$

create procedure sp_AgregarDetalleFactura(in IDDetalleFactura int,in precioUnitario decimal(10,2), in cantidad int, in numFactura int,in IDProductos varchar(15)
)
begin
    insert into DetalleFactura (IDDetalleFactura, precioUnitario, cantidad, numFactura, IDProductos)
    values (IDDetalleFactura, precioUnitario, cantidad, numFactura, IDProductos);
end$$

delimiter ;

call sp_AgregarDetalleFactura(1, 1500.75, 2, 2, 'P002');
call sp_AgregarDetalleFactura(2, 150.75, 10, 2, 'P002');

delimiter $$
create procedure sp_ListarDetalleFactura()
begin
    select IDDetalleFactura, precioUnitario, cantidad, numFactura, IDProductos from DetalleFactura;
end$$
delimiter ;

call sp_ListarDetalleFactura();

delimiter $$

create procedure sp_BuscarDetalleFactura(in _IDDetalleFactura int)
begin
    select * from DetalleFactura where IDDetalleFactura = _IDDetalleFactura;
end$$

delimiter ;

call sp_BuscarDetalleFactura(1);

delimiter $$

create procedure sp_ActualizarDetalleFactura(
    in _IDDetalleFactura int,in precioUnitario decimal(10,2), in cantidad int, in numFactura int,in IDProductos varchar(15))
begin
    update DetalleFactura
    set
        precioUnitario = precioUnitario,
        cantidad = cantidad,
        numFactura = numFactura,
        IDProductos = IDProductos
    where
        IDDetalleFactura = _IDDetalleFactura;
end$$

delimiter ;

call sp_ActualizarDetalleFactura(2, 1500.00, 4, 2, 'P002');

delimiter $$

create procedure sp_EliminarDetalleFactura(in _IDDetalleFactura int)
begin
    delete from DetalleFactura where IDDetalleFactura = _IDDetalleFactura;
end$$

delimiter ;

call sp_EliminarDetalleFactura(1);

DELIMITER $$

CREATE TRIGGER CantidadTotalInsertar AFTER INSERT ON DetalleFactura
FOR EACH ROW
BEGIN
    UPDATE Productos
    SET existencia = existencia - NEW.cantidad
    WHERE IDProductos = NEW.IDProductos;
END
$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER CantidadTotalEliminar AFTER DELETE ON DetalleFactura
FOR EACH ROW
BEGIN
    UPDATE Productos
    SET existencia = existencia + OLD.cantidad
    WHERE IDProductos = OLD.IDProductos;
END
$$

DELIMITER ;

DELIMITER $$
CREATE TRIGGER CantidadTotalActualizar AFTER UPDATE ON DetalleFactura
FOR EACH ROW
BEGIN
    DECLARE distincion INT;
    SET distincion = NEW.cantidad - OLD.cantidad;
    
    UPDATE Productos
    SET existencia = existencia - distincion
    WHERE IDProductos = NEW.IDProductos;
END
$$

DELIMITER ;

-- DetalleCompra
 
 delimiter $$

create procedure sp_AgregarDetalleCompra(in IDDetalleCompra int,in costoUnitario decimal(10,2), in cantidad int, in IDProductos varchar(15),in numDocumento int
)
begin
    insert into DetalleCompra (IDDetalleCompra, costoUnitario, cantidad, IDProductos, numDocumento)
    values (IDDetalleCompra, costoUnitario, cantidad, IDProductos, numDocumento);
end$$

delimiter ;

call sp_AgregarDetalleCompra(1, 15, 15, 'P002', 2);
call sp_AgregarDetalleCompra(2, 25, 10, 'P002', 2);

delimiter $$
create procedure sp_ListarDetalleCompra()
begin
    select IDDetalleCompra, costoUnitario, cantidad, IDProductos, numDocumento from DetalleCompra;
end$$
delimiter ;

call sp_ListarDetalleCompra();

delimiter $$

create procedure sp_BuscarDetalleCompra(in _IDDetalleCompra int)
begin
    select * from DetalleCompra where IDDetalleCompra = _IDDetalleCompra;
end$$

delimiter ;

call sp_BuscarDetalleCompra(1);

delimiter $$

create procedure sp_ActualizarDetalleCompra(
    in _IDDetalleCompra int,in costoUnitario decimal(10,2), in cantidad int, in IDProductos varchar(15),in numDocumento int)
begin
    update DetalleCompra
    set
        costoUnitario = costoUnitario,
        cantidad = cantidad,
        IDProductos = IDProductos,
        numDocumento = numDocumento
    where
        IDDetalleCompra = _IDDetalleCompra;
end$$

delimiter ;

call sp_ActualizarDetalleCompra(2,15, 7, 'P002', 2);

delimiter $$

create procedure sp_EliminarDetalleCompra(in _IDDetalleCompra int)
begin
    delete from DetalleCompra where IDDetalleCompra = _IDDetalleCompra;
end$$

delimiter ;

call sp_EliminarDetalleCompra(1);

DELIMITER $$
CREATE TRIGGER CFCompra AFTER INSERT ON DetalleCompra
FOR EACH ROW
BEGIN
    UPDATE Compras
    SET totalDocumento = totalDocumento + NEW.costoUnitario * NEW.cantidad
    WHERE numDocumento = NEW.numDocumento;
END
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER CFCompraActualizar AFTER UPDATE ON DetalleCompra
FOR EACH ROW
BEGIN
    UPDATE Compras
    SET totalDocumento = totalDocumento + (NEW.costoUnitario * NEW.cantidad) - (OLD.costoUnitario * OLD.cantidad)
    WHERE numDocumento = NEW.numDocumento;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER CFCompraEliminar AFTER DELETE ON DetalleCompra
FOR EACH ROW
BEGIN
    UPDATE Compras
    SET totalDocumento = totalDocumento - OLD.costoUnitario * OLD.cantidad
    WHERE numDocumento = OLD.numDocumento;
END
$$
DELIMITER ;

-- TelefonoProveedor
 
 delimiter $$

create procedure sp_AgregarTelefonoProveedor(in IDTelefonoProveedor int,in numeroPrincipal varchar(8), in numeroSecundario varchar(8), in observaciones varchar(45),in IDProveedor int
)
begin
    insert into TelefonoProveedor (IDTelefonoProveedor, numeroPrincipal, numeroSecundario, observaciones, IDProveedor)
    values (IDTelefonoProveedor, numeroPrincipal, numeroSecundario, observaciones, IDProveedor);
end$$

delimiter ;

call sp_AgregarTelefonoProveedor(1, '25698535', '14526987', 'Son ambos numeros personales', 2);
call sp_AgregarTelefonoProveedor(2, '12345678', '87654321', 'Son ambos numeros personales', 2);

delimiter $$
create procedure sp_ListarTelefonoProveedor()
begin
    select IDTelefonoProveedor, numeroPrincipal, numeroSecundario, observaciones, IDProveedor from TelefonoProveedor;
end$$
delimiter ;

call sp_ListarTelefonoProveedor();

delimiter $$

create procedure sp_BuscarTelefonoProveedor(in _IDTelefonoProveedor int)
begin
    select * from TelefonoProveedor where IDTelefonoProveedor = _IDTelefonoProveedor;
end$$

delimiter ;

call sp_BuscarTelefonoProveedor(1);

delimiter $$

create procedure sp_ActualizarTelefonoProveedor(
    in _IDTelefonoProveedor int,in numeroPrincipal varchar(8), in numeroSecundario varchar(8), in observaciones varchar(45),in IDProveedor int)
begin
    update TelefonoProveedor
    set
        numeroPrincipal = numeroPrincipal,
        numeroSecundario = numeroSecundario,
        observaciones = observaciones,
        IDProveedor = IDProveedor
    where
        IDTelefonoProveedor = _IDTelefonoProveedor;
end$$

delimiter ;

call sp_ActualizarTelefonoProveedor(2, '25698535', '14526987', 'Son ambos numeros personales', 2);

delimiter $$

create procedure sp_EliminarTelefonoProveedor(in _IDTelefonoProveedor int)
begin
    delete from TelefonoProveedor where IDTelefonoProveedor = _IDTelefonoProveedor;
end$$

delimiter ;

call sp_EliminarTelefonoProveedor(1);

-- EmailProveedor
 
 delimiter $$

create procedure sp_AgregarEmailProveedor(in IDEmailProveedor int,in emailProveedor varchar(45), in descripcion varchar(100), in IDProveedor int
)
begin
    insert into EmailProveedor (IDEmailProveedor, emailProveedor, descripcion, IDProveedor)
    values (IDEmailProveedor, emailProveedor, descripcion, IDProveedor);
end$$

delimiter ;

call sp_AgregarEmailProveedor(1, 'fgarcia@hotmail', 'correo Personal', 2);
call sp_AgregarEmailProveedor(2, 'fSicajau@hotmail', 'correo de empresa', 2);

delimiter $$
create procedure sp_ListarEmailProveedor()
begin
    select IDEmailProveedor, emailProveedor, descripcion, IDProveedor from EmailProveedor;
end$$
delimiter ;

call sp_ListarEmailProveedor();

delimiter $$

create procedure sp_BuscarEmailProveedor(in _IDEmailProveedor int)
begin
    select * from EmailProveedor where IDEmailProveedor = _IDEmailProveedor;
end$$

delimiter ;

call sp_BuscarEmailProveedor(1);

delimiter $$

create procedure sp_ActualizarEmailProveedor(
    in _IDEmailProveedor int,in emailProveedor varchar(45), in descripcion varchar(100), in IDProveedor int)
begin
    update EmailProveedor
    set
        emailProveedor = emailProveedor,
        descripcion = descripcion,
        IDProveedor = IDProveedor
    where
        IDEmailProveedor = _IDEmailProveedor;
end$$

delimiter ;

call sp_ActualizarEmailProveedor(2, 'fgarcia@hotmail', 'correo Personal', 2);

delimiter $$

create procedure sp_EliminarEmailProveedor(in _IDEmailProveedor int)
begin
    delete from EmailProveedor where IDEmailProveedor = _IDEmailProveedor;
end$$

delimiter ;

call sp_EliminarEmailProveedor(1);



