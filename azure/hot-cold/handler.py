import os
import json
import random
import math

MAX_ROUNDS = 250000

def pi():
    r = 5
    points_total = 0
    points_inside = 0

    while points_total < MAX_ROUNDS:
        points_total += 1

        x = random.random() * r * 2 - r
        y = random.random() * r * 2 - r
        
        if math.pow(x, 2) + math.pow(y, 2) < math.pow(r, 2):
            points_inside += 1

    return 4.0 * points_inside / points_total

response = open(os.environ['res'], 'w')
response.write("%f" % pi())
response.close()