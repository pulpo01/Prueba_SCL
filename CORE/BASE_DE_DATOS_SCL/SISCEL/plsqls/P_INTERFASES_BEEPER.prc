CREATE OR REPLACE procedure P_INTERFASES_BEEPER
 (V_PRODUCTO IN NUMBER,
                                                 VP_ACTABO IN VARCHAR2,
                                                 V_ABONADO IN VARCHAR2,
                                                 VP_ORIGEN IN VARCHAR2,
                                                 VP_DESTINO IN VARCHAR2,
                                                 VP_VAR3 IN VARCHAR2,
                                                 V_FECSYS IN OUT DATE,
                                                 VP_PROC IN OUT VARCHAR2,
                                                 VP_TABLA IN OUT VARCHAR2,
                                                 VP_ACT IN OUT VARCHAR2,
                                                 VP_SQLCODE IN OUT VARCHAR2,
                                                 VP_SQLERRM IN OUT VARCHAR2,
                                                 V_ERROR IN OUT VARCHAR2) is
--
-- Procedimiento de actualizacion de interfases con los modulos de
-- Facturacion, Tarificacion y Ventas. Es llamado desde las pantallas del
-- modulo que realizan transaccion que afectan a estos modulos.
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
  V_CLIENTE GA_ABOCEL.COD_CLIENTE%TYPE;
  V_CLIENEW GA_ABOCEL.COD_CLIENTE%TYPE;
  V_LIMCONSUMO GA_ABOCEL.COD_LIMCONSUMO%TYPE;
  V_IMPLICONS TA_LIMCONSUMO.IMP_LIMCONSUMO%TYPE;
  V_TIPPLANTARIF GA_ABOCEL.TIP_PLANTARIF%TYPE;
  V_PLANTARIF GA_ABOCEL.COD_PLANTARIF%TYPE;
  V_CARGOBASICO GA_ABOCEL.COD_CARGOBASICO%TYPE;
  V_CICLO GA_ABOCEL.COD_CICLO%TYPE;
  V_PLANCOM VE_PLANCOM.COD_PLANCOM%TYPE;
  V_PLANSERV GA_ABOCEL.COD_PLANSERV%TYPE;
  V_GRPSERV GA_ABOCEL.COD_GRPSERV%TYPE;
  V_EMPRESA GA_ABOCEL.COD_EMPRESA%TYPE;
  V_HOLDING GA_ABOCEL.COD_HOLDING%TYPE;
  V_PROCALTA GA_ABOCEL.IND_PROCALTA%TYPE;
  V_AGENTE GA_ABOCEL.COD_VENDEDOR_AGENTE%TYPE;
  V_FECALTA GA_ABOCEL.FEC_ACTCEN%TYPE;
  V_VENTA GA_ABOCEL.NUM_VENTA%TYPE;
  V_INDFACT GA_ABOCEL.IND_FACTUR%TYPE;
  V_FINCONTRA GA_ABOCEL.FEC_FINCONTRA%TYPE;
  V_BAJACEN GA_ABOCEL.FEC_BAJACEN%TYPE;
  V_BAJA GA_ABOCEL.FEC_BAJACEN%TYPE;
  V_CREDMOR GA_ABOCEL.COD_CREDMOR%TYPE;
  V_USUARIO GA_ABOCEL.COD_USUARIO%TYPE;
  V_CAPCODE GA_ABOBEEP.CAP_CODE%TYPE;
  V_BEEPER GA_ABOBEEP.NUM_BEEPER%TYPE;
  V_CELDA GA_ABOCEL.COD_CELDA%TYPE;
  V_CICLO_CLINUEVO GA_ABOBEEP.COD_CICLO%TYPE;
  V_ORIGEN NUMBER;
  V_DESTINO NUMBER;
  V_VAR3 NUMBER;
  ERROR_PROCESO EXCEPTION;
