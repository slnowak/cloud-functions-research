using System.Net;

static int MAX_ROUNDS = 250000;

public static async Task<HttpResponseMessage> Run(HttpRequestMessage req, TraceWriter log)
{
    return req.CreateResponse(HttpStatusCode.OK, pi());
}

public static double pi() {
    int r = 5;
    int points_total = 0;
    int points_inside = 0;

    while (points_total < MAX_ROUNDS) {
        points_total++;

        Random random = new Random();
        double x = random.NextDouble() * r * 2 - r;
        double y = random.NextDouble() * r * 2 - r;
        
        if (Math.Pow(x, 2) + Math.Pow(y, 2) < Math.Pow(r, 2))
            points_inside++;
    }

    return 4.0 * points_inside / points_total;
}