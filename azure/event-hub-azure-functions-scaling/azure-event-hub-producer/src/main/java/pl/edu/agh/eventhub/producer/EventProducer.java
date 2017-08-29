package pl.edu.agh.eventhub.producer;

import com.microsoft.azure.eventhubs.EventData;
import com.microsoft.azure.eventhubs.EventHubClient;
import com.microsoft.azure.servicebus.ServiceBusException;

import java.util.Collection;
import java.util.stream.Collectors;

public class EventProducer {
    private final EventHubClient eventHubClient;

    public EventProducer(EventHubClient eventHubClient) {
        this.eventHubClient = eventHubClient;
    }

    public void pushEvents(Collection<EventIdWrapper> events) {
        try {
            eventHubClient.sendSync(events.stream().map(this::asEventData).collect(Collectors.toList()));
        } catch (ServiceBusException e) {
            throw new RuntimeException(e);
        }
    }

    private EventData asEventData(EventIdWrapper eventId) {
        return new EventData(JsonSerializer.writeValueAsJsonByteArray(eventId));
    }

}
