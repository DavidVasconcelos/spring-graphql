package com.udemy.springgraphql.exception;

public class ProblemzAuthenticationException extends RuntimeException {

  public ProblemzAuthenticationException() {
    super("Invalid credential");
  }
}
