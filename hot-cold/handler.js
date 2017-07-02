'use strict';

let MAX_ROUNDS = 250000;

module.exports.hotColdJs = (context, req) => {

    context.res = {
        body: pi()
    };

    context.done();
};

function pi() {
    var r = 5;
    var points_total = 0;
    var points_inside = 0;

    while (points_total < MAX_ROUNDS) {
        points_total++;

        var x = Math.random() * r * 2 - r;
        var y = Math.random() * r * 2 - r;
        
        if (Math.pow(x, 2) + Math.pow(y, 2) < Math.pow(r, 2))
            points_inside++;
    }

    return 4 * points_inside / points_total;
}