package com.udemy.springgraphql.datasource.problemz.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OrderBy;
import jakarta.persistence.Table;
import java.util.ArrayList;
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
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "problemz")
public class Problemz implements Serializable {

    @Serial
    private static final long serialVersionUID = -2753797659935712817L;

    @Id
    private UUID id;
    @CreationTimestamp
    private LocalDateTime creationTimestamp;
    private String title;
    private String content;
    private String tags;
    @OneToMany(mappedBy = "problemz")
    @OrderBy("creationTimestamp desc")
    @ToString.Exclude
    private List<Solutionz> solutions = new ArrayList<>();
    @ManyToOne
    @JoinColumn(name = "created_by", nullable = false)
    private Userz createdBy;

    @Override
    public boolean equals(final Object o) {
        if (this == o) return true;
        if (!(o instanceof final Problemz problemz)) return false;
        return Objects.equals(id, problemz.id) && Objects.equals(creationTimestamp, problemz.creationTimestamp) && Objects.equals(title, problemz.title) && Objects.equals(content, problemz.content) && Objects.equals(tags, problemz.tags) && Objects.equals(solutions, problemz.solutions) && Objects.equals(createdBy, problemz.createdBy);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, creationTimestamp, title, content, tags, solutions, createdBy);
    }
}
