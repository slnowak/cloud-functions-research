package pl.edu.agh.eventhub.producer;

import com.microsoft.azure.eventhubs.EventHubClient;
import com.microsoft.azure.servicebus.ConnectionStringBuilder;
import pl.edu.agh.eventhub.Configuration;

public class EventHubClientFactory {

    public static EventHubClient create() {
        final ConnectionStringBuilder connStr = new ConnectionStringBuilder(
                Configuration.getString("eventhub.namespacename"),
                Configuration.getString("eventhub.eventhubname"),
                Configuration.getString("eventhub.saskeyname"),
                Configuration.getString("eventhub.saskey")
        );

        try {
            return EventHubClient.createFromConnectionString(connStr.toString()).get();
        } catch (Exception e) {
            throw new RuntimeException("Unrecognized exception", e);
        }
    }

}
