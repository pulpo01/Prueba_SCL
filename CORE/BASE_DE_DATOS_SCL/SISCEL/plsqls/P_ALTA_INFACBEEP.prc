CREATE OR REPLACE procedure P_ALTA_INFACBEEP
 (VP_ABONADO IN NUMBER,
                                              VP_INDACREC IN VARCHAR2,
                                              VP_CLIENTE IN NUMBER,
                                              VP_BEEPER IN NUMBER,
                                              VP_CICLO IN NUMBER,
                                              VP_PROCALTA IN NUMBER,
                                              VP_AGENTE IN NUMBER,
                                              VP_FECALTA IN DATE,
                                              VP_VENTA IN NUMBER,
                                              VP_INDFACT IN NUMBER,
                                              VP_FINCONTRA IN DATE,
                                              VP_FECSYS IN DATE,
                                              VP_PROC IN OUT VARCHAR2,
                                              VP_TABLA IN OUT VARCHAR2,
                                              VP_ACT IN OUT VARCHAR2,
                                              VP_SQLCODE IN OUT VARCHAR2,
                                              VP_SQLERRM IN OUT VARCHAR2,
                                              VP_ERROR IN OUT VARCHAR2) is
--
-- Procedimiento que inserta datos en la tabla de interfase
-- Abonados/Facturacion para el procesamiento de estos.
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
  V_CICLFACT FA_CICLFACT.COD_CICLFACT%TYPE;
  V_CLIENTE_AG VE_VENDEDORES.COD_CLIENTE%TYPE;
  V_CICLO GE_CLIENTES.COD_CICLO%TYPE;
  V_PLANCOM VE_PLANCOM.COD_PLANCOM%TYPE;
  V_DETALLE GA_INFACBEEP.IND_DETALLE%TYPE;
  V_CODDET GA_DATOSGENER.COD_DETBEEP%TYPE;
  V_CUOTAS GE_MODVENTA.IND_CUOTAS%TYPE;
  V_INDARRIENDO NUMBER(1) := 0;
  V_INDCUOTAS NUMBER(1) := 0;
  V_CARGOS NUMBER := 0;
  V_USO    AL_USOS.COD_USO%TYPE;
  V_CARGOPRO NUMBER := 0;
  V_CCONTROL NUMBER := 0;
  V_USOCONTROL AL_USOS.COD_USO%TYPE;
  VAR1 GA_ABOBEEP.NUM_ABONADO%TYPE;
  ERROR_PROCESO EXCEPTION;
BEGIN
    VP_PROC := 'P_ALTA_INFACBEEP';
    VP_TABLA := 'GA_DATOSGENER';
    VP_ACT := 'S';
    SELECT COD_DETBEEP
      INTO V_CODDET
      FROM GA_DATOSGENER;
    IF VP_INDACREC = 'R' THEN
       VP_TABLA := 'VE_VENDEDORES';
       VP_ACT := 'S';
       SELECT COD_CLIENTE
         INTO V_CLIENTE_AG
         FROM VE_VENDEDORES
        WHERE COD_VENDEDOR = VP_AGENTE;

	   VP_TABLA := 'GE_CLIENTES';
       VP_ACT := 'S';
       SELECT COD_CICLO
         INTO V_CICLO
         FROM GE_CLIENTES
        WHERE COD_CLIENTE = V_CLIENTE_AG;
    ELSE
       V_CICLO := VP_CICLO;
    END IF;
--SELECCIONAMOS EL USO
        SELECT COD_USO INTO V_USO FROM GA_ABOBEEP
        WHERE NUM_ABONADO = VP_ABONADO;
--COMPROBAMOS QUE SEA UNA LINEA CON CARGO BASICO PRORRATEABLE POR SU USO
        SELECT IND_CARGOPRO INTO V_CARGOPRO FROM AL_USOS
        WHERE COD_USO = V_USO;
    VP_TABLA := 'FA_CICLFACT';
    VP_ACT := 'S';
    SELECT COD_CICLFACT
      INTO V_CICLFACT
      FROM FA_CICLFACT
     WHERE COD_CICLO = V_CICLO
       AND SYSDATE BETWEEN FEC_DESDELLAM
                       AND FEC_HASTALLAM;
    BEGIN
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
       WHEN TOO_MANY_ROWS THEN
            V_DETALLE := 1;
       WHEN OTHERS THEN
            VP_ERROR := '4';
            RAISE ERROR_PROCESO;
    END;
    VP_TABLA := 'GA_VENTAS';
    VP_ACT := 'J';
    SELECT B.IND_CUOTAS
      INTO V_CUOTAS
      FROM GA_VENTAS A,GE_MODVENTA B
     WHERE A.NUM_VENTA = VP_VENTA
       AND A.COD_MODVENTA = B.COD_MODVENTA;
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
    IF V_CUOTAS = 1 THEN
       V_INDCUOTAS := 1;
    ELSIF V_CUOTAS = 2 THEN
       V_INDARRIENDO := 1;
       IF VP_INDACREC = 'R' THEN
          P_MODIFICA_CUOTAS(VP_ABONADO,V_CLIENTE_AG,VP_PROC,VP_TABLA,
                            VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
          IF VP_ERROR <> '0' THEN
             VP_ERROR := '4';
             RAISE ERROR_PROCESO;
          END IF;
          VP_PROC := 'P_ALTA_INFACBEEP';
       END IF;
    ELSE
       V_INDCUOTAS := 0;
       V_INDARRIENDO := 0;
    END IF;
    VP_TABLA := 'GA_INFACBEEP';
    VP_ACT := 'I';
    INSERT INTO GA_INFACBEEP
           (COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,
            FEC_ALTA,FEC_BAJA,NUM_BEEPER,
            IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
            IND_DETALLE,IND_FACTUR,IND_CUOTAS,
            IND_ARRIENDO,IND_CARGOS,IND_PENALIZA, IND_CARGOPRO, IND_CUENCONTROLADA)
    VALUES (DECODE(VP_INDACREC,'R',V_CLIENTE_AG,VP_CLIENTE),VP_ABONADO,
            V_CICLFACT,VP_FECALTA,TO_DATE('31-12-3000','DD-MM-YYYY'),
            VP_BEEPER,DECODE(VP_INDACREC,'R',5,1),VP_FINCONTRA,1,
            V_DETALLE,VP_INDFACT,V_INDCUOTAS,
            V_INDARRIENDO,V_CARGOS,0, V_CARGOPRO,0);
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
