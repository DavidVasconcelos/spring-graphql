package com.udemy.springgraphql;

import com.jayway.jsonpath.TypeRef;
import com.netflix.graphql.dgs.DgsQueryExecutor;
import com.netflix.graphql.dgs.client.codegen.GraphQLQueryRequest;
import com.udemy.springgraphql.generated.client.BooksByReleasedGraphQLQuery;
import com.udemy.springgraphql.generated.client.BooksGraphQLQuery;
import com.udemy.springgraphql.generated.client.BooksProjectionRoot;
import com.udemy.springgraphql.generated.client.ReleaseHistoryProjection;
import com.udemy.springgraphql.generated.types.Author;
import com.udemy.springgraphql.generated.types.ReleaseHistoryInput;
import net.datafaker.Faker;
import org.intellij.lang.annotations.Language;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
public class FakeBookDataResolverTest {

    @Autowired
    DgsQueryExecutor dgsQueryExecutor;

    @Autowired
    Faker faker;

    @Test
    void testAllBooks() {
        final BooksGraphQLQuery graphQLQuery = new BooksGraphQLQuery.Builder().build();
        final ReleaseHistoryProjection projectionRoot = ((BooksProjectionRoot) new BooksProjectionRoot()
                .title()
                .author()
                .name()
                .originCountry()
                .getRoot())
                .released().year();

        @Language("GraphQL") final String request = new GraphQLQueryRequest(graphQLQuery, projectionRoot).serialize();
        final List<String> titles = dgsQueryExecutor.executeAndExtractJsonPath(request, "data.books[*].title");

        assertNotNull(titles);
        assertFalse(titles.isEmpty());

        final List<Author> authors = dgsQueryExecutor.executeAndExtractJsonPathAsObject(request, "data.books[*].author",
                new TypeRef<>() {
                }
        );

        assertNotNull(authors);
        assertEquals(titles.size(), authors.size());

        List<Integer> releaseYears = dgsQueryExecutor.executeAndExtractJsonPathAsObject(
                request, "data.books[*].released.year",
                new TypeRef<>() {
                }
        );

        assertNotNull(releaseYears);
        assertEquals(titles.size(), releaseYears.size());
    }

    @Test
    void testBooksWithInput() {
        final Integer expectedYear = faker.number().numberBetween(2019, 2021);
        final Boolean expectedPrintedEdition = faker.bool().bool();

        final ReleaseHistoryInput releaseHistoryInput = ReleaseHistoryInput.newBuilder()
                .year(expectedYear)
                .printedEdition(expectedPrintedEdition)
                .build();
        final BooksByReleasedGraphQLQuery graphQLQuery = BooksByReleasedGraphQLQuery.newRequest()
                .releasedInput(releaseHistoryInput)
                .build();
        final ReleaseHistoryProjection projectionRoot = new BooksProjectionRoot()
                .released().year().printedEdition();

        @Language("GraphQL") final String request = new GraphQLQueryRequest(graphQLQuery, projectionRoot).serialize();

        final List<Integer> releaseYears = dgsQueryExecutor.executeAndExtractJsonPath(
                request, "data.booksByReleased[*].released.year"
        );
        final Set<Integer> uniqueReleaseYears = new HashSet<>(releaseYears);

        assertNotNull(uniqueReleaseYears);
        assertTrue(uniqueReleaseYears.size() <= 1);

        if (!uniqueReleaseYears.isEmpty()) {
            assertTrue(uniqueReleaseYears.contains(expectedYear));
        }

        final List<Boolean> releasePrintedEditions = dgsQueryExecutor.executeAndExtractJsonPath(
                request, "data.booksByReleased[*].released.printedEdition"
        );
        final Set<Boolean> uniqueReleasePrintedEditions = new HashSet<>(releasePrintedEditions);

        assertNotNull(uniqueReleasePrintedEditions);
        assertTrue(uniqueReleasePrintedEditions.size() <= 1);

        if (!uniqueReleasePrintedEditions.isEmpty()) {
            assertTrue(uniqueReleasePrintedEditions.contains(expectedPrintedEdition));
        }
    }
}
