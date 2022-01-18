USE db_rpg

SET NOCOUNT ON

MERGE dbo.tb_armadura AS destino
USING	(
		VALUES
			 ('Acolchoada',11)
			,('Couro',11)
			,('Couro Batido',12)
			,('Gibão de Peles',12)
			,('Camisão de Malha',13)
			,('Brunea',14)
			,('Peitoral',14)
			,('Meia-Armadura',15)
			,('Cota de Anéis',15)
			,('Cota de Malha',16)
			,('Cota de Talas',17)
			,('Placas',18)
			,('Escudo',2)
		)
		AS origem	(nm_armadura, vl_defesa)

ON (destino.nm_armadura = origem.nm_armadura)

WHEN MATCHED THEN

	UPDATE SET
	 destino.nm_armadura	= origem.nm_armadura
	,destino.vl_defesa		= origem.vl_defesa

WHEN NOT MATCHED BY TARGET THEN

	INSERT (nm_armadura, vl_defesa)
	VALUES (origem.nm_armadura, origem.vl_defesa)

WHEN NOT MATCHED BY SOURCE THEN

	DELETE;
