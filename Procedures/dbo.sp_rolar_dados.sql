CREATE PROCEDURE proc_rolar_dados (@qtd_dados INT, @qtd_lados INT)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE	 @jogada	VARCHAR (50)	= 'Resultado ' + CONVERT(VARCHAR, @qtd_dados) + 'd' + CONVERT(VARCHAR, @qtd_lados)
			,@conta		INT				= 1
			,@resultado	INT
	
	IF OBJECT_ID('tempdb..#tb_aux') IS NOT NULL
		BEGIN
			DROP TABLE #tb_aux
		END

	CREATE TABLE #tb_aux (Item VARCHAR(50), Valor INT)

	WHILE @conta <= @qtd_dados
		BEGIN
			INSERT INTO #tb_aux VALUES (CONVERT(VARCHAR, @conta) + 'º dado', ROUND( RAND() * ( @qtd_lados - 1 ) + 1 , 0))
			SET @conta += 1
		END

	SELECT @resultado = SUM(Valor) FROM #tb_aux

	INSERT INTO #tb_aux VALUES (@jogada, @resultado)

	SELECT * FROM #tb_aux
END