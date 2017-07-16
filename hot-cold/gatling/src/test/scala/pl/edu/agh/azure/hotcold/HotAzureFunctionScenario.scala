package pl.edu.agh.azure.hotcold

import java.util.concurrent.TimeUnit

import io.gatling.core.Predef.{rampUsersPerSec, _}
import io.gatling.http.Predef._

import scala.concurrent.duration._
import scala.language.postfixOps

class HotAzureFunctionScenario extends Simulation {

  private val httpConf = http.baseURL("https://cloud-functions-kkulak.azurewebsites.net/api")

  private val hotAzureFunctions = scenario("Hot azure functions")
//    .exec(
//      http("GET /hotColdCSharp")
//        .get("/hotColdCSharp")
//    )
    .exec(
      http("GET /hotColdJs")
        .get("/hotColdJs")
    )
//    .exec(
//        http("GET /hotColdPython")
//          .get("/hotColdPython")
//    )

  private val matrixMultiplicationScenarioCfg = hotAzureFunctions
    .inject(
      rampUsersPerSec(20) to 21 during (3 minutes),
      nothingFor(15 minutes),
      rampUsersPerSec(20) to 21 during (3 minutes),
      nothingFor(30 minutes),
      rampUsersPerSec(20) to 21 during (3 minutes),
      nothingFor(45 minutes),
      rampUsersPerSec(20) to 21 during (3 minutes),
      nothingFor(60 minutes),
      rampUsersPerSec(20) to 21 during (3 minutes)
    )
    .protocols(httpConf)

  setUp(matrixMultiplicationScenarioCfg)

}
