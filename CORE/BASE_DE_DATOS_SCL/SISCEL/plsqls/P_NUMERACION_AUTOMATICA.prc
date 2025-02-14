CREATE OR REPLACE PROCEDURE P_NUMERACION_AUTOMATICA(
  VP_TRANSAC IN VARCHAR2 ,
  VP_ACTABO IN VARCHAR2 ,
  VP_SUBALM IN VARCHAR2 ,
  VP_CENTRAL IN VARCHAR2 ,
  VP_USO IN VARCHAR2 )
IS
--
-- Procedimiento de recuperacion de numeracion seleccionada de forma
-- automatica en funcion del Subalm, Central y Uso de la linea
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Numero Seleccionado y Reservado
--         - "1" ; Rango Bloqueado Temporalmente
--         - "2" ; No Existe Numeracion para Asignar
--         - "4" ; Error en el proceso
--
   V_ERROR CHAR(1) := '2';
   V_CAT GA_CELNUM_USO.COD_CAT%TYPE;
   V_CELULAR GA_ABOCEL.NUM_CELULAR%TYPE;
   V_TABLA CHAR(1);
   V_FECBAJA DATE := NULL;
   V_CADENA GA_TRANSACABO.DES_CADENA%TYPE := NULL;
   ERROR_PROCESO EXCEPTION;
   V_FORMAT_FECHA  GA_TRANSACABO.DES_CADENA%TYPE;
BEGIN
   V_TABLA := 'R';
   P_SELECT_REUTILIZABLES (VP_ACTABO,VP_SUBALM,VP_CENTRAL,
                           VP_USO,V_CELULAR,V_CAT,V_FECBAJA,V_ERROR);
   IF V_ERROR = '2' THEN
      V_TABLA := 'L';
     P_SELECT_RANGOS (VP_ACTABO,VP_SUBALM,VP_CENTRAL,
                       VP_USO,V_CELULAR,V_CAT,V_ERROR);
   END IF;

   SELECT VAL_PARAMETRO INTO V_FORMAT_FECHA FROM GED_PARAMETROS
   WHERE COD_PRODUCTO = 1  AND COD_MODULO = 'GE' AND NOM_PARAMETRO = 'FORMATO_SEL2';

   IF V_ERROR = '0' THEN
      V_CADENA := '/'||TO_CHAR(V_CELULAR)||
                  '/'||V_TABLA||
                  '/'||TO_CHAR(V_CAT)||
                  '/'||TO_CHAR(V_FECBAJA,V_FORMAT_FECHA);
      INSERT INTO GA_TRANSACABO
                 (NUM_TRANSACCION,
                  COD_RETORNO,
                  DES_CADENA)
          VALUES (VP_TRANSAC,
                  V_ERROR,
                  V_CADENA);
      COMMIT;
   ELSif V_ERROR <> '2' then
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
           ROLLBACK;
           INSERT INTO GA_TRANSACABO
                  (NUM_TRANSACCION,
                   COD_RETORNO,
                   DES_CADENA)
           VALUES (VP_TRANSAC,
                   V_ERROR,
                   NULL);
           COMMIT;
END;
/
SHOW ERRORS
