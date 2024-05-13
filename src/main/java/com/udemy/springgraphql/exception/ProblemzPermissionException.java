package com.udemy.springgraphql.exception;

public class ProblemzPermissionException extends RuntimeException {

  public ProblemzPermissionException() {
    super("Invalid permission");
  }
}
