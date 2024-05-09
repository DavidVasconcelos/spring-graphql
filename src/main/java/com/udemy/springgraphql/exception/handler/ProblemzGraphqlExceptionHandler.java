package com.udemy.springgraphql.exception.handler;

import com.netflix.graphql.dgs.exceptions.DefaultDataFetcherExceptionHandler;
import com.netflix.graphql.dgs.exceptions.DgsEntityNotFoundException;
import com.netflix.graphql.types.errors.ErrorType;
import com.netflix.graphql.types.errors.TypedGraphQLError;
import com.udemy.springgraphql.exception.ProblemzAuthenticationException;
import graphql.execution.DataFetcherExceptionHandler;
import graphql.execution.DataFetcherExceptionHandlerParameters;
import graphql.execution.DataFetcherExceptionHandlerResult;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import org.springframework.stereotype.Component;

@Component
public class ProblemzGraphqlExceptionHandler implements DataFetcherExceptionHandler {

  private final Map<String, ProblemzErrorDetail> errorProviderMap =
      Collections.synchronizedMap(new HashMap<>());

  public ProblemzGraphqlExceptionHandler() {
    errorProviderMap.put("ProblemzAuthenticationException",
        new ProblemzErrorDetail(ErrorType.UNAUTHENTICATED, "User validation failed. Check that "
            + "username & password combination match (both are case sensitive)."));
    errorProviderMap.put("DgsEntityNotFoundException", new ProblemzErrorDetail(ErrorType.NOT_FOUND,
        "Entity request failed. Check the given parameters"));
  }

  @Override
  public CompletableFuture<DataFetcherExceptionHandlerResult> handleException(
      final DataFetcherExceptionHandlerParameters handlerParameters) {
    final Throwable exception = handlerParameters.getException();
    final ProblemzErrorDetail problemzErrorDetail = errorProviderMap.getOrDefault(
        exception.getClass().getSimpleName(), new ProblemzErrorDetail());
    if (exception instanceof ProblemzAuthenticationException) {
      return handleException(handlerParameters, exception, problemzErrorDetail);
    } else if (exception instanceof DgsEntityNotFoundException) {
      return handleException(handlerParameters, exception, problemzErrorDetail);
    } else {
      return new DefaultDataFetcherExceptionHandler().handleException(handlerParameters);
    }
  }

  private CompletableFuture<DataFetcherExceptionHandlerResult> handleException(
      final DataFetcherExceptionHandlerParameters handlerParameters,
      final Throwable exception, final ProblemzErrorDetail problemzErrorDetail) {
    final TypedGraphQLError graphqlError = TypedGraphQLError.newBuilder()
        .message(exception.getMessage())
        .path(handlerParameters.getPath())
        .errorDetail(problemzErrorDetail)
        .build();
    return handleError(graphqlError);
  }

  private CompletableFuture<DataFetcherExceptionHandlerResult> handleError(
      final TypedGraphQLError graphqlError) {
    final DataFetcherExceptionHandlerResult result = DataFetcherExceptionHandlerResult.newResult()
        .error(graphqlError).build();
    return CompletableFuture.completedFuture(result);
  }
}
