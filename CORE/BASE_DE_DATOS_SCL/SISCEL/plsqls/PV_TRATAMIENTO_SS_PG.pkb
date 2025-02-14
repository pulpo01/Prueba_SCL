CREATE OR REPLACE PACKAGE BODY PV_TRATAMIENTO_SS_PG AS

PROCEDURE PV_REGLA_SS_ACTIVOS_PR(EN_num_abonado            IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                 EV_cod_plantarif_origen   IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                 EV_cod_plan_destino       IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                 SN_cod_retorno            OUT NOCOPY GE_ERRORES_PG.CodError,
                                 SV_mens_retorno           OUT NOCOPY GE_ERRORES_PG.MsgError,
                                 SN_num_evento             OUT NOCOPY GE_ERRORES_PG.Evento)
/*
<Documentación
TipoDoc = "Procedure">
 <Elemento
    Nombre = "PV_REGLA_SS_ACTIVOS_PR
    Lenguaje="PL/SQL"
    Fecha="14-12-2006"
    Versión="1.0"
    Diseñador="Manuel Acevedo M"
    Programador="Manuel Acevedo M."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Es el encargado de validar de no volver a activar, por el plan nuevo,;
                     servicios suplementarios ya activos para el abonado.>
    <Parámetros>
       <Entrada>EN_num_abonado : Numero de Abonado</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS

    LN_fila1             NUMBER;
    LN_fila2             NUMBER;

    LV_ser_contr         GA_SERVSUPL.COD_SERVICIO%TYPE;
    LN_ser_contr         GA_SERVSUPL.COD_SERVSUPL%TYPE;
    LN_niv_contr         GA_SERVSUPL.COD_NIVEL%TYPE;
    LN_servsupl_nuevo    GA_SERVSUPL.COD_SERVSUPL%TYPE;
    LN_niv_nuevo         GA_SERVSUPL.COD_NIVEL%TYPE;
    LV_acc_nuevo         VARCHAR2(1);

    LV_error             VARCHAR2(5);
    LV_cambio_producto   VARCHAR2(5);

    LV_des_error         GE_ERRORES_PG.DesEvent;
    sSql                 GE_ERRORES_PG.vQuery;

    FIN_EJECUCION        EXCEPTION;

BEGIN

    IF SN_cod_retorno <> 0 THEN
       RAISE FIN_EJECUCION;
    END IF;

    LN_fila1:=0;
    LN_fila2:=0;

    SN_cod_retorno   := 0;
    SV_mens_retorno  := 'OK';
    SN_num_evento    := 0;

    sSql :='PV_existe_cambio_producto_FN('|| EN_num_abonado ||','|| EV_cod_plantarif_origen  ||','|| EV_cod_plan_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
    LV_cambio_producto := PV_TRATAMIENTO_SS_PG.PV_EXISTE_CAMBIO_PRODUCTO_FN(EN_num_abonado,EV_cod_plantarif_origen ,EV_cod_plan_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener cambio de producto',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error al obtener cambio de producto';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;


    FOR LN_fila1 IN 0..ind_contratados - 1 LOOP

        LV_ser_contr := tab_contratados(LN_fila1).t_v_cod_servicio;
        LN_ser_contr := tab_contratados(LN_fila1).t_v_cod_servsupl;
        LN_niv_contr := tab_contratados(LN_fila1).t_v_cod_nivel;

        FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

            LN_servsupl_nuevo := tab_nuevo(LN_fila2).t_v_cod_servsupl;
            LN_niv_nuevo      := tab_nuevo(LN_fila2).t_v_cod_nivel;
            LV_acc_nuevo      := tab_nuevo(LN_fila2).t_v_cod_accion;

            IF ((LN_ser_contr = LN_servsupl_nuevo) AND (LN_niv_contr <> LN_niv_nuevo) AND (LV_acc_nuevo = CV_a))  THEN
               -- MARCAMOS SERVICIO CONTRATADO CON ACCION DESACTIVAR --
               tab_contratados(LN_fila1).t_v_cod_accion:=CV_d;

               sSql :='PV_CONSULTA_SS_LIGADOS_PR('|| EN_num_abonado || ',' || LV_ser_contr ||','|| CV_d ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
               PV_TRATAMIENTO_SS_PG.PV_CONSULTA_SS_LIGADOS_PR(EN_num_abonado,LV_ser_contr,CV_d,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

               IF  SN_cod_retorno <> 0 THEN
                   LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener servicio suplementario ligado.',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                   SN_cod_retorno   := 4;
                   SV_mens_retorno  := 'Error al obtener servicio suplementario ligado.';
                   SN_num_evento    := 0;
                   RAISE FIN_EJECUCION;
               END IF;

            END IF;

            IF (LN_ser_contr = LN_servsupl_nuevo) AND (LN_niv_contr = LN_niv_nuevo) AND (LV_acc_nuevo = CV_a)  THEN
               -- MARCAMOS SERVICIO CONTRATADO Y NUEVO CON ACCION MANTENER SOLO SI NO EXISTE CAMBIO DE PRODUCTO --

               IF LV_cambio_producto= 'TRUE' THEN
                  tab_contratados(LN_fila1).t_v_cod_accion:=CV_d;

                  sSql :='PV_CONSULTA_SS_LIGADOS_PR('|| EN_num_abonado || ',' || LV_ser_contr ||','|| CV_d ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
                  PV_TRATAMIENTO_SS_PG.PV_CONSULTA_SS_LIGADOS_PR(EN_num_abonado,LV_ser_contr,CV_d,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                  IF  SN_cod_retorno <> 0 THEN
                      LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener servicio suplementario ligado.',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                      SN_cod_retorno   := 4;
                      SV_mens_retorno  := 'Error al obtener servicio suplementario ligado.';
                      SN_num_evento    := 0;
                      RAISE FIN_EJECUCION;
                  END IF;

			   ELSE
                  tab_contratados(LN_fila1).t_v_cod_accion:=CV_m;
                  tab_nuevo(LN_fila2).t_v_cod_accion:=CV_m;

                  sSql :='PV_CONSULTA_SS_LIGADOS_PR('|| EN_num_abonado || ',' || LV_ser_contr ||','|| CV_m ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
                  PV_TRATAMIENTO_SS_PG.PV_CONSULTA_SS_LIGADOS_PR(EN_num_abonado,LV_ser_contr,CV_m,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                  IF SN_cod_retorno <> 0 THEN
                     LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener servicio suplementario ligado.',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                     SN_cod_retorno   := 4;
                     SV_mens_retorno  := 'Error al obtener servicio suplementario ligado.';
                     SN_num_evento    := 0;
                     RAISE FIN_EJECUCION;
                  END IF;

			   END IF;

            END IF;

        END LOOP;

    END LOOP;

    dbms_output.PUT_LINE('TAB_CONTRATADOS ----------');
    FOR I IN 0..ind_contratados - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_contratados(I).t_v_origen||' | '||tab_contratados(I).t_v_cod_accion||' | '||tab_contratados(I).t_v_cod_servicio||' | '||tab_contratados(I).t_v_cod_servsupl||' | '||tab_contratados(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_NUEVO ----------');
    FOR I IN 0..ind_nuevo - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_nuevo(I).t_v_origen||' | '||tab_nuevo(I).t_v_cod_accion||' | '||tab_nuevo(I).t_v_cod_servicio||' | '||tab_nuevo(I).t_v_cod_servsupl||' | '||tab_nuevo(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_PERFILES ----------');
    FOR I IN 0..ind_perfiles - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_perfiles(I).t_v_origen||' | '||tab_perfiles(I).t_v_cod_accion||' | '||tab_perfiles(I).t_v_cod_servicio||' | '||tab_perfiles(I).t_v_cod_servsupl||' | '||tab_perfiles(I).t_v_cod_nivel||' | ');
    END LOOP;

EXCEPTION
    WHEN FIN_EJECUCION THEN
         NULL;
    WHEN NO_DATA_FOUND THEN
         SN_cod_retorno   := 4;
         SV_mens_retorno  := 'No se encuentra datos';
         SN_num_evento    := 0;
         LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No existen datos.'  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    WHEN OTHERS THEN
         SN_cod_retorno   := 4;
         SV_mens_retorno  := CV_error_no_clasif;
         LV_des_error     := 'PV_REGLA_SS_ACTIVOS_PR(' || EN_num_abonado || ',' || EV_cod_plantarif_origen || ',' || EV_cod_plan_destino || ')';
         SN_num_evento    := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
         'PV_TRATAMIENTO_SS_PG.PV_REGLA_SS_ACTIVOS_PR', sSql, SQLCODE, LV_des_error );
         LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
END PV_REGLA_SS_ACTIVOS_PR;

PROCEDURE PV_REGLA_DUPLICADOS_PR(SN_cod_retorno    OUT NOCOPY GE_ERRORES_PG.CodError,
                                 SV_mens_retorno   OUT NOCOPY GE_ERRORES_PG.MsgError,
                                 SN_num_evento     OUT NOCOPY GE_ERRORES_PG.Evento)
/*
<Documentación
TipoDoc = "Procedure">
 <Elemento
    Nombre = "PV_REGLA_DUPLICADOS_PR
    Lenguaje="PL/SQL"
    Fecha="14-12-2006"
    Versión="1.0"
    Diseñador="Manuel Acevedo M"
    Programador="Manuel Acevedo M."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Encargado de validar los servicios suplementarios ya activos>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/

IS

LN_fila1             NUMBER;
LN_fila2             NUMBER;

LV_ori_contr         VARCHAR2(3);
LN_ser_contr         GA_SERVSUPL.COD_SERVSUPL%TYPE;
LN_servsupl_nuevo    GA_SERVSUPL.COD_SERVSUPL%TYPE;
LV_acc_nuevo         VARCHAR2(1);

LV_des_error         GE_ERRORES_PG.DesEvent;
sSql                 GE_ERRORES_PG.vQuery;

FIN_EJECUCION        EXCEPTION;

LV_error             VARCHAR2(5);

BEGIN

    IF SN_cod_retorno <> 0 THEN
       RAISE FIN_EJECUCION;
    END IF;

    LN_fila1:=0;
    LN_fila2:=0;

    SN_cod_retorno   := 0;
    SV_mens_retorno  := 'OK';
    SN_num_evento    := 0;

    FOR LN_fila1 IN 0..ind_contratados - 1 LOOP

        LV_ori_contr:=tab_contratados(LN_fila1).t_v_origen;
        LN_ser_contr:=tab_contratados(LN_fila1).t_v_cod_servsupl;

        IF (LV_ori_contr = CV_tra OR LV_ori_contr = CV_con) THEN

           FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

               LN_servsupl_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servsupl;
               LV_acc_nuevo:=tab_nuevo(LN_fila2).t_v_cod_accion;

               IF (LN_ser_contr = LN_servsupl_nuevo) AND (LV_acc_nuevo=CV_a) THEN
                  -- MARCAMOS SERVICIO CONTRATADO CON ACCION NO CONSIDERAR--
                  tab_contratados(LN_fila1).t_v_cod_accion:=CV_n;
               END IF;

           END LOOP;

        END IF;

    END LOOP;

    dbms_output.PUT_LINE('TAB_CONTRATADOS ----------');
    FOR I IN 0..ind_contratados - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_contratados(I).t_v_origen||' | '||tab_contratados(I).t_v_cod_accion||' | '||tab_contratados(I).t_v_cod_servicio||' | '||tab_contratados(I).t_v_cod_servsupl||' | '||tab_contratados(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_NUEVO ----------');
    FOR I IN 0..ind_nuevo - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_nuevo(I).t_v_origen||' | '||tab_nuevo(I).t_v_cod_accion||' | '||tab_nuevo(I).t_v_cod_servicio||' | '||tab_nuevo(I).t_v_cod_servsupl||' | '||tab_nuevo(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_PERFILES ----------');
    FOR I IN 0..ind_perfiles - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_perfiles(I).t_v_origen||' | '||tab_perfiles(I).t_v_cod_accion||' | '||tab_perfiles(I).t_v_cod_servicio||' | '||tab_perfiles(I).t_v_cod_servsupl||' | '||tab_perfiles(I).t_v_cod_nivel||' | ');
    END LOOP;

EXCEPTION
    WHEN FIN_EJECUCION THEN
         NULL;
    WHEN NO_DATA_FOUND THEN
         SN_cod_retorno   := 4;
         SV_mens_retorno  := 'No se encuentra datos';
         SN_num_evento    := 0;
         LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No existen datos.'  ,0,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    WHEN OTHERS THEN
         SN_cod_retorno   := 4;
         SV_mens_retorno:= CV_error_no_clasif;
         LV_des_error := 'PV_REGLA_DUPLICADOS_PR()';
         SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
         'PV_TRATAMIENTO_SS_PG.PV_REGLA_DUPLICADOS_PR', sSql, SQLCODE, LV_des_error );
         LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,0,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

END PV_REGLA_DUPLICADOS_PR;

PROCEDURE PV_REGLA_SS_SMS_ONDEMAND_PR(EN_num_abonado            IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                      EV_cod_plantarif_origen   IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                      EV_cod_plan_destino       IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                      SN_cod_retorno            OUT NOCOPY GE_ERRORES_PG.CodError,
                                      SV_mens_retorno           OUT NOCOPY GE_ERRORES_PG.MsgError,
                                      SN_num_evento             OUT NOCOPY GE_ERRORES_PG.Evento)
/*
<Documentación
TipoDoc = "Procedure">
 <Elemento
    Nombre = "PV_REGLA_SS_SMS_ONDEMAND_PR
    Lenguaje="PL/SQL"
    Fecha="14-12-2006"
    Versión="1.0"
    Diseñador="Manuel Acevedo M"
    Programador="Manuel Acevedo M."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Encargado de validar los servicios suplementarios SMS ON DEMAND>
    <Parámetros>
       <Entrada>EN_num_abonado : Numero de Abonado</Entrada>
       <Entrada>EV_cod_plan_destino: Plan Tarifario Destino</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/

IS

LN_fila1                  NUMBER;
LN_fila2                  NUMBER;
LN_fila3                  NUMBER;

LV_ori_contr              VARCHAR2(3);
LN_ser_contr              GA_SERVSUPL.COD_SERVSUPL%TYPE;
LN_niv_contr              GA_SERVSUPL.COD_NIVEL%TYPE;
LN_servsupl_nuevo         GA_SERVSUPL.COD_SERVSUPL%TYPE;
LN_niv_nuevo              GA_SERVSUPL.COD_NIVEL%TYPE;
LV_ori_nuevo              VARCHAR2(3);
LN_servsupl_nuevo2        GA_SERVSUPL.COD_SERVSUPL%TYPE;
LN_niv_nuevo2             GA_SERVSUPL.COD_NIVEL%TYPE;
LV_ori_nuevo2             VARCHAR2(3);

LV_cambio_producto        VARCHAR2(5);

LN_grupo_sms              NUMBER;

LV_tip_terminal           GA_ABOCEL.TIP_TERMINAL%TYPE;
LV_cod_tecnologia         GA_ABOCEL.COD_TECNOLOGIA%TYPE;
LV_cod_plan_tarif         GA_ABOCEL.COD_PLANTARIF%TYPE;
LN_cod_central            GA_ABOCEL.COD_CENTRAL%TYPE;
LN_num_celular            GA_ABOCEL.NUM_CELULAR%TYPE;
LN_cod_sistema            ICG_CENTRAL.COD_SISTEMA%TYPE;

-- Variables para contener la respuesta si es abonado o plan atlantida ---
LV_abonado_atlantida      VARCHAR2(5);
LV_plantarif_atlantida    VARCHAR2(5);

LV_error                  VARCHAR2(5);

LN_existe2                NUMBER;
LN_fila_existe2           NUMBER;

LV_des_error              GE_ERRORES_PG.DesEvent;
sSql                      GE_ERRORES_PG.vQuery;

FIN_EJECUCION             EXCEPTION;

BEGIN

    IF SN_cod_retorno <> 0 THEN
       RAISE FIN_EJECUCION;
    END IF;

    LN_fila1:=0;
    LN_fila2:=0;
    LN_fila3:=0;

    SN_cod_retorno   := 0;
    SV_mens_retorno  := 'OK';
    SN_num_evento    := 0;
    LV_cod_plan_tarif :=EV_cod_plantarif_origen;

    BEGIN
        sSql :='SELECT TO_NUMBER(a.valor_texto)  ';
        sSql :=sSql || 'FROM  ga_parametros_simples_vw a ';
        sSql :=sSql || 'WHERE a.nom_parametro = ' || CV_grupo_sms_on_demand;
        sSql :=sSql || 'AND   a.cod_modulo    = ' || CV_mo_ga;
        sSql :=sSql || 'AND    a.cod_operadora = (SELECT b.valor_texto ';
        sSql :=sSql || 'FROM   ge_parametros_sistema_vw b ';
        sSql :=sSql || 'WHERE  b.nom_parametro =' || CV_op_local;
        sSql :=sSql || 'AND    b.cod_modulo =' || CV_mo_ge;

        SELECT TO_NUMBER(a.valor_texto)
        INTO   LN_grupo_sms
        FROM   ga_parametros_simples_vw a
        WHERE  a.nom_parametro = CV_grupo_sms_on_demand
        AND    a.cod_modulo    = CV_mo_ga
        AND    a.cod_operadora = (SELECT b.valor_texto
                                  FROM   ge_parametros_sistema_vw b
                                  WHERE  b.nom_parametro = CV_op_local
                                  AND    b.cod_modulo    = CV_mo_ge);

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No se encuentra valor asociado a parametro '|| CV_grupo_sms_on_demand,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                 SN_cod_retorno   := 4;
                 SV_mens_retorno  := 'No se encuentra valor asociado a parametro '|| CV_grupo_sms_on_demand;
                 SN_num_evento    := 0;
                 RAISE FIN_EJECUCION;
    END;

    PV_RECUPERA_DATOS_ABONADO_PR(EN_num_abonado,LV_tip_terminal,LV_cod_tecnologia,  LV_cod_plan_tarif ,LN_cod_central,LN_num_celular,LN_cod_sistema,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener Datos del Abonado',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error al obtener Datos del Abonado';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;

    sSql :='PV_existe_cambio_producto_FN('|| EN_num_abonado ||','|| EV_cod_plantarif_origen  ||','|| EV_cod_plan_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
    LV_cambio_producto := PV_TRATAMIENTO_SS_PG.PV_EXISTE_CAMBIO_PRODUCTO_FN(EN_num_abonado,EV_cod_plantarif_origen ,EV_cod_plan_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener cambio de producto',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error al obtener cambio de producto';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;

    --- LLamada al package para obtener abonado atlantida ----
    sSql :='pv_obtieneinfo_atlantida_pg.pv_existeaboatlantida2_pr('|| EN_num_abonado ||','|| LV_Abonado_Atlantida ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
    pv_obtieneinfo_atlantida_pg.pv_existeaboatlantida2_pr(EN_num_abonado,LV_Abonado_Atlantida,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener abonado atlantida',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error para obtener abonado atlantida';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;

    --- LLamada a función para obtener plan atlantida ----
    sSql :='PV_PLAN_DESTINO_ATLANTIDA_FN('|| EV_cod_plan_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
    LV_plantarif_atlantida := PV_TRATAMIENTO_SS_PG.PV_PLAN_DESTINO_ATLANTIDA_FN(EV_cod_plan_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener plan atlantida',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error para obtener plan atlantida';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;

    IF LV_cambio_producto = 'FALSE' THEN
       -- SE MANTIENE EL PRODUCTO --

       FOR LN_fila1 IN 0..ind_contratados - 1 LOOP

           LV_ori_contr:=tab_contratados(LN_fila1).t_v_origen;
           LN_ser_contr:=tab_contratados(LN_fila1).t_v_cod_servsupl;
           LN_niv_contr:=tab_contratados(LN_fila1).t_v_cod_nivel;

           LN_existe2      := 0;
           LN_fila_existe2 := 0;
           IF (LN_ser_contr = LN_grupo_sms) AND (LV_ori_contr = CV_opc)  THEN
              --EXISTE (1) --
              FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

                  LV_ori_nuevo:=tab_nuevo(LN_fila2).t_v_origen;
                  LN_servsupl_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servsupl;
                  LN_niv_nuevo:=tab_nuevo(LN_fila2).t_v_cod_nivel;

                  IF (LN_ser_contr = LN_servsupl_nuevo) AND (LN_niv_contr = LN_niv_nuevo) AND (LV_ori_nuevo = CV_opc)  THEN
                     LN_existe2 := 1;
                     LN_fila_existe2 := LN_fila2;
                  END IF;

              END LOOP;

              IF LN_existe2 = 1 THEN
                 -- EXISTE (2) --
                 IF LV_plantarif_atlantida = 'TRUE' OR LV_Abonado_Atlantida = 'TRUE' THEN
                    -- SI SON ATLANTIDA...
                    tab_contratados(LN_fila1).t_v_cod_accion:=CV_d;
                    tab_nuevo(LN_fila_existe2).t_v_cod_accion:=CV_a;
                 ELSE
                    tab_contratados(LN_fila1).t_v_cod_accion:=CV_m;
                    tab_nuevo(LN_fila_existe2).t_v_cod_accion:=CV_m;
                 END IF;

                 -- SE BUSCA SMS CON ORIGEN DEF EN MATRIZ PLAN NUEVO
                 FOR LN_fila3 IN 0..ind_nuevo - 1 LOOP

                     LV_ori_nuevo2:=tab_nuevo(LN_fila3).t_v_origen;
                     LN_servsupl_nuevo2:=tab_nuevo(LN_fila3).t_v_cod_servsupl;
                     LN_niv_nuevo2:=tab_nuevo(LN_fila3).t_v_cod_nivel;

                     IF (LN_servsupl_nuevo2 = LN_grupo_sms) AND (LV_ori_nuevo2 = CV_def)  THEN
                        tab_nuevo(LN_fila3).t_v_cod_accion:=CV_n;
                     END IF;

                 END LOOP;

              ELSE
                 -- NO EXISTE (2) --
                 tab_contratados(LN_fila1).t_v_cod_accion:=CV_d;

                 FOR LN_fila3 IN 0..ind_nuevo - 1 LOOP

                     LV_ori_nuevo2:=tab_nuevo(LN_fila3).t_v_origen;
                     LN_servsupl_nuevo2:=tab_nuevo(LN_fila3).t_v_cod_servsupl;
                     LN_niv_nuevo2:=tab_nuevo(LN_fila3).t_v_cod_nivel;
                     IF (LN_servsupl_nuevo2 = LN_grupo_sms) AND (LV_ori_nuevo2 = CV_def)  THEN
                        tab_nuevo(LN_fila3).t_v_cod_accion:=CV_a;
                     END IF;

                 END LOOP;

              END IF;

           END IF;

       END LOOP;

    ELSE
       -- NO SE MANTIENE EL PRODUCTO --
       LN_fila1:=0;
       LN_fila2:=0;

       FOR LN_fila1 IN 0..ind_contratados - 1 LOOP

           LV_ori_contr:=tab_contratados(LN_fila1).t_v_origen;
           LN_ser_contr:=tab_contratados(LN_fila1).t_v_cod_servsupl;

           IF (LN_ser_contr = LN_grupo_sms) AND (LV_ori_contr = CV_def OR LV_ori_contr = CV_opc)  THEN
              -- MARCAMOS SERVICIO CONTRATADO CON ACCION DESACTIVAR --
              tab_contratados(LN_fila1).t_v_cod_accion:=CV_d;
           END IF;

       END LOOP;

       FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

           LV_ori_nuevo:=tab_nuevo(LN_fila2).t_v_origen;
           LN_servsupl_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servsupl;

           IF (LN_servsupl_nuevo = LN_grupo_sms) AND (LV_ori_nuevo = CV_def)  THEN
              -- MARCAMOS SERVICIO CONTRATADO CON ACCION ACTIVAR --
              tab_nuevo(LN_fila2).t_v_cod_accion:=CV_a;
           END IF;

       END LOOP;

    END IF;


    dbms_output.PUT_LINE('TAB_CONTRATADOS ----------');
    FOR I IN 0..ind_contratados - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_contratados(I).t_v_origen||' | '||tab_contratados(I).t_v_cod_accion||' | '||tab_contratados(I).t_v_cod_servicio||' | '||tab_contratados(I).t_v_cod_servsupl||' | '||tab_contratados(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_NUEVO ----------');
    FOR I IN 0..ind_nuevo - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_nuevo(I).t_v_origen||' | '||tab_nuevo(I).t_v_cod_accion||' | '||tab_nuevo(I).t_v_cod_servicio||' | '||tab_nuevo(I).t_v_cod_servsupl||' | '||tab_nuevo(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_PERFILES ----------');
    FOR I IN 0..ind_perfiles - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_perfiles(I).t_v_origen||' | '||tab_perfiles(I).t_v_cod_accion||' | '||tab_perfiles(I).t_v_cod_servicio||' | '||tab_perfiles(I).t_v_cod_servsupl||' | '||tab_perfiles(I).t_v_cod_nivel||' | ');
    END LOOP;

EXCEPTION
    WHEN FIN_EJECUCION THEN
         NULL;
    WHEN NO_DATA_FOUND THEN
         SN_cod_retorno   := 4;
         SV_mens_retorno  := 'No se encuentra datos';
         SN_num_evento    := 0;
         LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No existen datos.'  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    WHEN OTHERS THEN
         SN_cod_retorno   := 4;
         SV_mens_retorno:= CV_error_no_clasif;
         LV_des_error := 'PV_REGLA_SS_SMS_ONDEMAND_PR(' || EN_num_abonado || ',' || EV_cod_plan_destino ||')';
         SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
         'PV_TRATAMIENTO_SS_PG.PV_REGLA_SS_SMS_ONDEMAND_PR', sSql, SQLCODE, LV_des_error );
         LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

END PV_REGLA_SS_SMS_ONDEMAND_PR;

PROCEDURE PV_REGLA_SS_WAPGPRSMMSROA_PR(EN_num_abonado             IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                       EV_cod_plantarif_origen    IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                       EV_cod_plan_destino        IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                       SN_cod_retorno             OUT NOCOPY GE_ERRORES_PG.CodError,
                                       SV_mens_retorno            OUT NOCOPY GE_ERRORES_PG.MsgError,
                                       SN_num_evento              OUT NOCOPY GE_ERRORES_PG.Evento)
/*
<Documentación
TipoDoc = "Procedure">
 <Elemento
    Nombre = "PV_REGLA_SS_WAPGPRSMMSROA_PR"
    Lenguaje="PL/SQL"
    Fecha="14-12-2006"
    Versión="1.0"
    Diseñador="Manuel Acevedo M"
    Programador="Manuel Acevedo M."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Encargado de validar los servicios suplementarios WAP-GPRS, MMS, ROAMING>
    <Parámetros>
       <Entrada>EN_num_abonado : Numero de Abonado</Entrada>
       <Entrada>EV_cod_plan_destino: Plan Tarifario Destino</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/

IS

LN_fila1             NUMBER;
LN_fila2             NUMBER;
LN_fila21            NUMBER;

LN_pos               NUMBER;
LV_grupo_ss          VARCHAR2(6);

LV_ori_contr         VARCHAR2(3);
LV_ser_contr         GA_SERVSUPL.COD_SERVICIO%TYPE;
LN_ser_contr         GA_SERVSUPL.COD_SERVSUPL%TYPE;
LN_niv_contr         GA_SERVSUPL.COD_NIVEL%TYPE;
LN_servsupl_nuevo    GA_SERVSUPL.COD_SERVSUPL%TYPE;
LN_niv_nuevo         GA_SERVSUPL.COD_NIVEL%TYPE;
LV_ori_nuevo         VARCHAR2(3);

LV_cambio_producto   VARCHAR2(5);

LV_tip_terminal      GA_ABOCEL.TIP_TERMINAL%TYPE;
LV_cod_tecnologia    GA_ABOCEL.COD_TECNOLOGIA%TYPE;
LV_cod_plan_tarif    GA_ABOCEL.COD_PLANTARIF%TYPE;
LN_cod_central       GA_ABOCEL.COD_CENTRAL%TYPE;
LN_num_celular       GA_ABOCEL.NUM_CELULAR%TYPE;
LN_cod_sistema       ICG_CENTRAL.COD_SISTEMA%TYPE;

LN_grupo                  NUMBER;
LV_grupos_wap_mms_roa     VARCHAR2(250);

-- Variables para contener la respuesta si es abonado o plan atlantida ---
LV_abonado_atlantida      VARCHAR2(5);
LV_plantarif_atlantida    VARCHAR2(5);

LV_error             VARCHAR2(5);

LN_existe1           NUMBER;
LN_existe2           NUMBER;
LN_existe3           NUMBER;
LN_existe5           NUMBER;

LN_contratados       BINARY_INTEGER;

LV_des_error         GE_ERRORES_PG.DesEvent;
sSql                 GE_ERRORES_PG.vQuery;

FIN_EJECUCION        EXCEPTION;

CURSOR CURSOR_GRUPOS_WAP_MMS_ROA IS
SELECT valor_numerico a
FROM   ga_parametros_multiples_vw a
WHERE  a.cod_modulo    = CV_mo_ga
AND    a.nom_parametro = CV_grupos_wap_mms_roa
AND    a.cod_operadora = (SELECT b.valor_texto
                          FROM   ge_parametros_sistema_vw b
                          WHERE  b.nom_parametro = CV_op_local
                          AND    b.cod_modulo    = CV_mo_ge);

BEGIN

    IF SN_cod_retorno <> 0 THEN
       RAISE FIN_EJECUCION;
    END IF;

    LN_fila1:=0;
    LN_fila2:=0;
    LN_fila21 :=0;

    LV_grupos_wap_mms_roa:='';

    SN_cod_retorno   := 0;
    SV_mens_retorno  := 'OK';
    SN_num_evento    := 0;
    LV_cod_plan_tarif :=EV_cod_plantarif_origen;
    PV_RECUPERA_DATOS_ABONADO_PR(EN_num_abonado,LV_tip_terminal,LV_cod_tecnologia,LV_cod_plan_tarif,LN_cod_central,LN_num_celular,LN_cod_sistema,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener Datos del Abonado',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error al obtener Datos del Abonado';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;

    --- LLamada a función para si existe cambio de producto----
    sSql :='PV_existe_cambio_producto_FN('|| EN_num_abonado ||','|| EV_cod_plantarif_origen ||','|| EV_cod_plan_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
    LV_cambio_producto :=  PV_TRATAMIENTO_SS_PG.PV_EXISTE_CAMBIO_PRODUCTO_FN(EN_num_abonado,EV_cod_plantarif_origen,EV_cod_plan_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener cambio de producto',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error al obtener cambio de producto';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;

    --- LLamada al package para obtener abonado atlantida ----
    sSql :='pv_obtieneinfo_atlantida_pg.pv_existeaboatlantida2_pr('|| EN_num_abonado ||','|| LV_Abonado_Atlantida ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
    pv_obtieneinfo_atlantida_pg.pv_existeaboatlantida2_pr(EN_num_abonado,LV_Abonado_Atlantida,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener abonado atlantida',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error para obtener abonado atlantida';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;

    --- LLamada a función para obtener plan atlantida ----
    sSql :='PV_PLAN_DESTINO_ATLANTIDA_FN('|| EV_cod_plan_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
    LV_plantarif_atlantida := PV_TRATAMIENTO_SS_PG.PV_PLAN_DESTINO_ATLANTIDA_FN(EV_cod_plan_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener plan atlantida',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error para obtener plan atlantida';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;


    OPEN CURSOR_GRUPOS_WAP_MMS_ROA;
    LOOP
        FETCH CURSOR_GRUPOS_WAP_MMS_ROA INTO LN_grupo;
        EXIT WHEN CURSOR_GRUPOS_WAP_MMS_ROA%NOTFOUND;

        IF LV_grupos_wap_mms_roa IS NULL THEN
           LV_grupos_wap_mms_roa := TO_CHAR(LN_grupo);
        ELSE
           LV_grupos_wap_mms_roa := LV_grupos_wap_mms_roa ||','|| TO_CHAR(LN_grupo);
        END IF;

    END LOOP;
    CLOSE CURSOR_GRUPOS_WAP_MMS_ROA;

    IF LV_grupos_wap_mms_roa IS NULL THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener Servicios Suplementarios.',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       RAISE FIN_EJECUCION;
    END IF;

    LN_existe1:=0;

    LN_contratados:=ind_contratados;

    FOR LN_fila1 IN 0..ind_contratados - 1 LOOP

        LV_ori_contr:=tab_contratados(LN_fila1).t_v_origen;
        LV_ser_contr:=tab_contratados(LN_fila1).t_v_cod_servicio;
        LN_ser_contr:=tab_contratados(LN_fila1).t_v_cod_servsupl;
        LN_niv_contr:=tab_contratados(LN_fila1).t_v_cod_nivel;

        LN_existe2:=0;

        LV_grupo_ss := LTRIM(TO_CHAR(LN_ser_contr,'00'));

        LN_pos:=NVL(INSTR(LV_grupos_wap_mms_roa,TO_CHAR(LV_grupo_ss)),0);

        IF (LV_ori_contr = CV_def OR LV_ori_contr = CV_opc) AND LN_pos <> 0 THEN
           -- EXISTE(1) --
           LN_existe1:=1;

           FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

               LV_ori_nuevo      :=tab_nuevo(LN_fila2).t_v_origen;
               LN_servsupl_nuevo :=tab_nuevo(LN_fila2).t_v_cod_servsupl;
               LN_niv_nuevo      :=tab_nuevo(LN_fila2).t_v_cod_nivel;

               IF (LN_ser_contr = LN_servsupl_nuevo) AND (LN_niv_contr = LN_niv_nuevo) AND (LV_ori_nuevo = CV_def) THEN
                  --- EXISTE(2) --
                  LN_existe2:=1;

                  IF LV_plantarif_atlantida = 'TRUE' OR LV_Abonado_Atlantida = 'TRUE' THEN
                     -- SI SON ATLANTIDA...
                     tab_contratados(LN_fila1).t_v_cod_accion:=CV_d;
                     tab_nuevo(LN_fila2).t_v_cod_accion:=CV_a;
                  ELSE
                     tab_contratados(LN_fila1).t_v_cod_accion:=CV_m;
                     tab_nuevo(LN_fila2).t_v_cod_accion:=CV_m;
                  END IF;
               END IF;
           END LOOP;

           IF LN_existe2 = 0 THEN
              --- NO EXISTE(2) --
              LN_fila2  :=0;
              LN_existe3:=0;

              FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

                  LV_ori_nuevo      :=tab_nuevo(LN_fila2).t_v_origen;
                  LN_servsupl_nuevo :=tab_nuevo(LN_fila2).t_v_cod_servsupl;
                  LN_niv_nuevo      :=tab_nuevo(LN_fila2).t_v_cod_nivel;

                  IF (LN_ser_contr = LN_servsupl_nuevo) AND (LN_niv_contr = LN_niv_nuevo) AND (LV_ori_nuevo = CV_opc)  THEN
                     --- EXISTE(3) --
                     LN_existe3:=1;

                     IF LV_plantarif_atlantida = 'TRUE' OR LV_Abonado_Atlantida = 'TRUE' THEN
                        -- SI SON ATLANTIDA...
                        tab_contratados(LN_fila1).t_v_cod_accion:=CV_d;
                        tab_nuevo(LN_fila2).t_v_cod_accion:=CV_a;
                     ELSE
                        tab_contratados(LN_fila1).t_v_cod_accion:=CV_m;
                        tab_nuevo(LN_fila2).t_v_cod_accion:=CV_m;
                     END IF;

                     FOR LN_fila21 IN 0..ind_nuevo - 1 LOOP

                         LV_ori_nuevo:=tab_nuevo(LN_fila21).t_v_origen;
                         LN_servsupl_nuevo:=tab_nuevo(LN_fila21).t_v_cod_servsupl;
                         LN_niv_nuevo:=tab_nuevo(LN_fila21).t_v_cod_nivel;

                         IF (LN_ser_contr = LN_servsupl_nuevo) AND (LV_ori_nuevo = CV_def)  THEN
                            --- EXISTE(4) --
                            tab_nuevo(LN_fila21).t_v_cod_accion:=CV_n;
                         END IF;
                     END LOOP;
                  END IF;
              END LOOP;

              IF LN_existe3 = 0 THEN
                 --- NO EXISTE(3) --
                 LN_fila2:=0;
                 LN_existe5:=0;

                 FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

                     LV_ori_nuevo:=tab_nuevo(LN_fila2).t_v_origen;
                     LN_servsupl_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servsupl;
                     LN_niv_nuevo:=tab_nuevo(LN_fila2).t_v_cod_nivel;

                     IF (LN_ser_contr = LN_servsupl_nuevo) AND (LV_ori_nuevo = CV_def)  THEN
                        -- EXISTE(5)
                        LN_existe5:=1;
                        tab_contratados(LN_fila1).t_v_cod_accion:=CV_d;
                        tab_nuevo(LN_fila2).t_v_cod_accion:=CV_a;
                     END IF;
                 END LOOP;

                 IF LN_existe5 = 0 THEN
                    -- NO EXISTE(5)
                    IF LV_cambio_producto = 'FALSE' THEN
                       -- no hay cambio de producto
                       IF LV_plantarif_atlantida = 'TRUE' OR LV_Abonado_Atlantida = 'TRUE' THEN
                          -- SI SON ATLANTIDA...
                          tab_contratados(LN_fila1).t_v_cod_accion:=CV_d;

                          -- duplico servicio pero con accion ACTIVAR --
                          tab_contratados(LN_contratados).t_v_origen:=LV_ori_contr;
                          tab_contratados(LN_contratados).t_v_cod_servicio:=LV_ser_contr;
                          tab_contratados(LN_contratados).t_v_cod_servsupl:=LN_ser_contr;
                          tab_contratados(LN_contratados).t_v_cod_nivel:=LN_niv_contr;
                          tab_contratados(LN_contratados).t_v_cod_accion:=CV_a;

                          LN_contratados:=LN_contratados+1;

                       ELSE
                          tab_contratados(LN_fila1).t_v_cod_accion:=CV_m;
                       END IF;
                    ELSE
                       -- HAY CAMBIO DE PRODUCTO --
                       tab_contratados(LN_fila1).t_v_cod_accion:=CV_d;
                    END IF;
                 END IF; -- NO EXISTE(5) --

              END IF; -- NO EXISTE(3) --

           END IF; -- NO EXISTE(2) --

    END IF; -- EXISTE (1)

    END LOOP; -- fin lectura contratados --


        IF LN_existe1 = 0 THEN
            -- SI NO EXISTE(1) --
            FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

                        LV_ori_nuevo:=tab_nuevo(LN_fila2).t_v_origen;
       LN_servsupl_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servsupl;
                        LN_niv_nuevo:=tab_nuevo(LN_fila2).t_v_cod_nivel;

           LV_grupo_ss := LTRIM(TO_CHAR(LN_servsupl_nuevo,'00'));

       LN_pos:= NVL(INSTR(LV_grupos_wap_mms_roa,LV_grupo_ss),0);

                        IF (LV_ori_nuevo = CV_def) AND LN_pos <> 0 THEN
                                tab_nuevo(LN_fila2).t_v_cod_accion:=CV_n;
                        END IF;

                END LOOP;

        END IF;

        ind_contratados:=LN_contratados; -- reasigno TOTAL --

    dbms_output.PUT_LINE('TAB_CONTRATADOS ----------');
    FOR I IN 0..ind_contratados - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_contratados(I).t_v_origen||' | '||tab_contratados(I).t_v_cod_accion||' | '||tab_contratados(I).t_v_cod_servicio||' | '||tab_contratados(I).t_v_cod_servsupl||' | '||tab_contratados(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_NUEVO ----------');
    FOR I IN 0..ind_nuevo - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_nuevo(I).t_v_origen||' | '||tab_nuevo(I).t_v_cod_accion||' | '||tab_nuevo(I).t_v_cod_servicio||' | '||tab_nuevo(I).t_v_cod_servsupl||' | '||tab_nuevo(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_PERFILES ----------');
    FOR I IN 0..ind_perfiles - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_perfiles(I).t_v_origen||' | '||tab_perfiles(I).t_v_cod_accion||' | '||tab_perfiles(I).t_v_cod_servicio||' | '||tab_perfiles(I).t_v_cod_servsupl||' | '||tab_perfiles(I).t_v_cod_nivel||' | ');
    END LOOP;

EXCEPTION
    WHEN FIN_EJECUCION THEN
                 NULL;
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'No se encuentra datos';
                SN_num_evento    := 0;
  --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No existen datos.'  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.
        WHEN OTHERS THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno:= CV_error_no_clasif;
                LV_des_error := 'PV_REGLA_SS_WAPGPRSMMSROA_PR(' || EN_num_abonado || ',' || EV_cod_plan_destino ||')';
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                'PV_TRATAMIENTO_SS_PG.PV_REGLA_SS_WAPGPRSMMSROA_PR', sSql, SQLCODE, LV_des_error );
  --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.
END PV_REGLA_SS_WAPGPRSMMSROA_PR;

PROCEDURE PV_REGLA_SS_INTEROPCO_PR(EN_num_abonado            IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                   EV_cod_plantarif_origen   IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                   EV_cod_plantarif_destino  IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                   SN_cod_retorno            OUT NOCOPY GE_ERRORES_PG.CodError,
                                   SV_mens_retorno           OUT NOCOPY GE_ERRORES_PG.MsgError,
                                   SN_num_evento             OUT NOCOPY GE_ERRORES_PG.Evento)
/*
<Documentación
TipoDoc = "Procedure">
 <Elemento
    Nombre = "PV_REGLA_SS_INTEROPCO_PR"
    Lenguaje="PL/SQL"
    Fecha="14-12-2006"
    Versión="1.0"
    Diseñador="Manuel Acevedo M"
    Programador="Manuel Acevedo M."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Encargado de validar los servicios suplementarios INTEROPCO>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/

IS

LN_fila1                           NUMBER;

LN_pos                                 NUMBER;
LV_cadenass                            VARCHAR2(6);


LV_ori_contr                   VARCHAR2(3);
LV_servicio_contr              GA_SERVSUPL.COD_SERVICIO%TYPE;
LN_sersuple_contr              GA_SERVSUPL.COD_SERVSUPL%TYPE;
LN_niv_contr                   GA_SERVSUPL.COD_NIVEL%TYPE;

LV_ori_nuevo                   VARCHAR2(3);
LV_servicio_nuevo    GA_SERVSUPL.COD_SERVICIO%TYPE;
LN_servsupl_nuevo    GA_SERVSUPL.COD_SERVSUPL%TYPE;
LN_niv_nuevo                   GA_SERVSUPL.COD_NIVEL%TYPE;

LV_cod_serv_destino        GA_SERVSUPL.COD_SERVICIO%TYPE;
LN_cod_servsupl                GA_SERVSUPL.COD_SERVSUPL%TYPE;
LN_cod_nivel                       GA_SERVSUPL.COD_NIVEL%TYPE;

LV_cambio_producto         VARCHAR2(5);

LV_tip_terminal            GA_ABOCEL.TIP_TERMINAL%TYPE;
LV_cod_tecnologia          GA_ABOCEL.COD_TECNOLOGIA%TYPE;
LV_cod_plan_tarif          GA_ABOCEL.COD_PLANTARIF%TYPE;
LN_cod_central             GA_ABOCEL.COD_CENTRAL%TYPE;
LN_num_celular             GA_ABOCEL.NUM_CELULAR%TYPE;
LN_cod_sistema             ICG_CENTRAL.COD_SISTEMA%TYPE;

-- Variables para contener si la topologia es ATL - POS - HIB - PRE ---
LN_cod_tipologia_origen    PV_CONVERSION_SERVSUP_TD.COD_USO_ORIGEN%TYPE;
LN_cod_tipologia_destino   PV_CONVERSION_SERVSUP_TD.COD_USO_DESTINO%TYPE;

-- Variables para contener la respuesta si es abonado o plan atlantida ---
LV_abonado_atlantida      VARCHAR2(5);
LV_plantarif_atlantida    VARCHAR2(5);
LV_existe_servicio                VARCHAR2(5);

LV_error                                  VARCHAR2(5);

-- Variables para contener la respuesta de código de tipo de plan origen y destino, ademas si es HIB - PRE - POS --
LV_cod_tipo_plan_origen    TA_PLANTARIF.COD_TIPLAN%TYPE;
LV_cod_tipo_plan_destino   TA_PLANTARIF.COD_TIPLAN%TYPE;
LV_des_tip_plan            VARCHAR2(3);

LV_servicios_interopco     VARCHAR2(250);
LV_cadena_cursor                   VARCHAR2(250);

LN_existe1                                 NUMBER;

LV_des_error                   GE_ERRORES_PG.DesEvent;
sSql                           GE_ERRORES_PG.vQuery;

FIN_EJECUCION                  EXCEPTION;

CURSOR CURSOR_SERVICIOS_INTEROPCO IS
SELECT a.valor_texto
FROM   ga_parametros_multiples_vw a
WHERE  a.cod_modulo    = CV_mo_ga
AND    a.nom_parametro = CV_servicios_interopco
AND    a.cod_operadora = (SELECT b.valor_texto
                          FROM   ge_parametros_sistema_vw b
                          WHERE  b.nom_parametro = CV_op_local
                          AND    b.cod_modulo    = CV_mo_ge);


BEGIN

        IF SN_cod_retorno <> 0 THEN
           RAISE FIN_EJECUCION;
        END IF;

        LN_fila1:=0;
        LV_servicios_interopco:='';

        LV_existe_servicio:='FALSE';

        SN_cod_retorno   := 0;
        SV_mens_retorno  := 'OK';
        SN_num_evento    := 0;
        LV_cod_plan_tarif :=EV_cod_plantarif_origen;
        PV_RECUPERA_DATOS_ABONADO_PR(EN_num_abonado,LV_tip_terminal,LV_cod_tecnologia,LV_cod_plan_tarif,LN_cod_central,LN_num_celular,LN_cod_sistema,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF  SN_cod_retorno <> 0 THEN
                LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener Datos del Abonado',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'Error al obtener Datos del Abonado';
                SN_num_evento    := 0;
                RAISE FIN_EJECUCION;
        END IF;

        OPEN CURSOR_SERVICIOS_INTEROPCO;
        LOOP

            FETCH CURSOR_SERVICIOS_INTEROPCO INTO LV_cadena_cursor;
                        EXIT WHEN CURSOR_SERVICIOS_INTEROPCO%NOTFOUND;

                        IF LV_cadena_cursor IS NOT NULL THEN
                            IF LV_servicios_interopco IS NULL THEN
                                        LV_servicios_interopco := LV_cadena_cursor;
                                ELSE
                                        LV_servicios_interopco := LV_servicios_interopco ||','|| LV_cadena_cursor;
                                END IF;
                        END IF;

                END LOOP;
        CLOSE CURSOR_SERVICIOS_INTEROPCO;


        IF LV_servicios_interopco IS NULL THEN
            LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener Servicios Suplementarios.',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
            RAISE FIN_EJECUCION;
        END IF;


        --- LLamada a función para obtener plan atlantida ----
        sSql :='PV_existe_cambio_producto_FN('|| EN_num_abonado ||','|| EV_cod_plantarif_origen ||','|| EV_cod_plantarif_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
        LV_cambio_producto := PV_TRATAMIENTO_SS_PG.PV_EXISTE_CAMBIO_PRODUCTO_FN(EN_num_abonado,EV_cod_plantarif_origen,EV_cod_plantarif_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF  SN_cod_retorno <> 0 THEN
                LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener cambio de producto',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'Error al obtener cambio de producto';
                SN_num_evento    := 0;
                RAISE FIN_EJECUCION;
        END IF;

        --- Tratamiento de Origen ---
        --- LLamada al package para obtener abonado atlantida ----
        sSql :='pv_obtieneinfo_atlantida_pg.pv_existeaboatlantida2_pr('|| EN_num_abonado ||','|| LV_Abonado_Atlantida ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
        pv_obtieneinfo_atlantida_pg.pv_existeaboatlantida2_pr(EN_num_abonado,LV_Abonado_Atlantida,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF  SN_cod_retorno <> 0 THEN
                LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener abonado atlantida',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

            SN_cod_retorno   := 4;
            SV_mens_retorno  := 'Error para obtener abonado atlantida';
            SN_num_evento    := 0;
            RAISE FIN_EJECUCION;
        END IF;

        IF LV_Abonado_Atlantida = 'TRUE' THEN
            LN_cod_tipologia_origen := CV_atlantida;
        ELSE
                --- LLamada al procedimiento para obtener código de tipo de plan origen ----
                sSql :='PV_COD_TIPO_PLAN_TARIFARIO_PR('|| EV_cod_plantarif_origen ||','|| LV_cod_tipo_plan_origen ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
                PV_TRATAMIENTO_SS_PG.PV_COD_TIPO_PLAN_TARIFARIO_PR(EV_cod_plantarif_origen,LV_cod_tipo_plan_origen,LV_des_tip_plan,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                IF  SN_cod_retorno <> 0 THEN
                   LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener código de tipo de plan origen',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                   SN_cod_retorno   := 4;
                   SV_mens_retorno  := 'Error para obtener código de tipo de plan origen';
                   SN_num_evento    := 0;
                   RAISE FIN_EJECUCION;
                END IF;

                LN_cod_tipologia_origen := LV_des_tip_plan;

        END IF;


    --- Tratamiento de Destino ---
    --- LLamada a función para obtener plan atlantida ----
        sSql :='PV_PLAN_DESTINO_ATLANTIDA_FN('|| EV_cod_plantarif_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
        LV_plantarif_atlantida := PV_TRATAMIENTO_SS_PG.PV_PLAN_DESTINO_ATLANTIDA_FN(EV_cod_plantarif_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF  SN_cod_retorno <> 0 THEN
                LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener plan atlantida',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                SN_cod_retorno   := 4;
            SV_mens_retorno  := 'Error para obtener plan atlantida';
                SN_num_evento    := 0;
            RAISE FIN_EJECUCION;
        END IF;

        IF LV_plantarif_atlantida = 'TRUE' THEN
            LN_cod_tipologia_destino := CV_atlantida;
        ELSE
            --- LLamada al procedimiento para obtener código de tipo de plan destino ----
        sSql :='PV_COD_TIPO_PLAN_TARIFARIO_PR('|| EV_cod_plantarif_destino ||','|| LV_cod_tipo_plan_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
            PV_TRATAMIENTO_SS_PG.PV_COD_TIPO_PLAN_TARIFARIO_PR(EV_cod_plantarif_destino,LV_cod_tipo_plan_destino,LV_des_tip_plan,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                IF  SN_cod_retorno <> 0 THEN
                    LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener código de tipo de plan destino',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                    SN_cod_retorno   := 4;
                    SV_mens_retorno  := 'Error para obtener código de tipo de plan destino';
                    SN_num_evento    := 0;
                    RAISE FIN_EJECUCION;
                END IF;

                LN_cod_tipologia_destino := LV_des_tip_plan;

        END IF;


    FOR LN_fila1 IN 0..ind_contratados - 1 LOOP

                LV_ori_contr:=tab_contratados(LN_fila1).t_v_origen;
                LV_servicio_contr:=tab_contratados(LN_fila1).t_v_cod_servicio;
                LN_sersuple_contr:=tab_contratados(LN_fila1).t_v_cod_servsupl;
                LN_niv_contr:=tab_contratados(LN_fila1).t_v_cod_nivel;

                LV_cadenass :=  LTRIM(TO_CHAR(LN_sersuple_contr,'00')) || LTRIM(TO_CHAR(LN_niv_contr,'0000'));

        LN_pos:=NVL(INSTR(LV_servicios_interopco,LV_cadenass),0);

                IF (LV_ori_contr = CV_def OR LV_ori_contr = CV_opc) AND LN_pos <> 0 THEN
                    --EXISTE(1)

                        IF LV_cambio_producto = 'FALSE' THEN
                            -- NO HAY CAMBIO DE PRODUCTO --
                                -- NO EXISTE(2)
                            FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

                                        LV_ori_nuevo:=tab_nuevo(LN_fila2).t_v_origen;
                            LV_servicio_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servicio;
                    LN_servsupl_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servsupl;
                                        LN_niv_nuevo:=tab_nuevo(LN_fila2).t_v_cod_nivel;

                    LV_cadenass := LTRIM(TO_CHAR(LN_servsupl_nuevo,'00')) || LTRIM(TO_CHAR(LN_niv_nuevo,'0000'));
                    LN_pos      := NVL(INSTR(LV_servicios_interopco,LV_cadenass),0);

                    IF (LV_ori_nuevo = CV_def) AND LN_pos <> 0 THEN
                                           -- NO CONSIDERAR --
                                           tab_nuevo(LN_fila2).t_v_cod_accion:=CV_n;
                                        END IF;

                    IF LV_servicio_contr = LV_servicio_nuevo THEN
                       IF LV_plantarif_atlantida = 'TRUE' OR LV_Abonado_Atlantida = 'TRUE' THEN
                                                  -- ES ATLANTIDA --
                                                  tab_contratados(LN_fila1).t_v_cod_accion:=CV_d;
                                                  tab_nuevo(LN_fila2).t_v_cod_accion:=CV_a;
                                           ELSE
                                                  tab_contratados(LN_fila1).t_v_cod_accion:=CV_m;
                                                  tab_nuevo(LN_fila2).t_v_cod_accion:=CV_m;
                                           END IF;
                                        END IF;
                                END LOOP;
                        ELSE
                -- HAY CAMBIO DE PRODUCTO --
                                -- EXISTE(2)
                LV_existe_servicio := 'FALSE';
                            tab_contratados(LN_fila1).t_v_cod_accion:=CV_d;

                                BEGIN

                                        sSql :='SELECT a.cod_servicio_destino  ';
                                        sSql :=sSql || 'INTO  LV_serv_conv_dest ';
                                    sSql :=sSql || 'FROM  pv_conversion_servsup_td a ';
                                    sSql :=sSql || 'WHERE a.cod_producto = '||CN_producto ;
                                        sSql :=sSql || 'AND   a.cod_uso_origen = '||LN_cod_tipologia_origen ;
                                    sSql :=sSql || 'AND   a.cod_servicio_origen ='||LV_servicio_contr ;
                                    sSql :=sSql || 'AND   a.cod_uso_destino ='||LN_cod_tipologia_destino ;
                                        sSql :=sSql || 'AND    SYSDATE  BETWEEN a.fec_desde AND a.fec_hasta ';

                                        SELECT a.cod_servicio_destino
                                        INTO   LV_cod_serv_destino
                                        FROM   pv_conversion_servsup_td a
                                        WHERE  a.cod_producto= CN_producto
                                        AND    a.cod_uso_origen = LN_cod_tipologia_origen
                                        AND    a.cod_servicio_origen = LV_servicio_contr
                                        AND    a.cod_uso_destino = LN_cod_tipologia_destino
                                        AND    SYSDATE BETWEEN a.fec_desde AND a.fec_hasta;


                                    FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

                                                LV_ori_nuevo:=tab_nuevo(LN_fila2).t_v_origen;
                                            LV_servicio_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servicio;
                                        LN_servsupl_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servsupl;
                                                LN_niv_nuevo:=tab_nuevo(LN_fila2).t_v_cod_nivel;

                                    IF LV_cod_serv_destino = LV_servicio_nuevo THEN
                                                   -- EXISTE(4) --
                                                   -- SERVICIO CONVERTIDO EXISTE EN MATRIZ NUEVO --
                                                   tab_nuevo(LN_fila2).t_v_cod_accion:=CV_a;
                                                   LV_existe_servicio:='TRUE';
                                                END IF;
                                        END LOOP;

                                        IF LV_existe_servicio = 'FALSE' THEN
                                            -- NO EXISTE(4) --
                                            FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP
                                                        LV_ori_nuevo:=tab_nuevo(LN_fila2).t_v_origen;
                                            LN_servsupl_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servsupl;
                                                        LN_niv_nuevo:=tab_nuevo(LN_fila2).t_v_cod_nivel;

                                            LV_cadenass := LTRIM(TO_CHAR(LN_servsupl_nuevo,'00')) || LTRIM(TO_CHAR(LN_niv_nuevo,'0000'));
                                            LN_pos      := NVL(INSTR(LV_servicios_interopco,LV_cadenass),0);

                                            IF (LV_ori_nuevo = CV_def) AND LN_pos <> 0 THEN
                                                           -- NO CONSIDERAR --
                                                           tab_nuevo(LN_fila2).t_v_cod_accion:=CV_n;
                                                        END IF;
                                                END LOOP;
                                        END IF;


                                EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                       --NO EXISTE(3) --
                                            FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

                                                        LV_ori_nuevo:=tab_nuevo(LN_fila2).t_v_origen;
                                        LN_servsupl_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servsupl;
                                                        LN_niv_nuevo:=tab_nuevo(LN_fila2).t_v_cod_nivel;

                                            LV_cadenass := LTRIM(TO_CHAR(LN_servsupl_nuevo,'00')) || LTRIM(TO_CHAR(LN_niv_nuevo,'0000'));
                                            LN_pos      :=NVL(INSTR(LV_servicios_interopco,LV_cadenass),0);

                                                IF (LV_ori_nuevo = CV_def) AND LN_pos <> 0 THEN
                                                           -- NO CONSIDERAR --
                                                           tab_nuevo(LN_fila2).t_v_cod_accion:=CV_n;
                                            END IF;
                                        END LOOP;
                        END;

            END IF;

                END IF;

        END LOOP;

    dbms_output.PUT_LINE('TAB_CONTRATADOS ----------');
    FOR I IN 0..ind_contratados - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_contratados(I).t_v_origen||' | '||tab_contratados(I).t_v_cod_accion||' | '||tab_contratados(I).t_v_cod_servicio||' | '||tab_contratados(I).t_v_cod_servsupl||' | '||tab_contratados(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_NUEVO ----------');
    FOR I IN 0..ind_nuevo - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_nuevo(I).t_v_origen||' | '||tab_nuevo(I).t_v_cod_accion||' | '||tab_nuevo(I).t_v_cod_servicio||' | '||tab_nuevo(I).t_v_cod_servsupl||' | '||tab_nuevo(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_PERFILES ----------');
    FOR I IN 0..ind_perfiles - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_perfiles(I).t_v_origen||' | '||tab_perfiles(I).t_v_cod_accion||' | '||tab_perfiles(I).t_v_cod_servicio||' | '||tab_perfiles(I).t_v_cod_servsupl||' | '||tab_perfiles(I).t_v_cod_nivel||' | ');
    END LOOP;

EXCEPTION
    WHEN FIN_EJECUCION THEN
                 NULL;
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'No se encuentra datos';
                SN_num_evento    := 0;
    --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No existen datos.'  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.
        WHEN OTHERS THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno:= CV_error_no_clasif;
                LV_des_error := 'PV_REGLA_SS_INTEROPCO_PR(' || EN_num_abonado || ',' || EV_cod_plantarif_origen || ',' || EV_cod_plantarif_destino || ')';
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                'PV_TRATAMIENTO_SS_PG.PV_REGLA_SS_INTEROPCO_PR', sSql, SQLCODE, LV_des_error );
  --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.
END PV_REGLA_SS_INTEROPCO_PR;

PROCEDURE PV_REGLA_SS_GESTOR_PR(EN_num_abonado    IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                SN_cod_retorno    OUT NOCOPY GE_ERRORES_PG.CodError,
                                SV_mens_retorno   OUT NOCOPY GE_ERRORES_PG.MsgError,
                                SN_num_evento     OUT NOCOPY GE_ERRORES_PG.Evento)
/*
<Documentación
TipoDoc = "Procedure">
 <Elemento
    Nombre = "PV_REGLA_SS_GESTOR_PR"
    Lenguaje="PL/SQL"
    Fecha="14-12-2006"
    Versión="1.0"
    Diseñador="Manuel Acevedo M"
    Programador="Manuel Acevedo M."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>>
    <Parámetros>Encargado de validar servicios suplementarios del gestor Corporativo;
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/

IS

LN_fila1                    NUMBER;

LV_acc_contr            VARCHAR2(1);
LV_ser_contr        GA_SERVSUPL.COD_SERVICIO%TYPE;
LV_niv_contr            GA_SERVSUPL.COD_NIVEL%TYPE;
LN_ind_gestor           GA_SERVSUPL.IND_GESTOR%TYPE;

LV_error                        VARCHAR2(5);

LV_des_error            GE_ERRORES_PG.DesEvent;
sSql                    GE_ERRORES_PG.vQuery;
ERROR_PROCESO           EXCEPTION;

FIN_EJECUCION           EXCEPTION;

BEGIN

        IF SN_cod_retorno <> 0 THEN
           RAISE FIN_EJECUCION;
        END IF;

        LN_fila1:=0;

        SN_cod_retorno   := 0;
        SV_mens_retorno  := 'OK';
        SN_num_evento    := 0;

    FOR LN_fila1 IN 0..ind_contratados - 1 LOOP

                LV_acc_contr:=tab_contratados(LN_fila1).t_v_cod_accion;
                LV_ser_contr:=tab_contratados(LN_fila1).t_v_cod_servicio;
                LV_niv_contr:=tab_contratados(LN_fila1).t_v_cod_nivel;

                IF LV_acc_contr = CV_d  THEN
                   -- Se desactiva servicio --
                   -- Validamos si pertenece al gestor de clientes --

                   BEGIN

                           SELECT a.ind_gestor
                           INTO   LN_ind_gestor
                           FROM   ga_servsupl a
                           WHERE  a.cod_producto = CN_producto
                           AND    a.cod_servicio = LV_ser_contr;

                           IF LN_ind_gestor = CN_ind_gestor THEN
                                  -- NO SE DA DE BAJA EL SERVICIO
                                   tab_contratados(LN_fila1).t_v_cod_accion:=CV_m;
                           END IF;

                   EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                                LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No se encuentra indicador de gestor',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                                SN_cod_retorno   := 4;
                                SV_mens_retorno  := 'No se encuentra indicador de gestor';
                                SN_num_evento    := 0;
                                RAISE ERROR_PROCESO;
                   END;



            END IF;

    END LOOP;

    dbms_output.PUT_LINE('TAB_CONTRATADOS ----------');
    FOR I IN 0..ind_contratados - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_contratados(I).t_v_origen||' | '||tab_contratados(I).t_v_cod_accion||' | '||tab_contratados(I).t_v_cod_servicio||' | '||tab_contratados(I).t_v_cod_servsupl||' | '||tab_contratados(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_NUEVO ----------');
    FOR I IN 0..ind_nuevo - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_nuevo(I).t_v_origen||' | '||tab_nuevo(I).t_v_cod_accion||' | '||tab_nuevo(I).t_v_cod_servicio||' | '||tab_nuevo(I).t_v_cod_servsupl||' | '||tab_nuevo(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_PERFILES ----------');
    FOR I IN 0..ind_perfiles - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_perfiles(I).t_v_origen||' | '||tab_perfiles(I).t_v_cod_accion||' | '||tab_perfiles(I).t_v_cod_servicio||' | '||tab_perfiles(I).t_v_cod_servsupl||' | '||tab_perfiles(I).t_v_cod_nivel||' | ');
    END LOOP;

EXCEPTION
    WHEN FIN_EJECUCION THEN
                 NULL;
        WHEN ERROR_PROCESO THEN
                SN_cod_retorno   := SN_cod_retorno;
                SV_mens_retorno  := SV_mens_retorno;
                SN_num_evento    := SN_num_evento;

        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'No se encuentra datos';
                SN_num_evento    := 0;

        WHEN OTHERS THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno:= CV_error_no_clasif;
                LV_des_error := 'PV_REGLA_SS_GESTOR_PR(' || EN_num_abonado || ')';
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                'PV_TRATAMIENTO_SS_PG.PV_REGLA_SS_GESTOR_PR', sSql, SQLCODE, LV_des_error );

END PV_REGLA_SS_GESTOR_PR;

PROCEDURE PV_REGLA_SS_PERFIL_PR(EN_num_abonado            IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                EV_cod_plantarif_origen   IN  GA_ABOCEL.COD_PLANTARIF%TYPE,--ocb
                                EV_cod_plan_destino       IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                SN_cod_retorno            OUT NOCOPY GE_ERRORES_PG.CodError,
                                SV_mens_retorno           OUT NOCOPY GE_ERRORES_PG.MsgError,
                                SN_num_evento             OUT NOCOPY GE_ERRORES_PG.Evento)
/*
<Documentación
TipoDoc = "Procedure">
 <Elemento
    Nombre = "PV_REGLA_SS_PERFIL_PR"
    Lenguaje="PL/SQL"
    Fecha="14-12-2006"
    Versión="1.0"
    Diseñador="Manuel Acevedo M"
    Programador="Manuel Acevedo M."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Encargado de validar los servicios suplementarios asociados al perfil de
                                 centrales del producto origen y destino;
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/

IS

LN_fila1                    NUMBER;
LN_fila2                    NUMBER;
LN_fila3                    NUMBER;

LB_existe_perfil            BOOLEAN;

LV_ori_contr                VARCHAR2(3);
LN_ser_contr                GA_SERVSUPL.COD_SERVSUPL%TYPE;
LV_ser_contr                GA_SERVSUPL.COD_SERVICIO%TYPE;
LN_niv_contr                GA_SERVSUPL.COD_NIVEL%TYPE;

LV_ori_nuevo                VARCHAR2(3);
LN_servsupl_nuevo           GA_SERVSUPL.COD_SERVSUPL%TYPE;
LV_ser_nuevo                GA_SERVSUPL.COD_SERVICIO%TYPE;

LV_ori_perfiles             VARCHAR2(3);
LN_ser_perfiles             GA_SERVSUPL.COD_SERVSUPL%TYPE;
LV_ser_perfiles             GA_SERVSUPL.COD_SERVICIO%TYPE;
LV_niv_perfiles             GA_SERVSUPL.COD_NIVEL%TYPE;


LV_cambio_producto          VARCHAR2(5);

LV_error                    VARCHAR2(5);

LV_Abonado_Atlantida        VARCHAR2(5);
LV_plantarif_atlantida      VARCHAR2(5);

LV_tip_terminal             GA_ABOCEL.TIP_TERMINAL%TYPE;
LV_cod_tecnologia           GA_ABOCEL.COD_TECNOLOGIA%TYPE;
LV_cod_plan_tarif           GA_ABOCEL.COD_PLANTARIF%TYPE;
LN_cod_central              GA_ABOCEL.COD_CENTRAL%TYPE;
LN_num_celular              GA_ABOCEL.NUM_CELULAR%TYPE;
LN_cod_sistema              ICG_CENTRAL.COD_SISTEMA%TYPE;

LN_contratados              BINARY_INTEGER;

LV_des_error                GE_ERRORES_PG.DesEvent;
sSql                        GE_ERRORES_PG.vQuery;

ERROR_PROCESO               EXCEPTION;
FIN_EJECUCION               EXCEPTION;

BEGIN

        IF SN_cod_retorno <> 0 THEN
           RAISE FIN_EJECUCION;
        END IF;

        LN_fila1:=0;
        LN_fila2:=0;
        LN_fila3:=0;

        SN_cod_retorno   := 0;
        SV_mens_retorno  := 'OK';
        SN_num_evento    := 0;

        sSql :='PV_RECUPERA_DATOS_ABONADO_PR('||EN_num_abonado||','||LV_tip_terminal||','||LV_cod_tecnologia||', ';
        sSql := sSql||LV_cod_plan_tarif||','||LN_cod_central||','||LN_num_celular||','||LN_cod_sistema||','||SN_cod_retorno||', ';
        sSql := sSql||SV_mens_retorno||','||SN_num_evento||')';

        PV_RECUPERA_DATOS_ABONADO_PR(EN_num_abonado,LV_tip_terminal,LV_cod_tecnologia,LV_cod_plan_tarif,LN_cod_central,LN_num_celular,LN_cod_sistema,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF  SN_cod_retorno <> 0 THEN
            LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener Datos del Abonado',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

            SN_cod_retorno   := 4;
            SV_mens_retorno  := 'Error al obtener Datos del Abonado';
            SN_num_evento    := 0;
            RAISE ERROR_PROCESO;
        END IF;

        --- LLamada a función para obtener plan atlantida ----
        sSql :='PV_EXISTE_CAMBIO_PRODUCTO_FN('|| EN_num_abonado ||','|| EV_cod_plantarif_origen ||','|| EV_cod_plan_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
        LV_cambio_producto := PV_TRATAMIENTO_SS_PG.PV_EXISTE_CAMBIO_PRODUCTO_FN(EN_num_abonado,EV_cod_plantarif_origen,EV_cod_plan_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF  SN_cod_retorno <> 0 THEN
            LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener cambio de producto',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

            SN_cod_retorno   := 4;
            SV_mens_retorno  := 'Error al obtener cambio de producto';
            SN_num_evento    := 0;
            RAISE ERROR_PROCESO;
        END IF;

        --- LLamada al package para obtener abonado atlantida ----
        sSql :='pv_obtieneinfo_atlantida_pg.pv_existeaboatlantida2_pr('|| EN_num_abonado ||','|| LV_Abonado_Atlantida ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
        pv_obtieneinfo_atlantida_pg.pv_existeaboatlantida2_pr(EN_num_abonado,LV_Abonado_Atlantida,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF  SN_cod_retorno <> 0 THEN
            LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener abonado atlantida',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

            SN_cod_retorno   := 4;
            SV_mens_retorno  := 'Error para obtener abonado atlantida';
            SN_num_evento    := 0;
            RAISE ERROR_PROCESO;
        END IF;

    --- LLamada a función para obtener plan atlantida ----
        sSql :='PV_PLAN_DESTINO_ATLANTIDA_FN('|| EV_cod_plan_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
        LV_plantarif_atlantida := PV_TRATAMIENTO_SS_PG.PV_PLAN_DESTINO_ATLANTIDA_FN(EV_cod_plan_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF  SN_cod_retorno <> 0 THEN
            LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener plan atlantida',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

            SN_cod_retorno   := 4;
            SV_mens_retorno  := 'Error para obtener plan atlantida';
            SN_num_evento    := 0;
            RAISE ERROR_PROCESO;
        END IF;

        LN_contratados:=ind_contratados;

        IF  LV_cambio_producto= 'TRUE' THEN
            -- EXISTE CAMBIO DE PRODUCTO --

            FOR LN_fila1 IN 0..ind_perfiles - 1 LOOP

                LV_ori_perfiles:=tab_perfiles(LN_fila1).t_v_origen;
                LN_ser_perfiles:=tab_perfiles(LN_fila1).t_v_cod_servsupl;

                FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

                    LV_ori_nuevo:=tab_nuevo(LN_fila2).t_v_origen;
                    LN_servsupl_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servsupl;

                    IF LN_ser_perfiles = LN_servsupl_nuevo THEN
                       -- Servicio IDEM --
                       tab_nuevo(LN_fila2).t_v_cod_accion:=CV_n;
                    END IF;

                END LOOP;

                FOR LN_fila3 IN 0..ind_contratados - 1 LOOP

                    LV_ori_contr:=tab_contratados(LN_fila3).t_v_origen;
                    LN_ser_contr:=tab_contratados(LN_fila3).t_v_cod_servsupl;

                    IF LN_ser_perfiles = LN_ser_contr AND  (LV_ori_contr = CV_def OR LV_ori_contr = CV_opc OR LV_ori_contr = CV_per) THEN
                       tab_contratados(LN_fila3).t_v_cod_accion:=CV_d;
                    END IF;

                    IF LN_ser_perfiles = LN_ser_contr AND  (LV_ori_contr = CV_tra OR LV_ori_contr = CV_con) THEN
                       tab_contratados(LN_fila3).t_v_cod_accion:=CV_n;
                    END IF;

                END LOOP;

            END LOOP;

        ELSE   -- NO EXISTE CAMBIO DE PRODUCTO --

            FOR LN_fila1 IN 0..ind_perfiles - 1 LOOP

                LV_ser_perfiles := tab_perfiles(LN_fila1).t_v_cod_servicio;
				LN_ser_perfiles := tab_perfiles(LN_fila1).t_v_cod_servsupl;
                LV_niv_perfiles := tab_perfiles(LN_fila1).t_v_cod_nivel;

				LB_existe_perfil := FALSE;
				FOR LN_fila2 IN 0..ind_contratados - 1 LOOP
                   LV_ori_contr := tab_contratados(LN_fila2).t_v_origen;
                   LV_ser_contr := tab_contratados(LN_fila2).t_v_cod_servicio;
                   LN_ser_contr := tab_contratados(LN_fila2).t_v_cod_servsupl;
                   LN_niv_contr := tab_contratados(LN_fila2).t_v_cod_nivel;

				   IF LN_ser_contr = LN_ser_perfiles THEN
                      IF LN_niv_contr = LV_niv_perfiles THEN
					     LB_existe_perfil := TRUE;
                         tab_contratados(LN_fila2).t_v_cod_accion:=CV_m;
                      ELSE
                         IF LV_ori_contr = CV_def OR LV_ori_contr = CV_opc OR LV_ori_contr = CV_per THEN
                            tab_contratados(LN_fila2).t_v_cod_accion := CV_d;
                         END IF;

                         IF LV_ori_contr = CV_tra OR LV_ori_contr = CV_con THEN
                            tab_contratados(LN_fila2).t_v_cod_accion := CV_n;
                         END IF;
                      END IF;
                   END IF;

                END LOOP;

                IF LB_existe_perfil = FALSE THEN
                   tab_perfiles(LN_fila1).t_v_cod_accion := CV_a;
                END IF;

                FOR LN_fila3 IN 0..ind_nuevo - 1 LOOP
                    LN_servsupl_nuevo := tab_nuevo(LN_fila3).t_v_cod_servsupl;
                    IF LN_servsupl_nuevo = LN_ser_perfiles THEN
                       tab_nuevo(LN_fila3).t_v_cod_accion := CV_n;
                    END IF;
                END LOOP;

            END LOOP;

        END IF;

    ind_contratados:=LN_contratados;

    dbms_output.PUT_LINE('TAB_CONTRATADOS ----------');
    FOR I IN 0..ind_contratados - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_contratados(I).t_v_origen||' | '||tab_contratados(I).t_v_cod_accion||' | '||tab_contratados(I).t_v_cod_servicio||' | '||tab_contratados(I).t_v_cod_servsupl||' | '||tab_contratados(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_NUEVO ----------');
    FOR I IN 0..ind_nuevo - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_nuevo(I).t_v_origen||' | '||tab_nuevo(I).t_v_cod_accion||' | '||tab_nuevo(I).t_v_cod_servicio||' | '||tab_nuevo(I).t_v_cod_servsupl||' | '||tab_nuevo(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_PERFILES ----------');
    FOR I IN 0..ind_perfiles - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_perfiles(I).t_v_origen||' | '||tab_perfiles(I).t_v_cod_accion||' | '||tab_perfiles(I).t_v_cod_servicio||' | '||tab_perfiles(I).t_v_cod_servsupl||' | '||tab_perfiles(I).t_v_cod_nivel||' | ');
    END LOOP;

EXCEPTION
    WHEN FIN_EJECUCION THEN
                NULL;
        WHEN ERROR_PROCESO THEN
                SN_cod_retorno   := SN_cod_retorno;
                SV_mens_retorno  := SV_mens_retorno;
                SN_num_evento    := SN_num_evento;
    --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Proceso error. N° evento' || to_char(SN_num_evento)  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'No se encuentra datos';
                SN_num_evento    := 0;
   --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No existen datos.'  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.
        WHEN OTHERS THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno:= CV_error_no_clasif;
                LV_des_error := 'PV_REGLA_SS_PERFIL_PR(' || EN_num_abonado || ',' || EV_cod_plan_destino ||')';
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                'PV_TRATAMIENTO_SS_PG.PV_REGLA_SS_PERFIL_PR', sSql, SQLCODE, LV_des_error );
  --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.
END PV_REGLA_SS_PERFIL_PR;

PROCEDURE PV_REGLA_INCOMPATIBILIDAD_PR(EN_num_abonado    IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                       SN_cod_retorno    OUT NOCOPY GE_ERRORES_PG.CodError,
                                       SV_mens_retorno   OUT NOCOPY GE_ERRORES_PG.MsgError,
                                       SN_num_evento     OUT NOCOPY GE_ERRORES_PG.Evento)
/*
<Documentación
TipoDoc = "Procedure">
 <Elemento
    Nombre = "PV_REGLA_INCOMPATIBILIDAD_PR"
    Lenguaje="PL/SQL"
    Fecha="14-12-2006"
    Versión="1.0"
    Diseñador="Manuel Acevedo M"
    Programador="Manuel Acevedo M."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Encargado de validar las incompatibilidades de los servicios del nuevo plan
                                 con los servicios ya activos del abonado>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/

IS

LN_fila1                     NUMBER;
LN_fila2                     NUMBER;

LV_acc_nuevo             VARCHAR2(1);
LV_ser_nuevo         GA_SERVSUPL.COD_SERVICIO%TYPE;
LV_ori_contr             VARCHAR2(3);
LV_ser_contr         GA_SERVSUPL.COD_SERVICIO%TYPE;

LV_codservicio           GA_SERVSUP_DEF.COD_SERVDEF%TYPE;

LV_tip_terminal      GA_ABOCEL.TIP_TERMINAL%TYPE;
LV_cod_tecnologia    GA_ABOCEL.COD_TECNOLOGIA%TYPE;
LV_cod_plan_tarif    GA_ABOCEL.COD_PLANTARIF%TYPE;
LN_cod_central       GA_ABOCEL.COD_CENTRAL%TYPE;
LN_num_celular       GA_ABOCEL.NUM_CELULAR%TYPE;
LN_cod_sistema       ICG_CENTRAL.COD_SISTEMA%TYPE;

LV_error                         VARCHAR2(5);

CURSOR CURSOR_INCOMPATIBLES IS
SELECT a.cod_servdef
FROM   ga_servsup_def a, ga_servsupl b, icg_serviciotercen c
WHERE  a.cod_servicio   = LV_ser_nuevo
AND    a.tip_relacion   = CN_relacion3
AND    SYSDATE    BETWEEN a.fec_desde and a.fec_hasta
AND    a.cod_producto   = CN_producto
AND    a.cod_producto   = b.cod_producto
AND    a.cod_servdef    = b.cod_servicio
AND    b.cod_producto   = c.cod_producto
AND    b.cod_servsupl   = c.cod_servicio
AND    c.cod_sistema    = LN_cod_sistema
AND    c.tip_terminal   = LV_tip_terminal
AND    c.tip_tecnologia = LV_cod_tecnologia;


LV_des_error             GE_ERRORES_PG.DesEvent;
sSql                     GE_ERRORES_PG.vQuery;
ERROR_PROCESO            EXCEPTION;

FIN_EJECUCION            EXCEPTION;

BEGIN

        IF SN_cod_retorno <> 0 THEN
           RAISE FIN_EJECUCION;
        END IF;

        LN_fila1:=0;

        SN_cod_retorno   := 0;
        SV_mens_retorno  := 'OK';
        SN_num_evento    := 0;

        sSql :='PV_RECUPERA_DATOS_ABONADO_PR('||EN_num_abonado||','||LV_tip_terminal||','||LV_cod_tecnologia||', ';
        sSql := sSql||LV_cod_plan_tarif||','||LN_cod_central||','||LN_num_celular||','||LN_cod_sistema||','||SN_cod_retorno||', ';
        sSql := sSql||SV_mens_retorno||','||SN_num_evento||')';

        PV_RECUPERA_DATOS_ABONADO_PR(EN_num_abonado,LV_tip_terminal,LV_cod_tecnologia,LV_cod_plan_tarif,LN_cod_central,LN_num_celular,LN_cod_sistema,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF  SN_cod_retorno <> 0 THEN
                LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener Datos del Abonado',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'Error al obtener Datos del Abonado';
                SN_num_evento    := 0;
                RAISE ERROR_PROCESO;
        END IF;

    FOR LN_fila1 IN 0..ind_nuevo - 1 LOOP

                LV_acc_nuevo:=tab_nuevo(LN_fila1).t_v_cod_accion;
                LV_ser_nuevo:=tab_nuevo(LN_fila1).t_v_cod_servicio;

                IF LV_acc_nuevo = CV_a  THEN
                    -- VEMOS SI EXISTE INCOMPATIBILIDAD --
                        OPEN CURSOR_INCOMPATIBLES;
                        LOOP
                            FETCH CURSOR_INCOMPATIBLES INTO LV_codservicio;
                                        EXIT WHEN CURSOR_INCOMPATIBLES%NOTFOUND;

                                    FOR LN_fila2 IN 0..ind_contratados - 1 LOOP

                                                LV_ori_contr:=tab_contratados(LN_fila2).t_v_origen;
                                                LV_ser_contr:=tab_contratados(LN_fila2).t_v_cod_servicio;

                                                IF LV_ser_contr = LV_codservicio AND (LV_ori_contr = CV_def OR LV_ori_contr = CV_opc OR LV_ori_contr = CV_per) THEN
                                                   -- Desactivar--
                                                   tab_contratados(LN_fila2).t_v_cod_accion:=CV_d;

                                                   IF LV_ori_contr = CV_opc THEN
                                                            -- REVISA SS LIGADOS --
                                                                sSql :='PV_CONSULTA_SS_LIGADOS_PR('|| EN_num_abonado || ',' || LV_ser_contr ||','|| CV_d ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
                                                                PV_TRATAMIENTO_SS_PG.PV_CONSULTA_SS_LIGADOS_PR(EN_num_abonado,LV_ser_contr,CV_d,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                                                                IF  SN_cod_retorno <> 0 THEN
                                                                   LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener servicio suplementario ligado.',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                                                                   SN_cod_retorno   := 4;
                                                                   SV_mens_retorno  := 'Error al obtener servicio suplementario ligado.';
                                                                   SN_num_evento    := 0;
                                                                   RAISE FIN_EJECUCION;
                                                                END IF;

                                                   END IF;

                                                END IF;

                                                IF LV_ser_contr = LV_codservicio AND (LV_ori_contr = CV_con OR LV_ori_contr = CV_tra) THEN
                                                   -- No Considerar --
                                                   tab_contratados(LN_fila2).t_v_cod_accion:=CV_n;

                                                END IF;

                                    END LOOP;

                        END LOOP;
                CLOSE CURSOR_INCOMPATIBLES;

            END IF;

    END LOOP;

    dbms_output.PUT_LINE('TAB_CONTRATADOS ----------');
    FOR I IN 0..ind_contratados - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_contratados(I).t_v_origen||' | '||tab_contratados(I).t_v_cod_accion||' | '||tab_contratados(I).t_v_cod_servicio||' | '||tab_contratados(I).t_v_cod_servsupl||' | '||tab_contratados(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_NUEVO ----------');
    FOR I IN 0..ind_nuevo - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_nuevo(I).t_v_origen||' | '||tab_nuevo(I).t_v_cod_accion||' | '||tab_nuevo(I).t_v_cod_servicio||' | '||tab_nuevo(I).t_v_cod_servsupl||' | '||tab_nuevo(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_PERFILES ----------');
    FOR I IN 0..ind_perfiles - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_perfiles(I).t_v_origen||' | '||tab_perfiles(I).t_v_cod_accion||' | '||tab_perfiles(I).t_v_cod_servicio||' | '||tab_perfiles(I).t_v_cod_servsupl||' | '||tab_perfiles(I).t_v_cod_nivel||' | ');
    END LOOP;

EXCEPTION
    WHEN FIN_EJECUCION THEN
                 NULL;
        WHEN ERROR_PROCESO THEN
                SN_cod_retorno   := SN_cod_retorno;
                SV_mens_retorno  := SV_mens_retorno;
                SN_num_evento    := SN_num_evento;
    --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Proceso error. N° evento' || to_char(SN_num_evento)  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'No se encuentra datos';
                SN_num_evento    := 0;
  --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No existen datos.'  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.
        WHEN OTHERS THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno:= CV_error_no_clasif;
                LV_des_error := 'PV_REGLA_INCOMPATIBILIDAD_PR(' || EN_num_abonado || ')';
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                'PV_TRATAMIENTO_SS_PG.PV_REGLA_INCOMPATIBILIDAD_PR', sSql, SQLCODE, LV_des_error );
  --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.
END PV_REGLA_INCOMPATIBILIDAD_PR;


PROCEDURE PV_ACTIVA_DESACTIVA_SS_PR(EN_num_abonado        IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                    SN_cod_retorno    OUT NOCOPY GE_ERRORES_PG.CodError,
                                    SV_mens_retorno   OUT NOCOPY GE_ERRORES_PG.MsgError,
                                    SN_num_evento     OUT NOCOPY GE_ERRORES_PG.Evento)
/*
<Documentación
TipoDoc = "Procedure">
 <Elemento
    Nombre = "PV_ACTIVA_DESACTIVA_SS_PR"
    Lenguaje="PL/SQL"
    Fecha="14-12-2006"
    Versión="1.0"
    Diseñador="Manuel Acevedo M"
    Programador="Manuel Acevedo M."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Realiza activacion y desactivacion a nivel comercial de los servicios suplementarios>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/

IS

LN_fila1                    NUMBER;
LN_fila2                    NUMBER;
LN_fila3                    NUMBER;

LV_ori_contr            VARCHAR2(3);
LV_acc_contr            VARCHAR2(1);
LV_ser_contr            GA_SERVSUPL.COD_SERVICIO%TYPE;
LN_ser_contr            GA_SERVSUPL.COD_SERVSUPL%TYPE;
LV_niv_contr            GA_SERVSUPL.COD_NIVEL%TYPE;

LV_ori_nuevo            VARCHAR2(3);
LV_acc_nuevo            VARCHAR2(1);
LV_ser_nuevo            GA_SERVSUPL.COD_SERVICIO%TYPE;
LN_servsupl_nuevo       GA_SERVSUPL.COD_SERVSUPL%TYPE;--ocb-pan12
LV_niv_nuevo            GA_SERVSUPL.COD_NIVEL%TYPE;

LV_ori_perfiles         VARCHAR2(3);
LV_acc_perfiles         VARCHAR2(1);
LV_ser_perfiles         GA_SERVSUPL.COD_SERVICIO%TYPE;
LN_ser_perfiles         GA_SERVSUPL.COD_SERVSUPL%TYPE;
LV_niv_perfiles         GA_SERVSUPL.COD_NIVEL%TYPE;

LV_tip_terminal         GA_ABOCEL.TIP_TERMINAL%TYPE;
LV_cod_tecnologia       GA_ABOCEL.COD_TECNOLOGIA%TYPE;
LV_cod_plan_tarif       GA_ABOCEL.COD_PLANTARIF%TYPE;
LN_cod_central          GA_ABOCEL.COD_CENTRAL%TYPE;
LN_num_celular          GA_ABOCEL.NUM_CELULAR%TYPE;
LN_cod_sistema          ICG_CENTRAL.COD_SISTEMA%TYPE;

LV_error                        VARCHAR2(2);

LN_cod_concepto         GA_ACTUASERV.COD_CONCEPTO%TYPE;

LV_des_error            GE_ERRORES_PG.DesEvent;
sSql                    GE_ERRORES_PG.vQuery;
ERROR_PROCESO           EXCEPTION;

FIN_EJECUCION           EXCEPTION;

BEGIN

        IF SN_cod_retorno <> 0 THEN
           RAISE FIN_EJECUCION;
        END IF;
        LN_fila1:=0;
        LN_fila2:=0;
        LN_fila3:=0;

        SN_cod_retorno   := 0;
        SV_mens_retorno  := 'OK';
        SN_num_evento    := 0;

        sSql :='PV_RECUPERA_DATOS_ABONADO_PR(' || EN_num_abonado || ',' || LV_tip_terminal || ',' ||LV_cod_tecnologia|| ', ';
        sSql := sSql || LV_cod_plan_tarif || ','|| LN_cod_central ||','|| LN_num_celular || ',' ||LN_cod_sistema || ',' ||SN_cod_retorno|| ', ';
        sSql := sSql || SV_mens_retorno || ',' || SN_num_evento|| ')';

        PV_RECUPERA_DATOS_ABONADO_PR(EN_num_abonado,LV_tip_terminal,LV_cod_tecnologia,LV_cod_plan_tarif,LN_cod_central,LN_num_celular,LN_cod_sistema,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF  SN_cod_retorno <> 0 THEN
                LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener Datos del Abonado',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'Error al obtener Datos del Abonado';
                SN_num_evento    := 0;
                RAISE ERROR_PROCESO;

        END IF;
    FOR LN_fila1 IN 0..ind_contratados - 1 LOOP

                LV_ori_contr:=tab_contratados(LN_fila1).t_v_origen;
                LV_acc_contr:=tab_contratados(LN_fila1).t_v_cod_accion;
                LV_ser_contr:=tab_contratados(LN_fila1).t_v_cod_servicio;
                LN_ser_contr:=tab_contratados(LN_fila1).t_v_cod_servsupl;
                LV_niv_contr:=tab_contratados(LN_fila1).t_v_cod_nivel;

                IF LV_acc_contr = CV_a  THEN
                   -- ACTIVAR --

                   sSql :='SELECT a.cod_concepto  ';
                   sSql :=sSql || 'FROM   ga_actuaserv a ';
                   sSql :=sSql || 'WHERE  a.cod_producto = ' || CN_producto;
                   sSql :=sSql || 'AND    a.cod_tipserv = ' || CN_tip_serv;
                   sSql :=sSql || 'AND    a.cod_servicio = ' || LV_ser_contr;
                   sSql :=sSql || 'AND    a.cod_actabo = ' || CV_fa;

                   BEGIN

                           SELECT a.cod_concepto
                           INTO   LN_cod_concepto
                           FROM   ga_actuaserv a
                           WHERE  a.cod_producto = CN_producto
                           AND    a.cod_tipserv = CN_tip_serv
                           AND    a.cod_servicio = LV_ser_contr
                           AND    a.cod_actabo = CV_fa;

                   EXCEPTION
                   WHEN NO_DATA_FOUND THEN
          LN_cod_concepto:=NULL;--ocb-pan12

         WHEN OTHERS THEN--ocb-pan12
                                LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener concepto',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                                SN_cod_retorno   := 4;
                                SV_mens_retorno  := 'Error al obtener concepto';
                                SN_num_evento    := 0;
                                RAISE ERROR_PROCESO;

                   END;

                   INSERT INTO GA_SERVSUPLABO(num_abonado,cod_servicio,fec_altabd,cod_servsupl,
                                                                          cod_nivel,num_terminal,cod_producto,nom_usuarora,
                                                                          ind_estado,cod_concepto)
                   VALUES (EN_num_abonado,LV_ser_contr,SYSDATE,LN_ser_contr,
                                   LV_niv_contr,LN_num_celular,CN_producto,USER,CN_estado1,LN_cod_concepto);
dbms_output.PUT_LINE('  ----> ACTIVAR CONTRATADOS-'|| LV_ser_contr||'-'|| LN_ser_contr||'-'|| LV_niv_contr||'-'|| CN_estado1||'-');
            END IF;

                IF LV_acc_contr = CV_d THEN
                   -- DESACTIVAR --

                   sSql :='UPDATE ga_servsuplabo a ';
                   sSql :=sSql || 'SET    a.fec_bajabd = ' || SYSDATE;
                   sSql :=sSql || ', a.ind_estado = ' || CN_estado;
                   sSql :=sSql || 'WHERE  a.num_abonado = ' || EN_num_abonado;
                   sSql :=sSql || 'AND    a.cod_servsupl = ' || LN_ser_contr;
                   sSql :=sSql || 'AND    a.cod_nivel = ' || LV_niv_contr;
                   sSql :=sSql || 'AND    a.ind_estado < ' || CN_estado;

                   UPDATE ga_servsuplabo a
                   SET    a.fec_bajabd = SYSDATE, a.ind_estado = CN_estado
                   WHERE  a.num_abonado=EN_num_abonado
                   AND    a.cod_servsupl = LN_ser_contr
                   AND    a.cod_nivel = LV_niv_contr
                   AND    a.ind_estado < CN_estado;

dbms_output.PUT_LINE('  ----> DESACTIVAR CONTRATADOS'|| LN_ser_contr||'-'|| LV_niv_contr||'-'|| CN_estado||'-');
            END IF;

    END LOOP;

    FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

                LV_ori_nuevo:=tab_nuevo(LN_fila2).t_v_origen;
                LV_acc_nuevo:=tab_nuevo(LN_fila2).t_v_cod_accion;
                LV_ser_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servicio;
  LN_servsupl_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servsupl;--ocb-pan12
                LV_niv_nuevo:=tab_nuevo(LN_fila2).t_v_cod_nivel;

                IF LV_acc_nuevo = CV_a  THEN
                   -- ACTIVAR --
dbms_output.PUT_LINE('  ----> ACTIVAR NUEVOS-'|| LV_ser_nuevo||'-'|| LN_servsupl_nuevo||'-'|| LV_niv_nuevo||'-'|| CN_estado1||'-');
                   sSql :='SELECT a.cod_concepto  ';
                   sSql :=sSql || 'FROM   ga_actuaserv a ';
                   sSql :=sSql || 'WHERE  a.cod_producto = ' || CN_producto;
                   sSql :=sSql || 'AND    a.cod_tipserv = ' || CN_tip_serv;
                   sSql :=sSql || 'AND    a.cod_servicio = ' || LV_ser_nuevo;
                   sSql :=sSql || 'AND    a.cod_actabo = ' || CV_fa;

                   BEGIN

                           SELECT a.cod_concepto
                           INTO   LN_cod_concepto
                           FROM   ga_actuaserv a
                           WHERE  a.cod_producto = CN_producto
                           AND    a.cod_tipserv = CN_tip_serv
                           AND    a.cod_servicio = LV_ser_nuevo
                           AND    a.cod_actabo = CV_fa;

                   EXCEPTION
                   WHEN NO_DATA_FOUND THEN
dbms_output.PUT_LINE('  ----> ACTIVAR NUEVOS- NO HAY NA');
          LN_cod_concepto:=NULL;
dbms_output.PUT_LINE('  ----> ACTIVAR NUEVOS- NO HAY NA DE NA');

         WHEN OTHERS THEN
                                LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener concepto',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                                SN_cod_retorno   := 4;
                                SV_mens_retorno  := 'Error al obtener concepto';
                                SN_num_evento    := 0;
                                RAISE ERROR_PROCESO;

                   END;

dbms_output.PUT_LINE('  ----> ACTIVAR NUEVOS- VOY AL INS');
DBMS_OUTPUT.PUT_LINE ( 'EN_num_abonado= ' || EN_num_abonado ||'*');
DBMS_OUTPUT.PUT_LINE ( 'LV_ser_nuevo= ' || LV_ser_nuevo ||'*');
DBMS_OUTPUT.PUT_LINE ( 'SYSDATE= ' || SYSDATE ||'*');
DBMS_OUTPUT.PUT_LINE ( 'LN_servsupl_nuevo= ' || LN_servsupl_nuevo ||'*');
DBMS_OUTPUT.PUT_LINE ( 'LV_niv_nuevo= ' || LV_niv_nuevo ||'*');
DBMS_OUTPUT.PUT_LINE ( 'LN_num_celular= ' || LN_num_celular ||'*');
DBMS_OUTPUT.PUT_LINE ( 'CN_producto= ' || CN_producto ||'*');
DBMS_OUTPUT.PUT_LINE ( 'USER= ' || USER ||'*');
DBMS_OUTPUT.PUT_LINE ( 'CN_estado1= ' || CN_estado1 ||'*');
DBMS_OUTPUT.PUT_LINE ( 'LN_cod_concepto= ' || LN_cod_concepto ||'*');

                   INSERT INTO GA_SERVSUPLABO(num_abonado,cod_servicio,fec_altabd,cod_servsupl,
                                                                          cod_nivel,num_terminal,cod_producto,nom_usuarora,
                                                                          ind_estado,cod_concepto)
     VALUES (EN_num_abonado,LV_ser_nuevo,SYSDATE,LN_servsupl_nuevo,
          LV_niv_nuevo,TO_CHAR(LN_num_celular),CN_producto,USER,CN_estado1,LN_cod_concepto);
dbms_output.PUT_LINE('  ----> ACTIVAR NUEVOS-'|| LV_ser_nuevo||'-'|| LN_servsupl_nuevo||'-'|| LV_niv_nuevo||'-'|| CN_estado1||'-');
            END IF;

                IF LV_acc_nuevo = CV_d THEN
                   -- DESACTIVAR --

                   sSql :='UPDATE ga_servsuplabo a ';
                   sSql :=sSql || 'SET    a.fec_bajabd = ' || SYSDATE;
                   sSql :=sSql || ', a.ind_estado = ' || CN_estado;
                   sSql :=sSql || 'WHERE  a.num_abonado = ' || EN_num_abonado;
     sSql :=sSql || 'AND    a.cod_servsupl = ' || LN_servsupl_nuevo; --ocb12
                   sSql :=sSql || 'AND    a.cod_nivel = ' || LV_niv_nuevo;
                   sSql :=sSql || 'AND    a.ind_estado < ' || CN_estado;

                   UPDATE ga_servsuplabo a
                   SET    a.fec_bajabd = SYSDATE, a.ind_estado = CN_estado
                   WHERE  a.num_abonado=EN_num_abonado
     AND    a.cod_servsupl = LN_servsupl_nuevo --ocb12
                   AND    a.cod_nivel = LV_niv_nuevo
                   AND    a.ind_estado < CN_estado;
dbms_output.PUT_LINE('  ----> DESACTIVAR NUEVOS'|| LN_servsupl_nuevo||'-'|| LV_niv_nuevo||'-'|| CN_estado||'-');
         END IF;

    END LOOP;

    FOR LN_fila3 IN 0..ind_perfiles - 1 LOOP

                LV_ori_perfiles:=tab_perfiles(LN_fila3).t_v_origen;
                LV_acc_perfiles:=tab_perfiles(LN_fila3).t_v_cod_accion;
                LV_ser_perfiles:=tab_perfiles(LN_fila3).t_v_cod_servicio;
                LN_ser_perfiles:=tab_perfiles(LN_fila3).t_v_cod_servsupl;
                LV_niv_perfiles:=tab_perfiles(LN_fila3).t_v_cod_nivel;

                IF LV_acc_perfiles = CV_a  THEN
                   -- ACTIVAR --
                   sSql :='SELECT a.cod_concepto  ';
                   sSql :=sSql || 'FROM   ga_actuaserv a ';
                   sSql :=sSql || 'WHERE  a.cod_producto = ' || CN_producto;
                   sSql :=sSql || 'AND    a.cod_tipserv = ' || CN_tip_serv;
                   sSql :=sSql || 'AND    a.cod_servicio = ' || LV_ser_perfiles;
                   sSql :=sSql || 'AND    a.cod_actabo = ' || CV_fa;

                   BEGIN

                           SELECT a.cod_concepto
                           INTO   LN_cod_concepto
                           FROM   ga_actuaserv a
                           WHERE  a.cod_producto = CN_producto
                           AND    a.cod_tipserv = CN_tip_serv
                           AND    a.cod_servicio = LV_ser_perfiles
                           AND    a.cod_actabo = CV_fa;

                   EXCEPTION
                   WHEN NO_DATA_FOUND THEN --ocb12
          LN_cod_concepto:=NULL; --ocb12

         WHEN OTHERS THEN
                                LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener concepto',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                                SN_cod_retorno   := 4;
                                SV_mens_retorno  := 'Error al obtener concepto';
                                SN_num_evento    := 0;
                                RAISE ERROR_PROCESO;

                   END;

                   INSERT INTO GA_SERVSUPLABO(num_abonado,cod_servicio,fec_altabd,cod_servsupl,
                                                                          cod_nivel,num_terminal,cod_producto,nom_usuarora,
                                                                          ind_estado,cod_concepto)
                   VALUES (EN_num_abonado,LV_ser_perfiles,SYSDATE,LN_ser_perfiles,
                                   LV_niv_perfiles,LN_num_celular,CN_producto,USER,CN_estado1,LN_cod_concepto);
dbms_output.PUT_LINE('  ----> ACTIVAR PERFIL'|| LV_ser_perfiles||'-'|| LN_ser_perfiles||'-'|| LV_niv_perfiles||'-'|| CN_estado1||'-');
            END IF;

  IF LV_acc_perfiles = CV_d  THEN --ocb-pan12
                   -- DESACTIVAR --

                   sSql :='UPDATE ga_servsuplabo a ';
                   sSql :=sSql || 'SET    a.fec_bajabd = ' || SYSDATE;
                   sSql :=sSql || ', a.ind_estado = ' || CN_estado;
                   sSql :=sSql || 'WHERE  a.num_abonado = ' || EN_num_abonado;
                   sSql :=sSql || 'AND    a.cod_servsupl = ' || LN_ser_perfiles;
                   sSql :=sSql || 'AND    a.cod_nivel = ' || LV_niv_perfiles;
                   sSql :=sSql || 'AND    a.ind_estado < ' || CN_estado;

                   UPDATE ga_servsuplabo a
                   SET    a.fec_bajabd = SYSDATE, a.ind_estado = CN_estado
                   WHERE  a.num_abonado=EN_num_abonado
                   AND    a.cod_servsupl = LN_ser_perfiles
                   AND    a.cod_nivel = LV_niv_perfiles
                   AND    a.ind_estado < CN_estado;
dbms_output.PUT_LINE('  ----> DESACTIVAR PERFIL'|| LN_ser_perfiles||'-'|| LV_niv_perfiles||'-'|| CN_estado||'-');
            END IF;

    END LOOP;

    dbms_output.PUT_LINE('TAB_CONTRATADOS ----------');
    FOR I IN 0..ind_contratados - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_contratados(I).t_v_origen||' | '||tab_contratados(I).t_v_cod_accion||' | '||tab_contratados(I).t_v_cod_servicio||' | '||tab_contratados(I).t_v_cod_servsupl||' | '||tab_contratados(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_NUEVO ----------');
    FOR I IN 0..ind_nuevo - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_nuevo(I).t_v_origen||' | '||tab_nuevo(I).t_v_cod_accion||' | '||tab_nuevo(I).t_v_cod_servicio||' | '||tab_nuevo(I).t_v_cod_servsupl||' | '||tab_nuevo(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_PERFILES ----------');
    FOR I IN 0..ind_perfiles - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_perfiles(I).t_v_origen||' | '||tab_perfiles(I).t_v_cod_accion||' | '||tab_perfiles(I).t_v_cod_servicio||' | '||tab_perfiles(I).t_v_cod_servsupl||' | '||tab_perfiles(I).t_v_cod_nivel||' | ');
    END LOOP;

EXCEPTION
    WHEN FIN_EJECUCION THEN
                 NULL;
        WHEN ERROR_PROCESO THEN

  LV_des_error := 'PV_ACTIVA_DESACTIVA_SS_PR(' || EN_num_abonado || ')';
  SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
  'PV_TRATAMIENTO_SS_PG.PV_ACTIVA_DESACTIVA_SS_PR', sSql, SQLCODE, LV_des_error );

    --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Proceso error. N° evento' || to_char(SN_num_evento)  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.

        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'No se encuentra datos';
                SN_num_evento    := 0;
  --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No existen datos.'  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.
        WHEN OTHERS THEN

dbms_output.PUT_LINE('SQLCODE = '||SQLCODE);
dbms_output.PUT_LINE('SQLCODE = '||SQLERRM);

                SN_cod_retorno   := 4;
                SV_mens_retorno:= CV_error_no_clasif;
                LV_des_error := 'PV_ACTIVA_DESACTIVA_SS_PR(' || EN_num_abonado || ')';
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                'PV_TRATAMIENTO_SS_PG.PV_ACTIVA_DESACTIVA_SS_PR', sSql, SQLCODE, LV_des_error );
  --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.


END PV_ACTIVA_DESACTIVA_SS_PR;


PROCEDURE PV_REGLA_SS_ATLANTIDA_PR(EN_num_abonado         IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                   EV_cod_plan_destino    IN  TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                   EV_cod_ooss            IN  CI_ORSERV.COD_OS%TYPE,
                                   SN_cod_retorno         OUT NOCOPY GE_ERRORES_PG.CodError,
                                   SV_mens_retorno        OUT NOCOPY GE_ERRORES_PG.MsgError,
                                   SN_num_evento          OUT NOCOPY GE_ERRORES_PG.Evento)
/*
<Documentación
TipoDoc = "Procedure">
 <Elemento
    Nombre = "PV_REGLA_SS_ATLANTIDA_PR"
    Lenguaje="PL/SQL"
    Fecha="14-12-2006"
    Versión="1.0"
    Diseñador="Manuel Acevedo M"
    Programador="Manuel Acevedo M."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Encargado de validar los servicios suplementarios ATLANTIDA>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/

IS

LN_fila1                           NUMBER;
LN_fila2                                   NUMBER;

LV_aplica                                  VARCHAR2(5);
LV_abonado_atlantida       VARCHAR2(5); --Respuesta a si abonado es atlantida.
LV_plan_atlantida                  VARCHAR2(5); --Respuesta a si plan destino es atlantida.
LV_actabo                                  VARCHAR2(2);
LN_pos                                     NUMBER;

--LV_usuario_adm                   VARCHAR2(5);

LV_error                                   VARCHAR2(5);

LV_ori_contr                       VARCHAR2(3);
LN_ser_contr                       GA_SERVSUPL.COD_SERVSUPL%TYPE;
LV_ori_nuevo                       VARCHAR2(3);

LV_valor                                   VARCHAR2(250);

LV_des_error                       GE_ERRORES_PG.DesEvent;
sSql                               GE_ERRORES_PG.vQuery;

FIN_EJECUCION                      EXCEPTION;

BEGIN

        IF SN_cod_retorno <> 0 THEN
           RAISE FIN_EJECUCION;
        END IF;

        SN_cod_retorno   := 0;
        SV_mens_retorno  := 'OK';
        SN_num_evento    := 0;

        BEGIN

                sSql :='SELECT a.valor_texto  ';
                sSql :=sSql || 'FROM  ga_parametros_simples_vw a ';
                sSql :=sSql || 'WHERE a.nom_parametro = ' || CV_aplica_atlantida;
                sSql :=sSql || 'AND   a.cod_modulo    = ' || CV_mo_ga;
                sSql :=sSql || 'AND    a.cod_operadora = (select cod_operadora_scl from ge_operadora_scl_local)';

                SELECT a.valor_texto
                INTO   LV_aplica
                FROM   ga_parametros_simples_vw a
                WHERE  a.nom_parametro = CV_aplica_atlantida
                AND    a.cod_modulo    = CV_mo_ga
                AND    a.cod_operadora = (select cod_operadora_scl from ge_operadora_scl_local);

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                                LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No se encuentra valor asociado a parametro '|| CV_aplica_atlantida,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                                SN_cod_retorno   := 4;
                                SV_mens_retorno  := 'No se encuentra valor asociado a parametro '|| CV_aplica_atlantida;
                                SN_num_evento    := 0;
                                RAISE FIN_EJECUCION;
        END;

        BEGIN

                sSql:='SELECT a.cod_tipmodi';
                sSql:=sSql ||' FROM  ci_tiporserv a ';
                sSql:=sSql ||' WHERE a.cod_os = ' || EV_cod_ooss;

                SELECT a.cod_tipmodi
                INTO   LV_actabo
                FROM   ci_tiporserv a
                WHERE  a.cod_os = EV_cod_ooss;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
                LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No se encuentra actuación.',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'No se encuentra actuación.';
                SN_num_evento    := 0;
                RAISE FIN_EJECUCION;
        END;


 LN_pos:=NVL(INSTR(CV_ooss,LV_actabo),0); --ocb12

 --Quitamos filtro por actuacion
 --IF LV_aplica = CV_true AND LN_pos <> 0 THEN --ocb12
 IF LV_aplica = CV_true THEN

                --- LLamada al package para obtener abonado atlantida ----
                sSql :='pv_obtieneinfo_atlantida_pg.pv_existeaboatlantida2_pr('|| EN_num_abonado ||','|| LV_Abonado_Atlantida ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
                pv_obtieneinfo_atlantida_pg.pv_existeaboatlantida2_pr(EN_num_abonado,LV_Abonado_Atlantida,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                IF  SN_cod_retorno <> 0 THEN
                    LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener abonado atlantida',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                        SN_cod_retorno   := 4;
                        SV_mens_retorno  := 'Error para obtener abonado atlantida';
                        SN_num_evento    := 0;
                        RAISE FIN_EJECUCION;
                END IF;

         --- LLamada a función para obtener plan atlantida ----
                 sSql :='PV_PLAN_DESTINO_ATLANTIDA_FN('|| EV_cod_plan_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
         LV_plan_atlantida :=PV_TRATAMIENTO_SS_PG.PV_PLAN_DESTINO_ATLANTIDA_FN(EV_cod_plan_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                 IF  SN_cod_retorno <> 0 THEN
                         LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener plan atlantida',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                     SN_cod_retorno   := 4;
                     SV_mens_retorno  := 'Error para obtener plan atlantida';
                         SN_num_evento    := 0;
                     RAISE FIN_EJECUCION;
                 END IF;


                 IF LV_Abonado_Atlantida = CV_true OR LV_plan_atlantida = CV_true THEN

                        LN_fila1:=0;
                        --marcar TODOS los SS de la matriz contratados con la acción para Desactivar
                        FOR LN_fila1 IN 0..ind_contratados - 1 LOOP

                                tab_contratados(LN_fila1).t_v_cod_accion:=CV_d;

                        END LOOP;

                        LN_fila2:=0;

                        FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

                                LV_ori_nuevo:=tab_nuevo(LN_fila2).t_v_origen;

    --PACC ....
        IF LV_ori_nuevo = CV_def  OR (LV_ori_nuevo = CV_opc AND  tab_nuevo(LN_fila2).t_v_cod_accion  IN (CV_a , CV_m)) THEN--ocb12

                                   -- ACTIVAR NUEVO --
                                   tab_nuevo(LN_fila2).t_v_cod_accion:=CV_a;

                                END IF;

                        END LOOP;

                 END IF;


        END IF;

    dbms_output.PUT_LINE('TAB_CONTRATADOS ----------');
    FOR I IN 0..ind_contratados - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_contratados(I).t_v_origen||' | '||tab_contratados(I).t_v_cod_accion||' | '||tab_contratados(I).t_v_cod_servicio||' | '||tab_contratados(I).t_v_cod_servsupl||' | '||tab_contratados(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_NUEVO ----------');
    FOR I IN 0..ind_nuevo - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_nuevo(I).t_v_origen||' | '||tab_nuevo(I).t_v_cod_accion||' | '||tab_nuevo(I).t_v_cod_servicio||' | '||tab_nuevo(I).t_v_cod_servsupl||' | '||tab_nuevo(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_PERFILES ----------');
    FOR I IN 0..ind_perfiles - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_perfiles(I).t_v_origen||' | '||tab_perfiles(I).t_v_cod_accion||' | '||tab_perfiles(I).t_v_cod_servicio||' | '||tab_perfiles(I).t_v_cod_servsupl||' | '||tab_perfiles(I).t_v_cod_nivel||' | ');
    END LOOP;

EXCEPTION
    WHEN FIN_EJECUCION THEN
                 NULL;
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'No se encuentra datos';
                SN_num_evento    := 0;
  --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No existen datos.'  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.
        WHEN OTHERS THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno:= CV_error_no_clasif;
                LV_des_error := 'PV_REGLA_SS_ATLANTIDA_PR(' || EN_num_abonado || ',' || EV_cod_plan_destino ||')';
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                'PV_TRATAMIENTO_SS_PG.PV_REGLA_SS_ATLANTIDA_PR', sSql, SQLCODE, LV_des_error );
  --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.


END PV_REGLA_SS_ATLANTIDA_PR;

PROCEDURE PV_CARGA_SS_PERF_CENT_PR(EN_num_abonado            IN     GA_ABOCEL.NUM_ABONADO%TYPE,
                                   EV_cod_plantarif_origen   IN  GA_ABOCEL.COD_PLANTARIF%TYPE,--ocb12
                                   EV_cod_plan_destino       IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                   SN_cod_retorno            IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                   SV_mens_retorno           IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                   SN_num_evento             IN OUT NOCOPY GE_ERRORES_PG.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento;
      Nombre = "PV_CARGA_SS_PERF_CENT_PR"
      Lenguaje="PL/SQL"
      Fecha="15-12-2006"
      Versión="1.0"
      Diseñador="Yury Andres Alvarez Tapia"
          Programador="Yury Andres Alvarez Tapia"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_num_abonado"          Tipo="NUMERICO">Número del Abonado</param>
                        <param nom="EV_cod_plantarifnue"     Tipo="CARACTER">Plan tarifario nuevo</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"          Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"         Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"           Tipo="NUMERICO">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

        LV_des_error         GE_ERRORES_PG.DesEvent;
        sSql                 GE_ERRORES_PG.vQuery;
        FIN_EJECUCION        EXCEPTION;

        LV_codtiplan         TA_PLANTARIF.COD_TIPLAN%TYPE;
        LV_act_alta_nuevo    VARCHAR2(20);

        SV_GLOSA             VARCHAR2(200);
        LN_INDICE                        BINARY_INTEGER := 0;


        LV_cant_servicios    ICG_ACTUACIONTERCEN.COD_SERVICIOS%TYPE;  --Cantidad de SS para perfil.
        LN_largo_servicio    NUMBER(6):= 6;
        LN_contador          NUMBER:=1;

        LV_sGrupo            VARCHAR2(2);
        LV_sNivel            VARCHAR2(4);

        LV_cod_servicio      GA_SERVSUPL.COD_SERVICIO%TYPE;

        LV_cambio_producto   VARCHAR2(5);
        LV_error                         VARCHAR2(5);

        LV_tip_terminal      GA_ABOCEL.TIP_TERMINAL%TYPE;
        LV_cod_tecnologia    GA_ABOCEL.COD_TECNOLOGIA%TYPE;
        LV_cod_plan_tarif    GA_ABOCEL.COD_PLANTARIF%TYPE;
        LN_cod_central       GA_ABOCEL.COD_CENTRAL%TYPE;
        LN_num_celular       GA_ABOCEL.NUM_CELULAR%TYPE;
        LN_cod_sistema       ICG_CENTRAL.COD_SISTEMA%TYPE;

        LV_cod_servicios     ICG_ACTUACIONTERCEN.COD_SERVICIOS%TYPE;
        LN_cod_servsupl      GA_SERVSUPL.COD_SERVSUPL%TYPE;
        LN_cod_nivel         GA_SERVSUPL.COD_NIVEL%TYPE;
        LV_tip_relacion      GAD_SERVSUP_PLAN.TIP_RELACION%TYPE;

        CURSOR  CARGA_SS_PERFIL_CENTRALES  IS
        SELECT  C.cod_servicios
        FROM    ga_actabo A
              , ged_parametros B
              , icg_actuaciontercen C
        WHERE   A.cod_actabo     = B.val_parametro
        AND     A.cod_producto   = CN_producto
		AND     A.cod_tecnologia = LV_cod_tecnologia
		AND     A.cod_modulo     = CV_mo_ga
        AND     B.nom_parametro  = LV_act_alta_nuevo
        AND     C.cod_actuacion  = A.cod_actcen
        AND     C.tip_terminal   = LV_tip_terminal
        AND     C.tip_tecnologia = LV_cod_tecnologia
        AND     C.cod_sistema    = LN_cod_sistema;


BEGIN

        IF SN_cod_retorno <> 0 THEN
           RAISE FIN_EJECUCION;
        END IF;

        SN_cod_retorno   := 0;
        SV_mens_retorno  := 'OK';
        SN_num_evento    := 0;
        ind_perfiles     := 0;

        sSql :='PV_RECUPERA_DATOS_ABONADO_PR('||EN_num_abonado||','||LV_tip_terminal||','||LV_cod_tecnologia||', ';
        sSql := sSql||EV_cod_plan_destino ||','||LN_cod_central||','||LN_num_celular||','||LN_cod_sistema||','||SN_cod_retorno||', ';
        sSql := sSql||SV_mens_retorno||','||SN_num_evento||')';
        LV_cod_plan_tarif :=EV_cod_plan_destino;
        PV_RECUPERA_DATOS_ABONADO_PR(EN_num_abonado,LV_tip_terminal,LV_cod_tecnologia,LV_cod_plan_tarif ,LN_cod_central,LN_num_celular,LN_cod_sistema,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF  SN_cod_retorno <> 0 THEN
            LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener Datos del Abonado',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

            SN_cod_retorno   := 4;
            SV_mens_retorno  := 'Error al obtener Datos del Abonado';
            SN_num_evento    := 0;
            RAISE FIN_EJECUCION;
        END IF;


        BEGIN

            sSql :='SELECT A.cod_tiplan ';
            sSql :=sSql || 'INTO   LV_codtiplan';
            sSql :=sSql || 'FROM   ta_plantarif A ';
            sSql :=sSql || 'WHERE  A.cod_plantarif ='|| EV_cod_plan_destino ;
            sSql :=sSql || 'AND    A.cod_producto  ='|| CN_PRODUCTO;

            SELECT A.cod_tiplan
            INTO   LV_codtiplan
            FROM   ta_plantarif A
            WHERE  A.cod_plantarif = EV_cod_plan_destino -- plan destino.
            AND    A.cod_producto  = CN_PRODUCTO;

            IF LV_codtiplan = CV_codtiplan2  THEN
               LV_act_alta_nuevo := CV_alta_postpago; --vista sacar desde alli .
            ELSE
			   IF LV_codtiplan = CV_codtiplan3  THEN
                  LV_act_alta_nuevo := CV_alta_hibrido;
               ELSE
			      LV_act_alta_nuevo := CV_alta_prepago;
               END IF;
            END IF;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN

            LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener Tipo de Plan Tarifario',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

            SN_cod_retorno   := 4;
            SV_mens_retorno  := 'Error al obtener Tipo de Plan Tarifario';
            SN_num_evento    := 0;
            RAISE FIN_EJECUCION;

        END;

    --- LLamada a función para obtener plan atlantida ----
        sSql :='PV_existe_cambio_producto_FN('|| EN_num_abonado ||','|| EV_cod_plantarif_origen ||','|| EV_cod_plan_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
        LV_cambio_producto := PV_TRATAMIENTO_SS_PG.PV_EXISTE_CAMBIO_PRODUCTO_FN(EN_num_abonado,EV_cod_plantarif_origen,EV_cod_plan_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF  SN_cod_retorno <> 0 THEN
            LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener cambio de producto',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

            SN_cod_retorno   := 4;
            SV_mens_retorno  := 'Error al obtener cambio de producto';
            SN_num_evento    := 0;
            RAISE FIN_EJECUCION;
        END IF;

       sSql :='SELECT C.cod_servicios  ';
       sSql :=sSql || 'FROM  ga_actabo A, ged_parametros B, icg_actuaciontercen C  ';  --poner desde vista en ves de ged_parametros.
       sSql :=sSql || 'WHERE A.cod_actabo     =  B.val_parametro ';
       sSql :=sSql || 'AND   A.cod_producto   = '||CN_PRODUCTO;
       sSql :=sSql || 'AND   A.cod_tecnologia = '||LV_cod_tecnologia;
       sSql :=sSql || 'AND   A.cod_modulo     = '||CV_mo_ga;
       sSql :=sSql || 'AND   B.nom_parametro  = '|| LV_act_alta_nuevo ;
       sSql :=sSql || 'AND   C.cod_actuacion  =  A.cod_actcen ';
       sSql :=sSql || 'AND   C.tip_terminal   = '||LV_tip_terminal;
       sSql :=sSql || 'AND   C.tip_tecnologia = '||LV_cod_tecnologia;
       sSql :=sSql || 'AND   C.cod_sistema    = '||LN_cod_sistema;


       OPEN CARGA_SS_PERFIL_CENTRALES ;
       LOOP
         FETCH CARGA_SS_PERFIL_CENTRALES INTO LV_cod_servicios;
             EXIT WHEN CARGA_SS_PERFIL_CENTRALES%NOTFOUND;

             LV_cant_servicios := (LENGTH(LV_cod_servicios) / LN_largo_servicio );

        IF LV_CANT_SERVICIOS IS NOT NULL THEN 
             
             FOR LN_INDICE  IN 0..LV_cant_servicios - 1 LOOP

                     SV_GLOSA := SUBSTR(LV_cod_servicios,LN_contador, LN_largo_servicio);

                     LN_cod_servsupl := SUBSTR(SV_GLOSA,1,2);
                     LN_cod_nivel    := SUBSTR(SV_GLOSA,3,4);

                     BEGIN

                       SELECT D.cod_servicio
                       INTO   LV_cod_servicio
                       FROM   ga_servsupl D
                       WHERE  D.cod_servsupl  = LN_cod_servsupl
                       AND    D.cod_nivel     = LN_cod_nivel
                       AND    D.cod_producto  = CN_PRODUCTO;

         --   IF LV_cod_servicio IS NOT NULL THEN
                    EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                              LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No se encuentra Codigo de Servicio Comercial',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                              SN_cod_retorno   := 4;
                              SV_mens_retorno  := 'No se encuentra Codigo de Servicio Comercial';
                              SN_num_evento    := 0;
                              RAISE FIN_EJECUCION;
         --   END IF;--ocb12
                 END;

                 IF  LV_cambio_producto= 'TRUE' THEN
                     tab_perfiles(ind_perfiles).t_v_origen       := CV_per;
                     tab_perfiles(ind_perfiles).t_v_cod_servicio := LV_cod_servicio ;
                     tab_perfiles(ind_perfiles).t_v_cod_servsupl := LN_cod_servsupl;
                     tab_perfiles(ind_perfiles).t_v_cod_nivel    := LN_cod_nivel;
                     tab_perfiles(ind_perfiles).t_v_cod_accion   := CV_a;

                 ELSE
                     tab_perfiles(ind_perfiles).t_v_origen       := CV_per;
                     tab_perfiles(ind_perfiles).t_v_cod_servicio := LV_cod_servicio ;
                     tab_perfiles(ind_perfiles).t_v_cod_servsupl := LN_cod_servsupl;
                     tab_perfiles(ind_perfiles).t_v_cod_nivel    := LN_cod_nivel;
                     tab_perfiles(ind_perfiles).t_v_cod_accion   := CV_n;

                 END IF;

                 ind_perfiles := ind_perfiles + 1;

                 LN_contador := LN_contador + LN_largo_servicio;

             END LOOP;
       END IF;
       
       END LOOP;
       
       
       CLOSE CARGA_SS_PERFIL_CENTRALES;

    dbms_output.PUT_LINE('TAB_PERFILES ----------');
    FOR I IN 0..ind_perfiles - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_perfiles(I).t_v_origen||' | '||tab_perfiles(I).t_v_cod_accion||' | '||tab_perfiles(I).t_v_cod_servicio||' | '||tab_perfiles(I).t_v_cod_servsupl||' | '||tab_perfiles(I).t_v_cod_nivel||' | ');
    END LOOP;

       EXCEPTION
            WHEN FIN_EJECUCION THEN
                 NULL;
            WHEN NO_DATA_FOUND THEN
                 SN_cod_retorno   := 4;
                 SV_mens_retorno  := 'No se encuentra datos';
                 SN_num_evento    := 0;
            --INI. PAGC 18-07-2007 --
                 LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No existen datos.'  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
            --FIN.

            WHEN OTHERS THEN
                 SN_cod_retorno   := 4;
                 SV_mens_retorno  := CV_error_no_clasif;
                 LV_des_error     := 'PV_CARGA_SS_PERF_CENT_PR (' || EN_num_abonado || ',' || LV_cod_plan_tarif || ',' || EV_cod_plan_destino ||')';
                 SN_num_evento    := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                                     'PV_TRATAMIENTO_SS_PG.PV_CARGA_SS_PERF_CENT_PR', sSql, SQLCODE, LV_des_error );
            --INI. PAGC 18-07-2007 --
                LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
            --FIN.

END PV_CARGA_SS_PERF_CENT_PR;


PROCEDURE PV_CARGA_SS_ACTUALES_PR(EN_num_abonado    IN  NUMBER,
                                  EV_cod_plan       IN  TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                  EV_indicador      IN  VARCHAR2,
                                  SN_cod_retorno    OUT NOCOPY GE_ERRORES_PG.CodError,
                                  SV_mens_retorno   OUT NOCOPY GE_ERRORES_PG.MsgError,
                                  SN_num_evento     OUT NOCOPY GE_ERRORES_PG.Evento)
/*
<Documentación
TipoDoc = "Procedure">
 <Elemento
    Nombre = "PV_CARGA_SS_ACTUALES_PR" --
    Lenguaje="PL/SQL"
    Fecha="14-12-2006"
    Versión="1.0"
    Diseñador="Manuel Acevedo M"
    Programador="Manuel Acevedo M."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Carga los servicios suplementarios que actualmente tiene contratado el abonado>
    <Parámetros>
       <Entrada>Numero de Abonado</Entrada>
       <Entrada>Plan Tarifario</Entrada>
       <Entrada>Indicador, S: Si se mantienen los servicios opcionales</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/


IS

        LV_des_error            GE_ERRORES_PG.DesEvent;
        sSql                    GE_ERRORES_PG.vQuery;

        FIN_EJECUCION           EXCEPTION;

        LV_codservicio              GA_SERVSUPL.COD_SERVICIO%TYPE;
        LN_codservsupl              GA_SERVSUPL.COD_SERVSUPL%TYPE;
        LN_codnivel                         GA_SERVSUPL.COD_NIVEL%TYPE;
        LD_fecaltabd                GA_SERVSUPLABO.FEC_ALTABD%TYPE;
        LN_indcentral               GA_SERVSUPL.IND_CENTRAL%TYPE;

        LV_tip_terminal             GA_ABOCEL.TIP_TERMINAL%TYPE;
        LV_cod_tecnologia           GA_ABOCEL.COD_TECNOLOGIA%TYPE;
        LV_cod_plan_tarif           GA_ABOCEL.COD_PLANTARIF%TYPE;
        LN_cod_central              GA_ABOCEL.COD_CENTRAL%TYPE;
        LN_num_celular              GA_ABOCEL.NUM_CELULAR%TYPE;
        LN_cod_sistema              ICG_CENTRAL.COD_SISTEMA%TYPE;

        LV_ser_contr                    GA_SERVSUPL.COD_SERVICIO%TYPE;
        LN_ser_contr                    GA_SERVSUPL.COD_SERVSUPL%TYPE;
        LN_niv_contr                    GA_SERVSUPL.COD_NIVEL%TYPE;
        LV_ori_contr                    VARCHAR2(3);
        LV_acc_contr                    VARCHAR2(1);

        LV_error                        VARCHAR2(5);

        LN_tiprelacion              NUMBER;
        LV_codtiplan                VARCHAR2(5);
        LV_actuacion                VARCHAR2(20);
        LV_codservicios             VARCHAR2(255);

        LV_cadenass                         VARCHAR2(6);
        LN_pos                              NUMBER;

        LN_ss_opc_comerc_centr  NUMBER;

        LN_grupo                                NUMBER;
        LV_grupos_wap_mms_roa   VARCHAR2(250);
        LN_grupo_sms                    NUMBER;
        LN_pos1                         NUMBER;
        LN_pos2                         NUMBER;
        LV_servicios_interopco  VARCHAR2(250);

	    pos_inicial    BINARY_INTEGER := 0;--ocb12

        CURSOR CURSOR_CONTRATADOS is
        SELECT a.cod_servicio, a.cod_servsupl, a.cod_nivel, a.fec_altabd, b.ind_central
        FROM   ga_servsuplabo a, ga_servsupl b
        WHERE  a.cod_producto  = CN_producto
        AND    a.num_abonado   = EN_num_abonado
        AND    a.ind_estado    < CN_estado
        AND    b.cod_producto  = a.cod_producto
        AND    b.cod_servicio  = a.cod_servicio
        AND    b.cod_servsupl  = a.cod_servsupl
        AND    b.cod_nivel     = a.cod_nivel
        AND    a.num_abonado   > 0
        AND    a.fec_altabd    > to_date('01/01/1990','dd/mm/yyyy');

/*--ocb12
        CURSOR CURSOR_GRUPOS_WAP_MMS_ROA IS
        SELECT valor_numerico a
        FROM   ga_parametros_multiples_vw a
        WHERE  a.cod_modulo    = CV_mo_ga
        AND    a.nom_parametro = CV_grupos_wap_mms_roa
        AND    a.cod_operadora = (SELECT b.valor_texto
                                  FROM   ge_parametros_sistema_vw b
                                  WHERE  b.nom_parametro = CV_op_local
                                  AND    b.cod_modulo    = CV_mo_ge);

        CURSOR CURSOR_SERVICIOS_INTEROPCO IS
        SELECT a.valor_texto
        FROM   ga_parametros_multiples_vw a
        WHERE  a.cod_modulo    = CV_mo_ga
        AND    a.nom_parametro = CV_servicios_interopco
        AND    a.cod_operadora = (SELECT b.valor_texto
                                  FROM   ge_parametros_sistema_vw b
                                  WHERE  b.nom_parametro = CV_op_local
                                  AND    b.cod_modulo    = CV_mo_ge);
*/--ocb12

