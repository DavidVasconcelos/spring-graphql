package com.udemy.springgraphql.component.fake.resolver;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsQuery;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;

@DgsComponent
public class FakeAdditionalOnRequestDataResolver {

    @DgsQuery
    public String additionalOnRequest( @RequestHeader(name = "optionalHeader", required = false) String optionalHeader,
                                       @RequestHeader(name = "mandatoryHeader", required = true) String mandatoryHeader,
                                       @RequestParam(name = "optionalParam", required = false) String optionalParam,
                                       @RequestParam(name = "mandatoryParam", required = true) String mandatoryParam) {

        return "Optional header : " + optionalHeader +
                ", " +
                "Mandatory header : " + mandatoryHeader +
                ", " +
                "Optional param : " + optionalParam +
                ", " +
                "Mandatory param : " + mandatoryParam;
    }
}
