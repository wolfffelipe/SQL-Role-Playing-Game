CREATE PROCEDURE proc_num_aleatorio (@min INT, @max INT)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE	@resultado	INT

	SET @resultado = ROUND( RAND() * ( @max - @min ) + 1 , 0)

	SELECT @resultado
END