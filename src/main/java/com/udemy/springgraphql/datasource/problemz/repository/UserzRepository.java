package com.udemy.springgraphql.datasource.problemz.repository;

import com.udemy.springgraphql.datasource.problemz.entity.Userz;
import java.util.Optional;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.UUID;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface UserzRepository extends CrudRepository<Userz, UUID> {

  Optional<Userz> findByUsernameIgnoreCase(String username);

  @Query(nativeQuery = true, value = "select u.id, u.active, u.avatar, u.creation_timestamp, "
      + "u.display_name, u.email, u.hashed_password, u.username, u.user_role "
      + "from userz u inner join userz_token ut "
      + "on u.id = ut.user_id "
      + "where ut.auth_token = :authToken "
      + " and ut.expiry_timestamp > current_timestamp")
  Optional<Userz> findUserByToken(@Param("authToken") String authToken);

  @Transactional
  @Modifying
  @Query(nativeQuery = true,
      value = "update userz set active = :isActive where upper(username) = upper(:username)")
  void activateUser(@Param("username") String username, @Param("isActive") boolean isActive);
}