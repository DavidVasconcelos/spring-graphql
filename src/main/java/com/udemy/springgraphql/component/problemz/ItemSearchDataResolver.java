package com.udemy.springgraphql.component.problemz;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsQuery;
import com.netflix.graphql.dgs.InputArgument;
import com.netflix.graphql.dgs.exceptions.DgsEntityNotFoundException;
import com.udemy.springgraphql.generated.types.Problem;
import com.udemy.springgraphql.generated.types.SearchItemFilter;
import com.udemy.springgraphql.generated.types.SearchableItem;
import com.udemy.springgraphql.generated.types.Solution;
import com.udemy.springgraphql.service.query.ProblemzQueryService;
import com.udemy.springgraphql.service.query.SolutionzQueryService;
import com.udemy.springgraphql.util.GraphqlBeanMapper;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Stream;

@DgsComponent
public class ItemSearchDataResolver {

  private final ProblemzQueryService problemzQueryService;
  private final SolutionzQueryService solutionzQueryService;
  private final GraphqlBeanMapper graphqlBeanMapper;

  public ItemSearchDataResolver(final ProblemzQueryService problemzQueryService,
      final SolutionzQueryService solutionzQueryService,
      final GraphqlBeanMapper graphqlBeanMapper) {
    this.problemzQueryService = problemzQueryService;
    this.solutionzQueryService = solutionzQueryService;
    this.graphqlBeanMapper = graphqlBeanMapper;
  }

  @DgsQuery(field = "itemSearch")
  public List<SearchableItem> searchItems(
      @InputArgument(name = "filter") final SearchItemFilter filter) {
    final List<Problem> problemList = problemzQueryService
        .problemzByKeyword(filter.getKeyword())
        .stream()
        .map(graphqlBeanMapper::mapToGraphql)
        .toList();
    final List<Solution> solutionList = solutionzQueryService
        .solutionzByKeyword(filter.getKeyword())
        .stream()
        .map(graphqlBeanMapper::mapToGraphql)
        .toList();
    final List<SearchableItem> resultList = new ArrayList<>(
        Stream.concat(solutionList.stream(), problemList.stream()).toList()
    );
    if (resultList.isEmpty()) {
      throw new DgsEntityNotFoundException("No item with keyword " + filter.getKeyword());
    }
    resultList.sort(Comparator.comparing(SearchableItem::getCreateDateTime).reversed());
    return resultList;
  }
}