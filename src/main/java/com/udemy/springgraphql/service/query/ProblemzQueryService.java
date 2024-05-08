package com.udemy.springgraphql.service.query;

import com.udemy.springgraphql.datasource.problemz.entity.Problemz;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ProblemzQueryService {

  List<Problemz> problemzLatestList();

  Optional<Problemz> problemzDetail(UUID problemzId);

  List<Problemz> problemzByKeyword(String keyword);
}
