CREATE PROCEDURE sp_gera_habilidade (@cd_personagem INT)
AS
BEGIN

	DECLARE  @for		SMALLINT
			,@des		SMALLINT
			,@con		SMALLINT
			,@int		SMALLINT
			,@sab		SMALLINT
			,@car		SMALLINT
			,@dado		SMALLINT	= 20

	EXEC sp_num_aleatorio 1, @dado, @resultado = @for OUTPUT
	EXEC sp_num_aleatorio 1, @dado, @resultado = @des OUTPUT
	EXEC sp_num_aleatorio 1, @dado, @resultado = @con OUTPUT
	EXEC sp_num_aleatorio 1, @dado, @resultado = @int OUTPUT
	EXEC sp_num_aleatorio 1, @dado, @resultado = @sab OUTPUT
	EXEC sp_num_aleatorio 1, @dado, @resultado = @car OUTPUT

	INSERT INTO tb_habilidade (
								 [cd_personagem]
								,[hb_forca]
								,[hb_destreza]
								,[hb_constituicao]
								,[hb_inteligencia]
								,[hb_sabedoria]
								,[hb_carisma]
	)
	VALUES (
			 @cd_personagem
			,@for
			,@des
			,@con
			,@int
			,@sab
			,@car
	)
END