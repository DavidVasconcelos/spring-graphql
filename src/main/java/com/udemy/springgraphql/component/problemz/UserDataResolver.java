package com.udemy.springgraphql.component.problemz;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsMutation;
import com.netflix.graphql.dgs.DgsQuery;
import com.netflix.graphql.dgs.InputArgument;
import com.netflix.graphql.dgs.exceptions.DgsEntityNotFoundException;
import com.udemy.springgraphql.datasource.problemz.entity.Userz;
import com.udemy.springgraphql.datasource.problemz.entity.UserzToken;
import com.udemy.springgraphql.generated.types.User;
import com.udemy.springgraphql.generated.types.UserActivationInput;
import com.udemy.springgraphql.generated.types.UserActivationResponse;
import com.udemy.springgraphql.generated.types.UserAuthToken;
import com.udemy.springgraphql.generated.types.UserCreateInput;
import com.udemy.springgraphql.generated.types.UserLoginInput;
import com.udemy.springgraphql.generated.types.UserResponse;
import com.udemy.springgraphql.service.command.UserzCommandService;
import com.udemy.springgraphql.service.query.UserzQueryService;
import com.udemy.springgraphql.util.GraphqlBeanMapper;
import org.springframework.security.access.prepost.PreAuthorize;
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
  @PreAuthorize("hasRole('ROLE_MEMBER') or hasRole('ROLE_ADMIN')")
  public User accountInfo(@RequestHeader(name = "authToken") final String authToken) {
    return userzQueryService.findUserzByAuthToken(authToken)
        .map(graphqlBeanMapper::mapToGraphql)
        .orElseThrow(DgsEntityNotFoundException::new);
  }

  @DgsMutation(field = "userCreate")
  @PreAuthorize("hasRole('ROLE_ADMIN')")
  public UserResponse createUser(
      @InputArgument(name = "user") final UserCreateInput userCreateInput) {
    final Userz userz = graphqlBeanMapper.mapToEntity(userCreateInput);
    final Userz savedUserz = userzCommandService.createUserz(userz);
    return UserResponse.newBuilder()
        .user(graphqlBeanMapper.mapToGraphql(savedUserz))
        .build();
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
  @PreAuthorize("hasRole('ROLE_ADMIN')")
  public UserActivationResponse userActivation(
      @InputArgument(name = "user") final UserActivationInput userActivationInput) {
    final Userz userz = userzCommandService.activateUser(
            userActivationInput.getUsername(), userActivationInput.getActive())
        .orElseThrow(DgsEntityNotFoundException::new);
    return UserActivationResponse.newBuilder()
        .isActive(userz.isActive())
        .build();
  }
}
