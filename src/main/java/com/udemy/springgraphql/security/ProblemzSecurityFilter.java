package com.udemy.springgraphql.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

@Slf4j
public class ProblemzSecurityFilter extends OncePerRequestFilter {

  @Override
  protected void doFilterInternal(final HttpServletRequest request,
      final HttpServletResponse response, final FilterChain filterChain)
      throws ServletException, IOException {
    try {
      final String authToken = request.getHeader("authToken");
      final String authority = request.getHeader("authority");
      final UsernamePasswordAuthenticationToken authenticationToken =
          new UsernamePasswordAuthenticationToken(null, authToken,
              AuthorityUtils.commaSeparatedStringToAuthorityList(authority));
      SecurityContextHolder.getContext().setAuthentication(authenticationToken);
      filterChain.doFilter(request, response);
    } catch (RuntimeException ex) {
      logger.error(ex.getMessage());
      throw new BadCredentialsException("Invalid Token received!");
    }
  }
}