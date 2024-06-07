package com.udemy.springgraphql.client.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class GraphqlErrorResponse {

  @Getter
  @Setter
  private static class Location {

    private String line;
    private String column;
  }

  private String message;
  private List<String> path;
  private List<Location> locations;
}

