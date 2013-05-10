USE [DPESel_Prod13]
GO

/****** Object:  View [dbo].[v_dc_lmic_indicators]    Script Date: 04/23/2013 15:45:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[v_dc_lmic_indicators]
as
select l.CountryCode, 
	pr.PolRigDisplay, cl.CivLibDisplay, cc.ConCorDisplay, ge.GovtEffDisplay, rl.RuleLawDisplay, fi.FreedomInfoDisplay,
	i.ImmunDisplay,h.HealthDisplay,ee.EducExpDisplay,gs.GirlsSecAgg,ch.CHDisplay,nrm.NRMDisplay,
	rq.RegQualityDisplay,lra.LRADisplay, bsu.BusStartupDisplay ,tp.TradeDisplay,infl.InflDisplay,fp.FisPolDisplay,ac.AccessCreditDisplay,gen.GenderEconDisplay
from dbo.v_dc_lmic l
left outer join
	(select * from dbo.t_PolRig pr, dbo.t_Indicators y where y.IndicatorCode='PolRig' and pr.PolRigYear=y.MaxDispYear) pr
on l.CountryCode=pr.PolRigCountryCode
left outer join	
	(select * from dbo.t_Civlib cl, dbo.t_Indicators y where y.IndicatorCode='CivLib' and cl.CivlibYear =y.MaxDispYear) cl
on l.CountryCode=cl.CivlibCountryCode	
left outer join
	(select * from dbo.t_ConCor cc, dbo.t_Indicators y where y.IndicatorCode='ConCor' and cc.ConCorYear=y.MaxDispYear) cc
on l.CountryCode=cc.ConCorCountryCode
left outer join	
	(select * from dbo.t_GovtEff ge, dbo.t_Indicators y where y.IndicatorCode='GovEff' and ge.GovtEffYear=y.MaxDispYear)ge
on	l.CountryCode=ge.GovtEffCountryCode
left outer join	
	(select * from dbo.t_RuleLaw rl, dbo.t_Indicators y where y.IndicatorCode='RulLaw' and rl.RuleLawYear=y.MaxDispYear) rl
on l.CountryCode=rl.RuleLawCountryCode
left outer join	
	(select * from dbo.t_FreedomInfo fi, dbo.t_Indicators y where y.IndicatorCode='Freedom' and fi.FreedomInfoYear=y.MaxDispYear) fi
on l.CountryCode=fi.FreedomInfoCountryCode

left outer join	
	(select * from dbo.t_Immun i, dbo.t_Indicators y where y.IndicatorCode='Immun' and i.ImmunYear=y.MaxDispYear) i
on l.CountryCode=i.ImmunCountryCode
left outer join	
	(select * from dbo.t_Health h, dbo.t_Indicators y where y.IndicatorCode='Health' and h.HealthYear=y.MaxDispYear) h
on l.CountryCode=h.HealthCountryCode
left outer join	
	(select * from dbo.t_EducExp ee, dbo.t_Indicators y where y.IndicatorCode='PriEdu' and ee.EducExpYear=y.MaxDispYear) ee
on l.CountryCode=ee.EducExpCountryCode
left outer join	
	(select * from dbo.t_GirlsSec gs, dbo.t_Indicators y where y.IndicatorCode='GSECR' and gs.GirlsSecYear=y.MaxDispYear) gs
on l.CountryCode=gs.GirlsSecCountryCode
left outer join	
	(select * from dbo.t_ChiHealth ch, dbo.t_Indicators y where y.IndicatorCode='ChiHeal' and ch.CHYear=y.MaxDispYear) ch
on l.CountryCode=ch.CHCountryCode
left outer join	
	(select * from dbo.t_NRM nrm, dbo.t_Indicators y where y.IndicatorCode='NRMI' and nrm.NRMYear=y.MaxDispYear) nrm
on l.CountryCode=nrm.NRMCountryCode
	
left outer join	
	(select * from dbo.t_RegQuality rq, dbo.t_Indicators y where y.IndicatorCode='RegQ' and rq.RegQualityYear=y.MaxDispYear) rq
on l.CountryCode=rq.RegQualityCountryCode
left outer join	
	(select * from dbo.t_LandRightsAccess lra, dbo.t_Indicators y where y.IndicatorCode='Land' and lra.LRAYear=y.MaxDispYear) lra
on l.CountryCode=lra.LRACountryCode
left outer join	
	(select * from dbo.t_BusStartUp bsu, dbo.t_Indicators y where y.IndicatorCode='Bus' and bsu.BusStartUpYear=y.MaxDispYear) bsu
on l.CountryCode=bsu.BusStartUpCountryCode
left outer join	
	(select * from dbo.t_TradePolicy tp, dbo.t_Indicators y where y.IndicatorCode='Trade' and tp.TradeYear=y.MaxDispYear) tp
on l.CountryCode=tp.TradeCountryCode
left outer join	
	(select * from dbo.t_Infl infl, dbo.t_Indicators y where y.IndicatorCode='Infl' and infl.InflYear=y.MaxDispYear) infl
on l.CountryCode=infl.InflCountryCode
left outer join	
	(select * from dbo.t_FisPol fp, dbo.t_Indicators y where y.IndicatorCode='FisPol' and fp.FisPolYear=y.MaxDispYear) fp
on l.CountryCode=fp.FisPolCountryCode
left outer join	
	(select * from dbo.t_AccessCredit ac, dbo.t_Indicators y where y.IndicatorCode='AccCred' and ac.AccessCreditYear=y.MaxDispYear) ac
on l.CountryCode=ac.AccessCreditCountryCode
left outer join	
	(select * from dbo.t_GenderEcon gen, dbo.t_Indicators y where y.IndicatorCode='GE' and gen.GenderEconYear=y.MaxDispYear) gen
on l.CountryCode=gen.GenderEconCountryCode
		
	
GO


USE [DPESel_Prod13]
GO

/****** Object:  View [dbo].[v_dc_lmic]    Script Date: 04/23/2013 15:44:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[v_dc_lmic] as	
select CountryCode, GNICapYear, GNICap, GNIIncCatOverride, GNILimitIncCat 
from dbo.t_GNICap1, dbo.t_GNILimits
where GNILimitIncCat='LMIC'
	and
	(GNIcap<=GNILimitHigh and GNIcap>=GNILimitLow or GNIIncCatOverride=GNILimitIncCat)
	and GNICapYear=GNILimitYear
GO


USE [DPESel_Prod13]
GO

/****** Object:  View [dbo].[v_dc_lic_indicators]    Script Date: 04/23/2013 15:44:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[v_dc_lic_indicators]
as
select l.CountryCode, 
	pr.PolRigDisplay, cl.CivLibDisplay, cc.ConCorDisplay, ge.GovtEffDisplay, rl.RuleLawDisplay, fi.FreedomInfoDisplay,
	i.ImmunDisplay,h.HealthDisplay,ee.EducExpDisplay,gp.GirlsPrimAgg,ch.CHDisplay,nrm.NRMDisplay,
	rq.RegQualityDisplay,lra.LRADisplay, bsu.BusStartupDisplay ,tp.TradeDisplay,infl.InflDisplay,fp.FisPolDisplay,ac.AccessCreditDisplay,gen.GenderEconDisplay
from dbo.v_dc_lic l
left outer join
	(select * from dbo.t_PolRig pr, dbo.t_Indicators y where y.IndicatorCode='PolRig' and pr.PolRigYear=y.MaxDispYear) pr
on l.CountryCode=pr.PolRigCountryCode
left outer join	
	(select * from dbo.t_Civlib cl, dbo.t_Indicators y where y.IndicatorCode='CivLib' and cl.CivlibYear =y.MaxDispYear) cl
on l.CountryCode=cl.CivlibCountryCode	
left outer join
	(select * from dbo.t_ConCor cc, dbo.t_Indicators y where y.IndicatorCode='ConCor' and cc.ConCorYear=y.MaxDispYear) cc
on l.CountryCode=cc.ConCorCountryCode
left outer join	
	(select * from dbo.t_GovtEff ge, dbo.t_Indicators y where y.IndicatorCode='GovEff' and ge.GovtEffYear=y.MaxDispYear)ge
on	l.CountryCode=ge.GovtEffCountryCode
left outer join	
	(select * from dbo.t_RuleLaw rl, dbo.t_Indicators y where y.IndicatorCode='RulLaw' and rl.RuleLawYear=y.MaxDispYear) rl
on l.CountryCode=rl.RuleLawCountryCode
left outer join	
	(select * from dbo.t_FreedomInfo fi, dbo.t_Indicators y where y.IndicatorCode='Freedom' and fi.FreedomInfoYear=y.MaxDispYear) fi
on l.CountryCode=fi.FreedomInfoCountryCode

left outer join	
	(select * from dbo.t_Immun i, dbo.t_Indicators y where y.IndicatorCode='Immun' and i.ImmunYear=y.MaxDispYear) i
on l.CountryCode=i.ImmunCountryCode
left outer join	
	(select * from dbo.t_Health h, dbo.t_Indicators y where y.IndicatorCode='Health' and h.HealthYear=y.MaxDispYear) h
on l.CountryCode=h.HealthCountryCode
left outer join	
	(select * from dbo.t_EducExp ee, dbo.t_Indicators y where y.IndicatorCode='PriEdu' and ee.EducExpYear=y.MaxDispYear) ee
on l.CountryCode=ee.EducExpCountryCode
left outer join	
	(select * from dbo.t_GirlsPrim gp, dbo.t_Indicators y where y.IndicatorCode='GPECR' and gp.GirlsPrimYear=y.MaxDispYear) gp
on l.CountryCode=gp.GirlsPrimCountryCode
left outer join	
	(select * from dbo.t_ChiHealth ch, dbo.t_Indicators y where y.IndicatorCode='ChiHeal' and ch.CHYear=y.MaxDispYear) ch
on l.CountryCode=ch.CHCountryCode
left outer join	
	(select * from dbo.t_NRM nrm, dbo.t_Indicators y where y.IndicatorCode='NRMI' and nrm.NRMYear=y.MaxDispYear) nrm
on l.CountryCode=nrm.NRMCountryCode
	
left outer join	
	(select * from dbo.t_RegQuality rq, dbo.t_Indicators y where y.IndicatorCode='RegQ' and rq.RegQualityYear=y.MaxDispYear) rq
on l.CountryCode=rq.RegQualityCountryCode
left outer join	
	(select * from dbo.t_LandRightsAccess lra, dbo.t_Indicators y where y.IndicatorCode='Land' and lra.LRAYear=y.MaxDispYear) lra
on l.CountryCode=lra.LRACountryCode
left outer join	
	(select * from dbo.t_BusStartUp bsu, dbo.t_Indicators y where y.IndicatorCode='Bus' and bsu.BusStartUpYear=y.MaxDispYear) bsu
on l.CountryCode=bsu.BusStartUpCountryCode
left outer join	
	(select * from dbo.t_TradePolicy tp, dbo.t_Indicators y where y.IndicatorCode='Trade' and tp.TradeYear=y.MaxDispYear) tp
on l.CountryCode=tp.TradeCountryCode
left outer join	
	(select * from dbo.t_Infl infl, dbo.t_Indicators y where y.IndicatorCode='Infl' and infl.InflYear=y.MaxDispYear) infl
on l.CountryCode=infl.InflCountryCode
left outer join	
	(select * from dbo.t_FisPol fp, dbo.t_Indicators y where y.IndicatorCode='FisPol' and fp.FisPolYear=y.MaxDispYear) fp
on l.CountryCode=fp.FisPolCountryCode
left outer join	
	(select * from dbo.t_AccessCredit ac, dbo.t_Indicators y where y.IndicatorCode='AccCred' and ac.AccessCreditYear=y.MaxDispYear) ac
on l.CountryCode=ac.AccessCreditCountryCode
left outer join	
	(select * from dbo.t_GenderEcon gen, dbo.t_Indicators y where y.IndicatorCode='GE' and gen.GenderEconYear=y.MaxDispYear) gen
on l.CountryCode=gen.GenderEconCountryCode
		
	
GO


USE [DPESel_Prod13]
GO

/****** Object:  View [dbo].[v_dc_lic]    Script Date: 04/23/2013 15:44:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[v_dc_lic] as
select CountryCode, GNICapYear, GNICap, GNIIncCatOverride, GNILimitIncCat 
from dbo.t_GNICap1, dbo.t_GNILimits
where GNILimitIncCat='LIC'
	and
	(GNIcap<=GNILimitHigh and GNIcap>=GNILimitLow or GNIIncCatOverride=GNILimitIncCat)
	and GNICapYear=GNILimitYear

GO


USE [DPESel_Prod13]
GO

/****** Object:  View [dbo].[v_dc_gniinccatoverride]    Script Date: 04/23/2013 15:44:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[v_dc_gniinccatoverride] as
  select * from dbo.t_gnicap1 where gniinccatOverride is not null
GO


USE [DPESel_Prod]
GO

/****** Object:  View [dbo].[v_dc_displaydata]    Script Date: 04/23/2013 15:46:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_dc_displaydata]
AS
SELECT     dbo.t_DisplayData.*
FROM         dbo.t_DisplayData

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "t_DisplayData"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 250
               Right = 296
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_dc_displaydata'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_dc_displaydata'
GO


