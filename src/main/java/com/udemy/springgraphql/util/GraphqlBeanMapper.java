package com.udemy.springgraphql.util;

import com.udemy.springgraphql.datasource.problemz.entity.Problemz;
import com.udemy.springgraphql.datasource.problemz.entity.Solutionz;
import com.udemy.springgraphql.datasource.problemz.entity.Userz;
import com.udemy.springgraphql.datasource.problemz.entity.UserzToken;
import com.udemy.springgraphql.generated.types.Problem;
import com.udemy.springgraphql.generated.types.ProblemCreateInput;
import com.udemy.springgraphql.generated.types.Solution;
import com.udemy.springgraphql.generated.types.SolutionCategory;
import com.udemy.springgraphql.generated.types.SolutionCreateInput;
import com.udemy.springgraphql.generated.types.User;
import com.udemy.springgraphql.generated.types.UserAuthToken;
import java.time.Instant;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import org.apache.commons.lang3.StringUtils;
import org.ocpsoft.prettytime.PrettyTime;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GraphqlBeanMapper {

  private final PrettyTime PRETTY_TIME = new PrettyTime();
  private final ZoneOffset ZONE_OFFSET = ZoneId.of("America/Sao_Paulo").getRules()
      .getOffset(Instant.now());

  public User mapToGraphql(final Userz original) {
    return User.newBuilder()
        .id(original.getId().toString())
        .username(original.getUsername())
        .email(original.getEmail())
        .avatar(original.getAvatar())
        .displayName(original.getDisplayName())
        .createDateTime(original.getCreationTimestamp().atOffset(ZONE_OFFSET))
        .build();
  }

  public Problem mapToGraphql(final Problemz original) {
    final OffsetDateTime createDateTime = original.getCreationTimestamp().atOffset(ZONE_OFFSET);
    final List<String> tagList = List.of(original.getTags().split(","));
    final List<Solution> solutions = original.getSolutions()
        .stream()
        .filter(Objects::nonNull)
//                .sorted(Comparator.comparing(Solutionz::getCreationTimestamp).reversed())
        .map(this::mapToGraphql)
        .toList();
    return Problem.newBuilder()
        .id(original.getId().toString())
        .createDateTime(createDateTime)
        .prettyCreateDateTime(PRETTY_TIME.format(createDateTime))
        .title(original.getTitle())
        .content(original.getContent())
        .tags(tagList)
        .solutions(solutions)
        .solutionCount(solutions.size())
        .author(mapToGraphql(original.getCreatedBy()))
        .build();
  }

  public Solution mapToGraphql(final Solutionz original) {
    final OffsetDateTime createDateTime = original.getCreationTimestamp().atOffset(ZONE_OFFSET);
    final SolutionCategory category = StringUtils.equalsIgnoreCase(
        original.getCategory(), SolutionCategory.EXPLANATION.toString()) ?
        SolutionCategory.EXPLANATION : SolutionCategory.REFERENCE;
    return Solution.newBuilder()
        .id(original.getId().toString())
        .createDateTime(createDateTime)
        .prettyCreateDateTime(PRETTY_TIME.format(createDateTime))
        .content(original.getContent())
        .category(category)
        .voteAsGoodCount(original.getVoteGoodCount())
        .voteAsBadCount(original.getVoteBadCount())
        .author(mapToGraphql(original.getCreatedBy()))
        .build();
  }

  public UserAuthToken mapToGraphql(final UserzToken original) {
    return UserAuthToken.newBuilder()
        .authToken(original.getAuthToken())
        .expiryTime(original.getExpiryTimestamp().atOffset(ZONE_OFFSET))
        .build();
  }

  public Problemz mapToEntity(final ProblemCreateInput original, final Userz author) {
    return Problemz.builder()
        .id(UUID.randomUUID())
        .title(original.getTitle())
        .content(original.getContent())
        .tags(String.join(",", original.getTags()))
        .createdBy(author)
        .solutions(new ArrayList<>())
        .build();
  }

  public Solutionz mapToEntity(final SolutionCreateInput original, final Userz author,
      final Problemz problemz) {
    return Solutionz.builder()
        .id(UUID.randomUUID())
        .content(original.getContent())
        .category(original.getCategory().name())
        .createdBy(author)
        .problemz(problemz)
        .build();
  }
}
