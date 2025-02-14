CREATE OR REPLACE FUNCTION AL_DATOS_GSM_FN(p_columna varchar2, p_tip_terminal al_tipos_terminales.TIP_TERMINAL%TYPE, p_num_serie al_series.num_serie%TYPE) RETURN VARCHAR is

v_cod_simgsm      varchar(1);
v_cod_tergsm      varchar(1);


BEGIN

   SELECT a.val_parametro,b.val_parametro
   INTO v_cod_simgsm, v_cod_tergsm
   FROM ged_parametros a, ged_parametros b
   WHERE a.cod_modulo='AL' AND
         a.cod_producto=1  AND
                 a.nom_parametro='COD_SIMCARD_GSM' AND
         b.cod_modulo='AL' AND
         b.cod_producto=1  AND
                 b.nom_parametro='COD_TERMINAL_GSM';

   IF (p_tip_terminal <> v_cod_simgsm and p_tip_terminal <> v_cod_tergsm) THEN
      RETURN null;
   ELSE
      IF (p_tip_terminal = v_cod_tergsm) THEN
            IF p_columna = 'IMEI' THEN
                  RETURN p_num_serie;
                ELSE
                  RETURN null;
                END IF;
          ELSE
            IF p_columna = 'ICC' THEN
          RETURN p_num_serie;
                ELSE
                  IF p_columna ='IMSI' THEN
                     RETURN frecupersimcard_fn(p_num_serie,p_columna);
                  ELSE
                      RETURN null;
                  END IF;
                END IF;
      END IF;
        END IF;

   exception
      when others then
            RAISE_APPLICATION_ERROR (-20100,'ERRROR : '|| TO_CHAR(SQLCODE) ||' ' || SQLERRM);
END;
/
SHOW ERRORS
