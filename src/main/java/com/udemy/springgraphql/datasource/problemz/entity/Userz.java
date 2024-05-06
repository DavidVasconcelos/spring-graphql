package com.udemy.springgraphql.datasource.problemz.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.CreationTimestamp;

import java.io.Serial;
import java.io.Serializable;
import java.net.URL;
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.UUID;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "userz")
public class Userz implements Serializable {

    @Serial
    private static final long serialVersionUID = 4691117147063595459L;

    @Id
    private UUID id;
    private String username;
    private String email;
    private String hashedPassword;
    private URL avatar;
    @CreationTimestamp
    private LocalDateTime creationTimestamp;
    private String displayName;
    private boolean active;
    private String userRole;

    @Override
    public boolean equals(final Object o) {
        if (this == o) return true;
        if (!(o instanceof final Userz userz)) return false;
        return active == userz.active && Objects.equals(id, userz.id) && Objects.equals(username, userz.username) && Objects.equals(email, userz.email) && Objects.equals(hashedPassword, userz.hashedPassword) && Objects.equals(avatar, userz.avatar) && Objects.equals(creationTimestamp, userz.creationTimestamp) && Objects.equals(displayName, userz.displayName) && Objects.equals(userRole, userz.userRole);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, username, email, hashedPassword, avatar, creationTimestamp, displayName, active, userRole);
    }
}
