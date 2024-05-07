package com.udemy.springgraphql.util;

import com.udemy.springgraphql.datasource.problemz.entity.Problemz;
import com.udemy.springgraphql.datasource.problemz.entity.Solutionz;
import com.udemy.springgraphql.datasource.problemz.entity.Userz;
import com.udemy.springgraphql.datasource.problemz.entity.UserzToken;
import com.udemy.springgraphql.generated.types.Problem;
import com.udemy.springgraphql.generated.types.Solution;
import com.udemy.springgraphql.generated.types.SolutionCategory;
import com.udemy.springgraphql.generated.types.User;
import com.udemy.springgraphql.generated.types.UserAuthToken;
import org.apache.commons.lang3.StringUtils;
import org.ocpsoft.prettytime.PrettyTime;
import org.springframework.context.annotation.Configuration;

import java.time.Instant;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.util.Comparator;
import java.util.List;

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
}
