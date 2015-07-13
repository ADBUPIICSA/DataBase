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
			SELECT * FROM compensaciones WHERE nombre_comp LIKE '%'+@nombre_comp+'%' ORDER BY nombre_comp ASC
		END
	
GO
--UPDATE
CREATE PROCEDURE proc_editar_compensacion(
		@id_compensacion int,
		@importe int
	)
	AS
	UPDATE compensaciones SET importe = @importe WHERE id_compensacion = @id_compensacion
GO
--DELETE
CREATE PROCEDURE proc_eliminar_compensacion(
		@id_compensacion int
	)
	AS
	DELETE FROM compensaciones WHERE id_compensacion = @id_compensacion
GO

--PROCEDIMIENTOS DE LA TABLA CAPACITACION
--CREATE
CREATE PROCEDURE proc_nueva_capacitacion(
		@nombre_cap varchar(35),
		@tipo	varchar(35),
		@duración	int,
		@id_compensacion int = null
	)
	AS
	INSERT INTO capacitaciones VALUES (@nombre_cap, @tipo, @duración, @id_compensacion)
GO
--READ
CREATE PROCEDURE proc_seleccionar_capacitacion(
		@nombre_cap varchar(35) = NULL
	)
	AS
	IF @nombre_cap IS NULL
		BEGIN
			SELECT * FROM capacitaciones ORDER BY id_capacitacion
		END
	ELSE
		BEGIN
			SELECT * FROM capacitaciones WHERE nombre_cap = @nombre_cap ORDER BY nombre_cap ASC
		END
	
GO
--DELETE
CREATE PROCEDURE proc_eliminar_capacitacion(
		@id_capacitacion int
	)
	AS
	DELETE FROM capacitaciones WHERE id_capacitacion = @id_capacitacion
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
--CREO QUE LO MEJOR SERÍA PROGRAMAR ESTA ACTUALIZACIÓN EN EL SSTEMA Y NO EN UN PROCEDURE
--CREATE PROCEDURE proc_editar_empleado(
--		@num_empleado int,
--		@campo varchar(35),
--		@valor varchar(35)
--	)
--	AS
--	UPDATE empleados SET @campo = @valor WHERE num_empleado = @num_empleado
--GO
--DELETE
CREATE PROCEDURE proc_eliminar_empleado(
		@num_empleado int
	)
	AS
	DELETE FROM empleados WHERE num_empleado = @num_empleado
GO

--PROCEDIMIENTOS DE LA TABLA CAPACITA_EMPLEADO
--CREATE
CREATE PROCEDURE proc_asignar_capacitacion_empleado(
		@num_empleado int,
		@id_capacitacion int,
		@fecha datetime
	)
	AS
	INSERT capacita_empleado VALUES (@num_empleado, @id_capacitacion, @fecha)
GO
--SELECT
CREATE VIEW capacitaciones_asignadas_empleados AS
SELECT A.id_capacitacion, A.num_empleado, A.fecha, nombre_cap AS capacitacion, nombre, aPaterno, aMaterno
FROM capacita_empleado A 
	INNER JOIN capacitaciones B
		ON A.id_capacitacion = B.id_capacitacion
	INNER JOIN empleados C
		ON A.num_empleado = C.num_empleado
GO
CREATE PROCEDURE proc_select_capacitacion_empleado(
		@num_empleado int = null,
		@id_capacitacion int = null
	)
	AS
	IF @num_empleado IS NULL AND @id_capacitacion IS NULL
		BEGIN
			SELECT * FROM capacita_empleado ORDER BY num_empleado
		END
	ELSE IF @num_empleado IS NULL
		BEGIN
			SELECT * FROM capacita_empleado WHERE id_capacitacion = @id_capacitacion ORDER BY num_empleado
		END
	ELSE IF @id_capacitacion IS NULL
		BEGIN
			SELECT * FROM capacita_empleado WHERE num_empleado = @num_empleado ORDER BY num_empleado
		END
	ELSE
		BEGIN
			SELECT * FROM capacita_empleado WHERE id_capacitacion = @id_capacitacion AND num_empleado = @num_empleado ORDER BY num_empleado
		END	
GO
--DELETE
CREATE PROCEDURE proc_eliminar_capacitacion_empleado(
		@num_empleado int,
		@id_capacitacion int
	)
	AS
	DELETE FROM capacita_empleado WHERE num_empleado = @num_empleado AND id_capacitacion = @id_capacitacion
GO






USE E_13_05_2015