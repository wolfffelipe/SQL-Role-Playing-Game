CREATE PROCEDURE sp_gera_personagem
AS
BEGIN

	BEGIN TRY

		DECLARE	 @contador		INT = 0
				,@aleatorio		INT
				,@nome			VARCHAR(100)
				,@raca			INT
				,@classe		INT
				,@nivel			INT
				,@tendencia		VARCHAR(50)
				,@sexo			CHAR(1)
				,@pdv			INT
				,@arma			INT
				,@armadura		INT

		/* DEFINE NOME DO PERSONAGEM */
		SELECT @contador = COUNT(*) FROM [dbo].[tb_nome]
		EXEC sp_num_aleatorio 1, @contador, @resultado = @aleatorio OUTPUT
		SELECT @nome = nm_nome FROM [dbo].[tb_nome] ORDER BY cd_nome OFFSET @aleatorio - 1 ROWS FETCH NEXT 1 ROWS ONLY;

		/* DEFINE RAÇA */
		SELECT @contador = COUNT(*) FROM [dbo].[tb_raca_classe] WHERE defi_rc = 0
		EXEC sp_num_aleatorio 1, @contador, @resultado = @aleatorio OUTPUT
		SELECT @raca = cd_rc FROM [dbo].[tb_raca_classe] WHERE defi_rc = 0 ORDER BY cd_rc OFFSET @aleatorio - 1 ROWS FETCH NEXT 1 ROWS ONLY;

		/* DEFINE CLASSE */
		SELECT @contador = COUNT(*) FROM [dbo].[tb_raca_classe] WHERE defi_rc = 1
		EXEC sp_num_aleatorio 1, @contador, @resultado = @aleatorio OUTPUT
		SELECT @classe = cd_rc FROM [dbo].[tb_raca_classe] WHERE defi_rc = 1 ORDER BY cd_rc OFFSET @aleatorio - 1 ROWS FETCH NEXT 1 ROWS ONLY;

		/* DEFINE NÍVEL */
		EXEC sp_num_aleatorio 1, 15, @resultado = @aleatorio OUTPUT
		SET @nivel = @aleatorio

		/* DEFINE TENDÊNCIA */
		EXEC sp_num_aleatorio 1, 9, @resultado = @aleatorio OUTPUT
		SET @tendencia = 
			CASE @aleatorio
				WHEN 1 THEN 'Leal e Bom'
				WHEN 2 THEN 'Neutro e Bom'
				WHEN 3 THEN 'Caótico e Bom'
				WHEN 4 THEN 'Leal e Neutro'
				WHEN 5 THEN 'Neutro'
				WHEN 6 THEN 'Caótico e Neutro'
				WHEN 7 THEN 'Leal e Mau'
				WHEN 8 THEN 'Neutro e Mau'
				WHEN 9 THEN 'Caótico e Mau'
			END   

		/* DEFINE SEXO */
		EXEC sp_num_aleatorio 1, 2, @resultado = @aleatorio OUTPUT
		IF (@aleatorio = 1)
			BEGIN SET @sexo = 'M' END
		ELSE 
			BEGIN SET @sexo = 'F' END

		/* DEFINE PDV */
		IF (@nivel >= 1 AND @nivel <= 5)
			BEGIN SET @pdv = 20 END
		ELSE IF (@nivel >= 6 AND @nivel <= 10)
			BEGIN SET @pdv = 40 END
		ELSE
			BEGIN SET @pdv = 60 END

		/* DEFINE ARMA */
		SELECT @contador = COUNT(*) FROM [dbo].[tb_arma]
		EXEC sp_num_aleatorio 1, @contador, @resultado = @aleatorio OUTPUT
		SELECT @arma = cd_arma FROM [dbo].[tb_arma] ORDER BY cd_arma OFFSET @aleatorio - 1 ROWS FETCH NEXT 1 ROWS ONLY;

		/* DEFINE ARMADURA */
		SELECT @contador = COUNT(*) FROM [dbo].[tb_armadura] 
		EXEC sp_num_aleatorio 1, @contador, @resultado = @aleatorio OUTPUT
		SELECT @armadura = cd_armadura FROM [dbo].[tb_armadura] ORDER BY cd_armadura OFFSET @aleatorio - 1 ROWS FETCH NEXT 1 ROWS ONLY;

		INSERT INTO dbo.tb_personagem	(
										 [nm_jogador]
										,[nm_personagem]
										,[cd_raca]
										,[cd_classe]
										,[pe_nivel]
										,[pe_tendencia]
										,[pe_sexo]
										,[pe_pdv]
										,[cd_arma]
										,[cd_armadura]
										)
			VALUES
				(
					 'NPC'
					,@nome		
					,@raca		
					,@classe	
					,@nivel		
					,@tendencia	
					,@sexo		
					,@pdv		
					,@arma		
					,@armadura	
				)
	
		SELECT TOP 1 * FROM dbo.tb_personagem ORDER BY cd_personagem DESC

	END TRY

	BEGIN CATCH

		SELECT 'Ocorreu um erro ao gerar o personagem de forma aleatória' AS Erro

	END CATCH
END


