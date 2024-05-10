package com.udemy.springgraphql.service.command.impl;

import com.udemy.springgraphql.datasource.problemz.entity.Problemz;
import com.udemy.springgraphql.datasource.problemz.repository.ProblemzRepository;
import com.udemy.springgraphql.service.command.ProblemzCommandService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProblemzCommandServiceImpl implements ProblemzCommandService {

  private final ProblemzRepository problemzRepository;

  public ProblemzCommandServiceImpl(final ProblemzRepository problemzRepository) {
    this.problemzRepository = problemzRepository;
  }

  @Override
  @Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = {Exception.class})
  public Problemz createProblemz(final Problemz problemz) {
    return problemzRepository.save(problemz);
  }
}
