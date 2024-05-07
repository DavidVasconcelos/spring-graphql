-- Run this on database problemz

SET search_path TO problemz;

ALTER TABLE userz ADD COLUMN user_role varchar(20);

UPDATE userz SET user_role = 'ROLE_MEMBER';

UPDATE userz
SET user_role = 'ROLE_ADMIN'
WHERE username = 'jbrameg';
