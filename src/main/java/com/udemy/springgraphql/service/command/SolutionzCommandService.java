package com.udemy.springgraphql.service.command;

import com.udemy.springgraphql.datasource.problemz.entity.Solutionz;
import java.util.Optional;
import java.util.UUID;
import reactor.core.publisher.Flux;

public interface SolutionzCommandService {

  Solutionz createSolutionz(Solutionz solutionz);

  Optional<Solutionz> voteBad(UUID solutionId);

  Optional<Solutionz> voteGood(UUID solutionId);

  Flux<Solutionz> solutionzFlux();

}
