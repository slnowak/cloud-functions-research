influx -database azure_lambda_db -format csv -execute 'SELECT "duration" FROM "data_intensive_aws" WHERE time > 1504372640117ms and time < 1504372874559ms and "duration" > 0' -precision RFC3339 >> data_intensive_aws.csv
influx -database azure_lambda_db -format csv -execute 'SELECT "duration" FROM "data_intensive_step1_aws" WHERE time > 1504372640117ms and time < 1504372874559ms and "duration" > 0' -precision RFC3339 >> data_intensive_step1_aws.csv
influx -database azure_lambda_db -format csv -execute 'SELECT "duration" FROM "data_intensive_step2_aws" WHERE time > 1504372640117ms and time < 1504372874559ms and "duration" > 0' -precision RFC3339 >> data_intensive_step2_aws.csv

ssh influx@cloud-functions-research-influx.westeurope.cloudapp.azure.com
scp influx@cloud-functions-research-influx.westeurope.cloudapp.azure.com:/home/influx/intensiveaws/*.csv .
