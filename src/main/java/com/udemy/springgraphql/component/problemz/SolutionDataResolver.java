package com.udemy.springgraphql.component.problemz;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsMutation;
import com.netflix.graphql.dgs.DgsSubscription;
import com.netflix.graphql.dgs.InputArgument;
import com.netflix.graphql.dgs.exceptions.DgsEntityNotFoundException;
import com.udemy.springgraphql.datasource.problemz.entity.Problemz;
import com.udemy.springgraphql.datasource.problemz.entity.Solutionz;
import com.udemy.springgraphql.datasource.problemz.entity.Userz;
import com.udemy.springgraphql.exception.ProblemzAuthenticationException;
import com.udemy.springgraphql.generated.types.Solution;
import com.udemy.springgraphql.generated.types.SolutionCreateInput;
import com.udemy.springgraphql.generated.types.SolutionResponse;
import com.udemy.springgraphql.generated.types.SolutionVoteInput;
import com.udemy.springgraphql.service.command.SolutionzCommandService;
import com.udemy.springgraphql.service.query.ProblemzQueryService;
import com.udemy.springgraphql.service.query.UserzQueryService;
import com.udemy.springgraphql.util.GraphqlBeanMapper;
import java.util.Optional;
import java.util.UUID;
import org.springframework.web.bind.annotation.RequestHeader;
import reactor.core.publisher.Flux;

@DgsComponent
public class SolutionDataResolver {

  private final SolutionzCommandService solutionzCommandService;
  private final UserzQueryService userzQueryService;
  private final ProblemzQueryService problemzQueryService;
  private final GraphqlBeanMapper graphqlBeanMapper;

  public SolutionDataResolver(final SolutionzCommandService solutionzCommandService,
      final UserzQueryService userzQueryService, final ProblemzQueryService problemzQueryService,
      final GraphqlBeanMapper graphqlBeanMapper) {
    this.solutionzCommandService = solutionzCommandService;
    this.userzQueryService = userzQueryService;
    this.problemzQueryService = problemzQueryService;
    this.graphqlBeanMapper = graphqlBeanMapper;
  }

  @DgsMutation(field = "solutionCreate")
  public SolutionResponse createSolution(
      @RequestHeader(name = "authToken", required = true) final String authToken,
      @InputArgument(name = "solution") final SolutionCreateInput solutionCreateInput
  ) {
    final Userz userz = getUserz(authToken);
    final UUID problemId = UUID.fromString(solutionCreateInput.getProblemId());
    final Problemz problemz = problemzQueryService.problemzDetail(problemId)
        .orElseThrow(DgsEntityNotFoundException::new);
    final Solutionz solutionz = graphqlBeanMapper.mapToEntity(solutionCreateInput, userz, problemz);
    final Solutionz savedSolutionz = solutionzCommandService.createSolutionz(solutionz);
    return SolutionResponse.newBuilder()
        .solution(graphqlBeanMapper.mapToGraphql(savedSolutionz))
        .build();
  }

  @DgsMutation(field = "solutionVote")
  public SolutionResponse createSolutionVote(
      @RequestHeader(name = "authToken", required = true) final String authToken,
      @InputArgument(name = "vote") final SolutionVoteInput solutionVoteInput
  ) {
    getUserz(authToken);
    final UUID solutionId = UUID.fromString(solutionVoteInput.getSolutionId());
    final Optional<Solutionz> optionalSolutionz =
        solutionVoteInput.getVoteAsGood() ? solutionzCommandService.voteGood(solutionId)
            : solutionzCommandService.voteBad(solutionId);
    final Solutionz solutionz = optionalSolutionz.orElseThrow(DgsEntityNotFoundException::new);
    return SolutionResponse.newBuilder()
        .solution(graphqlBeanMapper.mapToGraphql(solutionz))
        .build();
  }

  @DgsSubscription(field = "solutionVoteChanged")
  public Flux<Solution> subscribeSolutionVote(
      @InputArgument(name = "solutionId") final String solutionId) {
    return solutionzCommandService.solutionzFlux().map(graphqlBeanMapper::mapToGraphql);
  }

  private Userz getUserz(final String authToken) {
    return userzQueryService.findUserzByAuthToken(authToken)
        .orElseThrow(ProblemzAuthenticationException::new);
  }
}