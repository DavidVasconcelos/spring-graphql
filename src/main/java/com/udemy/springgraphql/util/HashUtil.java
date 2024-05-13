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

  public String hashBcryptPassword(final String originalPassword) {
    final String BCRYPT_SALT = "dontDoThisOnProd";
    return OpenBSDBCrypt.generate(originalPassword.getBytes(StandardCharsets.UTF_8),
        BCRYPT_SALT.getBytes(StandardCharsets.UTF_8), 5);
  }
}
