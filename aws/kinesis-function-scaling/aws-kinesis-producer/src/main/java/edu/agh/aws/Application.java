package edu.agh.aws;

import edu.agh.aws.kinesis.KinesisQueue;
import edu.agh.aws.kinesis.KinesisQueueFactory;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Application {

    private static final KinesisQueue kinesisQueue = KinesisQueueFactory.kinesisQueue();
    private static final List<IntWrapper> chunk = IntStream
            .range(0, 500)
            .boxed()
            .map(IntWrapper::new)
            .collect(Collectors.toList());

    public static void main(String[] args) {
        IntStream
                .range(0, 200)
                .forEach(i -> kinesisQueue.push(chunk));
    }

}
