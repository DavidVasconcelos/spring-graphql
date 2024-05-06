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
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.UUID;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "userz_token")
public class UserzToken implements Serializable {

    @Serial
    private static final long serialVersionUID = 4916611121460475685L;
    
    @Id
    private UUID userId;
    private String authToken;
    @CreationTimestamp
    private LocalDateTime creationTimestamp;
    private LocalDateTime expiryTimestamp;

    @Override
    public boolean equals(final Object o) {
        if (this == o) return true;
        if (!(o instanceof final UserzToken that)) return false;
        return Objects.equals(userId, that.userId) && Objects.equals(authToken, that.authToken) && Objects.equals(creationTimestamp, that.creationTimestamp) && Objects.equals(expiryTimestamp, that.expiryTimestamp);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, authToken, creationTimestamp, expiryTimestamp);
    }
}