template = """
select isnull(cl.CivLibCountryCode,cc.ConCorCountryCode) as country, ISNULL(cl.civlibyear,cc.ConCorYear) as year, cl.civlibdata,   cc.ConCorData 
from t_Civlib cl full outer join
t_ConCor cc
on 
cc.ConCorCountryCode=cl.CivLibCountryCode
and
cl.CivLibYear=cc.ConCorYear
order by country, year
"""

f = open("tables.txt")

num = 0
sql = ""

line2 = ""
columns2 = ""

for line in f:
	line=line.strip()
	skip, table, name, prefix, cols = line.split(" ")
	#print line.split(" ")

	tablenum = "t" + str(num)
	cols=cols.split(",")
	#print tablenum
	#print cols
	columns = tablenum+"."+prefix+str(", "+tablenum+"."+prefix).join(cols)
	if line2 !="":
		skip2, table2, name2, prefix2, cols2 = line2.split(" ")

		tablenum2 = "ct" + str(num)
		cols2=cols2.split(",")
		if columns2 !="":
			columns2 = columns2.replace(str(num-1), str(num))
			columns2 = columns2+", "+tablenum2+"."+prefix2+str(", "+tablenum2+"."+prefix2).join(cols2)
		else:
			columns2 = tablenum2+"."+prefix2+str(", "+tablenum2+"."+prefix2).join(cols2)
		columns = columns+", "+columns2
	#print columns

	if num == 0:
		columns = """%(tablenum)s.%(prefix)sCountryCode as country2, 
				%(tablenum)s.%(prefix)sYear as year, %(columns)s""" \
				% {"tablenum":tablenum, "prefix":prefix, "columns":columns}
		sql= "select %s from dbo.%s %s " % (columns, table, tablenum)

		#print sql

	else:
		columns = """isnull(%(tablenum)s.%(prefix)sCountryCode, c%(tablenum)s.country2) as country2, 
				isnull(%(tablenum)s.%(prefix)sYear, c%(tablenum)s.year) as year, %(columns)s""" \
				% {"tablenum":tablenum, "prefix":prefix, "columns":columns}
		sql = """select %(columns)s from (%(sql)s) c%(tablenum)s full outer join dbo.%(table)s %(tablenum)s
		on c%(tablenum)s.country2=%(tablenum)s.%(prefix)sCountryCode and c%(tablenum)s.year=%(tablenum)s.%(prefix)sYear
		""" \
			% {"tablenum":tablenum, "columns":columns, "sql":sql, "table":table, "prefix":prefix}
	
	num = num + 1
	line2 = line
	#print sql
	#print

f2 = open("tables2.txt")

num2 = 0

for line in f2:
	line=line.strip()
	table, prefix = line.split(" ")
	#print line.split(" ")

	tablenum = "t" + str(num)
	#print tablenum
	#print cols
	columns = tablenum+"."+prefix
	#print "coluns: ",columns
	if num2 == 0:
		#print "num2=0"
		skip2, table2, name2, prefix2, cols2 = line2.split(" ")

		tablenum2 = "ct" + str(num)
		cols2=cols2.split(",")
		#print "cols2: ",cols2
		columns2 = columns2.replace(str(num-1), str(num))
		#print "columns2: ",columns2
		columns2 = columns2+", "+tablenum2+"."+prefix2+str(", "+tablenum2+"."+prefix2).join(cols2)
		#print "columns: ",columns
		#print "columns2: ",columns2
		columns = columns+", "+columns2
		#print "columns: ",columns
	else:
		#print "num2!=0"
		table2, prefix2 = line2.split(" ")

		tablenum2 = "ct" + str(num)
		cols2=prefix2.split(",")
		#print "cols2: ",cols2
		columns2 = columns2.replace(str(num-1), str(num))
		#print "columns2: ",columns2
		columns2 = columns2+", "+tablenum2+"."+str(", "+tablenum2+".").join(cols2)
		#print "columns: ",columns
		#print "columns2: ",columns2
		columns = columns+", "+columns2
		#print "columns: ",columns
	#print columns

	if True:
		columns = """isnull(%(tablenum)s.CountryCode, c%(tablenum)s.country2) as country2, 
				isnull(%(tablenum)s.%(prefix)sYear, c%(tablenum)s.year) as year, %(columns)s""" \
				% {"tablenum":tablenum, "prefix":prefix, "columns":columns}
		sql = """select %(columns)s from (%(sql)s) c%(tablenum)s full outer join dbo.%(table)s %(tablenum)s
		on c%(tablenum)s.country2=%(tablenum)s.CountryCode and c%(tablenum)s.year=%(tablenum)s.%(prefix)sYear
		""" \
			% {"tablenum":tablenum, "columns":columns, "sql":sql, "table":table, "prefix":prefix}
	
	num = num + 1
	num2 = num2 +1
	line2 = line
	#print sql
	#print


sql="select countrycode3 as country3, countrynameofficial as countryname, tt.* from dbo.t_country, ("+sql+") as tt where tt.country2=countrycode2 and countrycode2!='--' and year>=1996"
print sql

f.close()