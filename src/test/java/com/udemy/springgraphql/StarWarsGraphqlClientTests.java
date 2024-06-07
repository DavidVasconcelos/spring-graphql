package com.udemy.springgraphql;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;

import com.netflix.graphql.dgs.client.GraphQLError;
import com.udemy.springgraphql.client.StarWarsGraphqlClient;
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
public class StarWarsGraphqlClientTests {

  @Autowired
  private StarWarsGraphqlClient starWarsGraphqlClient;

  @Test
  void testAsJson() throws Exception {
    final String result = starWarsGraphqlClient.asJson("allPlanets", null, null);
    assertNotNull(result);
  }

  @Test
  void testAsJson_Invalid() throws Exception {
    assertThrows(RuntimeException.class, () -> starWarsGraphqlClient.asJson("allPlanetsxxxxx", null, null));
  }

  @Test
  void testAllPlanets() throws Exception {
    final List<PlanetResponse> result = starWarsGraphqlClient.allPlanets();
    assertNotNull(result);
    assertFalse(result.isEmpty());
  }

  @Test
  void testOneStarshipFixed() throws Exception {
    final StarshipResponse result = starWarsGraphqlClient.oneStarshipFixed();
    assertNotNull(result);
    assertNotNull(result.getModel());
    assertNotNull(result.getName());
    assertNotNull(result.getManufacturers());
  }

  @Test
  void testOneFilm_Right() throws Exception {
    final FilmResponse result = starWarsGraphqlClient.oneFilm("1");
    assertNotNull(result);
    assertNotNull(result.getTitle());
  }

  @Test
  void testOneFilm_Invalid() throws Exception {
    final List<GraphQLError> errors = starWarsGraphqlClient.oneFilmInvalid();
    assertNotNull(errors);
    assertFalse(errors.isEmpty());
  }

}
