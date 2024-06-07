package com.udemy.springgraphql.client;

import com.jayway.jsonpath.TypeRef;
import com.netflix.graphql.dgs.client.GraphQLClient;
import com.netflix.graphql.dgs.client.GraphQLError;
import com.netflix.graphql.dgs.client.GraphQLResponse;
import com.netflix.graphql.dgs.client.HttpResponse;
import com.udemy.springgraphql.client.response.FilmResponse;
import com.udemy.springgraphql.client.response.PlanetResponse;
import com.udemy.springgraphql.client.response.StarshipResponse;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.intellij.lang.annotations.Language;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class StarWarsGraphqlClient {

  private final String URL = "https://swapi-graphql.netlify.app/.netlify/functions/index";
  @Language("graphql")
  private final String QUERY = """
      query allPlanets {
        allPlanets {
          planets {
            name
            climates
            terrains
          }
        }
      }
      query oneStarshipFixed {
        starship(id: "c3RhcnNoaXBzOjU=") {
          model
          name
          manufacturers
        }
      }
      query oneFilm($filmId: ID!) {
        film(filmID: $filmId) {
          title
          director
          releaseDate
        }
      }
      """;
  private final RestTemplate restTemplate = new RestTemplate();
  private final GraphQLClient graphqlClient = GraphQLClient.createCustom(URL,
      (requestUrl, headers, body) -> {
        HttpHeaders httpHeaders = new HttpHeaders();
        headers.forEach(httpHeaders::addAll);
        ResponseEntity<String> exchange = restTemplate.exchange(URL, HttpMethod.POST,
            new HttpEntity<>(body, httpHeaders), String.class);
        return new HttpResponse(exchange.getStatusCode().value(), exchange.getBody());
      });

  private GraphQLResponse getGraphqlResponse(final String operationName,
      final Map<String, ?> variablesMap, final Map<String, List<String>> headersMap) {
    return graphqlClient.executeQuery(QUERY,
        Optional.ofNullable(variablesMap).orElse(Collections.emptyMap()),
        operationName
    );
  }

  public String asJson(final String operationName, final Map<String, ?> variablesMap,
      final Map<String, List<String>> headersMap) {
    return getGraphqlResponse(operationName, variablesMap, headersMap).getJson();
  }

  public List<PlanetResponse> allPlanets() {
    return getGraphqlResponse("allPlanets", null, null)
        .extractValueAsObject("allPlanets.planets", new TypeRef<>() {
        });
  }

  public StarshipResponse oneStarshipFixed() {
    return getGraphqlResponse("oneStarshipFixed", null, null)
        .extractValueAsObject("starship", StarshipResponse.class);
  }

  public FilmResponse oneFilm(String filmId) {
    final Map<String, String> variablesMap = Map.of("filmId", filmId);
    return getGraphqlResponse("oneFilm", variablesMap, null)
        .extractValueAsObject("film", FilmResponse.class);
  }

  public List<GraphQLError> oneFilmInvalid() {
    final Map<String, String> variablesMap = Map.of("filmId", "xxxxxx");
    final GraphQLResponse graphqlResponse = getGraphqlResponse(
        "oneFilm", variablesMap, null
    );
    return graphqlResponse.hasErrors() ? graphqlResponse.getErrors() : null;
  }
}
