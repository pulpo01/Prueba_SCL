CREATE OR REPLACE PROCEDURE P_ALTA_INTARBEEP(
  VP_ABONADO IN NUMBER ,
  VP_INDACREC IN VARCHAR2 ,
  VP_CLIENTE IN NUMBER ,
  VP_IMPLIMCONS IN NUMBER ,
  VP_TIPPLANTARIF IN CHAR ,
  VP_PLANTARIF IN VARCHAR2 ,
  VP_CAPCODE IN NUMBER ,
  VP_BEEPER IN NUMBER ,
  VP_CARGOBASICO IN VARCHAR2 ,
  VP_CICLO IN NUMBER ,
  VP_PLANSERV IN VARCHAR2 ,
  VP_GRPSERV IN VARCHAR2 ,
  VP_EMPRESA IN NUMBER ,
  VP_HOLDING IN NUMBER ,
  VP_PROCALTA IN NUMBER ,
  VP_AGENTE IN NUMBER ,
  VP_FECALTA IN DATE ,
  VP_FECSYS IN DATE ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que inserta datos en la tabla de interfase
-- Abonados/Tarificacion para el procesamiento de estos.
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
  V_PLANCOM VE_PLANCOM.COD_PLANCOM%TYPE;
  V_DIASESP GA_INTARCEL.IND_DIASESP%TYPE;
  V_DIASESPBEEP GA_DATOSGENER.COD_DIASESPBEEP%TYPE;
  V_CLIENTE_AG VE_VENDEDORES.COD_CLIENTE%TYPE;
  V_CICLO GE_CLIENTES.COD_CICLO%TYPE;
  V_PLANCOMNEW GA_INTARCEL.COD_PLANCOM%TYPE;
  VAR1 GA_ABOBEEP.NUM_ABONADO%TYPE;
  ERROR_PROCESO EXCEPTION;
BEGIN
   VP_PROC := 'P_ALTA_INTARBEEP';
   VP_TABLA := 'GA_DATOSGENER';
   VP_ACT := 'S';
   dbms_output.put_line ('estamos entrando otra ve');
   SELECT COD_DIASESPBEEP
     INTO V_DIASESPBEEP
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
    END IF;
    BEGIN
       VP_TABLA := 'GA_SERVSUPLABO';
       VP_ACT := 'S';
       SELECT NUM_ABONADO
         INTO VAR1
         FROM GA_SERVSUPLABO
        WHERE NUM_ABONADO = VP_ABONADO
          AND COD_SERVICIO = V_DIASESPBEEP
          AND IND_ESTADO < 3;
       V_DIASESP := 1;
    EXCEPTION
       WHEN NO_DATA_FOUND THEN
            V_DIASESP := 0;
       WHEN TOO_MANY_ROWS THEN
     V_DIASESP := 1;
       WHEN OTHERS THEN
     VP_ERROR := '4';
     RAISE ERROR_PROCESO;
    END;
       dbms_output.put_line ('va a recuperar el plan comercial');
    VP_TABLA := 'GA_CLIENTE_PCOM';
    VP_ACT := 'S';
    IF VP_INDACREC = 'R' THEN
       dbms_output.put_line ('entra en la select plancom');
       dbms_output.put_line ('cliente: '||to_char(v_cliente_ag));
       SELECT COD_PLANCOM
         INTO V_PLANCOM
         FROM GA_CLIENTE_PCOM
        WHERE COD_CLIENTE = V_CLIENTE_AG
          AND VP_FECSYS BETWEEN FEC_DESDE
                            AND NVL(FEC_HASTA,VP_FECSYS);
       dbms_output.put_line ('sale de la select de plancom');
    ELSE
       SELECT COD_PLANCOM
         INTO V_PLANCOM
         FROM GA_CLIENTE_PCOM
        WHERE COD_CLIENTE = VP_CLIENTE
          AND VP_FECSYS BETWEEN FEC_DESDE
                            AND NVL(FEC_HASTA,VP_FECSYS);
    END IF;
       dbms_output.put_line ('sale de recuperar plan comercial');
       dbms_output.put_line ('intenta insertar en intarcel');
    VP_TABLA := 'GA_INTARBEEP';
    VP_ACT := 'I';
       dbms_output.put_line ('cliente:'||to_char(vp_cliente));
       dbms_output.put_line ('abonado:'||to_char(vp_abonado));
       dbms_output.put_line ('fecalta:'||to_char(vp_fecalta));
       dbms_output.put_line ('implicons:'||to_char(vp_implimcons));
       dbms_output.put_line ('diasesp:'||to_char(v_diasesp));
       dbms_output.put_line ('tipplan:'||vp_tipplantarif);
       dbms_output.put_line ('plantarif:'||vp_plantarif);
       dbms_output.put_line ('capcode:'||to_char(vp_capcode));
       dbms_output.put_line ('cargobasico:'||vp_cargobasico);
       dbms_output.put_line ('beeper:'||to_char(vp_beeper));
       dbms_output.put_line ('ciclo:'||to_char(vp_ciclo));
       dbms_output.put_line ('plancom:'||to_char(v_plancom));
       dbms_output.put_line ('planserv:'||vp_planserv);
       dbms_output.put_line ('grpserv:'||vp_grpserv);
       dbms_output.put_line ('holding:'||vp_holding);
       dbms_output.put_line ('empresa:'||vp_empresa);
    INSERT INTO GA_INTARBEEP
           (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
     FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
            TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
            NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
            COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
            COD_GRUPO)
    VALUES (DECODE(VP_INDACREC,'R',V_CLIENTE_AG,VP_CLIENTE),VP_ABONADO,
            VP_FECALTA,TO_DATE('31-12-3000','DD-MM-YYYY'),VP_IMPLIMCONS,
            V_DIASESP,VP_TIPPLANTARIF,VP_PLANTARIF,VP_CAPCODE,
            VP_BEEPER,VP_CARGOBASICO,DECODE(VP_INDACREC,'R',V_CICLO,VP_CICLO),
            V_PLANCOM,VP_PLANSERV,VP_GRPSERV,
            DECODE(VP_TIPPLANTARIF,'E',VP_EMPRESA,'H',VP_HOLDING,NULL));
       dbms_output.put_line ('todo va bien en insert intarbeep');
    IF VP_INDACREC = 'A' THEN
       BEGIN
          VP_TABLA := 'GA_CLIENTE_PCOM';
          VP_ACT := 'S';
          SELECT COD_PLANCOM
            INTO V_PLANCOMNEW
            FROM GA_CLIENTE_PCOM
           WHERE COD_CLIENTE = VP_CLIENTE
             AND VP_FECSYS < FEC_DESDE;
          P_CAMBIO_PLANCOM(2,VP_CLIENTE,VP_ABONADO,V_PLANCOMNEW,
      VP_CICLO,VP_FECSYS,VP_PROC,VP_TABLA,
      VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
          IF VP_ERROR <> '0' THEN
       VP_ERROR := '4';
       RAISE ERROR_PROCESO;
          END IF;
   VP_PROC := 'P_ALTA_INTARBEEP';
       EXCEPTION
          WHEN NO_DATA_FOUND THEN
        NULL;
          WHEN OTHERS THEN
        VP_SQLCODE := SQLCODE;
        VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
       END;
    END IF;
EXCEPTION
   WHEN ERROR_PROCESO THEN
       dbms_output.put_line ('excepcion error proceso');
 IF VP_SQLCODE IS NULL THEN
    VP_SQLCODE := SQLCODE;
    VP_SQLERRM := SQLERRM;
        END IF;
        VP_ERROR := '4';
   WHEN OTHERS THEN
       dbms_output.put_line ('se va por el others');
        VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
