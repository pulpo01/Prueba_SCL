CREATE OR REPLACE PROCEDURE        P_MODIFICA_CONCEPTOS(
  VP_TRANSAC IN VARCHAR2 ,
  VP_TIPSERV IN VARCHAR2 ,
  VP_PRODUCTO IN VARCHAR2 ,
  VP_SERVICIO IN VARCHAR2 ,
  VP_DESCRIPCION IN VARCHAR2 ,
  VP_CONCEPTO IN VARCHAR2 )
IS
--
--
-- Procedimiento de modificacion de conceptos facturables por servicios
-- y penalizaciones al modificar las descripciones de estos.
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; El concepto fue modificado correctamente
--         - "4" ; Error en el proceso
--
   V_ERROR    CHAR(1) := '0';
   V_PRODUCTO GA_ACTUASERV.COD_PRODUCTO%TYPE;
   V_CONCEPTO GA_ACTUASERV.COD_CONCEPTO%TYPE;
   V_CONCFACT GA_ACTUASERV.COD_CONCEPTO%TYPE;
   V_TRANSAC GA_TRANSACABO.NUM_TRANSACCION%TYPE;
   V_DESCRIPCION GA_SERVICIOS.DES_SERVICIO%TYPE;
   ERROR_PROCESO EXCEPTION;
BEGIN
   V_CONCEPTO := TO_NUMBER(VP_CONCEPTO);
   V_TRANSAC  := TO_NUMBER(VP_TRANSAC);
   V_DESCRIPCION := LOWER(VP_DESCRIPCION);
   IF V_CONCEPTO IS NOT NULL THEN
      P_CAMBIO_CONCEPTO(V_CONCEPTO,V_DESCRIPCION,'N',V_ERROR);
      IF V_ERROR <> '0' THEN
         RAISE ERROR_PROCESO;
      END IF;
   ELSE
      P_RECUPERA_CONCEPTO(VP_PRODUCTO,VP_TIPSERV,
                          VP_SERVICIO,V_CONCEPTO,V_CONCFACT,V_ERROR);
      IF V_ERROR = '4' THEN
  dbms_output.put_line ('se pira aqui el jodio');
         RAISE ERROR_PROCESO;
      ELSIF V_ERROR = '1' THEN
            V_ERROR := '0';
      ELSIF V_ERROR = '0' THEN
         IF V_CONCFACT IS NOT NULL THEN
            P_CAMBIO_CONCEPTO(V_CONCFACT,V_DESCRIPCION,'F',V_ERROR);
         END IF;
         IF V_ERROR <> '0' THEN
            RAISE ERROR_PROCESO;
         END IF;
         IF V_CONCEPTO IS NOT NULL THEN
            P_CAMBIO_CONCEPTO(V_CONCEPTO,V_DESCRIPCION,'N',V_ERROR);
         END IF;
      END IF;
   END IF;
   RAISE ERROR_PROCESO;
EXCEPTION
   WHEN ERROR_PROCESO THEN
        INSERT INTO GA_TRANSACABO
                  (NUM_TRANSACCION,
                   COD_RETORNO,
                   DES_CADENA)
           VALUES (V_TRANSAC,
                   V_ERROR,
                   NULL);
   WHEN OTHERS THEN
        RAISE ERROR_PROCESO;
END;
/
SHOW ERRORS
