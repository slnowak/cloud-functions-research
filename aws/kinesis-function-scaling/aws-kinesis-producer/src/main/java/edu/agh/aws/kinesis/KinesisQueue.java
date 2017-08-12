package edu.agh.aws.kinesis;

import com.amazonaws.services.kinesis.AmazonKinesis;
import com.amazonaws.services.kinesis.model.PutRecordsRequest;
import com.amazonaws.services.kinesis.model.PutRecordsRequestEntry;
import com.amazonaws.services.kinesis.model.PutRecordsResult;
import edu.agh.aws.IntWrapper;

import java.nio.ByteBuffer;
import java.util.Collection;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

public class KinesisQueue {
    private final AmazonKinesis amazonKinesis;
    private final String streamName;

    public KinesisQueue(AmazonKinesis amazonKinesis, String streamName) {
        this.amazonKinesis = amazonKinesis;
        this.streamName = streamName;
    }

    public void push(List<IntWrapper> values) {
        final PutRecordsRequest putRecordsRequest = new PutRecordsRequest();
        putRecordsRequest.setStreamName(streamName);
        putRecordsRequest.setRecords(putRecordRequests(values));

        final PutRecordsResult putRecordsResult = amazonKinesis.putRecords(putRecordsRequest);
        if (putRecordsResult.getFailedRecordCount() > 0)
            throw new IllegalStateException("Failed to push messages to kinesis queue");
    }

    private Collection<PutRecordsRequestEntry> putRecordRequests(List<IntWrapper> values) {
        return values
                .stream()
                .map(this::wrapAsPutRecordRequestEntry)
                .collect(Collectors.toList());
    }

    private PutRecordsRequestEntry wrapAsPutRecordRequestEntry(IntWrapper intWrapper) {
        final PutRecordsRequestEntry putRecordsRequestEntry = new PutRecordsRequestEntry();
        putRecordsRequestEntry.setData(ByteBuffer.wrap(JsonCodec.encodeAsJsonBytes(intWrapper)));
        putRecordsRequestEntry.setPartitionKey(UUID.randomUUID().toString());
        return putRecordsRequestEntry;
    }

}
