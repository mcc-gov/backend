import tables_export
import queries_export
import timeseries_sql
import timeseries_export

from settings import settings
import os
import shutil

if not os.path.exists("output"): os.makedirs("output")

for fy in settings:
	print "Processing: ",fy

	print "Exporting indicator tables from database"
	tables_export.run(settings[fy], fy)

	print "Exporting custom queries from database"
	queries_export.run(settings[fy], fy)

	if settings[fy]["regenerate_timeseries_sql"]=="true":
		print "Regenerating SQL for timeseries"
		timeseries_sql.run(settings[fy], fy)

	if settings[fy]["run_timeseries"]=="true":
		print "Exporting timeseries data from database"
		timeseries_export.run(settings[fy], fy)


	print "Copying all static datafiles: ", fy

	src="config/"+fy+"/static/"
	src_files = os.listdir(src)
	for file_name in src_files:
	    	full_file_name = os.path.join(src, file_name)
	    	if (os.path.isfile(full_file_name)):
        		shutil.copy(full_file_name, "output/"+fy+"/")


