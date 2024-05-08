package com.udemy.springgraphql.service.query;

import com.udemy.springgraphql.datasource.problemz.entity.Solutionz;

import java.util.List;

public interface SolutionzQueryService {

  List<Solutionz> solutionzByKeyword(String keyword);
}
