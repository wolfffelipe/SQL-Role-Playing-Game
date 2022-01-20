USE db_rpg

SET NOCOUNT ON

MERGE dbo.tb_armadura AS destino
USING	(
		VALUES
			 ('Acolchoada',1)
			,('Couro',2)
			,('Couro Batido',3)
			,('Gibão de Peles',2)
			,('Camisão de Malha',3)
			,('Brunea',4)
			,('Peitoral',3)
			,('Meia-Armadura',4)
			,('Cota de Anéis',5)
			,('Cota de Malha',4)
			,('Cota de Talas',5)
			,('Placas',6)
			,('Escudo',1)
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
