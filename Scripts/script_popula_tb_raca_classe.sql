USE db_rpg

SET NOCOUNT ON

MERGE dbo.tb_raca_classe AS destino
USING	(
		VALUES
			 ('Anão'		,'Mestres das rochas e do ferro, destemidos e obstinados diante de adversidades'											,0)
			,('Elfo'		,'Arqueiros ágeis e cautelosos que vagam livremente pelos ermos e florestas'												,0)
			,('Meio-Elfo'	,'Heróis e líderes natos que combinam as melhores características dos humanos e dos elfos'									,0)
			,('Halfling'	,'Nômades velozes e engenhosos, de estatura pequena, mas grande coragem'													,0)
			,('Humano'		,'Ambiciosos, determinados e pragmáticos — uma raça de heróis, e também de vilões'											,0)
			,('Meio-Orc'	,'Guerreiros temíveis que combinam a determinação dos humanos com a selvageria dos orcs'									,0)
			,('Bárbaro'		,'Guerreiros selvagens que conseguem des­ferir golpes terríveis com suas armas poderosas'									,1)
			,('Bardo'		,'Artistas que praticam a magia assim como suas canções, dramas e poesias'													,1)
			,('Mago'		,'Detentores da magia arcana'																								,1)
			,('Feiticeiro'	,'Portadores do poder arcano em sua forma bruta, eles criam explosões e rajadas de energia arcana através de seus corpos'	,1)
			,('Bruxo'		,'Canalizam o poder arcano retirado de entidades primordiais'																,1)
			,('Druida'		,'Eles correm ao lado de matilhas de lobos, falam com árvores antigas e observam solitários os temporais'					,1)
			,('Clérigo'		,'Líderes de combate que foram investidos com o poder divino'																,1)
			,('Guerreiro'	,'São adeptos determinados do combate, trei­nados para proteger os outros membros dos seus grupos de aventureiros'			,1)
			,('Ladino'		,'Confiam em sua perícia, furtividade e na vulnerabilidade de seus oponentes obter vantagem em qualquer situação'			,1)
		)
		AS origem (nm_rc, desc_rc, defi_rc)

ON (destino.nm_rc = origem.nm_rc)

WHEN MATCHED THEN

	UPDATE SET
	 destino.nm_rc		= origem.nm_rc
	,destino.desc_rc	= origem.desc_rc
	,destino.defi_rc	= origem.defi_rc

WHEN NOT MATCHED BY TARGET THEN

	INSERT (nm_rc, desc_rc, defi_rc)
	VALUES (origem.nm_rc, origem.desc_rc, origem.defi_rc)

WHEN NOT MATCHED BY SOURCE THEN

	DELETE;
