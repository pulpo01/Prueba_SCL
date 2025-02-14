CREATE OR REPLACE PROCEDURE        P_CREAR_CONCEPTO(
  VP_DESCRIPCION IN VARCHAR2 ,
  VP_MODULO IN VARCHAR2 ,
  VP_PRODUCTO IN VARCHAR2 ,
  VP_MONEDA IN VARCHAR2 ,
  VP_CONCEPTO IN OUT NUMBER ,
  VP_TIPCONCE IN NUMBER ,
  VP_ORIGEN IN VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de creacion de conceptos
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Concepto insertado correctamente
--         - "4" ; Error en el proceso
--
   V_CONCORIG    FA_CONCEPTOS.COD_CONCORIG%TYPE := NULL;
BEGIN
   IF VP_TIPCONCE =  2 THEN
      V_CONCORIG := VP_CONCEPTO;
   END IF;
   dbms_output.put_line ('1');
   SELECT FA_SEQ_CONCE.NEXTVAL INTO VP_CONCEPTO FROM DUAL;
   dbms_output.put_line ('2');
   INSERT INTO FA_CONCEPTOS
               (COD_CONCEPTO,
                COD_PRODUCTO,
                DES_CONCEPTO,
                COD_TIPCONCE,
                COD_MODULO,
                IND_ACTIVO,
                COD_MONEDA,
                COD_CONCORIG,
                COD_TIPDESCU)
        VALUES (VP_CONCEPTO,
                VP_PRODUCTO,
                VP_DESCRIPCION,
                VP_TIPCONCE,
                VP_MODULO,
                0,
                VP_MONEDA,
                V_CONCORIG,
                DECODE(VP_TIPCONCE,2,'S',NULL));
   dbms_output.put_line ('3');
   IF VP_TIPCONCE =  2 AND VP_ORIGEN = '1' THEN
      VP_CONCEPTO := V_CONCORIG;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
