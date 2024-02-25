package app.iris.whereareyou.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Post extends TimeStamp {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    private Member author;

    @OneToOne(optional = false, cascade = CascadeType.REMOVE)
    private Location location;

    @Column(nullable = false)
    private LocalDateTime disappearedAt;

    @Column(nullable = false)
    private String missingName;

    @Column(nullable = false)
    private Gender missingGender;

    @Column(nullable = false)
    private Integer missingAge;

    @Column
    private Integer missingHeight;

    @Column
    private Integer missingWeight;

    @Column(nullable = false)
    private String clothes;

    @Column(columnDefinition = "TEXT")
    private String details;
}
