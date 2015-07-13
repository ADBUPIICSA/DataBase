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
		@aPaterno varchar(35),
		@aMaterno varchar(35),
		@fnacimiento datetime,
		@telefono varchar(35),
		@direccion	varchar (75),
		@email	varchar(30),
		@rfc	varchar(35),
		@curp varchar(35),
		@salario	int,
		@fecha_ingreso datetime,
		@id_puesto int
	)
	AS
	INSERT INTO empleados VALUES (@nombre, @aPaterno, @aMaterno, @fnacimiento, @telefono, 
									@direccion, @email, @rfc, @curp, @salario, @fecha_ingreso, @id_puesto)
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
			SELECT * FROM capacitaciones_asignadas_empleados ORDER BY num_empleado
		END
	ELSE IF @num_empleado IS NULL
		BEGIN
			SELECT * FROM capacitaciones_asignadas_empleados WHERE id_capacitacion = @id_capacitacion ORDER BY num_empleado
		END
	ELSE IF @id_capacitacion IS NULL
		BEGIN
			SELECT * FROM capacitaciones_asignadas_empleados WHERE num_empleado = @num_empleado ORDER BY num_empleado
		END
	ELSE
		BEGIN
			SELECT * FROM capacitaciones_asignadas_empleados WHERE id_capacitacion = @id_capacitacion AND num_empleado = @num_empleado ORDER BY num_empleado
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


--PROCEDIMIENTOS DE LA TABLA COMPENSA_EMPLEADO
--CREATE
CREATE PROCEDURE proc_asignar_compensacion_empleado(
		@num_empleado int,
		@id_compensacion int
	)
	AS
	INSERT compensa_empleado VALUES (@num_empleado, @id_compensacion)
GO
--SELECT
CREATE VIEW compensaciones_asignadas_empleados AS
SELECT A.id_compensacion, A.num_empleado, nombre_comp AS compensacion, nombre, aPaterno, aMaterno
FROM compensa_empleado A 
	INNER JOIN compensaciones B
		ON A.id_compensacion = B.id_compensacion
	INNER JOIN empleados C
		ON A.num_empleado = C.num_empleado
GO
CREATE PROCEDURE proc_select_compensacion_empleado(
		@num_empleado int = null,
		@id_compensacion int = null
	)
	AS
	IF @num_empleado IS NULL AND @id_compensacion IS NULL
		BEGIN
			SELECT * FROM compensaciones_asignadas_empleados ORDER BY num_empleado
		END
	ELSE IF @num_empleado IS NULL
		BEGIN
			SELECT * FROM compensaciones_asignadas_empleados WHERE id_compensacion = @id_compensacion ORDER BY num_empleado
		END
	ELSE IF @id_compensacion IS NULL
		BEGIN
			SELECT * FROM compensaciones_asignadas_empleados WHERE num_empleado = @num_empleado ORDER BY num_empleado
		END
	ELSE
		BEGIN
			SELECT * FROM compensaciones_asignadas_empleados WHERE id_compensacion = @id_compensacion AND num_empleado = @num_empleado ORDER BY num_empleado
		END	
GO
--DELETE
CREATE PROCEDURE proc_eliminar_compensacion_empleado(
		@num_empleado int,
		@id_compensacion int
	)
	AS
	DELETE FROM compensa_empleado WHERE num_empleado = @num_empleado AND id_compensacion = @id_compensacion
GO

--PROCEDIMIENTOS DE LA TABLA PAGO
--CREATE
CREATE VIEW total_compensaciones_empleado AS
	SELECT C.num_empleado, nombre, aPaterno, aMaterno, SUM(importe) AS total_compensaciones
	FROM compensa_empleado A
		INNER JOIN compensaciones B
			ON A.id_compensacion = B.id_compensacion
		INNER JOIN empleados C
			ON A.num_empleado = C.num_empleado
	GROUP BY C.num_empleado, nombre, aPaterno, aMaterno
GO
CREATE PROCEDURE proc_reaizar_pago(
		@num_empleado	int,
		@fecha_pago	datetime = null,
		@total_pago int = null
	)
	AS
	SET @fecha_pago = getdate()
	SET @total_pago = (
						(	
							SELECT salario 
							FROM empleados 
							WHERE num_empleado = @num_empleado
						) +
						(
							SELECT  total_compensaciones
							FROM total_compensaciones_empleado 
							WHERE num_empleado = @num_empleado
						)
					)
	INSERT pago VALUES (@num_empleado, @fecha_pago, @total_pago)