BEGIN

        IF SN_cod_retorno <> 0 THEN
           RAISE FIN_EJECUCION;
        END IF;

 ---Para ocupar en la regla de carga de planes actuales y no agregar un parametro al PL ...
        GV_ind_trasp_opc := EV_indicador;--ocb12

        SN_cod_retorno   := 0;
        SV_mens_retorno  := 'OK';
        SN_num_evento    := 0;
        ind_contratados  := 0;
        pos_inicial      := 0;--ocb12

        BEGIN

                sSql :='SELECT  a.valor_numerico  ';
                sSql :=sSql || ' FROM  ga_parametros_simples_vw a ';
                sSql :=sSql || ' WHERE a.nom_parametro = ' || CV_ss_opc_comerc_centr;
                sSql :=sSql || ' AND   a.cod_modulo    = ' || CV_mo_ga;
                sSql :=sSql || ' AND    a.cod_operadora = (SELECT b.valor_texto ';
                sSql :=sSql || ' FROM   ge_parametros_sistema_vw b ';
                sSql :=sSql || ' WHERE  b.nom_parametro =' || CV_op_local;
                sSql :=sSql || ' AND    b.cod_modulo =' || CV_mo_ge;

                SELECT a.valor_numerico
                INTO   LN_ss_opc_comerc_centr
                FROM   ga_parametros_simples_vw a
                WHERE  a.nom_parametro = CV_ss_opc_comerc_centr
                AND    a.cod_modulo    = CV_mo_ga
                AND    a.cod_operadora = (SELECT b.valor_texto
                                          FROM   ge_parametros_sistema_vw b
                                      WHERE  b.nom_parametro = CV_op_local
                                      AND    b.cod_modulo    = CV_mo_ge);

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                            LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No se encuentra valor asociado a parametro '|| CV_ss_opc_comerc_centr,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                SN_cod_retorno   := 4;
                                SV_mens_retorno  := 'No se encuentra valor asociado a parametro '|| CV_ss_opc_comerc_centr;
                                SN_num_evento    := 0;
                                RAISE FIN_EJECUCION;
        END;

