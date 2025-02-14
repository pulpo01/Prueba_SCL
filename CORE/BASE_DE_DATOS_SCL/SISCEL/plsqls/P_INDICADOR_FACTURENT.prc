CREATE OR REPLACE PROCEDURE        P_INDICADOR_FACTURENT(
  VP_ABONADO IN NUMBER ,
  VP_ALQUILER IN NUMBER ,
  VP_ESTADO IN NUMBER ,
  VP_FECSYS IN DATE ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que refleja el estado del Indicativo de Facturacion
-- para cada uno de los abonados de rent a phone ; 1-Activo 0-Desactivo
-- las tablas de interfase con facturacion
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
BEGIN
    VP_PROC := 'P_INDICADOR_FACTURENT';
    VP_TABLA := 'GA_INFACRENT';
    VP_ACT := 'U';
    UPDATE GA_INFACRENT
       SET IND_FACTUR  = VP_ESTADO
     WHERE NUM_ABONADO = VP_ABONADO
       AND NUM_ALQUILER  = VP_ALQUILER;
    UPDATE GA_INFACRENT
       SET IND_FACTUR = VP_ESTADO
     WHERE NUM_ABONADO = VP_ABONADO
       AND FEC_ALTA > VP_FECSYS;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
