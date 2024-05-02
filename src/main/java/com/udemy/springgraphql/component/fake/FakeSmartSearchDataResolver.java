package com.udemy.springgraphql.component.fake;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsQuery;
import com.netflix.graphql.dgs.InputArgument;
import com.udemy.springgraphql.datasource.fake.FakeBookDataSource;
import com.udemy.springgraphql.datasource.fake.FakeHelloDataSource;
import com.udemy.springgraphql.datasource.fake.FakeMobileAppDataSource;
import com.udemy.springgraphql.generated.types.SmartSearchResult;
import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@DgsComponent
public class FakeSmartSearchDataResolver {

    @SuppressWarnings("DgsInputArgumentValidationInspector")
    @DgsQuery(field = "smartSearch")
    public List<SmartSearchResult> getSmartSearchResult(@InputArgument(name = "keyword") Optional<String> keyword) {
        return keyword
                .map(this::filterByKeyWord)
                .orElse(getLists());
    }

    private List<SmartSearchResult> filterByKeyWord(final String keyword) {
        final List<SmartSearchResult> smartSearchResults = new ArrayList<>();
        FakeHelloDataSource.HELLO_LIST
                .stream()
                .filter(hello -> StringUtils.containsIgnoreCase(hello.getText(), keyword))
                .forEach(smartSearchResults::add);
        FakeBookDataSource.BOOK_LIST
                .stream()
                .filter(book -> StringUtils.containsIgnoreCase(book.getTitle(), keyword))
                .forEach(smartSearchResults::add);
        return smartSearchResults;
    }

    private List<SmartSearchResult> getLists() {
        final List<SmartSearchResult> smartSearchResults = new ArrayList<>();
        smartSearchResults.addAll(FakeHelloDataSource.HELLO_LIST);
        smartSearchResults.addAll(FakeBookDataSource.BOOK_LIST);
        return smartSearchResults;
    }
}
