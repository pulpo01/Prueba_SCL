CREATE OR REPLACE PROCEDURE P_Interfases_Celular
(
  V_PRODUCTO IN NUMBER ,
  VP_ACTABO IN VARCHAR2 ,
  V_ABONADO IN OUT NUMBER ,
  VP_ORIGEN IN VARCHAR2 ,
  VP_DESTINO IN VARCHAR2 ,
  VP_VAR3 IN VARCHAR2 ,
  V_FECSYS IN OUT DATE ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  V_ERROR IN OUT VARCHAR2,
  VP_VAR7 IN VARCHAR2 := NULL)
IS
--
-- *************************************************************
-- * procedimiento      : P_Interfases_Celular
-- * Descripcisn        : Procedimiento de actualizacion de interfases con los modulos de
-- *                      Facturacion, Tarificacion y Ventas. Es llamado desde las pantallas del
-- *                      modulo que realizan transaccion que afectan a estos modulos.
-- * Fecha de creacisn  :
-- * Responsable        : CRM
      --            Los posibles retornos del procedimiento son :
      --                - '0' Actualizaciones realizadas correctamente
      --                - '4' Error en el proceso
-- *************************************************************

--P_Interfases_Celular, v1.1 / RA-200512260395: German Espinoza Z; 02/03/2006
--P_Interfases_Celular, v1.2 //COL-72424|03-11-2008|GEZ
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
        V_CICLO_DES GA_ABOCEL.COD_CICLO%TYPE;
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
        V_GRUPO GA_ABOCEL.COD_EMPRESA%TYPE;
        V_EMP NUMBER;
        V_CICLO_CLINUEVO GA_ABOCEL.COD_CICLO%TYPE;
        V_CELULAR_ORIG GA_ABOROAVIS.NUM_CELUROPER%TYPE;
                V_CELULAR_ORIG_COM GA_ABOROACOM.NUM_CELULAR%TYPE;
                V_CELULAR_ABO_COM GA_ABOROACOM.NUM_ABONADOCEL%TYPE;
        ERROR_PROCESO EXCEPTION;
                ERROR_FDO     EXCEPTION;

                /* Variables de salida para PV_LIMITE_CONSUMO_PG.PV_OPERA_LIMITE_PR */
                PvCodValor              VARCHAR2(50);
                pvErrorGlosa    VARCHAR2(250);
                pvTrace                 VARCHAR2(250);
                /* Fin Variables de salida para V_LIMITE_CONSUMO_PG.PV_OPERA_LIMITE_PR */

   LV_des_error    ge_errores_pg.DesEvent;
   LV_sSql         ge_errores_pg.vQuery;
   SN_num_evento   ge_errores_pg.evento;
   SV_mens_retorno ge_errores_td.det_msgerror%TYPE;
   
   LV_COD_COLOR    GE_CLIENTES.COD_COLOR%TYPE;
   LV_COD_SEGMENTO GE_CLIENTES.COD_SEGMENTO%TYPE;
   LN_IMP_LIMCON   TOL_LIMITE_PLAN_TD.MTO_CONS%TYPE;
   LV_NUM_ABONADO  GA_LCABO_TO.NUM_ABONADO%TYPE;
                


