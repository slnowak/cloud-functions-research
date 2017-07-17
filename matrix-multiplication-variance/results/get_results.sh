influx -database azure_lambda_db -format csv -execute 'SELECT percentile("duration", 50) as p50, percentile("duration", 75) as p75, percentile("duration", 95) as p95, percentile("duration", 99) as p99 FROM "matrix_multiplication_variance" WHERE time > 1500230556397ms and time < 1500314336261ms GROUP BY time(1s) fill(0)' -precision RFC3339 >> percentiles_variance.csv

scp influx@cloud-functions-research-influx.westeurope.cloudapp.azure.com:/home/influx/percentiles_variance.csv .
