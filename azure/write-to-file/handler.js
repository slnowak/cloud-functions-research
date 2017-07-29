'use strict';

const fs = require('mz/fs');
const Influx = require('influx');
const moment = require('moment');
const uuid = require("uuid");


const influx = new Influx.InfluxDB({
    host: 'azure-functions-influx.westeurope.cloudapp.azure.com',
    port: 8086,
    database: 'azure_lambda_db',
    schema: [
        {
            measurement: 'write_to_file',
            fields: {
                duration: Influx.FieldType.INTEGER
            },
            tags: [
                'invocation'
            ]
        }
    ]
});

module.exports.writeToFile = writeToFile;

function writeToFile(context) {

    const payload = new Uint8Array(1024 * 1024 * 10);
    const start = moment().valueOf();

    fs.writeFile(uniqueFile(), payload)
        .then(measureExecution(start))
        .then(reportToInflux(influx, context.invocationId))
        .then(finalize(context));

}

function uniqueFile() {
    return `D:\\home\\${uuid.v4()}.txt`;
}

function measureExecution(start) {
    return () => {
        let end = moment().valueOf();
        return end - start;
    };
}

function reportToInflux(influx, invocation) {
    return duration => influx.writePoints([{
        measurement: 'response_times',
        fields: {duration},
        tags: {invocation}
    }]);
}

function finalize(context) {
    context.res = {body: 'OK'};
    context.done();
}