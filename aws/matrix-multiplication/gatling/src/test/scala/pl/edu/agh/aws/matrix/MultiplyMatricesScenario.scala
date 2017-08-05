package pl.edu.agh.aws.matrix

import io.gatling.core.Predef._
import io.gatling.http.Predef._

import scala.concurrent.duration._
import scala.language.postfixOps

class MultiplyMatricesScenario extends Simulation {

  private val httpConf = http.baseURL("https://ei8bik2m3f.execute-api.eu-west-1.amazonaws.com")
  private val matrixMultiplicationScenario = scenario("Multiply matrices")
    .exec(
      http("POST /dev/multiplication")
        .post("/dev/multiplication")
        .body(StringBody("100"))
    )

  private val scenarioCfg = matrixMultiplicationScenario.inject(
    rampUsersPerSec(10) to 500 during (1 hour)
  )

  setUp(scenarioCfg).protocols(httpConf)
}
