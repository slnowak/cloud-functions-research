package edu.agh.aws.kinesis;

import com.amazonaws.auth.EnvironmentVariableCredentialsProvider;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.kinesis.AmazonKinesisClientBuilder;

public class KinesisQueueFactory {

    public static KinesisQueue kinesisQueue() {
        return new KinesisQueue(
                AmazonKinesisClientBuilder
                        .standard()
                        .withCredentials(new EnvironmentVariableCredentialsProvider())
                        .withRegion(Regions.EU_WEST_1)
                        .build(),
                "matrix-multiplication-events"
        );
    }

}