GO
--SELECT
CREATE PROCEDURE proc_select_pago(
		@num_empleado int = null
	)
	AS
	IF @num_empleado IS NULL
		BEGIN
			SELECT * FROM pago ORDER BY fecha_pago DESC
		END
	ELSE
		BEGIN
			SELECT * FROM pago WHERE num_empleado = @num_empleado ORDER BY fecha_pago DESC
		END
GO

--PROCEDIMIENTOS DE LA TABLA ASPIRANTE
--CREATE
CREATE PROCEDURE proc_nuevo_aspirante(
		@nombre	varchar(35),
		@aPaterno varchar(35),
		@aMaterno varchar(35),
		@fnacimiento datetime,
		@telefono varchar(35),
		@direccion	varchar (75),
		@email	varchar(30),
		@rfc	varchar(35),
		@curp varchar(35),
		@puesto varchar(35)
	)
	AS
	INSERT aspirante VALUES (@nombre, @aPaterno, @aMaterno, @fnacimiento, @telefono, @direccion, @email, @rfc, @curp, @puesto)
GO
--SELECT
CREATE PROCEDURE proc_select_aspirantes(
		@id_aspirante int = null,
		@id_puesto int
	)
	AS
	IF @id_aspirante IS NULL AND @id_puesto IS NULL
		BEGIN
			SELECT * FROM aspirante ORDER BY id_aspirante DESC
		END
	ELSE IF @id_aspirante IS NULL
		BEGIN
			SELECT * FROM aspirante WHERE id_puesto = @id_puesto ORDER BY id_aspirante DESC
		END
	ELSE IF @id_puesto IS NULL
		BEGIN
			SELECT * FROM aspirante WHERE id_aspirante = @id_aspirante ORDER BY id_aspirante DESC
		END
	ELSE
		BEGIN
			SELECT * FROM aspirante WHERE id_aspirante = @id_aspirante AND id_puesto = @id_puesto ORDER BY id_aspirante DESC
		END
GO
--DELETE
CREATE PROCEDURE proc_eliminar_aspirante(
		@id_aspirante int = NULL, 
		@id_puesto int = NULL
	)
	AS
	IF @id_puesto IS NULL
		BEGIN
			DELETE FROM aspirante WHERE id_aspirante = @id_aspirante
		END
	ELSE IF @id_puesto IS NULL
		BEGIN
			DELETE FROM aspirante WHERE id_puesto = @id_puesto
		END

	
GO
--CONTRATAR
CREATE PROCEDURE proc_contratar_aspirante(
		@id_aspirante int,
		@id_puesto int,
		@salario	int,

		@nombre	varchar(35) = null,
		@aPaterno varchar(35) = null,
		@aMaterno varchar(35) = null,
		@fnacimiento datetime = null,
		@telefono varchar(35) = null,
		@direccion	varchar (75) = null,
		@email	varchar(30) = null,
		@rfc	varchar(35) = null,
		@curp varchar(35) = null,
		@fecha_ingreso datetime = null
	)
	AS
	SET @nombre = (SELECT nombre FROM aspirante WHERE id_aspirante = @id_aspirante)
	SET @aPaterno = (SELECT aPaterno FROM aspirante WHERE id_aspirante = @id_aspirante)
	SET @aMaterno = (SELECT aMaterno FROM aspirante WHERE id_aspirante = @id_aspirante)
	SET @fnacimiento = (SELECT fnacimiento FROM aspirante WHERE id_aspirante = @id_aspirante)
	SET @telefono = (SELECT telefono FROM aspirante WHERE id_aspirante = @id_aspirante)
	SET @direccion = (SELECT direccion FROM aspirante WHERE id_aspirante = @id_aspirante)
	SET @email = (SELECT telefono FROM aspirante WHERE id_aspirante = @id_aspirante)
	SET @rfc = (SELECT rfc FROM aspirante WHERE id_aspirante = @id_aspirante)
	SET @curp = (SELECT curp FROM aspirante WHERE id_aspirante = @id_aspirante)
	SET @fecha_ingreso = GETDATE()

	INSERT INTO empleados VALUES (@nombre, @aPaterno, @aMaterno, @fnacimiento, @telefono, 
									@direccion, @email, @rfc, @curp, @salario, @fecha_ingreso, @id_puesto)
									
	DELETE FROM aspirante WHERE id_aspirante = @id_aspirante	
