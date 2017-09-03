influx -database azure_lambda_db -format csv -execute 'SELECT percentile("duration", 50) as p50, percentile("duration", 75) as p75, percentile("duration", 95) as p95, percentile("duration", 99) as p99 FROM "data_intensive" WHERE time > 1504387956649ms and time < 1504388381278ms  GROUP BY time(1s) fill(0)' -precision RFC3339 >> dataintensive.csv

scp influx@cloud-functions-research-influx.westeurope.cloudapp.azure.com:/home/influx/dataintensive.csv .

http://cloud-functions-research-grafana.westeurope.cloudapp.azure.com:3000/dashboard/db/data-intensive?orgId=1&from=1504387956649&to=1504388381278

scp influx@cloud-functions-research-influx.westeurope.cloudapp.azure.com:/home/influx/azureint/*.csv .
