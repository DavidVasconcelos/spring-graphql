package com.udemy.springgraphql.service.command.impl;

import com.udemy.springgraphql.datasource.problemz.entity.Solutionz;
import com.udemy.springgraphql.datasource.problemz.repository.SolutionzRepository;
import com.udemy.springgraphql.service.command.SolutionzCommandService;
import java.util.Optional;
import java.util.UUID;
import org.jetbrains.annotations.NotNull;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Sinks;

@Service
public class SolutionzCommandServiceImpl implements SolutionzCommandService {

  private final SolutionzRepository solutionzRepository;
  private final Sinks.Many<Solutionz> solutionzSink = Sinks.many().multicast()
      .onBackpressureBuffer();

  public SolutionzCommandServiceImpl(final SolutionzRepository solutionzRepository) {
    this.solutionzRepository = solutionzRepository;
  }

  @Override
  @Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = {Exception.class})
  public Solutionz createSolutionz(final Solutionz solutionz) {
    return solutionzRepository.save(solutionz);
  }

  @Override
  public Optional<Solutionz> voteBad(final UUID solutionId) {
    solutionzRepository.addVoteBadCount(solutionId);
    return emitSolution(solutionId);
  }

  @Override
  public Optional<Solutionz> voteGood(final UUID solutionId) {
    solutionzRepository.addVoteGoodCount(solutionId);
    return emitSolution(solutionId);
  }

  @Override
  public Flux<Solutionz> solutionzFlux() {
    return solutionzSink.asFlux();
  }

  private Optional<Solutionz> emitSolution(final UUID solutionId) {
    final Optional<Solutionz> saved = solutionzRepository.findById(solutionId);
    saved.ifPresent(solutionzSink::tryEmitNext);
    return saved;
  }
}
