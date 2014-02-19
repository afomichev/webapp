/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
DECLARE @v sql_variant 
SET @v = N'Companies'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'bs_Companies', NULL, NULL
GO
ALTER TABLE dbo.bs_Companies SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
DECLARE @v sql_variant 
SET @v = N'Clients'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'bs_Clients', NULL, NULL
GO
ALTER TABLE dbo.bs_Clients SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
DECLARE @v sql_variant 
SET @v = N'Client Products'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'bs_ClientProducts', NULL, NULL
GO
ALTER TABLE dbo.bs_ClientProducts SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
DECLARE @v sql_variant 
SET @v = N'Client FTP Rates'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'bs_ClientFTPRates', NULL, NULL
GO
ALTER TABLE dbo.bs_ClientFTPRates ADD CONSTRAINT
	FK_bs_ClientFTPRates_bs_Clients FOREIGN KEY
	(
	ClientID
	) REFERENCES dbo.bs_Clients
	(
	ClientID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.bs_ClientFTPRates ADD CONSTRAINT
	FK_bs_ClientFTPRates_bs_ClientProducts FOREIGN KEY
	(
	ProductID
	) REFERENCES dbo.bs_ClientProducts
	(
	CPID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.bs_ClientFTPRates SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
DECLARE @v sql_variant 
SET @v = N'Client Entities'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'bs_ClientEntities', NULL, NULL
GO
ALTER TABLE dbo.bs_ClientEntities SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
DECLARE @v sql_variant 
SET @v = N'Client Meetings'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'bs_ClientMeetings', NULL, NULL
GO
ALTER TABLE dbo.bs_ClientMeetings ADD CONSTRAINT
	FK_bs_ClientMeetings_bs_Clients FOREIGN KEY
	(
	ClientID
	) REFERENCES dbo.bs_Clients
	(
	ClientID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.bs_ClientMeetings ADD CONSTRAINT
	FK_bs_ClientMeetings_bs_ClientEntities FOREIGN KEY
	(
	ClientEntityID
	) REFERENCES dbo.bs_ClientEntities
	(
	ClientEntityID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.bs_ClientMeetings SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
DECLARE @v sql_variant 
SET @v = N'Client Entity Limits'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'bs_ClientEntityLimits', NULL, NULL
GO
ALTER TABLE dbo.bs_ClientEntityLimits ADD CONSTRAINT
	FK_bs_ClientEntityLimits_bs_ClientEntities FOREIGN KEY
	(
	ClientEntityID
	) REFERENCES dbo.bs_ClientEntities
	(
	ClientEntityID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.bs_ClientEntityLimits ADD CONSTRAINT
	FK_bs_ClientEntityLimits_bs_Clients FOREIGN KEY
	(
	ClientID
	) REFERENCES dbo.bs_Clients
	(
	ClientID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.bs_ClientEntityLimits SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.bs_SectorOKVED SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.bs_SectorBank SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.bs_Clients ADD CONSTRAINT
	FK_bs_Clients_bs_SectorBank FOREIGN KEY
	(
	SectorBankID
	) REFERENCES dbo.bs_SectorBank
	(
	SectorBankID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.bs_Clients ADD CONSTRAINT
	FK_bs_Clients_bs_SectorOKVED FOREIGN KEY
	(
	SectorOKVEDID
	) REFERENCES dbo.bs_SectorOKVED
	(
	SectorOKVEDID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.bs_Clients SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
