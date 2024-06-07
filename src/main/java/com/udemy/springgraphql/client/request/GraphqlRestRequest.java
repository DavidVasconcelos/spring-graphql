package com.udemy.springgraphql.client.request;

import java.util.Map;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GraphqlRestRequest {

  private String query;
  private Map<String, ?> variables;
}
