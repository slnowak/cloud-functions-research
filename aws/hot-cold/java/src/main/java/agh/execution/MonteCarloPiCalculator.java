package agh.execution;

import java.util.Random;

public class MonteCarloPiCalculator {

    public static double pi(Integer rounds) {
        int r = 5;
        int points_total = 0;
        int points_inside = 0;

        while (points_total < rounds) {
            points_total++;

            Random random = new Random();
            double x = random.nextDouble() * r * 2 - r;
            double y = random.nextDouble() * r * 2 - r;

            if (Math.pow(x, 2) + Math.pow(y, 2) < Math.pow(r, 2))
                points_inside++;
        }

        return 4.0 * points_inside / points_total;
    }

    public static String an() {
        return "";
    }

}