BEGIN
        VP_PROC := 'P_INTERFASES_CELULAR';
        DBMS_OUTPUT.put_line ('VP_ACTABO :' || VP_ACTABO);
        IF VP_ACTABO = 'AV' THEN /* aceptacion de ventas */



           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           P_Valida_Ciclo(V_CLIENTE,V_PRODUCTO,V_ABONADO,V_CICLO,
           V_CICLO_CLINUEVO,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
           VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           V_CICLO:=V_CICLO_CLINUEVO;
           VP_PROC := 'P_INTERFASES_CELULAR';
                   P_Alta_Intarcel(V_ABONADO,'A',V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                           V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                           V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                           V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                           V_PORTADOR,V_PROCALTA,V_AGENTE,V_FECALTA,
                           V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
             VP_SQLERRM,V_ERROR, VP_VAR7, VP_ACTABO);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
                   IF VP_VAR3 ='PV_PT' THEN
                      V_FECALTA:= V_FECSYS;
                   END IF;
           P_Alta_Infaccel(V_ABONADO,'A',V_CLIENTE,V_CELULAR,V_CICLO,
                           V_PROCALTA,V_AGENTE,V_SUPERTEL,V_TELEFIJA,
                           V_FECALTA,V_VENTA,V_INDFACT,V_FINCONTRA,
                           V_FECSYS,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE
                           ,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           IF V_INDFACT = 1 THEN
              P_Alta_Ciclocli(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'A',
                              V_AGENTE,V_CREDMOR,V_USUARIO,V_FECSYS, VP_PROC,VP_TABLA,
              VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           ELSE
              P_Alta_Ciclocli(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'A',
                              V_AGENTE,V_CREDMOR,V_USUARIO,V_FECSYS, VP_PROC,VP_TABLA,
                              VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
              P_Alta_Nociclocli(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'A',
              V_AGENTE,V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
              VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           END IF;
           /* VE_P_INSVENTALIN(V_PRODUCTO,V_ABONADO,0,VP_PROC,VP_TABLA,VP_ACT,
              VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF; */
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Comision_Servicios (V_PRODUCTO,V_ABONADO,VP_PROC,VP_TABLA,VP_ACT,
            VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           BEGIN
                   SELECT COD_EMPRESA INTO V_GRUPO FROM GA_EMPRESA
                   WHERE COD_CLIENTE = V_CLIENTE;
                   EXCEPTION
                           WHEN NO_DATA_FOUND THEN
                                V_GRUPO := NULL;
           END;
           /*IF V_TIPPLANTARIF = 'H' OR V_TIPPLANTARIF = 'E' THEN
              Ga_P_Primerholding (V_ABONADO ,
                                        V_PRODUCTO,
                                        V_TIPPLANTARIF,
                                        V_GRUPO,
                                        V_FECSYS,
                                        VP_PROC,
                                        VP_TABLA,
                                        VP_ACT ,
                                        VP_SQLCODE,
                                        VP_SQLERRM,
                                        V_ERROR,
                                        VP_ACTABO);
                    IF V_ERROR <> '0' THEN
                            V_ERROR := '4';
                            RAISE ERROR_PROCESO;
                    END IF;
            END IF;*/
            -- permite conocer si cliente posee cambio ciclo pendiente
            P_Cliente_Ciclonue(V_ABONADO,V_CLIENTE,1,SYSDATE,
                               VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                               VP_SQLERRM,V_ERROR);

            IF V_ERROR <> '0' THEN
               V_ERROR := '4';
               RAISE ERROR_PROCESO;
            END IF;
            -- permite conocer si cliente posee cambio plan pendiente.
            P_Cliente_Plannue(V_ABONADO,V_CLIENTE,1,V_CICLO,SYSDATE,
                              V_TIPPLANTARIF,V_EMPRESA,VP_PROC,VP_TABLA,
                              VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

            IF V_ERROR <> '0' THEN
               V_ERROR := '4';
               RAISE ERROR_PROCESO;
            END IF;
        ELSIF VP_ACTABO = 'RV' THEN /* rechazo de ventas */
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Alta_Intarcel(V_ABONADO,'R',V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                           V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                           V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                           V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                           V_PORTADOR,V_PROCALTA,V_AGENTE,V_FECALTA,
                           V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                           VP_SQLERRM,V_ERROR,VP_ACTABO);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Alta_Infaccel(V_ABONADO,'R',V_CLIENTE,V_CELULAR,V_CICLO,
                           V_PROCALTA,V_AGENTE,V_SUPERTEL,V_TELEFIJA,
                           V_FECALTA,V_VENTA,V_INDFACT,V_FINCONTRA,
                           V_FECSYS,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE
    ,
                    VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           IF V_INDFACT = 1 THEN
              P_Alta_Ciclocli(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'R',
                              V_AGENTE,V_CREDMOR,V_USUARIO,V_FECSYS, VP_PROC
    ,VP_TABLA,
         VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           ELSE
              P_Alta_Ciclocli(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'R',
                              V_AGENTE,V_CREDMOR,V_USUARIO,V_FECSYS, VP_PROC,VP_TABLA,
                              VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
              P_Alta_Nociclocli(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'R',
                                V_AGENTE,V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                                VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           END IF;
           IF V_TIPPLANTARIF = 'E' OR V_TIPPLANTARIF = 'H' THEN
              P_Cambio_Grupotar(V_PRODUCTO,V_TIPPLANTARIF,V_EMPRESA,
           V_HOLDING,0,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
           VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           END IF;
        ELSIF VP_ACTABO = 'CB' THEN /* cambio de cargo basico */
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Cargo_Basico(V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_DESTINO,V_CICLO,
                       V_FECSYS,VP_ORIGEN,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'SS' THEN
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           IF VP_ORIGEN = '1' THEN /* cambio en friends */
       V_DESTINO := TO_NUMBER(VP_DESTINO);
              P_Modif_Friends(V_CLIENTE,V_ABONADO,V_DESTINO,V_FECSYS,
         VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
       VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           ELSIF VP_ORIGEN = '2' THEN /* cambio en dias especiales */
       V_DESTINO := TO_NUMBER(VP_DESTINO);
              P_Modif_Diasesp(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_DESTINO,
                              V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
         VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           ELSIF VP_ORIGEN = '3' THEN /* cambio de detalle */
       V_DESTINO := TO_NUMBER(VP_DESTINO);
              P_Modif_Detalle(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_DESTINO,
                              V_FECSYS,V_CICLO,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE
    ,
         VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           END IF;
        ELSIF VP_ACTABO = 'CT' THEN /* cambio de plan tarifario */
           V_VAR3 := TO_NUMBER(VP_VAR3);
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Plan_Tarifario(V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_ORIGEN,
                            VP_DESTINO,V_CICLO,V_FECSYS,V_EMPRESA,
                            V_HOLDING,V_TIPPLANTARIF,V_VAR3,VP_PROC,
              VP_TABLA,VP_ACT,VP_SQLCODE,
              VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
       ELSIF VP_ACTABO = 'PI' OR VP_ACTABO = 'PT' THEN /* cambio de plan tarifario inmediato */
           V_VAR3 := TO_NUMBER(VP_VAR3);
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           Ga_P_Cambio_Plantarif2(V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_ORIGEN,
                            V_CICLO, TO_NUMBER(VP_DESTINO), V_FECSYS, VP_PROC
    , VP_TABLA,VP_ACT,VP_SQLCODE,
              VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'CL' THEN
        DBMS_OUTPUT.put_line ('VP_ACTABO :' || VP_ACTABO);
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
            DBMS_OUTPUT.put_line ('V_ERROR:' || V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           DBMS_OUTPUT.put_line ('VP_PROC:' || VP_PROC);
           P_Limite_Consumo(V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_ORIGEN,
                            V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                     VP_SQLERRM,V_ERROR);
           DBMS_OUTPUT.put_line ('V_ERROR:' || V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'CE' OR VP_ACTABO = 'GT' OR VP_ACTABO = 'TG' OR VP_ACTABO = 'ET' OR VP_ACTABO = 'EG' OR VP_ACTABO = 'SA' THEN /* cambio de serie */
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Cambio_Serie(V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_ORIGEN,VP_DESTINO,
                          V_CICLO,V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           /* VP_PROC := 'P_INTERFASES_CELULAR';
           VE_P_INSVENTALIN(V_PRODUCTO,V_ABONADO,0,VP_PROC,VP_TABLA,VP_ACT,
              VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;*/
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'CP' THEN /* cambio de portador */
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           P_Cambio_Portador(V_CLIENTE,V_ABONADO,V_ORIGEN,V_FECSYS,VP_PROC,
               VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'CG' THEN /* cambio de grupo cobro servicios */
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Cambio_Grpserv (V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_ORIGEN,
                             V_CICLO,V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
               VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'CS' THEN /* cambio de plan de servicios */
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Cambio_Planserv (V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_ORIGEN,
                              V_CICLO,V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE
    ,
         VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'CC' THEN /* cambio de ciclo de facturacion */
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           P_Cambio_Ciclo (V_PRODUCTO,V_CLIENTE,V_ABONADO,V_ORIGEN,
                           V_CICLO,V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                    VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           IF V_INDFACT = 1 THEN
              P_Actualiza_Ciclocli (V_ABONADO,V_ORIGEN,VP_PROC,VP_TABLA,
               VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           ELSE
              P_Actualiza_Nociclocli (V_ABONADO,V_ORIGEN,VP_PROC,VP_TABLA,
                 VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           END IF;
           P_Valida_Roaming (V_ABONADO,V_ORIGEN,V_CICLO,VP_PROC,VP_TABLA,
               VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'CM' THEN /* Cambio de Credito Morosidad */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           P_Credito_Morosidad (V_ABONADO,V_ORIGEN,VP_PROC,VP_TABLA,
           VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'NS' THEN /* cambio de numero de supertelefono */
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           V_VAR3 := TO_NUMBER(VP_VAR3);
                      P_Numero_Supertelciclo (V_CLIENTE,V_ABONADO,VP_ORIGEN,V_VAR3, VP_DESTINO
                    ,V_CICLO,V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE, VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'IF' THEN /* cambio de indicador de facturable */
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           P_Indicador_Facturable (V_PRODUCTO,V_CLIENTE,V_ABONADO,V_ORIGEN,
                                   V_CICLO,V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,
              VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           IF VP_ORIGEN = '1' THEN
              P_Alta_Ciclocli(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'A',
              V_AGENTE,V_CREDMOR,V_USUARIO,V_FECALTA, VP_PROC,VP_TABLA,
              VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
              P_Borra_Nociclocli(V_ABONADO,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                          VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           ELSE
              P_Alta_Ciclocli(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'A',
              V_AGENTE,V_CREDMOR,V_USUARIO,V_FECALTA, VP_PROC,VP_TABLA,
              VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
              P_Alta_Nociclocli(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_CICLO,'A',
                                V_AGENTE,V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                                VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
              P_Borra_Ciclocli(V_ABONADO,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                        VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           END IF;
        ELSIF VP_ACTABO = 'TA' THEN /* Traspaso de Abonados */
         IF VP_VAR3 IS NULL THEN
            P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                           V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                           V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                           V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                           V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                           V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                           V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
                           V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,
                           VP_SQLCODE, VP_SQLERRM,V_ERROR);
            IF V_ERROR <> '0' THEN
                V_ERROR := '4';
                RAISE ERROR_PROCESO;
            END IF;
            VP_PROC := 'P_INTERFASES_CELULAR';
            V_ORIGEN := TO_NUMBER(VP_ORIGEN);
            V_DESTINO := TO_NUMBER(VP_DESTINO);
            P_Traspaso_Intarxxx (V_PRODUCTO,V_CLIENTE,V_ABONADO,V_ORIGEN,
                                  V_CICLO,V_FECSYS,V_CLIENEW,VP_PROC,VP_TABLA,
                                  VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
            IF V_ERROR <> '0' THEN
                V_ERROR := '4';
                RAISE ERROR_PROCESO;
            END IF;
            VP_PROC := 'P_INTERFASES_CELULAR';
            P_Traspaso_Infacxxx (V_PRODUCTO,V_CLIENTE,V_ABONADO,V_ORIGEN,
                                  V_CICLO,V_FECSYS,V_CLIENEW,VP_PROC,VP_TABLA,
                                  VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
            IF V_ERROR <> '0' THEN
               V_ERROR := '4';
                RAISE ERROR_PROCESO;
            END IF;
            VP_PROC := 'P_INTERFASES_CELULAR';
            P_Baja_Sertras(V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_PROC,
                            VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
            IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
            END IF;
            P_Obtiene_Ciclo(V_ORIGEN,V_PRODUCTO,V_CICLO,V_INDFACT,V_ERROR);
            IF V_ERROR <> '0' THEN
                   V_ERROR := '4';
                   RAISE ERROR_PROCESO;
            END IF;
            IF V_INDFACT = 1 THEN
               P_Alta_Ciclocli(V_PRODUCTO,V_CLIENEW,V_ORIGEN,V_CICLO,'A',
                                V_AGENTE,V_CREDMOR,V_USUARIO,V_FECSYS, VP_PROC,
                                VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
               IF V_ERROR <> '0' THEN
                   V_ERROR := '4';
                   RAISE ERROR_PROCESO;
               END IF;
               VP_PROC := 'P_INTERFASES_CELULAR';
             ELSE
                P_Alta_Ciclocli(V_PRODUCTO,V_CLIENEW,V_ORIGEN,V_CICLO,'A',
                                V_AGENTE,V_CREDMOR,V_USUARIO,V_FECSYS, VP_PROC,
                                VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
                P_Alta_Nociclocli(V_PRODUCTO,V_CLIENEW,V_ORIGEN,V_CICLO,'A',
                                  V_AGENTE,V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
                IF V_ERROR <> '0' THEN
                   V_ERROR := '4';
                   RAISE ERROR_PROCESO;
                END IF;
                VP_PROC := 'P_INTERFASES_CELULAR';
             END IF;
             VP_PROC := 'P_INTERFASES_CELULAR';
             BEGIN
                    V_EMP := 1;
                    VP_TABLA := 'GA_EMPRESA';
                    VP_ACT := 'S';
                    SELECT COD_EMPRESA  INTO V_GRUPO
                    FROM GA_EMPRESA
                    WHERE COD_CLIENTE = V_CLIENEW;
             EXCEPTION
                       WHEN NO_DATA_FOUND THEN
                       V_EMP := 0;
                       WHEN OTHERS THEN
                            V_ERROR := '4';
                       RAISE ERROR_PROCESO;
             END;
             IF V_EMP = 1 THEN
                Ga_P_Primerholding(V_ORIGEN, V_PRODUCTO, 'E', V_GRUPO,
                                      V_FECSYS, VP_PROC, VP_TABLA, VP_ACT,
                                      VP_SQLCODE, VP_SQLERRM, V_ERROR, VP_ACTABO);
                IF V_ERROR <> '0' THEN
                      V_ERROR := 4;
                      RAISE ERROR_PROCESO;
                END IF;
             END IF;
             BEGIN
                V_EMP := 1;
                VP_TABLA := 'GA_EMPRESA';
                VP_ACT := 'S';
                SELECT COD_EMPRESA  INTO V_GRUPO
                FROM GA_EMPRESA
                WHERE COD_CLIENTE = V_CLIENTE;
             EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    V_EMP := 0;
                WHEN OTHERS THEN
                    V_ERROR := '4';
                    RAISE ERROR_PROCESO;
             END;
             IF V_EMP = 1 THEN
                Ga_P_Ultimoholding (V_ABONADO,V_PRODUCTO,V_TIPPLANTARIF
                      ,V_EMPRESA,VP_PROC,VP_TABLA,VP_ACT,'T',VP_SQLCODE
                                       ,VP_SQLERRM,V_ERROR );
                IF V_ERROR <> '0' THEN
                   V_ERROR := '4';
                   RAISE ERROR_PROCESO;
                END IF;
             END IF;
           ELSE
             --TRASPASO DE ABONADO SUPERTELEFONO
             Ga_P_Traspaso_Stm(VP_VAR3, VP_DESTINO, VP_ORIGEN, V_ABONADO,
             VP_PROC, VP_TABLA, VP_ACT, VP_SQLCODE, VP_SQLERRM, V_ERROR);
             IF V_ERROR <> '0' THEN
                  V_ERROR := '4';
                  RAISE ERROR_PROCESO;
             END IF;
             VP_PROC := 'P_INTERFASES_CELULAR';
          END IF;
          P_Actualiza_Cargos_Baja(V_CLIENTE,V_ABONADO,V_CICLO,VP_PROC,
          VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
          IF V_ERROR <> '0' THEN
            V_ERROR := '4';
            RAISE ERROR_PROCESO;
          END IF;
      -- Valida si cliente posee cambio de ciclo pendiente
          P_Cliente_Ciclonue(V_ORIGEN,V_CLIENEW,1,SYSDATE,VP_PROC,
          VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
          IF V_ERROR <> '0' THEN
             V_ERROR := '4';
             RAISE ERROR_PROCESO;
          END IF;
      -- Valida si cliente empresa posee cambio de plan pendiente
          BEGIN
            V_EMP := 1;
            VP_TABLA := 'GA_EMPRESA';
            VP_ACT := 'S';
            SELECT COD_EMPRESA  INTO V_GRUPO
            FROM GA_EMPRESA
            WHERE COD_CLIENTE = V_CLIENEW;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
               V_EMP := 0;
            WHEN OTHERS THEN
                V_ERROR := '4';
           RAISE ERROR_PROCESO;
          END;
          IF V_EMP=1 THEN
           BEGIN
              SELECT COD_CICLO,TIP_PLANTARIF,COD_EMPRESA
              INTO V_CICLO,V_TIPPLANTARIF,V_EMPRESA
              FROM GA_ABOCEL
              WHERE NUM_ABONADO=V_ORIGEN;
           EXCEPTION
              WHEN OTHERS THEN
                V_ERROR := '4';
               RAISE ERROR_PROCESO;
           END;
           P_Cliente_Plannue(V_ORIGEN,V_CLIENEW,1,V_CICLO,SYSDATE,
           V_TIPPLANTARIF,V_EMPRESA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
           VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
             V_ERROR := '4';
             RAISE ERROR_PROCESO;
           END IF;
         END IF;

--OCB-INI
        ELSIF VP_ACTABO = 'TP' OR VP_ACTABO = 'T2'  THEN /* Traspaso de Abonados */
                 IF VP_VAR3 IS NULL THEN
                    P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                                   V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                                   V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                                   V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                                   V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                                   V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                                   V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
                                   V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,
                                   VP_SQLCODE, VP_SQLERRM,V_ERROR);


                    IF V_ERROR <> '0' THEN
                        V_ERROR := '4';
                        RAISE ERROR_PROCESO;
                    END IF;
                    VP_PROC := 'P_INTERFASES_CELULAR';
                    V_ORIGEN := TO_NUMBER(VP_ORIGEN);   /* CLIENTE DESTINO */
                    V_DESTINO := TO_NUMBER(VP_DESTINO); /* CLIENTE ORIGEN*/
                    --RAISE ERROR_FDO;
                    Pv_Traspasopropiedadintar_Pr (V_PRODUCTO,V_DESTINO,V_ABONADO,V_ORIGEN,
                                                  V_CICLO,SYSDATE,V_CLIENEW,VP_PROC,VP_TABLA,
                                                  VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

                    IF V_ERROR <> '0' THEN
                        V_ERROR := '4';
                        RAISE ERROR_PROCESO;
                    END IF;


                    VP_PROC := 'P_INTERFASES_CELULAR';

                    Pv_Traspasopropiedadinfac_Pr (V_PRODUCTO,V_DESTINO,V_ABONADO,V_ORIGEN,
                                                  V_CICLO,SYSDATE,VP_PROC,VP_TABLA,
                                                  VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

                    IF V_ERROR <> '0' THEN
                       V_ERROR := '4';
                        RAISE ERROR_PROCESO;
                    END IF;


                     Pv_Altabajasertras_Pr  (V_PRODUCTO,V_ABONADO,VP_PROC,
                                             VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

                     IF V_ERROR <> '0' THEN
                            V_ERROR := '4';
                            RAISE ERROR_PROCESO;
                     END IF;



                    VP_PROC := 'P_INTERFASES_CELULAR';

                    P_Obtiene_Ciclo(V_ABONADO,V_PRODUCTO,V_CICLO,V_INDFACT,V_ERROR);

                    SELECT COD_CICLO INTO V_CICLO_DES
                    FROM GE_CLIENTES
                    WHERE COD_CLIENTE=V_ORIGEN;

                    V_CICLO:=V_CICLO_DES;

                    IF V_ERROR <> '0' THEN
                           V_ERROR := '4';
                           RAISE ERROR_PROCESO;
                    END IF;

                    IF V_INDFACT = 1 THEN
                       P_Alta_Ciclocli( V_PRODUCTO,V_ORIGEN,V_ABONADO,V_CICLO,'A',
                                        V_AGENTE,V_CREDMOR,V_USUARIO,SYSDATE, VP_PROC,
                                        VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);



                       IF V_ERROR <> '0' THEN
                           V_ERROR := '4';
                           RAISE ERROR_PROCESO;
                       END IF;
                       VP_PROC := 'P_INTERFASES_CELULAR';

                                ELSE
                        P_Alta_Ciclocli(V_PRODUCTO,V_ORIGEN,V_ABONADO,V_CICLO,'A',
                                        V_AGENTE,V_CREDMOR,V_USUARIO,SYSDATE, VP_PROC,
                                        VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);



                                    P_Alta_Nociclocli(V_PRODUCTO,V_ORIGEN,V_ABONADO,V_CICLO,'A',
                                          V_AGENTE,V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                                                  VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);



                                        IF V_ERROR <> '0' THEN
                           V_ERROR := '4';
                           RAISE ERROR_PROCESO;
                        END IF;
                        VP_PROC := 'P_INTERFASES_CELULAR';

                                END IF;

                                 VP_PROC := 'P_INTERFASES_CELULAR';
                     BEGIN
                            V_EMP := 1;
                            VP_TABLA := 'GA_EMPRESA';
                            VP_ACT := 'S';
                            SELECT COD_EMPRESA  INTO V_GRUPO
                            FROM GA_EMPRESA
                            WHERE COD_CLIENTE = V_ORIGEN;
                     EXCEPTION
                               WHEN NO_DATA_FOUND THEN
                               V_EMP := 0;
                               WHEN OTHERS THEN
                                    V_ERROR := '4';
                               RAISE ERROR_PROCESO;
                     END;
                     IF V_EMP = 1 THEN
                        Ga_P_Primerholding(V_ABONADO, V_PRODUCTO, 'E', V_GRUPO,
                                           SYSDATE, VP_PROC, VP_TABLA, VP_ACT,
                                           VP_SQLCODE, VP_SQLERRM, V_ERROR, VP_ACTABO);




                                    IF V_ERROR <> '0' THEN
                              V_ERROR := 4;
                              RAISE ERROR_PROCESO;
                        END IF;

                 --OCB-INI 15-09-2008
                 PV_REPONER_LIMITE_CLIABO_PR(V_ORIGEN,V_ABONADO,SYSDATE,V_PLANTARIF,V_ERROR);

                 IF V_ERROR <> '0' THEN
                    V_ERROR := '4';
                    RAISE ERROR_PROCESO;
                 END IF;
                 --OCB-FIN 15-09-2008


                     END IF;
                     BEGIN
                        V_EMP := 1;
                        VP_TABLA := 'GA_EMPRESA';
                        VP_ACT := 'S';
                        SELECT COD_EMPRESA  INTO V_GRUPO
                        FROM GA_EMPRESA
                        WHERE COD_CLIENTE = V_DESTINO;
                     EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            V_EMP := 0;
                        WHEN OTHERS THEN
                            V_ERROR := '4';
                            RAISE ERROR_PROCESO;
                     END;

                                 IF V_EMP = 1 THEN
                        Ga_P_Ultimoholding (V_ABONADO,V_PRODUCTO,V_TIPPLANTARIF
                                            ,V_GRUPO,VP_PROC,VP_TABLA,VP_ACT,'T',VP_SQLCODE
                                            ,VP_SQLERRM,V_ERROR,VP_ACTABO ); -- ahott 15-02-2006 RA-759



                                                IF V_ERROR <> '0' THEN
                           V_ERROR := '4';
                           RAISE ERROR_PROCESO;
                        END IF;
                     END IF;
                   ELSE

                     P_Actualiza_Cargos_Baja(V_DESTINO,V_ABONADO,V_CICLO,VP_PROC,
                                                                 VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);



                     IF V_ERROR <> '0' THEN
                        V_ERROR := '4';
                        RAISE ERROR_PROCESO;
                     END IF;

                         -- Valida si cliente posee cambio de ciclo pendiente
                     P_Cliente_Ciclonue(V_ABONADO,V_ORIGEN,1,SYSDATE,VP_PROC,
                                        VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);



                     IF V_ERROR <> '0' THEN
                         V_ERROR := '4';
                        RAISE ERROR_PROCESO;
                  END IF;
              -- Valida si cliente empresa posee cambio de plan pendiente
                  BEGIN
                    V_EMP := 1;
                    VP_TABLA := 'GA_EMPRESA';
                    VP_ACT := 'S';
                    SELECT COD_EMPRESA  INTO V_GRUPO
                    FROM GA_EMPRESA
                    WHERE COD_CLIENTE = V_ORIGEN;
                  EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                       V_EMP := 0;
                    WHEN OTHERS THEN
                        V_ERROR := '4';
                   RAISE ERROR_PROCESO;
                  END;
                  IF V_EMP=1 THEN
                   BEGIN
                      SELECT COD_CICLO,TIP_PLANTARIF,COD_EMPRESA
                      INTO V_CICLO,V_TIPPLANTARIF,V_EMPRESA
                      FROM GA_ABOCEL
                      WHERE NUM_ABONADO=V_ABONADO;
                   EXCEPTION
                      WHEN OTHERS THEN
                        V_ERROR := '4';
                       RAISE ERROR_PROCESO;
                   END;

                   P_Cliente_Plannue(V_ABONADO,V_ORIGEN,1,V_CICLO,SYSDATE,
                                     V_TIPPLANTARIF,V_EMPRESA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                                     VP_SQLERRM,V_ERROR);




                   IF V_ERROR <> '0' THEN
                     V_ERROR := '4';
                     RAISE ERROR_PROCESO;
                   END IF;
                 END IF;
               END IF;

        --OCB-FIN



        ELSIF VP_ACTABO = 'RO' OR VP_ACTABO = 'R2' THEN  /* Reordenamiento */
         IF VP_VAR3 IS NULL THEN


           SV_mens_retorno :='ERROR';
           SN_num_evento:=0;
           LV_sSql  :='Invoca procedure P_Datos_Abocel con el abonado:'||V_ABONADO;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));


            P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                           V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                           V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                           V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                           V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                           V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                           V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
                           V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,
                           VP_SQLCODE, VP_SQLERRM,V_ERROR);

                        DBMS_OUTPUT.PUT_LINE('PASO 1 =' || V_ERROR );
            IF V_ERROR <> '0' THEN
                V_ERROR := '4';
                RAISE ERROR_PROCESO;
            END IF;
            VP_PROC   := 'P_INTERFASES_CELULAR';
            V_ORIGEN  := TO_NUMBER(VP_ORIGEN);
            V_DESTINO := TO_NUMBER(VP_DESTINO);
            V_CLIENEW := TO_NUMBER(VP_DESTINO);



           SV_mens_retorno :='ERROR';
           SN_num_evento:=0;
           LV_sSql  :='Invoca procedure Pv_Reordenamientointar_Pr (PRODUCTO,CLIENTE ORIG,ABONADO,CLIENTE DES,CICLO):'||V_PRODUCTO||'-'||V_DESTINO||'-'||V_ABONADO||'-'||V_ORIGEN||'-'||V_CICLO;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));


            Pv_Reordenamientointar_Pr (V_PRODUCTO,V_DESTINO,V_ABONADO,V_ORIGEN,
                                       V_CICLO,SYSDATE,V_CLIENEW,VP_PROC,VP_TABLA,
                                       VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

                        DBMS_OUTPUT.PUT_LINE('PASO 2 =' || V_ERROR );
            IF V_ERROR <> '0' THEN
                        V_ERROR := '4';
                        RAISE ERROR_PROCESO;
            END IF;


            VP_PROC := 'P_INTERFASES_CELULAR';

            SV_mens_retorno :='ERROR';
           SN_num_evento:=0;
           LV_sSql  :='Invoca procedure Pv_Reordenamientoinfac_Pr (PRODUCTO,CLIENTE ORIG,ABONADO,CLIENTE DES,CICLO):'||V_PRODUCTO||'-'||V_DESTINO||'-'||V_ABONADO||'-'||V_ORIGEN||'-'||V_CICLO;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));


            Pv_Reordenamientoinfac_Pr (V_PRODUCTO,V_DESTINO,V_ABONADO,V_ORIGEN,
                                          V_CICLO,SYSDATE,VP_PROC,VP_TABLA,
                                          VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
                        DBMS_OUTPUT.PUT_LINE('PASO 3 =' || V_ERROR );
            IF V_ERROR <> '0' THEN
                       V_ERROR := '4';
                        RAISE ERROR_PROCESO;
            END IF;




            SV_mens_retorno :='ERROR';
           SN_num_evento:=0;
           LV_sSql  :='Invoca procedure  Pv_Altabajasertras_Pr (PRODUCTO,ABONADO):'||V_PRODUCTO||'-'||V_ABONADO;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));


            Pv_Altabajasertras_Pr  (V_PRODUCTO,V_ABONADO,VP_PROC,
                                    VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

            VP_PROC := 'P_INTERFASES_CELULAR';

                        IF V_ERROR <> '0' THEN
                           V_ERROR := '4';
                           RAISE ERROR_PROCESO;
            END IF;


            SV_mens_retorno :='ERROR';
            SN_num_evento:=0;
            LV_sSql  :='Invoca procedure  Pv_Altabajasertras_Pr (ABONADO,PRODUCTO,CICLO):'||V_PRODUCTO||'-'||V_ABONADO||'-'||V_CICLO;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));


            P_Obtiene_Ciclo(V_ABONADO,V_PRODUCTO,V_CICLO,V_INDFACT,V_ERROR);

                        DBMS_OUTPUT.PUT_LINE('PASO 4 =' || V_ERROR );

                        IF V_ERROR <> '0' THEN
                   V_ERROR := '4';
                   RAISE ERROR_PROCESO;
            END IF;

            SELECT COD_CICLO INTO V_CICLO_DES
            FROM GE_CLIENTES
            WHERE COD_CLIENTE=V_ORIGEN;

            V_CICLO:=V_CICLO_DES;


            SV_mens_retorno :='ERROR';
            SN_num_evento:=0;
            LV_sSql  :='VALOR V_INDFACT :'||V_INDFACT ;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));


            IF V_INDFACT = 1 THEN



            SV_mens_retorno :='ERROR';
            SN_num_evento:=0;
            LV_sSql  :='Invoca procedure P_Alta_Ciclocli :'||V_PRODUCTO||'-'||V_ORIGEN||'-'||V_ABONADO||'-'||V_CICLO||'-'||'A'||'-'||V_AGENTE||'-'||V_CREDMOR||'-'||V_USUARIO;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));



               P_Alta_Ciclocli(V_PRODUCTO,V_ORIGEN,V_ABONADO,V_CICLO,'A',
                                V_AGENTE,V_CREDMOR,V_USUARIO,SYSDATE, VP_PROC,
                                VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
                           DBMS_OUTPUT.PUT_LINE('PASO 5 =' || V_ERROR );


            SV_mens_retorno :='ERROR';
            SN_num_evento:=0;
            LV_sSql  :='SALIDA procedure P_Alta_Ciclocli :'||VP_PROC||'-'||VP_TABLA||'-'||VP_ACT||'-'||VP_SQLCODE||'-'||VP_SQLERRM||'-'||V_ERROR;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));



               IF V_ERROR <> '0' THEN
                   V_ERROR := '4';
                   RAISE ERROR_PROCESO;
               END IF;
               VP_PROC := 'P_INTERFASES_CELULAR';
             ELSE

              SV_mens_retorno :='ERROR';
            SN_num_evento:=0;
            LV_sSql  :='Invoca procedure P_Alta_Ciclocli :'||V_PRODUCTO||'-'||V_ORIGEN||'-'||V_ABONADO||'-'||V_CICLO||'-'||'A'||'-'||V_AGENTE||'-'||V_CREDMOR||'-'||V_USUARIO;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));



                P_Alta_Ciclocli(V_PRODUCTO,V_ORIGEN,V_ABONADO,V_CICLO,'A',
                                V_AGENTE,V_CREDMOR,V_USUARIO,SYSDATE, VP_PROC,
                                VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
                                DBMS_OUTPUT.PUT_LINE('PASO 6 =' || V_ERROR );

            SV_mens_retorno :='ERROR';
            SN_num_evento:=0;
            LV_sSql  :='SALIDA procedure P_Alta_Ciclocli :'||VP_PROC||'-'||VP_TABLA||'-'||VP_ACT||'-'||VP_SQLCODE||'-'||VP_SQLERRM||'-'||V_ERROR;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));


                    SV_mens_retorno :='ERROR';
            SN_num_evento:=0;
            LV_sSql  :='Invoca procedure  P_Alta_Nociclocli:'||V_PRODUCTO||'-'||V_ORIGEN||'-'||V_ABONADO||'-'||V_CICLO||'-'||'A'||'-'||V_AGENTE||'-'||V_CREDMOR||'-'||V_USUARIO;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));


                P_Alta_Nociclocli(V_PRODUCTO,V_ORIGEN,V_ABONADO,V_CICLO,'A',
                                  V_AGENTE,V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

            SV_mens_retorno :='ERROR';
            SN_num_evento:=0;
            LV_sSql  :='SALIDA procedure P_Alta_Nociclocli :'||VP_PROC||'-'||VP_TABLA||'-'||VP_ACT||'-'||VP_SQLCODE||'-'||VP_SQLERRM||'-'||V_ERROR;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));


                                DBMS_OUTPUT.PUT_LINE('PASO 7 =' || V_ERROR );
                IF V_ERROR <> '0' THEN
                   V_ERROR := '4';
                   RAISE ERROR_PROCESO;
                END IF;
                VP_PROC := 'P_INTERFASES_CELULAR';
             END IF;
             VP_PROC := 'P_INTERFASES_CELULAR';
             BEGIN
                    V_EMP := 1;
                    VP_TABLA := 'GA_EMPRESA';
                    VP_ACT := 'S';
                    SELECT COD_EMPRESA  INTO V_GRUPO
                    FROM GA_EMPRESA
                    WHERE COD_CLIENTE = V_ORIGEN;
             EXCEPTION
                       WHEN NO_DATA_FOUND THEN
                       V_EMP := 0;
                       WHEN OTHERS THEN

                         SV_mens_retorno :='ERROR';
                         SN_num_evento:=0;
                         LV_sSql  :='ERROR EN LA OBTENCION DEL CODIGO EMPRESA PARA EL CLIENTE  :'||V_ORIGEN;
                          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));

                            V_ERROR := '4';
                       RAISE ERROR_PROCESO;
             END;
             
             IF V_EMP = 1 THEN

                SV_mens_retorno :='ERROR';
                SN_num_evento:=0;
                LV_sSql  :='Invoca procedure Ga_P_Primerholding(abonado,producto,tipo,grupo,fecha,actabo):'||V_ABONADO||'-'|| V_PRODUCTO||'-'|| 'E'||'-'|| V_GRUPO||'-'|| SYSDATE||'-'||VP_ACTABO;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));



                Ga_P_Primerholding(V_ABONADO, V_PRODUCTO, 'E', V_GRUPO,
                                      SYSDATE, VP_PROC, VP_TABLA, VP_ACT,
                                      VP_SQLCODE, VP_SQLERRM, V_ERROR, VP_ACTABO);


               SV_mens_retorno :='ERROR';
               SN_num_evento:=0;
               LV_sSql  :='SALIDA procedure  Ga_P_Primerholding :'||VP_PROC||','|| VP_TABLA||','|| VP_ACT||','||VP_SQLCODE||','|| VP_SQLERRM||','|| V_ERROR;
               SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));

               
               DBMS_OUTPUT.PUT_LINE('PASO 8 =' || V_ERROR );
                IF V_ERROR <> '0' THEN
                      V_ERROR := 4;
                      RAISE ERROR_PROCESO;
                END IF;

                 --OCB-INI 15-09-2008

                SELECT COD_COLOR,COD_SEGMENTO
                INTO LV_COD_COLOR,LV_COD_SEGMENTO
                FROM   GE_CLIENTES
                WHERE  COD_CLIENTE=V_ORIGEN;

                BEGIN 

                    SELECT MTO_CONS
                    INTO   LN_IMP_LIMCON
                    FROM   TOL_LIMITE_PLAN_TD
                    WHERE COD_PLANTARIF =V_PLANTARIF
                    AND   ID_SUBSEGMENTO=LV_COD_SEGMENTO
                    AND   IND_PRIORIDAD =LV_COD_COLOR
                    AND   IND_DEFAULT   ='S'
                    AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
                        
                EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                       LN_IMP_LIMCON:=0;
                END; 
                


                BEGIN
            
                    SELECT  NUM_ABONADO
                    INTO LV_NUM_ABONADO 
                    FROM  GA_LCABO_TO
                    WHERE 
                    NUM_ABONADO=V_ABONADO;
                    
                    UPDATE GA_LCABO_TO
                    SET IMP_LIMCONS=  LN_IMP_LIMCON
                    WHERE  NUM_ABONADO=V_ABONADO;           
            
                EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                        INSERT INTO  GA_LCABO_TO (NUM_ABONADO,IMP_LIMCONS)
                        VALUES(V_ABONADO,LN_IMP_LIMCON);
                END; 



                BEGIN
            
                    SELECT  NUM_ABONADO
                    INTO LV_NUM_ABONADO 
                    FROM  GA_LCABO_TO
                    WHERE 
                    NUM_ABONADO=0;
                    
                    UPDATE GA_LCABO_TO
                    SET IMP_LIMCONS=  LN_IMP_LIMCON
                    WHERE  NUM_ABONADO=0;           
            
                EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                              INSERT INTO  GA_LCABO_TO (NUM_ABONADO,IMP_LIMCONS)
                              VALUES(0,LN_IMP_LIMCON);
                END; 


                SV_mens_retorno :='ERROR';
                SN_num_evento:=0;
                LV_sSql  :='Invoca procedure PV_REPONER_LIMITE_CLIABO_PR(cliente,abonado,fecha,plan):'||V_ORIGEN||'-'||V_ABONADO||'-'||SYSDATE||'-'||V_PLANTARIF;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));


                PV_REPONER_LIMITE_CLIABO_PR(V_ORIGEN,V_ABONADO,SYSDATE,V_PLANTARIF,V_ERROR);

                SV_mens_retorno :='ERROR';
                SN_num_evento:=0;
                LV_sSql  :='SALIDA procedure    PV_REPONER_LIMITE_CLIABO_PR:'||v_error;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));


                 DELETE GA_LCABO_TO  
                 WHERE NUM_ABONADO  =  0 
                 AND IMP_LIMCONS    = LN_IMP_LIMCON;


                 IF V_ERROR <> '0' THEN
                    V_ERROR := '4';
                    RAISE ERROR_PROCESO;
                 END IF;
                   --OCB-FIN 15-09-2008
             END IF;
             
             
             BEGIN
                V_EMP := 1;
                VP_TABLA := 'GA_EMPRESA';
                VP_ACT := 'S';
                SELECT COD_EMPRESA  INTO V_GRUPO
                FROM GA_EMPRESA
                WHERE COD_CLIENTE = V_DESTINO;
             EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    V_EMP := 0;
                WHEN OTHERS THEN
                        SV_mens_retorno :='ERROR';
                         SN_num_evento:=0;
                         LV_sSql  :='ERROR EN LA OBTENCION DEL CODIGO EMPRESA PARA EL CLIENTE origen  :'||v_destino;
                          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));

                    V_ERROR := '4';
                    RAISE ERROR_PROCESO;
             END;
             IF V_EMP = 1 THEN


                SV_mens_retorno :='ERROR';
            SN_num_evento:=0;
            LV_sSql  :='Invoca procedure Ga_P_Ultimoholding(abonado,producto,tipo,grupo):'||V_ABONADO||'-'|| V_PRODUCTO||'-'|| V_TIPPLANTARIF||'-'|| V_GRUPO;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));


                Ga_P_Ultimoholding (V_ABONADO,V_PRODUCTO,V_TIPPLANTARIF
                      ,V_GRUPO,VP_PROC,VP_TABLA,VP_ACT,'T',VP_SQLCODE
                                       ,VP_SQLERRM,V_ERROR );

         SV_mens_retorno :='ERROR';
            SN_num_evento:=0;
            LV_sSql  :='SALIDA procedure   Ga_P_Ultimoholding:'||VP_PROC||'-'||VP_TABLA||'-'||VP_ACT||'-'||VP_SQLCODE||'-'||VP_SQLERRM||'-'||V_ERROR;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));

                                DBMS_OUTPUT.PUT_LINE('PASO 9 =' || V_ERROR );
                IF V_ERROR <> '0' THEN
                   V_ERROR := '4';
                   RAISE ERROR_PROCESO;
                END IF;
             END IF;

            SV_mens_retorno :='ERROR';
            SN_num_evento:=0;
            LV_sSql  :='Invoca procedure  P_Actualiza_Cargos_Baja(cliente,abonado,ciclo):'||V_DESTINO||','||V_ABONADO||','||V_CICLO;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));


          P_Actualiza_Cargos_Baja(V_DESTINO,V_ABONADO,V_CICLO,VP_PROC,
          VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

            SV_mens_retorno :='ERROR';
            SN_num_evento:=0;
            LV_sSql  :='salida procedure  P_Actualiza_Cargos_Baja:'||VP_PROC||'-'|| VP_TABLA||'-'||VP_ACT||'-'||VP_SQLCODE||'-'||VP_SQLERRM||'-'||V_ERROR;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));



                  DBMS_OUTPUT.PUT_LINE('PASO 10 =' || V_ERROR );
          IF V_ERROR <> '0' THEN
            V_ERROR := '4';
            RAISE ERROR_PROCESO;
          END IF;
      -- Valida si cliente posee cambio de ciclo pendiente

       SV_mens_retorno :='ERROR';
            SN_num_evento:=0;
            LV_sSql  :='Invoca procedure P_Cliente_Ciclonue(abonado,cliente):'||V_ABONADO||'-'||V_ORIGEN;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));

          P_Cliente_Ciclonue(V_ABONADO,V_ORIGEN,1,SYSDATE,VP_PROC,
          VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

            SV_mens_retorno :='ERROR';
            SN_num_evento:=0;
            LV_sSql  :='salida procedure    P_Cliente_Ciclonue:'||VP_PROC||'-'|| VP_TABLA||'-'||VP_ACT||'-'||VP_SQLCODE||'-'||VP_SQLERRM||'-'||V_ERROR;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));



                  DBMS_OUTPUT.PUT_LINE('PASO 11 =' || V_ERROR );
          IF V_ERROR <> '0' THEN
             V_ERROR := '4';
             RAISE ERROR_PROCESO;
          END IF;
      -- Valida si cliente empresa posee cambio de plan pendiente
          BEGIN
            V_EMP := 1;
            VP_TABLA := 'GA_EMPRESA';
            VP_ACT := 'S';
            SELECT COD_EMPRESA  INTO V_GRUPO
            FROM GA_EMPRESA
            WHERE COD_CLIENTE = V_ORIGEN;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
               V_EMP := 0;
            WHEN OTHERS THEN
                         SV_mens_retorno :='ERROR';
                         SN_num_evento:=0;
                         LV_sSql  :='ERROR EN LA OBTENCION DEL CODIGO EMPRESA_F PARA EL CLIENTE destino  :'||V_ORIGEN;
                          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));

                V_ERROR := '4';
           RAISE ERROR_PROCESO;
          END;
          IF V_EMP=1 THEN
           BEGIN
              SELECT COD_CICLO,TIP_PLANTARIF,COD_EMPRESA
              INTO V_CICLO,V_TIPPLANTARIF,V_EMPRESA
              FROM GA_ABOCEL
              WHERE NUM_ABONADO=V_ABONADO;
           EXCEPTION
              WHEN OTHERS THEN
                         SV_mens_retorno :='ERROR';
                         SN_num_evento:=0;
                         LV_sSql  :='ERROR EN LA OBTENCION del ciclo,tipo plan y codigo empresa del abonado   :'||V_ABONADO;
                         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno,'1' , USER, 'R2MASIVO',  LV_sSql  , SQLCODE, SUBSTR(SQLERRM,1,400));

                V_ERROR := '4';
               RAISE ERROR_PROCESO;
           END;
          END IF;
       END IF;

       --OCB-FIN

           --OCB-INI



           ELSIF VP_ACTABO = 'AE' OR VP_ACTABO = 'A2'  THEN /* CAMBIO DE PLAN CON REORDENAMIENTO */
         IF VP_VAR3 IS NULL THEN
            P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                           V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                           V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                           V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                           V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                           V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                           V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
                           V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,
                           VP_SQLCODE, VP_SQLERRM,V_ERROR);

                        DBMS_OUTPUT.PUT_LINE('PASO 1 =' || V_ERROR );
            IF V_ERROR <> '0' THEN
                V_ERROR := '4';
                RAISE ERROR_PROCESO;
            END IF;

            VP_PROC := 'P_INTERFASES_CELULAR';
            V_ORIGEN := TO_NUMBER(VP_ORIGEN);
            V_DESTINO := TO_NUMBER(VP_DESTINO);
            V_CLIENEW := TO_NUMBER(VP_DESTINO);


            Pv_Cambiopreordintar_Pr (V_PRODUCTO,V_DESTINO,V_ABONADO,V_ORIGEN,
                                     V_CICLO,SYSDATE,V_CLIENEW,VP_PROC,VP_TABLA,
                                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);


                        DBMS_OUTPUT.PUT_LINE('PASO 2 =' || V_ERROR );

                        IF V_ERROR <> '0' THEN
               V_ERROR := '4';
               RAISE ERROR_PROCESO;
            END IF;


            VP_PROC := 'P_INTERFASES_CELULAR';

            Pv_Cambiopreordinfac_Pr (V_PRODUCTO,V_DESTINO,V_ABONADO,V_ORIGEN,
                                     V_CICLO,SYSDATE,VP_PROC,VP_TABLA,
                                     VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

                        DBMS_OUTPUT.PUT_LINE('PASO 3 =' || V_ERROR );
            IF V_ERROR <> '0' THEN
                       V_ERROR := '4';
                        RAISE ERROR_PROCESO;
            END IF;


             Pv_Altabajasertras_Pr  (V_PRODUCTO,V_ABONADO,VP_PROC,
                                     VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

             VP_PROC := 'P_INTERFASES_CELULAR';

             IF V_ERROR <> '0' THEN
                V_ERROR := '4';
                RAISE ERROR_PROCESO;
             END IF;



                P_Obtiene_Ciclo(V_ABONADO,V_PRODUCTO,V_CICLO,V_INDFACT,V_ERROR);

            DBMS_OUTPUT.PUT_LINE('PASO 4 =' || V_ERROR );

                    IF V_ERROR <> '0' THEN
                   V_ERROR := '4';
                   RAISE ERROR_PROCESO;
            END IF;

            SELECT COD_CICLO INTO V_CICLO_DES
            FROM GE_CLIENTES
            WHERE COD_CLIENTE=V_ORIGEN;

            V_CICLO:=V_CICLO_DES;

            IF V_INDFACT = 1 THEN
               P_Alta_Ciclocli(V_PRODUCTO,V_ORIGEN,V_ABONADO,V_CICLO,'A',
                                                           V_AGENTE,V_CREDMOR,V_USUARIO,SYSDATE, VP_PROC,
                               VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

                           DBMS_OUTPUT.PUT_LINE('PASO 5 =' || V_ERROR );
               IF V_ERROR <> '0' THEN
                   V_ERROR := '4';
                   RAISE ERROR_PROCESO;
               END IF;
               VP_PROC := 'P_INTERFASES_CELULAR';
             ELSE
                P_Alta_Ciclocli(V_PRODUCTO,V_ORIGEN,V_ABONADO,V_CICLO,'A',
                                V_AGENTE,V_CREDMOR,V_USUARIO,SYSDATE, VP_PROC,
                                VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
                                DBMS_OUTPUT.PUT_LINE('PASO 6 =' || V_ERROR );

                                P_Alta_Nociclocli(V_PRODUCTO,V_ORIGEN,V_ABONADO,V_CICLO,'A',
                                  V_AGENTE,V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

                                DBMS_OUTPUT.PUT_LINE('PASO 7 =' || V_ERROR );
                IF V_ERROR <> '0' THEN
                   V_ERROR := '4';
                   RAISE ERROR_PROCESO;
                END IF;
                VP_PROC := 'P_INTERFASES_CELULAR';
             END IF;
             VP_PROC := 'P_INTERFASES_CELULAR';
             BEGIN
                    V_EMP := 1;
                    VP_TABLA := 'GA_EMPRESA';
                    VP_ACT := 'S';
                    SELECT COD_EMPRESA  INTO V_GRUPO
                    FROM GA_EMPRESA
                    WHERE COD_CLIENTE = V_ORIGEN;
             EXCEPTION
                       WHEN NO_DATA_FOUND THEN
                       V_EMP := 0;
                       WHEN OTHERS THEN
                            V_ERROR := '4';
                       RAISE ERROR_PROCESO;
             END;
             IF V_EMP = 1 THEN
                Ga_P_Primerholding(V_ABONADO, V_PRODUCTO, 'E', V_GRUPO,
                                   SYSDATE, VP_PROC, VP_TABLA, VP_ACT,
                                   VP_SQLCODE, VP_SQLERRM, V_ERROR, VP_ACTABO);
                DBMS_OUTPUT.PUT_LINE('PASO 8 =' || V_ERROR );
                                IF V_ERROR <> '0' THEN
                      V_ERROR := 4;
                      RAISE ERROR_PROCESO;
                END IF;

                 --OCB-INI 15-09-2008
                 PV_REPONER_LIMITE_CLIABO_PR(V_ORIGEN,V_ABONADO,SYSDATE,V_PLANTARIF,V_ERROR);

                 IF V_ERROR <> '0' THEN
                    V_ERROR := '4';
                    RAISE ERROR_PROCESO;
                 END IF;
                   --OCB-FIN 15-09-2008



             END IF;
             BEGIN
                V_EMP := 1;
                VP_TABLA := 'GA_EMPRESA';
                VP_ACT := 'S';
                SELECT COD_EMPRESA  INTO V_GRUPO
                FROM GA_EMPRESA
                WHERE COD_CLIENTE = V_DESTINO;
             EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    V_EMP := 0;
                WHEN OTHERS THEN
                    V_ERROR := '4';
                    RAISE ERROR_PROCESO;
             END;
             IF V_EMP = 1 THEN
                Ga_P_Ultimoholding (V_ABONADO,V_PRODUCTO,V_TIPPLANTARIF
                      ,V_GRUPO,VP_PROC,VP_TABLA,VP_ACT,'T',VP_SQLCODE
                                       /* Inicio modificacion by SAQL/Soporte 12/07/2006 - CO-200607050216 */
                                       --,VP_SQLERRM,V_ERROR );
                                       ,VP_SQLERRM,V_ERROR,VP_ACTABO );
                                       /* Fin modificacion by SAQL/Soporte 12/07/2006 - CO-200607050216 */
                                DBMS_OUTPUT.PUT_LINE('PASO 9 =' || V_ERROR );
                IF V_ERROR <> '0' THEN
                   V_ERROR := '4';
                   RAISE ERROR_PROCESO;
                END IF;
             END IF;

                  P_Actualiza_Cargos_Baja(V_DESTINO,V_ABONADO,V_CICLO,VP_PROC,
                                                          VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
                  DBMS_OUTPUT.PUT_LINE('PASO 10 =' || V_ERROR );
          IF V_ERROR <> '0' THEN
            V_ERROR := '4';
            RAISE ERROR_PROCESO;
          END IF;
      -- Valida si cliente posee cambio de ciclo pendiente
          P_Cliente_Ciclonue(V_ABONADO,V_ORIGEN,1,SYSDATE,VP_PROC,
          VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
                  DBMS_OUTPUT.PUT_LINE('PASO 11 =' || V_ERROR );
          IF V_ERROR <> '0' THEN
             V_ERROR := '4';
             RAISE ERROR_PROCESO;
          END IF;
      -- Valida si cliente empresa posee cambio de plan pendiente
          BEGIN
            V_EMP := 1;
            VP_TABLA := 'GA_EMPRESA';
            VP_ACT := 'S';
            SELECT COD_EMPRESA  INTO V_GRUPO
            FROM GA_EMPRESA
            WHERE COD_CLIENTE = V_ORIGEN;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
               V_EMP := 0;
            WHEN OTHERS THEN
                V_ERROR := '4';
           RAISE ERROR_PROCESO;
          END;
          IF V_EMP=1 THEN
           BEGIN
              SELECT COD_CICLO,TIP_PLANTARIF,COD_EMPRESA
              INTO V_CICLO,V_TIPPLANTARIF,V_EMPRESA
              FROM GA_ABOCEL
              WHERE NUM_ABONADO=V_ABONADO;
           EXCEPTION
              WHEN OTHERS THEN
                V_ERROR := '4';
               RAISE ERROR_PROCESO;
           END;
           P_Cliente_Plannue(V_ABONADO,V_ORIGEN,1,V_CICLO,SYSDATE,
           V_TIPPLANTARIF,V_EMPRESA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
           VP_SQLERRM,V_ERROR);
                   DBMS_OUTPUT.PUT_LINE('PASO 12 =' || V_ERROR );
           IF V_ERROR <> '0' THEN
             V_ERROR := '4';
             RAISE ERROR_PROCESO;
           END IF;
         END IF;
       END IF;

           --OCB-FIN


       ELSIF VP_ACTABO = 'CN' OR VP_ACTABO = 'C8' THEN /* Cambio de Numero de celular / Cambio de Numero de celular PREPAGO (C8)*/
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           IF V_ORIGEN = 0 THEN /* Cambio numero del home */
              P_Primer_Numero (V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_DESTINO,
                               V_CICLO,V_CELDA,V_FECSYS,VP_PROC,VP_TABLA,
                               VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           ELSIF V_ORIGEN = 1 THEN /* Cambio del segundo numero */
              P_Segundo_Numero (V_CLIENTE,V_ABONADO,V_CELULAR_PLEX,V_CICLO,
              V_CELDA,V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,
              V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           ELSIF V_ORIGEN = 2 THEN /* Cambio de las dos numeraciones */
              P_Primer_Numero (V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_DESTINO,
                               V_CICLO,V_CELDA,V_FECSYS,VP_PROC,VP_TABLA,
                               VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
              P_Segundo_Numero (V_CLIENTE,V_ABONADO,V_CELULAR_PLEX,V_CICLO,
                       V_CELDA,V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                       VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
                   ELSIF V_ORIGEN = 3 THEN /* Cambio numero del home Prepago */

              P_Tercer_Numero (V_PRODUCTO,V_CLIENTE,V_ABONADO,VP_DESTINO,
                               V_CICLO,V_CELDA,V_FECSYS,VP_PROC,VP_TABLA,
                               VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

             IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           END IF;
        ELSIF VP_ACTABO = 'BA' OR VP_ACTABO = 'BF' OR VP_ACTABO ='BH' THEN /* Baja de Abonado */
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                             V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                             V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                             V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                             V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                             V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
                             V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                             VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Baja_Abonado(V_PRODUCTO,V_CLIENTE,V_ABONADO,
                          V_CICLO,V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                          VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           IF V_TIPPLANTARIF = 'E' OR V_TIPPLANTARIF = 'H' THEN
              P_Cambio_Grupotar(V_PRODUCTO,V_TIPPLANTARIF,V_EMPRESA,
                                V_HOLDING,'0',VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                                VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           END IF;
           Ve_P_Insrenuncias (V_ABONADO,V_VENTA,1,VP_PROC,VP_TABLA,VP_ACT,
                              VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
--           P_MODIFICA_NUMPROCESO (V_ABONADO,VP_PROC,VP_TABLA,VP_ACT,
--                                  VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
            IF V_TIPPLANTARIF = 'H'  THEN
                    Ga_P_Ultimoholding (V_ABONADO,V_PRODUCTO,V_TIPPLANTARIF
                                        ,V_HOLDING,VP_PROC,VP_TABLA,VP_ACT,'B',VP_SQLCODE
                                        --,VP_SQLERRM,V_ERROR );    --COL-72424|03-11-2008|GEZ
                                        ,VP_SQLERRM,V_ERROR,'BA' ); --COL-72424|03-11-2008|GEZ

                    IF V_ERROR <> '0' THEN
                            V_ERROR := '4';
                            RAISE ERROR_PROCESO;
                    END IF;

            ELSIF V_TIPPLANTARIF = 'E' THEN
                    Ga_P_Ultimoholding (V_ABONADO,V_PRODUCTO,V_TIPPLANTARIF
                                       ,V_EMPRESA,VP_PROC,VP_TABLA,VP_ACT,'B',VP_SQLCODE
                                       --,VP_SQLERRM,V_ERROR );     --COL-72424|03-11-2008|GEZ
                                        ,VP_SQLERRM,V_ERROR,'BA' ); --COL-72424|03-11-2008|GEZ

                    IF V_ERROR <> '0' THEN
                            V_ERROR := '4';
                            RAISE ERROR_PROCESO;
                    END IF;

            --INI COL-72424|03-11-2008|GEZ
            /*
            ELSIF V_TIPPLANTARIF = 'I' THEN
                                  /* INCIDENCIA  TM-031020030317 CEM */
            /*
                                  VP_PROC  := 'PV_LIMITE_CONSUMO_PG';
                                  VP_TABLA := 'PV_OPERA_LIMITE_PR';
                                  VP_ACT   := 'P';
                  Pv_Limite_Consumo_Pg.PV_OPERA_LIMITE_PR (V_ABONADO,'A','*','*','BA','*','*',PvCodValor,V_ERROR,pvErrorGlosa,VP_SQLCODE,VP_SQLERRM,pvTrace);
                  IF PvCodValor='FALSE' THEN
                     V_ERROR := '4';
                     RAISE ERROR_PROCESO;
                  END IF;
            */
            --FIN COL-72424|03-11-2008|GEZ

            END IF;
            P_Actualiza_Cargos_Baja(V_CLIENTE,V_ABONADO,V_CICLO,VP_PROC,
            VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
            IF V_ERROR <> '0' THEN
               V_ERROR := '4';
               RAISE ERROR_PROCESO;
            END IF;
        ELSIF VP_ACTABO = 'BM' THEN /* Baja masiva de abonados */
           V_VAR3 := TO_NUMBER(VP_VAR3);
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Baja_Masiva_Abonados (V_PRODUCTO,V_VAR3,V_ABONADO,V_FECSYS,VP_PROC,VP_TABLA, VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Cambio_Grupotar_Masivo(V_PRODUCTO,V_VAR3,V_ABONADO,
               VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
/*           VP_PROC := 'P_INTERFASES_CELULAR';
           VE_P_INSRENUNCIAS (V_ABONADO,V_VENTA,1,VP_PROC,VP_TABLA,VP_ACT,
               VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
 */
           VP_PROC := 'P_INTERFASES_CELULAR';
--           P_MODIFICA_NUMPROCESO_MASIVO (V_VAR3,V_ABONADO,VP_PROC,VP_TABLA,VP_ACT,
--             VP_SQLCODE,VP_SQLERRM,V_ERROR);
--           IF V_ERROR <> '0' THEN
--              V_ERROR := '4';
--              RAISE ERROR_PROCESO;
--           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           Ga_P_Ultimoholding_Masivo (V_PRODUCTO, V_VAR3, V_ABONADO,
                  VP_PROC, VP_TABLA, VP_ACT, VP_SQLCODE, VP_SQLERRM,V_ERROR );
           IF V_ERROR <> '0' THEN
                  V_ERROR := '4';
                  RAISE ERROR_PROCESO;
           END IF;
        ELSIF VP_ACTABO = 'LA' THEN /* Liquidacion de Abonados */
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Liquida_Abonado (V_PRODUCTO,V_CLIENTE,V_ABONADO,
                              V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
         VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Modifica_Numproceso (V_ABONADO,VP_PROC,VP_TABLA,VP_ACT,
             VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
        ELSIF VP_ACTABO = 'AB' OR VP_ACTABO = 'AF' OR VP_ACTABO = 'AH' THEN /* Anulacion de baja de Abonados */
           P_Datos_Abocel(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Anula_Bajaabo(V_PRODUCTO,V_CLIENTE,V_ABONADO,V_BAJACEN,
                           V_BAJA,V_FECSYS,V_GRPSERV,V_CICLO,VP_PROC,
                           VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           IF V_TIPPLANTARIF = 'E' OR V_TIPPLANTARIF = 'H' THEN
              P_Cambio_Grupotar(V_PRODUCTO,V_TIPPLANTARIF,V_EMPRESA,
              V_HOLDING,'1',VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,
              V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           END IF;
           Ve_P_Insrenuncias (V_ABONADO,V_VENTA,0,VP_PROC,VP_TABLA,VP_ACT,
                              VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           IF  V_TIPPLANTARIF = 'H' THEN
                  V_GRUPO := V_HOLDING;
           ELSIF V_TIPPLANTARIF = 'E' THEN
                  V_GRUPO := V_EMPRESA;
           /* Inicio modificacion by SAQL/Soporte 17/07/2006 - CO-200607050216 */
           /* ELSIF V_TIPPLANTARIF = 'I' THEN */
           /*    VP_PROC  := 'PV_LIMITE_CONSUMO_PG'; */
         --Inicio Modificación - Rodrigo Muñoz E. - TM-200502241286 - 02/03/2005
         --  --Modificado para incidencia TM-200403310606 por WGC 19-04-2004
         --  PV_REPONER_LIMITE_CLIABO_PR(V_CLIENTE,V_ABONADO,V_IMPLICONS,V_PLANTARIF,V_ERROR);
         --  --Fin Modificación para incidencia TM-200403310606 por WGC 19-04-2004
           END IF;
           /* Fin modificacion by SAQL/Soporte 17/07/2006 - CO-200607050216 */
          PV_REPONER_LIMITE_CLIABO_PR(V_CLIENTE,V_ABONADO,V_FECSYS,V_PLANTARIF,V_ERROR);
         --Fin Modificación - Rodrigo Muñoz E. - TM-200502241286 - 02/03/2005
                 IF V_ERROR <> '0' THEN
                    V_ERROR := '4';
                    RAISE ERROR_PROCESO;
                 END IF;
           /* Inicio modificacion by SAQL/Soporte 17/07/2006 - CO-200607050216 */
           /* END IF; */
           /* Fin modificacion by SAQL/Soporte 17/07/2006 - CO-200607050216 */
           IF V_TIPPLANTARIF = 'H' OR V_TIPPLANTARIF = 'E' THEN
               Ga_P_Updinfaccel (V_CLIENTE,VP_PROC,VP_TABLA,VP_ACT,
                                 VP_SQLCODE,VP_SQLERRM,V_ERROR);
               IF V_ERROR <> '0' THEN
                  V_ERROR := '4';
                  RAISE ERROR_PROCESO;
               END IF;
               Ga_P_Primerholding(V_ABONADO, V_PRODUCTO, V_TIPPLANTARIF,
                                  V_GRUPO,V_FECSYS,VP_PROC,VP_TABLA,
                                                                  VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR,VP_ACTABO);
               IF V_ERROR <> '0' THEN
                  V_ERROR := '4';
                  RAISE ERROR_PROCESO;
               END IF;

                   --RA-200512260395: German Espinoza Z; 01/03/2006
                   END IF;
                   --FIN/RA-200512260395: German Espinoza Z; 01/03/2006

                   P_Cliente_Ciclonue(V_ABONADO,V_CLIENTE,1,SYSDATE,VP_PROC,
                                          VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

                   IF V_ERROR <> '0' THEN
                  V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;

           P_Cliente_Plannue(V_ABONADO,V_CLIENTE,1,V_CICLO,SYSDATE,
                                         V_TIPPLANTARIF,V_EMPRESA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                                         VP_SQLERRM,V_ERROR);

                   IF V_ERROR <> '0' THEN
                  V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;

                   --RA-200512260395: German Espinoza Z; 01/03/2006
           --END IF;
                   P_Valida_Ciclo(V_CLIENTE,V_PRODUCTO,V_ABONADO,V_CICLO,
                                          V_CICLO_CLINUEVO,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                                          VP_SQLERRM,V_ERROR);

           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;

                   IF V_CICLO<>V_CICLO_CLINUEVO THEN
                          BEGIN
                                  UPDATE ga_intarcel
                                  SET    cod_ciclo=V_CICLO_CLINUEVO
                                  WHERE  cod_cliente=V_CLIENTE
                                  AND    num_abonado=V_ABONADO
                                  AND    SYSDATE BETWEEN fec_desde AND fec_hasta;
                          EXCEPTION
                                  WHEN OTHERS THEN
                                           V_ERROR := '4';
                           RAISE ERROR_PROCESO;
                          END;
                   END IF;
                   --FIN/RA-200512260395: German Espinoza Z; 01/03/2006

        ELSIF VP_ACTABO = 'HO' THEN /* Cambio plan tarifario o ciclo en holding
  */
           V_DESTINO := TO_NUMBER(VP_DESTINO);
      /*     P_DATOS_ABOCEL(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
*/
     IF VP_VAR3 = 'I' THEN
     --PLANTARIFARIO INMEDIATO
             Ga_P_Modifica_Pthinmediato(V_PRODUCTO,V_ABONADO,VP_ORIGEN,V_FECSYS,
      VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                    VP_SQLERRM,V_ERROR) ;
     ELSE
            P_Modifica_Holding(V_PRODUCTO,V_ABONADO,VP_ORIGEN,V_DESTINO,
            V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
     END IF;
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'EM' THEN /* Cambio plan tarifario o ciclo en empresa
  */
           V_DESTINO := TO_NUMBER(VP_DESTINO);
      /*     P_DATOS_ABOCEL(V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                          V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                          V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,
                          V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
                          V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,
            V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
            VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
*/
     IF VP_VAR3 = 'I' THEN
          --PLANTARIFARIO INMEDIATO
          Ga_P_Modifica_Pteinmediato(V_PRODUCTO,V_ABONADO,VP_ORIGEN,V_FECSYS,
          VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
          VP_SQLERRM,V_ERROR ) ;
     ELSE
          P_Modifica_Empresa(V_PRODUCTO,V_ABONADO,VP_ORIGEN,V_DESTINO,
          V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
          VP_SQLERRM,V_ERROR);
     END IF;
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
      /* Operaciones en rent a phone */
        ELSIF VP_ACTABO = 'OR' THEN /* Alta de operaciones de rent a phone */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           P_Datos_Aborent(V_ORIGEN,V_ABONADO,V_CLIENTE,V_PLEXSYS,
             V_IMPLICONS,V_CELDA,V_PLANTARIF,
             V_SERIE,V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,
                           V_PLANSERV,V_PROCALTA,V_AGENTE,V_FECALTA,
             V_VENTA,V_INDFACT,V_FINCONTRA,V_BAJACEN,
             V_BAJA,V_MOVALTA,V_MOVBAJA,VP_PROC,VP_TABLA,
             VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Alta_Intarent(V_ORIGEN,V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                           V_CELDA,V_PLANTARIF,V_SERIE,V_CELULAR,V_CELULAR_PLEX,
                    V_CARGOBASICO,V_PLANSERV,V_PROCALTA,V_AGENTE,
             V_FECALTA,V_BAJA,V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,
             VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Alta_Infacrent(V_ORIGEN,V_ABONADO,V_CLIENTE,V_CELULAR,
                            V_PROCALTA,V_AGENTE,V_FECALTA,V_VENTA,
                     V_INDFACT,V_FINCONTRA,V_FECSYS,V_BAJA,
              VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                     VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           -- inicio GPrev-Implantación de Generación de folios para cliente-TMM-50133 Ve_P_Insrentaphone (V_PRODUCTO,V_ABONADO,V_ORIGEN,VP_PROC,VP_TABLA,
           --VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           --IF V_ERROR <> '0' THEN
           --   V_ERROR := '4';
           --   RAISE ERROR_PROCESO;
           --END IF;
           --VP_PROC := 'P_INTERFASES_CELULAR'; -- / fin GPrev-Implantación de Generación de folios para cliente-TMM-50133
        ELSIF VP_ACTABO = 'PR' THEN /* Prorrogas de servicio Rent a Phone */
      --
      -- origen = alquiler
      -- destino = 0 - baja, 1 - alta, 2 - modificacion
      -- var3 = numero de movimiento de baja
      --
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           V_DESTINO := TO_NUMBER(VP_DESTINO);
           V_VAR3 := TO_NUMBER(VP_VAR3);
           IF V_DESTINO <> 1 THEN
              P_Borra_Intarent(V_ORIGEN,V_ABONADO,VP_PROC,VP_TABLA,VP_ACT,
          VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
              P_Borra_Infarent(V_ORIGEN,V_ABONADO,VP_PROC,VP_TABLA,VP_ACT,
          VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           END IF;
           IF V_DESTINO <> 0 THEN
              P_Datos_Aborent(V_ORIGEN,V_ABONADO,V_CLIENTE,V_PLEXSYS,
            V_IMPLICONS,V_CELDA,V_PLANTARIF,
         V_SERIE,V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,
                              V_PLANSERV,V_PROCALTA,V_AGENTE,V_FECALTA,
         V_VENTA,V_INDFACT,V_FINCONTRA,V_BAJACEN,
         V_BAJA,V_MOVALTA,V_MOVBAJA,VP_PROC,VP_TABLA,
         VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
              P_Alta_Intarent(V_ORIGEN,V_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                              V_CELDA,V_PLANTARIF,V_SERIE,V_CELULAR,
                              V_CELULAR_PLEX,V_CARGOBASICO,V_PLANSERV,V_PROCALTA,V_AGENTE,
                              V_FECALTA,V_BAJA,V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,
                              VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
              P_Alta_Infacrent(V_ORIGEN,V_ABONADO,V_CLIENTE,V_CELULAR,
                               V_PROCALTA,V_AGENTE,V_FECALTA,V_VENTA,
          V_INDFACT,V_FINCONTRA,V_FECSYS,V_BAJA,
          VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
          VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           END IF;
      /*   IF V_DESTINO <> 1 THEN */
       P_Movimiento_Baja(V_ORIGEN,V_ABONADO,V_DESTINO,V_VAR3,VP_PROC,
           VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
      /*   END IF;
 */
        ELSIF VP_ACTABO = 'DR' THEN /* Modificacion datos abonados rent a phone
  */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           V_DESTINO := TO_NUMBER(VP_DESTINO);
           P_Datos_Aborent(V_ORIGEN,V_ABONADO,V_CLIENTE,V_PLEXSYS,
                V_IMPLICONS,V_CELDA,V_PLANTARIF,
             V_SERIE,V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,
                           V_PLANSERV,V_PROCALTA,V_AGENTE,V_FECALTA,
                    V_VENTA,V_INDFACT,V_FINCONTRA,V_BAJACEN,
             V_BAJA,V_MOVALTA,V_MOVBAJA,VP_PROC,VP_TABLA,
             VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Modifica_Intarent(V_ORIGEN,V_ABONADO,V_CLIENTE,V_IMPLICONS,
          V_CELDA,V_SERIE,V_FECSYS,V_DESTINO,VP_PROC,
          VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'RB' THEN /* Baja de periodos Rent a Phone */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           P_Datos_Aborent(V_ORIGEN,V_ABONADO,V_CLIENTE,V_PLEXSYS,
                    V_IMPLICONS,V_CELDA,V_PLANTARIF,
             V_SERIE,V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,
                           V_PLANSERV,V_PROCALTA,V_AGENTE,V_FECALTA,
             V_VENTA,V_INDFACT,V_FINCONTRA,V_BAJACEN,
             V_BAJA,V_MOVALTA,V_MOVBAJA,VP_PROC,VP_TABLA,VP_ACT,
             VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
       V_ERROR := '4';
       RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Movimiento_Baja(V_ORIGEN,V_ABONADO,0,V_MOVBAJA,VP_PROC,VP_TABLA,
               VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Baja_Rent(V_ORIGEN,V_ABONADO,V_FECSYS,VP_PROC,VP_TABLA,VP_ACT,
         VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'FI' THEN /* Cambio de indicador facturable Rent a
  Phone */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           V_DESTINO := TO_NUMBER(VP_DESTINO);
           P_Indicador_Facturent (V_ABONADO,V_ORIGEN,V_DESTINO,V_FECSYS,
                                  VP_PROC,VP_TABLA,VP_ACT,
                    VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'FP' THEN /* Factura Baja abonados rent a phone */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           P_Factura_Rent(V_ORIGEN,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                   VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
       V_ERROR := '4';
       RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Modifica_Numproceso (V_ABONADO,VP_PROC,VP_TABLA,VP_ACT,
             VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
        ELSIF VP_ACTABO = 'LR' THEN /* Liquidacion abonados rent a phone */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           P_Liquida_Aborent(V_ORIGEN,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                             VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
       V_ERROR := '4';
       RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
      /* Operaciones de Roaming Compania */
        ELSIF VP_ACTABO = 'RA' THEN /* Alta de abonados roaming compania */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           P_Datos_Aboroacom(V_ORIGEN,V_ABONADO,V_CLIENTE,V_CELULAR_ORIG_COM,
               V_IMPLICONS,V_FECALTA,V_BAJA,V_SERIE,V_OPERADOR,
               V_CELULAR_ABO_COM,V_CICLO,VP_PROC,VP_TABLA,VP_ACT,
               VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
                          V_ERROR := '4';
                                  RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
                   --dbms_output.put_line('Antes de  P_Recupera Ciclo');
           P_Recupera_Ciclos(V_ABONADO,V_CICLONEW,V_FECCICLO,VP_PROC,VP_TABLA,
               VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
                          V_ERROR := '4';
                          RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Alta_Intaroacom (V_ORIGEN,V_ABONADO,V_CLIENTE,V_FECALTA,V_BAJA,
                V_IMPLICONS,V_SERIE,V_CELULAR_ORIG_COM,V_OPERADOR,
                V_CELULAR_ABO_COM,V_CICLO,V_CICLONEW,V_FECCICLO,
         VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
         VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
                          V_ERROR := '4';
                                  RAISE ERROR_PROCESO;
           END IF;
                   DBMS_OUTPUT.PUT_LINE('Fin de  Alta RA');
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'RM' THEN /* Modificacion de abonados roaming compania
  */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           P_Datos_Aboroacom(V_ORIGEN,V_ABONADO,V_CLIENTE,V_CELULAR_ORIG_COM,
               V_IMPLICONS,V_FECALTA,V_BAJA,V_SERIE,V_OPERADOR,
               V_CELULAR_ABO_COM,V_CICLO,VP_PROC,VP_TABLA,VP_ACT,
               VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
       V_ERROR := '4';
       RAISE ERROR_PROCESO;
           END IF;
           P_Borra_Estadias (V_ORIGEN,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
               VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
       V_ERROR := '4';
       RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Recupera_Ciclos(V_ABONADO,V_CICLONEW,V_FECCICLO,VP_PROC,VP_TABLA,
               VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
       V_ERROR := '4';
       RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Alta_Intaroacom (V_ORIGEN,V_ABONADO,V_CLIENTE,V_FECALTA,V_BAJA,
                V_IMPLICONS,V_SERIE,V_CELULAR_ORIG_COM,V_OPERADOR,
                V_CELULAR_ABO_COM,V_CICLO,V_CICLONEW,V_FECCICLO,
         VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
         VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
       V_ERROR := '4';
       RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'BS' THEN /* Baja de abonados roaming compania */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           V_DESTINO := TO_NUMBER(VP_DESTINO);
           P_Baja_Aboroacom(V_ORIGEN,V_DESTINO,V_FECSYS,VP_PROC,VP_TABLA,
              VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR P_DATOS_ABOROAVIS';
        ELSIF VP_ACTABO = 'AR' THEN /* Alta de abonados roaming visitantes */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           P_Datos_Aboroavis(V_ORIGEN,V_CLIENTE,V_ABONADO,V_FECALTA,
               V_BAJA,V_IMPLICONS,V_SERIE,V_CELDA,V_CELULAR,
               V_OPERADOR,V_CELULAR_ORIG,V_MOVALTA,V_MOVBAJA,
               VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
               VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR P_ALTA_INTAROAVIS';
           P_Alta_Intaroavis(V_CLIENTE,V_ABONADO,V_FECALTA,V_BAJA,
               V_IMPLICONS,V_CELDA,V_SERIE,V_CELULAR,
               V_ORIGEN,V_OPERADOR,V_CELULAR_ORIG,VP_PROC,
               VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR P_ALTA_INFACROAVIS';
           IF V_CLIENTE IS NOT NULL THEN
              P_Alta_Infacroavis(V_CLIENTE,V_ABONADO,V_ORIGEN,V_FECALTA,V_BAJA,
              V_CELULAR,V_CELULAR_ORIG,VP_PROC,VP_TABLA,VP_ACT,
              VP_SQLCODE,VP_SQLERRM,V_ERROR);
              IF V_ERROR <> '0' THEN
                 V_ERROR := '4';
                 RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_INTERFASES_CELULAR';
           END IF;
        ELSIF VP_ACTABO = 'MR' THEN /* Modificacion abonados roaming visitantes
  */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           P_Datos_Aboroavis(V_ORIGEN,V_CLIENTE,V_ABONADO,V_FECALTA,
               V_BAJA,V_IMPLICONS,V_SERIE,V_CELDA,V_CELULAR,
               V_OPERADOR,V_CELULAR_ORIG,V_MOVALTA,V_MOVBAJA,
               VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
               VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
           P_Modifica_Aboroavis(V_ORIGEN,V_IMPLICONS,V_FECALTA,V_BAJA,
           V_CELULAR_ORIG,V_SERIE,V_CELDA,V_MOVALTA,
           V_MOVBAJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
           VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'BV' THEN /* Baja abonados roaming visitantes */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           V_DESTINO := TO_NUMBER(VP_DESTINO);
           V_VAR3 := TO_NUMBER(VP_VAR3);
           P_Baja_Aboroavis(V_ABONADO,V_ORIGEN,V_FECSYS,V_DESTINO,
              V_VAR3,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
              VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'FR' THEN /* Factura Baja abonados roaming visitantes
  */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           P_Factura_Roabaja(V_ORIGEN,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                             VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        ELSIF VP_ACTABO = 'RL' THEN /* Liquidacion abonados roaming visitantes */
           V_ORIGEN := TO_NUMBER(VP_ORIGEN);
           P_Liquida_Roaming(V_ORIGEN,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                             VP_SQLERRM,V_ERROR);
           IF V_ERROR <> '0' THEN
              V_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
           VP_PROC := 'P_INTERFASES_CELULAR';
        END IF;
      EXCEPTION
             WHEN ERROR_FDO THEN
                 V_ERROR:= '8';

         WHEN ERROR_PROCESO THEN
         V_ERROR := 4;
         WHEN OTHERS THEN
         VP_SQLCODE := SQLCODE;
         VP_SQLERRM := SQLERRM;
         V_ERROR := '4';
END;
/