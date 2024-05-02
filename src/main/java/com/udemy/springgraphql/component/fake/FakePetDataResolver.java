package com.udemy.springgraphql.component.fake;

import com.netflix.graphql.dgs.DgsComponent;
import com.netflix.graphql.dgs.DgsData;
import com.netflix.graphql.dgs.DgsQuery;
import com.netflix.graphql.dgs.InputArgument;
import com.udemy.springgraphql.datasource.fake.FakePetDataSource;
import com.udemy.springgraphql.generated.DgsConstants;
import com.udemy.springgraphql.generated.types.Cat;
import com.udemy.springgraphql.generated.types.Dog;
import com.udemy.springgraphql.generated.types.Pet;
import com.udemy.springgraphql.generated.types.PetFilter;
import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@DgsComponent
public class FakePetDataResolver {

    @SuppressWarnings("DgsInputArgumentValidationInspector")
    @DgsQuery(field = "pets")
    public List<Pet> getPets(@InputArgument(name = "petFilter") Optional<PetFilter> filter) {
        return filter.map(petFilter ->
                        FakePetDataSource.PET_LIST
                                .stream()
                                .filter(pet -> this.matchFilter(petFilter, pet))
                                .toList())
                .orElse(FakePetDataSource.PET_LIST);

    }

    private boolean matchFilter(PetFilter petFilter, Pet pet) {
        if (StringUtils.isBlank(petFilter.getPetType())) {
            return true;
        }
        if (petFilter.getPetType().equalsIgnoreCase(Dog.class.getSimpleName())) {
            return pet instanceof Dog;
        } else if (petFilter.getPetType().equalsIgnoreCase(Cat.class.getSimpleName())) {
            return pet instanceof Cat;
        } else {
            return false;
        }
    }

}