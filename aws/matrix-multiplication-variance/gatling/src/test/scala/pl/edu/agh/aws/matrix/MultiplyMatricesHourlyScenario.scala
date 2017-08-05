package pl.edu.agh.aws.matrix

import io.gatling.core.Predef._
import io.gatling.http.Predef._

import scala.concurrent.duration._
import scala.language.postfixOps

class MultiplyMatricesHourlyScenario extends Simulation {

  private val httpConf = http.baseURL("https://by48gw011j.execute-api.eu-west-1.amazonaws.com")
  private val matrixMultiplicationScenario = scenario("Multiply matrices")
    .exec(
      http("POST /dev/multiplication")
        .post("/dev/multiplication")
        .body(StringBody("100"))
    )

  private val scenarioCfg = matrixMultiplicationScenario.inject(
    constantUsersPerSec(10) during (10 minutes)
  )

  setUp(scenarioCfg).protocols(httpConf).maxDuration(10 minutes)
}
