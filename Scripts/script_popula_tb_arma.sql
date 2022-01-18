USE db_rpg

SET NOCOUNT ON

MERGE dbo.tb_arma AS destino
USING	(
		VALUES
			('Adaga','1d4')
			,('Azagaia','1d6')
			,('Bordão','1d6')
			,('Clava Grande','1d8')
			,('Foice Curta','1d4')
			,('Lança','1d6')
			,('Maça','1d6')
			,('Machadinha','1d6')
			,('Martelo Leve','1d4')
			,('Porrete','1d4')
			,('Arco Curto','1d6')
			,('Beste Leve','1d8')
			,('Dardo','1d4')
			,('Funda','1d4')
			,('Alabarda','1d10')
			,('Cimitarra','1d6')
			,('Chicote','1d4')
			,('Espada Curta','1d6')
			,('Espada Grande','2d6')
			,('Espada Longa','1d8')
			,('Glaive','1d10')
			,('Lança de Montaria','1d12')
			,('Lança Longa','1d10')
			,('Maça Estrela','1d8')
			,('Machado Grande','1d12')
			,('Machado de Batalha','1d8')
			,('Malho','2d6')
			,('Mangual','1d8')
			,('Martelo de Guerra','1d8')
			,('Picareta de Guerra','1d8')
			,('Rapieira','1d8')
			,('Tridente','1d6')
			,('Arco Longo','1d8')
			,('Besta de Mão','1d6')
			,('Besta Pesada','1d10')
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
