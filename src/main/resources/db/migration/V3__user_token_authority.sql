-- Run this on database problemz

SET search_path TO problemz;

ALTER TABLE userz_token ADD COLUMN authority varchar(20);
