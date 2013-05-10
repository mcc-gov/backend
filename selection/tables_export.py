#export tables to CSV
import pymssql
import os

def run(settings, fy):

	conn = pymssql.connect(host=settings["host"], user=settings["user"], password=settings["pswd"], database=settings["database"])
	cur = conn.cursor()
	print "DB Connected"

	tables=[]
	f=open("config/"+fy+"/tables.txt")
	for line in f:
		vals=line.strip().split(' ')
		skip=int(vals[0])
		table=vals[1]
		file=vals[2]
		tables.append({"skip":skip, "table":table,"file":file})
	f.close()

	print tables

	if not os.path.exists("output/"+fy): os.makedirs("output/"+fy)

	for table in tables:
		print table
		cur.execute('SELECT * FROM dbo.'+table["table"])
	
	        f=open("output/"+fy+"/"+table["file"]+"_"+fy+".csv","w")

		row = cur.fetchone()
		count=0
		#print cur.description
		header=""
		for i, el in enumerate(cur.description):	
			if i<table["skip"]:
				pass
			elif i==table["skip"]:
				header=el[0]
			elif i>table["skip"]:
				header=header+", "+el[0]
			#header=header[2:len(header)-2]

		f.write(header+'\n')

		while row:
			#print row
			line=""
			for i, el in enumerate(row):
				if i<table["skip"]:
					pass
				elif i==table["skip"]:
					line=str(el)
				elif i>table["skip"]:		
					line=line+", "+str(el)

			f.write(line+'\n')
			#print row	
			count=count+1
			row=cur.fetchone()

		f.close()
	#print cur.description
	conn.close()

	#print count