/*--ocb12
        OPEN CURSOR_GRUPOS_WAP_MMS_ROA;
        LOOP
            FETCH CURSOR_GRUPOS_WAP_MMS_ROA INTO LN_grupo;
                        EXIT WHEN CURSOR_GRUPOS_WAP_MMS_ROA%NOTFOUND;

                        IF LV_grupos_wap_mms_roa IS NULL THEN
                            LV_grupos_wap_mms_roa := TO_CHAR(LN_grupo);
                        ELSE
                                LV_grupos_wap_mms_roa := LV_grupos_wap_mms_roa ||','|| TO_CHAR(LN_grupo);
                        END IF;

                END LOOP;
        CLOSE CURSOR_GRUPOS_WAP_MMS_ROA;


        IF LV_grupos_wap_mms_roa IS NULL THEN

            LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener Servicios Suplementarios.',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
            RAISE FIN_EJECUCION;

        END IF;

        BEGIN

                sSql :='SELECT TO_NUMBER(a.valor_texto)  ';
                sSql :=sSql || 'FROM  ga_parametros_simples_vw a ';
                sSql :=sSql || 'WHERE a.nom_parametro = ' || CV_grupo_sms_on_demand;
                sSql :=sSql || 'AND   a.cod_modulo    = ' || CV_mo_ga;
                sSql :=sSql || 'AND    a.cod_operadora = (SELECT b.valor_texto ';
                sSql :=sSql || 'FROM   ge_parametros_sistema_vw b ';
                sSql :=sSql || 'WHERE  b.nom_parametro =' || CV_op_local;
                sSql :=sSql || 'AND    b.cod_modulo =' || CV_mo_ge;

                SELECT TO_NUMBER(a.valor_texto)
                INTO   LN_grupo_sms
                FROM   ga_parametros_simples_vw a
                WHERE  a.nom_parametro = CV_grupo_sms_on_demand
                AND    a.cod_modulo    = CV_mo_ga
                AND    a.cod_operadora = (SELECT b.valor_texto
                                  FROM   ge_parametros_sistema_vw b
                                          WHERE  b.nom_parametro = CV_op_local
                                          AND    b.cod_modulo    = CV_mo_ge);

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
                LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No se encuentra valor asociado a parametro '|| CV_grupo_sms_on_demand,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'No se encuentra valor asociado a parametro '|| CV_grupo_sms_on_demand;
                SN_num_evento    := 0;
                RAISE FIN_EJECUCION;
        END;
*/--ocb12

        sSql :='PV_RECUPERA_DATOS_ABONADO_PR(' || EN_num_abonado || ',' || LV_tip_terminal || ',' ||LV_cod_tecnologia|| ', ';
        sSql := sSql || EV_cod_plan || ','|| LN_cod_central ||','|| LN_num_celular || ',' ||LN_cod_sistema || ',' ||SN_cod_retorno|| ', ';
        sSql := sSql || SV_mens_retorno || ',' || SN_num_evento|| ')';
        LV_cod_plan_tarif   :=EV_cod_plan;
        PV_RECUPERA_DATOS_ABONADO_PR(EN_num_abonado,LV_tip_terminal,LV_cod_tecnologia, LV_cod_plan_tarif,LN_cod_central,LN_num_celular,LN_cod_sistema,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF  SN_cod_retorno <> 0 THEN
        LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener Datos del Abonado',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'Error al obtener Datos del Abonado';
                SN_num_evento    := 0;
                RAISE FIN_EJECUCION;
        END IF;

        OPEN CURSOR_CONTRATADOS;
        LOOP
            FETCH CURSOR_CONTRATADOS INTO LV_codservicio,LN_codservsupl,LN_codnivel,LD_fecaltabd,LN_indcentral;
                        EXIT WHEN CURSOR_CONTRATADOS%NOTFOUND;

                        pos_inicial      := ind_contratados;--ocb12

                        sSql:='SELECT TO_NUMBER(a.tip_relacion)';
                        sSql:=sSql ||' FROM gad_servsup_plan a ';
                        sSql:=sSql ||' WHERE a.cod_producto = ' || CN_producto;
                        sSql:=sSql ||' AND   a.cod_servicio = ' || LV_codservicio;
                        sSql:=sSql ||' AND   a.cod_plantarif = ' || EV_cod_plan;
                        sSql:=sSql ||' AND ' || LD_fecaltabd || ' BETWEEN a.fec_desde AND a.fec_hasta';

                        BEGIN

                                SELECT  TO_NUMBER(a.tip_relacion)
                                INTO    LN_tiprelacion
                                FROM    gad_servsup_plan a
                                WHERE   a.cod_producto = CN_producto
                                AND     a.cod_servicio = LV_codservicio
                                AND     a.cod_plantarif = EV_cod_plan
                                AND     LD_fecaltabd BETWEEN a.fec_desde AND a.fec_hasta;

                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                        LN_tiprelacion :=0;
                        END;

                        IF LN_tiprelacion = CN_ss_default THEN
                            -- SERVICIO POR DEFAULT AL PLAN --
                                tab_contratados(ind_contratados).t_v_origen:=CV_def;
                                tab_contratados(ind_contratados).t_v_cod_servicio:=LV_codservicio;
                                tab_contratados(ind_contratados).t_v_cod_servsupl:=LN_codservsupl;
                                tab_contratados(ind_contratados).t_v_cod_nivel:=LN_codnivel;
                                tab_contratados(ind_contratados).t_v_cod_accion:=CV_d;

                                ind_contratados := ind_contratados + 1;

                        ELSIF LN_tiprelacion = CN_ss_opcional THEN
/*--ocb12
                                -- VEMOS SI EL SERVICIO ES ESPECIAL
                                LN_pos1:=NVL(INSTR(TO_CHAR(LN_codservsupl),LV_grupos_wap_mms_roa),0);

                                LV_cadenass:=LTRIM(TO_CHAR(LN_codservsupl,'00')) || LTRIM(TO_CHAR(LN_codnivel,'0000'));

                            LN_pos2:=NVL(INSTR(LV_cadenass,LV_servicios_interopco),0);

                                IF (LN_codservsupl = LN_grupo_sms) OR (LN_pos1<>0) OR (LN_pos2<>0) THEN
                                   -- SERVICIOS ESPECIALES --
*/--ocb12

                            -- SERVICIO OPCIONAL AL PLAN --
                                -- SE APLICA LA REGLA --
                                IF EV_indicador = CV_si THEN

                                   IF LN_ss_opc_comerc_centr = CN_opc_comerc_central1 THEN

                                   -- SOLO SERVICIOS CON MOVIMIENTO A CENTRALES --
                                          IF LN_indcentral = 1 THEN
                                             tab_contratados(ind_contratados).t_v_origen:=CV_opc;
                                             tab_contratados(ind_contratados).t_v_cod_servicio:=LV_codservicio;
                                             tab_contratados(ind_contratados).t_v_cod_servsupl:=LN_codservsupl;
                                             tab_contratados(ind_contratados).t_v_cod_nivel:=LN_codnivel;
                                             tab_contratados(ind_contratados).t_v_cod_accion:=CV_m;

                                             ind_contratados := ind_contratados + 1;

                                          ELSE

                                             --  los demás se marcan con acción Desactivar.
                                             tab_contratados(ind_contratados).t_v_origen:=CV_opc;
                                             tab_contratados(ind_contratados).t_v_cod_servicio:=LV_codservicio;
                                             tab_contratados(ind_contratados).t_v_cod_servsupl:=LN_codservsupl;
                                             tab_contratados(ind_contratados).t_v_cod_nivel:=LN_codnivel;
                                             tab_contratados(ind_contratados).t_v_cod_accion:=CV_d;

                                             ind_contratados := ind_contratados + 1;

                                          END IF;
                                   END IF;

                                   IF LN_ss_opc_comerc_centr = CN_opc_comerc_central2 THEN

                                   -- SOLO SERVICIOS SIN MOVIMIENTO A CENTRALES --
                                          IF LN_indcentral = 0 THEN

                                                        tab_contratados(ind_contratados).t_v_origen:=CV_opc;
                                                        tab_contratados(ind_contratados).t_v_cod_servicio:=LV_codservicio;
                                                        tab_contratados(ind_contratados).t_v_cod_servsupl:=LN_codservsupl;
                                                        tab_contratados(ind_contratados).t_v_cod_nivel:=LN_codnivel;
                                                        tab_contratados(ind_contratados).t_v_cod_accion:=CV_m;

                                                        ind_contratados := ind_contratados + 1;

                                          ELSE

                                                            --  los demás se marcan con acción Desactivar.
                                                                tab_contratados(ind_contratados).t_v_origen:=CV_opc;
                                                                tab_contratados(ind_contratados).t_v_cod_servicio:=LV_codservicio;
                                                                tab_contratados(ind_contratados).t_v_cod_servsupl:=LN_codservsupl;
                                                                tab_contratados(ind_contratados).t_v_cod_nivel:=LN_codnivel;
                                                                tab_contratados(ind_contratados).t_v_cod_accion:=CV_d;

                                                                ind_contratados := ind_contratados + 1;

                                           END IF;

                                   END IF;

                                   IF LN_ss_opc_comerc_centr = CN_opc_comerc_central3 THEN

                                                -- AMBOS --
                                                        tab_contratados(ind_contratados).t_v_origen:=CV_opc;
                                                        tab_contratados(ind_contratados).t_v_cod_servicio:=LV_codservicio;
                                                        tab_contratados(ind_contratados).t_v_cod_servsupl:=LN_codservsupl;
                                                        tab_contratados(ind_contratados).t_v_cod_nivel:=LN_codnivel;
                                                        tab_contratados(ind_contratados).t_v_cod_accion:=CV_m;

                                                        ind_contratados := ind_contratados + 1;

                                   END IF;

                                ELSE

                                                -- ingresó la opción de NO mantener los servicios opcionales
                                                tab_contratados(ind_contratados).t_v_origen:=CV_opc;
                                                tab_contratados(ind_contratados).t_v_cod_servicio:=LV_codservicio;
                                                tab_contratados(ind_contratados).t_v_cod_servsupl:=LN_codservsupl;
                                                tab_contratados(ind_contratados).t_v_cod_nivel:=LN_codnivel;
                                                tab_contratados(ind_contratados).t_v_cod_accion:=CV_d;

                                                ind_contratados := ind_contratados + 1;


                                END IF;
/*--ocb12
                                ELSE
                                        -- NO ES SERVICIO OPCIONAL ESPECIAL --
                                        tab_contratados(ind_contratados).t_v_origen:=CV_opc;
                                        tab_contratados(ind_contratados).t_v_cod_servicio:=LV_codservicio;
                                        tab_contratados(ind_contratados).t_v_cod_servsupl:=LN_codservsupl;
                                        tab_contratados(ind_contratados).t_v_cod_nivel:=LN_codnivel;
                                        tab_contratados(ind_contratados).t_v_cod_accion:=CV_m;

                                        ind_contratados := ind_contratados + 1;

                                END IF;
*/
            END IF;--ocb12

--   ELSE --ocb12
                                -- VALIDAMOS SI PERTENECE AL PERFIL DE CENTRALES --
                                sSql:='SELECT a.cod_tiplan';
                                sSql:=sSql ||' FROM ta_plantarif a ';
                                sSql:=sSql ||' WHERE a.cod_producto = ' || CN_producto;
                                sSql:=sSql ||' AND   a.cod_plantarif = ' || EV_cod_plan;

                                SELECT a.cod_tiplan
                                INTO   LV_codtiplan
                                FROM   ta_plantarif a
                                WHERE  a.cod_producto = CN_producto
                                AND    a.cod_plantarif = EV_cod_plan;

                                IF LV_codtiplan = CV_codtiplan2  THEN
                                   LV_actuacion := CV_alta_postpago;
                                ELSE
                                   LV_actuacion := CV_alta_hibrido;
                                END IF;

                                sSql:='SELECT c.cod_servicios';
                                sSql:=sSql ||' FROM ga_actabo a, ged_parametros b, icg_actuaciontercen c ';
                                sSql:=sSql ||' WHERE a.cod_actabo     = b.val_parametro';
                                sSql:=sSql ||' AND   a.cod_producto = ' || CN_producto;
                        sSql:=sSql ||' AND   b.nom_parametro = ' || LV_actuacion;
                                sSql:=sSql ||' AND   c.cod_actuacion = a.cod_actcen';
                                sSql:=sSql ||' AND   c.tip_terminal = ' || LV_tip_terminal;
                                sSql:=sSql ||' AND   c.tip_tecnologia = ' || LV_cod_tecnologia;
                                sSql:=sSql ||' AND   c.tip_tecnologia = a.cod_tecnologia';
                                sSql:=sSql ||' AND   c.cod_sistema = ' || LN_cod_sistema;
                                BEGIN

                                        SELECT c.cod_servicios
                                        INTO   LV_codservicios
                                        FROM   ga_actabo a, ged_parametros b, icg_actuaciontercen c
                                        WHERE  a.cod_actabo     = b.val_parametro
                                        AND    a.cod_producto   = CN_producto
                                        AND    b.nom_parametro  = LV_actuacion
                                        AND    c.cod_actuacion  = a.cod_actcen
                                        AND    c.tip_terminal   = LV_tip_terminal
                                        AND    c.tip_tecnologia = LV_cod_tecnologia
                                        AND    c.tip_tecnologia = a.cod_tecnologia
                                        AND    c.cod_sistema    = LN_cod_sistema;

                                        LV_cadenass := LTRIM(TO_CHAR(LN_codservsupl,'00')) || LTRIM(TO_CHAR(LN_codnivel,'0000'));
                    LN_pos:=NVL(INSTR(LV_codservicios,LV_cadenass),0);--ocb12

                                EXCEPTION
                                        WHEN NO_DATA_FOUND THEN
                                                LN_pos:=0;
                                END;

                                IF LN_pos <> 0 THEN
                    -- EXISTE SERVICIO --
                                      IF pos_inicial != ind_contratados THEN --ocb12
                                             ind_contratados := pos_inicial;
                                      END IF;

                                    -- EXISTE SERVICIO --
                                        tab_contratados(ind_contratados).t_v_origen:=CV_per;
                                        tab_contratados(ind_contratados).t_v_cod_servicio:=LV_codservicio;
                                        tab_contratados(ind_contratados).t_v_cod_servsupl:=LN_codservsupl;
                                        tab_contratados(ind_contratados).t_v_cod_nivel:=LN_codnivel;
                                        tab_contratados(ind_contratados).t_v_cod_accion:=CV_d;
                                        ind_contratados := ind_contratados + 1;
                                ELSE
     -- NO EXISTE SERVICIO EN EL PERFIL --
                 IF pos_inicial = ind_contratados THEN --ocb12
                                        tab_contratados(ind_contratados).t_v_origen:=CV_opc;
                                        tab_contratados(ind_contratados).t_v_cod_servicio:=LV_codservicio;
                                        tab_contratados(ind_contratados).t_v_cod_servsupl:=LN_codservsupl;
                                        tab_contratados(ind_contratados).t_v_cod_nivel:=LN_codnivel;
                                        tab_contratados(ind_contratados).t_v_cod_accion:=CV_m;

                                        ind_contratados := ind_contratados + 1;
                  END IF;

                                END IF;


  -- END IF;--ocb12

        END LOOP;
      CLOSE CURSOR_CONTRATADOS;

    FOR LN_fila IN 0..ind_contratados - 1 LOOP

            LV_ser_contr:=tab_contratados(LN_fila).t_v_cod_servicio;
                LN_ser_contr:=tab_contratados(LN_fila).t_v_cod_servsupl;
                LN_niv_contr:=tab_contratados(LN_fila).t_v_cod_nivel;
                LV_ori_contr:=tab_contratados(LN_fila).t_v_origen;
            LV_acc_contr:=tab_contratados(LN_fila).t_v_cod_accion;

                IF (LV_ori_contr = CV_opc) AND (LV_acc_contr=CV_a OR LV_acc_contr=CV_d OR LV_acc_contr=CV_m) THEN
                    --VEMOS SI EXISTE SS LIGADOS --
                        sSql :='PV_TRATAMIENTO_SS_PG.PV_CONSULTA_SS_LIGADOS_PR('|| EN_num_abonado || ',' || LV_ser_contr ||','|| LV_acc_contr ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
                        PV_TRATAMIENTO_SS_PG.PV_CONSULTA_SS_LIGADOS_PR(EN_num_abonado,LV_ser_contr,LV_acc_contr,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                        IF  SN_cod_retorno <> 0 THEN
                           LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener servicio suplementario ligado.',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                           SN_cod_retorno   := 4;
                           SV_mens_retorno  := 'Error al obtener servicio suplementario ligado.';
                           SN_num_evento    := 0;
                           RAISE FIN_EJECUCION;
                        END IF;

        END IF;

    END LOOP;

    dbms_output.PUT_LINE('TAB_CONTRATADOS ----------');
    FOR I IN 0..ind_contratados - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_contratados(I).t_v_origen||' | '||tab_contratados(I).t_v_cod_accion||' | '||tab_contratados(I).t_v_cod_servicio||' | '||tab_contratados(I).t_v_cod_servsupl||' | '||tab_contratados(I).t_v_cod_nivel||' | ');
    END LOOP;

EXCEPTION
    WHEN FIN_EJECUCION THEN
                 NULL;
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno  := 'No se encuentra datos';
                SN_num_evento    := 0;
  --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No existen datos.'  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.
        WHEN OTHERS THEN
                SN_cod_retorno   := 4;
                SV_mens_retorno:= CV_error_no_clasif;
                LV_des_error := 'PV_CARGA_SS_ACTUALES_PR (' || EN_num_abonado || ',' || EV_cod_plan || ',' || EV_indicador || ')';
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                'PV_TRATAMIENTO_SS_PG.PV_CARGA_SS_ACTUALES_PR', sSql, SQLCODE, LV_des_error );
  --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.

