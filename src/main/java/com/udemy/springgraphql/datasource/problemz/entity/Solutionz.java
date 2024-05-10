package com.udemy.springgraphql.datasource.problemz.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
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
@Builder
@Entity
@Table(name = "solutionz")
public class Solutionz implements Serializable {

    @Serial
    private static final long serialVersionUID = -9199435178125973572L;

    @Id
    private UUID id;
    @CreationTimestamp
    private LocalDateTime creationTimestamp;
    private String content;
    private String category;
    private int voteGoodCount;
    private int voteBadCount;
    @ManyToOne
    @JoinColumn(name = "created_by", nullable = false)
    private Userz createdBy;
    @ManyToOne
    @JoinColumn(name = "problemz_id", nullable = false)
    private Problemz problemz;

    @Override
    public boolean equals(final Object o) {
        if (this == o) return true;
        if (!(o instanceof final Solutionz solutionz)) return false;
        return voteGoodCount == solutionz.voteGoodCount && voteBadCount == solutionz.voteBadCount && Objects.equals(id, solutionz.id) && Objects.equals(creationTimestamp, solutionz.creationTimestamp) && Objects.equals(content, solutionz.content) && Objects.equals(category, solutionz.category) && Objects.equals(createdBy, solutionz.createdBy) && Objects.equals(problemz, solutionz.problemz);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, creationTimestamp, content, category, voteGoodCount, voteBadCount, createdBy, problemz);
    }
}
