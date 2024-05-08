package com.udemy.springgraphql.service.query.impl;

import com.udemy.springgraphql.datasource.problemz.entity.Solutionz;
import com.udemy.springgraphql.datasource.problemz.repository.SolutionzRepository;
import com.udemy.springgraphql.service.query.SolutionzQueryService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SolutionzQueryServiceImpl implements SolutionzQueryService {

  private final SolutionzRepository solutionzRepository;

  public SolutionzQueryServiceImpl(final SolutionzRepository solutionzRepository) {
    this.solutionzRepository = solutionzRepository;
  }

  @Override
  @Transactional(readOnly = true)
  public List<Solutionz> solutionzByKeyword(final String keyword) {
    return solutionzRepository.findByKeyword("%" + keyword + "%");
  }
}
