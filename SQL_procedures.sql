USE ABD_GMODELO
GO


CREATE PROCEDURE proc_puestos(
		@nombre varchar(35),
		@oficina	varchar(35),
		@area varchar(35)
	)
	AS
	INSERT INTO puestos VALUES (@nombre, @oficina, @area)

