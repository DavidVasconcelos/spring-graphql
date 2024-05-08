package com.udemy.springgraphql.service.command;

import com.udemy.springgraphql.datasource.problemz.entity.UserzToken;

public interface UserzCommandService {

  UserzToken login(String username, String password);

}
