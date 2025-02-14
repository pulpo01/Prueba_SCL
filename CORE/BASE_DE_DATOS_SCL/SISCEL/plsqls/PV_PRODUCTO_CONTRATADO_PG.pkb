CREATE OR REPLACE PACKAGE BODY Pv_Producto_Contratado_Pg AS
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.- Metodo : RegistraReordenamientoPlan
PROCEDURE PV_REG_REORDENAMIENTO_PLAN_PR (EO_REG_REORD_PLAN         IN                           PV_REG_REORD_PLAN_QT,
                                                                     SN_cod_retorno                OUT    NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                     SV_mens_retorno               OUT    NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                     SN_num_evento                 OUT    NOCOPY        ge_errores_pg.evento)
IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_REG_REORDENAMIENTO_PLAN_PR"
              Lenguaje="PL/SQL"
              Fecha="11-07-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
                      <Descripción> Este metodo esta asociado al registro de un traspaso de un abonado a otro cliente , para lo cual hay </Descripción>>
                      <Descripción>  que invocar el pl  PV_CAMB_PLAN_R_PG.PV_TRASPASO_PR                                                 </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_REG_REORD_PLAN" Tipo="estructura">estructura de los datos Type </param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error                            ge_errores_pg.DesEvent;
        LV_sSql                                         ge_errores_pg.vQuery;

        ERROR_EJECUCION                 EXCEPTION;
        ncodCliOrig                             NUMBER   (8);
        nCodCliDest                             NUMBER   (8);
        ncod_Cuentad                            NUMBER   (8);
        nNumAbonado                             NUMBER   (8);
        scod_SubCuentad                         VARCHAR2 (15);
        scod_plantarif                          VARCHAR2 (03);
        ncod_producto                           NUMBER   (01);
        susuarora                               VARCHAR2 (30);
        scod_actabo                             VARCHAR2 (02);
        ncod_Cuentao                            NUMBER   (08);
        scodtipcontrato                         VARCHAR2 (03);
        snumcontrato                            VARCHAR2 (21);
        snum_anexo                              VARCHAR2 (21);
        scod_usuario                            VARCHAR2 (08);
        scod_usuariod                           VARCHAR2 (08);
        stiptraspaso                            VARCHAR2 (03);
        snum_celular                            NUMBER   (15);
        scod_empresad                           NUMBER   (8);
        scod_empresa                            NUMBER   (8);
        scod_subcuenta                          VARCHAR2 (15);
        /*serror                                        VARCHAR2 (06);
        scod_per                                VARCHAR2 (06);
        sdes_per                                VARCHAR2 (255);
        scod_ora                                VARCHAR2 (06);
        sdes_trace                              VARCHAR2 (255);
        nCodPlanCo                              VARCHAR2 (03);*/

        serror                                  VARCHAR2 (255);
        scod_per                                VARCHAR2 (255);
        sdes_per                                VARCHAR2 (255);
        scod_ora                                VARCHAR2 (255);
        sdes_trace                              VARCHAR2 (255);
        nCodPlanCo                              VARCHAR2 (255);

        ln_cicloDestino                         NUMBER;

BEGIN
    SN_num_evento   := 0;
        SV_mens_retorno := NULL;

                    ncodCliOrig     := EO_REG_REORD_PLAN.COD_CLIENTE_ORI;
                        nCodCliDest     := EO_REG_REORD_PLAN.COD_CLIENTE_DES;
                        ncod_Cuentad    := EO_REG_REORD_PLAN.COD_CUENTA_DES;
                        nNumAbonado     := EO_REG_REORD_PLAN.NUM_ABONADO;
                        scod_SubCuentad := EO_REG_REORD_PLAN.COD_SUBCUENTA_DES;
                        scod_plantarif  := EO_REG_REORD_PLAN.COD_PLANTARIF_NUEVO;
                        ncod_producto   := EO_REG_REORD_PLAN.COD_PRODUCTO;
                        susuarora       := EO_REG_REORD_PLAN.ID_USER;
                        scod_actabo     := EO_REG_REORD_PLAN.COD_ACTABO;
                        ncod_Cuentao    := EO_REG_REORD_PLAN.COD_CUENTA_ORI;
                        scodtipcontrato := EO_REG_REORD_PLAN.COD_TIPO_CONTRATO;
                        snumcontrato    := EO_REG_REORD_PLAN.NUM_CONTRATO;
                        snum_anexo      := EO_REG_REORD_PLAN.NUM_ANEXO;
                        scod_usuario    := EO_REG_REORD_PLAN.COD_USUARIO_ORI;
                        scod_usuariod   := EO_REG_REORD_PLAN.COD_USUARIO_DES;
                        stiptraspaso    := EO_REG_REORD_PLAN.TIPO_TRASPASO;
                        snum_celular    := EO_REG_REORD_PLAN.NUM_CELULAR;
                        scod_empresad   := EO_REG_REORD_PLAN.COD_EMPRESA_DES;
                        scod_empresa    := EO_REG_REORD_PLAN.COD_EMPRESA_ORI;
                        scod_subcuenta  := EO_REG_REORD_PLAN.COD_SUBCUENTA_ORI;

/*                      LV_sSql :=  'SELECT cod_ciclo FROM ge_clientes';
                        LV_sSql := LV_sSql || ' WHERE  cod_cliente = '||EO_REG_REORD_PLAN.COD_CLIENTE_DES;

                        SELECT cod_ciclo
                        INTO   ln_cicloDestino
                        FROM   ge_clientes
                        WHERE  cod_cliente = EO_REG_REORD_PLAN.COD_CLIENTE_DES;*/

                        serror          := '0';
                        scod_per        := '0';
                    sdes_per            := ' ';
                        scod_ora        := '0';
                    sdes_trace          := ' ';
                        nCodPlanCo      := '0';



                        LV_sSql:='PV_CAMB_PLAN_R_PG.PV_TRASPASO_PR ('||ncodCliOrig||','||nCodCliDest||','||ncod_Cuentad||','||nNumAbonado||',';
                        LV_sSql:=LV_sSql||''||scod_SubCuentad||','||scod_plantarif||','||ncod_producto||','||susuarora||','||scod_actabo||',';
                        LV_sSql:=LV_sSql||''||ncod_Cuentao||','||scodtipcontrato||','||snumcontrato||','||snum_anexo||','||scod_usuario||','||scod_usuariod||',';
                        LV_sSql:=LV_sSql||''||stiptraspaso||','||snum_celular||','||scod_empresad||','||scod_empresa||','||scod_subcuenta||',';
                        LV_sSql:=LV_sSql||''||serror||','||scod_per||','||sdes_per||','||scod_ora||','||sdes_trace||','||nCodPlanCo||');';

                        Pv_Camb_Plan_R_Pg.PV_TRASPASO_PR  (ncodCliOrig,nCodCliDest,ncod_Cuentad,nNumAbonado,scod_SubCuentad,scod_plantarif,ncod_producto,susuarora,scod_actabo,
                                                                                           ncod_Cuentao,scodtipcontrato,snumcontrato,snum_anexo,scod_usuario,scod_usuariod,stiptraspaso,snum_celular,scod_empresad,scod_empresa,scod_subcuenta,
                                                                                                serror,scod_per,sdes_per,scod_ora,sdes_trace,nCodPlanCo);
                        IF TRIM(serror) <>'NO' THEN --OCB 1-11-2007
                                RAISE ERROR_EJECUCION;
                        END IF;

                        SN_cod_retorno :=0;
        EXCEPTION
/*      WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 314;
          LV_des_error   := ' PV_REG_REORDENAMIENTO_PLAN_PR ('||EO_REG_REORD_PLAN.COD_CLIENTE_DES||'); '||SQLERRM;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
      END IF;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_REORDENAMIENTO_PLAN_PR', LV_sSQL||'-'||SQLERRM, scod_per, sdes_per );*/
        WHEN ERROR_EJECUCION THEN
                  SN_cod_retorno := scod_per;
                  SV_mens_retorno:= sdes_per;
                  LV_des_error   := ' PV_REG_REORDENAMIENTO_PLAN_PR (); '||SQLERRM;
              --SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_REORDENAMIENTO_PLAN_PR', LV_sSQL, scod_per, sdes_per );
                  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_REORDENAMIENTO_PLAN_PR', LV_sSQL||'-'||SQLERRM, scod_per, sdes_per );

          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_REG_REORDENAMIENTO_PLAN_PR (); '||SQLERRM;
              --SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_REORDENAMIENTO_PLAN_PR', LV_sSQL, scod_per, sdes_per );
                  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_REORDENAMIENTO_PLAN_PR', LV_sSQL||'-'||SQLERRM, scod_per, sdes_per );

END PV_REG_REORDENAMIENTO_PLAN_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.- Metodo :  registroCambPlanComer
PROCEDURE PV_REG_CAMB_PLAN_COMER_PR (
   EO_REG_CAMB_PLAN_COMER        IN               PV_REG_CAMB_PLAN_COMER_QT,
   SN_cod_retorno                OUT    NOCOPY    ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno               OUT    NOCOPY    ge_errores_td.det_msgerror%TYPE,
   SN_num_evento                 OUT    NOCOPY    ge_errores_pg.evento
) IS
/*
   <Documentación TipoDoc = "Procedure">>
   <Elemento
      Nombre = "PV_REG_CAMB_PLAN_COMER_PR"
      Lenguaje="PL/SQL"
      Fecha="11-07-2007"
      Versión="La del package"
      Diseñador=""
      Programador="Carlos Elizondo"
      Ambiente Desarrollo="BD">
   <Retorno>N/A</Retorno>>
   <Descripción>  </Descripción>>
   <Parámetros>
      <Entrada>
         <param nom="EO_REG_CAMB_PLAN_COMER" Tipo="estructura">estructura de los datos Type </param>>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
         <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
         <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
      </Salida>
   </Parámetros>
   </Elemento>
   </Documentación>
*/
-- PV_REG_CAMB_PLAN_COMER_PR v1.1 COL 77090|30-01-2009|SAQL

   LV_des_error         ge_errores_pg.DesEvent;
   LV_sSql              ge_errores_pg.vQuery;
   ERROR_EJECUCION      EXCEPTION;
   ERROR_PARAMETROS     EXCEPTION;
   VP_TRANSACCION       VARCHAR2(09);
   VP_ACTABO            VARCHAR2(02);
   VP_PRODUCTO          VARCHAR2(01);
   VP_ABONADO           VARCHAR2(08);
   VP_ORIGEN            VARCHAR2(09);
   VP_DESTINO           VARCHAR2(09);
   VP_VAR3              VARCHAR2(09);
   VP_VAR4              VARCHAR2(03) := NULL;
   VP_VAR5              VARCHAR2(01) := NULL;
   VP_VAR6              VARCHAR2(08) := NULL;
   V_VAR3               VARCHAR2(09) := NULL;
   V_CLIENTE            GA_ABOCEL.COD_CLIENTE%TYPE;
   V_PLEXSYS            GA_ABOCEL.IND_PLEXSYS%TYPE;
   V_IMPLICONS          TA_LIMCONSUMO.IMP_LIMCONSUMO%TYPE;
   V_CELDA              GA_ABOCEL.COD_CELDA%TYPE;
   V_TIPPLANTARIF       GA_ABOCEL.TIP_PLANTARIF%TYPE;
   V_PLANTARIF          GA_ABOCEL.COD_PLANTARIF%TYPE;
   V_SERIE              GA_ABOCEL.NUM_SERIEHEX%TYPE;
   V_CELULAR            GA_ABOCEL.NUM_CELULAR%TYPE;
   V_CELULAR_PLEX       GA_ABOCEL.NUM_CELULAR_PLEX%TYPE;
   V_CARGOBASICO        GA_ABOCEL.COD_CARGOBASICO%TYPE;
   V_CICLO              GA_ABOCEL.COD_CICLO%TYPE;
   V_PLANSERV           GA_ABOCEL.COD_PLANSERV%TYPE;
   V_GRPSERV            GA_ABOCEL.COD_GRPSERV%TYPE;
   V_EMPRESA            GA_ABOCEL.COD_EMPRESA%TYPE;
   V_HOLDING            GA_ABOCEL.COD_HOLDING%TYPE;
   V_PORTADOR           GA_ABOCEL.COD_CARRIER%TYPE;
   V_PROCALTA           GA_ABOCEL.IND_PROCALTA%TYPE;
   V_AGENTE             GA_ABOCEL.COD_VENDEDOR_AGENTE%TYPE;
   V_SUPERTEL           GA_ABOCEL.IND_SUPERTEL%TYPE;
   V_TELEFIJA           GA_ABOCEL.NUM_TELEFIJA%TYPE;
   V_FECALTA            GA_ABOCEL.FEC_ACTCEN%TYPE;
   V_VENTA              GA_ABOCEL.NUM_VENTA%TYPE;
   V_INDFACT            GA_ABOCEL.IND_FACTUR%TYPE;
   V_FINCONTRA          GA_ABOCEL.FEC_FINCONTRA%TYPE;
   V_BAJACEN            GA_ABOCEL.FEC_BAJACEN%TYPE;
   V_BAJA               GA_ABOCEL.FEC_BAJACEN%TYPE;
   V_CREDMOR            GA_ABOCEL.COD_CREDMOR%TYPE;
   V_USUARIO            GA_ABOCEL.COD_USUARIO%TYPE;
   V_OPREDFIJA          GA_ABOCEL.COD_OPREDFIJA%TYPE;
   VP_PROC              VARCHAR2(200);
   VP_TABLA             VARCHAR2(200);
   VP_ACT               VARCHAR2(8);
   VP_SQLCODE           VARCHAR2(200);
   VP_SQLERRM           VARCHAR2(200);
   V_ERROR              NUMBER;
   V_FECSYS             DATE;
