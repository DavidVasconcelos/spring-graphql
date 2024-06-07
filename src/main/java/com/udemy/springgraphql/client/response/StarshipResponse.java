package com.udemy.springgraphql.client.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class StarshipResponse {

  private String name;
  private String model;
  private List<String> manufacturers;
}
