package pl.edu.agh.eventhub.producer;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

class JsonSerializer {
    static ObjectMapper objectMapper = new ObjectMapper();

    static byte[] writeValueAsJsonByteArray(Object object) {
        try {
            final String valueAsString = objectMapper.writeValueAsString(object);
            return valueAsString.getBytes();
        } catch (JsonProcessingException e) {
            throw new RuntimeException("Couldn't serialize object", e);
        }
    }

}
