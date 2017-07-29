package pl.edu.agh.eventhub;

import com.microsoft.azure.eventhubs.EventHubClient;
import pl.edu.agh.eventhub.producer.EventHubClientFactory;
import pl.edu.agh.eventhub.producer.EventProducer;

public class Application {

    public static void main(String[] args) throws Exception {
        final EventHubClient eventHubClient = EventHubClientFactory.create();
        final EventProducer eventProducer = new EventProducer(eventHubClient);

        System.out.println("Starting...");
        eventProducer.pushEvents(100);
        System.out.println("Finished.");

        eventHubClient.onClose().get();
    }

}
