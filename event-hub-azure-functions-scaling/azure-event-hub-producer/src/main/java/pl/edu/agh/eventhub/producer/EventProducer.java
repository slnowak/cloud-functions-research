package pl.edu.agh.eventhub.producer;

import com.microsoft.azure.eventhubs.EventData;
import com.microsoft.azure.eventhubs.EventHubClient;

import java.util.stream.IntStream;

public class EventProducer {
    private final EventHubClient eventHubClient;

    public EventProducer(EventHubClient eventHubClient) {
        this.eventHubClient = eventHubClient;
    }

    public void pushEvents(int numberOfEvents) {
        IntStream
                .range(0, numberOfEvents)
                .forEach(this::publishEvent);
    }

    private void publishEvent(int eventId) {
        try {
            final EventData eventData = new EventData(messageFromValue(eventId));
            eventHubClient.send(eventData).get();
        } catch (Exception e) {
            throw new RuntimeException("Couldn't send message", e);
        }
    }

    private byte[] messageFromValue(Integer eventId) {
        final EventIdWrapper eventIdWrapper = new EventIdWrapper(eventId);
        return JsonSerializer.writeValueAsJsonByteArray(eventIdWrapper);
    }

}
