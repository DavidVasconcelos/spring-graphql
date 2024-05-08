package com.udemy.springgraphql.service.query.impl;

import com.udemy.springgraphql.datasource.problemz.entity.Userz;
import com.udemy.springgraphql.datasource.problemz.repository.UserzRepository;
import com.udemy.springgraphql.service.query.UserzQueryService;
import java.util.Optional;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserzQueryServiceImpl implements UserzQueryService {

  final UserzRepository userzRepository;

  public UserzQueryServiceImpl(final UserzRepository userzRepository) {
    this.userzRepository = userzRepository;
  }

  @Override
  @Transactional(readOnly = true)
  public Optional<Userz> findUserzByAuthToken(final String authToken) {
    return userzRepository.findUserByToken(authToken);
  }
}
