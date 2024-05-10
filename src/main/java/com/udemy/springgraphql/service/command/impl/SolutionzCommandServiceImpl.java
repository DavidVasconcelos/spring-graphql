package com.udemy.springgraphql.service.command.impl;

import com.udemy.springgraphql.datasource.problemz.entity.Solutionz;
import com.udemy.springgraphql.datasource.problemz.repository.SolutionzRepository;
import com.udemy.springgraphql.service.command.SolutionzCommandService;
import java.util.Optional;
import java.util.UUID;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SolutionzCommandServiceImpl implements SolutionzCommandService {

  private final SolutionzRepository solutionzRepository;

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
    return solutionzRepository.findById(solutionId);
  }

  @Override
  public Optional<Solutionz> voteGood(final UUID solutionId) {
    solutionzRepository.addVoteGoodCount(solutionId);
    return solutionzRepository.findById(solutionId);
  }
}
