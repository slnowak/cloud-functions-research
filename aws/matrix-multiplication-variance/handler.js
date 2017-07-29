'use strict';

const Influx = require('influx');

const influx = new Influx.InfluxDB({
    host: 'cloud-functions-research-influx.westeurope.cloudapp.azure.com',
    port: 8086,
    database: 'azure_lambda_db',
    schema: [
        {
            measurement: 'matrix_multiplication_variance_aws',
            fields: {
                duration: Influx.FieldType.INTEGER
            },
            tags: []
        }
    ]
});


module.exports.matrixMultiplication = (event, context, callback) => {
    const start = timeInMillis();

    Promise
        .resolve(main(event))
        .then(measureExecution(start))
        .then(reportToInflux(influx));

    // don't wait for influx response
    callback(null, httpOK());
};

function httpOK() {
    return {
        statusCode: 200
    }
}

function measureExecution(start) {
    return () => {
        const end = timeInMillis();
        return {start, end};
    };
}

function timeInMillis() {
    return (new Date).getTime();
}

function reportToInflux(influx) {
    return res => influx.writePoints([{
        measurement: 'matrix_multiplication_variance_aws',
        fields: {duration: res.end - res.start},
        timestamp: res.start
    }], {precision: 'ms'});
}

function multiplyRowAndColumn(row, column) {
    // assume same length of row and column
    let result = 0;
    for (let i = 0; i < row.length; i++) {
        result += row[i] * column[i];
    }

    return result;
}

function createRandomMatrix(size, seed, value_min, value_max) {
    const matrix = [];

    for (let i = 0; i < size; i++) {
        const row = [];
        for (let j = 0; j < size; j++) {
            const val = parseInt(Math.random(seed) * (value_max - value_min), 10);
            row.push(val);
        }

        matrix.push(row);
    }

    return matrix;
}

function getRowFromMatrix(matrix, i) {
    return matrix[i];
}

function getColumnFromMatrix(matrix, j) {
    const column = [];
    for (let i = 0; i < matrix.length; i++) {
        column.push(matrix[i][j]);
    }

    return column;
}

function multiplyMatrix(matrixA, matrixB) {
    const result = [];

    for (let i = 0; i < matrixA.length; i++) {
        const result_row = [];
        for (let j = 0; j < matrixA[0].length; j++) {
            const row = getRowFromMatrix(matrixA, i);
            const column = getColumnFromMatrix(matrixB, j);
            result_row.push(multiplyRowAndColumn(row, column));
        }
        result.push(result_row);
    }

    return result;
}

function main(body) {
    let seed = 123;
    const value_min = 0;
    const value_max = 101;
    const size = parseInt(body);

    const matrix = createRandomMatrix(size, seed, value_min, value_max);
    seed = 2 * seed;
    const matrix2 = createRandomMatrix(size, seed, value_min, value_max);
    return multiplyMatrix(matrix, matrix2);
}