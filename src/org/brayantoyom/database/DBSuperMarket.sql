
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

create table Proveedores
(
    codigoProveedor int not null primary key,
    NITProveedor varchar (10),
    nombresProveedor varchar(60),
    apellidosProveedor varchar(60),
    direccionProveedor varchar(150),
    razonSocial varchar(60),
    contactoPrincipal varchar(100),
    paginaWeb varchar(50)
    
);

-- ----------------------------------------------

create table Productos
(
	codigoProducto varchar(15) primary key,
	descripcionProducto varchar(45),
    precioUnitario decimal(10,2),
    precioDocena decimal(10,2),
    precioMayor decimal(10,2),
    existencia int not null,
    codigoTipoProducto int not null,
    codigoProveedor int not null,
	foreign key (codigoTipoProducto) references TipoProducto(codigoTipoProducto) on delete cascade,
	foreign key (codigoProveedor) references Proveedores(codigoProveedor) on delete cascade
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

call sp_ActualizarClientes(2, 'Junior', 'Hernandez', '478423', '8794', 'Zona 9', 'jhernandez@gmail.com');

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

create procedure sp_agregarProveedores (in codPro int, in NPro varchar(10), in nomPro varchar(60), in apePro varchar(60), 
in direPro varchar(150), in rsPro varchar(60), in conprinPro varchar(100), in pwPro varchar(50))
begin
	insert into Proveedores (Proveedores.codigoProveedor, Proveedores.NITProveedor, Proveedores.nombresProveedor,
    Proveedores.apellidosProveedor, Proveedores.direccionProveedor, Proveedores.razonSocial, Proveedores.contactoPrincipal,
    Proveedores.paginaWeb)
    values (codPro, NPro, nomPro, apePro, direPro, rsPro, conprinPro, pwPro);
end$$

delimiter ;	

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_agregarProveedores(1,'784','Joao','Boligo','Zona 12', 'iman', 'iman@gmail.com', 'bew');

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$
	create procedure sp_listarProveedores()
    begin
    
		select Proveedores.codigoProveedor, Proveedores.NITProveedor, Proveedores.nombresProveedor,Proveedores.apellidosProveedor, 
	Proveedores.direccionProveedor, Proveedores.razonSocial, Proveedores.contactoPrincipal, Proveedores.paginaWeb 
    from Proveedores;
    end$$
    
delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_listarProveedores();

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

	create procedure sp_buscarProveedores(in codPro int)
    begin
	select Proveedores.codigoProveedor, Proveedores.codigoProveedor ,Proveedores.NITProveedor, Proveedores.nombresProveedor,Proveedores.apellidosProveedor, 
	Proveedores.direccionProveedor, Proveedores.razonSocial, Proveedores.contactoPrincipal, Proveedores.paginaWeb  
    from Proveedores where Proveedores.codigoProveedor = codPro;
	end$$
    
delimiter ;


-- ---------------------------------------------------------------------------------------------------------------------------

call sp_buscarProveedores(1);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$

	create procedure sp_eliminarProveedores(in codPro int)
    begin
		delete from Proveedores where Proveedores.codigoProveedor = codPro;
    end$$
    
delimiter ;
-- ---------------------------------------------------------------------------------------------------------------------------

call sp_eliminarProveedores(3);

-- ---------------------------------------------------------------------------------------------------------------------------

delimiter $$
	create procedure sp_actualizarProveedores(in codPro int, in NPro varchar(10), in nomPro varchar(60), 
    in apePro varchar(60), in direPro varchar(150), in rsPro varchar(60), in conprinPro varchar(100), 
    in pwPro varchar(50))
    begin
		update Proveedores
		set
		Proveedores.NITProveedor = NPro,
        Proveedores.nombresProveedor = nomPro,
        Proveedores.apellidosProveedor = apePro,
		Proveedores.direccionProveedor = direPro,
        Proveedores.razonSocial = rsPro,
        Proveedores.contactoPrincipal = conprinPro,
        Proveedores.paginaWeb = pwPro
        where 
        Proveedores.codigoProveedor = codPro;
    end$$
delimiter ;

-- ---------------------------------------------------------------------------------------------------------------------------

call sp_actualizarProveedores(2,'12347894-9','Carlos José','Méndez Oliva','Almacén 18 carretera al Salvador', 'aguas Tuchez', 'aguas12@gmail.com', 'www.aguas.com');

-- ---------------------------- Productos -----------------------------------------------------------------------------------------------


delimiter $$
create procedure sp_agregarProductos (in codPro varchar(45), 
in desPro varchar(45), 
in precioUniPro decimal(10,2),
in precioDocPro decimal(10,2),									  
in precioMaPro decimal(10,2), 
in existencia int, 
in codTipPro int,
in codProvPro int )
	begin 
	insert into Productos (Productos.codigoProducto, Productos.descripcionProducto, Productos.precioUnitario, Productos.precioDocena,
						   Productos.precioMayor, Productos.existencia, Productos.codigoTipoProducto, 
                           Productos.codigoProveedor)
    values (codPro, desPro, precioUniPro, precioDocPro, precioMaPro, existencia, codTipPro, codProvPro);
	end$$
delimiter ;

-- ----------------------------------------------------------------------------------------

call sp_agregarProductos(1, 'Computadora de escritorio', 550.00, 2.00, 300.00, 50, 1, 1);

-- ----------------------------------------------------------------------------------------

delimiter $$
	create procedure sp_listarProductos ()
    begin
		select Productos.codigoProducto, Productos.descripcionProducto, Productos.precioUnitario, Productos.precioDocena,
			   Productos.precioMayor, Productos.existencia, Productos.codigoTipoProducto, 
			   Productos.codigoProveedor
        from Productos;
    end$$
delimiter ;

-- ----------------------------------------------------------------------------------------

call sp_listarProductos();

-- ----------------------------------------------------------------------------------------
delimiter $$
	create procedure sp_buscarProductos(in codPro varchar(45))
    begin
	select Productos.codigoProducto, Productos.descripcionProducto, Productos.precioUnitario, Productos.precioDocena,
		   Productos.precioMayor, Productos.existencia, Productos.codigoTipoProducto, 
		   Productos.codigoProveedor from Productos 
    where Productos.codigoProducto = codPro;
	end$$
delimiter ;

-- ----------------------------------------------------------------------------------------

call sp_buscarProductos('1');

-- ----------------------------------------------------------------------------------------

delimiter $$
	create procedure sp_actualizarProductos(in codPro varchar(45), 
    in desPro varchar(45), 
    in precioUniPro decimal(10,2), 
    in precioDocPro decimal(10,2),
	in precioMaPro decimal(10,2), 
    in existencia int, 
    in codTipPro int,
	in codProvPro int)
    begin
		update Productos
		set
        Productos.descripcionProducto = desPro, 
        Productos.precioUnitario = precioUniPro, 
        Productos.precioDocena = precioDocPro,
		Productos.precioMayor = precioMaPro, 
        Productos.existencia = existencia, 
        Productos.codigoTipoProducto = codTipPro, 
		Productos.codigoProveedor = codProvPro
        where 
        Productos.codigoProducto = codPro;
    end$$
delimiter ;


call sp_actualizarProducto(50, 'Descripción del producto', 9.00, 12.00, 45.00, 150, 2, 2);

-- ----------------------------------------------------------------------------------------

delimiter $$
	create procedure sp_eliminarProductos (in codPro varchar(45))
    begin
		delete from Productos where Productos.codigoProducto = codPro;
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


