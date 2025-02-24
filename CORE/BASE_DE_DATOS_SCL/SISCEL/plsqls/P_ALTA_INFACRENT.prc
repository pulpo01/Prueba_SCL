CREATE OR REPLACE PROCEDURE        P_ALTA_INFACRENT(
  VP_ALQUILER IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_CLIENTE IN NUMBER ,
  VP_CELULAR IN NUMBER ,
  VP_PROCALTA IN NUMBER ,
  VP_AGENTE IN NUMBER ,
  VP_FECALTA IN DATE ,
  VP_VENTA IN NUMBER ,
  VP_INDFACT IN NUMBER ,
  VP_FINCONTRA IN DATE ,
  VP_FECSYS IN DATE ,
  VP_FECBAJA IN DATE ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que inserta datos en la tabla de interfase
-- Abonados/Facturacion para el procesamiento de estos.
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
  V_DETALLE GA_INFACCEL.IND_DETALLE%TYPE;
  V_CODDET GA_DATOSGENER.COD_DETCEL%TYPE;
  V_CARGOS NUMBER := 0;
  VAR1 GA_ABOCEL.NUM_ABONADO%TYPE;
  ERROR_PROCESO EXCEPTION;
BEGIN
    VP_PROC := 'P_ALTA_INFACRENT';
    VP_TABLA := 'GA_DATOSGENER';
    VP_ACT := 'S';
    SELECT COD_DETCEL
      INTO V_CODDET
      FROM GA_DATOSGENER;
    BEGIN
       VP_TABLA := 'GA_SERVSUPLABO';
       VP_ACT := 'S';
       SELECT NUM_ABONADO
         INTO VAR1
         FROM GA_SERVSUPLABO
        WHERE NUM_ABONADO = VP_ABONADO
          AND COD_SERVICIO = V_CODDET
          AND IND_ESTADO < 3;
       V_DETALLE := 1;
    EXCEPTION
       WHEN NO_DATA_FOUND THEN
     V_DETALLE := 0;
       WHEN OTHERS THEN
     VP_ERROR := '4';
     RAISE ERROR_PROCESO;
    END;
    BEGIN
       VP_TABLA := 'GE_CARGOS';
       VP_ACT := 'S';
       SELECT NUM_ABONADO
         INTO VAR1
         FROM GE_CARGOS
        WHERE NUM_ABONADO = VP_ABONADO;
       V_CARGOS := 1;
    EXCEPTION
       WHEN NO_DATA_FOUND THEN
     V_CARGOS := 0;
       WHEN TOO_MANY_ROWS THEN
     V_CARGOS := 1;
       WHEN OTHERS THEN
     VP_ERROR := '4';
     RAISE ERROR_PROCESO;
    END;
    VP_TABLA := 'GA_INFACRENT';
    VP_ACT := 'I';
    INSERT INTO GA_INFACRENT
           (COD_CLIENTE,NUM_ABONADO,NUM_ALQUILER,
            FEC_ALTA,FEC_BAJA,NUM_CELULAR,
            IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
            IND_DETALLE,IND_FACTUR,IND_CARGOS,
     IND_PENALIZA)
    VALUES (VP_CLIENTE,VP_ABONADO,VP_ALQUILER,
            VP_FECALTA,VP_FECBAJA,VP_CELULAR,
            1,VP_FINCONTRA,1,
            V_DETALLE,VP_INDFACT,V_CARGOS,0);
EXCEPTION
   WHEN ERROR_PROCESO THEN
 IF VP_SQLCODE IS NULL THEN
    VP_SQLCODE := SQLCODE;
    VP_SQLERRM := SQLERRM;
        END IF;
 VP_ERROR := '4';
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
