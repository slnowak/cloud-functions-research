package pl.edu.agh.eventhub.producer;

class EventIdWrapper {
    private final Integer value;

    EventIdWrapper(Integer value) {
        this.value = value;
    }

    public double getValue() {
        return value;
    }

}