GO


--PROCEDIMIENTOS DE LA TABLA ENTREVISTA
--CREATE
CREATE PROCEDURE proc_nueva_entrevista(
		@id_aspirante int,
		@fecha datetime,
		@entrevistador	int,
		@resultado bit
	)
	AS
	INSERT entrevista VALUES (@id_aspirante, @fecha, @entrevistador, @resultado)
GO
--SELECT
CREATE PROCEDURE proc_select_entrevista(
		@id_entrevista int = null,
		@id_aspirante int = null,
		@fechaInicio datetime,
		@fechaFin datetime 
	)
	AS
	IF @id_aspirante IS NOT NULL AND @id_entrevista IS NOT NULL AND @fechaInicio IS NOT NULL AND @fechaFin IS NOT NULL
		BEGIN
			SELECT * 
			FROM entrevista 
			WHERE fecha >= @fechaInicio 
				AND fecha < DATEADD(DAY,1,@fechaFin)
				AND id_entrevista = @id_entrevista
				AND id_aspirante = @id_aspirante
			ORDER BY fecha ASC
		END
	ELSE IF @id_aspirante IS NULL AND @id_entrevista IS NULL
		BEGIN
			SELECT * FROM entrevista WHERE fecha >= @fechaInicio AND fecha < DATEADD(DAY,1,@fechaFin) ORDER BY fecha ASC
		END
	ELSE IF @id_aspirante IS NULL AND @fechaInicio IS NULL 
		BEGIN
			SELECT * FROM entrevista WHERE id_entrevista = @id_entrevista ORDER BY id_entrevista DESC
		END
	ELSE IF @id_entrevista IS NULL AND @fechaInicio IS NULL 
		BEGIN
			SELECT * FROM entrevista WHERE id_aspirante = @id_aspirante ORDER BY id_aspirante DESC
		END
	ELSE
		BEGIN
			SELECT * FROM entrevista ORDER BY id_entrevista ASC
		END
GO
--DELETE
CREATE PROCEDURE proc_eliminar_entrevista(
		@id_entrevista int = null,
		@id_aspirante	int = null 
	)
	AS
	IF @id_entrevista IS NULL
		BEGIN
			DELETE FROM entrevista WHERE id_aspirante = @id_aspirante
		END
	ELSE IF @id_aspirante IS NULL
		BEGIN
			DELETE FROM entrevista WHERE id_entrevista = @id_entrevista
		END

	
GO
--PROCEDIMIENTOS DE LA TABLA PROVEEDORES
--CREATE
CREATE PROCEDURE proc_nuevo_proveedor(
		@nombre	varchar(35),
		@aPaterno	varchar(35),
		@aMaterno	varchar(35),
		@telefono varchar(35),
		@direccion	varchar (75),
		@email	varchar(30)
	)
	AS
	INSERT proveedor VALUES (@nombre, @aPaterno, @aMaterno, @telefono, @direccion, @email)
GO
--SELECT
CREATE PROCEDURE proc_select_proveedor(
		@id_proveedor int = null,
		@nombre varchar(35)
	)
	AS
	IF @id_proveedor IS NULL AND @nombre IS NULL
		BEGIN
			SELECT * FROM proveedor ORDER BY id_proveedor ASC
		END
	ELSE IF @id_proveedor IS NULL
		BEGIN
			SELECT * FROM proveedor WHERE nombre = @nombre ORDER BY id_proveedor ASC
		END
	ELSE IF @nombre IS NULL
		BEGIN
			SELECT * FROM proveedor WHERE id_proveedor = @id_proveedor ORDER BY id_proveedor ASC
		END
	ELSE 
		BEGIN
			SELECT * FROM proveedor WHERE id_proveedor = @id_proveedor AND nombre = @nombre 
			ORDER BY id_proveedor ASC
		END
GO
--DELETE
CREATE PROCEDURE proc_eliminar_proveedor(
		@id_proveedor int	
	)
	AS
	DELETE FROM proveedor WHERE id_proveedor = @id_proveedor

	
GO
