package com.udemy.springgraphql.service.command.impl;

import com.udemy.springgraphql.datasource.problemz.entity.Userz;
import com.udemy.springgraphql.datasource.problemz.entity.UserzToken;
import com.udemy.springgraphql.datasource.problemz.repository.UserzRepository;
import com.udemy.springgraphql.datasource.problemz.repository.UserzTokenRepository;
import com.udemy.springgraphql.exception.ProblemzAuthenticationException;
import com.udemy.springgraphql.service.command.UserzCommandService;
import com.udemy.springgraphql.util.HashUtil;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserzCommandServiceImpl implements UserzCommandService {

  private final UserzRepository userzRepository;
  private final HashUtil hashUtil;
  private final UserzTokenRepository userzTokenRepository;

  public UserzCommandServiceImpl(final UserzRepository userzRepository, final HashUtil hashUtil,
      final UserzTokenRepository userzTokenRepository) {
    this.userzRepository = userzRepository;
    this.hashUtil = hashUtil;
    this.userzTokenRepository = userzTokenRepository;
  }

  @Override
  @Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = {Exception.class})
  public UserzToken login(final String username, final String password) {
    final Optional<Userz> optionalUserz = userzRepository.findByUsernameIgnoreCase(username);
    if (optionalUserz.isEmpty() || !hashUtil.isBcryptMatch(password,
        optionalUserz.get().getHashedPassword())) {
      throw new ProblemzAuthenticationException();
    }
    final String randomAuthToken = RandomStringUtils.randomAlphanumeric(40);
    return refreshToken(optionalUserz.get().getId(), randomAuthToken);
  }

  private UserzToken refreshToken(final UUID userId, final String authToken) {
    final LocalDateTime now = LocalDateTime.now();
    final UserzToken userzToken = UserzToken.builder()
        .userId(userId)
        .authToken(authToken)
        .creationTimestamp(now)
        .expiryTimestamp(now.plusHours(2))
        .build();
    return userzTokenRepository.save(userzToken);
  }
}
