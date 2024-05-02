package com.udemy.springgraphql.component.fake.resolver;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsQuery;
import com.netflix.graphql.dgs.InputArgument;
import com.udemy.springgraphql.datasource.fake.FakeBookDataSource;
import com.udemy.springgraphql.generated.DgsConstants;
import com.udemy.springgraphql.generated.types.Book;
import com.udemy.springgraphql.generated.types.ReleaseHistory;
import com.udemy.springgraphql.generated.types.ReleaseHistoryInput;
import graphql.schema.DataFetchingEnvironment;
import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.Map;
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

    @SuppressWarnings("DgsInputArgumentInspector")
    @DgsQuery(field = "booksByReleased")
//    @DgsData(
//            parentType = DgsConstants.QUERY_TYPE,
//            field = DgsConstants.QUERY.BooksByReleased
//    )
    public List<Book> getBooksByReleased(final DataFetchingEnvironment dataFetchingEnvironment) {
        final Map<String, Object> releasedMap = dataFetchingEnvironment.getArgument("releasedInput");
        final ReleaseHistoryInput releasedInput = ReleaseHistoryInput.newBuilder()
                .printedEdition((Boolean) releasedMap.get(DgsConstants.RELEASEHISTORYINPUT.PrintedEdition))
                .year((Integer) releasedMap.get(DgsConstants.RELEASEHISTORYINPUT.Year))
                .build();
        return FakeBookDataSource.BOOK_LIST.stream()
                .filter(book -> matchReleaseHistory(releasedInput, book.getReleased()))
                .toList();
    }

    private Boolean matchReleaseHistory(final ReleaseHistoryInput input, final ReleaseHistory element) {
        return input.getPrintedEdition().equals(element.getPrintedEdition()) && input.getYear() == element.getYear();
    }
}
