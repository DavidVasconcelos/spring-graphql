package com.udemy.springgraphql.component.problemz;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsQuery;
import com.netflix.graphql.dgs.InputArgument;
import com.udemy.springgraphql.generated.types.SearchItemFilter;
import com.udemy.springgraphql.generated.types.SearchableItem;

import java.util.List;

@DgsComponent
public class ItemSearchDataResolver {

    @DgsQuery(field = "itemSearch")
    public List<SearchableItem> searchItems(@InputArgument(name = "filter") final SearchItemFilter filter) {
        return null;
    }

}