package pl.edu.agh.azure.matrix

import io.gatling.core.Predef._
import io.gatling.http.Predef._

import scala.concurrent.duration._
import scala.language.postfixOps

class MultiplyMatricesHourlyScenario extends Simulation {

  private val httpConf = http.baseURL("http://cloud-functions-research-variance.azurewebsites.net")
  private val matrixMultiplicationScenario = scenario("Multiply matrices").repeat(24) {
    exec(
      http("POST /api/matrixMultiplication")
        .post("/api/matrixMultiplication")
        .body(StringBody("100"))
    )
  }

  private val scenarioCfg = matrixMultiplicationScenario.inject(
    constantUsersPerSec(10) during (10 minutes),
    nothingFor (50 minutes)
  )

  setUp(scenarioCfg).protocols(httpConf)
}
