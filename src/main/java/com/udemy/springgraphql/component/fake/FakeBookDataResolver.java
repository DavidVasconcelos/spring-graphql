package com.udemy.springgraphql.component.fake;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsQuery;
import com.netflix.graphql.dgs.InputArgument;
import com.udemy.springgraphql.datasource.fake.FakeBookDataSource;
import com.udemy.springgraphql.generated.types.Book;
import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.Optional;

@DgsComponent
public class FakeBookDataResolver {

    @SuppressWarnings("DgsInputArgumentValidationInspector") // in Kotlin you can use nullable
    @DgsQuery(field = "books")
    //@DgsData(parentType = "Query", field = "books") //old style
    public List<Book> booksWrittenBy(@InputArgument(name = "author") final Optional<String> optionalAuthorName) {
        return optionalAuthorName
                .map(authorName -> FakeBookDataSource.BOOK_LIST
                        .stream()
                        .filter(book -> StringUtils.containsIgnoreCase(book.getAuthor().getName(), authorName))
                        .toList())
                .orElse(FakeBookDataSource.BOOK_LIST);

    }
}
