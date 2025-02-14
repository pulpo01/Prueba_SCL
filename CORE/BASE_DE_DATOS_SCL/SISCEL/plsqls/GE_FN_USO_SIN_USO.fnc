CREATE OR REPLACE FUNCTION ge_fn_uso_sin_uso RETURN number
IS
     uso_sin_uso NUMBER;
BEGIN
            SELECT  val_parametro INTO uso_sin_uso
            FROM ged_parametros a
            WHERE nom_parametro = 'USO_SIN_USO';

            RETURN uso_sin_uso;
exception
   WHEN no_data_found THEN
      return null;
   when OTHERS then
      return 0;

END;
/
SHOW ERRORS
