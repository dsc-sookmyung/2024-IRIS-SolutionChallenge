package app.iris.whereareyou.entity;

import jakarta.persistence.*;
import lombok.*;

@AllArgsConstructor
@Builder
@NoArgsConstructor
@Entity
public class Image {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Getter
    @Column(nullable = false)
    private String url;

    @Getter
    @Column(nullable = false)
    private String name;

    @ManyToOne
    private Comment comment;

    @ManyToOne
    private Post post;

    @Setter
    @Column(nullable = false)
    private boolean isGenImage;

    @Setter
    @Getter
    @Column(nullable = false)
    private boolean isRepresent;
}
