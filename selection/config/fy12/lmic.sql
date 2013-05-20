select l.CountryCode, 
	pr.PolRigDisplay, cl.CivLibDisplay, cc.ConCorDisplay, ge.GovtEffDisplay, rl.RuleLawDisplay, fi.FreedomInfoDisplay,
	i.ImmunDisplay,h.HealthDisplay,ee.EducExpDisplay,gs.GirlsSecAgg,ch.CHDisplay,nrm.NRMDisplay,
	rq.RegQualityDisplay,lra.LRADisplay, bsu.BusStartupDisplay ,tp.TradeDisplay,infl.InflDisplay,fp.FisPolDisplay,ac.AccessCreditDisplay,gen.GenderEconDisplay
from (
select CountryCode, GNICapYear, GNICap, GNIIncCatOverride, GNILimitIncCat 
from dbo.t_GNICap1, dbo.t_GNILimits
where GNILimitIncCat='LMIC'
   and
   (GNIcap<=GNILimitHigh and GNIcap>=GNILimitLow or GNIIncCatOverride=GNILimitIncCat)
   and GNICapYear=GNILimitYear
) l
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