END PV_CARGA_SS_ACTUALES_PR;

PROCEDURE PV_CARGA_SS_PLAN_NUEVO_PR(EN_num_abonado            IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                    EV_cod_plantarif_origen   IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                    EV_cod_plan_destino       IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
--                                    EV_cod_plantarifnue       IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                    SN_cod_retorno            IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                    SV_mens_retorno           IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                    SN_num_evento             IN OUT NOCOPY GE_ERRORES_PG.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento;
      Nombre = "PV_CARGA_SS_PLAN_NUEVO_PR"
      Lenguaje="PL/SQL"
      Fecha="15-12-2006"
      Versión="1.0"
      Diseñador="Yury Andres Alvarez Tapia"
          Programador="Yury Andres Alvarez Tapia"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_num_abonado"          Tipo="NUMERICO">Número del Abonado</param>
                        <param nom="EV_cod_plantarif_origen" Tipo="CARACTER">Plan tarifario origen</param>
                        <param nom="EV_cod_plan_destino"     Tipo="CARACTER">Plan tarifario nuevo</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"          Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"         Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"           Tipo="NUMERICO">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

    LV_des_error         GE_ERRORES_PG.DesEvent;
    sSql                 GE_ERRORES_PG.vQuery;

    FIN_EJECUCION        EXCEPTION;

    LV_error                         VARCHAR2(5);

    LV_tip_terminal      GA_ABOCEL.TIP_TERMINAL%TYPE;
    LV_cod_tecnologia    GA_ABOCEL.COD_TECNOLOGIA%TYPE;
    LV_cod_plan_tarif    GA_ABOCEL.COD_PLANTARIF%TYPE;
    LN_cod_central       GA_ABOCEL.COD_CENTRAL%TYPE;
    LN_num_celular       GA_ABOCEL.NUM_CELULAR%TYPE;
    LN_cod_sistema       ICG_CENTRAL.COD_SISTEMA%TYPE;

    LV_cod_servicio      GA_SERVSUPL.COD_SERVICIO%TYPE;
    LN_cod_servsupl      GA_SERVSUPL.COD_SERVSUPL%TYPE;
    LN_cod_nivel         GA_SERVSUPL.COD_NIVEL%TYPE;
    LV_tip_relacion      GAD_SERVSUP_PLAN.TIP_RELACION%TYPE;

    LV_ser_nuevo             GA_SERVSUPL.COD_SERVICIO%TYPE;
    LN_servsupl_nuevo        GA_SERVSUPL.COD_SERVSUPL%TYPE;--ocb12
    LN_niv_nuevo             GA_SERVSUPL.COD_NIVEL%TYPE;
    LV_ori_nuevo             VARCHAR2(3);
    LV_acc_nuevo             VARCHAR2(1);

    LV_ser_nuevo2            GA_SERVSUPL.COD_SERVICIO%TYPE;
    LN_servsupl_nuevo2        GA_SERVSUPL.COD_SERVSUPL%TYPE; --ocb12
    LN_niv_nuevo2            GA_SERVSUPL.COD_NIVEL%TYPE;

    LV_cod_servdef           GA_SERVSUPL.COD_SERVICIO%TYPE;
    LV_servicio_buscar       GA_SERVSUPL.COD_SERVICIO%TYPE;

    LN_ind_nuevo2            BINARY_INTEGER;
    LN_i                     INTEGER;
    LN_j                     INTEGER;
	LN_fila1                 NUMBER;
    LB_existe                BOOLEAN;

    LV_cambio_producto       VARCHAR2(5);

    LV_cod_servicio_contratado     ga_servsupl.cod_servicio%TYPE;

    CURSOR  CARGA_SS_NUEVOS  IS
    SELECT A.cod_servicio
         , A.cod_servsupl
             , A.cod_nivel
             , C.tip_relacion
    FROM   ga_servsupl A, icg_serviciotercen B, gad_servsup_plan C
    WHERE  C.cod_producto   = CN_producto
    AND    B.cod_producto   = CN_producto
    AND    B.tip_terminal   = LV_tip_terminal
    AND    B.cod_sistema    = LN_cod_sistema
    AND    B.cod_servicio   = A.cod_servsupl
    AND    B.tip_tecnologia = LV_cod_tecnologia
    AND    A.cod_servicio   = C.cod_servicio
    AND    A.cod_producto   = C.cod_producto
    AND    C.cod_plantarif  = EV_cod_plan_destino --plan nuevo .
    AND    C.tip_relacion  IN (CN_ss_opcional, CN_ss_default)
    AND    SYSDATE    BETWEEN C.fec_desde AND C.fec_hasta ;

    CURSOR  CARGA_SS_LIGADOS  IS
    SELECT a.cod_servdef, b.cod_servsupl, b.cod_nivel
    FROM   ga_servsup_def a, ga_servsupl b, icg_serviciotercen c
    WHERE  a.cod_producto  = CN_producto
    AND    a.cod_servicio  = LV_servicio_buscar
    AND    a.tip_relacion  = CN_relacion1
    AND    SYSDATE   BETWEEN a.fec_desde AND nvl(a.fec_hasta, SYSDATE)
--     AND    a.cod_producto  = b.cod_producto
--     AND    a.cod_servdef   = b.cod_servicio
--     AND    a.cod_producto  = c.cod_producto
--     AND    a.cod_servdef   = c.cod_servicio
    AND    b.cod_producto  = a.cod_producto
    AND    b.cod_servicio  = a.cod_servdef
    AND    c.cod_producto  = b.cod_producto
    AND    c.cod_servicio  = b.cod_servsupl
    AND    c.cod_sistema   = LN_cod_sistema
    AND    c.tip_terminal  = LV_tip_terminal
    AND    c.tip_tecnologia = LV_cod_tecnologia;


BEGIN

    IF SN_cod_retorno <> 0 THEN
       RAISE FIN_EJECUCION;
    END IF;

    SN_cod_retorno   := 0;
    SV_mens_retorno  := 'OK';
    SN_num_evento    := 0;
    ind_nuevo        := 0;


    sSql :='PV_existe_cambio_producto_FN('|| EN_num_abonado ||','|| EV_cod_plantarif_origen  ||','|| EV_cod_plan_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
    LV_cambio_producto := PV_TRATAMIENTO_SS_PG.PV_EXISTE_CAMBIO_PRODUCTO_FN(EN_num_abonado,EV_cod_plantarif_origen ,EV_cod_plan_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener cambio de producto',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error al obtener cambio de producto';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;

    sSql :='PV_RECUPERA_DATOS_ABONADO_PR('||EN_num_abonado||','||LV_tip_terminal||','||LV_cod_tecnologia||', ';
    sSql := sSql||LV_cod_plan_tarif||','||LN_cod_central||','||LN_num_celular||','||LN_cod_sistema||','||SN_cod_retorno||', ';
    sSql := sSql||SV_mens_retorno||','||SN_num_evento||')';

    LV_cod_plan_tarif:=EV_cod_plan_destino;
    PV_RECUPERA_DATOS_ABONADO_PR(EN_num_abonado,LV_tip_terminal,LV_cod_tecnologia,LV_cod_plan_tarif,LN_cod_central,LN_num_celular,LN_cod_sistema,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener Datos del Abonado',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error al obtener Datos del Abonado';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;

    sSql :='SELECT A.cod_servicio, A.cod_servsupl, A.cod_nivel, C.tip_relacion ';
    sSql :=sSql || 'FROM  ga_servsupl A, icg_serviciotercen B, gad_servsup_plan C ';
    sSql :=sSql || 'WHERE C.cod_producto   = '||CN_PRODUCTO;
    sSql :=sSql || 'AND   B.cod_producto   = '||CN_PRODUCTO;
    sSql :=sSql || 'AND   B.tip_terminal   = '||LV_tip_terminal;
    sSql :=sSql || 'AND   B.cod_sistema    = '||LN_cod_sistema;
    sSql :=sSql || 'AND   B.cod_servicio   = A.cod_servsupl ';
    sSql :=sSql || 'AND   B.tip_tecnologia = '||LV_cod_tecnologia;
    sSql :=sSql || 'AND   A.cod_servicio   = C.cod_servicio ';
    sSql :=sSql || 'AND   A.cod_producto   = C.cod_producto ';
    sSql :=sSql || 'AND   C.cod_plantarif  = '||EV_cod_plan_destino;
    sSql :=sSql || 'AND   C.tip_relacion IN ('||CN_ss_opcional||','||CN_ss_default||')';
    sSql :=sSql || 'AND   SYSDATE BETWEEN C.fec_desde AND C.fec_hasta' ;


    OPEN CARGA_SS_NUEVOS ;
    LOOP
        FETCH CARGA_SS_NUEVOS INTO LV_cod_servicio, LN_cod_servsupl, LN_cod_nivel, LV_tip_relacion;
              EXIT WHEN CARGA_SS_NUEVOS%NOTFOUND;

        IF  LV_tip_relacion = CN_ss_default THEN
            tab_nuevo(ind_nuevo).t_v_origen       := CV_def;
            tab_nuevo(ind_nuevo).t_v_cod_servicio := LV_cod_servicio ;
            tab_nuevo(ind_nuevo).t_v_cod_servsupl := LN_cod_servsupl;
            tab_nuevo(ind_nuevo).t_v_cod_nivel    := LN_cod_nivel;
            tab_nuevo(ind_nuevo).t_v_cod_accion   := CV_a;

        ELSIF LV_tip_relacion = CN_ss_opcional THEN

              IF GV_ind_trasp_opc = CV_si THEN
                --Buscarmos si existe el SS opcional entre los contratados marcado
                --como mantener

                 LN_fila1  := 0;
                 LB_existe := FALSE;

                 FOR LN_i IN 0..ind_contratados - 1 LOOP
                     IF tab_contratados(LN_i).t_v_cod_accion = CV_m AND tab_contratados(LN_i).t_v_origen = CV_opc AND tab_contratados(LN_i).t_v_cod_servicio = LV_cod_servicio THEN
                        LN_fila1  := LN_i;
                        LB_existe := TRUE;
                     END IF;
--                      IF tab_contratados(LN_i).t_v_origen in ( CV_def ,CV_per)  AND tab_contratados(LN_i).t_v_cod_servicio = LV_cod_servicio THEN
--                         tab_contratados(LN_i).t_v_cod_accion := CV_m;
--                         LB_existe:=TRUE;
--                      END IF;
                 END LOOP;

                 tab_nuevo(ind_nuevo).t_v_origen       := CV_opc;
                 tab_nuevo(ind_nuevo).t_v_cod_servicio := LV_cod_servicio;
                 tab_nuevo(ind_nuevo).t_v_cod_servsupl := LN_cod_servsupl;
                 tab_nuevo(ind_nuevo).t_v_cod_nivel    := LN_cod_nivel;

                 IF LB_existe AND LV_cambio_producto = 'TRUE' THEN
                    tab_contratados(LN_fila1).t_v_cod_accion := CV_d;
                    tab_nuevo(ind_nuevo).t_v_cod_accion  := CV_a;
                 ELSE
                    tab_nuevo(ind_nuevo).t_v_cod_accion  := CV_n;
                 END IF;
              ELSE
                  tab_nuevo(ind_nuevo).t_v_origen       := CV_opc;
                  tab_nuevo(ind_nuevo).t_v_cod_servicio := LV_cod_servicio ;
                  tab_nuevo(ind_nuevo).t_v_cod_servsupl := LN_cod_servsupl;
                  tab_nuevo(ind_nuevo).t_v_cod_nivel    := LN_cod_nivel;
                  tab_nuevo(ind_nuevo).t_v_cod_accion   := CV_n;
              END IF;
        END IF; --ocb12

       ind_nuevo := ind_nuevo + 1;

    END LOOP;
    CLOSE CARGA_SS_NUEVOS;

    LN_ind_nuevo2:=ind_nuevo; -- asigno --

    FOR LN_fila1 IN 0..ind_nuevo - 1 LOOP

        LV_ser_nuevo:=tab_nuevo(LN_fila1).t_v_cod_servicio;
--      LN_ser_nuevo:=tab_nuevo(LN_fila1).t_v_cod_servsupl; --ocb12
        LN_servsupl_nuevo:=tab_nuevo(LN_fila1).t_v_cod_servsupl;
        LN_niv_nuevo:=tab_nuevo(LN_fila1).t_v_cod_nivel;
        LV_ori_nuevo:=tab_nuevo(LN_fila1).t_v_origen;
        LV_acc_nuevo:=tab_nuevo(LN_fila1).t_v_cod_accion;

        IF LV_ori_nuevo = CV_def THEN

           LV_servicio_buscar:=LV_ser_nuevo;

           -- VERIFICA SI SS DEFAULT TIENE SS LIGADOS
           OPEN CARGA_SS_LIGADOS ;
           LOOP
               FETCH CARGA_SS_LIGADOS INTO LV_cod_servdef, LN_cod_servsupl, LN_cod_nivel;
                     EXIT WHEN CARGA_SS_LIGADOS%NOTFOUND;
dbms_output.PUT_LINE(' ---- TAB_NUEVO (LV_cod_servdef)----------: '||LV_cod_servdef);
dbms_output.PUT_LINE(' ---- TAB_NUEVO (LN_cod_servsupl)---------: '||LN_cod_servsupl);
dbms_output.PUT_LINE(' ---- TAB_NUEVO (LN_cod_nivel)------------: '||LN_cod_nivel);
               tab_nuevo(LN_ind_nuevo2).t_v_origen       := CV_def;
               tab_nuevo(LN_ind_nuevo2).t_v_cod_servicio := LV_cod_servdef;
               tab_nuevo(LN_ind_nuevo2).t_v_cod_servsupl := LN_cod_servsupl;
               tab_nuevo(LN_ind_nuevo2).t_v_cod_nivel    := LN_cod_nivel;
               tab_nuevo(LN_ind_nuevo2).t_v_cod_accion   := CV_a;

               LN_ind_nuevo2 := LN_ind_nuevo2 + 1;

           END LOOP;
           CLOSE CARGA_SS_LIGADOS;

        END IF;

    END LOOP;

    ind_nuevo:=LN_ind_nuevo2; -- reasigno --

    dbms_output.PUT_LINE('TAB_NUEVO ----------');
    FOR I IN 0..ind_nuevo - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_nuevo(I).t_v_origen||' | '||tab_nuevo(I).t_v_cod_accion||' | '||tab_nuevo(I).t_v_cod_servicio||' | '||tab_nuevo(I).t_v_cod_servsupl||' | '||tab_nuevo(I).t_v_cod_nivel||' | ');
    END LOOP;

EXCEPTION
    WHEN FIN_EJECUCION THEN
         NULL;
    WHEN NO_DATA_FOUND THEN
         SN_cod_retorno   := 4;
         SV_mens_retorno  := 'No se encuentra datos';
         SN_num_evento    := 0;
         LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No existen datos.'  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    WHEN OTHERS THEN
          SN_cod_retorno   := 4;
          SV_mens_retorno  := CV_error_no_clasif;
          LV_des_error     := 'PV_CARGA_SS_PLAN_NUEVO_PR (' || EN_num_abonado || ',' || EV_cod_plantarif_origen || ',' || EV_cod_plan_destino || ')';
          SN_num_evento    := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
          'PV_TRATAMIENTO_SS_PG.PV_CARGA_SS_PLAN_NUEVO_PR', sSql, SQLCODE, LV_des_error );
         LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

END PV_CARGA_SS_PLAN_NUEVO_PR;

PROCEDURE PV_RECUPERA_DATOS_ABONADO_PR(EN_num_abonado      IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                       SV_tip_terminal     IN OUT GA_ABOCEL.TIP_TERMINAL%TYPE,
                                       SV_cod_tecnologia   IN OUT GA_ABOCEL.COD_TECNOLOGIA%TYPE,
                                       SV_cod_plan_tarif   IN OUT GA_ABOCEL.COD_PLANTARIF%TYPE,
                                       SN_cod_central      IN OUT GA_ABOCEL.COD_CENTRAL%TYPE,
                                       SN_num_celular      IN OUT GA_ABOCEL.NUM_CELULAR%TYPE,
                                       SN_cod_sistema      IN OUT ICG_CENTRAL.COD_SISTEMA%TYPE,
                                       SN_cod_retorno      IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                       SV_mens_retorno     IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                       SN_num_evento       IN OUT NOCOPY GE_ERRORES_PG.Evento
)
/*
<Documentación.
  TipoDoc = "Procedimiento">
   <Elemento;
      Nombre = "PV_RECUPERA_DATOS_ABONADO_PR"
      Lenguaje="PL/SQL"
      Fecha="15-12-2006"
      Versión="1.0"
      Diseñador="Yury Andres Alvarez Tapia"
          Programador="Yury Andres Alvarez Tapia"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_num_abonado"         Tipo="NUMERICO">Número del Abonado</param>
         </Entrada>
         <Salida>
                <param nom="SV_tip_terminal"        Tipo="CARACTER">Tipo de terminal</param>
            <param nom="SV_cod_tecnologia"      Tipo="CARACTER">Tecnologia del Abonado</param>
            <param nom="SV_cod_plan_tarif"      Tipo="CARACTER">Codigo del plan tarifario</param>
            <param nom="SN_cod_central"         Tipo="NUMERICO">Codigo de central</param>
            <param nom="SN_num_celular"         Tipo="NUMERICO">Celular del Abonado</param>
            <param nom="SN_cod_sistema"         Tipo="NUMERICO">Codigo del Sistema</param>
            <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"          Tipo="NUMERICO">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

    LV_error                     VARCHAR2(5);

        FIN_EJECUCION        EXCEPTION;

    LV_des_error         GE_ERRORES_PG.DesEvent;
        sSql                 GE_ERRORES_PG.vQuery;

        BEGIN

        IF SN_cod_retorno <> 0 THEN
           RAISE FIN_EJECUCION;
        END IF;

        SN_cod_retorno   := 0;
        SV_mens_retorno  := 'OK';
        SN_num_evento    := 0;

                         sSql :='SELECT A.tip_terminal,A.cod_tecnologia,A.cod_plantarif,A.cod_central,A.num_celular ';
                         sSql :=sSql || 'INTO  SV_tip_terminal,SV_cod_tecnologia,SV_cod_plan_tarif,SN_cod_central,SN_num_celular ';
                     sSql :=sSql || 'FROM  ga_abocel A ';
                     sSql :=sSql || 'WHERE A.num_abonado  = '||EN_num_abonado;

                     SELECT A.tip_terminal,A.cod_tecnologia,A.cod_plantarif,A.cod_central,A.num_celular
                         INTO   SV_tip_terminal,SV_cod_tecnologia,SV_cod_plan_tarif,SN_cod_central,SN_num_celular
                     FROM   ga_abocel A
                     WHERE  A.num_abonado = EN_num_abonado
                         UNION
                     SELECT A.tip_terminal,A.cod_tecnologia,A.cod_plantarif,A.cod_central,A.num_celular
                     FROM   ga_aboamist A
                     WHERE  A.num_abonado = EN_num_abonado;


                         sSql :='SELECT A.cod_sistema INTO  LN_cod_sistema';
                     sSql :=sSql || ' FROM  icg_central A ';
                     sSql :=sSql || ' WHERE A.cod_central = '||SN_cod_central;
                     sSql :=sSql || ' AND   A.cod_producto = '||CN_producto;


                         SELECT A.cod_sistema
                         INTO   SN_cod_sistema
                         FROM   icg_central A
                         WHERE  A.cod_central  =  SN_cod_central
                         AND    A.cod_producto =  CN_producto;

        EXCEPTION

        WHEN FIN_EJECUCION THEN
                    NULL;
                WHEN NO_DATA_FOUND THEN
                    LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Problemas al Consultar Datos del Abonado',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        SN_cod_retorno   := 4;
                        SV_mens_retorno  := 'Problemas al Consultar Datos del Abonado';
                        SN_num_evento    := 0;
     --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'No existen datos.'  ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.

                WHEN OTHERS THEN
                    SN_cod_retorno   := 4;
                        SV_mens_retorno:= CV_error_no_clasif;
                        LV_des_error := 'PV_RECUPERA_DATOS_ABONADO_PR (' || EN_num_abonado  || ')';
                        SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                        'PV_TRATAMIENTO_SS_PG.PV_RECUPERA_DATOS_ABONADO_PR', sSql, SQLCODE, LV_des_error );

  --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.

END PV_RECUPERA_DATOS_ABONADO_PR;

FUNCTION PV_EXISTE_CAMBIO_PRODUCTO_FN (EN_num_abonado           IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                       EV_cod_plantarif_origen  IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                       EV_cod_plantarif_destino IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                       SN_cod_retorno           IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                       SV_mens_retorno          IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                       SN_num_evento            IN OUT NOCOPY GE_ERRORES_PG.Evento) RETURN STRING
/*
<Documentación>
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "PV_EXISTE_CAMBIO_PRODUCTO_FN"
                Lenguaje="PL/SQL"
                Fecha creación="15-12-2006"
                Creado por="Yury Alvarez Tapia."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener si existe cambio de producto</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_abonado"           Tipo="NUMBER">Numero de Abonado/param>
                                <param nom="EV_cod_plantarif_origen"  Tipo="VARCHAR">Codigo de plan tarifario origen/param>
                                <param nom="EV_cod_plantarif_destino" Tipo="VARCHAR">codigo de plan tarifario destino/param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS

    LV_error                  VARCHAR2(5);

    LV_des_error              GE_ERRORES_PG.DesEvent;
    sSql                      GE_ERRORES_PG.vQuery;

    LN_cantidad               NUMBER;
    LV_abonado_atlantida      VARCHAR2(5);  --Respuesta si es abonado atlantida.
    LV_plantarif_atlantida    VARCHAR2(5);  --respuesta si es el plan atlantida.

    LV_cod_tipo_plan_origen   TA_PLANTARIF.COD_TIPLAN%TYPE; --Respuesta de código de tipo de plan origen.
    LV_cod_tipo_plan_destino  TA_PLANTARIF.COD_TIPLAN%TYPE; --Respuesta de código de tipo de plan destino.
    LV_des_tip_plan           VARCHAR2(3);

    FIN_EJECUCION             EXCEPTION;

BEGIN

    IF SN_cod_retorno <> 0 THEN
       RAISE FIN_EJECUCION;
    END IF;

    SN_cod_retorno   := 0;
    SV_mens_retorno  := 'OK';
    SN_num_evento    := 0;
--- LLamada a función para obtener plan atlantida ----
    sSql :='PV_PLAN_DESTINO_ATLANTIDA_FN('|| EV_cod_plantarif_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
    LV_plantarif_atlantida := PV_TRATAMIENTO_SS_PG.PV_PLAN_DESTINO_ATLANTIDA_FN(EV_cod_plantarif_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener plan atlantida',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error para obtener plan atlantida';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;

--- LLamada al package para obtener abonado atlantida ----
    sSql :='pv_obtieneinfo_atlantida_pg.pv_existeaboatlantida2_pr('|| EN_num_abonado ||','|| LV_Abonado_Atlantida ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
    pv_obtieneinfo_atlantida_pg.pv_existeaboatlantida2_pr(EN_num_abonado,LV_Abonado_Atlantida,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener abonado atlantida',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error para obtener abonado atlantida';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;

--     IF LV_plantarif_atlantida = 'TRUE' AND LV_Abonado_Atlantida = 'TRUE' THEN
--        RETURN 'FALSE';
--     END IF ;

--    IF LV_plantarif_atlantida = 'FALSE' AND LV_Abonado_Atlantida = 'FALSE' THEN
       --- LLamada al procedimiento para obtener código de tipo de plan origen ----
       sSql :='PV_COD_TIPO_PLAN_TARIFARIO_PR('|| EV_cod_plantarif_origen ||','|| LV_cod_tipo_plan_origen ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
       PV_TRATAMIENTO_SS_PG.PV_COD_TIPO_PLAN_TARIFARIO_PR(EV_cod_plantarif_origen,LV_cod_tipo_plan_origen,LV_des_tip_plan,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

       IF SN_cod_retorno <> 0 THEN
          LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener código de tipo de plan origen',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
          SN_cod_retorno   := 4;
          SV_mens_retorno  := 'Error para obtener código de tipo de plan origen';
          SN_num_evento    := 0;
          RAISE FIN_EJECUCION;
       END IF;

       --- LLamada al procedimiento para obtener código de tipo de plan destino ----
       sSql :='PV_COD_TIPO_PLAN_TARIFARIO_PR('|| EV_cod_plantarif_destino ||','|| LV_cod_tipo_plan_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
       PV_TRATAMIENTO_SS_PG.PV_COD_TIPO_PLAN_TARIFARIO_PR(EV_cod_plantarif_destino,LV_cod_tipo_plan_destino,LV_des_tip_plan,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

       IF  SN_cod_retorno <> 0 THEN
           LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener código de tipo de plan destino',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
           SN_cod_retorno   := 4;
           SV_mens_retorno  := 'Error para obtener código de tipo de plan destino';
           SN_num_evento    := 0;
           RAISE FIN_EJECUCION;
       END IF;

       IF LV_cod_tipo_plan_origen = LV_cod_tipo_plan_destino THEN
          RETURN 'FALSE';
       ELSE
          RETURN 'TRUE';
       END IF;
--     END IF;
--
--     RETURN 'TRUE';

EXCEPTION
    WHEN FIN_EJECUCION THEN
         NULL;
    WHEN NO_DATA_FOUND THEN
         SN_cod_retorno   := 4;
         SV_mens_retorno  := 'No se encuentra datos';
         SN_num_evento    := 0;
         RETURN 'FALSE';
    WHEN OTHERS THEN
         SN_cod_retorno   := 4;
         SV_mens_retorno  := CV_error_no_clasif;
         LV_des_error     := 'PV_EXISTE_CAMBIO_PRODUCTO_FN (' || EN_num_abonado || ',' || EV_cod_plantarif_origen || ',' || EV_cod_plantarif_destino ||')';
         SN_num_evento    := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
         'PV_TRATAMIENTO_SS_PG.PV_EXISTE_CAMBIO_PRODUCTO_FN', sSql, SQLCODE, LV_des_error );
         RETURN 'FALSE';
END;

FUNCTION PV_PLAN_DESTINO_ATLANTIDA_FN (EV_cod_plan_destino IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                       SN_cod_retorno      IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                       SV_mens_retorno     IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                       SN_num_evento       IN OUT NOCOPY GE_ERRORES_PG.Evento) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "PV_plan_destino_es_atlantida_FN"
                Lenguaje="PL/SQL"
                Fecha creación="15-12-2006"
                Creado por="Yury Alvarez Tapia."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener si el plan destino es atlantida</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EV_cod_plantarifnue" Tipo="VARCHAR">Codigo de plan tarifario nuevo</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS


    FIN_EJECUCION        EXCEPTION;
        LV_des_error         GE_ERRORES_PG.DesEvent;
        sSql                 GE_ERRORES_PG.vQuery;
        LN_cantidad          NUMBER;
        LV_resp              VARCHAR2(5);

BEGIN

        IF SN_cod_retorno <> 0 THEN
           RAISE FIN_EJECUCION;
        END IF;

        SN_cod_retorno   := 0;
        SV_mens_retorno  := 'OK';
        SN_num_evento    := 0;

         sSql :='SELECT COUNT(1)  ';
         sSql :=sSql || 'LN_cantidad ';
     sSql :=sSql || 'FROM  gad_servsup_plan A, ged_codigos B ';
         sSql :=sSql || 'WHERE B.cod_valor     = A.cod_servicio ';
     sSql :=sSql || 'A.cod_plantarif  = '||EV_cod_plan_destino;
     sSql :=sSql || 'B.cod_modulo     = '||CV_mo_ga;
     sSql :=sSql || ' A.nom_tabla     = '||CV_tabla;
     sSql :=sSql || ' B.nom_columna   = '||CV_columna;

         SELECT COUNT(1)
         INTO   LN_cantidad
         FROM   gad_servsup_plan A
              , ged_codigos B
         WHERE  B.cod_valor     = A.cod_servicio
         AND    A.cod_plantarif = EV_cod_plan_destino
         AND    B.cod_modulo    = CV_mo_ga
         AND    B.nom_tabla     = CV_tabla
         AND    B.nom_columna   = CV_columna;

         IF LN_cantidad > 0 THEN
                RETURN 'TRUE';
         ELSE
                RETURN 'FALSE';
         END IF;


EXCEPTION
        WHEN FIN_EJECUCION THEN
                        NULL;
        WHEN NO_DATA_FOUND THEN
                        SN_cod_retorno   := 4;
                        SV_mens_retorno  := 'No se encuentra datos';
                        SN_num_evento    := 0;
        WHEN OTHERS THEN
                    SN_cod_retorno   := 4;
                        SV_mens_retorno  := CV_error_no_clasif;
                        LV_des_error     := 'PV_PLAN_DESTINO_ATLANTIDA_FN (' || EV_cod_plan_destino || ')';
                        SN_num_evento    := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                        'PV_TRATAMIENTO_SS_PG.PV_PLAN_DESTINO_ATLANTIDA_FN', sSql, SQLCODE, LV_des_error );

END;

PROCEDURE PV_CONSULTA_SS_LIGADOS_PR (EN_num_abonado      IN     GA_ABOCEL.NUM_ABONADO%TYPE,
                                     EV_cod_servicio     IN     GA_SERVSUPL.COD_SERVICIO%TYPE,
                                     EV_cod_accion       IN     VARCHAR2,
                                     SN_cod_retorno      IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                     SV_mens_retorno     IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                     SN_num_evento       IN OUT NOCOPY GE_ERRORES_PG.Evento)
/*
<Documentación
        TipoDoc = "PROCEDIMIENTO>
        <Elemento
                Nombre = "PV_CONSULTA_SS_LIGADOS_PR"
                Lenguaje="PL/SQL"
                Fecha creación="15-12-2006"
                Creado por="Manuel Acevedo."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener si el servicio posee servicios ligados</Descripción>
                <Parámetros>
                        <Entrada>
                                                        <param nom="EN_num_abonado" Tipo="VARCHAR">Numero de Abonado</param>
                                <param nom="EV_cod_servicio" Tipo="VARCHAR">Codigo de servicio</param>
                                                                <param nom="EV_cod_accion" Tipo="VARCHAR">Accion que posee/param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS


    FIN_EJECUCION        EXCEPTION;
    LV_error             VARCHAR2(5);
    LV_des_error         GE_ERRORES_PG.DesEvent;
    sSql                 GE_ERRORES_PG.vQuery;

    LN_fila              NUMBER;
    LV_ser_contr         GA_SERVSUPL.COD_SERVICIO%TYPE;
    LN_ser_contr         GA_SERVSUPL.COD_SERVSUPL%TYPE;
    LN_niv_contr         GA_SERVSUPL.COD_NIVEL%TYPE;

    LV_tip_terminal      GA_ABOCEL.TIP_TERMINAL%TYPE;
    LV_cod_tecnologia    GA_ABOCEL.COD_TECNOLOGIA%TYPE;
    LV_cod_plan_tarif    GA_ABOCEL.COD_PLANTARIF%TYPE;
    LN_cod_central       GA_ABOCEL.COD_CENTRAL%TYPE;
    LN_num_celular       GA_ABOCEL.NUM_CELULAR%TYPE;
    LN_cod_sistema       ICG_CENTRAL.COD_SISTEMA%TYPE;

    LV_cod_servdef       GA_SERVSUPL.COD_SERVICIO%TYPE;
    LN_cod_servsupl      GA_SERVSUPL.COD_SERVSUPL%TYPE;
    LN_cod_nivel         GA_SERVSUPL.COD_NIVEL%TYPE;

    CURSOR  CARGA_SS_LIGADOS  IS
    SELECT  a.cod_servdef, b.cod_servsupl, b.cod_nivel
    FROM    ga_servsup_def a, ga_servsupl b, icg_serviciotercen c
    WHERE   a.cod_producto   = CN_producto
    AND     a.cod_servicio   = EV_cod_servicio
    AND     a.tip_relacion   = CN_relacion1
    AND     SYSDATE    BETWEEN a.fec_desde AND nvl(a.fec_hasta, SYSDATE)
--     AND     a.cod_producto   = b.cod_producto
--     AND     a.cod_servdef    = b.cod_servicio
--     AND     a.cod_producto   = c.cod_producto
--     AND     a.cod_servdef    = c.cod_servicio
    AND     b.cod_producto   = a.cod_producto
    AND     b.cod_servicio   = a.cod_servdef
    AND     c.cod_producto   = b.cod_producto
    AND     c.cod_servicio   = b.cod_servsupl
    AND     c.cod_sistema    = LN_cod_sistema
    AND     c.tip_terminal   = LV_tip_terminal
    AND     c.tip_tecnologia = LV_cod_tecnologia;

BEGIN

    IF SN_cod_retorno <> 0 THEN
      RAISE FIN_EJECUCION;
    END IF;

    SN_cod_retorno   := 0;
    SV_mens_retorno  := 'OK';
    SN_num_evento    := 0;

    PV_RECUPERA_DATOS_ABONADO_PR(EN_num_abonado,LV_tip_terminal,LV_cod_tecnologia,LV_cod_plan_tarif,LN_cod_central,LN_num_celular,LN_cod_sistema,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener Datos del Abonado',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error al obtener Datos del Abonado';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;

    sSql :='SELECT a.cod_servdef, b.cod_servsupl, b.cod_nivel ';
    sSql :=sSql || 'FROM  ga_servsup_def a, ga_servsupl b, icg_serviciotercen c ';
    sSql :=sSql || 'WHERE b.cod_producto   = ' || CN_producto ;
    sSql :=sSql || 'AND   a.cod_servicio   = ' || EV_cod_servicio ;
    sSql :=sSql || 'AND   SYSDATE    BETWEEN a.fec_desde AND a.fec_hasta ' ;
    sSql :=sSql || 'AND   a.cod_producto   = b.cod_producto ';
    sSql :=sSql || 'AND   a.cod_producto   = c.cod_producto ';
    sSql :=sSql || 'AND   a.cod_servdef    = b.cod_servicio';
    sSql :=sSql || 'AND   a.cod_servdef    = c.cod_servicio';
    sSql :=sSql || 'AND   a.tip_relacion   = ' || CN_relacion1;
    sSql :=sSql || 'AND   c.cod_sistema    = ' || LN_cod_sistema;
    sSql :=sSql || 'AND   c.tip_terminal   = ' || LV_tip_terminal;
    sSql :=sSql || 'AND   c.tip_tecnologia = ' || LV_cod_tecnologia;

    OPEN CARGA_SS_LIGADOS ;
    LOOP
       FETCH CARGA_SS_LIGADOS INTO LV_cod_servdef, LN_cod_servsupl, LN_cod_nivel;
             EXIT WHEN CARGA_SS_LIGADOS%NOTFOUND;

       -- ENCONTRO LIGADO, LO BUSCA EN MATRIZ CONTRATADOS PARA DESACTIVAR
       FOR LN_fila IN 0..ind_contratados - 1 LOOP

           LV_ser_contr:=tab_contratados(LN_fila).t_v_cod_servicio;
           LN_ser_contr:=tab_contratados(LN_fila).t_v_cod_servsupl;
           LN_niv_contr:=tab_contratados(LN_fila).t_v_cod_nivel;

dbms_output.PUT_LINE(' ---- TAB_CONTRATADOS(LV_cod_servdef)----------: '||LV_cod_servdef);
dbms_output.PUT_LINE(' ---- TAB_CONTRATADOS(LN_cod_servsupl)---------: '||LN_cod_servsupl);
dbms_output.PUT_LINE(' ---- TAB_CONTRATADOS(LN_cod_nivel)------------: '||LN_cod_nivel);

           -- PAREAR LOS TRES CAMPOS
           -- BUSCA SS LIGADO en la matriz CONTRATADOS --
           IF (LV_ser_contr = LV_cod_servdef) AND (LN_ser_contr = LN_cod_servsupl) AND (LN_niv_contr = LN_cod_nivel) THEN

              tab_contratados(LN_fila).t_v_cod_accion := EV_cod_accion;
dbms_output.PUT_LINE(' ---- TAB_CONTRATADOS(EV_cod_accion)-----------: '||EV_cod_accion);

           END IF;

       END LOOP;

     END LOOP;
     CLOSE CARGA_SS_LIGADOS;


EXCEPTION
        WHEN FIN_EJECUCION THEN
                        NULL;
        WHEN NO_DATA_FOUND THEN
                        SN_cod_retorno   := 4;
                        SV_mens_retorno  := 'No se encuentra datos';
                        SN_num_evento    := 0;
        WHEN OTHERS THEN
                    SN_cod_retorno   := 4;
                        SV_mens_retorno  := CV_error_no_clasif;
                        LV_des_error     := 'PV_CONSULTA_SS_LIGADOS_PR (' || EN_num_abonado || ',' || EV_cod_servicio || ',' || EV_cod_accion ||')';
                        SN_num_evento    := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                        'PV_TRATAMIENTO_SS_PG.PV_CONSULTA_SS_LIGADOS_PR', sSql, SQLCODE, LV_des_error );

END;

PROCEDURE PV_COD_TIPO_PLAN_TARIFARIO_PR (EV_cod_plan_tarifario     IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                         SV_cod_tipo_plan          IN OUT TA_PLANTARIF.COD_TIPLAN%TYPE,
                                         SV_des_tip_plan           IN OUT VARCHAR2,
                                         SN_cod_retorno            IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                         SV_mens_retorno           IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                         SN_num_evento             IN OUT NOCOPY GE_ERRORES_PG.Evento)
/*
<Documentación>
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "PV_COD_TIPO_PLAN_TARIFARIO_PR".
                Lenguaje="PL/SQL"
                Fecha creación="15-12-2006"
                Creado por="Yury Alvarez Tapia."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Función para obtener código de tipo de plan</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EV_cod_plan_tarifario" Tipo="VARCHAR">Código tipo de plan tarifario/param>
                                <param nom="SV_cod_tipo_plan"      Tipo="VARCHAR">Código tipo de plan tarifario/param>
                                <param nom="SV_des_tip_plan"       Tipo="VARCHAR">Código tipo de plan tarifario/param>
                        </Entrada>
                        <Salida>
                                                    <param nom="SN_cod_retorno"           Tipo="VARCHAR">Codigo error de negocio Retornado</param>
                                                    <param nom="SV_mens_retorno"          Tipo="VARCHAR">Mensaje error de negocio Retornado</param>
                                                    <param nom="SN_num_evento"            Tipo="VARCHAR">Nro de evento</param>
                                                </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS

        LV_des_error         GE_ERRORES_PG.DesEvent;
        sSql                 GE_ERRORES_PG.vQuery;
        LN_cantidad          NUMBER;

        FIN_EJECUCION        EXCEPTION;

BEGIN

        IF SN_cod_retorno <> 0 THEN
           RAISE FIN_EJECUCION;
        END IF;

        SN_cod_retorno   := 0;
        SV_mens_retorno  := 'OK';
        SN_num_evento    := 0;

                         sSql :='SELECT A.cod_tiplan  ';
                         sSql :=sSql || 'INTO   SV_cod_tipo_plan ';
                     sSql :=sSql || 'FROM   ta_plantarif A ';
                         sSql :=sSql || 'WHERE  A.cod_plantarif = '|| EV_cod_plan_tarifario;


                         SELECT A.cod_tiplan
                         INTO   SV_cod_tipo_plan
                         FROM   ta_plantarif A
                         WHERE  A.cod_plantarif = EV_cod_plan_tarifario;

                         IF    SV_cod_tipo_plan = CV_codtiplan1 THEN
                               SV_des_tip_plan := CV_prepago;
                         ELSIF SV_cod_tipo_plan = CV_codtiplan2 THEN
                               SV_des_tip_plan := CV_postpago;
                         ELSIF SV_cod_tipo_plan = CV_codtiplan3 THEN
                               SV_des_tip_plan := CV_hibrido;
                         END IF;

EXCEPTION
        WHEN FIN_EJECUCION THEN
                    NULL;
        WHEN NO_DATA_FOUND THEN
                        SN_cod_retorno   := 4;
                        SV_mens_retorno  := 'No se encuentra codigo tipo de plan tarifario';
                        SN_num_evento    := 0;
        WHEN OTHERS THEN
                    SN_cod_retorno   := 4;
                        SV_mens_retorno  := CV_error_no_clasif;
                        LV_des_error     := 'PV_COD_TIPO_PLAN_TARIFARIO_PR (' || EV_cod_plan_tarifario || ')';
                        SN_num_evento    := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                        'PV_TRATAMIENTO_SS_PG.PV_COD_TIPO_PLAN_TARIFARIO_PR', sSql, SQLCODE, LV_des_error );

END;


PROCEDURE PV_ARMADO_CADENAS_SS_PR (EN_cod_cliente      IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                   EN_num_abonado      IN GA_ABOCEL.num_abonado%TYPE,--ocb12
                                   SN_cod_retorno      IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                   SV_mens_retorno     IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                   SN_num_evento       IN OUT NOCOPY GE_ERRORES_PG.Evento
)
/*
<Documentación.
  TipoDoc = "Procedimiento">
   <Elemento;
      Nombre = "PV_ARMADO_CADENAS_SS_PR.
      Lenguaje="PL/SQL"
      Fecha="15-12-2006"
      Versión="1.0"
      Diseñador="Yury Andres Alvarez Tapia"
          Programador="Yury Andres Alvarez Tapia"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente"           Tipo="NUMBER">Código de Cliente/param>
            <param nom="EV_cod_plantarif_origen"  Tipo="VARCHAR">Codigo de plan tarifario origen/param>
            <param nom="EV_cod_plantarif_destino" Tipo="VARCHAR">codigo de plan tarifario destino/param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"          Tipo="NUMERICO">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

    LV_des_error         GE_ERRORES_PG.DesEvent;
        sSql                 GE_ERRORES_PG.vQuery;
        FIN_EJECUCION        EXCEPTION;

        LN_fila1                     NUMBER;
        LN_fila2                     NUMBER;
 LN_fila3       NUMBER;--ocb12
        LN_contador          NUMBER;
        LN_cant_cont         NUMBER;

    -- Variables para contener los SS contratados Activos  --
        LV_origen_cont                   VARCHAR2(3);
        LV_servicio_contr                GA_SERVSUPL.COD_SERVICIO%TYPE;
        LN_sersuple_contr                GA_SERVSUPL.COD_SERVSUPL%TYPE;
        LN_niv_contr                     GA_SERVSUPL.COD_NIVEL%TYPE;
        LV_acc_contr                     VARCHAR2(1);

        LN_sersuple_nue          GA_SERVSUPL.COD_SERVSUPL%TYPE;
        LN_niv_nue                       GA_SERVSUPL.COD_NIVEL%TYPE;
        LV_acc_nue                       VARCHAR2(1);

 LN_sersuple_perf  GA_SERVSUPL.COD_SERVSUPL%TYPE;--ocb12
 LN_niv_perf       GA_SERVSUPL.COD_NIVEL%TYPE;--ocb12
 LV_acc_perf       VARCHAR2(1);--ocb12


 LV_clase_servicio_act    pv_tmpparametros_salida_tt.clase_servicio_act%TYPE; --VARCHAR2(255);--ocb12
 LV_clase_servicio_des    pv_tmpparametros_salida_tt.clase_servicio_des%TYPE; --VARCHAR2(255);--ocb12
 LV_clase_servicio_dcero  pv_tmpparametros_salida_tt.clase_servicio_des%TYPE; --VARCHAR2(255);--ocb12
 LV_clase_servicio_ambos  pv_tmpparametros_salida_tt.clase_servicio%TYPE; --VARCHAR2(255);--ocb12
        LN_num_mov                               NUMBER(9);
 LV_error               VARCHAR2(5);--ocb12

BEGIN
        IF SN_cod_retorno <> 0 THEN
           RAISE FIN_EJECUCION;
        END IF;
        SN_cod_retorno   := 0;
        SV_mens_retorno  := 'OK';
        SN_num_evento    := 0;
        LN_contador      := ind_contratados;
        LN_cant_cont     := ind_contratados;

        LV_clase_servicio_act := '';
    LV_clase_servicio_des := '';
        LV_clase_servicio_dcero := '';

        LN_fila1:=0;

        FOR LN_fila1 IN 0..ind_contratados - 1 LOOP
                LN_sersuple_contr := tab_contratados(LN_fila1).t_v_cod_servsupl;
                LN_niv_contr      := tab_contratados(LN_fila1).t_v_cod_nivel;
                LV_acc_contr      := tab_contratados(LN_fila1).t_v_cod_accion;

                IF LV_acc_contr = CV_a THEN
                   LV_clase_servicio_act := LV_clase_servicio_act || LTRIM(TO_CHAR(LN_sersuple_contr,'00')) || LTRIM(TO_CHAR(LN_niv_contr,'0000'));
                END IF;

                IF LV_acc_contr = CV_D THEN
                   LV_clase_servicio_des   := LV_clase_servicio_des || LTRIM(TO_CHAR(LN_sersuple_contr,'00')) || LTRIM(TO_CHAR(LN_niv_contr,'0000'));
                   LV_clase_servicio_dcero := LV_clase_servicio_dcero || LTRIM(TO_CHAR(LN_sersuple_contr,'00')) || '0000';
                END IF;
        END LOOP;

        LN_fila2:=0;

        FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP
                LN_sersuple_nue := tab_nuevo(LN_fila2).t_v_cod_servsupl;
                LN_niv_nue      := tab_nuevo(LN_fila2).t_v_cod_nivel;
                LV_acc_nue      := tab_nuevo(LN_fila2).t_v_cod_accion;

                IF LV_acc_nue = CV_a THEN
                   LV_clase_servicio_act := LV_clase_servicio_act || LTRIM(TO_CHAR(LN_sersuple_nue,'00')) || LTRIM(TO_CHAR(LN_niv_nue,'0000'));
                END IF;

                IF LV_acc_nue = CV_D THEN
                   LV_clase_servicio_des := LV_clase_servicio_des || LTRIM(TO_CHAR(LN_sersuple_nue,'00')) || LTRIM(TO_CHAR(LN_niv_nue,'0000'));
                   LV_clase_servicio_dcero := LV_clase_servicio_dcero || LTRIM(TO_CHAR(LN_sersuple_nue,'00')) || '0000';
                END IF;
        END LOOP;


 LN_fila3:=0;

 FOR LN_fila3 IN 0..ind_perfiles - 1 LOOP
  LN_sersuple_perf := tab_perfiles(LN_fila3).t_v_cod_servsupl;
  LN_niv_perf      := tab_perfiles(LN_fila3).t_v_cod_nivel;
  LV_acc_perf      := tab_perfiles(LN_fila3).t_v_cod_accion;

  IF LV_acc_perf = CV_a THEN
     LV_clase_servicio_act := LV_clase_servicio_act || LTRIM(TO_CHAR(LN_sersuple_perf,'00')) || LTRIM(TO_CHAR(LN_niv_perf,'0000'));
  END IF;

  IF LV_acc_perf = CV_d THEN
     LV_clase_servicio_des := LV_clase_servicio_des || LTRIM(TO_CHAR(LN_sersuple_perf,'00')) || LTRIM(TO_CHAR(LN_niv_perf,'0000'));
     LV_clase_servicio_dcero := LV_clase_servicio_dcero || LTRIM(TO_CHAR(LN_sersuple_perf,'00')) || '0000';
  END IF;

        END LOOP;

        LV_clase_servicio_ambos := LV_clase_servicio_dcero || LV_clase_servicio_act;

/* INICIO MOD RRI*/

    dbms_output.PUT_LINE('TAB_CONTRATADOS ----------');
    FOR I IN 0..ind_contratados - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_contratados(I).t_v_origen||' | '||tab_contratados(I).t_v_cod_accion||' | '||tab_contratados(I).t_v_cod_servicio||' | '||tab_contratados(I).t_v_cod_servsupl||' | '||tab_contratados(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_NUEVO ----------');
    FOR I IN 0..ind_nuevo - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_nuevo(I).t_v_origen||' | '||tab_nuevo(I).t_v_cod_accion||' | '||tab_nuevo(I).t_v_cod_servicio||' | '||tab_nuevo(I).t_v_cod_servsupl||' | '||tab_nuevo(I).t_v_cod_nivel||' | ');
    END LOOP;

	dbms_output.PUT_LINE('TAB_PERFILES ----------');
    FOR I IN 0..ind_perfiles - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_perfiles(I).t_v_origen||' | '||tab_perfiles(I).t_v_cod_accion||' | '||tab_perfiles(I).t_v_cod_servicio||' | '||tab_perfiles(I).t_v_cod_servsupl||' | '||tab_perfiles(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('-------------------------------------------------------------------------------');
    dbms_output.PUT_LINE('----------- CADENAS A ACTIVAR Y DESACTIVAR ------------------------------------');
    dbms_output.PUT_LINE('-------------------------------------------------------------------------------');
    dbms_output.PUT_LINE('clase_servicio_act  --> '||LV_clase_servicio_act||' <<');
    dbms_output.PUT_LINE('clase_servicio_dcero--> '||LV_clase_servicio_dcero||' <<');
    dbms_output.PUT_LINE('clase_servicio_des  --> '||LV_clase_servicio_des||' <<');

/* FIN MOD RRI*/

        sSql:='SELECT PV_SEQ_NUMOS.NEXTVAL FROM DUAL';

        SELECT PV_SEQ_NUMOS.NEXTVAL INTO LN_num_mov FROM DUAL;
 sSql:='INSERT INTO PV_TMPPARAMETROS_SALIDA_TT(num_movimiento, cod_cliente, clase_servicio_act, clase_servicio_des, clase_servicio,num_abonado)';
 sSql:=sSql ||' VALUES (' || LN_num_mov ||', '|| EN_cod_cliente ||', '|| LV_clase_servicio_act ||', '|| LV_clase_servicio_des ||', '|| LV_clase_servicio_ambos ||',' || EN_num_abonado ||')';
        INSERT INTO PV_TMPPARAMETROS_SALIDA_TT(num_movimiento, cod_cliente, clase_servicio_act, clase_servicio_des, clase_servicio)
                   VALUES (LN_num_mov, EN_cod_cliente, LV_clase_servicio_act, LV_clase_servicio_des, LV_clase_servicio_ambos);


EXCEPTION
    WHEN FIN_EJECUCION THEN
            NULL;
        WHEN OTHERS THEN
            SN_cod_retorno   := 4;
                SV_mens_retorno  := CV_error_no_clasif;
                LV_des_error     := 'PV_ARMADO_CADENAS_SS_PR (' || EN_cod_cliente  || ')';
                SN_num_evento    := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                'PV_TRATAMIENTO_SS_PG.PV_ARMADO_CADENAS_SS_PR', sSql, SQLCODE, LV_des_error );
--ocb12

  --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,0,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.
--ocb12

END PV_ARMADO_CADENAS_SS_PR;

PROCEDURE PV_REGLA_CONVERSIONES_PR(EN_num_abonado            IN     GA_ABOCEL.NUM_ABONADO%TYPE,
                                   EV_cod_plantarif_origen   IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                   EV_cod_plantarif_destino  IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                   SN_cod_retorno            IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                   SV_mens_retorno           IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                   SN_num_evento             IN OUT NOCOPY GE_ERRORES_PG.Evento
)
/*
<Documentación.
  TipoDoc = "Procedimiento">
   <Elemento;
      Nombre = "PV_REGLA_CONVERSIONES_PR.
      Lenguaje="PL/SQL"
      Fecha="15-12-2006"
      Versión="1.0"
      Diseñador="Yury Andres Alvarez Tapia"
          Programador="Yury Andres Alvarez Tapia"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción>Es el encargado de realizar la conversión de servicios suplementarios opcionales.</Descripción>
       <Parámetros>
         <Entrada>
            <param nom="EN_num_abonado"           Tipo="NUMBER">Numero de Abonado/param>
            <param nom="EV_cod_plantarif_origen"  Tipo="VARCHAR">Codigo de plan tarifario origen/param>
            <param nom="EV_cod_plantarif_destino" Tipo="VARCHAR">codigo de plan tarifario destino/param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"          Tipo="NUMERICO">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

    LV_des_error         GE_ERRORES_PG.DesEvent;
    sSql                 GE_ERRORES_PG.vQuery;

    FIN_EJECUCION        EXCEPTION;

    LN_fila1             NUMBER;
    LN_fila2             NUMBER;
    LN_contador          NUMBER;
    LN_cant_cont         NUMBER;

    -- Variables para Asignar el SS con conversion --
    LN_codservsupl           GA_SERVSUPL.COD_SERVSUPL%TYPE;
    LN_codnivel              GA_SERVSUPL.COD_NIVEL%TYPE;

    -- Variables para contener los SS contratados --
    LV_ori_contr             VARCHAR2(3);
    LV_servicio_contr        GA_SERVSUPL.COD_SERVICIO%TYPE;
    LV_sersuple_contr        GA_SERVSUPL.COD_SERVSUPL%TYPE;
    LV_niv_contr             GA_SERVSUPL.COD_NIVEL%TYPE;
    LV_ori_nuevo             VARCHAR2(3);
    LV_ser_nuevo             GA_SERVSUPL.COD_SERVICIO%TYPE;

    LV_accion                VARCHAR2(1);

    LV_error                 VARCHAR2(5);

    -- Variables para contener el SS con conversion --
    LV_serv_conv_dest    PV_CONVERSION_SERVSUP_TD.COD_SERVICIO_DESTINO%TYPE;

    -- Variables para el retorno de Datos del Abonado --
    LV_tip_terminal      GA_ABOCEL.TIP_TERMINAL%TYPE;
    LV_cod_tecnologia    GA_ABOCEL.COD_TECNOLOGIA%TYPE;
    LV_cod_plan_tarif    GA_ABOCEL.COD_PLANTARIF%TYPE;
    LN_cod_central       GA_ABOCEL.COD_CENTRAL%TYPE;
    LN_num_celular       GA_ABOCEL.NUM_CELULAR%TYPE;
    LN_cod_sistema       ICG_CENTRAL.COD_SISTEMA%TYPE;

    -- Variables para contener si la topologia es ATL - POS - HIB - PRE ---
    LN_cod_tipologia_origen    PV_CONVERSION_SERVSUP_TD.COD_USO_ORIGEN%TYPE;
    LN_cod_tipologia_destino   PV_CONVERSION_SERVSUP_TD.COD_USO_DESTINO%TYPE;

    -- Variables para contener la respuesta si es abonado o plan atlantida ---
    LV_abonado_atlantida      VARCHAR2(5);
    LV_plantarif_atlantida    VARCHAR2(5);

    -- Variables para contener la respuesta de código de tipo de plan origen y destino, ademas si es HIB - PRE - POS --
    LV_cod_tipo_plan_origen   TA_PLANTARIF.COD_TIPLAN%TYPE;
    LV_cod_tipo_plan_destino  TA_PLANTARIF.COD_TIPLAN%TYPE;
    LV_des_tip_plan           VARCHAR2(3);
    LN_SS_especial            NUMBER(1); --ocb12

    LN_existe                 NUMBER;


BEGIN

    IF SN_cod_retorno <> 0 THEN
       RAISE FIN_EJECUCION;
    END IF;

    SN_cod_retorno   := 0;
    SV_mens_retorno  := 'OK';
    SN_num_evento    := 0;
    LN_contador      := ind_contratados;
    LN_cant_cont     := ind_contratados;
    LN_fila2                 := 0;

    --- Tratamiento de Origen ---
    --- LLamada al package para obtener abonado atlantida ----
    sSql :='pv_obtieneinfo_atlantida_pg.pv_existeaboatlantida2_pr('|| EN_num_abonado ||','|| LV_Abonado_Atlantida ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
    pv_obtieneinfo_atlantida_pg.pv_existeaboatlantida2_pr(EN_num_abonado,LV_Abonado_Atlantida,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener abonado atlantida',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error para obtener abonado atlantida';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;

    IF LV_Abonado_Atlantida = 'TRUE' THEN

       LN_cod_tipologia_origen := CV_atlantida;

    ELSE
       --- LLamada al procedimiento para obtener código de tipo de plan origen ----
       sSql :='PV_COD_TIPO_PLAN_TARIFARIO_PR('|| EV_cod_plantarif_origen ||','|| LV_cod_tipo_plan_origen ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
       PV_TRATAMIENTO_SS_PG.PV_COD_TIPO_PLAN_TARIFARIO_PR(EV_cod_plantarif_origen,LV_cod_tipo_plan_origen,LV_des_tip_plan,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

       IF SN_cod_retorno <> 0 THEN
          LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener código de tipo de plan origen',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
          SN_cod_retorno   := 4;
          SV_mens_retorno  := 'Error para obtener código de tipo de plan origen';
          SN_num_evento    := 0;
          RAISE FIN_EJECUCION;
       END IF;

       LN_cod_tipologia_origen := LV_des_tip_plan;

    END IF;

    --- Tratamiento de Destino ---
    --- LLamada a función para obtener plan atlantida ----
    sSql :='PV_PLAN_DESTINO_ATLANTIDA_FN('|| EV_cod_plantarif_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
    LV_plantarif_atlantida := PV_TRATAMIENTO_SS_PG.PV_PLAN_DESTINO_ATLANTIDA_FN(EV_cod_plantarif_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
       LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener plan atlantida',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       SN_cod_retorno   := 4;
       SV_mens_retorno  := 'Error para obtener plan atlantida';
       SN_num_evento    := 0;
       RAISE FIN_EJECUCION;
    END IF;

    IF LV_plantarif_atlantida = 'TRUE' THEN

       LN_cod_tipologia_destino := CV_atlantida;

    ELSE
       --- LLamada al procedimiento para obtener código de tipo de plan destino ----
       sSql :='PV_COD_TIPO_PLAN_TARIFARIO_PR('|| EV_cod_plantarif_destino ||','|| LV_cod_tipo_plan_destino ||','|| SN_cod_retorno ||','|| SV_mens_retorno ||','|| SN_num_evento ||')';
       PV_TRATAMIENTO_SS_PG.PV_COD_TIPO_PLAN_TARIFARIO_PR(EV_cod_plantarif_destino,LV_cod_tipo_plan_destino,LV_des_tip_plan,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

       IF SN_cod_retorno <> 0 THEN
          LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error para obtener código de tipo de plan destino',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
          SN_cod_retorno   := 4;
          SV_mens_retorno  := 'Error para obtener código de tipo de plan destino';
          SN_num_evento    := 0;
          RAISE FIN_EJECUCION;
       END IF;

       LN_cod_tipologia_destino := LV_des_tip_plan;

    END IF;

    LN_fila1:=0;

    FOR LN_fila1 IN 0..LN_cant_cont - 1 LOOP

        LV_ori_contr      := tab_contratados(LN_fila1).t_v_origen;
        LV_servicio_contr := tab_contratados(LN_fila1).t_v_cod_servicio;
        LV_sersuple_contr := tab_contratados(LN_fila1).t_v_cod_servsupl;
        LV_niv_contr      := tab_contratados(LN_fila1).t_v_cod_nivel;
        LV_accion         := tab_contratados(LN_fila1).t_v_cod_accion;
--ocb12

        BEGIN
            --Para filtrar los servicios especiales
            SELECT 1 into LN_SS_especial  FROM ged_codigos b
            WHERE  b.cod_modulo  = 'GA'
            AND    b.nom_tabla   = 'GA_SERVSUPL'
            AND    b.cod_valor   = TO_CHAR(LV_sersuple_contr)
            AND    b.nom_columna IN ('COD_SERVSUPL_ROAMING','COD_SERVSUPL_WAPMMS',
                                     'COD_SERVSUPL_INTEROPCO','COD_SERVSUPL_SMS');

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                     LN_SS_especial := 0;
        END;

        IF LN_SS_especial = 0 THEN --Para filtrar los SS especiales
--ocb12
           IF (LV_ori_contr = CV_opc AND LV_accion = CV_m ) THEN
              BEGIN
                  sSql :='SELECT a.cod_servicio_destino  ';
                  sSql :=sSql || 'INTO  LV_serv_conv_dest ';
                  sSql :=sSql || 'FROM  pv_conversion_servsup_td a ';
                  sSql :=sSql || 'WHERE a.cod_producto = '||CN_producto ;
                  sSql :=sSql || 'AND   a.cod_uso_origen = '||LN_cod_tipologia_origen ;
                  sSql :=sSql || 'AND   a.cod_servicio_origen ='||LV_servicio_contr ;
                  sSql :=sSql || 'AND   a.cod_uso_destino ='||LN_cod_tipologia_destino ;
                  sSql :=sSql || 'AND    SYSDATE  BETWEEN a.fec_desde AND a.fec_hasta ';


                  SELECT a.cod_servicio_destino
                  INTO   LV_serv_conv_dest
                  FROM   pv_conversion_servsup_td a
                  WHERE  a.cod_producto        = CN_producto
                  AND    a.cod_uso_origen      = LN_cod_tipologia_origen
                  AND    a.cod_servicio_origen = LV_servicio_contr
                  AND    a.cod_uso_destino     = LN_cod_tipologia_destino
                  AND    SYSDATE         BETWEEN a.fec_desde AND a.fec_hasta;

                  EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                           LV_serv_conv_dest:=NULL;
                  END;

                  IF LV_serv_conv_dest IS NOT NULL THEN
                     -- EXISTE(1)--
                     -- existe CONVERSION --
                     LN_existe := 0;
                     FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

                         LV_ori_nuevo:=tab_nuevo(LN_fila2).t_v_origen;
                         LV_ser_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servicio;

                         IF (LV_serv_conv_dest = LV_ser_nuevo) AND (LV_ori_nuevo = CV_opc) THEN
                            -- Servicio IDEM --
                            -- EXISTE(2) --
                            tab_nuevo(LN_fila2).t_v_origen       := CV_con;
                            tab_nuevo(LN_fila2).t_v_cod_accion   := CV_a;

                            tab_contratados(LN_fila1).t_v_cod_accion   := CV_d;
                            LN_existe := 1;
                         END IF;

                     END LOOP;

                     IF LN_existe = 0 THEN
                        -- NO EXISTE(2) --
                        tab_contratados(LN_fila1).t_v_cod_accion   := CV_d;
                     END IF;

                  ELSE
                     -- no existe conversion definida --
                     -- NO EXISTE(1)--
                     LN_existe := 0;
                     FOR LN_fila2 IN 0..ind_nuevo - 1 LOOP

                         LV_ori_nuevo:=tab_nuevo(LN_fila2).t_v_origen;
                         LV_ser_nuevo:=tab_nuevo(LN_fila2).t_v_cod_servicio;

                         -- busco servicio contratado dentro de la matriz plan nuevo --
--ocb12
                         --IF (LV_servicio_contr = LV_ser_nuevo) AND (LV_ori_nuevo = CV_opc) THEN
                         IF (LV_servicio_contr = LV_ser_nuevo) AND (LV_ori_nuevo in ( CV_opc,CV_def ) ) THEN
--ocb12
                            -- Servicio IDEM --
                            -- EXISTE(3) --
                            tab_nuevo(LN_fila2).t_v_cod_accion   := CV_m;
                            tab_contratados(LN_fila1).t_v_cod_accion   := CV_m;
                            LN_existe := 1;

                         END IF;

                     END LOOP;

                     IF LN_existe = 0 THEN
                        -- NO EXISTE(3) --
                        -- NO EXISTE SERV.CONTRATADO DENTRO DE MATRIZ PLAN NUEVO
                        tab_contratados(LN_fila1).t_v_cod_accion   := CV_d;
                     END IF;
                  END IF; --ocb12
           END IF;--ocb12
        END IF; --Filtra los SS especiles .....--ocb12

    END LOOP;

/* INICIO MOD RRI*/

    dbms_output.PUT_LINE('TAB_CONTRATADOS ----------');
    FOR I IN 0..ind_contratados - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_contratados(I).t_v_origen||' | '||tab_contratados(I).t_v_cod_accion||' | '||tab_contratados(I).t_v_cod_servicio||' | '||tab_contratados(I).t_v_cod_servsupl||' | '||tab_contratados(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_NUEVO ----------');
    FOR I IN 0..ind_nuevo - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_nuevo(I).t_v_origen||' | '||tab_nuevo(I).t_v_cod_accion||' | '||tab_nuevo(I).t_v_cod_servicio||' | '||tab_nuevo(I).t_v_cod_servsupl||' | '||tab_nuevo(I).t_v_cod_nivel||' | ');
    END LOOP;

/* FIN MOD RRI*/

    EXCEPTION
        WHEN FIN_EJECUCION THEN
             NULL;
        WHEN OTHERS THEN
             SN_cod_retorno   := 4;
             SV_mens_retorno  := CV_error_no_clasif;
             LV_des_error     := 'PV_REGLA_CONVERSIONES_PR (' || EN_num_abonado || ',' || EV_cod_plantarif_origen || ',' || EV_cod_plantarif_destino ||')';
             SN_num_evento    := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
            'PV_TRATAMIENTO_SS_PG.PV_REGLA_CONVERSIONES_PR', sSql, SQLCODE, LV_des_error );

            LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

