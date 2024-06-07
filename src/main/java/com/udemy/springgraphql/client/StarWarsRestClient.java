package com.udemy.springgraphql.client;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.udemy.springgraphql.client.request.GraphqlRestRequest;
import com.udemy.springgraphql.client.response.FilmResponse;
import com.udemy.springgraphql.client.response.GraphqlErrorResponse;
import com.udemy.springgraphql.client.response.PlanetResponse;
import com.udemy.springgraphql.client.response.StarshipResponse;
import java.util.List;
import java.util.Map;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.client.RestTemplate;

@Component
public class StarWarsRestClient {

  private final String URL = "https://swapi-graphql.netlify.app/.netlify/functions/index";
  private final RestTemplate restTemplate = new RestTemplate();
  private final ObjectMapper objectMapper = new ObjectMapper();

  public String asJson(final GraphqlRestRequest body, final Map<String, List<String>> headersMap) {
    final HttpHeaders httpHeaders = new HttpHeaders();
    if (headersMap != null && !headersMap.isEmpty()) {
      httpHeaders.addAll(new LinkedMultiValueMap<>(headersMap));
    }
    final ResponseEntity<String> responseEntity = restTemplate.postForEntity(URL,
        new HttpEntity<>(body, httpHeaders), String.class);
    return responseEntity.getBody();
  }

  public List<PlanetResponse> allPlanets() throws JsonProcessingException {
    final String query = """
        query allPlanets {
          allPlanets {
            planets {
              name
              climates
              terrains
            }
          }
        }
        """;
    final JsonNode data = getJsonNode(query, "/data/allPlanets/planets", null);
    return objectMapper.readValue(data.toString(), new TypeReference<>() {
    });
  }

  public StarshipResponse oneStarshipFixed() throws JsonProcessingException {
    final String query = """
        query oneStarshipFixed {
          starship(id: "c3RhcnNoaXBzOjU=") {
            model
            name
            manufacturers
          }
        }
        """;

    final JsonNode data = getJsonNode(query, "/data/starship", null);
    return objectMapper.readValue(data.toString(), StarshipResponse.class);
  }

  public FilmResponse oneFilm(final String filmId) throws JsonProcessingException {
    var query = """
        query oneFilm($filmId: ID!) {
          film(filmID: $filmId) {
            title
            director
            releaseDate
          }
        }
        """;

    final JsonNode data = getJsonNode(query, "/data/film", Map.of("filmId", filmId));
    return objectMapper.readValue(data.toString(), FilmResponse.class);
  }

  public List<GraphqlErrorResponse> oneFilmInvalid() throws JsonProcessingException {
    var query = """
        query oneFilm($filmId: ID!) {
          film(filmID: $filmId) {
            title
            director
            releaseDate
          }
        }
        """;

    final JsonNode errors = getJsonNode(query, "/errors", Map.of("filmId", "xxxxx"));
    if (errors != null) {
      return objectMapper.readValue(errors.toString(),
          new TypeReference<>() {
          });
    }
    return null;
  }

  private JsonNode getJsonNode(final String query, final String path,
      final Map<String, String> variablesMap)
      throws JsonProcessingException {
    final GraphqlRestRequest body = new GraphqlRestRequest();
    body.setQuery(query);
    if (variablesMap != null && !variablesMap.isEmpty()) {
      body.setVariables(variablesMap);
    }
    final String result = this.asJson(body, null);
    final JsonNode jsonNode = objectMapper.readTree(result);
    return jsonNode.at(path);
  }
}