BEGIN
   SN_num_evento   := 0;
   SN_cod_retorno  := 0;
   SV_mens_retorno := NULL;
   VP_TRANSACCION := NULL;
   VP_ACTABO      := NULL;
   VP_PRODUCTO    := NULL;
   VP_ABONADO     := NULL;
   VP_ORIGEN      := NULL;
   VP_DESTINO     := NULL;
   IF ge_log_pg.debug_activo THEN
      ge_log_pg.DEBUG( 'PV_REG_CAMB_PLAN_COMER_PR - INICIO LOG' );
   END IF;

   IF EO_REG_CAMB_PLAN_COMER.COD_OS IS NULL THEN
      RAISE ERROR_PARAMETROS;
   END IF;

   IF (EO_REG_CAMB_PLAN_COMER.COD_OS = '10508') THEN
      VP_TRANSACCION:= TO_CHAR(EO_REG_CAMB_PLAN_COMER.NUM_TRANSACCION);
      VP_ACTABO     := EO_REG_CAMB_PLAN_COMER.COD_ACTABO;
      VP_PRODUCTO   := TO_CHAR(EO_REG_CAMB_PLAN_COMER.COD_PRODUCTO);
      VP_ABONADO    := TO_CHAR(EO_REG_CAMB_PLAN_COMER.NUM_ABONADO);
      VP_ORIGEN     := EO_REG_CAMB_PLAN_COMER.COD_CLIENTE_DES;
      VP_DESTINO    := EO_REG_CAMB_PLAN_COMER.COD_CLIENTE_ORIG;
      VP_VAR3       := '';
   END IF;

   IF (EO_REG_CAMB_PLAN_COMER.COD_OS = '10022') THEN --Empresa
      VP_TRANSACCION:= TO_CHAR(EO_REG_CAMB_PLAN_COMER.NUM_TRANSACCION);
      VP_ACTABO     := EO_REG_CAMB_PLAN_COMER.COD_ACTABO;
      VP_PRODUCTO   := TO_CHAR(EO_REG_CAMB_PLAN_COMER.COD_PRODUCTO);
      VP_ABONADO    := TO_CHAR(EO_REG_CAMB_PLAN_COMER.COD_HOLDING);
      VP_ORIGEN     := EO_REG_CAMB_PLAN_COMER.COD_PLANTARIF_NUEVO;
      VP_DESTINO    := '';
      VP_VAR3       := 'C'; --NIVEL CLIENTE
   END IF;

   IF (EO_REG_CAMB_PLAN_COMER.COD_OS = '10020') THEN -- Cambio Plan Tarifario Individual a Ciclo
      VP_TRANSACCION:= TO_CHAR(EO_REG_CAMB_PLAN_COMER.NUM_TRANSACCION);
      VP_ACTABO     := EO_REG_CAMB_PLAN_COMER.COD_ACTABO;
      VP_PRODUCTO   := TO_CHAR(EO_REG_CAMB_PLAN_COMER.COD_PRODUCTO);
      VP_ABONADO    := TO_CHAR(EO_REG_CAMB_PLAN_COMER.NUM_ABONADO);
      VP_ORIGEN     := EO_REG_CAMB_PLAN_COMER.TIP_PLANTARIF;
      VP_DESTINO    := EO_REG_CAMB_PLAN_COMER.COD_PLANTARIF_NUEVO;
      -- VP_VAR3       := '';
   END IF;

   IF (EO_REG_CAMB_PLAN_COMER.COD_OS = '10530' OR  EO_REG_CAMB_PLAN_COMER.COD_OS = '10539') THEN --Normal a Total, Total a Normal (POSPAGO HIBRIDO - HIBRIDO POSPAGO)
      VP_TRANSACCION:= TO_CHAR(EO_REG_CAMB_PLAN_COMER.NUM_TRANSACCION);
      VP_ACTABO     := EO_REG_CAMB_PLAN_COMER.COD_ACTABO;
      VP_PRODUCTO   := TO_CHAR(EO_REG_CAMB_PLAN_COMER.COD_PRODUCTO);
      VP_ABONADO    := TO_CHAR(EO_REG_CAMB_PLAN_COMER.NUM_ABONADO);
      VP_ORIGEN     := EO_REG_CAMB_PLAN_COMER.COD_PLANTARIF_NUEVO;
      VP_DESTINO    := '';
      VP_VAR3       := EO_REG_CAMB_PLAN_COMER.COD_HOLDING;

      DBMS_OUTPUT.PUT_LINE('VP_TRANSACCION:' ||  VP_TRANSACCION);
      DBMS_OUTPUT.PUT_LINE('VP_ACTABO ' || VP_ACTABO);
      DBMS_OUTPUT.PUT_LINE('VP_PRODUCTO' || VP_PRODUCTO);
      DBMS_OUTPUT.PUT_LINE('VP_ABONADO ' || VP_ABONADO);
      DBMS_OUTPUT.PUT_LINE(' VP_ORIGEN' ||  VP_ORIGEN);
      DBMS_OUTPUT.PUT_LINE(' VP_DESTINO' || VP_DESTINO);
      DBMS_OUTPUT.PUT_LINE('VP_VAR3' || VP_VAR3);
   END IF;

   IF ( VP_TRANSACCION IS NOT NULL ) THEN
      /*DBMS_OUTPUT.Put_Line('Antes de P_INTERFASES_ABONADOS('||VP_TRANSACCION||','||VP_ACTABO||','||VP_PRODUCTO||','||VP_ABONADO||','||VP_ORIGEN||','||VP_DESTINO||','||VP_VAR3||','||VP_VAR4||','||VP_VAR5||','||VP_VAR6||')');
      LV_sSql:='P_INTERFASES_ABONADOS ('||VP_TRANSACCION||','||VP_ACTABO||','||VP_PRODUCTO||','||VP_ABONADO||','||VP_ORIGEN||','||VP_DESTINO||','||VP_VAR3||','||VP_VAR4||','||VP_VAR5||','||VP_VAR6||'); ';
      P_INTERFASES_ABONADOS (VP_TRANSACCION,VP_ACTABO,VP_PRODUCTO,VP_ABONADO,VP_ORIGEN,VP_DESTINO,VP_VAR3,VP_VAR4,VP_VAR5,VP_VAR6);

      LV_sSql:='SELECT COD_RETORNO,DES_CADENA INTO SN_cod_retorno,SV_mens_retorno FROM GA_TRANSACABO WHERE NUM_TRANSACCION ='|| VP_TRANSACCION||'; ';
      SELECT COD_RETORNO,DES_CADENA
      INTO SN_cod_retorno,SV_mens_retorno
      FROM GA_TRANSACABO
      WHERE NUM_TRANSACCION = VP_TRANSACCION;

      IF ((SN_cod_retorno>0) AND (SN_cod_retorno IS NOT NULL)) THEN
         RAISE ERROR_EJECUCION;
      END IF;*/

      IF (VP_VAR3 <> '99')  OR (trim(VP_VAR3)='') OR (trim(VP_VAR3)='C') OR (VP_VAR3 IS NULL) THEN
         DBMS_OUTPUT.PUT_LINE('Antes de P_INTERFASES_ABONADOS('||VP_TRANSACCION||','||
         VP_ACTABO||','||VP_PRODUCTO||','||
         VP_ABONADO||','||VP_ORIGEN||','||VP_DESTINO||','||VP_VAR3||','||VP_VAR4||','||VP_VAR5||','||
         VP_VAR6||')');
         LV_sSql:='P_INTERFASES_ABONADOS ('||VP_TRANSACCION||','||VP_ACTABO||','||
         VP_PRODUCTO||','||VP_ABONADO||','||
         VP_ORIGEN||','||VP_DESTINO||','||VP_VAR3||','||VP_VAR4||','||VP_VAR5||','||VP_VAR6||'); ';
         P_Interfases_Abonados(VP_TRANSACCION,VP_ACTABO,VP_PRODUCTO,VP_ABONADO,VP_ORIGEN,VP_DESTINO,VP_VAR3,VP_VAR4,VP_VAR5,VP_VAR6);
         -- LV_sSql:='SELECT COD_RETORNO,DES_CADENA INTO SN_cod_retorno,SV_mens_retorno FROM GA_TRANSACABO WHERE NUM_TRANSACCION ='|| VP_TRANSACCION||'; ';
         SELECT COD_RETORNO,DES_CADENA
         INTO SN_cod_retorno,SV_mens_retorno
         FROM GA_TRANSACABO
         WHERE NUM_TRANSACCION = VP_TRANSACCION;

         IF ((SN_cod_retorno>0) AND (SN_cod_retorno IS NOT NULL)) THEN
            LV_sSql:='SELECT COD_RETORNO,DES_CADENA INTO SN_cod_retorno,SV_mens_retorno FROM GA_TRANSACABO WHERE NUM_TRANSACCION ='|| VP_TRANSACCION||'; ';
            RAISE ERROR_EJECUCION;
         END IF;
      ELSE
         V_VAR3 := TO_NUMBER(VP_VAR3);
         P_Datos_Abocel( VP_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
         V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,V_TELEFIJA,V_FECALTA,V_VENTA,V_INDFACT,
         V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
         IF (V_ERROR <> '0') THEN
            SN_cod_retorno := '4';
            RAISE ERROR_EJECUCION;
         END IF;
         VP_ORIGEN     := EO_REG_CAMB_PLAN_COMER.TIP_PLANTARIF;
         VP_DESTINO    := EO_REG_CAMB_PLAN_COMER.COD_PLANTARIF_NUEVO;

         DBMS_OUTPUT.PUT_LINE('VP_ORIGEN X'||VP_ORIGEN );
         V_FECSYS:=SYSDATE;
         V_EMPRESA:=0;
         V_HOLDING:=0;
         DBMS_OUTPUT.PUT_LINE('VP_DESTINO X'||VP_DESTINO );
         DBMS_OUTPUT.PUT_LINE('V_CICLO'||V_CICLO);
         DBMS_OUTPUT.PUT_LINE('V_FECSYS'||V_FECSYS);
         DBMS_OUTPUT.PUT_LINE('V_EMPRESA'||V_EMPRESA);
         DBMS_OUTPUT.PUT_LINE('V_HOLDING'||V_HOLDING);
         DBMS_OUTPUT.PUT_LINE('V_TIPPLANTARIF'||V_TIPPLANTARIF);
         DBMS_OUTPUT.PUT_LINE('V_VAR3'||V_VAR3);
         IF ge_log_pg.debug_activo THEN
            ge_log_pg.DEBUG( 'PV_REG_CAMB_PLAN_COMER_PR - SETEANDO PARAMETROS DE PV_PLAN_TARIF_CTASEG_CICLO_PR:');
            ge_log_pg.DEBUG( 'PV_REG_CAMB_PLAN_COMER_PR - VP_PRODUCTO :'||VP_PRODUCTO );
            ge_log_pg.DEBUG( 'PV_REG_CAMB_PLAN_COMER_PR - V_CLIENTE :'||V_CLIENTE );
            ge_log_pg.DEBUG( 'PV_REG_CAMB_PLAN_COMER_PR - VP_ABONADO :'||VP_ABONADO );
            ge_log_pg.DEBUG( 'PV_REG_CAMB_PLAN_COMER_PR - VP_ORIGEN :'||VP_ORIGEN );
            ge_log_pg.DEBUG( 'PV_REG_CAMB_PLAN_COMER_PR - VP_DESTINO :'||VP_DESTINO );
            ge_log_pg.DEBUG( 'PV_REG_CAMB_PLAN_COMER_PR - V_CICLO :'||V_CICLO );
            ge_log_pg.DEBUG( 'PV_REG_CAMB_PLAN_COMER_PR - V_EMPRESA :'||V_EMPRESA );
            ge_log_pg.DEBUG( 'PV_REG_CAMB_PLAN_COMER_PR - V_HOLDING :'||V_HOLDING );
            ge_log_pg.DEBUG( 'PV_REG_CAMB_PLAN_COMER_PR - V_TIPPLANTARIF :'||V_TIPPLANTARIF );
            ge_log_pg.DEBUG( 'PV_REG_CAMB_PLAN_COMER_PR - V_VAR3 :'||V_VAR3 );
            ge_log_pg.DEBUG( 'PV_REG_CAMB_PLAN_COMER_PR - V_ACTABO :'||VP_ACTABO ); -- COL|77090|30-01-2009|SAQL
         END IF;
         -- INI COL|77090|30-01-2009|SAQL
         --Pv_Plan_Tarif_Ctaseg_Ciclo_Pg.PV_PLAN_TARIF_CTASEG_CICLO_PR(VP_PRODUCTO,V_CLIENTE,VP_ABONADO,VP_ORIGEN,VP_DESTINO,V_CICLO,V_FECSYS,V_EMPRESA,V_HOLDING,V_TIPPLANTARIF,V_VAR3,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
         PV_PLAN_TARIF_CTASEG_CICLO_PG.PV_PLAN_TARIF_CTASEG_CICLO_PR(VP_PRODUCTO,V_CLIENTE,VP_ABONADO,VP_ORIGEN,VP_DESTINO,V_CICLO,V_FECSYS,V_EMPRESA,V_HOLDING,V_TIPPLANTARIF,V_VAR3,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR, VP_ACTABO);
         -- FIN COL|77090|30-01-2009|SAQL
         IF ge_log_pg.debug_activo THEN
            ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR - RETORNO V_ERROR:   '||V_ERROR );
            ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR - RETORNO VP_SQLCODE:'||VP_SQLCODE );
            ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR - RETORNO VP_SQLERRM:'||VP_SQLERRM );
         END IF;
         IF V_ERROR <> '0' THEN
            SN_cod_retorno := '4';
            RAISE ERROR_EJECUCION;
         END IF;
      END IF;
   END IF;
   IF ge_log_pg.debug_activo THEN
      ge_log_pg.DEBUG( 'PV_REG_CAMB_PLAN_COMER_PR - FIN LOG' );
   END IF;
EXCEPTION
   WHEN ERROR_PARAMETROS THEN
      SN_cod_retorno := 98;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error   := ' PV_REG_CAMB_PLAN_COMER_PR ('||TO_CHAR(EO_REG_CAMB_PLAN_COMER.NUM_TRANSACCION)||'); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_CAMB_PLAN_COMER_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_EJECUCION THEN
      LV_des_error   := ' PV_REG_CAMB_PLAN_COMER_PR ('||TO_CHAR(EO_REG_CAMB_PLAN_COMER.NUM_TRANSACCION)||'); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_CAMB_PLAN_COMER_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error   := ' PV_REG_CAMB_PLAN_COMER_PR ('||TO_CHAR(EO_REG_CAMB_PLAN_COMER.NUM_TRANSACCION)||'); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_CAMB_PLAN_COMER_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_REG_CAMB_PLAN_COMER_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------
--      3.1
    PROCEDURE PV_INSERT_ICGENERICA_TO_PR (Reg_PV_ICGENERICA_TO   IN                        Pv_Tipos_Pg.R_PV_ICGENERICA_TO,
                                                                                  SN_cod_retorno         OUT NOCOPY        ge_errores_td.cod_msgerror%TYPE,
                                                                                  SV_mens_retorno        OUT NOCOPY        ge_errores_td.det_msgerror%TYPE,
                                                                                  SN_num_evento          OUT NOCOPY                ge_errores_pg.evento)
    IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_INSERT_ICGENERICA_TO_PR "
              Lenguaje="PL/SQL"
              Fecha="11-07-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
                      <Descripción>   </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="Reg_PV_ICGENERICA_TO" Tipo="estructura">estructura de los datos Type </param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;
    BEGIN
                        LV_sSql:= '';
                        LV_sSql:= 'INSERT INTO PV_ICGENERICA_TO (NUM_MOVIMIENTO,VALOR1,VALOR2,VALOR3,VALOR4,VALOR5) ';
                        LV_sSql:= LV_sSql || ' VALUES ('|| Reg_PV_ICGENERICA_TO(1).NUM_MOVIMIENTO||','||Reg_PV_ICGENERICA_TO(1).VALOR1||',';
                        LV_sSql:= LV_sSql || Reg_PV_ICGENERICA_TO(1).VALOR2 ||','|| Reg_PV_ICGENERICA_TO(1).VALOR3 ||',';
                        LV_sSql:= LV_sSql || Reg_PV_ICGENERICA_TO(1).VALOR4 ||','|| Reg_PV_ICGENERICA_TO(1).VALOR5 ||') ';

                FORALL I IN Reg_PV_ICGENERICA_TO.FIRST .. Reg_PV_ICGENERICA_TO.LAST
            INSERT INTO PV_ICGENERICA_TO VALUES Reg_PV_ICGENERICA_TO(i);

        EXCEPTION
          WHEN OTHERS THEN
              SN_cod_retorno := 156;                                                                            --  4
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_INSERT_ICGENERICA_TO_PR('||TO_CHAR(Reg_PV_ICGENERICA_TO(1).NUM_MOVIMIENTO)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_INSERT_ICGENERICA_TO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PV_INSERT_ICGENERICA_TO_PR;


--------------------------------------------------------------------------------------------------------------------------------------------------
-- 3.- Método validaDesacListaFrecuente                                                                 (PV_PRODUCTO_CONTRATADO_PG.PV_VAL_DESAC_LIST_FREC_PR)
PROCEDURE PV_VAL_DESAC_LIST_FREC_PR(EO_ICGENERICA_TO       IN                           PV_ICGENERICA_TO_QT,
                                                                     SN_cod_retorno        OUT    NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                     SV_mens_retorno       OUT    NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                     SN_num_evento         OUT    NOCOPY        ge_errores_pg.evento)
IS
        LV_des_error                            ge_errores_pg.DesEvent;
        LV_sSql                                         ge_errores_pg.vQuery;
        ERROR_EJECUCION                 EXCEPTION;
        Reg_PV_ICGENERICA_TO            Pv_Tipos_Pg.R_PV_ICGENERICA_TO;
        i                                                       NUMBER(9);
BEGIN
        SN_cod_retorno  := 0;
        SN_num_evento   := 0;
        SV_mens_retorno := NULL;

                BEGIN
                    Reg_PV_ICGENERICA_TO(1).NUM_MOVIMIENTO:= EO_ICGENERICA_TO.NUM_MOVIMIENTO;
                    Reg_PV_ICGENERICA_TO(1).VALOR2        := EO_ICGENERICA_TO.LISTAACTIVA;
                    Reg_PV_ICGENERICA_TO(1).VALOR1        := NULL;
                    Reg_PV_ICGENERICA_TO(1).VALOR3        := NULL;
                    Reg_PV_ICGENERICA_TO(1).VALOR4        := NULL;
                    Reg_PV_ICGENERICA_TO(1).VALOR5        := NULL;
                        Pv_Producto_Contratado_Pg.PV_INSERT_ICGENERICA_TO_PR (Reg_PV_ICGENERICA_TO,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                EXCEPTION
                WHEN OTHERS THEN
                        RAISE ERROR_EJECUCION;
                END;
        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := ' PV_VAL_DESAC_LIST_FREC_PR('||TO_CHAR(EO_ICGENERICA_TO.NUM_MOVIMIENTO)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_VAL_DESAC_LIST_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_VAL_DESAC_LIST_FREC_PR('||TO_CHAR(EO_ICGENERICA_TO.NUM_MOVIMIENTO)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_VAL_DESAC_LIST_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_VAL_DESAC_LIST_FREC_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------
--   5.2
        PROCEDURE PV_OBTIENE_COD_FYFCEL_PR(EO_DESACT_SERVFREC   IN OUT NOCOPY   PV_DESACT_SERVFREC_QT,
                                                                              SN_cod_retorno    OUT    NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                              SV_mens_retorno   OUT    NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                              SN_num_evento     OUT    NOCOPY   ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_COD_FYFCEL_PR"
              Lenguaje="PL/SQL"
              Fecha="13-06-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_DESACT_SERVFREC" Tipo="estructura">estructura de los datos de un abonado</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;
                BEGIN
                        SN_cod_retorno  := 0;
                        SN_num_evento   := 0;
                    SV_mens_retorno := NULL;

                        LV_sSql:= 'SELECT COD_FYFCEL ';
                        LV_sSql:= LV_sSql || ' INTO  '|| EO_DESACT_SERVFREC.COD_FYFCEL || ' ';
                        LV_sSql:= LV_sSql || ' FROM   GA_DATOSGENER ';

                        SELECT COD_FYFCEL
                        INTO   EO_DESACT_SERVFREC.COD_FYFCEL
                        FROM   GA_DATOSGENER;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_COD_FYFCEL_PR('||' Tabla GA_DATOSGENER'||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_DESACT_SERV_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_COD_FYFCEL_PR('||' Tabla GA_DATOSGENER'||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_DESACT_SERV_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        END PV_OBTIENE_COD_FYFCEL_PR;


--------------------------------------------------------------------------------------------------------------------------------------------------
--   5.3
        PROCEDURE PV_OBTIENE_GA_SERVSUPL_PR(EO_DESACT_SERVFREC  IN OUT NOCOPY   PV_DESACT_SERVFREC_QT,
                                                                              SN_cod_retorno    OUT    NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                              SV_mens_retorno   OUT    NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                              SN_num_evento     OUT    NOCOPY   ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_GA_SERVSUPL_PR"
              Lenguaje="PL/SQL"
              Fecha="13-06-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_DESACT_SERVFREC" Tipo="estructura">estructura de los datos de un abonado</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;
                BEGIN
                        SN_cod_retorno  := 0;
                        SN_num_evento   := 0;
                    SV_mens_retorno := NULL;

                        LV_sSql:= 'SELECT COD_SERVSUPL,      ';
                        LV_sSql:= LV_sSql || ' COD_NIVEL   ';
                        LV_sSql:= LV_sSql || ' INTO  ';
                        LV_sSql:= LV_sSql || EO_DESACT_SERVFREC.COD_SERVSUPL    || ', ';
                        LV_sSql:= LV_sSql || EO_DESACT_SERVFREC.COD_NIVEL               || '  ';
                        LV_sSql:= LV_sSql || ' FROM   GA_SERVSUPL ';
                        LV_sSql:= LV_sSql || ' WHERE  COD_PRODUCTO = ' || EO_DESACT_SERVFREC.COD_PRODUCTO || ' ';
                        LV_sSql:= LV_sSql || ' AND    COD_SERVICIO = ' || EO_DESACT_SERVFREC.COD_FYFCEL   || ' ';
                        LV_sSql:= LV_sSql || ' AND    COD_NIVEL   <> ' || CN_COD_NIVEL || ' ';

                        SELECT COD_SERVSUPL,
                                   COD_NIVEL
                        INTO    EO_DESACT_SERVFREC.COD_SERVSUPL,
                                        EO_DESACT_SERVFREC.COD_NIVEL
                        FROM   GA_SERVSUPL
                        WHERE  COD_PRODUCTO = EO_DESACT_SERVFREC.COD_PRODUCTO
                        AND    COD_SERVICIO = EO_DESACT_SERVFREC.COD_FYFCEL
                        AND    COD_NIVEL   <> CN_COD_NIVEL;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_GA_SERVSUPL_PR('|| EO_DESACT_SERVFREC.COD_FYFCEL || ' ' || TO_CHAR(EO_DESACT_SERVFREC.COD_PRODUCTO) ||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_DESACT_SERV_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_GA_SERVSUPL_PR('|| EO_DESACT_SERVFREC.COD_FYFCEL || ' ' || TO_CHAR(EO_DESACT_SERVFREC.COD_PRODUCTO) ||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_DESACT_SERV_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_OBTIENE_GA_SERVSUPL_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------
--   5.4
        PROCEDURE PV_OBTIENE_GA_ACTUASERV_PR(EO_DESACT_SERVFREC IN OUT NOCOPY   PV_DESACT_SERVFREC_QT,
                                                                              SN_cod_retorno    OUT    NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                              SV_mens_retorno   OUT    NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                              SN_num_evento     OUT    NOCOPY   ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_GA_ACTUASERV_PR"
              Lenguaje="PL/SQL"
              Fecha="13-06-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_DESACT_SERVFREC" Tipo="estructura">estructura de los datos de un abonado</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;
                BEGIN
                        SN_cod_retorno  := 0;
                        SN_num_evento   := 0;
                    SV_mens_retorno := NULL;

                        LV_sSql:= 'SELECT COD_CONCEPTO      ';
                        LV_sSql:= LV_sSql || ' INTO  ';
                        LV_sSql:= LV_sSql || EO_DESACT_SERVFREC.COD_CONCEPTO    || ' ';
                        LV_sSql:= LV_sSql || ' FROM   GA_ACTUASERV ';
                        LV_sSql:= LV_sSql || ' WHERE  COD_PRODUCTO = ' || EO_DESACT_SERVFREC.COD_PRODUCTO || ' ';
                        LV_sSql:= LV_sSql || '        COD_TIPSERV  = ' || EO_DESACT_SERVFREC.COD_TIPSERV  || ' ';
                        LV_sSql:= LV_sSql || ' AND    COD_SERVICIO = ' || EO_DESACT_SERVFREC.COD_FYFCEL   || ' ';
                        LV_sSql:= LV_sSql || ' AND    COD_ACTABO  <> ' || EO_DESACT_SERVFREC.COD_ACTABO   || ' ';

                        SELECT COD_CONCEPTO
                        INTO    EO_DESACT_SERVFREC.COD_CONCEPTO
                        FROM   GA_ACTUASERV
                        WHERE  COD_PRODUCTO = EO_DESACT_SERVFREC.COD_PRODUCTO
                        AND    COD_TIPSERV  = EO_DESACT_SERVFREC.COD_TIPSERV
                        AND    COD_SERVICIO = EO_DESACT_SERVFREC.COD_FYFCEL
                        AND    COD_ACTABO   = EO_DESACT_SERVFREC.COD_ACTABO;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_GA_ACTUASERV_PR('|| EO_DESACT_SERVFREC.COD_FYFCEL || ' ' || TO_CHAR(EO_DESACT_SERVFREC.COD_PRODUCTO) ||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_DESACT_SERV_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_GA_ACTUASERV_PR('|| EO_DESACT_SERVFREC.COD_FYFCEL || ' ' || TO_CHAR(EO_DESACT_SERVFREC.COD_PRODUCTO) ||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_DESACT_SERV_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_OBTIENE_GA_ACTUASERV_PR;


--------------------------------------------------------------------------------------------------------------------------------------------------
--   5.5
        PROCEDURE PV_OBTIENE_COD_SERVFF_PR(EO_DESACT_SERVFREC   IN OUT NOCOPY   PV_DESACT_SERVFREC_QT,
                                                                              SN_cod_retorno    OUT    NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                              SV_mens_retorno   OUT    NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                              SN_num_evento     OUT    NOCOPY   ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_COD_SERVFF_PR "
              Lenguaje="PL/SQL"
              Fecha="13-06-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_DESACT_SERVFREC" Tipo="estructura">estructura de los datos de un abonado</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;
                BEGIN
                        SN_cod_retorno  := 0;
                        SN_num_evento   := 0;
                    SV_mens_retorno := NULL;

                        LV_sSql:= 'SELECT COD_SERVICIO INTO '|| EO_DESACT_SERVFREC.COD_SERVICIO_FF || ' ';
                        LV_sSql:= LV_sSql || ' FROM   GA_SERVSUPLABO WHERE  NUM_ABONADO = ' || EO_DESACT_SERVFREC.NUM_ABONADO || ' ';
                        LV_sSql:= LV_sSql || ' AND    COD_SERVICIO =  ' || EO_DESACT_SERVFREC.COD_FYFCEL  || ' ';
                        LV_sSql:= LV_sSql || ' AND    IND_ESTADO   <  ' || CN_IND_ESTADO || ' ';

                        SELECT COD_SERVICIO
                        INTO   EO_DESACT_SERVFREC.COD_SERVICIO_FF
                        FROM   GA_SERVSUPLABO
                        WHERE  NUM_ABONADO  = EO_DESACT_SERVFREC.NUM_ABONADO
                        AND    COD_SERVICIO = EO_DESACT_SERVFREC.COD_FYFCEL
                        AND    IND_ESTADO   <  CN_IND_ESTADO;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
                 EO_DESACT_SERVFREC.COD_SERVICIO_FF:=NULL;
                 SN_cod_retorno :=NULL;
                 SV_mens_retorno:=NULL;
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_COD_SERVFF_PR('|| EO_DESACT_SERVFREC.COD_FYFCEL || ' ' || TO_CHAR(EO_DESACT_SERVFREC.NUM_ABONADO) ||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_DESACT_SERV_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        END PV_OBTIENE_COD_SERVFF_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------
--   5.6
        PROCEDURE PV_OBTIENE_PLAN_FREC_PR(EO_DESACT_SERVFREC    IN OUT NOCOPY   PV_DESACT_SERVFREC_QT,
                                                                              SN_cod_retorno    OUT    NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                              SV_mens_retorno   OUT    NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                              SN_num_evento     OUT    NOCOPY   ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_PLAN_FREC_PR "
              Lenguaje="PL/SQL"
              Fecha="13-06-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_DESACT_SERVFREC" Tipo="estructura">estructura de los datos de un abonado</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;
                BEGIN
                        SN_cod_retorno  := 0;
                        SN_num_evento   := 0;
                    SV_mens_retorno := NULL;

                        LV_sSql:='SELECT plfr.IND_FF  INTO '|| EO_DESACT_SERVFREC.IND_FF || ' ';
                        LV_sSql:= LV_sSql || 'FROM  ta_planes_frecuentes   plfr, ';
                        LV_sSql:= LV_sSql || '      ta_plantarif                        pl   ';
                        LV_sSql:= LV_sSql || 'WHERE                                                ';
                        LV_sSql:= LV_sSql || '          plfr.COD_PRODUCTO  = ' || EO_DESACT_SERVFREC.COD_PRODUCTO        || ' ';

                        IF EO_DESACT_SERVFREC.IND_PLANTARIF=0 THEN
                           LV_sSql:= LV_sSql || 'AND    plfr.COD_PLANTARIF = ' || EO_DESACT_SERVFREC.COD_PLANTARIF_NUEVO || ' ';
                        ELSE
                                LV_sSql:= LV_sSql || 'AND       plfr.COD_PLANTARIF = ' || EO_DESACT_SERVFREC.COD_PLANTARIF_ACTUA || ' ';
                        END IF;

                        LV_sSql:= LV_sSql || 'AND   plfr.COD_PRODUCTO  = pl.COD_PRODUCTO        ';
                        LV_sSql:= LV_sSql || 'AND       plfr.COD_PLANTARIF = pl.COD_PLANTARIF   ';



                        IF EO_DESACT_SERVFREC.IND_PLANTARIF=0 THEN
                                SELECT plfr.IND_FF
                                INTO   EO_DESACT_SERVFREC.IND_FF
                                FROM TA_PLANES_FRECUENTES   plfr,
                                         TA_PLANTARIF                   pl
                                WHERE
                                         plfr.COD_PRODUCTO    = EO_DESACT_SERVFREC.COD_PRODUCTO
                                AND      plfr.COD_PLANTARIF   = EO_DESACT_SERVFREC.COD_PLANTARIF_NUEVO
                                AND  SYSDATE BETWEEN plfr.FEC_DESDE AND NVL(plfr.FEC_HASTA, SYSDATE)
                                AND  plfr.COD_PRODUCTO    = pl.COD_PRODUCTO
                                AND      plfr.COD_PLANTARIF   = pl.COD_PLANTARIF;
                        ELSE
                                SELECT plfr.IND_FF
                                INTO   EO_DESACT_SERVFREC.IND_FF
                                FROM TA_PLANES_FRECUENTES   plfr,
                                         TA_PLANTARIF                   pl
                                WHERE
                                         plfr.COD_PRODUCTO    = EO_DESACT_SERVFREC.COD_PRODUCTO
                                AND      plfr.COD_PLANTARIF   = EO_DESACT_SERVFREC.COD_PLANTARIF_ACTUA
                                AND  SYSDATE BETWEEN plfr.FEC_DESDE AND NVL(plfr.FEC_HASTA, SYSDATE)
                                AND  plfr.COD_PRODUCTO    = pl.COD_PRODUCTO
                                AND      plfr.COD_PLANTARIF   = pl.COD_PLANTARIF;

                        END IF;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_PLAN_FREC_PR('||EO_DESACT_SERVFREC.COD_PRODUCTO ||','|| EO_DESACT_SERVFREC.COD_PLANTARIF_NUEVO|| '); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_OBTIENE_PLAN_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_PLAN_FREC_PR('||EO_DESACT_SERVFREC.COD_PRODUCTO ||','|| EO_DESACT_SERVFREC.COD_PLANTARIF_NUEVO|| '); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_OBTIENE_PLAN_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        END PV_OBTIENE_PLAN_FREC_PR;


--------------------------------------------------------------------------------------------------------------------------------------------------
--   5.7
        PROCEDURE PV_ACTUAL_DESACT_SERVFF_PR (EO_DESACT_SERVFREC        IN                      PV_DESACT_SERVFREC_QT,
                                                                                    SN_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                                                    SV_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                                                    SN_num_evento       OUT NOCOPY              ge_errores_pg.evento)
    IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_ACTUAL_DESACT_SERVFF_PR "
              Lenguaje="PL/SQL"
              Fecha="13-06-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_DESACT_SERVFREC" Tipo="estructura">estructura de los datos de un abonado</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;
        BEGIN

                LV_sSql:= 'UPDATE GA_SERVSUPLABO SET IND_ESTADO  = '|| EO_DESACT_SERVFREC.IND_ESTADO  || ', ';
                LV_sSql:= LV_sSql || ' FEC_BAJABD  = '|| EO_DESACT_SERVFREC.FEC_BAJABD  || ', ';
                LV_sSql:= LV_sSql || ' FEC_BAJACEN = '|| EO_DESACT_SERVFREC.FEC_BAJACEN || '  ';
                LV_sSql:= LV_sSql || ' WHERE ';
                LV_sSql:= LV_sSql || ' NUM_ABONADO = ' || EO_DESACT_SERVFREC.NUM_ABONADO || ' ';
                LV_sSql:= LV_sSql || ' AND COD_SERVICIO = ' || EO_DESACT_SERVFREC.COD_FYFCEL|| ' ';
                LV_sSql:= LV_sSql || ' AND IND_ESTADO = ' || CN_IND_ESTADO|| ' ';


                UPDATE GA_SERVSUPLABO   SET IND_ESTADO  = EO_DESACT_SERVFREC.IND_ESTADO,
                                                                FEC_BAJABD  = EO_DESACT_SERVFREC.FEC_BAJABD,
                                                                        FEC_BAJACEN = EO_DESACT_SERVFREC.FEC_BAJACEN
                WHERE NUM_ABONADO = EO_DESACT_SERVFREC.NUM_ABONADO
                AND COD_SERVICIO  = EO_DESACT_SERVFREC.COD_FYFCEL
                AND IND_ESTADO    < CN_IND_ESTADO;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_ACTUAL_DESACT_SERVFF_PR ('||EO_DESACT_SERVFREC.COD_FYFCEL||' '||TO_CHAR(EO_DESACT_SERVFREC.NUM_ABONADO)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_DESACT_SERV_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_ACTUAL_DESACT_SERVFF_PR ('||EO_DESACT_SERVFREC.COD_FYFCEL||' '||TO_CHAR(EO_DESACT_SERVFREC.NUM_ABONADO)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_DESACT_SERV_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

     END PV_ACTUAL_DESACT_SERVFF_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------
--   5.8
    PROCEDURE PV_INSERT_DESACT_SERVFF_PR (EO_DESACT_SERVFREC    IN                        PV_DESACT_SERVFREC_QT,
                                                                                        Reg_ga_servsuplabo  IN                            Pv_Tipos_Pg.R_GA_SERVSUPLABO,
                                                                                    SN_cod_retorno      OUT NOCOPY        ge_errores_td.cod_msgerror%TYPE,
                                                                                    SV_mens_retorno     OUT NOCOPY        ge_errores_td.det_msgerror%TYPE,
                                                                                    SN_num_evento       OUT NOCOPY                ge_errores_pg.evento)
    IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_INSERT_DESACT_SERVFF_PR "
              Lenguaje="PL/SQL"
              Fecha="11-07-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
                      <Descripción>  </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_DESACT_SERVFREC" Tipo="estructura">estructura de los datos Type </param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;
    BEGIN
                        LV_sSql:='';
                        LV_sSql:= LV_sSql ||'INSERT INTO GA_SERVSUPLABO (NUM_ABONADO,COD_SERVICIO,FEC_ALTABD,COD_SERVSUPL,COD_NIVEL,COD_PRODUCTO,NUM_TERMINAL, ';
                        LV_sSql:= LV_sSql || ' NOM_USUARORA,IND_ESTADO,FEC_ALTACEN,FEC_BAJABD,FEC_BAJACEN,COD_CONCEPTO,NUM_DIASNUM) ';
                        LV_sSql:= LV_sSql || ' VALUES ('||Reg_ga_servsuplabo(1).NUM_ABONADO||','||Reg_ga_servsuplabo(1).COD_SERVICIO||','||Reg_ga_servsuplabo(1).FEC_ALTABD||', ';
                        LV_sSql:= LV_sSql || ''||Reg_ga_servsuplabo(1).COD_SERVSUPL||','||Reg_ga_servsuplabo(1).COD_NIVEL   ||','||Reg_ga_servsuplabo(1).COD_PRODUCTO      ||', ';
                        LV_sSql:= LV_sSql || ''||Reg_ga_servsuplabo(1).NUM_TERMINAL||','||Reg_ga_servsuplabo(1).NOM_USUARORA||','||Reg_ga_servsuplabo(1).IND_ESTADO        ||', ';
                        LV_sSql:= LV_sSql || ''||Reg_ga_servsuplabo(1).FEC_ALTACEN ||','||Reg_ga_servsuplabo(1).FEC_BAJABD  ||','||Reg_ga_servsuplabo(1).FEC_BAJACEN       ||', ';
                        LV_sSql:= LV_sSql || ''||Reg_ga_servsuplabo(1).COD_CONCEPTO||','||Reg_ga_servsuplabo(1).NUM_DIASNUM||') ';

                FORALL I IN Reg_ga_servsuplabo.FIRST .. Reg_ga_servsuplabo.LAST
            INSERT INTO GA_SERVSUPLABO VALUES Reg_ga_servsuplabo(i);

        EXCEPTION
          WHEN OTHERS THEN
              SN_cod_retorno := 4;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_INSERT_DESACT_SERVFF_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_DESACT_SERV_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PV_INSERT_DESACT_SERVFF_PR;


--------------------------------------------------------------------------------------------------------------------------------------------------
--5.-
PROCEDURE PV_REG_DESACT_SERV_FREC_PR(EO_DESACT_SERVFREC    IN OUT                               PV_DESACT_SERVFREC_QT,
                                                                     SN_cod_retorno           OUT         NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                     SV_mens_retorno          OUT         NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                     SN_num_evento            OUT         NOCOPY        ge_errores_pg.evento)
IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_REG_DESACT_SERV_FREC_PR "
              Lenguaje="PL/SQL"
              Fecha="11-07-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
                      <Descripción>  </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_DESACT_SERVFREC" Tipo="estructura">estructura de los datos Type </param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error                            ge_errores_pg.DesEvent;
        LV_sSql                                         ge_errores_pg.vQuery;
        ERROR_EJECUCION                 EXCEPTION;

        Reg_SERV_SUPLABO                        Pv_Tipos_Pg.R_GA_SERVSUPLABO;
        EO_GED_PARAMETROS                       PV_GED_PARAMETROS_QT;
        EO_SECUENCIA                            PV_SECUENCIA_QT;
        i                                                       NUMBER(9);
BEGIN
        SN_cod_retorno  := 0;
        SN_num_evento   := 0;
        SV_mens_retorno := NULL;

           --   Rescata Datos de Parametros Generales
                        EO_GED_PARAMETROS.NOM_PARAMETRO := 'COD_OPERTMOVIL';
                        EO_GED_PARAMETROS.COD_MODULO    := CV_cod_modulo;
                        EO_GED_PARAMETROS.COD_PRODUCTO  := EO_DESACT_SERVFREC.COD_PRODUCTO;
                        LV_sSql:='';
                        LV_sSql:=LV_sSql||'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR ('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                        Pv_Generales_Pg.PV_OBTIENE_GED_PARAMETROS_PR (EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno>0 THEN
                                RAISE ERROR_EJECUCION;
                        END IF;

           --   Rescata  codigo Servicio Friend
                        LV_sSql:='';
                        LV_sSql:=LV_sSql||'PV_PRODUCTO_CONTRATADO_PG.PV_OBTIENE_COD_FYFCEL_PR (EO_DESACT_SERVFREC,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                        Pv_Producto_Contratado_Pg.PV_OBTIENE_COD_FYFCEL_PR (EO_DESACT_SERVFREC,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno>0 THEN
                                RAISE ERROR_EJECUCION;
                        END IF;

           --   Rescata  Datos GA_SERVSUPL
                        EO_DESACT_SERVFREC.COD_PRODUCTO:= EO_DESACT_SERVFREC.COD_PRODUCTO;
                        EO_DESACT_SERVFREC.COD_FYFCEL  := EO_DESACT_SERVFREC.COD_FYFCEL;
                        LV_sSql:='';
                        LV_sSql:=LV_sSql||'PV_PRODUCTO_CONTRATADO_PG.PV_OBTIENE_GA_SERVSUPL_PR ('||EO_DESACT_SERVFREC.COD_PRODUCTO||','||EO_DESACT_SERVFREC.COD_FYFCEL||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                        Pv_Producto_Contratado_Pg.PV_OBTIENE_GA_SERVSUPL_PR (EO_DESACT_SERVFREC,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno>0 THEN
                                RAISE ERROR_EJECUCION;
                        END IF;

           --   Rescata  Datos GA_ACTUASERV    Cod_Concepto
                        EO_DESACT_SERVFREC.COD_PRODUCTO:= EO_DESACT_SERVFREC.COD_PRODUCTO;
                        EO_DESACT_SERVFREC.COD_TIPSERV := CV_COD_TIPSERV;
                        EO_DESACT_SERVFREC.COD_FYFCEL  := EO_DESACT_SERVFREC.COD_FYFCEL;
                        EO_DESACT_SERVFREC.COD_ACTABO  := CV_COD_ACTABO;
                        LV_sSql:='';
                        LV_sSql:=LV_sSql||'PV_PRODUCTO_CONTRATADO_PG.PV_OBTIENE_GA_ACTUASERV_PR ('||EO_DESACT_SERVFREC.COD_PRODUCTO||','||EO_DESACT_SERVFREC.COD_TIPSERV||','||EO_DESACT_SERVFREC.COD_FYFCEL||','||EO_DESACT_SERVFREC.COD_ACTABO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                        Pv_Producto_Contratado_Pg.PV_OBTIENE_GA_ACTUASERV_PR (EO_DESACT_SERVFREC,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno>0 THEN
                                RAISE ERROR_EJECUCION;
                        END IF;

           --   Rescata  codigo Servicio  FF   donde codigo del  codigo Servicio Friend query anterior
                        EO_DESACT_SERVFREC.NUM_ABONADO := EO_DESACT_SERVFREC.NUM_ABONADO;
                        EO_DESACT_SERVFREC.COD_FYFCEL  := EO_DESACT_SERVFREC.COD_FYFCEL;
                        EO_DESACT_SERVFREC.IND_ESTADO  := CN_IND_ESTADO;
                        LV_sSql:='';
                        LV_sSql:=LV_sSql||'PV_PRODUCTO_CONTRATADO_PG.PV_OBTIENE_COD_SERVFF_PR ('||EO_DESACT_SERVFREC.NUM_ABONADO||','||EO_DESACT_SERVFREC.COD_FYFCEL||','||EO_DESACT_SERVFREC.IND_ESTADO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                        Pv_Producto_Contratado_Pg.PV_OBTIENE_COD_SERVFF_PR (EO_DESACT_SERVFREC,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno>0 THEN
                                RAISE ERROR_EJECUCION;
                        END IF;


           --   Rescata datos del plan frecuente nuevo (por medio del plan tarifario nuevo accediendo a las tablas TA_PLANES_FRECUENTES, TA_PLANTARIF)
                        EO_DESACT_SERVFREC.IND_PLANTARIF:= 0;                   --  COD_PLANTARIF_NUEVO
                        LV_sSql:='';
                        LV_sSql:=LV_sSql||'PV_PRODUCTO_CONTRATADO_PG.PV_OBTIENE_PLAN_FREC_PR ('||EO_DESACT_SERVFREC.IND_PLANTARIF||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                        Pv_Producto_Contratado_Pg.PV_OBTIENE_PLAN_FREC_PR (EO_DESACT_SERVFREC,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno>0 THEN
                                RAISE ERROR_EJECUCION;
                        END IF;


                IF      EO_DESACT_SERVFREC.IND_FF = 0 OR EO_DESACT_SERVFREC.IND_FF IS NULL  THEN
                        IF      EO_DESACT_SERVFREC.COD_SERVICIO_FF IS NOT NULL  THEN

                                        EO_DESACT_SERVFREC.IND_PLANTARIF:= 1;    --  COD_PLANTARIF_ACTUAL
                                        LV_sSql:='';
                                        LV_sSql:=LV_sSql||'PV_PRODUCTO_CONTRATADO_PG.PV_OBTIENE_PLAN_FREC_PR ('||EO_DESACT_SERVFREC.IND_PLANTARIF||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                                        Pv_Producto_Contratado_Pg.PV_OBTIENE_PLAN_FREC_PR (EO_DESACT_SERVFREC,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                        IF SN_cod_retorno>0 THEN
                                                RAISE ERROR_EJECUCION;
                                        END IF;

                                        EO_DESACT_SERVFREC.IND_ESTADO  := 4;
                                        EO_DESACT_SERVFREC.FEC_BAJABD  := SYSDATE;
                                        EO_DESACT_SERVFREC.FEC_BAJACEN := SYSDATE;

                                        LV_sSql:='';
                                        LV_sSql:=LV_sSql||'PV_PRODUCTO_CONTRATADO_PG.PV_ACTUAL_DESACT_SERVFF_PR ('||EO_DESACT_SERVFREC.IND_ESTADO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';

                                        Pv_Producto_Contratado_Pg.PV_ACTUAL_DESACT_SERVFF_PR (EO_DESACT_SERVFREC,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                        IF SN_cod_retorno>0 THEN
                                                RAISE ERROR_EJECUCION;
                                        END IF;

                        ELSE
                        IF       EO_DESACT_SERVFREC.COD_SERVICIO_FF IS NULL THEN
                                --  INSERTAR
                                        EO_DESACT_SERVFREC.IND_ESTADO  := 2;
                                        EO_DESACT_SERVFREC.FEC_BAJABD  := SYSDATE;
                                        EO_DESACT_SERVFREC.FEC_BAJACEN := SYSDATE;
                                        EO_DESACT_SERVFREC.FEC_ALTABD  := SYSDATE;
                                        EO_DESACT_SERVFREC.FEC_ALTACEN := SYSDATE;

                                    Reg_SERV_SUPLABO(1).NUM_ABONADO   := EO_DESACT_SERVFREC.NUM_ABONADO;
                                    Reg_SERV_SUPLABO(1).COD_SERVICIO  := EO_DESACT_SERVFREC.COD_FYFCEL;
                                    Reg_SERV_SUPLABO(1).FEC_ALTABD    := EO_DESACT_SERVFREC.FEC_ALTABD;

                                    Reg_SERV_SUPLABO(1).COD_SERVSUPL  := EO_DESACT_SERVFREC.COD_SERVSUPL;
                                    Reg_SERV_SUPLABO(1).COD_NIVEL     := EO_DESACT_SERVFREC.COD_NIVEL;
                                    Reg_SERV_SUPLABO(1).COD_PRODUCTO  := EO_DESACT_SERVFREC.COD_PRODUCTO;
                                    Reg_SERV_SUPLABO(1).NUM_TERMINAL  := EO_DESACT_SERVFREC.NUM_CELULAR;
                                    Reg_SERV_SUPLABO(1).NOM_USUARORA  := EO_DESACT_SERVFREC.NOM_USUARORA;
                                    Reg_SERV_SUPLABO(1).IND_ESTADO    := EO_DESACT_SERVFREC.IND_ESTADO;
                                    Reg_SERV_SUPLABO(1).FEC_ALTACEN   := EO_DESACT_SERVFREC.FEC_ALTACEN;
                                    Reg_SERV_SUPLABO(1).FEC_BAJABD    := EO_DESACT_SERVFREC.FEC_BAJABD;
                                    Reg_SERV_SUPLABO(1).FEC_BAJACEN   := EO_DESACT_SERVFREC.FEC_BAJACEN;
                                    Reg_SERV_SUPLABO(1).COD_CONCEPTO  := EO_DESACT_SERVFREC.COD_CONCEPTO;

                                        -- Rescata Secuencia NUM_DIASNUM
                                        EO_SECUENCIA                  := Pv_Inicia_Estructuras_Pg.PV_SECUENCIA_QT_FN;
                                        EO_SECUENCIA.NOM_SECUENCIA:= GV_Nom_Secuencia;
                                        LV_sSql:='';
                                        LV_sSql:=LV_sSql||'PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR ('||GV_Nom_Secuencia||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                                        Pv_Generales_Pg.PV_OBTIENE_SECUENCIA_PR (EO_SECUENCIA,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                        IF SN_cod_retorno>0 THEN
                                                RAISE ERROR_EJECUCION;
                                        END IF;


                                        Reg_SERV_SUPLABO(1).NUM_DIASNUM:= EO_SECUENCIA.NUM_SECUENCIA;
--                                  SELECT GA_SEQ_NUMDIASNUM.NEXTVAL INTO Reg_SERV_SUPLABO(1).NUM_DIASNUM FROM DUAL;

                                        LV_sSql:='';
                                        LV_sSql:=LV_sSql||'PV_PRODUCTO_CONTRATADO_PG.PV_INSERT_DESACT_SERVFF_PR ('||Reg_SERV_SUPLABO(1).NUM_DIASNUM||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';

                                        Pv_Producto_Contratado_Pg.PV_INSERT_DESACT_SERVFF_PR (EO_DESACT_SERVFREC,Reg_SERV_SUPLABO,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                    IF SN_cod_retorno>0 THEN
                                                RAISE ERROR_EJECUCION;
                                        END IF;

                        END IF;
                        END IF;
        END IF;

        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := ' PV_REG_DESACT_SERV_FREC_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_DESACT_SERV_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_REG_DESACT_SERV_FREC_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_DESACT_SERV_FREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_REG_DESACT_SERV_FREC_PR;

----------------------------------------------------------------------------------------------------------
-- 6.-   Método:  registroCambPlanServ                                                                  (PV_PRODUCTO_CONTRATADO_PG.PV_REG_CAMBIOPLAN_SERV_PR)
PROCEDURE PV_REG_CAMB_PLAN_SERV_PR(EO_REG_CAMB_PLAN_SERV           IN                           PV_REG_CAMB_PLAN_SERV_QT,
                                                                     SN_cod_retorno                OUT    NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                     SV_mens_retorno               OUT    NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                     SN_num_evento                 OUT    NOCOPY        ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <ElementoPV_REG_CAMB_PLAN_SERV_PR"
                  Lenguaje="PL/SQL"
              Fecha="06-07-2007"
              Versión="La del package"
              Diseñador=
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Producto Contratado</Descripción>>
                  <Descripción>Este metodo esta encargado de informar el plan de servicio para lo cual se debe invocar al p_interfases_abonaados</Descripción>;
                  <Descripción>Esta información esta condicionada si el plan de servicio del abonado es distinto al plan de servicio </Descripción>;
                  <Descripción>del plan tarifario y tecnologia(GA_PLANTECPLSERV) </Descripción>;
              <Parámetros>
                 <Entrada>
                    <param nom="GA_PROD_CONTRATADO" Tipo="estructura"></param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error                            ge_errores_pg.DesEvent;
        LV_sSql                                         ge_errores_pg.vQuery;
        ERROR_EJECUCION                 EXCEPTION;
        VP_TRANSACCION                          VARCHAR2(09);
        VP_ACTABO                                       VARCHAR2(02);
        VP_PRODUCTO                                     VARCHAR2(01);
        VP_ABONADO                                      VARCHAR2(08);
        VP_ORIGEN                                       VARCHAR2(07);
        VP_DESTINO                                      VARCHAR2(03);
        VP_VAR3                                         VARCHAR2(09);
        VP_VAR4                                         VARCHAR2(03) := NULL;
        VP_VAR5                                         VARCHAR2(01) := NULL;
        VP_VAR6                                         VARCHAR2(08) := NULL;

BEGIN

        SN_num_evento   := 0;
        SV_mens_retorno := NULL;



                IF EO_REG_CAMB_PLAN_SERV.COD_TIPLAN = CN_prepago THEN

                        LV_sSQL := ' UPDATE GA_ABOAMIST ';
                        LV_sSql:= LV_sSql || ' SET COD_PLANSERV = '||EO_REG_CAMB_PLAN_SERV.COD_PLANSERV;
                        LV_sSql:= LV_sSql || '    ,COD_CARGOBASICO = '||EO_REG_CAMB_PLAN_SERV.COD_CARGOBASICO;
                        LV_sSql:= LV_sSql || ' WHERE  NUM_ABONADO = '||EO_REG_CAMB_PLAN_SERV.NUM_ABONADO;

                    UPDATE GA_ABOAMIST
                     SET COD_PLANSERV    = EO_REG_CAMB_PLAN_SERV.COD_PLANSERV,
                                 COD_CARGOBASICO = EO_REG_CAMB_PLAN_SERV.COD_CARGOBASICO
                     WHERE  NUM_ABONADO = EO_REG_CAMB_PLAN_SERV.NUM_ABONADO;

                ELSE
                 IF EO_REG_CAMB_PLAN_SERV.COD_TIPLAN = CN_pospago THEN

                                VP_TRANSACCION:= TO_CHAR(EO_REG_CAMB_PLAN_SERV.NUM_TRANSACCION);
                                VP_ACTABO         := EO_REG_CAMB_PLAN_SERV.COD_ACTABO;
                                VP_PRODUCTO       := TO_CHAR(EO_REG_CAMB_PLAN_SERV.COD_PRODUCTO);
                                VP_ABONADO        := TO_CHAR(EO_REG_CAMB_PLAN_SERV.NUM_ABONADO);
                                VP_ORIGEN         := EO_REG_CAMB_PLAN_SERV.COD_PLANSERV; --ocb 1-11-2007
                                VP_DESTINO        := EO_REG_CAMB_PLAN_SERV.COD_PLANTARIF_NUEVO;
                                VP_VAR3           := TO_CHAR(EO_REG_CAMB_PLAN_SERV.COD_HOLDING);

                                LV_sSQL := '';
                                LV_sSQL := LV_sSQL||'P_INTERFASES_ABONADOS ('||VP_TRANSACCION||','|| VP_ACTABO||','|| VP_PRODUCTO||','|| VP_ABONADO||','|| VP_ORIGEN||','|| VP_DESTINO||','|| VP_VAR3||','|| VP_VAR4||','|| VP_VAR5||','|| VP_VAR6||')';

                                P_Interfases_Abonados (VP_TRANSACCION,VP_ACTABO,VP_PRODUCTO,VP_ABONADO,VP_ORIGEN,VP_DESTINO,VP_VAR3,VP_VAR4,VP_VAR5,VP_VAR6);

                                LV_sSQL := '';
                                LV_sSQL := LV_sSQL||'SELECT COD_RETORNO, DES_CADENA INTO SN_cod_retorno, SV_mens_retorno FROM GA_TRANSACABO ';
                                LV_sSQL := LV_sSQL||'WHERE num_transaccion = '||VP_TRANSACCION||'; ';

                                --  Aqui se rescata el Codigo y mensaje de Error producido en la Ejecucion del pAckage existente :
                                SELECT COD_RETORNO, DES_CADENA INTO SN_cod_retorno, SV_mens_retorno FROM GA_TRANSACABO
                                WHERE num_transaccion = VP_TRANSACCION;
                                IF SN_cod_retorno > 0 THEN
                                        RAISE ERROR_EJECUCION;
                                END IF;

                  END IF;




                END IF;

        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_REG_CAMB_PLAN_SERV_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_CAMB_PLAN_SERV_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_REG_CAMB_PLAN_SERV_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_CAMB_PLAN_SERV_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_REG_CAMB_PLAN_SERV_PR;

----------------------------------------------------------------------------------------------------------
-- 7  Metodo :  validaCuentaPersonal
        FUNCTION PV_VALIDA_CUENTA_PERSONAL_FN(EO_NUMCEL_PERS       IN                   PV_NUMCEL_PERS_QT,
                                                                      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                                                                      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                                                                      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)
        RETURN VARCHAR2
        IS
         /*
        <Documentación
          TipoDoc = "FUNCTION">>
           <Elemento
              Nombre = "PV_VALIDA_CUENTA_PERSONAL_FN"
              Lenguaje="PL/SQL"
              Fecha="03-07-2007"
              Versión="La del package"
              Diseñador="Juan Gonzalez C."
              Programador="Juan Gonzalez C."
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Este metodo  esta asociado a la validación de cuenta personal </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_CUENTA" Tipo="estructura">estructura para datos de cuenta personal</param>>
                 </Entrada>
                 <Salida>
                    <param nom="" Tipo=""></param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error                            ge_errores_pg.DesEvent;
                LV_sSql                                         ge_errores_pg.vQuery;
                Reg_ga_numcel_personal_to       Pv_Tipos_Pg.R_GA_NUMCEL_PERSONAL_TO;
                LN_cod_retorno                          NUMBER;

        BEGIN

                SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;
                LN_cod_retorno  := 0;


                Reg_ga_numcel_personal_to(1).num_cel_pers  := EO_NUMCEL_PERS.NUM_CELULAR_PERS;

            LV_sSql := 'LN_cod_retorno := GA_NUMCEL_PERSONAL_PG. GA_EXISTE_NUMPERSONAL_FN ('||Reg_ga_numcel_personal_to(1).num_cel_pers||')';

            LN_cod_retorno := Ga_Numcel_Personal_Pg.GA_EXISTE_NUMPERSONAL_FN (Reg_ga_numcel_personal_to(1).num_cel_pers);

            IF LN_cod_retorno = 0 THEN
               RETURN 'FALSE';
                        ELSE
                           RETURN 'TRUE';
            END IF;


        EXCEPTION
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_VALIDA_CUENTA_PERSONAL_PR('||EO_NUMCEL_PERS.NUM_CELULAR_PERS||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_VALIDA_CUENTA_PERSONAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_VALIDA_CUENTA_PERSONAL_FN;

--------------------------------------------------------------------------------------------------------
--8.- Metodo  :         Obterner cambio de Plantarifario Servicio    PV_OBTENER_CAMB_PLAN_SERV_PR
        PROCEDURE PV_OBTENER_CAMB_PLAN_SERV_PR (EO_OBT_CAMB_PLAN_SERV   IN OUT              PV_OBT_CAMB_PLAN_SERV_QT,
                                                                                    SN_cod_retorno                 OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                                    SV_mens_retorno                OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                                    SN_num_evento                  OUT NOCOPY   ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTENER_CAMB_PLAN_SERV_PR  "
              Lenguaje="PL/SQL"
              Fecha="01-08-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Metodo  :  Obterner cambio de Plantarifario Servicio    </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_OBT_CAMB_PLAN_SERV"                                          Tipo="estructura">estructura Type de Datos                        </param>>
                    <param nom="EO_OBT_CAMB_PLAN_SERV.COD_TECNOLOGIA"           Tipo="estructura">Codigo Tecnologixo                              </param>>
                    <param nom="EO_OBT_CAMB_PLAN_SERV.COD_PLANTARIF_NUEVO"  Tipo="estructura">Codigo plantarifario nuevo          </param>>
                    <param nom="EO_OBT_CAMB_PLAN_SERV.COD_PLANSERV_NUEVO"       Tipo="estructura">Codigo plantarifario obtenido nuevo </param>>
                 </Entrada>
                 <Salida>
                    <param nom="EO_OBT_CAMB_PLAN_SERV.COD_PLANSERV_NUEVO"       Tipo="estructura">Codigo plantarifario obtenido nuevo </param>>
                    <param nom="SN_cod_retorno"                                         Tipo="NUMERICO">Codigo de Retorno                  </param>>
                    <param nom="SV_mens_retorno"                                        Tipo="CARACTER">Mensaje de Retorno                 </param>>
                    <param nom="SN_num_evento" T                                        ipo="NUMERICO">Numero de Evento                    </param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error                            ge_errores_pg.DesEvent;
                LV_sSql                                         ge_errores_pg.vQuery;


        BEGIN
                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;

                        LV_sSql:= '';
                        LV_sSql:= 'SELECT COD_PLANSERV INTO   EO_OBT_CAMB_PLAN_SERV.COD_PLANSERV_NUEVO FROM GA_PLANTECPLSERV ';
                        LV_sSql:= LV_sSql || ' WHERE COD_PRODUCTO = '||CN_producto||' ';
                        LV_sSql:= LV_sSql || ' AND COD_TECNOLOGIA = '||EO_OBT_CAMB_PLAN_SERV.COD_TECNOLOGIA||' ';
                        LV_sSql:= LV_sSql || ' AND COD_PLANTARIF  = '||EO_OBT_CAMB_PLAN_SERV.COD_PLANTARIF_NUEVO||' ';
                        LV_sSql:= LV_sSql || ' AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE) ';

                        SELECT COD_PLANSERV INTO EO_OBT_CAMB_PLAN_SERV.COD_PLANSERV_NUEVO FROM GA_PLANTECPLSERV
                        WHERE COD_PRODUCTO   = CN_producto
                        AND   COD_TECNOLOGIA = EO_OBT_CAMB_PLAN_SERV.COD_TECNOLOGIA
                        AND   COD_PLANTARIF  = EO_OBT_CAMB_PLAN_SERV.COD_PLANTARIF_NUEVO
                        AND   SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 1365;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTENER_CAMB_PLAN_SERV_PR('||EO_OBT_CAMB_PLAN_SERV.COD_TECNOLOGIA||', '||EO_OBT_CAMB_PLAN_SERV.COD_PLANTARIF_NUEVO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_OBTENER_CAMB_PLAN_SERV_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTENER_CAMB_PLAN_SERV_PR('||EO_OBT_CAMB_PLAN_SERV.COD_TECNOLOGIA||', '||EO_OBT_CAMB_PLAN_SERV.COD_PLANTARIF_NUEVO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_OBTENER_CAMB_PLAN_SERV_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_OBTENER_CAMB_PLAN_SERV_PR;

----------------------------------------------------------------------------------------------------------
--9.- Metodo  :     obtenerCausaBaja                                                     PV_OBTENER_CAUSA_BAJA_PR
        PROCEDURE PV_OBTENER_CAUSA_BAJA_PR (SO_CAUSABAJA       OUT NOCOPY       refCursor,
                                                                                SN_cod_retorno     OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                                SV_mens_retorno    OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                                SN_num_evento      OUT NOCOPY   ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTENER_CAUSA_BAJA_PR  "
              Lenguaje="PL/SQL"
              Fecha="09-08-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Metodo  :  Obterner cursor de Causas de Baja    </Descripción>>
              <Parámetros>
                 <Entrada>
                 </Entrada>
                 <Salida>
                    <param nom="SO_CAUSABAJA"               Tipo="Cursor">  Retorna datos en un Cursor : SO_CAUSABAJA  </param>>
                    <param nom="SN_cod_retorno"                 Tipo="NUMERICO">Codigo de Retorno                                                  </param>>
                    <param nom="SV_mens_retorno"                Tipo="CARACTER">Mensaje de Retorno                                                 </param>>
                    <param nom="SN_num_evento" T                Tipo="NUMERICO">Numero de Evento                                                   </param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error                            ge_errores_pg.DesEvent;
                LV_sSql                                         ge_errores_pg.vQuery;
                ERROR_EJECUCION                 EXCEPTION;
                LV_causaBaja                            GA_CAUSABAJA.cod_causabaja%TYPE;
                EO_GED_PARAMETROS                       PV_GED_PARAMETROS_QT;
        BEGIN
                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;
        EO_GED_PARAMETROS := Pv_Inicia_Estructuras_Pg.PV_GED_PARAMETROS_QT_FN;

           --   Rescata Datos de Parametros Generales
                        EO_GED_PARAMETROS.NOM_PARAMETRO := GV_Nom_Cod_Optaamistar;
                        EO_GED_PARAMETROS.COD_MODULO    := CV_cod_modulo;
                        EO_GED_PARAMETROS.COD_PRODUCTO  := CN_producto;
                        LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR ('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                        Pv_Generales_Pg.PV_OBTIENE_GED_PARAMETROS_PR (EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno>0 THEN
                                RAISE ERROR_EJECUCION;
                        END IF;
                        LV_causaBaja:=EO_GED_PARAMETROS.VAL_PARAMETRO;

                        LV_sSql:='';
                        LV_sSql:=LV_sSql||'OPEN SO_CAUSABAJA FOR ';
                        LV_sSql:=LV_sSql||'SELECT DES_CAUSABAJA,';
                        LV_sSql:=LV_sSql||'        COD_CAUSABAJA,';
                        LV_sSql:=LV_sSql||'        IND_LN,';
                        LV_sSql:=LV_sSql||'        IND_COBRO, ';
                        LV_sSql:=LV_sSql||'        IND_PORTABLE ';
                        LV_sSql:=LV_sSql||'FROM GA_CAUSABAJA ';
                        LV_sSql:=LV_sSql||'WHERE ';
                        LV_sSql:=LV_sSql||'              COD_PRODUCTO  = '||CN_producto    ||'  ';
                        LV_sSql:=LV_sSql||'     AND  IND_VIGENCIA  = '||CN_Ind_Vigencia||'  ';
                        LV_sSql:=LV_sSql||'     AND  COD_CAUSABAJA = '||LV_causaBaja   ||'; ';

                        OPEN SO_CAUSABAJA FOR
                                SELECT DES_CAUSABAJA,
                                           COD_CAUSABAJA,
                                           IND_LN,
                                           IND_COBRO,
                                           IND_PORTABLE
                                FROM GA_CAUSABAJA
                                WHERE
                                          COD_PRODUCTO  = CN_producto
                                AND   IND_VIGENCIA  = CN_Ind_Vigencia
                                AND   COD_CAUSABAJA = LV_causaBaja;


        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_OBTENER_CAUSA_BAJA_PR('||CN_producto||','||CN_Ind_Vigencia||','||LV_causaBaja||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_OBTENER_CAUSA_BAJA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 1528;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTENER_CAUSA_BAJA_PR('||CN_producto||','||CN_Ind_Vigencia||','||LV_causaBaja||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_OBTENER_CAUSA_BAJA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTENER_CAUSA_BAJA_PR('||CN_producto||','||CN_Ind_Vigencia||','||LV_causaBaja||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_OBTENER_CAUSA_BAJA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_OBTENER_CAUSA_BAJA_PR;

----------------------------------------------------------------------------------------------------------
    --  10.- Metodo :  registraTraspasoPlan

PROCEDURE PV_REG_TRASPASO_PLAN_PR (EO_TRASPASO_PLAN        IN     PV_TRASPASO_PLAN_QT,
                                   SN_cod_retorno          OUT    NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno         OUT    NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento           OUT    NOCOPY    ge_errores_pg.evento)
IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_REG_TRASPASO_PLAN_PR"
              Lenguaje="PL/SQL"
              Fecha="22-08-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Elizabeth Vera"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
                      <Descripción>Registra plan en tabla historica</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="PV_TRASPASO_PLAN_QT" Tipo="estructura">estructura de los datos Type </param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error                            ge_errores_pg.DesEvent;
        LV_sSql                                 ge_errores_pg.vQuery;
        LV_COD_SUBCUENTA_NUE_AUX                GA_SUBCUENTAS.COD_SUBCUENTA%TYPE;
        LV_COD_SUBCUENTA_ANT_AUX                GA_SUBCUENTAS.COD_SUBCUENTA%TYPE;
        LV_NUM_CELULAR                          GA_TRASPABO.NUM_TERMINAL%TYPE;  -- RRG COL 13-05-2009 88850
        lv_ind_traspaso                         GA_TRASPABO.IND_TRASPASO%TYPE; -- INI FPP P_COL_09044 22-07-2010
        lv_count_aboamist                       NUMBER :=0; -- INI FPP P_COL_09044 22-07-2010 

BEGIN
        SN_cod_retorno  := 0;
        SN_num_evento   := 0;
        SV_mens_retorno := NULL;

        LV_COD_SUBCUENTA_NUE_AUX:=EO_TRASPASO_PLAN.COD_SUBCTANUE;
        LV_COD_SUBCUENTA_ANT_AUX:=EO_TRASPASO_PLAN.COD_SUBCTAANT;


        IF EO_TRASPASO_PLAN.COD_SUBCTANUE IS NULL THEN
           SELECT  MAX(COD_SUBCUENTA)
           INTO LV_COD_SUBCUENTA_NUE_AUX
           FROM  GA_SUBCUENTAS
           WHERE COD_CUENTA = EO_TRASPASO_PLAN.COD_CUENTANUE;
        END IF;

        IF EO_TRASPASO_PLAN.COD_SUBCTAANT IS NULL THEN
           SELECT  MAX(COD_SUBCUENTA)
           INTO LV_COD_SUBCUENTA_ANT_AUX
           FROM  GA_SUBCUENTAS
           WHERE COD_CUENTA = EO_TRASPASO_PLAN.COD_CUENTAANT;
        END IF;

        --163239
        --INICIO RRG COL 13-05-2009 88850
        
        LV_NUM_CELULAR := EO_TRASPASO_PLAN.NUM_TERMINAL;

        IF EO_TRASPASO_PLAN.NUM_TERMINAL IS NULL
                                                                         OR EO_TRASPASO_PLAN.NUM_TERMINAL = 'G'
                                                                         OR upper(EO_TRASPASO_PLAN.NUM_TERMINAL) = 'NULL'  THEN
           select to_char(num_celular)
           INTO LV_NUM_CELULAR
           from (
           select num_celular  from ga_aboamist where num_abonado = EO_TRASPASO_PLAN.NUM_ABONADOANT
           union all
           select num_celular  from ga_abocel where num_abonado = EO_TRASPASO_PLAN.NUM_ABONADOANT
           ) where rownum=1;

        end if;
        ---INICIO RRG COL 13-05-2009 88850

        -- INI FPP P_COL_09044 22-07-2010
        /*
            se valida si el ind_traspaso es null, y el abonado anterior corresponde a un prepago, para rescatar la información 
            correspondiente al ind_trapaso desde la tabla ged_codigos
        */     
        IF (EO_TRASPASO_PLAN.IND_TRASPASO IS NULL ) THEN
        
            SELECT COUNT(1)
            INTO lv_count_aboamist 
            FROM GA_ABOAMIST 
            WHERE NUM_ABONADO =  EO_TRASPASO_PLAN.NUM_ABONADOANT
            AND COD_CLIENTE = EO_TRASPASO_PLAN.COD_CLIENANT;
            
            IF lv_count_aboamist> 0 THEN
                lv_ind_traspaso := 'PRP'; -- IND_TRASPASO CORRESPONDIENTE A PREPAGO-POSTPAGO
            ELSE
                SELECT COUNT(1)
                INTO lv_count_aboamist 
                FROM GA_ABOCEL 
                WHERE NUM_ABONADO =  EO_TRASPASO_PLAN.NUM_ABONADOANT
                AND COD_CLIENTE = EO_TRASPASO_PLAN.COD_CLIENANT;
                IF lv_count_aboamist> 0 THEN
                    lv_ind_traspaso := 'POP'; -- IND_TRASPASO CORRESPONDIENTE A POSTPAGO-PREPAGO
                ELSE
                    lv_ind_traspaso := EO_TRASPASO_PLAN.IND_TRASPASO;
                END IF;                
            END IF;
        
             
        ELSE
            lv_ind_traspaso := EO_TRASPASO_PLAN.IND_TRASPASO;
        END IF;
        -- FIN FPP P_COL_09044 22-07-2010 


        INSERT INTO GA_TRASPABO(NUM_ABONADO,
                                FEC_MODIFICA,
                                COD_CLIENNUE,
                                COD_CUENTANUE,
                                COD_SUBCTANUE,
                                COD_USUARNUE,
                                COD_PRODUCTO,
                                NUM_TERMINAL,
                                NUM_ABONADOANT,
                                COD_CLIENANT,
                                COD_CUENTAANT,
                                COD_SUBCTAANT,
                                COD_USUARANT,
                                IND_TRASDEUDA,
                                NOM_USUARORA,
                                IND_TRASPASO,
                                COD_PLANTARIF_ORIG,
                                COD_PLANTARIF_DEST,
                                COD_VENDEDOR)
                                VALUES (EO_TRASPASO_PLAN.NUM_ABONADO,
                                            SYSDATE,
                                            EO_TRASPASO_PLAN.COD_CLIENUE,
                                            EO_TRASPASO_PLAN.COD_CUENTANUE,
                                            LV_COD_SUBCUENTA_NUE_AUX,
                                            EO_TRASPASO_PLAN.COD_USUARNUE,
                                            EO_TRASPASO_PLAN.COD_PRODUCTO,
                                            --EO_TRASPASO_PLAN.NUM_TERMINAL, -- RRG COL 13-05-2009 88850
                                            LV_NUM_CELULAR,                  -- RRG COL 13-05-2009 88850
                                            EO_TRASPASO_PLAN.NUM_ABONADOANT,
                                            EO_TRASPASO_PLAN.COD_CLIENANT,
                                            EO_TRASPASO_PLAN.COD_CUENTAANT,
                                            LV_COD_SUBCUENTA_ANT_AUX,
                                            EO_TRASPASO_PLAN.COD_USUARANT,
                                            EO_TRASPASO_PLAN.IND_TRASDEUDA,
                                            EO_TRASPASO_PLAN.NOM_USUARORA,
                                            --EO_TRASPASO_PLAN.IND_TRASPASO,  -- INI FPP P_COL_09044 22-07-2010
                                            lv_ind_traspaso, -- INI FPP P_COL_09044 22-07-2010
                                            EO_TRASPASO_PLAN.COD_PLANTARIF_ORIG,
                                            EO_TRASPASO_PLAN.COD_PLANTARIF_DEST,
                                            EO_TRASPASO_PLAN.COD_VENDEDOR);


        EXCEPTION
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_REG_TRASPASO_PLAN_PR ('||TO_CHAR(EO_TRASPASO_PLAN.NUM_ABONADO)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_TRASPASO_PLAN_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_REG_TRASPASO_PLAN_PR;

END Pv_Producto_Contratado_Pg;
/
