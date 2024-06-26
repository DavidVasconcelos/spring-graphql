package com.udemy.springgraphql.datasource.problemz.repository;

import com.udemy.springgraphql.datasource.problemz.entity.Problemz;
import java.util.List;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ProblemzRepository extends JpaRepository<Problemz, UUID> {

    List<Problemz> findAllByOrderByCreationTimestampDesc();

    @Query(nativeQuery = true, value = "select id, content, creation_timestamp, tags, title, "
        + "created_by "
        + "from problemz p "
        + "where upper(content) like upper(:keyword) "
        + "or upper(title) like upper(:keyword) "
        + "or upper(tags) like upper(:keyword)")
    List<Problemz> findByKeyword(@Param("keyword") String keyword);
}