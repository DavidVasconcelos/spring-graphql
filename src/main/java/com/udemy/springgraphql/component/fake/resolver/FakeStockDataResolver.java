package com.udemy.springgraphql.component.fake.resolver;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsSubscription;
import com.udemy.springgraphql.datasource.fake.FakeStockDataSource;
import com.udemy.springgraphql.generated.types.Stock;
import org.reactivestreams.Publisher;
import reactor.core.publisher.Flux;

import java.time.Duration;

@DgsComponent
public class FakeStockDataResolver {

    private final FakeStockDataSource fakeStockDataSource;

    public FakeStockDataResolver(final FakeStockDataSource fakeStockDataSource) {
        this.fakeStockDataSource = fakeStockDataSource;
    }

    @DgsSubscription
    public Publisher<Stock> randomStock() {
        return Flux.interval(Duration.ofSeconds(3)).map(t -> fakeStockDataSource.randomStock());
    }
}
