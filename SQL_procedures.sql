
USE ABD_GMODELO
GO

--PROCEDIMIENTOS DE LA TABLA PUESTOS
--CREATE
CREATE PROCEDURE proc_nuevo_puesto(
		@nombre varchar(35),
		@oficina	varchar(35),
		@area varchar(35)
	)
	AS
	INSERT INTO puestos VALUES (@nombre, @oficina, @area)
GO
--READ
CREATE PROCEDURE proc_seleccionar_puesto(
		@nombre varchar(35) = NULL
	)
	AS
	IF @nombre is null
		BEGIN
			SELECT * FROM puestos ORDER BY id_puesto ASC
		END 
	ELSE 
		BEGIN
			SELECT * FROM puestos WHERE nombre = @nombre ORDER BY id_puesto ASC
		END
	
GO
--DELETE
CREATE PROCEDURE proc_borrar_puesto(
		@id_puesto int
	)
	AS
	DELETE FROM puestos WHERE id_puesto = @id_puesto
GO

--PROCEDIMIENTOS DE LA TABLA COMPENSACIONES
--CREATE
CREATE PROCEDURE proc_nueva_compensacion(
		@nombre_comp	varchar(35),
		@concepto varchar(35),
		@importe int
	)
	AS
	INSERT INTO compensaciones VALUES (@nombre_comp, @concepto, @importe)
GO
--READ
CREATE PROCEDURE proc_seleccionar_compensacion(
		@nombre_comp varchar(35) = NULL
	)
	AS
	IF @nombre_comp IS NULL
		BEGIN
			SELECT * FROM compensaciones
		END
	ELSE
		BEGIN
			SELECT * FROM compensaciones WHERE nombre_comp = @nombre_comp ORDER BY @nombre_comp ASC
		END
	
GO
--UPDATE
CREATE PROCEDURE proc_editar_capacitacion(
		@id_compensacion int,
		@importe int
	)
	AS
	UPDATE compensaciones SET importe = @importe WHERE id_compensacion = @id_compensacion
GO
--DELETE
CREATE PROCEDURE proc_eliminar_capacitacion(
		@id_compensacion int
	)
	AS
	DELETE FROM compensaciones WHERE id_compensacion = @id_compensacion
GO

--PROCEDIMIENTOS DE LA TABLA EMPLEADOS
--CREATE
CREATE PROCEDURE proc_nuevo_empleado(
		@nombre	varchar(35),
		@aPaterno	varchar(35),
		@aMaterno	varchar(35),
		@telefono varchar(35),
		@direccion	varchar (75),
		@email	varchar(30),
		@salario	int,
		@fecha_ingreso datetime,
		@id_puesto int
	)
	AS
	INSERT INTO empleados VALUES (@nombre, @aPaterno, @aMaterno, @telefono, @direccion, @email, @salario, @fecha_ingreso, @id_puesto)
GO
--READ
CREATE PROCEDURE proc_seleccionar_empleado(
		@aPaterno varchar(35) = NULL
	)
	AS
	IF @aPaterno is null
		BEGIN
			SELECT * FROM empleados ORDER BY num_empleado
		END
	ELSE
		BEGIN
			SELECT * FROM empleados WHERE aPaterno = @aPaterno
		END
	
GO
--UPDATE
CREATE PROCEDURE proc_editar_empleado(
		@num_empleado int,
		@telefono varchar(35),
		@direccion	varchar (75),
		@email	varchar(30),
		@salario	int,
		@id_puesto int
	)
	AS
	UPDATE compensaciones SET telefono = @telefono WHERE id_compensacion = @id_compensacion
GO
--DELETE
CREATE PROCEDURE proc_eliminar_capacitacion(
		@id_compensacion int
	)
	AS
	DELETE FROM compensaciones WHERE id_compensacion = @id_compensacion
GO







USE E_13_05_2015