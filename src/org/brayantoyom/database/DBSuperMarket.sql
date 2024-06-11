
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

call sp_agregarClientes(1, 'Enrique', 'Arriaga', '84791', '47951', 'Zona 1', 'earriaga@gmail.com');

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

call sp_buscarClientes(2);

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

call sp_buscarTipoProducto(1);

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

call sp_listarProveedores	();

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

call sp_agregarProductos(1, 'Computadora de escritorio', 550.00, 2.00, 300.00, 50, 1, 1);

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

call sp_actualizarProducto(50, 'Descripción del producto', 9.00, 12.00, 45.00, 150, 2, 2);

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

-- ------------------------------------------------------------------------------------------------------------------------------

delimiter $$

create procedure sp_eliminarFactura(in numFactura int)
begin
    delete from Factura where numeroFactura = numFactura;
end$$

delimiter ;

call sp_eliminarFactura(1);

-- -----------------------------------------------------------------------------------------------------------

Delimiter $$
	create function fn_CalcularPrecioUnitario(codigoProducto varchar(15)) returns decimal(10,2)
	reads sql data deterministic
    Begin
		Declare precioUnitario decimal(10,2);
        Select (DC.costoUnitario)
        into precioUnitario 
        from  DetalleCompra DC where DC.codigoProducto = codigoProducto;
        
        return precioUnitario + (precioUnitario * 0.40);
    End $$
Delimiter ;

-- ---------------------------------------------------------------------------------------------------------

Delimiter $$
	create function fn_CalcularPrecioDocena(codigoProducto varchar(15)) returns decimal(10,2)
    reads sql data deterministic
    Begin
		Declare precioDocena decimal(10,2);
        Select (DC.costoUnitario)
        into precioDocena
        from DetalleCompra DC where DC.codigoProducto = codigoProducto;
        return precioDocena + (precioDocena * 0.35);
    End $$
Delimiter ;

Delimiter $$
	create function fn_CalcularPrecioMayor(codigoProducto varchar(15)) returns decimal(10,2)
    reads sql data deterministic
    Begin
		Declare precioMayor decimal(10,2);
        Select (DC.costoUnitario)
        into precioMayor
        from DetalleCompra DC where DC.codigoProducto = codigoProducto;
        return precioMayor + (precioMayor * 0.25);
    End $$
Delimiter ;
Delimiter $$
	create procedure sp_AsignarPrecios(in codigoProducto varchar(15))
    Begin
		Declare _precioDocena decimal(10,2);
		Declare _precioUnitario decimal(10,2);
        Declare _precioMayor decimal(10,2);
        set _precioMayor = fn_CalcularPrecioMayor(codigoProducto);
        set _precioUnitario = fn_CalcularPrecioUnitario(codigoProducto);
        set _precioDocena = fn_CalcularPrecioDocena(codigoProducto);
        
        Update Productos P
        set
        P.precioUnitario = _precioUnitario,
        P.precioDocena = _precioDocena,
        P.precioMayor = _precioMayor
        where P.codigoProducto = codigoProducto; 
    End $$
Delimiter ;

Delimiter $$
	Create Trigger tr_DetalleCompra_After_Update
    After Update on DetalleCompra
    for each row
    Begin
        call sp_AsignarPrecios(NEW.codigoProducto);
    End $$
Delimiter ;

Delimiter $$
	Create Trigger tr_DetalleCompra_After_Insert
    After Insert on DetalleCompra
    for each row
    Begin
        call sp_AsignarPrecios(NEW.codigoProducto);
    End $$
Delimiter ;

Delimiter $$
	create function fn_TotalCompras( numeroDocumento int)
	returns decimal(10,2)
    reads sql data deterministic
    Begin
		declare totalDocumento decimal(10,2);
        Select SUM(DC.costoUnitario * DC.cantidad) into totalDocumento from  DetalleCompra DC where DC.numeroDocumento = numeroDocumento;
		
        return totalDocumento;
	End $$
Delimiter ;

Delimiter $$
	create procedure sp_AsignarTotalCompras(in numeroDocumento int)
    Begin
		Declare _totalDocumento decimal(10,2);
        set _totalDocumento = fn_TotalCompras(numeroDocumento);
        
        Update Compras C
        set
        C.totalDocumento = _totalDocumento
        where C.numeroDocumento = numeroDocumento; 
    End $$
Delimiter ;

Delimiter $$
	Create Trigger tr_DetalleComprasTotal_After_Insert
    After Insert on DetalleCompra
    for each row
    Begin
		call sp_AsignarTotalCompras(new.numeroDocumento);
	End $$
Delimiter ;	

Delimiter $$
	create procedure sp_AgregarExistencia(codigoProducto varchar(15),cantidad int)
    Begin
		update Productos P
        set
			P.existencia = cantidad
		where P.codigoProducto = codigoProducto;
    End $$
Delimiter ;

Delimiter $$
	Create Trigger tr_DetalleCompraExistencia_After_Insert
    After Insert on DetalleCompra
    for each row
    Begin
		call sp_AgregarExistencia(NEW.codigoProducto,NEW.cantidad);
    End $$
Delimiter ;

Delimiter $$
	Create Trigger tr_DetalleCompraExistencia_After_Update
    After Update on DetalleCompra
    for each row
    Begin
		call sp_AgregarExistencia(NEW.codigoProducto,NEW.cantidad);
    End $$
Delimiter ;


