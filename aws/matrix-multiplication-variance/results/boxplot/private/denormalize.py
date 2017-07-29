import csv
from dateutil import parser

hours = []
values = []

with open('percentiles.csv') as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
    	if row[1] == "time":
    		continue
    	hour = parser.parse(row[1]).hour
        if len(str(hour)) == 1:
            hour = "0" + str(hour)
        hour = str(hour) + ":00"

    	if hour not in hours:
    		hours.append(hour)
    		values.append({"values": []})
        values[-1]["values"].append(row[2])

for h in values:
	print len(h["values"])

csvValues = []
for i in range(0, 2597):
    rows = []
    for h in values:
        rows.append(h["values"][i])
    csvValues.append(rows)

with open('test.csv', 'wb') as fp:
    a = csv.writer(fp, delimiter=',')
    csvValues.insert(0, hours)
    a.writerows(csvValues)

#print values