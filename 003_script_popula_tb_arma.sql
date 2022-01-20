USE db_rpg

SET NOCOUNT ON

MERGE dbo.tb_arma AS destino
USING	(
		VALUES
			 ('Adaga'				,'1d6')
			,('Azagaia'				,'2d8')
			,('Bordão'				,'2d8')
			,('Clava Grande'		,'2d8')
			,('Foice Curta'			,'2d8')
			,('Lança'				,'2d8')
			,('Maça'				,'2d8')
			,('Machadinha'			,'2d8')
			,('Martelo Leve'		,'2d10')
			,('Porrete'				,'2d10')
			,('Arco Curto'			,'2d10')
			,('Beste Leve'			,'3d10')
			,('Dardo'				,'3d10')
			,('Funda'				,'3d10')
			,('Alabarda'			,'3d10')
			,('Cimitarra'			,'3d10')
			,('Chicote'				,'3d10')
			,('Espada Curta'		,'1d12')
			,('Espada Grande'		,'1d12')
			,('Espada Longa'		,'1d20')
			,('Glaive'				,'1d12')
			,('Lança de Montaria'	,'1d12')
			,('Lança Longa'			,'1d12')
			,('Maça Estrela'		,'1d12')
			,('Machado Grande'		,'1d12')
			,('Machado de Batalha'	,'2d8')
			,('Malho'				,'2d8')
			,('Mangual'				,'2d8')
			,('Martelo de Guerra'	,'1d20')
			,('Picareta de Guerra'	,'2d10')
			,('Rapieira'			,'3d10')
			,('Tridente'			,'3d10')
			,('Arco Longo'			,'3d10')
			,('Besta de Mão'		,'3d12')
			,('Besta Pesada'		,'3d12')
		)
		AS origem	(nm_arma, vl_ataque)

ON (destino.nm_arma = origem.nm_arma)

WHEN MATCHED THEN

	UPDATE SET
	 destino.nm_arma	= origem.nm_arma
	,destino.vl_ataque	= origem.vl_ataque

WHEN NOT MATCHED BY TARGET THEN

	INSERT (nm_arma, vl_ataque)
	VALUES (origem.nm_arma, origem.vl_ataque)

WHEN NOT MATCHED BY SOURCE THEN

	DELETE;
