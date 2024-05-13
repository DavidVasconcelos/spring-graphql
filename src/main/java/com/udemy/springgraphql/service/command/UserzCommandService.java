package com.udemy.springgraphql.service.command;

import com.udemy.springgraphql.datasource.problemz.entity.Userz;
import com.udemy.springgraphql.datasource.problemz.entity.UserzToken;
import java.util.Optional;

public interface UserzCommandService {

  UserzToken login(String username, String password);

  Userz createUserz(Userz userz);

  Optional<Userz> activateUser(String username, boolean isActive);

}
