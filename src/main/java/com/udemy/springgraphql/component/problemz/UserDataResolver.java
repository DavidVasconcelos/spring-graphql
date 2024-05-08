package com.udemy.springgraphql.component.problemz;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsMutation;
import com.netflix.graphql.dgs.DgsQuery;
import com.netflix.graphql.dgs.InputArgument;
import com.udemy.springgraphql.generated.types.User;
import com.udemy.springgraphql.generated.types.UserActivationInput;
import com.udemy.springgraphql.generated.types.UserCreateInput;
import com.udemy.springgraphql.generated.types.UserLoginInput;
import com.udemy.springgraphql.generated.types.UserResponse;
import org.springframework.web.bind.annotation.RequestHeader;

@DgsComponent
public class UserDataResolver {

  @DgsQuery(field = "me")
  public User accountInfo(@RequestHeader(name = "authToken") final String authToken) {
    return null;
  }

  @DgsMutation(field = "userCreate")
  public UserResponse createUser(@InputArgument(name = "user") final UserCreateInput user) {
    return null;
  }

  @DgsMutation
  public UserResponse userLogin(@InputArgument(name = "user") final UserLoginInput user) {
    return null;
  }

  @DgsMutation
  public UserResponse userActivation(@InputArgument(name = "user") final UserActivationInput user) {
    return null;
  }
}
