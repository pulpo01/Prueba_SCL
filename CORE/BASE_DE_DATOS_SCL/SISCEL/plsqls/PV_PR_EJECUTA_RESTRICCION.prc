CREATE OR REPLACE PROCEDURE PV_PR_EJECUTA_RESTRICCION (
          v_secuencia     IN  VARCHAR2,
          v_modulo        IN  VARCHAR2,
          v_producto      IN  NUMBER,
          v_actuacion     IN  VARCHAR2,
          v_evento        IN  VARCHAR2,
          v_param_entrada IN  VARCHAR2
) IS
-- Procedimiento que llama a otras rutinas en forma dinamica
-- Creación     : 28 de mayo de 2002
-- Modificación : 12 de junio de 2002
-- Autor        :

     v_num_restriccion   pv_actuac_restriccion.num_restriccion%TYPE;

     v_tip_rutina        pv_restricciones.tip_rutina%TYPE;
     v_nom_rutina        pv_restricciones.nom_rutina%TYPE;

     v_param_salida      VARCHAR2(2000) := '';
     v_param_entrada_cte VARCHAR2(2000) := '';
     v_comando_sql       VARCHAR2(2000) := '';
     V_param_ok          VARCHAR(5);


     V_ERROR   VARCHAR2(1) := '0';
     V_CADENA  VARCHAR2(255);

     ERROR_PROCESO EXCEPTION;

     CURSOR C_ACTREST IS
     SELECT num_restriccion
     FROM   PV_ACTUAC_RESTRICCION
     WHERE  cod_operadora   = (select ge_fn_operadora_scl from dual) --ge_fn_operadora_scl()
     AND    cod_modulo      = v_modulo
     AND    cod_producto    = v_producto
     AND    cod_actuacion   = v_actuacion
     AND    cod_evento      = v_evento
     AND    flg_estado      = 'TRUE'
     ORDER BY IND_ORDEN ASC;


BEGIN
---- Selecciona rutina a ejecutar y valida su existencia
     V_ERROR  := '0';
     V_CADENA := 'OK';

     OPEN C_ACTREST;
     LOOP
         FETCH C_ACTREST INTO v_num_restriccion;
         EXIT WHEN C_ACTREST%NOTFOUND;
         v_tip_rutina := '';
         v_nom_rutina := '';
         SELECT tip_rutina, nom_rutina
         INTO   v_tip_rutina, v_nom_rutina
         FROM   pv_restricciones
         WHERE  cod_modulo      = v_modulo
         AND    cod_producto    = v_producto
         AND    num_restriccion = v_num_restriccion;
         IF SQLCODE <> 0 THEN
            V_ERROR  := '4';
            V_CADENA := 'ERROR EN PV_PR_EJECUTA_RESTRICCION: AL LEER TABLA PV_RESTRCCCIONES.';
            RAISE error_proceso;
         END IF;

         V_param_ok     := 'TRUE';
         v_param_salida := 'OK';

--       Llama a la otra rutina diferenciando Funcion, PL sin parametros y PL con parametros
         IF v_tip_rutina = 'FC' THEN
            v_comando_sql:='SELECT '||v_nom_rutina||'('||v_param_entrada||') FROM dual';
            EXECUTE IMMEDIATE v_comando_sql INTO v_param_salida;

         ELSIF v_tip_rutina = 'PL' THEN
               IF TRIM(v_param_entrada) = '' OR v_param_entrada IS NULL THEN  -- sin parametros
                  v_param_entrada_cte := ':V_param_ok,:v_param_salida';
                  v_comando_sql:= 'BEGIN ' || v_nom_rutina||'('|| v_param_entrada_cte ||'); END;';
                  EXECUTE IMMEDIATE v_comando_sql USING OUT V_param_ok, OUT v_param_salida;

               ELSE --con 1 parametro compuesto entrada y uno compuesto salida
                  v_param_entrada_cte := ':v_param_entrada,:V_param_ok,:v_param_salida';
                  v_comando_sql:= 'BEGIN ' || v_nom_rutina||'('|| v_param_entrada_cte ||'); END;';
                    EXECUTE IMMEDIATE v_comando_sql USING IN v_param_entrada, OUT V_param_ok, OUT v_param_salida;
               END IF;
            ELSE
               V_ERROR  := '4';
               V_CADENA := 'ERROR EN PV_PR_EJECUTA_RESTRICCION: NO ESTA HABILITADO PARA EJECUTAR EL TIPO DE RUTINA INDOCADO ('||v_tip_rutina||').';
               RAISE error_proceso;
            END IF;

         IF v_param_ok = 'FALSE' THEN
            V_ERROR  := '4';
            V_CADENA := v_param_salida;
            RAISE error_proceso;
         END IF;

     END LOOP;


     RAISE ERROR_PROCESO;


     EXCEPTION
     WHEN ERROR_PROCESO THEN
          INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                             VALUES (v_secuencia    , V_ERROR    , V_CADENA);


END;
/
SHOW ERRORS
