influx -database azure_lambda_db -format csv -execute 'SELECT percentile("duration", 50) as p50, percentile("duration", 75) as p75, percentile("duration", 95) as p95, percentile("duration", 99) as p99 FROM "data_intensive" WHERE time > 1500735000000ms and time < 1500735300000ms GROUP BY time(1s) fill(0)' -precision RFC3339 >> dataintensivevm.csv

scp influx@cloud-functions-research-influx.westeurope.cloudapp.azure.com:/home/influx/dataintensivevm.csv .