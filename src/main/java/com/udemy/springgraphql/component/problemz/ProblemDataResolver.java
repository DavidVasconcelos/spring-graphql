package com.udemy.springgraphql.component.problemz;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsMutation;
import com.netflix.graphql.dgs.DgsQuery;
import com.netflix.graphql.dgs.DgsSubscription;
import com.netflix.graphql.dgs.InputArgument;
import com.netflix.graphql.dgs.exceptions.DgsEntityNotFoundException;
import com.udemy.springgraphql.datasource.problemz.entity.Problemz;
import com.udemy.springgraphql.datasource.problemz.entity.Userz;
import com.udemy.springgraphql.exception.ProblemzAuthenticationException;
import com.udemy.springgraphql.generated.types.Problem;
import com.udemy.springgraphql.generated.types.ProblemCreateInput;
import com.udemy.springgraphql.generated.types.ProblemResponse;
import com.udemy.springgraphql.service.command.ProblemzCommandService;
import com.udemy.springgraphql.service.query.ProblemzQueryService;
import com.udemy.springgraphql.service.query.UserzQueryService;
import com.udemy.springgraphql.util.GraphqlBeanMapper;
import java.util.Optional;
import org.springframework.web.bind.annotation.RequestHeader;
import reactor.core.publisher.Flux;

import java.util.List;
import java.util.UUID;

@DgsComponent
public class ProblemDataResolver {

  private final ProblemzQueryService service;
  private final GraphqlBeanMapper graphqlBeanMapper;
  private final UserzQueryService userzQueryService;
  private final ProblemzCommandService problemzCommandService;

  public ProblemDataResolver(final ProblemzQueryService service,
      final GraphqlBeanMapper graphqlBeanMapper, final UserzQueryService userzQueryService,
      final ProblemzCommandService problemzCommandService) {
    this.service = service;
    this.graphqlBeanMapper = graphqlBeanMapper;
    this.userzQueryService = userzQueryService;
    this.problemzCommandService = problemzCommandService;
  }

  @DgsQuery(field = "problemLatestList")
  public List<Problem> getProblemLatestList() {
    return service.problemzLatestList()
        .stream()
        .map(graphqlBeanMapper::mapToGraphql)
        .toList();
  }

  @DgsQuery(field = "problemDetail")
  public Problem getProblemDetail(@InputArgument(name = "id") final String problemId) {
    return service.problemzDetail(UUID.fromString(problemId))
        .map(graphqlBeanMapper::mapToGraphql)
        .orElseThrow(DgsEntityNotFoundException::new);
  }

  @DgsMutation(field = "problemCreate")
  public ProblemResponse createProblem(@RequestHeader(name = "authToken") final String authToken,
      @InputArgument(name = "problem") final ProblemCreateInput problemCreateInput) {
    final Userz userz = userzQueryService.findUserzByAuthToken(authToken)
        .orElseThrow(ProblemzAuthenticationException::new);
    final Problemz problemz = graphqlBeanMapper.mapToEntity(problemCreateInput, userz);
    final Problemz savedProblemz = problemzCommandService.createProblemz(problemz);
    return ProblemResponse.newBuilder()
        .problem(graphqlBeanMapper.mapToGraphql(savedProblemz))
        .build();
  }

  @DgsSubscription(field = "problemAdded")
  public Flux<Problem> subscribeProblemAdded() {
    return problemzCommandService.problemzFlux().map(graphqlBeanMapper::mapToGraphql);
  }
}
