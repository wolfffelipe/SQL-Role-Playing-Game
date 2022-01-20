CREATE PROCEDURE sp_num_aleatorio	(
										 @min			INT
										,@max			INT
										,@resultado		INT OUTPUT
									)
AS
BEGIN
	SET NOCOUNT ON

	SET @resultado = ROUND( RAND() * ( @max - @min + 1) + 1 , 0)
END