END PV_REGLA_CONVERSIONES_PR;

PROCEDURE PV_REGLA_TRANSFERENCIAS_PR(EN_num_abonado      IN     GA_ABOCEL.NUM_ABONADO%TYPE,
                                     SN_cod_retorno      IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                     SV_mens_retorno     IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                     SN_num_evento       IN OUT NOCOPY GE_ERRORES_PG.Evento
)
/*
<Documentación.
  TipoDoc = "Procedimiento">
   <Elemento;
      Nombre = "PV_REGLA_TRANSFERENCIAS_PR".
      Lenguaje="PL/SQL"
      Fecha="15-12-2006"
      Versión="1.0"
      Diseñador="Yury Andres Alvarez Tapia"
          Programador="Yury Andres Alvarez Tapia"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción>Es el encargado de realizar la trasferencia de servicios suplementarios
                               a desactivar que son por defecto al plan</Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_num_abonado"         Tipo="NUMERICO">Número del Abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"          Tipo="NUMERICO">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

    LV_des_error         GE_ERRORES_PG.DesEvent;
        sSql                 GE_ERRORES_PG.vQuery;

        FIN_EJECUCION        EXCEPTION;

        LN_fila1                     NUMBER;
        LN_contador          NUMBER;
        LN_cant_cont         NUMBER;

        LV_error                         VARCHAR2(5);

    -- Variables para Asignar el SS con transferencia --
        LV_codservicio       GA_SERVSUPL.COD_SERVICIO%TYPE;
        LN_codservsupl           GA_SERVSUPL.COD_SERVSUPL%TYPE;
        LN_codnivel              GA_SERVSUPL.COD_NIVEL%TYPE;

    -- Variables para contener los SS contratados --
        LV_ori_contr             VARCHAR2(3);
        LV_servicio_contr        GA_SERVSUPL.COD_SERVICIO%TYPE;
        LV_sersuple_contr        GA_SERVSUPL.COD_SERVSUPL%TYPE;
        LV_niv_contr             GA_SERVSUPL.COD_NIVEL%TYPE;
        LV_accion            VARCHAR2(1);

        -- Variables para el retorno de Datos del Abonado --
        LV_tip_terminal      GA_ABOCEL.TIP_TERMINAL%TYPE;
        LV_cod_tecnologia    GA_ABOCEL.COD_TECNOLOGIA%TYPE;
    LV_cod_plan_tarif    GA_ABOCEL.COD_PLANTARIF%TYPE;
        LN_cod_central       GA_ABOCEL.COD_CENTRAL%TYPE;
    LN_num_celular       GA_ABOCEL.NUM_CELULAR%TYPE;
        LN_cod_sistema       ICG_CENTRAL.COD_SISTEMA%TYPE;

CURSOR CURSOR_TRANSFERENCIA IS
SELECT b.cod_servicio, b.cod_servsupl, b.cod_nivel
FROM   ga_servsup_def a, ga_servsupl b, icg_serviciotercen c
WHERE  a.cod_servicio   = LV_servicio_contr
AND    a.tip_relacion   = CN_Relacion4
AND    SYSDATE    BETWEEN a.fec_desde AND a.fec_hasta
AND    a.cod_servdef    = b.cod_servicio
AND    b.cod_producto   = CN_producto
AND    a.cod_producto   = b.cod_producto
AND    b.cod_producto   = c.cod_producto
AND    b.cod_servsupl   = c.cod_servicio
AND    c.cod_sistema    = LN_cod_sistema
AND    c.tip_terminal   = LV_tip_terminal
AND    c.tip_tecnologia = LV_cod_tecnologia;


BEGIN

        IF SN_cod_retorno <> 0 THEN
           RAISE FIN_EJECUCION;
        END IF;

        SN_cod_retorno   := 0;
        SV_mens_retorno  := 'OK';
        SN_num_evento    := 0;
        LN_contador      := ind_contratados;
        LN_cant_cont     := ind_contratados;

     sSql :='PV_RECUPERA_DATOS_ABONADO_PR('||EN_num_abonado||','||LV_tip_terminal||','||LV_cod_tecnologia||', ';
         sSql := sSql||LV_cod_plan_tarif||','||LN_cod_central||','||LN_num_celular||','||LN_cod_sistema||','||SN_cod_retorno||', ';
         sSql := sSql||SV_mens_retorno||','||SN_num_evento||')';

     PV_RECUPERA_DATOS_ABONADO_PR(EN_num_abonado,LV_tip_terminal,LV_cod_tecnologia,LV_cod_plan_tarif,LN_cod_central,LN_num_celular,LN_cod_sistema,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

         IF  SN_cod_retorno <> 0 THEN
                                 LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error al obtener Datos del Abonado',EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
             SN_cod_retorno   := 4;
             SV_mens_retorno  := 'Error al obtener Datos del Abonado';
             SN_num_evento    := 0;
             RAISE FIN_EJECUCION;
         END IF;

         sSql :='SELECT b.cod_servicio, b.cod_servsupl, b.cod_nivel ';
         sSql :=sSql || 'INTO  LV_codservicio, LN_codservsupl, LN_codnivel ';
     sSql :=sSql || 'FROM  ga_servsup_def a, ga_servsupl b, icg_serviciotercen c ';
     sSql :=sSql || 'WHERE a.cod_servicio  = '||LV_servicio_contr ;
         sSql :=sSql || 'AND   a.tip_relacion = '||CN_Relacion4 ;
         sSql :=sSql || 'AND   SYSDATE    BETWEEN a.fec_desde AND a.fec_hasta ' ;
         sSql :=sSql || 'AND   a.cod_servdef    = b.cod_servicio ';
     sSql :=sSql || 'AND   b.cod_producto   ='||CN_producto ;
         sSql :=sSql || 'AND   a.cod_producto   = b.cod_producto ';
         sSql :=sSql || 'AND   b.cod_producto   = c.cod_producto ';
         sSql :=sSql || 'AND   b.cod_servsupl   = c.cod_servicio ';
         sSql :=sSql || 'AND   c.cod_sistema    = a.cod_sistema ';
         sSql :=sSql || 'AND   c.tip_terminal   = a.tip_terminal ';
         sSql :=sSql || 'AND   c.tip_tecnologia = a.cod_tecnologia ';

         LN_fila1:=0;

     FOR LN_fila1 IN 0..LN_cant_cont - 1 LOOP

                LV_ori_contr      := tab_contratados(LN_fila1).t_v_origen;
                LV_servicio_contr := tab_contratados(LN_fila1).t_v_cod_servicio;
                LV_sersuple_contr := tab_contratados(LN_fila1).t_v_cod_servsupl;
                LV_niv_contr      := tab_contratados(LN_fila1).t_v_cod_nivel;
                LV_accion         := tab_contratados(LN_fila1).t_v_cod_accion;

                IF (LV_ori_contr = CV_def AND LV_accion = CV_D ) THEN

                        OPEN CURSOR_TRANSFERENCIA;
                        LOOP
                       FETCH CURSOR_TRANSFERENCIA INTO LV_codservicio, LN_codservsupl, LN_codnivel;
                                   EXIT WHEN CURSOR_TRANSFERENCIA%NOTFOUND;

                                   LN_contador := LN_contador + 1;

                                   tab_contratados(LN_contador).t_v_origen       := CV_TRA;
                                   tab_contratados(LN_contador).t_v_cod_servicio := LV_codservicio;
                                   tab_contratados(LN_contador).t_v_cod_servsupl := LN_codservsupl;
                                   tab_contratados(LN_contador).t_v_cod_nivel    := LN_codnivel;
                                   tab_contratados(LN_contador).t_v_cod_accion   := CV_a;

                        END LOOP;
                CLOSE CURSOR_TRANSFERENCIA;

            END IF;

     END LOOP;

         IF LN_contador > ind_contratados THEN
                ind_contratados := LN_contador; --actualiza indice general de contratados.
         END IF;

/* INICIO MOD RRI*/

    dbms_output.PUT_LINE('TAB_CONTRATADOS ----------');
    FOR I IN 0..ind_contratados - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_contratados(I).t_v_origen||' | '||tab_contratados(I).t_v_cod_accion||' | '||tab_contratados(I).t_v_cod_servicio||' | '||tab_contratados(I).t_v_cod_servsupl||' | '||tab_contratados(I).t_v_cod_nivel||' | ');
    END LOOP;

    dbms_output.PUT_LINE('TAB_NUEVO ----------');
    FOR I IN 0..ind_nuevo - 1 LOOP
        dbms_output.PUT_LINE('('||I||') | '||tab_nuevo(I).t_v_origen||' | '||tab_nuevo(I).t_v_cod_accion||' | '||tab_nuevo(I).t_v_cod_servicio||' | '||tab_nuevo(I).t_v_cod_servsupl||' | '||tab_nuevo(I).t_v_cod_nivel||' | ');
    END LOOP;

