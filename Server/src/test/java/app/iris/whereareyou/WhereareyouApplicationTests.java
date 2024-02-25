package app.iris.whereareyou;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

@SpringBootTest
class WhereareyouApplicationTests {

	@Test
	void contextLoads() {
	}

	@Transactional
	@Test
	public void EncoderMatchesTest() {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

		String origin = "안녕하세요";
		String encoded = passwordEncoder.encode(origin);
		String encoded2 = passwordEncoder.encode(origin);

		Assertions.assertTrue(passwordEncoder.matches(origin, encoded));
	}
}
