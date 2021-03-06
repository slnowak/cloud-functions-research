package pl.edu.agh.azure.matrix

import io.gatling.core.Predef._
import io.gatling.http.Predef._

import scala.concurrent.duration._
import scala.language.postfixOps

class MultiplyMatricesScenario extends Simulation {

  private val httpConf = http.baseURL("http://cloud-functions-research-snowak3.azurewebsites.net")
  private val matrixMultiplicationScenario = scenario("Multiply matrices")
    .exec(
      http("POST /api/matrixMultiplication")
        .post("/api/matrixMultiplication")
        .body(StringBody("100"))
    )

  private val scenarioCfg = matrixMultiplicationScenario.inject(
    rampUsersPerSec(10) to 500 during (1 hour)
  )

  setUp(scenarioCfg).protocols(httpConf)
}
