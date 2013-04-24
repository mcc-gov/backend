#export tables to CSV
import pymssql
import json

from settings import settings

conn = pymssql.connect(host=settings["host"], user=settings["user"], password=settings["pswd"], database=settings["database"], as_dict=True)
cur = conn.cursor()
#print "DB Connected"

f=open("query.sql")

sql = f.read()
f.close()


fc = open ("columns.txt")
columns=[]
for line in fc:
	column, description = line.strip().split("	")
	columns.append({"column":column, "description":description})

header = ""
for i, col in enumerate(columns):
	value=col["description"].strip()
	if i<len(columns)-1:
		header=header+value+","
	else:
		header=header+value

print header

cur.execute(sql)

row = cur.fetchone()

while row:
	line=""
	for i, col in enumerate(columns):
		value = str(row[col["column"]]).strip()
		if value == "None":
			value=""
		if value.find(",")>0:
			value="\""+value+"\""
		if i<len(columns)-1:
			line=line+value+","
		else:
			line=line+value

	print line
	row=cur.fetchone()

f.close()
#print cur.description
conn.close()


