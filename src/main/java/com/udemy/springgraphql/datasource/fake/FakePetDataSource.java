package com.udemy.springgraphql.datasource.fake;

import com.udemy.springgraphql.generated.types.Cat;
import com.udemy.springgraphql.generated.types.Dog;
import com.udemy.springgraphql.generated.types.Pet;
import com.udemy.springgraphql.generated.types.PetFoodType;
import jakarta.annotation.PostConstruct;
import net.datafaker.Faker;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;

@Configuration
public class FakePetDataSource {

    private final Faker faker;

    public FakePetDataSource(final Faker faker) {
        this.faker = faker;
    }

    public static final List<Pet> PET_LIST = new ArrayList<>();

    @PostConstruct
    private void postConstruct() {
        for (int i = 0; i < 10; i++) {
            final Pet animal = (i % 2 == 0) ? buildDog() : buildCat();
            PET_LIST.add(animal);
        }
    }

    private Dog buildDog() {
        return Dog.newBuilder().name(faker.dog().name())
                .food(PetFoodType.OMNIVORE)
                .breed(faker.dog().breed())
                .size(faker.dog().size())
                .coatLength(faker.dog().coatLength())
                .build();
    }

    private Cat buildCat() {
        return Cat.newBuilder().name(faker.cat().name())
                .food(PetFoodType.CARNIVORE)
                .breed(faker.cat().breed())
                .registry(faker.cat().registry())
                .build();
    }

}