USE db_rpg

IF OBJECT_ID('dbo.tb_criticidade', 'U')	IS NOT NULL BEGIN DROP TABLE tb_criticidade		END
IF OBJECT_ID('dbo.tb_habilidade', 'U')	IS NOT NULL BEGIN DROP TABLE tb_habilidade		END
IF OBJECT_ID('dbo.tb_personagem', 'U')	IS NOT NULL BEGIN DROP TABLE tb_personagem		END
IF OBJECT_ID('dbo.tb_armadura', 'U')	IS NOT NULL BEGIN DROP TABLE tb_armadura		END
IF OBJECT_ID('dbo.tb_arma', 'U')		IS NOT NULL BEGIN DROP TABLE tb_arma			END
IF OBJECT_ID('dbo.tb_nome', 'U')		IS NOT NULL BEGIN DROP TABLE tb_nome			END
IF OBJECT_ID('dbo.tb_raca_classe', 'U')	IS NOT NULL BEGIN DROP TABLE tb_raca_classe		END

CREATE TABLE tb_raca_classe
(
	 cd_rc			INT						NOT NULL IDENTITY UNIQUE
	,nm_rc			VARCHAR(50)				NULL
	,desc_rc		VARCHAR(500)			NULL
	,defi_rc		BIT						NULL
	
	,CONSTRAINT		pk_codigo_raca_classe	PRIMARY KEY (cd_rc)
)

CREATE TABLE tb_nome
(
	 cd_nome		INT				NOT NULL IDENTITY UNIQUE
	,nm_nome		VARCHAR(50)		NULL
	
	,CONSTRAINT		pk_codigo_nome	PRIMARY KEY (cd_nome)
)

CREATE TABLE tb_arma
(
	 cd_arma		INT				NOT NULL IDENTITY UNIQUE
	,nm_arma		VARCHAR(100)	NULL
	,vl_ataque		VARCHAR(5)		NULL
	
	,CONSTRAINT		pk_codigo_arma	PRIMARY KEY (cd_arma)
)

CREATE TABLE tb_armadura
(
	 cd_armadura	INT					NOT NULL IDENTITY UNIQUE
	,nm_armadura	VARCHAR(100)		NULL
	,vl_defesa		INT					NULL
	
	,CONSTRAINT		pk_codigo_armadura	PRIMARY KEY (cd_armadura)
)

CREATE TABLE tb_personagem
(
	 cd_personagem		INT							NOT NULL IDENTITY UNIQUE
	,nm_jogador			VARCHAR(100)				NULL
	,nm_personagem		VARCHAR(100)				NULL
	,cd_raca			INT							NULL
	,cd_classe			INT							NULL
	,pe_nivel			INT							NULL
	,pe_tendencia		VARCHAR(50)					NULL
	,pe_sexo			CHAR(1)						NULL
	,pe_pdv				INT							NULL
	,cd_arma			INT							NULL
	,cd_armadura		INT							NULL
	
	,CONSTRAINT		pk_codigo_personagem			PRIMARY KEY (cd_personagem)
	,CONSTRAINT		fk_codigo_personagem_raca		FOREIGN KEY (cd_raca)			REFERENCES tb_raca_classe(cd_rc)
	,CONSTRAINT		fk_codigo_personagem_classe		FOREIGN KEY (cd_classe)			REFERENCES tb_raca_classe(cd_rc)
	,CONSTRAINT		fk_codigo_personagem_arma		FOREIGN KEY (cd_arma)			REFERENCES tb_arma(cd_arma)
	,CONSTRAINT		fk_codigo_personagem_armadura	FOREIGN KEY (cd_armadura)		REFERENCES tb_armadura(cd_armadura)
	,CONSTRAINT		chk_sexo						CHECK (pe_sexo = 'M' OR pe_sexo = 'F')
)

CREATE TABLE tb_habilidade
(
	 cd_habilidade			INT						NOT NULL IDENTITY UNIQUE
	,cd_personagem			INT						NULL
	,hb_forca				SMALLINT				NULL
	,hb_destreza			SMALLINT				NULL
	,hb_constituicao		SMALLINT				NULL
	,hb_inteligencia		SMALLINT				NULL
	,hb_sabedoria			SMALLINT				NULL
	,hb_carisma				SMALLINT				NULL
	
	,CONSTRAINT		pk_codigo_habilidade			PRIMARY KEY (cd_habilidade)
	,CONSTRAINT		fk_codigo_habilidade_personagem FOREIGN KEY (cd_personagem)		REFERENCES tb_personagem(cd_personagem)
)

CREATE TABLE tb_criticidade
(
	 cd_criticidade			INT						NOT NULL IDENTITY UNIQUE
	,cd_acerto_erro			SMALLINT				NULL
	,desc_criticidade		VARCHAR(500)			NULL
	
	,CONSTRAINT		pk_codigo_criticidade			PRIMARY KEY (cd_criticidade)
)