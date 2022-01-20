CREATE PROCEDURE sp_batalha (
								 @personagem1 INT
								,@personagem2 INT
							)
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		
		DECLARE  @nome1			VARCHAR(100)
				,@pdv1			INT
				,@ataque1		VARCHAR(10)
				,@defesa1		INT
				,@nome2			VARCHAR(100)
				,@pdv2			INT
				,@ataque2		VARCHAR(10)
				,@defesa2		INT
				,@dano			INT
				,@calc			VARCHAR(100)
				,@qnt1			INT
				,@dado1			INT
				,@qnt2			INT
				,@dado2			INT
				,@conta			INT
				,@critico		VARCHAR(500)

		SELECT
				 @nome1					= tp.nm_personagem		
				,@pdv1					= tp.pe_pdv		
				,@ataque1				= ta.vl_ataque				
				,@defesa1				= tad.vl_defesa					
		FROM	dbo.tb_personagem		tp
		JOIN	dbo.tb_arma				ta		ON ta.cd_arma			= tp.cd_arma
		JOIN	dbo.tb_armadura			tad		ON tad.cd_armadura		= tp.cd_armadura
		JOIN	dbo.tb_habilidade		th		ON tp.cd_personagem		= th.cd_personagem
		WHERE	tp.cd_personagem		= @personagem1
		
		SELECT
				 @nome2					= tp.nm_personagem		
				,@pdv2					= tp.pe_pdv		
				,@ataque2				= ta.vl_ataque				
				,@defesa2				= tad.vl_defesa									
		FROM	dbo.tb_personagem		tp
		JOIN	dbo.tb_arma				ta		ON ta.cd_arma			= tp.cd_arma
		JOIN	dbo.tb_armadura			tad		ON tad.cd_armadura		= tp.cd_armadura
		JOIN	dbo.tb_habilidade		th		ON tp.cd_personagem		= th.cd_personagem
		WHERE	tp.cd_personagem		= @personagem2

		SELECT top 1 @qnt1	= VALUE FROM STRING_SPLIT (@ataque1, 'd') ORDER BY VALUE ASC
		SELECT top 1 @dado1	= VALUE FROM STRING_SPLIT (@ataque1, 'd') ORDER BY VALUE DESC
		SET @ataque1 = @qnt1 * @dado1

		SELECT top 1 @qnt2	= VALUE FROM STRING_SPLIT (@ataque2, 'd') ORDER BY VALUE ASC
		SELECT top 1 @dado2	= VALUE FROM STRING_SPLIT (@ataque2, 'd') ORDER BY VALUE DESC
		SET @ataque2 = @qnt2 * @dado2

		IF OBJECT_ID('tempdb..#tb_aux_batalha') IS NOT NULL
			BEGIN DROP TABLE #tb_aux_batalha END

		CREATE TABLE #tb_aux_batalha (
										 [PdV 1]			VARCHAR(10)
										,[Personagem 1]		VARCHAR(100)
										,[Ação 1]			VARCHAR(10)
										,[Dano]				VARCHAR(100)
										,[Ação 2]			VARCHAR(10)
										,[Personagem 2]		VARCHAR(100)
										,[PdV 2]			VARCHAR(10)
										,[Mensagem]			VARCHAR(100)
								)
		
		INSERT INTO #tb_aux_batalha 
							VALUES (
										 @pdv1
										,@nome1
										,'-'
										,'-'
										,'-'
										,@nome2
										,@pdv2
										,'-'
									)
									
		WHILE (@pdv1 > 0 AND @pdv2 > 0)
			BEGIN
				SET @calc = '-'

				/* 1 ATACA */
				EXEC sp_num_aleatorio 1, @ataque1, @resultado = @dano OUTPUT
				
				IF @dano = @ataque1
					BEGIN
						EXEC sp_num_aleatorio 1, 50, @resultado = @conta OUTPUT
						SELECT @critico = desc_criticidade FROM tb_criticidade
							WHERE cd_acerto_erro BETWEEN 100 AND 151
							ORDER BY cd_criticidade ASC 
							OFFSET 1 ROWS FETCH NEXT @conta ROWS ONLY 
						SET @calc = '!!! DANO CRÍTICO: ' + @critico 
					END

				IF (@defesa2 >= @dano)
					BEGIN
						SET @dano = 0
						SET @calc = 'Defesa!'
					END
				ELSE
					BEGIN
						SET @dano = (@dano - @defesa2)
						SET @pdv2 = @pdv2 - @dano
						IF (@calc = '-')
							BEGIN
								SET @calc = CONVERT(VARCHAR(10), (@dano + @defesa2)) + ' (Ataque) - ' +  CONVERT(VARCHAR(10), @defesa2) + ' (Defesa) = ' +  CONVERT(VARCHAR(10), @dano) + ' (Dano)'
							END
					END
				
				IF @dano = 1
					BEGIN
						EXEC sp_num_aleatorio 1, 50, @resultado = @conta OUTPUT
						SELECT @critico = desc_criticidade FROM tb_criticidade
							WHERE cd_acerto_erro BETWEEN 200 AND 251
							ORDER BY cd_criticidade ASC 
							OFFSET 1 ROWS FETCH NEXT @conta ROWS ONLY 
						SET @calc = '!!! ERRO CRÍTICO: ' + @critico 
					END

				INSERT INTO #tb_aux_batalha 
							VALUES (
										 @pdv1
										,@nome1
										,'=|===>'
										,CONVERT(VARCHAR(100), @dano)
										,'(O)'
										,@nome2
										,@pdv2
										,@calc
									)

				IF @pdv2 <= 0
					BEGIN
						INSERT INTO #tb_aux_batalha 
							VALUES ('-', '-', '-', '-', '-', '-', '-', @nome1 + ' venceu!!!!')
						BREAK
					END
		
				SET @calc = '-'

				/* 2 ATACA */
				EXEC sp_num_aleatorio 1, @ataque2, @resultado = @dano OUTPUT
				
				IF @dano = @ataque2
					BEGIN
						EXEC sp_num_aleatorio 1, 50, @resultado = @conta OUTPUT
						SELECT @critico = desc_criticidade FROM tb_criticidade
							WHERE cd_acerto_erro BETWEEN 100 AND 151
							ORDER BY cd_criticidade ASC 
							OFFSET 1 ROWS FETCH NEXT @conta ROWS ONLY 
						SET @calc = '!!! DANO CRÍTICO: ' + @critico 
					END
				

				IF (@defesa1 >= @dano)
					BEGIN
						SET @dano = 0
						SET @calc = 'Defesa!'
					END
				ELSE
					BEGIN
						SET @dano = (@dano - @defesa1)
						SET @pdv1 = @pdv1 - @dano
						IF (@calc = '-')
							BEGIN
								SET @calc = CONVERT(VARCHAR(10), (@dano + @defesa2)) + ' (Ataque) - ' +  CONVERT(VARCHAR(10), @defesa2) + ' (Defesa) = ' +  CONVERT(VARCHAR(10), @dano) + ' (Dano)'
							END
					END

				IF @dano = 1
				BEGIN
					EXEC sp_num_aleatorio 1, 50, @resultado = @conta OUTPUT
					SELECT @critico = desc_criticidade FROM tb_criticidade
						WHERE cd_acerto_erro BETWEEN 200 AND 251
						ORDER BY cd_criticidade ASC 
						OFFSET 1 ROWS FETCH NEXT @conta ROWS ONLY 
					SET @calc = '!!! ERRO CRÍTICO: ' + @critico 
				END

				INSERT INTO #tb_aux_batalha 
						VALUES (
										 @pdv1
										,@nome1
										,'(O)'
										,CONVERT(VARCHAR(100), @dano)
										,'<===|='
										,@nome2
										,@pdv2
										,@calc
								)

				IF @pdv1 <= 0
					BEGIN
						INSERT INTO #tb_aux_batalha 
							VALUES ('-', '-', '-', '-', '-', '-', '-', @nome2 + ' venceu!!!!')
						BREAK
					END

			END

			SELECT * FROM #tb_aux_batalha

	END TRY

	BEGIN CATCH

		SELECT 'Ocorreu um erro durante a batalha' AS Erro

	END CATCH
END


