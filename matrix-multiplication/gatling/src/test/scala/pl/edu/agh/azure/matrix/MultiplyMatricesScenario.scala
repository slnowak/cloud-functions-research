package pl.edu.agh.azure.matrix

import io.gatling.core.Predef._
import io.gatling.http.Predef._

import scala.concurrent.duration._
import scala.language.postfixOps

class MultiplyMatricesScenario extends Simulation {

  private val httpConf = http.baseURL("https://cloud-functions-research-snowak.azurewebsites.net")

  private val matrixMultiplicationScenario = scenario("Multiply matrices")
    .exec(
      http("POST /api/matrixMultiplication")
        .post("/api/matrixMultiplication")
        .body(StringBody("10"))
    )

  private val matrixMultiplicationScenarioCfg = matrixMultiplicationScenario
    .inject(constantUsersPerSec(100) during (3000 seconds))
    .protocols(httpConf)

  setUp(matrixMultiplicationScenarioCfg).throttle(
    reachRps(50) in (1 minute),
    holdFor(1 minutes),
    jumpToRps(100),
    holdFor(1 minutes),
    jumpToRps(200),
    holdFor(1 minutes),
    jumpToRps(500),
    holdFor(1 minutes),
    jumpToRps(1000),
    holdFor(1 minutes)
  )
}
