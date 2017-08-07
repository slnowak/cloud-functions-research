package pl.edu.agh.aws.hotcold

import io.gatling.core.Predef._
import io.gatling.http.Predef._

import scala.concurrent.duration._
import scala.language.postfixOps

class HotColdJava extends Simulation {

  private val httpConf = http.baseURL("https://1k819updw7.execute-api.eu-central-1.amazonaws.com")
  private val matrixMultiplicationScenario = scenario("Multiply matrices")
    .exec(
      http("GET /prod/pi-java")
        .get("/prod/pi-java")
    )

  private val scenarioCfg = matrixMultiplicationScenario.inject(
    rampUsersPerSec(10) to 11 during (20 minutes)
  )

  setUp(scenarioCfg).protocols(httpConf)

}
