package pl.edu.agh.eventhub;

import com.microsoft.azure.eventhubs.EventHubClient;
import pl.edu.agh.eventhub.producer.EventHubClientFactory;
import pl.edu.agh.eventhub.producer.EventIdWrapper;
import pl.edu.agh.eventhub.producer.EventProducer;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Application {
    private static final List<EventIdWrapper> chunk = IntStream
            .range(0, 500)
            .boxed()
            .map(EventIdWrapper::new)
            .collect(Collectors.toList());

    public static void main(String[] args) throws Exception {
        final EventHubClient eventHubClient = EventHubClientFactory.create();
        final EventProducer eventProducer = new EventProducer(eventHubClient);

        IntStream
                .range(0, 200)
                .forEach(i -> eventProducer.pushEvents(chunk));

        eventHubClient.onClose().get();
    }

}
