CREATE OR REPLACE PROCEDURE        P_NUMERACION_AUTOMATICAROA(
  VP_TRANSAC IN VARCHAR2 ,
  VP_OPERADOR IN NUMBER ,
  VP_PAIS IN VARCHAR2 ,
  VP_ZONA IN VARCHAR2 )
IS
--
-- Procedimiento de recuperacion de numeracion roaming seleccionada de forma
-- automatica en funcion del operador, zona y pais
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Numero Seleccionado y Reservado
--         - "1" ; Rango Bloqueado Temporalmente
--         - "2" ; No Existe Numeracion para Asignar
--         - "4" ; Error en el proceso
--
   V_ERROR CHAR(1) := '2';
   V_CELULAR GA_ABOROACOM.NUM_CELULAR%TYPE;
   V_TABLA CHAR(1);
   V_FECBAJA DATE := NULL;
   V_CADENA GA_TRANSACABO.DES_CADENA%TYPE := NULL;
   V_OPERADOR GA_NUMROAOPER.COD_OPERADOR%TYPE;
   ERROR_PROCESO EXCEPTION;
BEGIN
   V_OPERADOR := TO_NUMBER(VP_OPERADOR);
   V_TABLA := 'R';
   P_SELECT_REUTILIZABLESROA (V_OPERADOR,VP_PAIS,VP_ZONA,V_CELULAR,
         V_FECBAJA,V_ERROR);
   IF V_ERROR = '2' THEN
      V_TABLA := 'L';
      P_SELECT_RANGOSROA (V_OPERADOR,VP_PAIS,VP_ZONA,V_CELULAR,V_ERROR);
   END IF;
   IF V_ERROR = '0' THEN
      V_CADENA := '/'||TO_CHAR(V_CELULAR)||
                  '/'||V_TABLA||
                  '/'||TO_CHAR(V_FECBAJA,'DD-MM-YYYY');
      INSERT INTO GA_TRANSACABO
                 (NUM_TRANSACCION,
                  COD_RETORNO,
                  DES_CADENA)
          VALUES (VP_TRANSAC,
                  V_ERROR,
                  V_CADENA);
      COMMIT;
   ELSE
      RAISE ERROR_PROCESO;
   END IF;
EXCEPTION
   WHEN ERROR_PROCESO THEN
        ROLLBACK;
        INSERT INTO GA_TRANSACABO
                  (NUM_TRANSACCION,
                   COD_RETORNO,
                   DES_CADENA)
           VALUES (VP_TRANSAC,
                   V_ERROR,
                   NULL);
        COMMIT;
   WHEN OTHERS THEN
        RAISE ERROR_PROCESO;
END;
/
SHOW ERRORS
