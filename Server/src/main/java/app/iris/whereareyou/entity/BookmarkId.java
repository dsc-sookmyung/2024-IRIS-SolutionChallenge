package app.iris.whereareyou.entity;

import jakarta.persistence.Embeddable;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@Embeddable
public class BookmarkId implements Serializable {
    @ManyToOne(optional = false)
    private Post post;

    @ManyToOne(optional = false)
    private Member member;
}
