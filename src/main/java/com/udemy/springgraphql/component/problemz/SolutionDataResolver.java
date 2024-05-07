package com.udemy.springgraphql.component.problemz;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsMutation;
import com.netflix.graphql.dgs.DgsSubscription;
import com.netflix.graphql.dgs.InputArgument;
import com.udemy.springgraphql.generated.types.Solution;
import com.udemy.springgraphql.generated.types.SolutionCreateInput;
import com.udemy.springgraphql.generated.types.SolutionResponse;
import com.udemy.springgraphql.generated.types.SolutionVoteInput;
import org.springframework.web.bind.annotation.RequestHeader;
import reactor.core.publisher.Flux;

@DgsComponent
public class SolutionDataResolver {

    @DgsMutation(field = "solutionCreate")
    public SolutionResponse createSolution(
            @RequestHeader(name = "authToken", required = true) final String authToken,
            @InputArgument(name = "solution") final SolutionCreateInput solutionCreateInput
    ) {
        return null;
    }

    @DgsMutation(field = "solutionVote")
    public SolutionResponse createSolutionVote(
            @RequestHeader(name = "authToken", required = true) final String authToken,
            @InputArgument(name = "vote") final SolutionVoteInput solutionVoteInput
    ) {
        return null;
    }

    @DgsSubscription(field = "solutionVoteChanged")
    public Flux<Solution> subscribeSolutionVote(@InputArgument(name = "solutionId") final String solutionId) {
        return null;
    }

}