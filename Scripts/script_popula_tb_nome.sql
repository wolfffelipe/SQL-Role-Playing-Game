USE db_rpg

SET NOCOUNT ON

MERGE dbo.tb_nome AS destino
USING	(
		VALUES
			 ('Phareman')		,('Thybaut')		,('Gautzelin')
			,('Godfree')		,('Girardus')		,('Gerould')
			,('Gualterius')		,('Gocelinus')		,('Lambin')
			,('Tobye')			,('Conayn')			,('Joppa')
			,('Hamlyn')			,('Percival')		,('Americus')
			,('Reginalde')		,('Nicky')			,('Teodorico')
			,('Carle')			,('Huchon')			,('Molde')
			,('Thomas')			,('Elizabetha')		,('Swetelove')
			,('Gisella')		,('Evelot')			,('Mahaut')
			,('Joetta')			,('Jessimond')		,('Aalis')
			,('Kalis')			,('Jarid')			,('Príncipe')
			,('Jaime')			,('Lã')				,('Marcus')
			,('Maximiliano')	,('Máximo')			,('Trobe')
			,('Cerecei')		,('Kai')			,('Amanta')
			,('Amaranta')		,('Svenhylde')		,('Hrigjold')
			,('Agagrdrifa')		,('Hrurior')		,('Skaldr')
			,('Svepul')			,('Skaronul')		,('Geimadra')
			,('Frileif')		,('Regigabi')		,('Hivif')
			,('Sanrun')			,('Hjogjold')		,('Hervif')
			,('Goronul')		,('Gerun')			,('Mipul')
			,('Rogjold')		,('Ald')			,('Skondul')
			,('Regirja')		,('Thrugin')		,('Sind')
			,('Satha')			,('Svarja')			,('Sannhildr')
			,('Hangus')			,('Hladmadra')		,('Vala')
			,('Skolmold')		,('Se')				,('Tyunn')
			,('Ainda')			,('Tyorgrirn')		,('Vorrus')
			,('Grafralf')		,('Raslerd')		,('Thrunskulr')
			,('Eirkmuvoth')		,('Stappaekkag')	,('Sguf')
			,('Smik')			,('Fralf')			,('Brelgaumm')
			,('Ghortmir')		,('Rhendraek')		,('Relpamm')
			,('Neredr')			,('Norngestaet')	,('Hofnolsaern')
			,('Gwo')			,('Kiog')			,('Gweih')
			,('Teigde')			,('Fulhif')			,('Velfhus')
			,('Algra')			,('Ghindrin')		,('Murkuta')
			,('Soymalhu')		,('Trul')			,('Grun')
			,('Rhi')			,('Asvah')			,('Grergi')
			,('Gridieh')		,('Vuolomirh')		,('Marrecud')
			,('Miosath')		,('Boromir')		,('Bilson')
			,('Aumento')		,('Lak')			,('Loky')
			,('Marrik')			,('Moes')			,('Marsit')
			,('Anatólia')		,('Espyd Ard')		,('Frontin Bear')
			,('Montenio')		,('Trifoth')		,('Fraeymuh')
			,('Fegnirsti')		,('Galgrieyma')		,('Jhoyn Macar')

		)
		AS origem	(nm_nome)

ON (destino.nm_nome = origem.nm_nome)

WHEN MATCHED THEN

	UPDATE SET
	destino.nm_nome = origem.nm_nome

WHEN NOT MATCHED BY TARGET THEN

	INSERT (nm_nome)
	VALUES (origem.nm_nome)

WHEN NOT MATCHED BY SOURCE THEN

	DELETE;