/* FIN MOD RRI*/

EXCEPTION
WHEN FIN_EJECUCION THEN
    NULL;
WHEN OTHERS THEN
    SN_cod_retorno   := 4;
        SV_mens_retorno  := CV_error_no_clasif;
        LV_des_error     := 'PV_REGLA_TRANSFERENCIAS_PR (' || EN_num_abonado  || ')';
        SN_num_evento    := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                'PV_TRATAMIENTO_SS_PG.PV_REGLA_TRANSFERENCIAS_PR', sSql, SQLCODE, LV_des_error );

     --INI. PAGC 18-07-2007 --
  LV_error:=PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN(4,'Error no controlado. N° evento: ' || to_char(SN_num_evento) ,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  --FIN.


END PV_REGLA_TRANSFERENCIAS_PR;

FUNCTION PV_INSERTA_ERROR_FN (EV_cod_error      IN     PV_TMPPARAMETROS_SALIDA_TT.COD_ERROR%TYPE,
                              EV_des_error      IN     PV_TMPPARAMETROS_SALIDA_TT.DES_ERROR%TYPE,
                              EV_num_abonado    IN     GA_ABOCEL.NUM_ABONADO%TYPE,
                              SN_cod_retorno    IN OUT NOCOPY GE_ERRORES_PG.CodError,
                              SV_mens_retorno   IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                              SN_num_evento     IN OUT NOCOPY GE_ERRORES_PG.Evento) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "PV_INSERTA_ERROR_FN"
                Lenguaje="PL/SQL"
                Fecha creación="27-12-2006"
                Creado por="Alexie Castellanos"
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para insertar la descripción de un error comercial en la tabla PV_TMPPARAMETROS_SALIDA_TT</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EV_cod_error" Tipo="NUMBER">Codigo de error comercial</param>
                                                                <param nom="EV_des_error" Tipo="VARCHAR">Descripción de error comercial</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS

        FIN_EJECUCION        EXCEPTION;

        LV_des_error         GE_ERRORES_PG.DesEvent;
        sSql                 GE_ERRORES_PG.vQuery;
        LN_cantidad          NUMBER;
        LV_resp              VARCHAR2(5);
        LN_num_mov                       NUMBER(9);
        LN_cod_cliente           NUMBER(8);

BEGIN

        IF SN_cod_retorno <> 0 THEN
           RAISE FIN_EJECUCION;
        END IF;

        SN_cod_retorno   := 0;
        SV_mens_retorno  := 'OK';
        SN_num_evento    := 0;

        sSql:='SELECT PV_SEQ_NUMOS.NEXTVAL FROM DUAL';

        SELECT PV_SEQ_NUMOS.NEXTVAL INTO LN_num_mov FROM DUAL;

        sSql :='SELECT A.COD_CLIENTE';
        sSql :=sSql || ' FROM GA_ABOCEL A';
        sSql :=sSql || ' WHERE A.NUM_ABONADO = '|| EV_num_abonado;
        sSql :=sSql || ' UNION';
        sSql :=sSql || ' SELECT B.COD_CLIENTE';
        sSql :=sSql || ' FROM GA_ABOAMIST B';
        sSql :=sSql || ' WHERE B.NUM_ABONADO = '|| EV_num_abonado;

        SELECT A.COD_CLIENTE
        INTO   LN_cod_cliente
        FROM   GA_ABOCEL A
        WHERE  A.NUM_ABONADO = EV_num_abonado
        UNION
        SELECT B.COD_CLIENTE
        FROM GA_ABOAMIST B
        WHERE B.NUM_ABONADO = EV_num_abonado;


        sSql:='INSERT INTO PV_TMPPARAMETROS_SALIDA_TT(num_movimiento, cod_cliente, cod_error, des_error)';
        sSql:=sSql ||' VALUES (' || LN_num_mov ||', '|| LN_cod_cliente || ', '|| EV_cod_error ||', '|| EV_des_error ||')';


        INSERT INTO PV_TMPPARAMETROS_SALIDA_TT(num_movimiento, cod_cliente, cod_error, des_error)
                   VALUES (LN_num_mov, LN_cod_cliente, EV_cod_error, EV_des_error);


         sSql :='SELECT COUNT(1)  ';
     sSql :=sSql || 'FROM  PV_TMPPARAMETROS_SALIDA_TT A';
         sSql :=sSql || 'WHERE A.num_movimiento = '|| LN_num_mov;


         SELECT COUNT(1)
         INTO   LN_cantidad
         FROM   PV_TMPPARAMETROS_SALIDA_TT A
         WHERE  A.num_movimiento = LN_num_mov;

        IF LN_cantidad > 0 THEN
            RETURN 'TRUE';
        ELSE
                RETURN 'FALSE';
        END IF;


EXCEPTION
        WHEN FIN_EJECUCION THEN
                    NULL;
        WHEN NO_DATA_FOUND THEN
                        SN_cod_retorno   := 4;
                        SV_mens_retorno  := 'No se encuentra datos';
                        SN_num_evento    := 0;

        WHEN OTHERS THEN
                    SN_cod_retorno   := 4;
                        SV_mens_retorno  := CV_error_no_clasif;
                        LV_des_error     := 'PV_INSERTA_ERROR_FN (' || LN_num_mov || ')';
                        SN_num_evento    := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_mo_ga,SV_mens_retorno, '1.0', USER,
                        'PV_TRATAMIENTO_SS_PG.PV_INSERTA_ERROR_FN', sSql, SQLCODE, LV_des_error );

END;

END PV_TRATAMIENTO_SS_PG;
/
SHOW ERRORS