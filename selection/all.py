import tables_export
import timeseries_export

from settings import settings
import os

if not os.path.exists("output"): os.makedirs("output")

for fy in settings:
	print fy
	#print settings[fy]

	#tables_export.run(settings[fy], fy)

	if settings[fy]["run_timeseries"]=="true":
		timeseries_export.run(settings[fy], fy)



