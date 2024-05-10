package com.udemy.springgraphql.service.command;

import com.udemy.springgraphql.datasource.problemz.entity.Problemz;
import reactor.core.publisher.Flux;

public interface ProblemzCommandService {

  Problemz createProblemz(Problemz problemz);

  Flux<Problemz> problemzFlux();

}
