package agh;

import agh.execution.MonteCarloPiCalculator;
import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import agh.lambda.ApiGatewayProxyResponse;
import agh.lambda.ApiGatewayRequest;

public class ApiGatewayProxiedMicroservice implements RequestHandler<ApiGatewayRequest, ApiGatewayProxyResponse> {
    private static final Integer MAX_ROUNDS = 25000;

    public ApiGatewayProxyResponse handleRequest(ApiGatewayRequest request, Context context) {
        MonteCarloPiCalculator.an();
        return new ApiGatewayProxyResponse(200, null, String.valueOf(MonteCarloPiCalculator.pi(MAX_ROUNDS)));
    }

}
