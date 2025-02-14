CREATE OR REPLACE PROCEDURE        P_NUMERACION_AUTOMATICABEEP(
  VP_TRANSAC IN VARCHAR2 ,
  VP_CENTRAL IN VARCHAR2 ,
  VP_USO IN VARCHAR2 )
IS
--
-- Procedimiento de recuperacion de numeracion beeper seleccionada de forma
-- automatica en funcion de la Central y Uso de la linea
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Numero Seleccionado y Reservado
--         - "1" ; Rango Bloqueado Temporalmente
--         - "2" ; No Existe Numeracion para Asignar
--         - "4" ; Error en el proceso
--
   V_ERROR CHAR(1) := '2';
   V_BEEPER GA_ABOBEEP.NUM_BEEPER%TYPE;
   V_TABLA CHAR(1);
   V_FECBAJA DATE := NULL;
   V_CADENA GA_TRANSACABO.DES_CADENA%TYPE := NULL;
   ERROR_PROCESO EXCEPTION;
BEGIN
   V_TABLA := 'R';
   P_SELECT_REUTILIZABLESBEEP (VP_CENTRAL,VP_USO,V_BEEPER,V_FECBAJA,V_ERROR);
   IF V_ERROR = '2' THEN
      V_TABLA := 'L';
      P_SELECT_RANGOSBEEP (VP_CENTRAL,VP_USO,V_BEEPER,V_ERROR);
   END IF;
   IF V_ERROR = '0' THEN
      V_CADENA := '/'||TO_CHAR(V_BEEPER)||
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
