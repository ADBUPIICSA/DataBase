USE E_13_05_2015
GO
DROP DATABASE ABD_GMODELO
GO
CREATE DATABASE ABD_GMODELO
GO
USE ABD_GMODELO
GO

CREATE TABLE puestos(
	id_puesto int IDENTITY(1,1),
	nombre varchar(35),
	oficina	varchar(35),
	area varchar(35)
)

CREATE TABLE compensaciones(
	id_compensacion	int IDENTITY(1,1),
	nombre_comp	varchar(35),
	concepto varchar(35),
	importe int
)

CREATE TABLE empleados(
	num_empleado int IDENTITY(1,1),
	nombre	varchar(35),
	aPaterno varchar(35),
	aMaterno varchar(35),
	fnacimiento datetime,
	telefono varchar(35),
	direccion	varchar (75),
	email	varchar(30),
	rfc	varchar(35),
	curp varchar(35),
	salario	int,
	fecha_ingreso datetime,
	id_puesto int
)

CREATE TABLE capacitaciones(
	id_capacitacion	int identity(1,1),
	nombre_cap varchar(35),
	tipo	varchar(35),
	duracion	int,
	id_compensacion int
)

CREATE TABLE capacita_empleado(
	num_empleado int NOT NULL,
	id_capacitacion int NOT NULL,
	fecha datetime
)

CREATE TABLE compensa_empleado(
	num_empleado int NOT NULL,
	id_compensacion int NOT NULL
)

CREATE TABLE pago(
	id_pago	int identity(1,1), 
	num_empleado	int,
	fecha_pago	datetime,
	total_pago int
)

CREATE TABLE aspirante(
	id_aspirante int identity(1,1), 
	nombre	varchar(35),
	aPaterno varchar(35),
	aMaterno varchar(35),
	fnacimiento datetime,
	telefono varchar(35),
	direccion	varchar (75),
	email	varchar(30),
	rfc	varchar(35),
	curp varchar(35),
	id_puesto	int not null
)

CREATE TABLE entrevista(
	id_entrevista int identity(1,1),
	id_aspirante	int not null,
	fecha datetime,
	entrevistador	int,
	resultado bit
)

CREATE TABLE proveedores(
	id_proveedor int identity(1,1), 
	nombre	varchar(35),
	aPaterno	varchar(35),
	aMaterno	varchar(35),
	telefono varchar(35),
	direccion	varchar (75),
	email	varchar(30)
)

CREATE TABLE clientes(
	id_cliente int identity(1,1), 
	nombre	varchar(35),
	aPaterno	varchar(35),
	aMaterno	varchar(35),
	telefono varchar(35),
	direccion	varchar (75),
	email	varchar(30),
	rfc varchar(30)
)

CREATE TABLE mat_prima(
	id_mat_prima	int identity(1,1), 
	nom_mat_prima	varchar(35),
	precio	int,
	unidades	varchar(35),
	existencia int
)

CREATE TABLE prod_term(
	id_prod_terminado	int identity(1,1), 
	nom_prod_terminado	varchar(35),
	precio	int,
	presentacion	varchar(35),
	existencia int
)

CREATE TABLE compra(
	id_compra	int not null,
	id_proveedor	int not null,
	total_compra	int,
	autoriza_compra int

)

CREATE TABLE detalle_compra(
	id_compra	int not null,
	id_mat_prima	int not null,
	cantidad	int,
	total_art int
)

CREATE TABLE orden_servicio(
	id_orden_servicio	int identity(1,1),
	id_cliente	int,
	fecha	datetime,
	total_Entrega	int,
	realiza_entrega	int,
	economico varchar(23)
)

CREATE TABLE detalle_orden_servicio(
	id_orden_servicio	int not null,
	id_prod_terminado	int not null,
	cantidad	int,
	total_art int
)

CREATE TABLE orden_produccion(
	id_orden_produccion	int identity(1,1),
	id_prod_terminado	int,
	cantidad_prod_t	int,
	fecha	datetime,
	elaboro	int,
	autorizo int
)

CREATE TABLE detalle_orden_produccion(
	id_orden_produccion	int not null,
	id_mat_prima	int not null,
	cantidad	int
)


