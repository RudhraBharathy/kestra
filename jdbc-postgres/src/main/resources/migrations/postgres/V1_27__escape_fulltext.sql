CREATE OR REPLACE FUNCTION FULLTEXT_REPLACE(text, text) RETURNS text
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT
RETURN TRIM(BOTH $2 FROM ARRAY_TO_STRING(
   ARRAY(
       SELECT DISTINCT *
       FROM UNNEST(REGEXP_SPLIT_TO_ARRAY(COALESCE($1, ''), '[^a-zA-Z\d]')) AS a
       WHERE a != ''
   ),
   $2
));