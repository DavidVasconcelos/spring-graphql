package com.udemy.springgraphql.component.problemz;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsMutation;
import com.netflix.graphql.dgs.DgsQuery;
import com.netflix.graphql.dgs.DgsSubscription;
import com.netflix.graphql.dgs.InputArgument;
import com.udemy.springgraphql.generated.types.Problem;
import com.udemy.springgraphql.generated.types.ProblemCreateInput;
import com.udemy.springgraphql.generated.types.ProblemResponse;
import org.springframework.web.bind.annotation.RequestHeader;
import reactor.core.publisher.Flux;

import java.util.List;

@DgsComponent
public class ProblemDataResolver {

    @DgsQuery(field = "problemLatestList")
    public List<Problem> getProblemLatestList() {
        return null;
    }

    @DgsQuery(field = "problemDetail")
    public Problem getProblemDetail(@InputArgument(name = "id") final String problemId) {
        return null;
    }

    @DgsMutation(field = "problemCreate")
    public ProblemResponse createProblem(@RequestHeader(name = "authToken", required = true) final String authToken,
                                         @InputArgument(name = "problem") final ProblemCreateInput problemCreateInput) {
        return null;
    }

    @DgsSubscription(field = "problemAdded")
    public Flux<Problem> subscribeProblemAdded() {
        return null;
    }

}
