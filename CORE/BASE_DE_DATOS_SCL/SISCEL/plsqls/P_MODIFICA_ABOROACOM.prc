CREATE OR REPLACE PROCEDURE        P_MODIFICA_ABOROACOM(
  VP_ESTADIA IN NUMBER ,
  VP_IMPLIMCONS IN NUMBER ,
  VP_FECALTA IN DATE ,
  VP_FECBAJA IN DATE ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que actualiza las tablas de interfase con tarificacion
-- de abonados roaming de la compania con nuevos valores
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
BEGIN
   VP_PROC := 'P_MODIFICA_ABOROACOM';
   VP_TABLA := 'GA_INTAROACOM';
   VP_ACT := 'U';
   UPDATE GA_INTAROACOM
      SET FEC_DESDE = VP_FECALTA,
          FEC_HASTA = VP_FECBAJA,
   IMP_LIMCONSUMO = VP_IMPLIMCONS
    WHERE NUM_ESTADIA = VP_ESTADIA;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
