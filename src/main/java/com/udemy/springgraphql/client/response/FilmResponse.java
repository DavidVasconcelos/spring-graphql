package com.udemy.springgraphql.client.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class FilmResponse {

  private String title;
  private String director;
  private String releaseDate;
}

