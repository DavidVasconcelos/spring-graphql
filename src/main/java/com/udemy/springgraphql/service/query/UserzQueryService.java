package com.udemy.springgraphql.service.query;

import com.udemy.springgraphql.datasource.problemz.entity.Userz;
import java.util.Optional;

public interface UserzQueryService {

  Optional<Userz> findUserzByAuthToken(String authToken);

}