ALTER TABLE puestos ADD PRIMARY KEY (id_puesto)
ALTER TABLE empleados ADD PRIMARY KEY (num_empleado)
ALTER TABLE compensaciones ADD PRIMARY KEY (id_compensacion)
ALTER TABLE capacitaciones ADD PRIMARY KEY (id_capacitacion)
ALTER TABLE capacita_empleado ADD PRIMARY KEY (num_empleado, id_capacitacion)
ALTER TABLE compensa_empleado ADD PRIMARY KEY (num_empleado, id_compensacion)
ALTER TABLE pago ADD PRIMARY KEY (id_pago)
ALTER TABLE aspirante ADD PRIMARY KEY (id_aspirante)
ALTER TABLE entrevista ADD PRIMARY KEY (id_entrevista)
ALTER TABLE proveedores ADD PRIMARY KEY (id_proveedor)
ALTER TABLE clientes ADD PRIMARY KEY (id_cliente)
ALTER TABLE mat_prima ADD PRIMARY KEY (id_mat_prima)
ALTER TABLE prod_term ADD PRIMARY KEY (id_prod_terminado)
ALTER TABLE compra ADD PRIMARY KEY (id_compra)
ALTER TABLE detalle_compra ADD PRIMARY KEY (id_compra, id_mat_prima)
ALTER TABLE orden_servicio ADD PRIMARY KEY (id_orden_servicio)
ALTER TABLE orden_produccion ADD PRIMARY KEY (id_orden_produccion)
ALTER TABLE detalle_orden_servicio ADD PRIMARY KEY (id_orden_servicio, id_prod_terminado)
ALTER TABLE detalle_orden_produccion ADD PRIMARY KEY (id_orden_produccion, id_mat_prima)

ALTER TABLE empleados ADD FOREIGN KEY (id_puesto) REFERENCES puestos(id_puesto)

ALTER TABLE capacitaciones ADD FOREIGN KEY (id_compensacion) REFERENCES compensaciones(id_compensacion)

ALTER TABLE capacita_empleado ADD FOREIGN KEY (num_empleado) REFERENCES empleados(num_empleado)
ALTER TABLE capacita_empleado ADD FOREIGN KEY (id_capacitacion) REFERENCES capacitaciones(id_capacitacion)
ALTER TABLE compensa_empleado ADD FOREIGN KEY (num_empleado) REFERENCES empleados(num_empleado)
ALTER TABLE compensa_empleado ADD FOREIGN KEY (id_compensacion) REFERENCES compensaciones(id_compensacion)

ALTER TABLE pago ADD FOREIGN KEY (num_empleado) REFERENCES empleados(num_empleado)

ALTER TABLE aspirante ADD FOREIGN KEY (id_puesto) REFERENCES puestos(id_puesto)

ALTER TABLE entrevista ADD FOREIGN KEY (id_aspirante) REFERENCES aspirante(id_aspirante)
ALTER TABLE entrevista ADD FOREIGN KEY (entrevistador) REFERENCES empleados(num_empleado)

ALTER TABLE compra ADD FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
ALTER TABLE compra ADD FOREIGN KEY (autoriza_compra) REFERENCES empleados(num_empleado)

ALTER TABLE detalle_compra ADD FOREIGN KEY (id_compra) REFERENCES compra(id_compra)
ALTER TABLE detalle_compra ADD FOREIGN KEY (id_mat_prima) REFERENCES mat_prima(id_mat_prima)

ALTER TABLE orden_servicio ADD FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
ALTER TABLE orden_servicio ADD FOREIGN KEY (realiza_entrega) REFERENCES empleados(num_empleado)

ALTER TABLE orden_produccion ADD FOREIGN KEY (id_prod_terminado) REFERENCES prod_term(id_prod_terminado)
ALTER TABLE orden_produccion ADD FOREIGN KEY (elaboro) REFERENCES empleados(num_empleado)
ALTER TABLE orden_produccion ADD FOREIGN KEY (autorizo) REFERENCES empleados(num_empleado)

ALTER TABLE detalle_orden_servicio ADD FOREIGN KEY (id_orden_servicio) REFERENCES orden_servicio(id_orden_servicio)
ALTER TABLE detalle_orden_servicio ADD FOREIGN KEY (id_prod_terminado) REFERENCES prod_term(id_prod_terminado)

ALTER TABLE detalle_orden_produccion ADD FOREIGN KEY (id_orden_produccion) REFERENCES orden_produccion(id_orden_produccion)
ALTER TABLE detalle_orden_produccion ADD FOREIGN KEY (id_mat_prima) REFERENCES mat_prima(id_mat_prima)