'use strict';

const Influx = require('influx');
const fs = require('fs');
const uuidv4 = require('uuid/v4');

const influx = new Influx.InfluxDB({
    host: 'cloud-functions-research-influx.westeurope.cloudapp.azure.com',
    port: 8086,
    database: 'azure_lambda_db',
    schema: [
        {
            measurement: 'data_intensive_vm',
            fields: {
                duration: Influx.FieldType.INTEGER
            },
            tags: []
        }
    ]
});

function step1(path) {
    const payload = new Uint8Array(1024 * 1024 * 10);
    fs.writeFileSync(path, payload);
}

function step2(path) {
    fs.readFileSync(path);
}

function timeInMillis() {
    return (new Date).getTime();
}

function reportToInflux(influx, start, end) {
    influx.writePoints([{
        measurement: 'data_intensive_vm',
        fields: {duration: end - start},
        timestamp: start
    }], {precision: 'ms'});
}

const randomFile = uuidv4();

const start = timeInMillis();
step1(`pipeline/${randomFile}`);
step2(`pipeline/${randomFile}`);
const end = timeInMillis();
reportToInflux(influx, start, end);
