CREATE OR REPLACE PROCEDURE        VE_P_GETCATART(
  vp_articulo IN NUMBER ,
  vp_categoria IN OUT VARCHAR2 )
IS
BEGIN
   SELECT  COD_CATEGORIA
     INTO  vp_categoria
     FROM  VE_CATARTICULOS
    WHERE  COD_ARTICULO = vp_articulo
      AND  FEC_FINEFECTIVIDAD IS NULL;
   dbms_output.put_line('Categoria del articulo ' || vp_articulo || ' es '
                        || vp_categoria);
EXCEPTION
   WHEN OTHERS THEN
        NULL;
END;
/
SHOW ERRORS
