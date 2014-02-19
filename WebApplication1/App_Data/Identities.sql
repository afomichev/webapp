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
CREATE TABLE dbo.Tmp_bs_ActualFinancials
	(
	ActualFinancialID int NOT NULL IDENTITY (1, 1),
	Name varchar(50) NULL,
	BBG_Code varchar(50) NULL,
	SectoralUsage varchar(50) NULL,
	FinancialStatement varchar(50) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_ActualFinancials SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ActualFinancials ON
GO
IF EXISTS(SELECT * FROM dbo.bs_ActualFinancials)
	 EXEC('INSERT INTO dbo.Tmp_bs_ActualFinancials (ActualFinancialID, Name, BBG_Code, SectoralUsage, FinancialStatement)
		SELECT ActualFinancialID, Name, BBG_Code, SectoralUsage, FinancialStatement FROM dbo.bs_ActualFinancials WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ActualFinancials OFF
GO
DROP TABLE dbo.bs_ActualFinancials
GO
EXECUTE sp_rename N'dbo.Tmp_bs_ActualFinancials', N'bs_ActualFinancials', 'OBJECT' 
GO
ALTER TABLE dbo.bs_ActualFinancials ADD CONSTRAINT
	PK_bs_ActualFinancials PRIMARY KEY CLUSTERED 
	(
	ActualFinancialID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_ActualFinancialValues
	(
	ActFinancialValueID int NOT NULL IDENTITY (1, 1),
	ActualFinancialID int NOT NULL,
	CompanyID int NOT NULL,
	Period varchar(50) NOT NULL,
	Value numeric(18, 8) NULL,
	CCYId int NOT NULL,
	AccountingStandard varchar(50) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_ActualFinancialValues SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ActualFinancialValues ON
GO
IF EXISTS(SELECT * FROM dbo.bs_ActualFinancialValues)
	 EXEC('INSERT INTO dbo.Tmp_bs_ActualFinancialValues (ActFinancialValueID, ActualFinancialID, CompanyID, Period, Value, CCYId, AccountingStandard)
		SELECT ActFinancialValueID, ActualFinancialID, CompanyID, Period, Value, CCYId, AccountingStandard FROM dbo.bs_ActualFinancialValues WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ActualFinancialValues OFF
GO
DROP TABLE dbo.bs_ActualFinancialValues
GO
EXECUTE sp_rename N'dbo.Tmp_bs_ActualFinancialValues', N'bs_ActualFinancialValues', 'OBJECT' 
GO
ALTER TABLE dbo.bs_ActualFinancialValues ADD CONSTRAINT
	PK_bs_ActualFinancialValues PRIMARY KEY CLUSTERED 
	(
	ActFinancialValueID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_BankLEs
	(
	BankLEID int NOT NULL IDENTITY (1, 1),
	BankLEName varchar(50) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_BankLEs SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_BankLEs ON
GO
IF EXISTS(SELECT * FROM dbo.bs_BankLEs)
	 EXEC('INSERT INTO dbo.Tmp_bs_BankLEs (BankLEID, BankLEName)
		SELECT BankLEID, BankLEName FROM dbo.bs_BankLEs WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_BankLEs OFF
GO
DROP TABLE dbo.bs_BankLEs
GO
EXECUTE sp_rename N'dbo.Tmp_bs_BankLEs', N'bs_BankLEs', 'OBJECT' 
GO
ALTER TABLE dbo.bs_BankLEs ADD CONSTRAINT
	PK_bs_BankLEs PRIMARY KEY CLUSTERED 
	(
	BankLEID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
ALTER TABLE dbo.bs_Bonds
	DROP CONSTRAINT DF_bs_Bonds_IsBenchmark
GO
ALTER TABLE dbo.bs_Bonds
	DROP CONSTRAINT DF_bs_Bonds_IsDiscountLastCouponYield
GO
CREATE TABLE dbo.Tmp_bs_Bonds
	(
	BondID bigint NOT NULL IDENTITY (1, 1),
	CalculationMethodID bigint NOT NULL,
	CouponTypeID bigint NOT NULL,
	CouponConventionId int NOT NULL,
	CCYID int NOT NULL,
	Nominal decimal(20, 4) NOT NULL,
	IssuerSize decimal(20, 4) NOT NULL,
	IssueDate datetime NOT NULL,
	DatedDate datetime NULL,
	MaturityDate datetime NOT NULL,
	CouponDays int NOT NULL,
	CouponRate decimal(20, 4) NOT NULL,
	CouponFreq int NULL,
	SettlementPeriod int NOT NULL,
	IsBenchmark bit NOT NULL,
	IsDiscountLastCouponYield bit NOT NULL,
	IsEffectiveRate bit NOT NULL,
	FirstCoupon varchar(100) NOT NULL,
	FinalPeriod varchar(100) NOT NULL,
	YieldCalcPriority int NULL,
	SpreadInstrumentGroupID bigint NULL,
	SpreadAlgorithmID int NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_Bonds SET (LOCK_ESCALATION = TABLE)
GO
ALTER TABLE dbo.Tmp_bs_Bonds ADD CONSTRAINT
	DF_bs_Bonds_IsBenchmark DEFAULT ((0)) FOR IsBenchmark
GO
ALTER TABLE dbo.Tmp_bs_Bonds ADD CONSTRAINT
	DF_bs_Bonds_IsDiscountLastCouponYield DEFAULT ((0)) FOR IsDiscountLastCouponYield
GO
SET IDENTITY_INSERT dbo.Tmp_bs_Bonds ON
GO
IF EXISTS(SELECT * FROM dbo.bs_Bonds)
	 EXEC('INSERT INTO dbo.Tmp_bs_Bonds (BondID, CalculationMethodID, CouponTypeID, CouponConventionId, CCYID, Nominal, IssuerSize, IssueDate, DatedDate, MaturityDate, CouponDays, CouponRate, CouponFreq, SettlementPeriod, IsBenchmark, IsDiscountLastCouponYield, IsEffectiveRate, FirstCoupon, FinalPeriod, YieldCalcPriority, SpreadInstrumentGroupID, SpreadAlgorithmID)
		SELECT BondID, CalculationMethodID, CouponTypeID, CouponConventionId, CCYID, Nominal, IssuerSize, IssueDate, DatedDate, MaturityDate, CouponDays, CouponRate, CouponFreq, SettlementPeriod, IsBenchmark, IsDiscountLastCouponYield, IsEffectiveRate, FirstCoupon, FinalPeriod, YieldCalcPriority, SpreadInstrumentGroupID, SpreadAlgorithmID FROM dbo.bs_Bonds WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_Bonds OFF
GO
DROP TABLE dbo.bs_Bonds
GO
EXECUTE sp_rename N'dbo.Tmp_bs_Bonds', N'bs_Bonds', 'OBJECT' 
GO
ALTER TABLE dbo.bs_Bonds ADD CONSTRAINT
	PK_bs_Bonds PRIMARY KEY CLUSTERED 
	(
	BondID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_CCYValues
	(
	CCYValueID int NOT NULL IDENTITY (1, 1),
	Moment datetime NOT NULL,
	CCYPairID int NOT NULL,
	Value numeric(18, 8) NULL,
	RSI14D numeric(18, 8) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_CCYValues SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_CCYValues ON
GO
IF EXISTS(SELECT * FROM dbo.bs_CCYValues)
	 EXEC('INSERT INTO dbo.Tmp_bs_CCYValues (CCYValueID, Moment, CCYPairID, Value, RSI14D)
		SELECT CCYValueID, Moment, CCYPairID, Value, RSI14D FROM dbo.bs_CCYValues WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_CCYValues OFF
GO
DROP TABLE dbo.bs_CCYValues
GO
EXECUTE sp_rename N'dbo.Tmp_bs_CCYValues', N'bs_CCYValues', 'OBJECT' 
GO
ALTER TABLE dbo.bs_CCYValues ADD CONSTRAINT
	PK_bs_CCYValues PRIMARY KEY CLUSTERED 
	(
	CCYValueID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_ClientEntities
	(
	ClientEntityID int NOT NULL IDENTITY (1, 1),
	ClientID int NULL,
	EntityName varchar(50) NULL,
	SectorBankID int NOT NULL,
	SectorOKVEDID int NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_ClientEntities SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ClientEntities ON
GO
IF EXISTS(SELECT * FROM dbo.bs_ClientEntities)
	 EXEC('INSERT INTO dbo.Tmp_bs_ClientEntities (ClientEntityID, ClientID, EntityName, SectorBankID, SectorOKVEDID)
		SELECT ClientEntityID, ClientID, EntityName, SectorBankID, SectorOKVEDID FROM dbo.bs_ClientEntities WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ClientEntities OFF
GO
DROP TABLE dbo.bs_ClientEntities
GO
EXECUTE sp_rename N'dbo.Tmp_bs_ClientEntities', N'bs_ClientEntities', 'OBJECT' 
GO
ALTER TABLE dbo.bs_ClientEntities ADD CONSTRAINT
	PK_bs_ClientEntities PRIMARY KEY CLUSTERED 
	(
	ClientEntityID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_ClientEntityLimits
	(
	CELID int NOT NULL IDENTITY (1, 1),
	ClientID int NULL,
	ClientEntityID int NOT NULL,
	ProductID int NOT NULL,
	LimitValue numeric(18, 8) NOT NULL,
	CCYID int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_ClientEntityLimits SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ClientEntityLimits ON
GO
IF EXISTS(SELECT * FROM dbo.bs_ClientEntityLimits)
	 EXEC('INSERT INTO dbo.Tmp_bs_ClientEntityLimits (CELID, ClientID, ClientEntityID, ProductID, LimitValue, CCYID)
		SELECT CELID, ClientID, ClientEntityID, ProductID, LimitValue, CCYID FROM dbo.bs_ClientEntityLimits WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ClientEntityLimits OFF
GO
DROP TABLE dbo.bs_ClientEntityLimits
GO
EXECUTE sp_rename N'dbo.Tmp_bs_ClientEntityLimits', N'bs_ClientEntityLimits', 'OBJECT' 
GO
ALTER TABLE dbo.bs_ClientEntityLimits ADD CONSTRAINT
	PK_sp_ClientEntityLimits PRIMARY KEY CLUSTERED 
	(
	CELID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_ClientFTPRates
	(
	CFTPID int NOT NULL IDENTITY (1, 1),
	ClientID int NULL,
	ClientEntityID int NULL,
	RateValue numeric(10, 10) NULL,
	DateEffective datetime NULL,
	PmtFreq numeric(18, 5) NULL,
	CCYID int NULL,
	Active bit NULL,
	ProductID int NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_ClientFTPRates SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ClientFTPRates ON
GO
IF EXISTS(SELECT * FROM dbo.bs_ClientFTPRates)
	 EXEC('INSERT INTO dbo.Tmp_bs_ClientFTPRates (CFTPID, ClientID, ClientEntityID, RateValue, DateEffective, PmtFreq, CCYID, Active, ProductID)
		SELECT CFTPID, ClientID, ClientEntityID, RateValue, DateEffective, PmtFreq, CCYID, Active, ProductID FROM dbo.bs_ClientFTPRates WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ClientFTPRates OFF
GO
DROP TABLE dbo.bs_ClientFTPRates
GO
EXECUTE sp_rename N'dbo.Tmp_bs_ClientFTPRates', N'bs_ClientFTPRates', 'OBJECT' 
GO
ALTER TABLE dbo.bs_ClientFTPRates ADD CONSTRAINT
	PK_bs_ClientFTPRates PRIMARY KEY CLUSTERED 
	(
	CFTPID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_ClientLimits
	(
	CLID int NOT NULL IDENTITY (1, 1),
	ClientID int NOT NULL,
	ProductID int NOT NULL,
	LimitValue numeric(18, 8) NOT NULL,
	CCYID int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_ClientLimits SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ClientLimits ON
GO
IF EXISTS(SELECT * FROM dbo.bs_ClientLimits)
	 EXEC('INSERT INTO dbo.Tmp_bs_ClientLimits (CLID, ClientID, ProductID, LimitValue, CCYID)
		SELECT CLID, ClientID, ProductID, LimitValue, CCYID FROM dbo.bs_ClientLimits WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ClientLimits OFF
GO
DROP TABLE dbo.bs_ClientLimits
GO
EXECUTE sp_rename N'dbo.Tmp_bs_ClientLimits', N'bs_ClientLimits', 'OBJECT' 
GO
ALTER TABLE dbo.bs_ClientLimits ADD CONSTRAINT
	PK_bs_ClientLimits PRIMARY KEY CLUSTERED 
	(
	CLID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_ClientMeetings
	(
	ClientMtgID int NOT NULL IDENTITY (1, 1),
	ClientID int NULL,
	ClientEntityID int NULL,
	Date datetime NULL,
	Subject varchar(500) NULL,
	RM varchar(50) NULL,
	Contacts varchar(500) NULL,
	Results varchar(500) NULL,
	Questions varchar(500) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_ClientMeetings SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ClientMeetings ON
GO
IF EXISTS(SELECT * FROM dbo.bs_ClientMeetings)
	 EXEC('INSERT INTO dbo.Tmp_bs_ClientMeetings (ClientMtgID, ClientID, ClientEntityID, Date, Subject, RM, Contacts, Results, Questions)
		SELECT ClientMtgID, ClientID, ClientEntityID, Date, Subject, RM, Contacts, Results, Questions FROM dbo.bs_ClientMeetings WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ClientMeetings OFF
GO
DROP TABLE dbo.bs_ClientMeetings
GO
EXECUTE sp_rename N'dbo.Tmp_bs_ClientMeetings', N'bs_ClientMeetings', 'OBJECT' 
GO
ALTER TABLE dbo.bs_ClientMeetings ADD CONSTRAINT
	PK_bs_ClientMeetings PRIMARY KEY CLUSTERED 
	(
	ClientMtgID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_ClientProducts
	(
	CPID int NOT NULL IDENTITY (1, 1),
	ClientID int NULL,
	ClientEntityID int NOT NULL,
	ProductID int NOT NULL,
	DateAgreed datetime NULL,
	DateIssued datetime NOT NULL,
	DateEffective datetime NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_ClientProducts SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ClientProducts ON
GO
IF EXISTS(SELECT * FROM dbo.bs_ClientProducts)
	 EXEC('INSERT INTO dbo.Tmp_bs_ClientProducts (CPID, ClientID, ClientEntityID, ProductID, DateAgreed, DateIssued, DateEffective)
		SELECT CPID, ClientID, ClientEntityID, ProductID, DateAgreed, DateIssued, DateEffective FROM dbo.bs_ClientProducts WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_ClientProducts OFF
GO
DROP TABLE dbo.bs_ClientProducts
GO
EXECUTE sp_rename N'dbo.Tmp_bs_ClientProducts', N'bs_ClientProducts', 'OBJECT' 
GO
ALTER TABLE dbo.bs_ClientProducts ADD CONSTRAINT
	PK_bs_ClientProducts PRIMARY KEY CLUSTERED 
	(
	CPID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_Clients
	(
	ClientID int NOT NULL IDENTITY (1, 1),
	Name varchar(50) NULL,
	Address varchar(50) NULL,
	PrimaryContact varchar(50) NOT NULL,
	CountryOfRiskID int NULL,
	GICSSubIndustryID int NULL,
	SectorBankID int NOT NULL,
	SectorOKVEDID int NOT NULL,
	CategoryID int NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_Clients SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_Clients ON
GO
IF EXISTS(SELECT * FROM dbo.bs_Clients)
	 EXEC('INSERT INTO dbo.Tmp_bs_Clients (ClientID, Name, Address, PrimaryContact, CountryOfRiskID, GICSSubIndustryID, SectorBankID, SectorOKVEDID, CategoryID)
		SELECT ClientID, Name, Address, PrimaryContact, CountryOfRiskID, GICSSubIndustryID, SectorBankID, SectorOKVEDID, CategoryID FROM dbo.bs_Clients WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_Clients OFF
GO
DROP TABLE dbo.bs_Clients
GO
EXECUTE sp_rename N'dbo.Tmp_bs_Clients', N'bs_Clients', 'OBJECT' 
GO
ALTER TABLE dbo.bs_Clients ADD CONSTRAINT
	PK_bs_Clients PRIMARY KEY CLUSTERED 
	(
	ClientID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_Companies
	(
	CompanyID int NOT NULL IDENTITY (1, 1),
	ClientID int NULL,
	ClientEntityID int NULL,
	CompanyName varchar(50) NULL,
	CompanyDescription varchar(MAX) NULL,
	FiscalYrEndMonth int NULL,
	ReportingCCYID int NULL,
	IsMultinational bit NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_Companies SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_Companies ON
GO
IF EXISTS(SELECT * FROM dbo.bs_Companies)
	 EXEC('INSERT INTO dbo.Tmp_bs_Companies (CompanyID, ClientID, ClientEntityID, CompanyName, CompanyDescription, FiscalYrEndMonth, ReportingCCYID, IsMultinational)
		SELECT CompanyID, ClientID, ClientEntityID, CompanyName, CompanyDescription, FiscalYrEndMonth, ReportingCCYID, IsMultinational FROM dbo.bs_Companies WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_Companies OFF
GO
DROP TABLE dbo.bs_Companies
GO
EXECUTE sp_rename N'dbo.Tmp_bs_Companies', N'bs_Companies', 'OBJECT' 
GO
ALTER TABLE dbo.bs_Companies ADD CONSTRAINT
	PK_bs_Companies PRIMARY KEY CLUSTERED 
	(
	CompanyID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_Currencies
	(
	CCYId int NOT NULL IDENTITY (1, 1),
	Currency varchar(50) NOT NULL,
	Ticker varchar(50) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_Currencies SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_Currencies ON
GO
IF EXISTS(SELECT * FROM dbo.bs_Currencies)
	 EXEC('INSERT INTO dbo.Tmp_bs_Currencies (CCYId, Currency, Ticker)
		SELECT CCYId, Currency, Ticker FROM dbo.bs_Currencies WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_Currencies OFF
GO
ALTER TABLE dbo.bs_CurrencyPairs
	DROP CONSTRAINT FK_bs_CurrencyPairs_bs_Currencies
GO
ALTER TABLE dbo.bs_CurrencyPairs
	DROP CONSTRAINT FK_bs_CurrencyPairs_bs_Currencies1
GO
DROP TABLE dbo.bs_Currencies
GO
EXECUTE sp_rename N'dbo.Tmp_bs_Currencies', N'bs_Currencies', 'OBJECT' 
GO
ALTER TABLE dbo.bs_Currencies ADD CONSTRAINT
	PK_bs_Currencies PRIMARY KEY CLUSTERED 
	(
	CCYId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.bs_CurrencyPairs ADD CONSTRAINT
	FK_bs_CurrencyPairs_bs_Currencies FOREIGN KEY
	(
	CCY1ID
	) REFERENCES dbo.bs_Currencies
	(
	CCYId
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.bs_CurrencyPairs ADD CONSTRAINT
	FK_bs_CurrencyPairs_bs_Currencies1 FOREIGN KEY
	(
	CCY2ID
	) REFERENCES dbo.bs_Currencies
	(
	CCYId
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.bs_CurrencyPairs SET (LOCK_ESCALATION = TABLE)
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
CREATE TABLE dbo.Tmp_bs_Currencies
	(
	CCYId int NOT NULL IDENTITY (1, 1),
	Currency varchar(50) NOT NULL,
	Ticker varchar(50) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_Currencies SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_Currencies ON
GO
IF EXISTS(SELECT * FROM dbo.bs_Currencies)
	 EXEC('INSERT INTO dbo.Tmp_bs_Currencies (CCYId, Currency, Ticker)
		SELECT CCYId, Currency, Ticker FROM dbo.bs_Currencies WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_Currencies OFF
GO
ALTER TABLE dbo.bs_CurrencyPairs
	DROP CONSTRAINT FK_bs_CurrencyPairs_bs_Currencies
GO
ALTER TABLE dbo.bs_CurrencyPairs
	DROP CONSTRAINT FK_bs_CurrencyPairs_bs_Currencies1
GO
DROP TABLE dbo.bs_Currencies
GO
EXECUTE sp_rename N'dbo.Tmp_bs_Currencies', N'bs_Currencies', 'OBJECT' 
GO
ALTER TABLE dbo.bs_Currencies ADD CONSTRAINT
	PK_bs_Currencies PRIMARY KEY CLUSTERED 
	(
	CCYId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_bs_CurrencyPairs
	(
	CCYPairID int NOT NULL IDENTITY (1, 1),
	Ticker varchar(50) NOT NULL,
	CCY1ID int NOT NULL,
	CCY2ID int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_CurrencyPairs SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_CurrencyPairs ON
GO
IF EXISTS(SELECT * FROM dbo.bs_CurrencyPairs)
	 EXEC('INSERT INTO dbo.Tmp_bs_CurrencyPairs (CCYPairID, Ticker, CCY1ID, CCY2ID)
		SELECT CCYPairID, Ticker, CCY1ID, CCY2ID FROM dbo.bs_CurrencyPairs WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_CurrencyPairs OFF
GO
DROP TABLE dbo.bs_CurrencyPairs
GO
EXECUTE sp_rename N'dbo.Tmp_bs_CurrencyPairs', N'bs_CurrencyPairs', 'OBJECT' 
GO
ALTER TABLE dbo.bs_CurrencyPairs ADD CONSTRAINT
	PK_bs_CurrencyPairs PRIMARY KEY CLUSTERED 
	(
	CCYPairID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.bs_CurrencyPairs ADD CONSTRAINT
	FK_bs_CurrencyPairs_bs_Currencies FOREIGN KEY
	(
	CCY1ID
	) REFERENCES dbo.bs_Currencies
	(
	CCYId
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.bs_CurrencyPairs ADD CONSTRAINT
	FK_bs_CurrencyPairs_bs_Currencies1 FOREIGN KEY
	(
	CCY2ID
	) REFERENCES dbo.bs_Currencies
	(
	CCYId
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
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
CREATE TABLE dbo.Tmp_bs_GICSMap
	(
	GICSSubindustryID int NOT NULL IDENTITY (1, 1),
	SectorCode varchar(50) NULL,
	SectorName varchar(50) NULL,
	IndustryGroupCode varchar(50) NULL,
	IndustryGroupName varchar(50) NULL,
	IndustryCode varchar(50) NULL,
	IndustryName varchar(50) NULL,
	SubindustryCode varchar(50) NULL,
	SubindustryName varchar(50) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_GICSMap SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_GICSMap ON
GO
IF EXISTS(SELECT * FROM dbo.bs_GICSMap)
	 EXEC('INSERT INTO dbo.Tmp_bs_GICSMap (GICSSubindustryID, SectorCode, SectorName, IndustryGroupCode, IndustryGroupName, IndustryCode, IndustryName, SubindustryCode, SubindustryName)
		SELECT GICSSubindustryID, SectorCode, SectorName, IndustryGroupCode, IndustryGroupName, IndustryCode, IndustryName, SubindustryCode, SubindustryName FROM dbo.bs_GICSMap WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_GICSMap OFF
GO
DROP TABLE dbo.bs_GICSMap
GO
EXECUTE sp_rename N'dbo.Tmp_bs_GICSMap', N'bs_GICSMap', 'OBJECT' 
GO
ALTER TABLE dbo.bs_GICSMap ADD CONSTRAINT
	PK_bs_GICSMap PRIMARY KEY CLUSTERED 
	(
	GICSSubindustryID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
ALTER TABLE dbo.bs_LoanPaymentSchedule
	DROP CONSTRAINT DF_bs_LoanPaymentSchedule_Active
GO
ALTER TABLE dbo.bs_LoanPaymentSchedule
	DROP CONSTRAINT DF_bs_LoanPaymentSchedule_PaymentKnown
GO
CREATE TABLE dbo.Tmp_bs_LoanPaymentSchedule
	(
	LoanPaymentScheduleId int NOT NULL IDENTITY (1, 1),
	LoanTypeID int NOT NULL,
	LoanID int NULL,
	BondPaymentScheduleTypeId int NOT NULL,
	DateValue datetime NOT NULL,
	PaymentValue numeric(18, 8) NOT NULL,
	Active bit NOT NULL,
	PaymentKnown bit NOT NULL,
	Comment nvarchar(2000) NULL,
	PaymentSettled bit NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_LoanPaymentSchedule SET (LOCK_ESCALATION = TABLE)
GO
ALTER TABLE dbo.Tmp_bs_LoanPaymentSchedule ADD CONSTRAINT
	DF_bs_LoanPaymentSchedule_Active DEFAULT ((1)) FOR Active
GO
ALTER TABLE dbo.Tmp_bs_LoanPaymentSchedule ADD CONSTRAINT
	DF_bs_LoanPaymentSchedule_PaymentKnown DEFAULT ((0)) FOR PaymentKnown
GO
SET IDENTITY_INSERT dbo.Tmp_bs_LoanPaymentSchedule ON
GO
IF EXISTS(SELECT * FROM dbo.bs_LoanPaymentSchedule)
	 EXEC('INSERT INTO dbo.Tmp_bs_LoanPaymentSchedule (LoanPaymentScheduleId, LoanTypeID, LoanID, BondPaymentScheduleTypeId, DateValue, PaymentValue, Active, PaymentKnown, Comment, PaymentSettled)
		SELECT LoanPaymentScheduleId, LoanTypeID, LoanID, BondPaymentScheduleTypeId, DateValue, PaymentValue, Active, PaymentKnown, Comment, PaymentSettled FROM dbo.bs_LoanPaymentSchedule WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_LoanPaymentSchedule OFF
GO
DROP TABLE dbo.bs_LoanPaymentSchedule
GO
EXECUTE sp_rename N'dbo.Tmp_bs_LoanPaymentSchedule', N'bs_LoanPaymentSchedule', 'OBJECT' 
GO
ALTER TABLE dbo.bs_LoanPaymentSchedule ADD CONSTRAINT
	PK_bs_LoanPaymentSchedule PRIMARY KEY CLUSTERED 
	(
	LoanPaymentScheduleId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_LoanTypes
	(
	LoanTypeId int NOT NULL IDENTITY (1, 1),
	LoanTypeName varchar(50) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_LoanTypes SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_LoanTypes ON
GO
IF EXISTS(SELECT * FROM dbo.bs_LoanTypes)
	 EXEC('INSERT INTO dbo.Tmp_bs_LoanTypes (LoanTypeId, LoanTypeName)
		SELECT LoanTypeID, LoanTypeName FROM dbo.bs_LoanTypes WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_LoanTypes OFF
GO
DROP TABLE dbo.bs_LoanTypes
GO
EXECUTE sp_rename N'dbo.Tmp_bs_LoanTypes', N'bs_LoanTypes', 'OBJECT' 
GO
ALTER TABLE dbo.bs_LoanTypes ADD CONSTRAINT
	PK_bs_LoanTypes PRIMARY KEY CLUSTERED 
	(
	LoanTypeId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_Products
	(
	ProductID int NOT NULL IDENTITY (1, 1),
	ProductName varchar(50) NULL,
	MIRCODE varchar(50) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_Products SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_Products ON
GO
IF EXISTS(SELECT * FROM dbo.bs_Products)
	 EXEC('INSERT INTO dbo.Tmp_bs_Products (ProductID, ProductName, MIRCODE)
		SELECT ProductID, ProductName, MIRCODE FROM dbo.bs_Products WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_Products OFF
GO
DROP TABLE dbo.bs_Products
GO
EXECUTE sp_rename N'dbo.Tmp_bs_Products', N'bs_Products', 'OBJECT' 
GO
ALTER TABLE dbo.bs_Products ADD CONSTRAINT
	PK_bs_Products PRIMARY KEY CLUSTERED 
	(
	ProductID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_SectorBank
	(
	SectorBankID int NOT NULL IDENTITY (1, 1),
	SectorBankName varchar(50) NOT NULL,
	GICSSubindustryID int NULL,
	SectorOKVEDID int NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_SectorBank SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_SectorBank ON
GO
IF EXISTS(SELECT * FROM dbo.bs_SectorBank)
	 EXEC('INSERT INTO dbo.Tmp_bs_SectorBank (SectorBankID, SectorBankName, GICSSubindustryID, SectorOKVEDID)
		SELECT SectorBankID, SectorBankName, GICSSubindustryID, SectorOKVEDID FROM dbo.bs_SectorBank WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_SectorBank OFF
GO
DROP TABLE dbo.bs_SectorBank
GO
EXECUTE sp_rename N'dbo.Tmp_bs_SectorBank', N'bs_SectorBank', 'OBJECT' 
GO
ALTER TABLE dbo.bs_SectorBank ADD CONSTRAINT
	PK_bs_SectorBank PRIMARY KEY CLUSTERED 
	(
	SectorBankID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

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
CREATE TABLE dbo.Tmp_bs_VanillaLoans
	(
	VanillaLoanID int NOT NULL IDENTITY (1, 1),
	ClientID int NULL,
	ClientEntityID int NULL,
	CalculationMethodID bigint NOT NULL,
	InterestRateTypeID bigint NOT NULL,
	CCYID int NOT NULL,
	AmountIssued numeric(18, 8) NOT NULL,
	IssueDate datetime NOT NULL,
	DatedDate datetime NULL,
	MaturityDate datetime NOT NULL,
	InterestRateDays int NOT NULL,
	InterestRateValue numeric(18, 8) NOT NULL,
	PaymentFreq numeric(18, 8) NULL,
	SettlementPeriod int NOT NULL,
	FirstCoupon varchar(100) NOT NULL,
	FinalPeriod varchar(100) NOT NULL,
	IsAmortized bit NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_bs_VanillaLoans SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_bs_VanillaLoans ON
GO
IF EXISTS(SELECT * FROM dbo.bs_VanillaLoans)
	 EXEC('INSERT INTO dbo.Tmp_bs_VanillaLoans (VanillaLoanID, ClientID, ClientEntityID, CalculationMethodID, InterestRateTypeID, CCYID, AmountIssued, IssueDate, DatedDate, MaturityDate, InterestRateDays, InterestRateValue, PaymentFreq, SettlementPeriod, FirstCoupon, FinalPeriod, IsAmortized)
		SELECT VanillaLoanID, ClientID, ClientEntityID, CalculationMethodID, InterestRateTypeID, CCYID, AmountIssued, IssueDate, DatedDate, MaturityDate, InterestRateDays, InterestRateValue, PaymentFreq, SettlementPeriod, FirstCoupon, FinalPeriod, IsAmortized FROM dbo.bs_VanillaLoans WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_bs_VanillaLoans OFF
GO
DROP TABLE dbo.bs_VanillaLoans
GO
EXECUTE sp_rename N'dbo.Tmp_bs_VanillaLoans', N'bs_VanillaLoans', 'OBJECT' 
GO
ALTER TABLE dbo.bs_VanillaLoans ADD CONSTRAINT
	PK_bs_VanillaLoans PRIMARY KEY CLUSTERED 
	(
	VanillaLoanID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
