CREATE OR REPLACE PROCEDURE        P_BAJA_RENT(
  VP_ALQUILER IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_FECSYS IN DATE ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que refleja la baja de abonados Rent a Phone
-- marcando fecha fin vigencia en las tablas de interfase
-- con tarificacion y facturacion
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   V_ROWID ROWID;
BEGIN
   VP_PROC := 'P_BAJA_RENT';
   VP_TABLA := 'GA_INTARENT';
   VP_ACT := 'U';
   dbms_output.put_line ('alquiler='||to_char(vp_alquiler));
   dbms_output.put_line ('abonado='||to_char(vp_abonado));
   dbms_output.put_line ('fecha sistema='||to_char(vp_fecsys,
'dd-mm-yyyy hh24:mi:ss'));
   UPDATE GA_INTARENT
      SET FEC_HASTA = VP_FECSYS
    WHERE NUM_ALQUILER = VP_ALQUILER
      AND NUM_ABONADO = VP_ABONADO
      AND VP_FECSYS BETWEEN FEC_DESDE
                        AND FEC_HASTA;
   VP_ACT := 'D';
   DELETE GA_INTARENT
    WHERE NUM_ABONADO = VP_ABONADO
      AND FEC_DESDE > VP_FECSYS;
   VP_TABLA := 'GA_INFACRENT';
   VP_ACT := 'U';
   UPDATE GA_INFACRENT
      SET IND_ACTUAC = 2,
   FEC_BAJA = VP_FECSYS
    WHERE NUM_ALQUILER = VP_ALQUILER;
   VP_TABLA := 'GA_INFACRENT';
   VP_ACT := 'D';
   DELETE GA_INFACRENT
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
