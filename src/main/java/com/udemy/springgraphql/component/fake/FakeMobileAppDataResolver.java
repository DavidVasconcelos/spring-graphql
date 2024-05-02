package com.udemy.springgraphql.component.fake;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsData;
import com.netflix.graphql.dgs.DgsQuery;
import com.netflix.graphql.dgs.InputArgument;
import com.udemy.springgraphql.datasource.fake.FakeMobileAppDataSource;
import com.udemy.springgraphql.generated.DgsConstants;
import com.udemy.springgraphql.generated.types.MobileApp;
import com.udemy.springgraphql.generated.types.MobileAppFilter;
import org.apache.commons.lang3.StringUtils;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@DgsComponent
public class FakeMobileAppDataResolver {

    @SuppressWarnings("DgsInputArgumentValidationInspector")
    @DgsQuery(field = "mobileApps")
    public List<MobileApp> getMobileApps(@InputArgument(name = "mobileAppFilter") final Optional<MobileAppFilter> filter) {
        return filter.map(mobileAppFilter -> FakeMobileAppDataSource.MOBILE_APP_LIST
                        .stream()
                        .filter(mobileApp -> this.matchFilter(mobileAppFilter, mobileApp))
                        .collect(Collectors.toList()))
                .orElse(FakeMobileAppDataSource.MOBILE_APP_LIST);

    }

    @DgsQuery(field = "oneApp")
    public MobileApp getOneApp(@InputArgument(name = "appId") final String appId) {
        return FakeMobileAppDataSource.MOBILE_APP_LIST
                .stream()
                .filter(mobileApp -> mobileApp.getAppId().equals(appId))
                .findFirst().orElse(null);

    }

    private boolean matchFilter(final MobileAppFilter mobileAppFilter, final MobileApp mobileApp) {
        final boolean isAppMatch = StringUtils.containsIgnoreCase(mobileApp.getName(),
                StringUtils.defaultIfBlank(mobileAppFilter.getName(), StringUtils.EMPTY))
                && StringUtils.containsIgnoreCase(mobileApp.getVersion(),
                StringUtils.defaultIfBlank(mobileAppFilter.getVersion(), StringUtils.EMPTY))
                && mobileApp.getReleaseDate().isAfter(
                Optional.ofNullable(mobileAppFilter.getReleasedAfter()).orElse(LocalDate.MIN))
                && mobileApp.getDownloaded() >= Optional.ofNullable(mobileAppFilter.getMinimumDownload()).orElse(0);

        if (!isAppMatch) {
            return false;
        }

        if (StringUtils.isNotBlank(mobileAppFilter.getPlatform())
                && !mobileApp.getPlatform().contains(mobileAppFilter.getPlatform().toLowerCase())) {
            return false;
        }

        return mobileAppFilter.getAuthor() == null
                || StringUtils.containsIgnoreCase(mobileApp.getAuthor().getName(),
                StringUtils.defaultIfBlank(mobileAppFilter.getAuthor().getName(), StringUtils.EMPTY));
    }

}