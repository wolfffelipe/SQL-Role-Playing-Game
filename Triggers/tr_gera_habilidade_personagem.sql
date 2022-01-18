CREATE TRIGGER tr_gera_habilidade_personagem ON dbo.tb_personagem AFTER INSERT
AS
BEGIN
	DECLARE @cd_personagem INT

	SELECT @cd_personagem = INSERTED.cd_personagem FROM INSERTED

	EXEC sp_gera_habilidade	@cd_personagem
END
