package com.udemy.springgraphql.datasource.fake;

import com.udemy.springgraphql.generated.types.Stock;
import net.datafaker.Faker;
import org.springframework.context.annotation.Configuration;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.OffsetDateTime;
import java.util.Random;

@Configuration
public class FakeStockDataSource {

    private final Faker faker;

    public FakeStockDataSource(final Faker faker) {
        this.faker = faker;
    }

    public Stock randomStock() {
        final Random random = new Random();
        final double randomValue = 1 + random.nextDouble() * 99;
        final BigDecimal randomBigDecimal = BigDecimal.valueOf(randomValue).setScale(2, RoundingMode.HALF_UP);
        return Stock.newBuilder().lastTradeDateTime(OffsetDateTime.now())
                .price(randomBigDecimal)
                .symbol(faker.stock().nyseSymbol())
                .build();
    }

}