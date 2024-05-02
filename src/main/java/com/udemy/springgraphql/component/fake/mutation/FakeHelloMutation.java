package com.udemy.springgraphql.component.fake.mutation;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsMutation;
import com.netflix.graphql.dgs.InputArgument;
import com.udemy.springgraphql.datasource.fake.FakeHelloDataSource;
import com.udemy.springgraphql.generated.types.Hello;
import com.udemy.springgraphql.generated.types.HelloInput;

import java.util.List;
import java.util.Objects;

@DgsComponent
public class FakeHelloMutation {

    @DgsMutation // field can be omitted if the method has the same name
    public Integer addHello(@InputArgument(name = "helloInput") HelloInput helloInput) {
        final Hello hello = Hello.newBuilder()
                .text(helloInput.getText())
                .randomNumber(helloInput.getNumber())
                .build();
        FakeHelloDataSource.HELLO_LIST.add(hello);
        return FakeHelloDataSource.HELLO_LIST.size();
    }

    @DgsMutation // field can be omitted if the method has the same name
    public List<Hello> replaceHelloText(@InputArgument(name = "helloInput") HelloInput helloInput) {
        FakeHelloDataSource.HELLO_LIST
                .stream()
                .filter(hello -> Objects.equals(hello.getRandomNumber(), helloInput.getNumber()))
                .forEach(hello -> hello.setText(helloInput.getText()));
        return FakeHelloDataSource.HELLO_LIST;
    }

    @DgsMutation // field can be omitted if the method has the same name
    public Integer deleteHello(@InputArgument(name = "number") Integer number) {
        FakeHelloDataSource.HELLO_LIST
                .removeIf(hello -> Objects.equals(hello.getRandomNumber(), number));
        return FakeHelloDataSource.HELLO_LIST.size();
    }
}
