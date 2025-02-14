CREATE OR REPLACE PROCEDURE P_ALTA_INTARTREK(
  VP_ABONADO IN NUMBER ,
  VP_INDACREC IN VARCHAR2 ,
  VP_CLIENTE IN NUMBER ,
  VP_IMPLIMCONS IN NUMBER ,
  VP_TIPPLANTARIF IN CHAR ,
  VP_PLANTARIF IN VARCHAR2 ,
  VP_SERIE IN VARCHAR2 ,
  VP_MAN IN NUMBER ,
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
  V_DIASESPTREK GA_DATOSGENER.COD_DIASESPTREK%TYPE;
  V_CLIENTE_AG VE_VENDEDORES.COD_CLIENTE%TYPE;
  V_CICLO GE_CLIENTES.COD_CICLO%TYPE;
  V_PLANCOMNEW GA_INTARCEL.COD_PLANCOM%TYPE;
  VAR1 GA_ABOTREK.NUM_ABONADO%TYPE;
  ERROR_PROCESO EXCEPTION;
  CLIENTE GA_INTARTREK.COD_CLIENTE%TYPE;
  ABONADO GA_INTARTREK.NUM_ABONADO%TYPE;
  DESDE GA_INTARTREK.FEC_DESDE%TYPE;
  HASTA GA_INTARTREK.FEC_HASTA%TYPE;
  LIMCONS GA_INTARTREK.IMP_LIMCONSUMO%TYPE;
  DIAESP GA_INTARTREK.IND_DIASESP%TYPE;
  TIPPL GA_INTARTREK.TIP_PLANTARIF%TYPE;
  PLANT GA_INTARTREK.COD_PLANTARIF%TYPE;
  MAN GA_INTARTREK.NUM_MAN%TYPE;
  CARGOBAS GA_INTARTREK.COD_CARGOBASICO%TYPE;
  CICLO GA_INTARTREK.COD_CICLO%TYPE;
  PLANCOM GA_INTARTREK.COD_PLANCOM%TYPE;
  PLANSERV GA_INTARTREK.COD_PLANSERV%TYPE;
  GRPSERV GA_INTARTREK.COD_GRPSERV%TYPE;
  SERIE GA_INTARTREK.NUM_SERIE%TYPE;
  GRUPO GA_INTARTREK.COD_GRUPO%TYPE;
BEGIN
   VP_PROC := 'P_ALTA_INTARTREK';
   VP_TABLA := 'GA_DATOSGENER';
   VP_ACT := 'S';
   dbms_output.put_line ('estamos entrando a insert intartrek');
   SELECT COD_DIASESPTREK
     INTO V_DIASESPTREK
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
          AND COD_SERVICIO = V_DIASESPTREK
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
       dbms_output.put_line ('sale de la select plancom');
    ELSE
       SELECT COD_PLANCOM
         INTO V_PLANCOM
         FROM GA_CLIENTE_PCOM
        WHERE COD_CLIENTE = VP_CLIENTE
          AND VP_FECSYS BETWEEN FEC_DESDE
                            AND NVL(FEC_HASTA,VP_FECSYS);
    END IF;
       dbms_output.put_line ('sale de recuperar plan comercial');
       dbms_output.put_line ('intenta insertar en intartrek');
    VP_TABLA := 'GA_INTARTREK';
    VP_ACT := 'I';
       dbms_output.put_line ('cliente:'||to_char(vp_cliente)||'*');
       dbms_output.put_line ('abonado:'||to_char(vp_abonado)||'*');
       dbms_output.put_line ('fecalta:'||to_char(vp_fecalta)||'*');
       dbms_output.put_line ('implicons:'||to_char(vp_implimcons)||'*');
       dbms_output.put_line ('diasesp:'||to_char(v_diasesp)||'*');
       dbms_output.put_line ('tipplan:'||vp_tipplantarif||'*');
       dbms_output.put_line ('plantarif:'||vp_plantarif||'*');
       dbms_output.put_line ('serie:'||vp_serie||'*');
       dbms_output.put_line ('cargobasico:'||vp_cargobasico||'*');
       dbms_output.put_line ('man:'||to_char(vp_man)||'*');
       dbms_output.put_line ('ciclo:'||to_char(vp_ciclo)||'*');
       dbms_output.put_line ('plancom:'||to_char(v_plancom)||'*');
       dbms_output.put_line ('planserv:'||vp_planserv||'*');
       dbms_output.put_line ('grpserv:'||vp_grpserv||'*');
       dbms_output.put_line ('holding:'||vp_holding||'*');
       dbms_output.put_line ('empresa:'||vp_empresa||'*');
       select DECODE(VP_INDACREC,'R',V_CLIENTE_AG,VP_CLIENTE)
  into cliente from dual;
       dbms_output.put_line ('1');
       abonado := vp_abonado;
       dbms_output.put_line ('2');
       desde := vp_fecalta;
       dbms_output.put_line ('3');
       hasta := TO_DATE('31-12-3000','DD-MM-YYYY');
       dbms_output.put_line ('4');
       limcons := vp_implimcons;
       dbms_output.put_line ('5');
       diaesp := v_diasesp;
       dbms_output.put_line ('6');
       tippl := vp_tipplantarif;
       dbms_output.put_line ('7');
       plant := vp_plantarif;
       dbms_output.put_line ('8');
       serie := vp_serie;
       dbms_output.put_line ('9');
       man := vp_man;
       dbms_output.put_line ('10');
       cargobas := vp_cargobasico;
       dbms_output.put_line ('11');
       select DECODE(VP_INDACREC,'R',V_CICLO,VP_CICLO)
 into ciclo from dual;
       dbms_output.put_line ('12');
       plancom := v_plancom;
       dbms_output.put_line ('13');
       planserv := vp_planserv;
       dbms_output.put_line ('14');
       grpserv := vp_grpserv;
       dbms_output.put_line ('15');
       select DECODE(VP_TIPPLANTARIF,'E',VP_EMPRESA,'H',VP_HOLDING,NULL)
       into grupo from dual;
       dbms_output.put_line ('16');
    INSERT INTO GA_INTARTREK
           (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
     FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
            TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
            NUM_MAN,COD_CARGOBASICO,COD_CICLO,
            COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
            COD_GRUPO)
    VALUES (DECODE(VP_INDACREC,'R',V_CLIENTE_AG,VP_CLIENTE),VP_ABONADO,
            VP_FECALTA,TO_DATE('31-12-3000','DD-MM-YYYY'),VP_IMPLIMCONS,
            V_DIASESP,VP_TIPPLANTARIF,VP_PLANTARIF,VP_SERIE,
            VP_MAN,VP_CARGOBASICO,DECODE(VP_INDACREC,'R',V_CICLO,VP_CICLO),
            V_PLANCOM,VP_PLANSERV,VP_GRPSERV,
            DECODE(VP_TIPPLANTARIF,'E',VP_EMPRESA,'H',VP_HOLDING,NULL));
       dbms_output.put_line ('todo va bien en insert intartrek');
    IF VP_INDACREC = 'A' THEN
       BEGIN
          VP_TABLA := 'GA_CLIENTE_PCOM';
          VP_ACT := 'S';
          SELECT COD_PLANCOM
            INTO V_PLANCOMNEW
            FROM GA_CLIENTE_PCOM
           WHERE COD_CLIENTE = VP_CLIENTE
             AND VP_FECSYS < FEC_DESDE;
          P_CAMBIO_PLANCOM(4,VP_CLIENTE,VP_ABONADO,V_PLANCOMNEW,
      VP_CICLO,VP_FECSYS,VP_PROC,VP_TABLA,
      VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
          IF VP_ERROR <> '0' THEN
       VP_ERROR := '4';
       RAISE ERROR_PROCESO;
          END IF;
   VP_PROC := 'P_ALTA_INTARTREK';
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
       dbms_output.put_line ('excepcion error_proceso');
 IF VP_SQLCODE IS NULL THEN
    VP_SQLCODE := SQLCODE;
    VP_SQLERRM := SQLERRM;
        END IF;
        VP_ERROR := '4';
   WHEN OTHERS THEN
       dbms_output.put_line ('excepcion others');
        VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
