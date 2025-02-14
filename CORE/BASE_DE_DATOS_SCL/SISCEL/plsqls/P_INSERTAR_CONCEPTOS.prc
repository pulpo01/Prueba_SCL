CREATE OR REPLACE PROCEDURE        P_INSERTAR_CONCEPTOS(
  VP_TRANSAC IN VARCHAR2 ,
  VP_PRODUCTO IN VARCHAR2 ,
  VP_DESCRIPCION IN VARCHAR2 ,
  VP_MODULO IN VARCHAR2 ,
  VP_ACTABO IN VARCHAR2 ,
  VP_TIPSERV IN VARCHAR2 ,
  VP_SERVICIO IN VARCHAR2 )
IS
--
-- Procedimiento de insercion de conceptos facturables por servicios
-- y penalizaciones en funcion de la actuacion
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Concepto insertado correctamente
--         - "4" ; Error en el proceso
--
   V_ERROR    CHAR(1) := '0';
   V_CONCEPTO FA_CONCEPTOS.COD_CONCEPTO%TYPE := NULL;
   V_CADENA   GA_TRANSACABO.DES_CADENA%TYPE := NULL;
   V_MONEDA   FA_DATOSGENER.COD_MONEFACT%TYPE;
   V_ABONO    FA_DATOSGENER.DES_ABONO%TYPE;
   V_DTO      FA_DATOSGENER.DES_DESCUENTO%TYPE;
   V_DESCRIPCION FA_CONCEPTOS.DES_CONCEPTO%TYPE;
   ERROR_PROCESO EXCEPTION;
BEGIN
   dbms_output.put_line ('entra bien en el proceso');
   V_DESCRIPCION := LOWER(VP_DESCRIPCION);
   SELECT COD_MONEFACT,DES_ABONO,DES_DESCUENTO
     INTO V_MONEDA,V_ABONO,V_DTO
     FROM FA_DATOSGENER;
   IF VP_ACTABO IS NULL THEN
   dbms_output.put_line ('se pira a p_crear_concepto');
      P_CREAR_CONCEPTO(V_DESCRIPCION,VP_MODULO,VP_PRODUCTO,
                       V_MONEDA,V_CONCEPTO,3,'1',V_ERROR);
      IF V_ERROR <> '0' THEN
       dbms_output.put_line ('se pira por 1, v_error= '||v_error);
         RAISE ERROR_PROCESO;
      END IF;
   ELSE
      IF VP_ACTABO = 'FA' THEN
   dbms_output.put_line ('es la actuacion FACTURACION');
         V_DESCRIPCION := SUBSTR(V_ABONO||' '||V_DESCRIPCION,1,60);
   dbms_output.put_line ('se pira a p_crear_concepto');
         P_CREAR_CONCEPTO(V_DESCRIPCION,VP_MODULO,VP_PRODUCTO,
                          V_MONEDA,V_CONCEPTO,3,'1',V_ERROR);
         IF V_ERROR = '0' THEN
            V_DESCRIPCION := SUBSTR(V_DTO||' '||V_DESCRIPCION,1,60);
   dbms_output.put_line ('se pira a p_crear_concepto dto');
            P_CREAR_CONCEPTO(V_DESCRIPCION,VP_MODULO,VP_PRODUCTO,
                             V_MONEDA,V_CONCEPTO,2,'1',V_ERROR);
         ELSE
       dbms_output.put_line ('se pira por 2, v_error= '||v_error);
            RAISE ERROR_PROCESO;
         END IF;
      ELSE
   dbms_output.put_line ('se pira a p_validar_actuaserv');
         P_VALIDAR_ACTUASERV(VP_PRODUCTO,VP_ACTABO,VP_TIPSERV,
                             VP_SERVICIO,V_CONCEPTO,V_ERROR);
         IF V_ERROR = '1' THEN
   dbms_output.put_line ('no encuentra en actuaserv');
            V_ERROR := '0';
   dbms_output.put_line ('se pira a p_crear_concepto');
            P_CREAR_CONCEPTO(V_DESCRIPCION,VP_MODULO,VP_PRODUCTO,
                             V_MONEDA,V_CONCEPTO,3,'1',V_ERROR);
            IF V_ERROR = '0' THEN
               V_DESCRIPCION := SUBSTR(V_DTO||' '||V_DESCRIPCION,1,60);
   dbms_output.put_line ('se pira a p_crear_concepto dto');
               P_CREAR_CONCEPTO(V_DESCRIPCION,VP_MODULO,VP_PRODUCTO,
                                V_MONEDA,V_CONCEPTO,2,'1',V_ERROR);
            ELSE
       dbms_output.put_line ('se pira por 3, v_error= '||v_error);
               RAISE ERROR_PROCESO;
            END IF;
         ELSIF V_ERROR = '4' THEN
       dbms_output.put_line ('se pira por 4, v_error= '||v_error);
            RAISE ERROR_PROCESO;
         END IF;
      END IF;
      V_ERROR := '0';
      IF VP_ACTABO = 'PA' THEN
   dbms_output.put_line ('se pira a p_insertar_actuaserv');
         P_INSERTAR_ACTUASERV(VP_PRODUCTO,VP_ACTABO,VP_TIPSERV,
                              VP_SERVICIO,V_CONCEPTO,V_ERROR);
         IF V_ERROR <> '0' THEN
       dbms_output.put_line ('se pira por 5, v_error= '||v_error);
            RAISE ERROR_PROCESO;
         END IF;
      END IF;
   END IF;
   V_CADENA := '/'||V_CONCEPTO;
       dbms_output.put_line ('se pira por bien, v_error= '||v_error);
   RAISE ERROR_PROCESO;
EXCEPTION
   WHEN ERROR_PROCESO THEN
       dbms_output.put_line ('se pira yo que se, v_error= '||v_error);
        INSERT INTO GA_TRANSACABO
                  (NUM_TRANSACCION,
                   COD_RETORNO,
                   DES_CADENA)
           VALUES (VP_TRANSAC,
                   V_ERROR,
                   V_CADENA);
   WHEN OTHERS THEN
       dbms_output.put_line ('se pira por raro, v_error= '||v_error);
        RAISE ERROR_PROCESO;
END;
/
SHOW ERRORS
