CREATE OR REPLACE PROCEDURE        P_DELETE_CONCEPTOS(
  VP_TRANSAC IN VARCHAR2 ,
  VP_ACTABO IN VARCHAR2 ,
  VP_CONCEPTO IN VARCHAR2 )
IS
--
-- Procedimiento de borrado de conceptos facturables por servicios
-- y penalizaciones. Valida el posible borrado y si se realiza borra
-- de las tablas relacionadas con conceptos : FA_CONCEPTOS
--                                            FA_RELGRUPCONC
--                                            FA_GRUPOCOB
--                                            FA_GRPSERCONC
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; El concepto fue borrado correctamente
--         - "1" ; El concepto esta asociado a otro servicio x actuacion
--         - "4" ; Error en el proceso
--
   V_ERROR    CHAR(1) := '0';
   V_CONCEPTO GA_ACTUASERV.COD_CONCEPTO%TYPE;
   V_TRANSAC GA_TRANSACABO.NUM_TRANSACCION%TYPE;
   ERROR_PROCESO EXCEPTION;
BEGIN
   V_CONCEPTO := TO_NUMBER(VP_CONCEPTO);
   V_TRANSAC  := TO_NUMBER(VP_TRANSAC);
   IF VP_ACTABO IS NULL OR VP_ACTABO = 'FA' THEN
      P_BORRA_FACONCEPTOS (V_CONCEPTO,V_ERROR);
      IF V_ERROR <> '0' THEN
         RAISE ERROR_PROCESO;
      END IF;
   ELSE
      P_VALIDA_BORRACONC(V_CONCEPTO,V_ERROR);
      IF V_ERROR <> '0' THEN
         RAISE ERROR_PROCESO;
      END IF;
      P_BORRA_FACONCEPTOS (V_CONCEPTO,V_ERROR);
      IF V_ERROR <> '0' THEN
         RAISE ERROR_PROCESO;
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
