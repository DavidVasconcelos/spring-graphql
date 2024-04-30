package com.udemy.springgraphql;

import com.netflix.graphql.dgs.DgsQueryExecutor;
import io.micrometer.common.util.StringUtils;
import org.intellij.lang.annotations.Language;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class FakeHelloDataResolverTest {

    @Autowired
    DgsQueryExecutor dgsQueryExecutor;

    @Test
    void testOneHello() {
        @Language("GraphQL") final String graphqlQuery = """
                {
                   oneHello {
                    text
                    randomNumber
                  }
                }
                """;

        final String text = dgsQueryExecutor.executeAndExtractJsonPath(graphqlQuery, "data.oneHello.text");
        final Integer randomNumber = dgsQueryExecutor.executeAndExtractJsonPath(graphqlQuery, "data.oneHello.randomNumber");

        assertFalse(StringUtils.isBlank(text));
        assertNotNull(randomNumber);
    }

    @Test
    void testAllHellos() {
        @Language("GraphQL") final String graphqlQuery = """
                {
                   allHellos {
                    text
                    randomNumber
                  }
                }
                """;

        final List<String> texts = dgsQueryExecutor.executeAndExtractJsonPath(graphqlQuery, "data.allHellos[*].text");
        final List<Integer> randomNumbers = dgsQueryExecutor.executeAndExtractJsonPath(graphqlQuery, "data.allHellos[*].randomNumber");

        assertNotNull(texts);
        assertFalse(texts.isEmpty());
        assertNotNull(randomNumbers);
        assertEquals(texts.size(), randomNumbers.size());
    }
}
