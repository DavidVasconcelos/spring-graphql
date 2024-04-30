package com.udemy.springgraphql.component.fake;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsQuery;
import com.udemy.springgraphql.datasource.fake.FakeHelloDataSource;
import com.udemy.springgraphql.generated.types.Hello;

import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

@DgsComponent
public class FakeHelloDataResolver {

    @DgsQuery
    public List<Hello> allHellos() {
        return FakeHelloDataSource.HELLO_LIST;
    }

    @DgsQuery
    public Hello oneHello() {
        final List<Hello> helloList = FakeHelloDataSource.HELLO_LIST;
        return helloList.get(ThreadLocalRandom.current().nextInt(helloList.size()));
    }
}
