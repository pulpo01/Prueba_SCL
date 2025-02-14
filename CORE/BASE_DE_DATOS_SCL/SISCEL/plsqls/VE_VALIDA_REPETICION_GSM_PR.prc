CREATE OR REPLACE PROCEDURE Ve_Valida_Repeticion_Gsm_Pr (
   v_serie   IN       ga_abocel.num_serie%TYPE,
   v_error   IN OUT   CHAR
)
IS
   var1   INTEGER;
   var2   ged_parametros.val_parametro%TYPE;
BEGIN
   SELECT COUNT (1)
     INTO var1
     FROM (SELECT 1
             FROM ga_abocel
            WHERE num_imei = v_serie
              AND cod_situacion NOT IN ('BAA', 'BAP')
              AND cod_uso <> 3
           UNION ALL
           SELECT 1
             FROM ga_aboamist
            WHERE num_imei = v_serie
              AND cod_situacion NOT IN ('BAA', 'BAP'));
   SELECT val_parametro
     INTO var2
     FROM ged_parametros
    WHERE nom_parametro = 'NUM_REPETICION_IMEI'
      AND cod_modulo = 'GA'
      AND cod_producto = 1;

   IF var1 > TO_NUMBER (var2)
   THEN
      v_error := '2';
   ELSE
      v_error := '0';
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      v_error := '4';
END;
/
SHOW ERRORS
