package com.udemy.springgraphql.component.problemz;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsMutation;
import com.netflix.graphql.dgs.DgsQuery;
import com.netflix.graphql.dgs.InputArgument;
import com.netflix.graphql.dgs.exceptions.DgsEntityNotFoundException;
import com.udemy.springgraphql.datasource.problemz.entity.UserzToken;
import com.udemy.springgraphql.generated.types.User;
import com.udemy.springgraphql.generated.types.UserActivationInput;
import com.udemy.springgraphql.generated.types.UserAuthToken;
import com.udemy.springgraphql.generated.types.UserCreateInput;
import com.udemy.springgraphql.generated.types.UserLoginInput;
import com.udemy.springgraphql.generated.types.UserResponse;
import com.udemy.springgraphql.service.command.UserzCommandService;
import com.udemy.springgraphql.service.query.UserzQueryService;
import com.udemy.springgraphql.util.GraphqlBeanMapper;
import org.springframework.web.bind.annotation.RequestHeader;

@DgsComponent
public class UserDataResolver {

  private final UserzQueryService userzQueryService;
  private final UserzCommandService userzCommandService;
  private final GraphqlBeanMapper graphqlBeanMapper;

  public UserDataResolver(final UserzQueryService userzQueryService,
      final UserzCommandService userzCommandService, final GraphqlBeanMapper graphqlBeanMapper) {
    this.userzQueryService = userzQueryService;
    this.userzCommandService = userzCommandService;
    this.graphqlBeanMapper = graphqlBeanMapper;
  }

  @DgsQuery(field = "me")
  public User accountInfo(@RequestHeader(name = "authToken") final String authToken) {
    return userzQueryService.findUserzByAuthToken(authToken)
        .map(graphqlBeanMapper::mapToGraphql)
        .orElseThrow(DgsEntityNotFoundException::new);
  }

  @DgsMutation(field = "userCreate")
  public UserResponse createUser(
      @InputArgument(name = "user") final UserCreateInput userCreateInput) {
    return null;
  }

  @DgsMutation
  public UserResponse userLogin(@InputArgument(name = "user") final UserLoginInput userLoginInput) {
    final UserzToken userzToken = userzCommandService.login(userLoginInput.getUsername(),
        userLoginInput.getPassword());
    final UserAuthToken userAuthToken = graphqlBeanMapper.mapToGraphql(userzToken);
    final User user = accountInfo(userAuthToken.getAuthToken());
    return UserResponse.newBuilder()
        .authToken(userAuthToken)
        .user(user)
        .build();
  }

  @DgsMutation
  public UserResponse userActivation(@InputArgument(name = "user") final UserActivationInput user) {
    return null;
  }
}
