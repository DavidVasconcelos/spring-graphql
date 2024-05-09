package com.udemy.springgraphql.exception.handler;

import com.netflix.graphql.types.errors.ErrorDetail;
import com.netflix.graphql.types.errors.ErrorType;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
public class ProblemzErrorDetail implements ErrorDetail {

  private ErrorType errorType;
  private String message;

  @Override
  public ErrorType getErrorType() {
    return this.errorType;
  }

  @Override
  public String toString() {
    return this.message;
  }
}
