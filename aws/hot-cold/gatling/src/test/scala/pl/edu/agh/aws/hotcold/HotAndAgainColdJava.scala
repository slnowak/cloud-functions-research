package pl.edu.agh.aws.hotcold

import io.gatling.core.Predef._
import io.gatling.http.Predef._

import scala.concurrent.duration._
import scala.language.postfixOps

/**
  * Created by kkulak on 07/08/2017.
  */
class HotAndAgainColdJava extends Simulation {

  private val httpConf = http.baseURL("https://1k819updw7.execute-api.eu-central-1.amazonaws.com")
  private val matrixMultiplicationScenario = scenario("Multiply matrices")
    .exec(
      http("GET /prod/pi-java")
        .get("/prod/pi-java")
    )

  private val matrixMultiplicationScenarioCfg = matrixMultiplicationScenario
    .inject(
      rampUsersPerSec(10) to 11 during (3 minutes),
      nothingFor(5 minutes),
      rampUsersPerSec(10) to 11 during (3 minutes),
      nothingFor(15 minutes),
      rampUsersPerSec(10) to 11 during (3 minutes),
      nothingFor(30 minutes),
      rampUsersPerSec(10) to 11 during (3 minutes),
      nothingFor(45 minutes),
      rampUsersPerSec(10) to 11 during (3 minutes),
      nothingFor(60 minutes),
      rampUsersPerSec(10) to 11 during (3 minutes)
    )
    .protocols(httpConf)

  setUp(matrixMultiplicationScenarioCfg).protocols(httpConf)

}
