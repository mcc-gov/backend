#export tables to CSV
import pymssql
import os

def run(settings, fy):

	conn = pymssql.connect(host=settings["host"], user=settings["user"], password=settings["pswd"], database=settings["database"])
	cur = conn.cursor()
	print "DB Connected"

	queries=[]
	f=open("config/"+fy+"/queries.txt")
	for line in f:
		vals=line.strip().split(' ')
		skip=int(vals[0])
		fq=open("config/"+fy+"/"+vals[1])
		query=fq.read()
		fq.close()
		file=vals[2]
		queries.append({"skip":skip, "query":query,"file":file})
	f.close()

	print queries

	if not os.path.exists("output/"+fy): os.makedirs("output/"+fy)

	for query in queries:
		print query
		cur.execute(query["query"])
	
	        f=open("output/"+fy+"/"+query["file"]+"_"+fy+".csv","w")

		row = cur.fetchone()
		count=0
		#print cur.description
		header=""
		for i, el in enumerate(cur.description):	
			if i<query["skip"]:
				pass
			elif i==query["skip"]:
				header=el[0]
			elif i>query["skip"]:
				header=header+", "+el[0]
			#header=header[2:len(header)-2]

		f.write(header+'\n')

		while row:
			#print row
			line=""
			for i, el in enumerate(row):
				if i<query["skip"]:
					pass
				elif i==query["skip"]:
					if str(el)=="None":
						line=""
					else:
						line=str(el)
				elif i>query["skip"]:		
					if str(el)=="None":
						line=line+", "
					else:
						line=line+", "+str(el)

			f.write(line+'\n')
			#print row	
			count=count+1
			row=cur.fetchone()

		f.close()
	#print cur.description
	conn.close()

	#print count