BEGIN
  VP_PROC := 'P_INTERFASES_BEEPER';
  IF VP_ACTABO = 'AV' THEN /* aceptacion de ventas */
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     P_VALIDA_CICLO(V_CLIENTE,V_PRODUCTO,V_ABONADO,V_CICLO,V_CICLO_CLINUEVO,
     VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     V_CICLO:=V_CICLO_CLINUEVO;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_ALTA_INTARBEEP(V_ABONADO,'A',V_CLIENTE,V_IMPLICONS,
                      V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                      V_BEEPER,V_CARGOBASICO,V_CICLO,
                      V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                      V_PROCALTA,V_AGENTE,V_FECALTA,
                      V_FECSYS,VP_PROC,VP_TABLA,
                      VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_ALTA_INFACBEEP(V_ABONADO,'A',V_CLIENTE,V_BEEPER,V_CICLO,
                      V_PROCALTA,V_AGENTE,V_FECALTA,V_VENTA,
                      V_INDFACT,V_FINCONTRA,V_FECSYS,VP_PROC,VP_TABLA,
                      VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     IF V_INDFACT = 1 THEN
        P_ALTA_CICLOCLI(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'A',
                        V_AGENTE,V_CREDMOR,V_USUARIO,V_FECSYS, VP_PROC,VP_TABLA,
                        VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     ELSE
        P_ALTA_NOCICLOCLI(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'A',
                          V_AGENTE,V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                          VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     END IF;
     --VE_P_INSVENTALIN(V_PRODUCTO,V_ABONADO,0,VP_PROC,VP_TABLA,
     --                 VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     --IF V_ERROR <> '0' THEN
     --   V_ERROR := '4';
     --   RAISE ERROR_PROCESO;
     --END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_COMISION_SERVICIOS (V_PRODUCTO,V_ABONADO,VP_PROC,VP_TABLA,VP_ACT,
                           VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     IF V_TIPPLANTARIF = 'H' OR V_TIPPLANTARIF = 'E' THEN
        GA_P_PRIMERHOLDING (V_ABONADO ,V_PRODUCTO ,V_TIPPLANTARIF,V_HOLDING,
        V_FECSYS ,VP_PROC ,VP_TABLA ,VP_ACT ,VP_SQLCODE ,VP_SQLERRM ,V_ERROR );
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
     END IF;
     P_CLIENTE_CICLONUEBEEP(V_ABONADO,V_CLIENTE,1,SYSDATE,
                        VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     -- permite conocer si cliente posee cambio plan pendiente.
     P_CLIENTE_PLANNUE(V_ABONADO,V_CLIENTE,2,V_CICLO,SYSDATE,
                   V_TIPPLANTARIF,V_EMPRESA,VP_PROC,VP_TABLA,
                   VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
  ELSIF VP_ACTABO = 'RV' THEN /* rechazo de ventas */
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_ALTA_INTARBEEP(V_ABONADO,'R',V_CLIENTE,V_IMPLICONS,
                      V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                      V_BEEPER,V_CARGOBASICO,V_CICLO,
                      V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                      V_PROCALTA,V_AGENTE,V_FECALTA,
                      V_FECSYS,VP_PROC,VP_TABLA,
                      VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_ALTA_INFACBEEP(V_ABONADO,'A',V_CLIENTE,V_BEEPER,V_CICLO,
                      V_PROCALTA,V_AGENTE,V_FECALTA,V_VENTA,
                      V_INDFACT,V_FINCONTRA,V_FECSYS,VP_PROC,VP_TABLA,
                      VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     IF V_INDFACT = 1 THEN
        P_ALTA_CICLOCLI(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'R',
                        V_AGENTE,V_CREDMOR,V_USUARIO,V_FECSYS, VP_PROC,VP_TABLA,
                        VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     ELSE
        P_ALTA_NOCICLOCLI(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'R',
                          V_AGENTE,V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                          VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     END IF;
     IF V_TIPPLANTARIF = 'E' OR V_TIPPLANTARIF = 'H' THEN
        P_CAMBIO_GRUPOTAR(V_PRODUCTO,V_TIPPLANTARIF,V_EMPRESA,
                          V_HOLDING,0,VP_PROC,VP_TABLA,
                          VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     END IF;
  ELSIF VP_ACTABO = 'CB' THEN /* cambio de cargo basico */
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_CARGO_BASICO(V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_DESTINO,V_CICLO,
                    V_FECSYS,VP_ORIGEN,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
  ELSIF VP_ACTABO = 'SS' THEN
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     IF VP_ORIGEN = '1' THEN /* cambio en friends */
        V_DESTINO := TO_NUMBER(VP_DESTINO);
        P_MODIF_FRIENDS(V_CLIENTE,V_ABONADO,V_DESTINO,V_FECSYS,VP_PROC,
                        VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     ELSIF VP_ORIGEN = '2' THEN /* cambio en dias especiales */
        V_DESTINO := TO_NUMBER(VP_DESTINO);
        P_MODIF_DIASESP(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_DESTINO,
                        V_FECSYS,VP_PROC,VP_TABLA,
                        VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     ELSIF VP_ORIGEN = '3' THEN /* cambio de detalle */
        V_DESTINO := TO_NUMBER(VP_DESTINO);
        P_MODIF_DETALLE(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_DESTINO,
                        V_FECSYS,V_CICLO,VP_PROC,VP_TABLA,
                        VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     END IF;
  ELSIF VP_ACTABO = 'CT' THEN /* cambio de plan tarifario */
     V_VAR3 := TO_NUMBER(VP_VAR3);
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_PLAN_TARIFARIO(V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_ORIGEN,
                      VP_DESTINO,V_CICLO,V_FECSYS,V_EMPRESA,
                      V_HOLDING,V_TIPPLANTARIF,V_VAR3,VP_PROC,VP_TABLA,
                      VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
   ELSIF VP_ACTABO = 'PI' THEN /* cambio de plan tarifario inmediato */
       V_VAR3 := TO_NUMBER(VP_VAR3);
       P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
       IF V_ERROR <> '0' THEN
          V_ERROR := '4';
          RAISE ERROR_PROCESO;
       END IF;
       VP_PROC := 'P_INTERFASES_CELULAR';
       GA_P_CAMBIO_PLANTARIF2(V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_ORIGEN,
                        V_CICLO, TO_NUMBER(VP_DESTINO), V_FECSYS, VP_PROC, VP_TABLA,VP_ACT,VP_SQLCODE,
          VP_SQLERRM,V_ERROR);
       IF V_ERROR <> '0' THEN
          V_ERROR := '4';
          RAISE ERROR_PROCESO;
       END IF;
       VP_PROC := 'P_INTERFASES_CELULAR';
  ELSIF VP_ACTABO = 'CL' THEN /* cambio de limite consumo */
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_LIMITE_CONSUMO(V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_ORIGEN,
                      V_FECSYS,VP_PROC,VP_TABLA,
                      VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
  ELSIF VP_ACTABO = 'CE' THEN /* cambio de serie */
     V_VAR3 := TO_NUMBER(VP_VAR3);
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_CAMBIO_SERIE(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_VAR3,VP_DESTINO,
                    V_CICLO,V_FECSYS,VP_PROC,VP_TABLA,
                    VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     --VP_PROC := 'P_INTERFASES_BEEPER';
     --VE_P_INSVENTALIN(V_PRODUCTO,V_ABONADO,0,VP_PROC,VP_TABLA,VP_ACT,
     --                 VP_SQLCODE,VP_SQLERRM,V_ERROR);
     --IF V_ERROR <> '0' THEN
     --   V_ERROR := '4';
     --   RAISE ERROR_PROCESO;
     --END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
  ELSIF VP_ACTABO = 'CG' THEN /* cambio de grupo cobro servicios */
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_CAMBIO_GRPSERV (V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_ORIGEN,
                       V_CICLO,V_FECSYS,VP_PROC,VP_TABLA,
                       VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
  ELSIF VP_ACTABO = 'CS' THEN /* cambio de plan de servicios */
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_CAMBIO_PLANSERV (V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_ORIGEN,
                        V_CICLO,V_FECSYS,VP_PROC,VP_TABLA,
                        VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
  ELSIF VP_ACTABO = 'CC' THEN /* cambio de ciclo de facturacion */
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     V_ORIGEN := TO_NUMBER(VP_ORIGEN);
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_CAMBIO_CICLO (V_PRODUCTO,V_CLIENTE,V_ABONADO,V_ORIGEN,
                     V_CICLO,V_FECSYS,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     IF V_INDFACT = 1 THEN
        P_ACTUALIZA_CICLOCLI (V_ABONADO,V_ORIGEN,VP_PROC,VP_TABLA,
                              VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     ELSE
        P_ACTUALIZA_NOCICLOCLI (V_ABONADO,V_ORIGEN,VP_PROC,VP_TABLA,
                                VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     END IF;
  ELSIF VP_ACTABO = 'CM' THEN /* Cambio de Credito Morosidad */
     V_ORIGEN := TO_NUMBER(VP_ORIGEN);
     P_CREDITO_MOROSIDAD (V_ABONADO,V_ORIGEN,VP_PROC,VP_TABLA,
                          VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
  ELSIF VP_ACTABO = 'IF' THEN /* cambio de indicador de facturable */
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     V_ORIGEN := TO_NUMBER(VP_ORIGEN);
     P_INDICADOR_FACTURABLE (V_PRODUCTO,V_CLIENTE,V_ABONADO,V_ORIGEN,
                             V_CICLO,V_FECSYS,VP_PROC,VP_TABLA,
                             VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     IF VP_ORIGEN = '1' THEN
        P_ALTA_CICLOCLI(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'A',
                        V_AGENTE,V_CREDMOR,V_USUARIO,V_FECALTA, VP_PROC,VP_TABLA,
                        VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
        P_BORRA_NOCICLOCLI(V_ABONADO,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                           VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     ELSE
        P_ALTA_NOCICLOCLI(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'A',
                          V_AGENTE,V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                          VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
        P_BORRA_CICLOCLI(V_ABONADO,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                         VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     END IF;
  ELSIF VP_ACTABO = 'TA' THEN /* Traspaso de Abonados */
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     V_ORIGEN := TO_NUMBER(VP_ORIGEN);
     V_DESTINO := TO_NUMBER(VP_DESTINO);
     P_TRASPASO_INTARXXX (V_PRODUCTO,V_CLIENTE,V_ABONADO,V_ORIGEN,
                          V_CICLO,V_FECSYS,V_CLIENEW,VP_PROC,VP_TABLA,
                          VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_TRASPASO_INFACXXX (V_PRODUCTO,V_CLIENTE,V_ABONADO,V_ORIGEN,
                          V_CICLO,V_FECSYS,V_CLIENEW,VP_PROC,VP_TABLA,
                          VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_OBTIENE_CICLO(V_ORIGEN,V_PRODUCTO,V_CICLO,V_INDFACT,V_ERROR);
     IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
     END IF;
     IF V_INDFACT = 1 THEN
        P_ALTA_CICLOCLI(V_PRODUCTO,V_CLIENEW,V_ORIGEN,V_CICLO,'A',
        V_AGENTE,V_CREDMOR,V_USUARIO,V_FECALTA, VP_PROC,VP_TABLA,
        VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     ELSE
        P_ALTA_NOCICLOCLI(V_PRODUCTO,V_CLIENEW,V_ORIGEN,V_CICLO,'A',
                          V_AGENTE,V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                          VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     END IF;
  ELSIF VP_ACTABO = 'CN' THEN /* Cambio de Numero de beeper */
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_PRIMER_NUMERO (V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_DESTINO,
                      V_CICLO,V_CELDA,V_FECSYS,VP_PROC,VP_TABLA,
                      VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
  ELSIF VP_ACTABO = 'BA' THEN /* Baja de Abonado */
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_BAJA_ABONADO (V_PRODUCTO,V_CLIENTE,V_ABONADO,
                     V_CICLO,V_FECSYS,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     IF V_TIPPLANTARIF = 'E' OR V_TIPPLANTARIF = 'H' THEN
        P_CAMBIO_GRUPOTAR(V_PRODUCTO,V_TIPPLANTARIF,V_EMPRESA,
                          V_HOLDING,'0',VP_PROC,VP_TABLA,
                          VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     END IF;
     VE_P_INSRENUNCIAS (V_ABONADO,V_VENTA,1,VP_PROC,VP_TABLA,VP_ACT,
                        VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     /*P_MODIFICA_NUMPROCESO (V_ABONADO,VP_PROC,VP_TABLA,VP_ACT,
                            VP_SQLCODE,VP_SQLERRM,V_ERROR);
       IF V_ERROR <> '0' THEN
          V_ERROR := '4';
          RAISE ERROR_PROCESO;
       END IF;
       IF V_TIPPLANTARIF = 'H'  THEN
          GA_P_ULTIMOHOLDING (V_ABONADO , V_PRODUCTO , V_TIPPLANTARIF, V_HOLDING,
                              VP_PROC, VP_TABLA, VP_ACT, VP_SQLCODE, VP_SQLERRM,V_ERROR );
          IF V_ERROR <> '0' THEN
             V_ERROR := '4';
             RAISE ERROR_PROCESO;
          END IF;
       ELSIF V_TIPPLANTARIF = 'E' THEN
          GA_P_ULTIMOHOLDING (V_ABONADO , V_PRODUCTO , V_TIPPLANTARIF, V_EMPRESA,
                              VP_PROC, VP_TABLA, VP_ACT, VP_SQLCODE, VP_SQLERRM,V_ERROR );
          IF V_ERROR <> '0' THEN
             V_ERROR := '4';
             RAISE ERROR_PROCESO;
          END IF;
       END IF;
     */
     VP_PROC := 'P_INTERFASES_BEEPER';
  ELSIF VP_ACTABO = 'LA' THEN /* Liquidacion de Abonados */
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_LIQUIDA_ABONADO (V_PRODUCTO,V_CLIENTE,V_ABONADO,V_FECSYS,
                        VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                        VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_MODIFICA_NUMPROCESO (V_ABONADO,VP_PROC,VP_TABLA,VP_ACT,
                            VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
  ELSIF VP_ACTABO = 'AB' THEN /* Anulacion de baja de Abonados */
     P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,V_CICLO,
                     V_PLANSERV,V_GRPSERV,V_EMPRESA,
                     V_HOLDING,V_PROCALTA,V_AGENTE,
                     V_FECALTA,V_VENTA,V_INDFACT,
                     V_FINCONTRA,V_BAJACEN,V_BAJA,
                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     P_ANULA_BAJAABO(V_PRODUCTO,V_CLIENTE,V_ABONADO,
                     V_BAJACEN,V_BAJA,V_FECSYS,
                     V_GRPSERV,V_CICLO,VP_PROC,VP_TABLA,
                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     IF V_TIPPLANTARIF = 'E' OR V_TIPPLANTARIF = 'H' THEN
        P_CAMBIO_GRUPOTAR(V_PRODUCTO,V_TIPPLANTARIF,V_EMPRESA,
                          V_HOLDING,'1',VP_PROC,VP_TABLA,
                          VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF V_ERROR <> '0' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;
        VP_PROC := 'P_INTERFASES_BEEPER';
     END IF;
     VE_P_INSRENUNCIAS (V_ABONADO,V_VENTA,0,VP_PROC,VP_TABLA,VP_ACT,
                        VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     IF V_TIPPLANTARIF = 'H' OR V_TIPPLANTARIF = 'E' THEN
                GA_P_PRIMERHOLDING (V_ABONADO ,
                                                V_PRODUCTO,
                                                V_TIPPLANTARIF,
                                                V_HOLDING ,
                                                V_FECSYS ,
                                                VP_PROC ,
                                                VP_TABLA,
                                                VP_ACT ,
                                                VP_SQLCODE ,
                                                VP_SQLERRM ,
                                                V_ERROR );
                IF V_ERROR <> '0' THEN
                        V_ERROR := '4';
                        RAISE ERROR_PROCESO;
                END IF;
        END IF;
  ELSIF VP_ACTABO = 'HO' THEN /* Cambio plan tarifario o ciclo en holding */
     V_DESTINO := TO_NUMBER(VP_DESTINO);
     --P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
     --                V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
     --                V_BEEPER,V_CARGOBASICO,V_CICLO,
     --                V_PLANSERV,V_GRPSERV,V_EMPRESA,
--                     V_HOLDING,V_PROCALTA,V_AGENTE,
 --                    V_FECALTA,V_VENTA,V_INDFACT,
   --                  V_FINCONTRA,V_BAJACEN,V_BAJA,
--                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
--                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
--     IF V_ERROR <> '0' THEN
 --       V_ERROR := '4';
  --      RAISE ERROR_PROCESO;
   --  END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     --P_MODIFICA_HOLDING(V_PRODUCTO,V_ABONADO,VP_ORIGEN,V_DESTINO,
--                        V_FECSYS,VP_PROC,VP_TABLA,
--                        VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF VP_VAR3 = 'I' THEN
                               --PLANTARIFARIO INMEDIATO
                GA_P_MODIFICA_PTHINMEDIATO(V_PRODUCTO,V_ABONADO,VP_ORIGEN,V_FECSYS,
                VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                VP_SQLERRM,V_ERROR) ;
        ELSE
             P_MODIFICA_HOLDING(V_PRODUCTO,V_ABONADO,VP_ORIGEN,V_DESTINO,
             V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
             VP_SQLERRM,V_ERROR);
        END IF;
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
  ELSIF VP_ACTABO = 'EM' THEN /* Cambio plan tarifario o ciclo en empresa */
     V_DESTINO := TO_NUMBER(VP_DESTINO);
     --P_DATOS_ABOBEEP(V_ABONADO,V_CLIENTE,V_IMPLICONS,
     --                V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
     --                V_BEEPER,V_CARGOBASICO,V_CICLO,
     --                V_PLANSERV,V_GRPSERV,V_EMPRESA,
--                     V_HOLDING,V_PROCALTA,V_AGENTE,
  --                   V_FECALTA,V_VENTA,V_INDFACT,
    --                 V_FINCONTRA,V_BAJACEN,V_BAJA,
--                     V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
--                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
     --P_MODIFICA_EMPRESA(V_PRODUCTO,V_ABONADO,VP_ORIGEN,V_DESTINO,
--                        V_FECSYS,VP_PROC,VP_TABLA,
--                        VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
        IF VP_VAR3 = 'I' THEN
--PLANTARIFARIO INMEDIATO
                GA_P_MODIFICA_PTEINMEDIATO(V_PRODUCTO,V_ABONADO,VP_ORIGEN,V_FECSYS,
                VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
               VP_SQLERRM,V_ERROR        ) ;
        ELSE
             P_MODIFICA_EMPRESA(V_PRODUCTO,V_ABONADO,VP_ORIGEN,V_DESTINO,
             V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
             VP_SQLERRM,V_ERROR);
        END IF;
     IF V_ERROR <> '0' THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'P_INTERFASES_BEEPER';
  END IF;
EXCEPTION
   WHEN ERROR_PROCESO THEN
        V_ERROR := '4';
   WHEN OTHERS THEN
        VP_SQLCODE := SQLCODE;
        VP_SQLERRM := SQLERRM;
        V_ERROR := '4';
END;
/
SHOW ERRORS
