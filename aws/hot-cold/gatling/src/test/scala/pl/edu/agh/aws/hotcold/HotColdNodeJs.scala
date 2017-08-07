package pl.edu.agh.aws.hotcold

import io.gatling.core.Predef._
import io.gatling.http.Predef._

import scala.concurrent.duration._
import scala.language.postfixOps

class HotColdNodeJs extends Simulation {

  private val httpConf = http.baseURL("https://sdwfjeusy2.execute-api.eu-central-1.amazonaws.com")
  private val matrixMultiplicationScenario = scenario("Multiply matrices")
    .exec(
      http("GET /dev/pi-nodejs")
        .get("/dev/pi-nodejs")
    )

  private val scenarioCfg = matrixMultiplicationScenario.inject(
    rampUsersPerSec(10) to 11 during (20 minutes)
  )

  setUp(scenarioCfg).protocols(httpConf)
}
