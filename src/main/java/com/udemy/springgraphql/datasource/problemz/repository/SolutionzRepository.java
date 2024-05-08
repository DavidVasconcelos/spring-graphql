package com.udemy.springgraphql.datasource.problemz.repository;

import com.udemy.springgraphql.datasource.problemz.entity.Solutionz;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface SolutionzRepository extends CrudRepository<Solutionz, UUID> {

    @Query(nativeQuery = true, value = "select id, category, content, creation_timestamp, "
        + "vote_bad_count, vote_good_count, created_by, problemz_id "
        + "from solutionz where upper(content) like upper(:keyword)")
    List<Solutionz> findByKeyword(@Param("keyword") String keyword);
}