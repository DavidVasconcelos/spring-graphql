package com.udemy.springgraphql;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;

import com.udemy.springgraphql.client.StarWarsRestClient;
import com.udemy.springgraphql.client.request.GraphqlRestRequest;
import com.udemy.springgraphql.client.response.FilmResponse;
import com.udemy.springgraphql.client.response.GraphqlErrorResponse;
import com.udemy.springgraphql.client.response.PlanetResponse;
import com.udemy.springgraphql.client.response.StarshipResponse;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class StarWarsRestClientTests {

  @Autowired
  private StarWarsRestClient starWarsRestClient;

  @Test
  void testAsJson() throws Exception {
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

    final GraphqlRestRequest body = new GraphqlRestRequest();
    body.setQuery(query);
    final String result = starWarsRestClient.asJson(body, null);
    assertNotNull(result);
  }

  @Test
  void testAsJson_Invalid() throws Exception {
    final String query = """
        query allPlanets {
          allPlanetsxxxxx {
            planets {
              name
              climates
              terrains
            }
          }
        }
        """;

    final GraphqlRestRequest body = new GraphqlRestRequest();
    body.setQuery(query);
    assertThrows(RuntimeException.class, () -> starWarsRestClient.asJson(body, null));
  }

  @Test
  void testAllPlanets() throws Exception {
    final List<PlanetResponse> result = starWarsRestClient.allPlanets();
    assertNotNull(result);
    assertFalse(result.isEmpty());
  }

  @Test
  void testOneStarshipFixed() throws Exception {
    final StarshipResponse result = starWarsRestClient.oneStarshipFixed();
    assertNotNull(result);
    assertNotNull(result.getModel());
    assertNotNull(result.getName());
    assertNotNull(result.getManufacturers());
  }

  @Test
  void testOneFilm_Right() throws Exception {
    final FilmResponse result = starWarsRestClient.oneFilm("1");
    assertNotNull(result);
    assertNotNull(result.getTitle());
  }

  @Test
  void testOneFilm_Invalid() throws Exception {
    final List<GraphqlErrorResponse> errors = starWarsRestClient.oneFilmInvalid();
    assertNotNull(errors);
    assertFalse(errors.isEmpty());
  }

}
