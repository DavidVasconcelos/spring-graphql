package com.udemy.springgraphql.service.command;

import com.udemy.springgraphql.datasource.problemz.entity.Problemz;

public interface ProblemzCommandService {

  Problemz createProblemz(Problemz problemz);

}
