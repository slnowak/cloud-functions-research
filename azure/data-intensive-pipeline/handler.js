'use strict';

const Influx = require('influx');

const influx = new Influx.InfluxDB({
    host: 'cloud-functions-research-influx.westeurope.cloudapp.azure.com',
    port: 8086,
    database: 'azure_lambda_db',
    schema: [
        {
            measurement: 'data_intensive',
            fields: {
                duration: Influx.FieldType.INTEGER
            },
            tags: []
        }
    ]
});

module.exports.step1 = step1;
module.exports.step2 = step2;

function step1(ctx) {
    const start = timeInMillis();
    const payload = new Uint8Array(1024 * 1024 * 10);
    ctx.bindings.firstStepOutput = {start, payload};
    ctx.done();
}

function step2(ctx, firstStepOutput) {
    const end = timeInMillis();
    const {start} = firstStepOutput;
    reportToInflux(influx, start, end);
    ctx.done();
}

function timeInMillis() {
    return (new Date).getTime();
}

function reportToInflux(influx, start, end) {
    influx.writePoints([{
        measurement: 'data_intensive',
        fields: {duration: end - start},
        timestamp: start
    }], {precision: 'ms'});
}