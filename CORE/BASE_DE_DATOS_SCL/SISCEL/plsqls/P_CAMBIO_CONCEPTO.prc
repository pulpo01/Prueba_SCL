CREATE OR REPLACE PROCEDURE        P_CAMBIO_CONCEPTO(
  VP_CONCEPTO IN NUMBER ,
  VP_DESCRIPCION IN VARCHAR2 ,
  VP_TIPCONC IN VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
--
-- Procedimiento de modificacion de los conceptos
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; El concepto fue modificado correctamente
--         - "4" ; Error en el proceso
--
   V_PRODUCTO GA_ACTUASERV.COD_PRODUCTO%TYPE;
   V_CONCEDTO GA_ACTUASERV.COD_CONCEPTO%TYPE;
   V_ABONO FA_DATOSGENER.DES_ABONO%TYPE;
   V_DTO FA_DATOSGENER.DES_DESCUENTO%TYPE;
   V_DESCRIPCION FA_CONCEPTOS.DES_CONCEPTO%TYPE;
   ERROR_PROCESO EXCEPTION;
BEGIN
   V_DESCRIPCION := VP_DESCRIPCION;
   BEGIN
     SELECT DES_ABONO,DES_DESCUENTO
       INTO V_ABONO,V_DTO
       FROM FA_DATOSGENER;
   EXCEPTION
     WHEN OTHERS THEN
          RAISE ERROR_PROCESO;
   END;
   BEGIN
     SELECT COD_CONCEPTO
       INTO V_CONCEDTO
       FROM FA_CONCEPTOS
      WHERE COD_TIPCONCE = 2
        AND COD_CONCORIG = VP_CONCEPTO;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
          NULL;
     WHEN OTHERS THEN
          RAISE ERROR_PROCESO;
   END;
   IF VP_TIPCONC = 'F' THEN
      V_DESCRIPCION := SUBSTR(V_ABONO||' '||V_DESCRIPCION,1,60);
   END IF;
   UPDATE FA_CONCEPTOS SET DES_CONCEPTO = V_DESCRIPCION
    WHERE COD_CONCEPTO = VP_CONCEPTO;
   IF V_CONCEDTO IS NOT NULL THEN
      V_DESCRIPCION := SUBSTR(V_DTO||' '||V_DESCRIPCION,1,60);
      UPDATE FA_CONCEPTOS SET DES_CONCEPTO = V_DESCRIPCION
       WHERE COD_CONCEPTO = V_CONCEDTO;
   END IF;
EXCEPTION
   WHEN ERROR_PROCESO THEN
        VP_ERROR := '4';
   WHEN OTHERS THEN
        RAISE ERROR_PROCESO;
END;
/
SHOW ERRORS
