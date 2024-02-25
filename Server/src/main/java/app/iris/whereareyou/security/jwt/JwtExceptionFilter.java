package app.iris.whereareyou.security.jwt;

import app.iris.whereareyou.exception.CustomException;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import net.minidev.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
@RequiredArgsConstructor
public class JwtExceptionFilter extends OncePerRequestFilter {
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        try {
            filterChain.doFilter(request, response);
        } catch (ExpiredJwtException e) {
            setErrorResponse(response, 499,"Expired Jwt Token");
        } catch (JwtException | CustomException e) {
            setErrorResponse(response, 401, e.getMessage());
        } catch (ServletException | IOException e) {
            setErrorResponse(response, 500, "문의 바랍니다.");
            e.printStackTrace();
        }
    }

    public void setErrorResponse(HttpServletResponse response,int statusCode, String msg) throws IOException {
        response.setStatus(statusCode);
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setCharacterEncoding("UTF-8");

        JSONObject responseJson = new JSONObject();

        responseJson.put("details", msg);
        responseJson.put("message", HttpStatus.valueOf(statusCode));
        responseJson.put("status", String.valueOf(statusCode));

        response.getWriter().print(responseJson);
    }
}
