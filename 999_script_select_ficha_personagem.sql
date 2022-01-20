SET NOCOUNT ON

SELECT
		 tp.cd_personagem
		,tp.nm_personagem					
		,tp.pe_nivel						
		,(SELECT nm_rc
			FROM dbo.tb_raca_classe 
			WHERE cd_rc = tp.cd_raca)		AS [Raça]
		,(SELECT nm_rc 
			FROM dbo.tb_raca_classe 
			WHERE cd_rc = tp.cd_classe)		AS [Classe]		
		,tp.pe_tendencia					AS [Tendência]				
		,tp.pe_pdv							AS [PdV]
		,ta.nm_arma							AS [Arma]
		,ta.vl_ataque						AS [Ataque]
		,tad.nm_armadura					AS [Armadura]
		,tad.vl_defesa						AS [Defesa]
		,th.hb_forca						AS [Força]
		,th.hb_destreza						AS [Destreza]
		,th.hb_constituicao					AS [Constituição]
		,th.hb_inteligencia					AS [Inteligência]
		,th.hb_sabedoria					AS [Sabedoria]
		,th.hb_carisma						AS [Carisma]

FROM	dbo.tb_personagem		tp
JOIN	dbo.tb_arma				ta		ON ta.cd_arma			= tp.cd_arma
JOIN	dbo.tb_armadura			tad		ON tad.cd_armadura		= tp.cd_armadura
JOIN	dbo.tb_habilidade		th		ON tp.cd_personagem		= th.cd_personagem

		