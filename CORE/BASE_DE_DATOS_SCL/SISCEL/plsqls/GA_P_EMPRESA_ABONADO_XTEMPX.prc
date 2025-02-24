CREATE OR REPLACE PROCEDURE        GA_P_EMPRESA_ABONADO_XTEMPX(
  VP_ABONADO IN NUMBER ,
  VP_PRODUCTO IN NUMBER ,
  VP_TIPPLANTARIF IN VARCHAR2 ,
  VP_HOLDING IN OUT NUMBER ,
  VP_FECSYS IN DATE ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--pl que comprueba si al aceptar un abonado es holding y no tiene abonados
--dados de alta aun, en ese caso actualiza la tabla de interfase con el abonado 0
--para que sea tomado en cuenta por facturacion
--
    V_CLIENTE GA_ABOCEL.COD_CLIENTE%TYPE;
    V_CLIENEW GA_ABOCEL.COD_CLIENTE%TYPE;
    V_PLEXSYS GA_ABOCEL.IND_PLEXSYS%TYPE;
    V_LIMCONSUMO GA_ABOCEL.COD_LIMCONSUMO%TYPE;
    V_IMPLICONS TA_LIMCONSUMO.IMP_LIMCONSUMO%TYPE;
    V_CELDA GA_ABOCEL.COD_CELDA%TYPE;
    V_TIPPLANTARIF GA_ABOCEL.TIP_PLANTARIF%TYPE;
    V_PLANTARIF GA_ABOCEL.COD_PLANTARIF%TYPE;
    V_SERIE GA_ABOCEL.NUM_SERIEHEX%TYPE;
    V_CELULAR GA_ABOCEL.NUM_CELULAR%TYPE;
    V_CELULAR_PLEX GA_ABOCEL.NUM_CELULAR_PLEX%TYPE;
    V_CARGOBASICO GA_ABOCEL.COD_CARGOBASICO%TYPE;
    V_CICLO GA_ABOCEL.COD_CICLO%TYPE;
    V_CICLONEW GA_ABOCEL.COD_CICLO%TYPE;
    V_PLANCOM VE_PLANCOM.COD_PLANCOM%TYPE;
    V_PLANSERV GA_ABOCEL.COD_PLANSERV%TYPE;
    V_GRPSERV GA_ABOCEL.COD_GRPSERV%TYPE;
    V_EMPRESA GA_ABOCEL.COD_EMPRESA%TYPE;
    V_HOLDING GA_ABOCEL.COD_HOLDING%TYPE;
    V_PORTADOR GA_ABOCEL.COD_CARRIER%TYPE;
    V_PROCALTA GA_ABOCEL.IND_PROCALTA%TYPE;
    V_AGENTE GA_ABOCEL.COD_VENDEDOR_AGENTE%TYPE;
    V_SUPERTEL GA_ABOCEL.IND_SUPERTEL%TYPE;
    V_TELEFIJA GA_ABOCEL.NUM_TELEFIJA%TYPE;
    V_FECALTA GA_ABOCEL.FEC_ACTCEN%TYPE;
    V_VENTA GA_ABOCEL.NUM_VENTA%TYPE;
    V_INDFACT GA_ABOCEL.IND_FACTUR%TYPE;
    V_FINCONTRA GA_ABOCEL.FEC_FINCONTRA%TYPE;
    V_OPREDFIJA GA_ABOCEL.COD_OPREDFIJA%TYPE;
    V_BAJACEN GA_ABOCEL.FEC_BAJACEN%TYPE;
    V_BAJA GA_ABOCEL.FEC_BAJACEN%TYPE;
    V_CREDMOR GA_ABOCEL.COD_CREDMOR%TYPE;
    V_USUARIO GA_ABOCEL.COD_USUARIO%TYPE;
    V_ALQUILER GA_ABORENT.NUM_ALQUILER%TYPE;
    V_MOVALTA GA_ABORENT.NUM_MOVIMIENTO%TYPE;
    V_MOVBAJA GA_ABORENT.NUM_MOVBAJA%TYPE;
    V_ORIGEN NUMBER;
    V_DESTINO NUMBER;
    V_VAR3 NUMBER;
    V_FECCICLO DATE;
    V_OPERADOR GA_ABOROACOM.COD_OPERADOR%TYPE;
    V_ROWID ROWID;
    V_OK NUMBER(1);
    V_CAPCODE GA_ABOBEEP.CAP_CODE%TYPE;
    V_BEEPER GA_ABOBEEP.NUM_BEEPER%TYPE;
    V_MAN GA_ABOTREK.NUM_MAN%TYPE;
    V_TIPSUSC GA_ABOTREK.IND_TIPSUSC%TYPE;
    V_TERMINAL GA_ABOCEL.NUM_CELULAR%TYPE;
    V_CICLFACT FA_CICLFACT.COD_CICLFACT%TYPE;
    ERROR_PROCESO EXCEPTION;
BEGIN
        V_OK := 0;
--*******************DAR DE ALTA EN INTERFASES CON ABONADO 0******
                              V_OK := 1;
                              P_DATOS_ABOCEL(VP_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                                      V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                                      V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                                      V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                                      V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                                      V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                                      V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
                                      V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                                      VP_SQLERRM,VP_ERROR);
                               V_TERMINAL := 0;
                               IF VP_ERROR <> '0' THEN
                                          VP_ERROR := '4';
                                          RAISE ERROR_PROCESO;
                               END IF;
                               VP_HOLDING := V_EMPRESA;
                               dbms_output.put_line ('alta intarcl' || VP_FECSYS);
                               VP_PROC := 'P_INTERFASES_CELULAR';
                               P_ALTA_INTARCEL(0,'A',V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                                               V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                                               0,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                                               V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                                               V_PORTADOR,V_PROCALTA,V_AGENTE,V_FECALTA,
                                               VP_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                               VP_SQLERRM,VP_ERROR);
                                       dbms_output.put_line ('XMVILLAGRAX'||': '||vp_error);
                               IF VP_ERROR <> '0' THEN
                                       VP_ERROR := '4';
                                       RAISE ERROR_PROCESO;
                               END IF;
--                             VP_PROC := 'P_INTERFASES_CELULAR';
--                             dbms_output.put_line ('alta infaccel');
--                             SELECT COD_CICLFACT INTO V_CICLFACT FROM FA_CICLFACT
--                             WHERE COD_CICLO = V_CICLO
--                             AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
--                             INSERT INTO GA_INFACCEL
--                                         (COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,
--                                          FEC_ALTA,FEC_BAJA,NUM_CELULAR,
--                                          IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
--                                          IND_DETALLE,IND_FACTUR,IND_CUOTAS,
--                                          IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,
--                                          IND_SUPERTEL)
--                                  VALUES (V_CLIENTE,0,
--                                          51198,VP_FECSYS,TO_DATE('31-12-3000','DD-MM-YYYY'),
--                                          0,1,V_FINCONTRA,0,
--                                          0,1,0,
--                                          0,0,0,
--                                          0);
--
--                             IF VP_ERROR <> '0' THEN
--                                VP_ERROR := '4';
--                                RAISE ERROR_PROCESO;
--                             END IF;
--                             VP_PROC := 'P_INTERFASES_CELULAR';
--
-- IF V_OK = 1 THEN
        --SI SE HA DADO DE ALTA ACTIVAMOS EL CICLOCLI
--        dbms_output.put_line ('ANTES de p_alta_ciclocli error: ' || VP_ERROR);
--        P_ALTA_CICLOCLI(VP_PRODUCTO,V_CLIENTE,0,V_CICLO,'A',
--                        V_AGENTE,V_CREDMOR,V_USUARIO,VP_FECSYS, VP_PROC,VP_TABLA,
--        VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
-- dbms_output.put_line ('despues de p_alta_ciclocli error: ' || VP_ERROR);
--        IF VP_ERROR <> '0' THEN
--    dbms_output.put_line ('error despues de p_alta_ciclocli: ' || VP_ERROR);
--           VP_ERROR := '4';
--           RAISE ERROR_PROCESO;
--        END IF;
--        UPDATE FA_CICLOCLI SET NUM_TERMINAL = V_TERMINAL
--        WHERE COD_CLIENTE = V_CLIENTE
--              AND COD_CICLO = V_CICLO
--              AND COD_PRODUCTO = VP_PRODUCTO
--              AND NUM_ABONADO  = 0;
--   dbms_output.put_line ('A0000');
-- VP_PROC := 'P_INTERFASES_CELULAR';
--   dbms_output.put_line ('A0001');
-- END IF;
EXCEPTION
        WHEN ERROR_PROCESO THEN
                IF VP_ERROR = '4' THEN
                        VP_SQLCODE      := SQLCODE;
                        VP_SQLERRM      := SQLERRM;
                END IF;
        WHEN OTHERS THEN
                VP_ERROR        := '4';
                VP_SQLCODE      := SQLCODE;
                VP_SQLERRM      := SQLERRM;
END;
/
SHOW ERRORS
