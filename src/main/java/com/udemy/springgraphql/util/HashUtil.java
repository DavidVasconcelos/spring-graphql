package com.udemy.springgraphql.util;

import java.nio.charset.StandardCharsets;
import org.bouncycastle.crypto.generators.OpenBSDBCrypt;
import org.springframework.stereotype.Component;

@Component
public class HashUtil {

  public Boolean isBcryptMatch(final String originalPassword, final String hashedPassword) {
    return OpenBSDBCrypt.checkPassword(hashedPassword,
        originalPassword.getBytes(StandardCharsets.UTF_8));
  }

}
