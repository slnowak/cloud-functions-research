package edu.agh.aws.kinesis;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonCodec {
    private final static ObjectMapper MAPPER;

    static {
        MAPPER = new ObjectMapper()
                .setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.NONE)
                .setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);
    }

    public static <T> byte[] encodeAsJsonBytes(T entity) {
        try {
            return MAPPER.writeValueAsBytes(entity);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

}