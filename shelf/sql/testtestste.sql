declare @p1 dbo.uftt_PaymentOptionDailyLimitMember
insert into @p1 values(7125,1,430642,10,1,6.00,0,1)
insert into @p1 values(7126,2,430642,9,0,5.00,0,1)
insert into @p1 values(7127,3,430642,4,0,600.00,0,0)
insert into @p1 values(7128,4,430642,3,0,4.00,0,1)
insert into @p1 values(7129,5,430642,5,0,0,0,0)
insert into @p1 values(7130,6,430642,6,0,0,0,0)
insert into @p1 values(7131,7,430642,3,1,10000.00,0,0)
insert into @p1 values(7132,8,430642,10,1,20000.00,0,0)
insert into @p1 values(7133,9,430642,10,1,4000.00,0,0)
insert into @p1 values(7134,10,430642,3,0,450.00,0,0)
insert into @p1 values(7135,13,430642,0,0,0,0,0)
insert into @p1 values(7136,14,430642,20,1,500.00,0,0)
insert into @p1 values(7137,15,430642,0,0,0,0,0)
insert into @p1 values(7138,16,430642,0,0,0,0,0)
insert into @p1 values(7139,17,430642,0,0,0,0,0)
insert into @p1 values(7140,19,430642,0,0,0,0,0)
insert into @p1 values(7141,18,430642,0,0,0,0,0)
insert into @p1 values(7142,20,430642,0,0,0,0,0)
insert into @p1 values(7143,21,430642,0,0,0,0,0)
insert into @p1 values(7144,22,430642,0,0,0,0,0)
insert into @p1 values(7145,23,430642,0,0,0,0,0)
insert into @p1 values(7146,24,430642,0,0,0,0,0)
insert into @p1 values(7147,25,430642,0,0,0,0,0)
insert into @p1 values(7148,27,430642,0,0,0,0,0)
insert into @p1 values(7149,28,430642,0,0,0,0,0)
insert into @p1 values(7150,29,430642,0,0,0,0,0)
insert into @p1 values(7542,30,430642,0,0,0,0,0)
insert into @p1 values(7543,31,430642,0,0,0,1,1)

exec [dbo].[PaymentLimit_UpdateMemberDepositWithdrawlLimitAndDailyLimitByID] @paymentOptionDailyLimitMemberTable=@p1,@depositWithdrawalLimitID=22046,@depositStatusID=1,@depositLimit=1,@withdrawalStatusID=1,@withdrawalLimit=0,@accountID=430642,@maxBankAccountSaved=30,@maxOtherBankAccountSaved=60,@overallDailyDPAmountLimit=10.00,@overallDailyDPAmountStatus=1,@overallDailyWDAmountLimit=50.00,@overallDailyWDAmountStatus=1,@user=N'paymentdev'