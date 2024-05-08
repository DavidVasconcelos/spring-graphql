package com.udemy.springgraphql.service.query.impl;

import com.udemy.springgraphql.datasource.problemz.entity.Problemz;
import com.udemy.springgraphql.datasource.problemz.entity.Solutionz;
import com.udemy.springgraphql.datasource.problemz.repository.ProblemzRepository;
import com.udemy.springgraphql.service.query.ProblemzQueryService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class ProblemzQueryServiceImpl implements ProblemzQueryService {

  private final ProblemzRepository problemzRepository;

  public ProblemzQueryServiceImpl(final ProblemzRepository problemzRepository) {
    this.problemzRepository = problemzRepository;
  }

  @Override
  @Transactional(readOnly = true)
  public List<Problemz> problemzLatestList() {
    return problemzRepository.findAllByOrderByCreationTimestampDesc();
//        problemzList.forEach(problemz -> problemz.getSolutions()
//                .sort(Comparator.comparing(Solutionz::getCreationTimestamp)
//                        .reversed())
//        );
//        return problemzList;
  }

  @Override
  @Transactional(readOnly = true)
  public Optional<Problemz> problemzDetail(final UUID problemzId) {
    return problemzRepository.findById(problemzId);
  }

  @Override
  @Transactional(readOnly = true)
  public List<Problemz> problemzByKeyword(final String keyword) {
    return problemzRepository.findByKeyword("%" + keyword + "%");
  }
}
