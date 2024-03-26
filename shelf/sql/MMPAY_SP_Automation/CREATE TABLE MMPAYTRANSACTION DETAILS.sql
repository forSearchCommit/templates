USE [Affiliate_P003]
GO

/****** Object:  Table [Affiliate].[MMPayTransactionDetails]    Script Date: 2/6/2024 4:01:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[Affiliate].[MMPayTransactionDetails]', 'U') IS NOT NULL
BEGIN
    DROP TABLE [Affiliate].[MMPayTransactionDetails];
END
GO

CREATE TABLE [Affiliate].[MMPayTransactionDetails](
    [MMPayTransactionId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[TransactionNumber] [NVARCHAR](MAX) NOT NULL,
    [TransactionType] [INT] NULL,
    [TransactionDate] [DATETIME] NOT NULL,
	[PayoutTransactionNumber] [NVARCHAR](MAX) NOT NULL,
	[AdjustmentTransactionNumber] [NVARCHAR](MAX) NULL,
    [MemberCode] [NVARCHAR](MAX) NOT NULL,
	[AffiliateCode] [NVARCHAR](MAX) NOT NULL,
	[CredentialID] [BIGINT] NOT NULL,
	[SubCredentialID] [BIGINT] NOT NULL,
    [MemberCurrency] [NVARCHAR](10) NOT NULL,
    [Status] [INT] NOT NULL,
    [Active] [INT] NOT NULL,
	[AffiliateBalanceBeforeTransaction] [DECIMAL](20, 4) NOT NULL,
	[Amount] [DECIMAL](20, 4) NOT NULL,
	[AmountAfterExchange] [DECIMAL](20, 4) NOT NULL,
	[CurrencyExchangeRate] [DECIMAL](18, 6) NOT NULL,
	[ReverseExchangeRate] [DECIMAL](18, 6) NOT NULL,
    [CommissionRate] [DECIMAL](20, 4) NOT NULL,
	[Churn] [INT] NOT NULL,
	[RemarkType] [INT] NOT NULL,
	[Remark] [NVARCHAR](MAX) NOT NULL,
	[CreatedDate] [DATETIME] NOT NULL,
	[CreatedBy] [NVARCHAR](MAX) NOT NULL,
	[ModifiedDate] [DATETIME] NOT NULL,
	[ModifiedBy] [NVARCHAR](MAX) NOT NULL,
    [NotifyUrl] [NVARCHAR](MAX) NULL
    CONSTRAINT [PK__MMPayTrans__E733A2BE6F0A4432] PRIMARY KEY CLUSTERED 
    (
        [MMPayTransactionId] ASC
    ) WITH (
        PAD_INDEX = OFF, 
        STATISTICS_NORECOMPUTE = OFF, 
        IGNORE_DUP_KEY = OFF, 
        ALLOW_ROW_LOCKS = ON, 
        ALLOW_PAGE_LOCKS = ON, 
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Affiliate].[MMPayTransactionDetails] ADD  CONSTRAINT [DF__MMPayTrans__SubCr__15C5FB1B]  DEFAULT ((0)) FOR [SubCredentialID]
GO

ALTER TABLE [Affiliate].[MMPayTransactionDetails] ADD  CONSTRAINT [DF__MMPayTrans__Commi__0EF901FB]  DEFAULT ((0)) FOR [CommissionRate]
GO

ALTER TABLE [Affiliate].[MMPayTransactionDetails] ADD  CONSTRAINT [DF__MMPayTrans__Statu__05A4A1EB]  DEFAULT ((0)) FOR [Status]
GO

ALTER TABLE [Affiliate].[MMPayTransactionDetails] ADD  CONSTRAINT [DF__MMPayTrans__Activ__05A4A2EB]  DEFAULT ((0)) FOR [Active]
GO

ALTER TABLE [Affiliate].[MMPayTransactionDetails] ADD  CONSTRAINT [DF__MMPayTrans__Rever__222BD200]  DEFAULT ((1)) FOR [ReverseExchangeRate]
GO

ALTER TABLE [Affiliate].[MMPayTransactionDetails] ADD  CONSTRAINT [DF__MMPayTrans__Creat__0698C624]  DEFAULT (getutcdate()) FOR [CreatedDate]
GO

ALTER TABLE [Affiliate].[MMPayTransactionDetails] ADD  CONSTRAINT [DF__MMPayTrans__Modif__08810E96]  DEFAULT (getutcdate()) FOR [ModifiedDate]
GO


