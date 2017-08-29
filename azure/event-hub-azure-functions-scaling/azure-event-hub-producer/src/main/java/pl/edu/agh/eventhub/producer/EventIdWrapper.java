package pl.edu.agh.eventhub.producer;

public class EventIdWrapper {
    private final Integer value;

    public EventIdWrapper(Integer value) {
        this.value = value;
    }

    public double getValue() {
        return value;
    }

}
