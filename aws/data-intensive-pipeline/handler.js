'use strict';

const Influx = require('influx');

const influxOverall = new Influx.InfluxDB({
    host: 'cloud-functions-research-influx.westeurope.cloudapp.azure.com',
    port: 8086,
    database: 'azure_lambda_db',
    schema: [
        {
            measurement: 'data_intensive_aws',
            fields: {
                duration: Influx.FieldType.INTEGER
            },
            tags: []
        }
    ]
});

const influxStep1 = new Influx.InfluxDB({
    host: 'cloud-functions-research-influx.westeurope.cloudapp.azure.com',
    port: 8086,
    database: 'azure_lambda_db',
    schema: [
        {
            measurement: 'data_intensive_step1_aws',
            fields: {
                start: Influx.FieldType.INTEGER,
                end: Influx.FieldType.INTEGER,
                duration: Influx.FieldType.INTEGER
            },
            tags: []
        }
    ]
});

const influxStep2 = new Influx.InfluxDB({
    host: 'cloud-functions-research-influx.westeurope.cloudapp.azure.com',
    port: 8086,
    database: 'azure_lambda_db',
    schema: [
        {
            measurement: 'data_intensive_step2_aws',
            fields: {
                start: Influx.FieldType.INTEGER,
                end: Influx.FieldType.INTEGER,
                duration: Influx.FieldType.INTEGER
            },
            tags: []
        }
    ]
});


const aws = require('aws-sdk');

const s3 = new aws.S3({
    apiVersion: '2006-03-01',
    accessKeyId: process.env.ACCESS_KEY,
    secretAccessKey: process.env.SECRET_KEY,
    region: process.env.LAMBDA_REGION
});

const uuid = require('uuid/v4');

module.exports.step1 = step1;
module.exports.step2 = step2;

function step1(event, context, callback) {
    const start = timeInMillis();
    const payload = new Uint8Array(1024 * 1024 * 5).toString();
    const fileContent = {start, payload};

    const bucketName = 'cloud-functions-research-data-step1';
    s3.putObject({Bucket: bucketName, Key: uuid(), Body: JSON.stringify(fileContent)}, (err, data) => {
        const end = timeInMillis();
        reportStep1(start, end);

        callback(null, httpOK());
    });
}

function httpOK() {
    return {
        statusCode: 201
    }
}

function step2(event, context, callback) {
    const start = timeInMillis();
    const bucket = event.Records[0].s3.bucket.name;
    const key = event.Records[0].s3.object.key;

    s3.getObject({Bucket: bucket, Key: key}, (error, data) => {
        const pipelineStart = JSON.parse(data.Body).start;
        const end = timeInMillis();
        reportStep2(pipelineStart, start, end);
        reportToInflux(pipelineStart, end);

        callback(null);
    });
}

function timeInMillis() {
    return (new Date).getTime();
}

function reportToInflux(start, end) {
    influxOverall.writePoints([{
        measurement: 'data_intensive_aws',
        fields: {duration: end - start},
        timestamp: start
    }], {precision: 'ms'});
}

function reportStep1(pipelineStart, end) {
    influxStep1.writePoints([{
        measurement: 'data_intensive_step1_aws',
        fields: {start: pipelineStart, end: end, duration: end - pipelineStart},
        timestamp: pipelineStart
    }], {precision: 'ms'});
}

function reportStep2(pipelineStart, stepStart, stepEnd) {
    influxStep2.writePoints([{
        measurement: 'data_intensive_step2_aws',
        fields: {start: stepStart, end: stepEnd, duration: stepEnd - stepStart},
        timestamp: pipelineStart
    }], {precision: 'ms'});
}
