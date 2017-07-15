influx -database azure_lambda_db -format csv -execute 'SELECT percentile("duration", 50) as p50, percentile("duration", 75) as p75, percentile("duration", 95) as p95, percentile("duration", 99) as p99 FROM "matrix_multiplication" WHERE time > 1500112980000ms and time < 1500114240000ms GROUP BY time(1s) fill(0)' -precision RFC3339 >> percentiles.csv
influx -database azure_lambda_db -format csv -execute 'SELECT count(*) FROM "matrix_multiplication" WHERE time > 1500112980000ms and time < 1500114240000ms GROUP BY time(1s) fill(0)' -precision RFC3339 >> rps.csv
influx -database azure_lambda_db -format csv -execute 'SELECT count(distinct("host")) FROM "matrix_multiplication" WHERE time > 1500112980000ms and time < 1500114240000ms GROUP BY time(1s) fill(0)' -precision RFC3339 >> hosts.csv

scp influx@52.174.187.47:/home/influx/*.csv .
