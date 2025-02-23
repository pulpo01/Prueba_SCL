CREATE OR REPLACE PROCEDURE        P_DATOS_ABOROAVIS(
  VP_ESTADIA IN NUMBER ,
  VP_CLIENTE IN OUT NUMBER ,
  VP_ABONADO IN OUT NUMBER ,
  VP_FECALTA IN OUT DATE ,
  VP_FECBAJA IN OUT DATE ,
  VP_IMPLIMCONS IN OUT NUMBER ,
  VP_SERIE IN OUT VARCHAR2 ,
  VP_CELDA IN OUT VARCHAR2 ,
  VP_CELULAR IN OUT NUMBER ,
  VP_OPERADOR IN OUT NUMBER ,
  VP_CELUORIG IN OUT NUMBER ,
  VP_MOVALTA IN OUT NUMBER ,
  VP_MOVBAJA IN OUT NUMBER ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que recupera datos en la tabla de abonados roaming de
-- la compania
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
BEGIN
   VP_PROC := 'P_DATOS_ABOROAVIS';
   VP_TABLA := 'GA_ABOROAVIS';
   VP_ACT := 'S';
   SELECT COD_CLIENTE,NUM_ABONADO,FEC_ALTA,FEC_BAJA,
   IMP_LIMCONSUMO,NUM_SERIEHEX,COD_CELDA,
   NUM_CELULAR,COD_OPERADOR,NUM_CELUROPER,
   NUM_MOVALTA,NUM_MOVBAJA
     INTO VP_CLIENTE,VP_ABONADO,VP_FECALTA,VP_FECBAJA,
          VP_IMPLIMCONS,VP_SERIE,VP_CELDA,
   VP_CELULAR,VP_OPERADOR,VP_CELUORIG,
   VP_MOVALTA,VP_MOVBAJA
     FROM GA_ABOROAVIS
    WHERE NUM_ESTADIA = VP_ESTADIA;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
