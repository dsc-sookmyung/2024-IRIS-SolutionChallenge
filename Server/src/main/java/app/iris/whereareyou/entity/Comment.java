package app.iris.whereareyou.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Comment extends TimeStamp {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    private Post post;

    @ManyToOne(optional = false)
    private Member author;

    @OneToOne(optional = false, cascade = CascadeType.REMOVE)
    private Location location;

    @Column
    private LocalDateTime discoveredAt;

    @Column
    private String clothes;

    @Column(columnDefinition = "TEXT")
    private String details;

    @Setter
    @Column
    private Double accuracy;
}
