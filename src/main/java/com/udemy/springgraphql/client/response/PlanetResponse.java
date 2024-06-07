package com.udemy.springgraphql.client.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class PlanetResponse {

  private String name;
  private List<String> climates;
  private List<String> terrains;
}
