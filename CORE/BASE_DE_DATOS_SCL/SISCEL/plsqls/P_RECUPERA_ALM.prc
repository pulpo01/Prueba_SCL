CREATE OR REPLACE PROCEDURE        P_RECUPERA_ALM(
  VP_CELDA IN VARCHAR2 ,
  VP_ALM IN OUT VARCHAR2 ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de actualizacion de tabla de abonados a facturar en ciclo
-- a un nuevo ciclo
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; El cambio se ha realizado correctamente
--         - "4" ; Error en el proceso
--
BEGIN
   VP_PROC := 'P_RECUPERA_ALM';
   VP_TABLA := 'GE_ALMS';
   VP_ACT := 'J';
   SELECT C.COD_ALM
     INTO VP_ALM
     FROM GE_CELDAS A,GE_SUBALMS B,GE_ALMS C
    WHERE A.COD_CELDA = VP_CELDA
      AND A.COD_SUBALM = B.COD_SUBALM
      AND B.COD_ALM = C.COD_ALM;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
 VP_ERROR := '4';
END;
/
SHOW ERRORS
