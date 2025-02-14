CREATE OR REPLACE PACKAGE BODY SISCEL.Al_Pac_Numeracion
IS

-----------------------------------------------------

/*
<NOMBRE>       : AL_PAC_NUMERACION </NOMBRE>
<FECHACREA>    : 14-11-2002 </FECHACREA>
<MODULO >      : ADMINISTRACION DE INVENTARIO </MODULO >
<AUTOR >       : LOGISTICA </AUTOR>
<VERSION >     : 1.2 </VERSION>
<DESCRIPCION>  : RUTINAS DE NUMERACION DE SERIES </DESCRIPCION>
<FECHAMOD >    : 22-03-2013 </FECHAMOD >
<DESCMOD >     : INC 193268, se incorpora auditoria de tablas GA_CELNUM_USO, GA_CELNUM_REUTIL y AL_CELNUM_REUTIL, en PROCEDURES p_audit_insert_celnumuso y p_audit_insert_celnumreutil </DESCMOD >
<ParamEntr>    : </ParamEntr>
<ParamSal >    : </ParamEntr>
*/

-----------------------------------------------------

  PROCEDURE p_hay_numeros(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  EN_can IN al_lineas_ordenes1.can_orden%TYPE ,
  SN_nro_reutil IN OUT NUMBER ,
  v_nro_uso IN OUT NUMBER ,
  EN_cat IN ga_catnumer.cod_cat%TYPE ,
  SV_error IN OUT NUMBER )
  IS
    v_producto   ge_datosgener.prod_celular%TYPE;
    BEGIN
      p_select_celular (v_producto,
                        SV_error);
      IF SV_error = 0 THEN
         p_cuenta_reutil (EV_subalm,
                          v_producto,
                          EN_central,
                          EN_cat,
                          EN_uso,
                          SN_nro_reutil);
         p_cuenta_uso (EV_subalm,
                       v_producto,
                       EN_central,
                       EN_cat,
                       EN_uso,
                       v_nro_uso);
         IF v_nro_uso + SN_nro_reutil < EN_can THEN
            SV_error := 1;
         END IF;
      END IF;
    END p_hay_numeros;

 PROCEDURE p_hay_numeros_al(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  EN_can IN al_lineas_ordenes1.can_orden%TYPE ,
  SN_nro_reutil IN OUT NUMBER ,
  EN_cat IN ga_catnumer.cod_cat%TYPE ,
  SV_error IN OUT NUMBER )
  IS
    v_producto      ge_datosgener.prod_celular%TYPE;
    v_dias          al_usos.num_dias_hibernacion%TYPE;
    v_ind_equipado  al_celnum_reutil.ind_equipado%TYPE;
    EN_uso_sin_uso   al_celnum_reutil.COD_USO%TYPE;
    BEGIN
      v_ind_equipado := 1;
      p_select_celular (v_producto,
                        SV_error);
      BEGIN
         v_dias := ge_fn_dias_hibernacion(EN_uso);
         EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
         EXCEPTION
                   WHEN OTHERS THEN
                      SV_error := 1;
          END;

      IF SV_error = 0 THEN
         SELECT COUNT(num_celular) INTO SN_nro_reutil
           FROM al_celnum_reutil
          WHERE cod_subalm   = EV_subalm
            AND cod_producto = v_producto
            AND cod_central  = EN_central
            AND cod_cat      = EN_cat
            AND cod_uso      IN (EN_uso, EN_uso_sin_uso)
            AND (fec_baja + v_dias <= TRUNC(SYSDATE)
                             OR v_dias = 0)
            AND ind_equipado = v_ind_equipado;
      ELSE
           SN_nro_reutil := 0;
      END IF;
     IF SN_nro_reutil < EN_can THEN
            SV_error := 1;
      END IF;
  END p_hay_numeros_al;

PROCEDURE p_asigna_numeracion(
  TN_orden IN al_lineas_ordenes.num_orden%TYPE ,
  TN_tipo IN al_lineas_ordenes.tip_orden%TYPE ,
  TN_linea IN al_lineas_ordenes.num_linea%TYPE ,
  TEV_subalm IN ge_subalms.cod_subalm%TYPE ,
  TN_central IN icg_central.cod_central%TYPE ,
  TN_uso IN al_usos.cod_uso%TYPE ,
  VN_nro_reutil IN OUT NUMBER ,
  TV_terminal IN al_tipos_terminales.tip_terminal%TYPE ,
  TN_cat IN ga_catnumer.cod_cat%TYPE ,
  VN_error IN OUT NUMBER )
  IS
    TN_ind_equipado       GA_CELNUM_REUTIL.ind_equipado%TYPE;
    VN_rownum             NUMBER(4);
    TN_producto           GE_DATOSGENER.prod_celular%TYPE;
    TN_dias               AL_USOS.num_dias_hibernacion%TYPE;
    TN_uso_sin_uso        AL_CELNUM_REUTIL.cod_uso%TYPE;
    TR_ficseries          AL_FIC_SERIES%ROWTYPE;
    TN_telefono           AL_FIC_SERIES.num_telefono%TYPE;
    v_actuacion           ICG_ACTUACION.cod_actuacion%TYPE;
    TN_actuacion_aux      ICG_ACTUACION.cod_actuacion%TYPE;
    TN_actuacion_gsm      ICG_ACTUACION.cod_actuacion%TYPE;
    TN_celular            GA_CELNUM_REUTIL.num_celular%TYPE;
    TN_numero             AL_FIC_SERIES.num_telefono%TYPE;
        TN_central_tecno      ICG_CENTRAL.cod_central%TYPE;
    TV_prefijo                    AL_USOS_MIN.num_min%TYPE;
    TV_cod_estacen                AL_FIC_SERIES.cod_estacen%TYPE;
    TV_CodSimCard         AL_TIPOS_TERMINALES.tip_terminal%TYPE;
        TV_codtecnologia          ICG_CENTRAL.COD_TECNOLOGIA%TYPE;
        TV_num_min                        AL_FIC_SERIES.NUM_MIN%TYPE;
        TV_nom_parametro          GED_PARAMETROS.nom_parametro%TYPE;
        TV_cod_modulo             GED_PARAMETROS.cod_modulo%TYPE;
        CN_tecnologiagsm          CONSTANT VARCHAR(3):='GSM';
    CN_zero               PLS_INTEGER := 0;
    CN_uno                PLS_INTEGER := 1;
    CURSOR c_ficseries IS
           SELECT *
                   FROM al_fic_series
           WHERE num_orden   = TN_orden
           AND tip_orden   = TN_tipo
           AND num_linea   = TN_linea
           AND cod_subalm  = TEV_subalm
           AND cod_central = TN_central
           AND cod_uso     = TN_uso
           AND cod_cat     = TN_cat
           AND num_telefono IS NULL
    FOR UPDATE OF num_telefono NOWAIT;
    CURSOR c_tel_libres(VN_uso_sin_uso NUMBER) IS
           SELECT num_celular
           FROM al_celnum_reutil
           WHERE cod_subalm        = TEV_subalm
             AND cod_producto      = TN_producto
             AND cod_central       = TN_central
             AND cod_cat           = TN_cat
             AND cod_uso      IN (TN_uso, VN_uso_sin_uso)
             AND (fec_baja + TN_dias <= TRUNC(SYSDATE)
                  OR TN_dias = CN_zero)
             AND ind_equipado      = TN_ind_equipado
             AND ROWNUM < VN_rownum;
    BEGIN
        TN_ind_equipado := CN_uno;
        VN_rownum       := 11;
        TV_cod_estacen  := 'SO';
        p_select_celular (TN_producto,VN_error);
        VN_error := CN_zero;
        TN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,TN_uso);
                TV_nom_parametro := 'COD_SIMCARD_GSM';
                TV_cod_modulo := 'AL';

         SELECT val_parametro
         INTO TV_CodSimCard
         FROM GED_PARAMETROS
         WHERE cod_producto=CN_uno AND
               cod_modulo= TV_cod_modulo AND
               nom_parametro= TV_nom_parametro;
       BEGIN
         TN_dias := ge_fn_dias_hibernacion(TN_uso);
         EXCEPTION
            WHEN OTHERS THEN
                      VN_error := CN_uno;
            END;

        IF VN_error = CN_zero THEN
           OPEN c_ficseries;
           LOOP
           FETCH c_ficseries INTO TR_ficseries;
           EXIT WHEN c_ficseries%NOTFOUND;
           -- Nos han quitado un numero, y ademas este era el ultimo reutilizable,
           -- mientras estabamos procesando!!
           TN_numero := NULL;
           IF VN_nro_reutil > CN_zero THEN
              OPEN c_tel_libres(TN_uso_sin_uso);
              LOOP
              FETCH c_tel_libres INTO TN_celular;
                IF c_tel_libres%NOTFOUND THEN
                     VN_nro_reutil := CN_zero;
                     CLOSE c_tel_libres;
                END IF;
              BEGIN
                 TN_numero        := NULL;
                                 TN_central_tecno := NULL;
                 SELECT num_celular, cod_central
                 INTO TN_numero, TN_central_tecno
                 FROM al_celnum_reutil
                 WHERE num_celular = TN_celular
                 FOR UPDATE NOWAIT;
                 -- si estaba bloqueado salta la excepcion y busca otro numero
                 VN_nro_reutil := VN_nro_reutil -1;
                 DELETE al_celnum_reutil
                 WHERE num_celular = TN_celular;
                 EXIT;
                 EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         NULL;
                    WHEN OTHERS THEN
                         IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                         -- Vamos a por otro numero de telefono
                            NULL;
                         ELSE
                            RAISE;
                         END IF;
              END;
              END LOOP;
           END IF;
     -- ahora update al_fic_series y activacion
           IF TN_numero IS NOT NULL THEN

              SELECT Al_Fn_Prefijo_Numero(TN_numero)
              INTO TV_prefijo
              FROM DUAL;

                          SELECT cod_tecnologia
                          INTO TV_codtecnologia
                          FROM icg_central
                          WHERE cod_central = TN_central;

                          IF CN_tecnologiagsm = TV_codtecnologia THEN
                                 TV_num_min := TN_numero;
                          ELSE
                                 TV_num_min := GE_FN_MIN_DE_MDN(TN_numero);
                          END IF;

              UPDATE AL_FIC_SERIES
              SET num_telefono = TN_numero,
                  cod_estacen  = TV_cod_estacen,
                                  num_min          = TV_num_min
              WHERE CURRENT OF c_ficseries;
              p_select_actuacion (v_actuacion,TN_actuacion_gsm,TN_central_tecno);
                          IF TV_terminal=TV_CodSimCard  THEN
                            TN_actuacion_aux:=TN_actuacion_gsm;
                          ELSE
                            TN_actuacion_aux:=v_actuacion;
                          END IF;

              -- Esto es el comando de alta basica
              p_activar_central (TN_actuacion_aux,
                                        TV_prefijo,
                                        TR_ficseries.cod_central,
                                        TN_numero,
                                        TR_ficseries.num_serhex,
                                        TV_terminal,
                                        VN_error,
                                        NULL,
                                        NULL,
                                        TR_ficseries.num_serie);
           ELSE
              VN_error:=CN_uno;
              EXIT;  -- del LOOP principal
           END IF;

           IF c_tel_libres%ISOPEN  THEN
              CLOSE c_tel_libres;
           END IF;

           IF VN_error = 7 THEN
              RAISE_APPLICATION_ERROR (-20175,' ');
           END IF;

        END LOOP;
        CLOSE c_ficseries;
     END IF;
    EXCEPTION
        WHEN OTHERS THEN
             IF VN_error = 7 THEN
                   RAISE_APPLICATION_ERROR (-20175, 'Error Creacion Mvto. Activacion');
             ELSE
                   VN_error := CN_uno;
              END IF;
    END p_asigna_numeracion;

PROCEDURE p_asigna_un_numero(
  EV_subalm IN al_series.cod_subalm%TYPE ,
  EN_central IN al_series.cod_central%TYPE ,
  EN_uso IN al_series.cod_uso%TYPE ,
  EN_cat IN al_series.cod_cat%TYPE ,
  EN_numero IN OUT al_series.num_telefono%TYPE )
  IS
            v_producto     ge_datosgener.prod_celular%TYPE;
            v_dias         al_usos.num_dias_hibernacion%TYPE;
            v_rowid        ROWID;
            v_nro_uso      NUMBER := 0;
            SN_nro_reutil   NUMBER := 0;
            v_hasta        ga_celnum_uso.num_hasta%TYPE;
            SV_error        NUMBER(1) := 0;
            v_celular      ga_celnum_reutil.num_celular%TYPE;
            v_cel_uso      ga_celnum_uso%ROWTYPE;
            v_num_libres   ga_celnum_uso.num_libres%TYPE;
            v_ind_equipado ga_celnum_reutil.ind_equipado%TYPE;
            v_rownum       NUMBER(4);
                        EN_uso_sin_uso  ga_celnum_reutil.COD_USO%TYPE;
            CURSOR c_cel_reutil(p_uso_sin_uso NUMBER)  IS
            SELECT num_celular
              FROM ga_celnum_reutil
             WHERE cod_subalm    = EV_subalm
               AND cod_producto  = v_producto
               AND cod_central   = EN_central
               AND cod_cat       = EN_cat
               AND cod_uso      IN (EN_uso, p_uso_sin_uso)
               AND (fec_baja + v_dias <= TRUNC(SYSDATE)
                                OR v_dias = 0)
               AND ind_equipado = v_ind_equipado
               AND ROWNUM < v_rownum ORDER BY num_celular;

            CURSOR c_cel_uso(p_uso_sin_uso NUMBER) IS
            SELECT * FROM ga_celnum_uso
             WHERE cod_subalm    = EV_subalm
               AND cod_producto  = v_producto
               AND cod_central   = EN_central
               AND cod_cat       = EN_cat
               AND cod_uso      IN (EN_uso, p_uso_sin_uso)
               AND num_libres > v_num_libres
               AND ROWNUM < v_rownum
             ORDER BY num_desde;
  BEGIN
      EN_numero:=0;
      v_ind_equipado := 1;
      v_rownum := 21;
      v_num_libres := 0;
      p_select_celular (v_producto,SV_error);
      IF SV_error = 0 THEN
         p_cuenta_reutil (EV_subalm,v_producto,EN_central,
                          EN_cat,EN_uso,SN_nro_reutil);
         IF SN_nro_reutil > 0 THEN
            BEGIN
               v_dias := ge_fn_dias_hibernacion(EN_uso);
                           EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
            EXCEPTION
                   WHEN OTHERS THEN
                         SV_error := 1;
            END;

            IF SV_error = 0 THEN

                        OPEN c_cel_reutil(EN_uso_sin_uso);
            LOOP
               FETCH c_cel_reutil INTO v_celular;
               EXIT WHEN c_cel_reutil%NOTFOUND;
               BEGIN
                  SELECT num_celular
                    INTO EN_numero
                    FROM ga_celnum_reutil
                   WHERE num_celular = v_celular FOR UPDATE NOWAIT;
                  SN_nro_reutil := SN_nro_reutil -1;
                  DELETE ga_celnum_reutil WHERE num_celular = v_celular;
                  EXIT;
                  EXCEPTION
                             WHEN NO_DATA_FOUND THEN
                                        NULL;

                    WHEN OTHERS THEN
                        IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                           NULL;
                        ELSE
                           RAISE;
                        END IF;
               END;
            END LOOP;
            CLOSE c_cel_reutil;
            ELSE
               RAISE_APPLICATION_ERROR (-20120,'' || TO_CHAR(SQLCODE));
            END IF;
         ELSE
            p_cuenta_uso (EV_subalm,v_producto,EN_central,EN_cat,EN_uso,v_nro_uso);
            IF v_nro_uso > 0 THEN
               OPEN c_cel_uso(EN_uso_sin_uso);
               LOOP
               FETCH c_cel_uso INTO v_cel_uso;
               EXIT WHEN c_cel_uso%NOTFOUND;
               BEGIN
                  SELECT num_siguiente,ROWID,num_hasta
                    INTO EN_numero,v_rowid,v_hasta
                    FROM ga_celnum_uso
                   WHERE num_desde = v_cel_uso.num_desde
                   ORDER BY num_desde
                   FOR UPDATE OF num_siguiente, num_libres NOWAIT;
                  IF v_hasta = EN_numero THEN
                     UPDATE ga_celnum_uso SET num_libres = 0
                      WHERE ROWID = v_rowid;
                  ELSE
                     UPDATE ga_celnum_uso
                        SET num_siguiente = num_siguiente +1,
                            num_libres = num_libres -1
                      WHERE ROWID = v_rowid;
                  END IF;
                  EXIT;
                  EXCEPTION
                              WHEN NO_DATA_FOUND THEN
                                        NULL;
                     WHEN OTHERS THEN
                     IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                        NULL;
                     ELSE
                        RAISE;
            END IF;
            END;
            END LOOP;
            CLOSE c_cel_uso;
         ELSE
            RAISE_APPLICATION_ERROR (-20120,'' || TO_CHAR(SQLCODE));
            -- Error Controlado en VB (NO HAY NUMERACION)
         END IF;
      END IF;
      IF EN_numero=0 THEN
         RAISE_APPLICATION_ERROR (-20120,'--' || TO_CHAR(SQLCODE));
      END IF;
      END IF;
      EXCEPTION
      WHEN OTHERS THEN
             IF SQLCODE <> -20120 THEN
                RAISE_APPLICATION_ERROR (-20123,'');
             ELSE
                RAISE_APPLICATION_ERROR (-20120,'');
             END IF;
    -- Error Controlado en VB (ERROR ASIGNACION NUMERACION)
  END p_asigna_un_numero;

  PROCEDURE p_select_dias(
  v_dias IN OUT ga_datosgener.num_resnum%TYPE ,
  SV_error IN OUT NUMBER )
  IS
    BEGIN
       SELECT num_resnum
         INTO v_dias
         FROM ga_datosgener;
    EXCEPTION
        WHEN OTHERS THEN
             SV_error := 1;
    END p_select_dias;

  PROCEDURE p_select_celular(
  v_producto IN OUT ge_datosgener.prod_celular%TYPE ,
  SV_error IN OUT NUMBER )
  IS
    BEGIN
       SELECT prod_celular
         INTO v_producto
         FROM ge_datosgener;
    EXCEPTION
       WHEN OTHERS THEN
          SV_error := 1;
END p_select_celular;

PROCEDURE p_cuenta_reutil(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  v_producto IN ge_datosgener.prod_celular%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_cat IN al_datos_generales.cod_cat%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  SN_nro_reutil IN OUT NUMBER )
  IS
    v_dias         al_usos.num_dias_hibernacion%TYPE;
    SV_error        NUMBER(1) := 0;
    v_ind_equipado NUMBER(1) := 1;
        EN_uso_sin_uso  ga_celnum_reutil.COD_USO%TYPE;
    BEGIN
      BEGIN
         v_dias := ge_fn_dias_hibernacion(EN_uso);
                 EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
         EXCEPTION
                   WHEN OTHERS THEN
                      SV_error := 1;
          END;

        IF SV_error = 0 THEN
           SELECT COUNT(num_celular) INTO SN_nro_reutil
             FROM ga_celnum_reutil
            WHERE cod_subalm   = EV_subalm
              AND cod_producto = v_producto
              AND cod_central  = EN_central
              AND cod_cat      = EN_cat
              AND cod_uso      IN (EN_uso, EN_uso_sin_uso)
              AND (fec_baja + v_dias <= TRUNC(SYSDATE)
                               OR v_dias = 0)
              AND ind_equipado = v_ind_equipado;
        ELSE
           SN_nro_reutil := 0;
        END IF;
    EXCEPTION
       WHEN OTHERS THEN
            SN_nro_reutil := 0;
    END p_cuenta_reutil;

  PROCEDURE p_cuenta_reutil_al(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  v_producto IN ge_datosgener.prod_celular%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_cat IN al_datos_generales.cod_cat%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  SN_nro_reutil IN OUT NUMBER )
  IS
    v_dias         al_usos.num_dias_hibernacion%TYPE;
    SV_error        NUMBER(1) := 0;
    v_ind_equipado NUMBER(1) := 1;
        EN_uso_sin_uso  al_celnum_reutil.COD_USO%TYPE;
    BEGIN
        BEGIN
          v_dias := ge_fn_dias_hibernacion(EN_uso);
                  EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
          EXCEPTION
                    WHEN OTHERS THEN
                       SV_error := 1;
        END;
        IF SV_error = 0 THEN
           SELECT COUNT(num_celular) INTO SN_nro_reutil
             FROM al_celnum_reutil
            WHERE cod_subalm   = EV_subalm
              AND cod_producto = v_producto
              AND cod_central  = EN_central
              AND cod_cat      = EN_cat
              AND cod_uso      IN (EN_uso, EN_uso_sin_uso)
             AND (fec_baja + v_dias <= TRUNC(SYSDATE)
                              OR v_dias = 0)
              AND ind_equipado = v_ind_equipado;
        ELSE
           SN_nro_reutil := 0;
        END IF;
    EXCEPTION
       WHEN OTHERS THEN
            SN_nro_reutil := 0;
    END p_cuenta_reutil_al;

  PROCEDURE p_cuenta_uso(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  v_producto IN ge_datosgener.prod_celular%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_cat IN al_datos_generales.cod_cat%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  v_nro_uso IN OUT NUMBER )
  IS
    v_num_libres  NUMBER(1) := 0;
        EN_uso_sin_uso ga_celnum_uso.COD_USO%TYPE;
    BEGIN
       EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
       SELECT NVL(SUM(num_libres),0)
         INTO v_nro_uso
         FROM ga_celnum_uso
        WHERE cod_subalm    = EV_subalm
          AND cod_producto  = v_producto
          AND cod_central   = EN_central
          AND cod_cat       = EN_cat
          AND cod_uso      IN (EN_uso, EN_uso_sin_uso)
          AND num_libres > v_num_libres;
    EXCEPTION
       WHEN OTHERS THEN
            v_nro_uso := 0;
    END p_cuenta_uso;

  PROCEDURE p_select_actuacion(
  v_actuacion     IN OUT icg_actuacion.cod_actuacion%TYPE,
  v_actuacion_gsm IN OUT icg_actuacion.cod_actuacion%TYPE,
  EN_central_tecno IN     icg_central.cod_central%TYPE)
  IS
  v_cod_tecnologia      al_tecnologia.cod_tecnologia%TYPE;
  BEGIN

         BEGIN
        SELECT cod_tecnologia
        INTO v_cod_tecnologia
            FROM icg_central
        WHERE  cod_central = EN_central_tecno;
         EXCEPTION
        WHEN NO_DATA_FOUND THEN
        v_cod_tecnologia := NULL;
     END;

         BEGIN
                 SELECT cod_actcen
                 INTO   v_actuacion
                 FROM   ga_actabo
                 WHERE  cod_modulo ='AL'
                 AND    cod_producto = 1
                 AND    COD_TECNOLOGIA = v_cod_tecnologia
                 AND    cod_actabo ='AA';
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
        v_actuacion := NULL;
     END;
         --
         BEGIN
                 SELECT cod_actcen
                 INTO   v_actuacion_gsm
                 FROM   ga_actabo
                 WHERE  cod_modulo ='AL'
                 AND    cod_producto = 1
                 AND    COD_TECNOLOGIA = v_cod_tecnologia
                 AND    cod_actabo ='AG';
         EXCEPTION
        WHEN NO_DATA_FOUND THEN
        v_actuacion_gsm := NULL;
     END;


  END p_select_actuacion;

  PROCEDURE p_activar_central(
  v_actuacion IN icc_movimiento.cod_actuacion%TYPE ,
  v_prefijo   IN al_usos_min.num_min%TYPE,
  EN_central   IN icc_movimiento.cod_central%TYPE ,
  v_celular   IN icc_movimiento.num_celular%TYPE ,
  v_serie     IN icc_movimiento.num_serie%TYPE ,
  v_terminal  IN icc_movimiento.tip_terminal%TYPE ,
  SV_error     IN OUT NUMBER,
  v_plan      IN icc_movimiento.PLAN%TYPE,
  v_carga     IN icc_movimiento.carga%TYPE,
  v_serie_dec IN al_series.num_serie%TYPE,
  v_codactabochip in icc_movimiento.cod_actabo%type default null)
  IS
    v_zero              NUMBER(1) := 0;
    v_uno               NUMBER(1) := 1;
    v_cod_modulo        VARCHAR2(2);
    v_cod_actabo        VARCHAR2(2);
    v_des_respuesta     VARCHAR2(10);
    v_cod_ami_plantarif ga_datosgener.cod_ami_plantarif%TYPE;
    v_comando           VARCHAR2(500);
    v_val_parametro     ged_parametros.val_parametro%TYPE;
    v_tecnologia        al_tecnologia.cod_tecnologia%TYPE;


    BEGIN
      v_cod_modulo    := 'AL';
      v_cod_actabo    := 'XX';
      v_des_respuesta := 'PENDIENTE';

      ---123325
      if v_codactabochip is not null then
         v_cod_actabo:=v_codactabochip;
      end if;
      ---123325





-- Para poder parear , ingresamos el movimiento en la ga_movccontrol, como procesado .
      SELECT val_parametro
            INTO v_val_parametro
                FROM GED_PARAMETROS
      WHERE NOM_PARAMETRO = 'COD_PLAN_AMISTAR';
      SELECT cod_ami_plantarif INTO v_cod_ami_plantarif FROM ga_datosgener;
      IF v_carga IS NOT NULL THEN
         v_comando := 'm 9' || v_celular || ',SERVICE=PPS,STATE=DISABLED,USER=INFOHIA|D 9' ||
         v_celular || ',SERVICE=PPS,USER=INFOHIA|' ||
         'C 9' || v_celular || ',SERVICE=PPS,COS='||v_val_parametro||',SP=A1,TIME_ZONE=:America/Santiago,BALANCE=' ||
         v_carga || ',USER=INFOHIA';
        INSERT INTO GA_MOVCCONTROL (NUM_LINEA, FEC_INICIO,COD_PLANTARIF, IND_TIPMOV, IND_PROCESADO,CMD_COMVERSE)
             VALUES (v_celular, SYSDATE, v_cod_ami_plantarif , '1', 1 ,v_Comando);
      END IF;
          IF EN_central IS NOT NULL THEN
         SELECT cod_tecnologia
           INTO v_tecnologia
                   FROM icg_central
                  WHERE cod_central = EN_central;
      END IF;

      INSERT INTO icc_movimiento (num_movimiento,
                                  num_abonado,
                                  cod_estado,
                                  cod_modulo,
                                  num_intentos,
                                  des_respuesta,
                                  cod_actuacion,
                                  cod_actabo,
                                  nom_usuarora,
                                  fec_ingreso,
                                  cod_central,
                                  num_celular,
                                  num_serie,
                                  tip_terminal,
                                  ind_bloqueo,
                                  num_min,
                                  PLAN,
                                  carga,
                                  tip_tecnologia,
                                  imsi,
                                  imei,
                                  icc)
                          VALUES (icc_seq_nummov.NEXTVAL,
                                  v_zero,
                                  v_uno,
                                  v_cod_modulo,
                                  v_zero,
                                  v_des_respuesta,
                                  v_actuacion,
                                  v_cod_actabo,
                                  USER,
                                  SYSDATE,
                                  EN_central,
                                  v_celular,
                                  v_serie,
                                  v_terminal,
                                  v_zero,
                                  v_prefijo,
                                  v_plan,
                                  v_carga,
                                  --AL_TECNOLOGIA_FN (v_terminal,1), Proyecto Contabilización CMDA por Tecnologia
                                                                  v_tecnologia,
                                  AL_DATOS_GSM_FN('IMSI', v_terminal,v_serie_dec),
                                  AL_DATOS_GSM_FN('IMEI', v_terminal,v_serie_dec),
                                  AL_DATOS_GSM_FN('ICC', v_terminal,v_serie_dec));

    EXCEPTION
       WHEN OTHERS THEN
            SV_error := 7;
                        DBMS_OUTPUT.PUT_LINE(SQLCODE || SQLERRM);
    END p_activar_central;

 PROCEDURE p_libera_numero(v_reutil IN OUT ga_celnum_reutil%ROWTYPE )
  IS
      SV_error             NUMBER(1) :=0;
      v_dias              al_usos.num_dias_hibernacion%TYPE;
      v_cod_uso_ami       al_datos_generales.cod_uso_ami%TYPE;
      v_fec_baja          ga_celnum_reutil.fec_baja%TYPE;
      v_cod_plantarif     VARCHAR2(3);
      v_ind_tipmov        VARCHAR2(1);
      v_ind_procesado     NUMBER(1) := 0;
      v_ind_equipado      NUMBER(1) := 1;

      EN_central_rango     ga_celnum_reutil.cod_central%TYPE;

    BEGIN
      v_cod_plantarif := 'ALM';
      v_ind_tipmov    := '2';
      BEGIN
         v_dias := ge_fn_dias_hibernacion(v_reutil.cod_uso);
         EXCEPTION
                   WHEN OTHERS THEN
                      SV_error := 1;
          END;
      IF SV_error = 0 THEN
         SELECT cod_uso_ami
         INTO v_cod_uso_ami
         FROM AL_DATOS_GENERALES;

         v_fec_baja := SYSDATE; --Liberar un número hacia la ga_celnum_reutil => Dejar Numero Hibernado


         --Código de la Central (Original) con que fue creado el Rango que contiene el número de Celular a liberar
         SELECT cod_central
         INTO EN_central_rango
         FROM ga_celnum_uso
         WHERE v_reutil.num_celular BETWEEN num_desde AND num_hasta;

                 BEGIN
                 INSERT INTO ga_celnum_reutil (num_celular,
                                               cod_subalm,
                                               cod_producto,
                                               cod_central,
                                               cod_cat,
                                               cod_uso,
                                               fec_baja,
                                               ind_equipado,
                                                                                   uso_anterior)
                                       VALUES (v_reutil.num_celular,
                                               v_reutil.cod_subalm,
                                               v_reutil.cod_producto,
                                               EN_central_rango,
                                               v_reutil.cod_cat,
                                               v_reutil.cod_uso,
                                               v_fec_baja,
                                               v_ind_equipado,
                                                                                   v_reutil.cod_uso);
                 EXCEPTION
                   WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20141, 'Error al insertar numero en la tabla ga_celnum_reutil, Numero ' || TO_CHAR(v_reutil.num_celular));
                 END;
      END IF;
END p_libera_numero;

PROCEDURE p_libera_numero_al(
  v_reutil IN OUT al_celnum_reutil%ROWTYPE )
  IS
      SV_error         NUMBER(1) :=0;
      v_dias          al_usos.num_dias_hibernacion%TYPE;
      v_cod_uso_ami   al_datos_generales.cod_uso_ami%TYPE;
      v_fec_baja      ga_celnum_reutil.fec_baja%TYPE;
      v_cod_plantarif VARCHAR2(3);
      v_ind_tipmov    VARCHAR2(1);
      v_ind_procesado NUMBER(1) := 0;
      v_ind_equipado  NUMBER(1) := 1;
    BEGIN
      v_cod_plantarif := 'ALM';
      v_ind_tipmov    := '2';
      BEGIN
         v_dias := ge_fn_dias_hibernacion(v_reutil.cod_uso);
         EXCEPTION
                   WHEN OTHERS THEN
                      SV_error := 1;
          END;
      IF SV_error = 0 THEN
         v_fec_baja := TRUNC(SYSDATE - v_dias);  --Liberar un número hacia la ga_celnum_reutil => Dejar Numero Fuera de Hibernación

                 BEGIN

                 INSERT INTO al_celnum_reutil (num_celular,
                                               cod_subalm,
                                               cod_producto,
                                               cod_central,
                                               cod_cat,
                                               cod_uso,
                                               fec_baja,
                                               ind_equipado)
                                       VALUES (v_reutil.num_celular,
                                               v_reutil.cod_subalm,
                                               v_reutil.cod_producto,
                                               v_reutil.cod_central,
                                               v_reutil.cod_cat,
                                               v_reutil.cod_uso,
                                               v_fec_baja,
                                               v_ind_equipado);
                 EXCEPTION
                   WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20142, 'Error al insertar numero en la tabla al_celnum_reutil, Numero ' || TO_CHAR(v_reutil.num_celular));
                 END;
      END IF;
    END p_libera_numero_al;

  PROCEDURE p_numero_manual(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  v_celular IN al_series.num_telefono%TYPE ,
  v_producto IN al_series.cod_producto%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  EN_cat IN al_series.cod_cat%TYPE )
  IS
    v_dias al_usos.num_dias_hibernacion%TYPE;
    SV_error NUMBER(1) := 0;
    BEGIN
       BEGIN
         v_dias := ge_fn_dias_hibernacion(EN_uso);
         EXCEPTION
                   WHEN OTHERS THEN
                      SV_error := 1;
           END;
       IF SV_error = 0 THEN
          p_manual_reutil(EV_subalm,
                          EN_central,
                          v_celular,
                          v_producto,
                          EN_cat,
                          EN_uso,
                          v_dias,
                          SV_error);
          IF SV_error = 1 THEN
             SV_error := 0;
             p_manual_uso(EV_subalm,
                          EN_central,
                          v_celular,
                          v_producto,
                          EN_cat,
                          EN_uso,
                          SV_error);
             IF SV_error = 1 THEN
                RAISE_APPLICATION_ERROR(-20177, '');
             ELSIF
                SV_error = 2 THEN
                RAISE_APPLICATION_ERROR(-20123, '');
             END IF;
          ELSIF
             SV_error = 2 THEN
             RAISE_APPLICATION_ERROR(-20123, '');
          END IF;
       END IF;
    END p_numero_manual;

PROCEDURE p_numero_manual_al(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  v_celular IN al_series.num_telefono%TYPE ,
  v_producto IN al_series.cod_producto%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  EN_cat IN al_series.cod_cat%TYPE )
  IS
    v_dias  al_usos.num_dias_hibernacion%TYPE;
    SV_error NUMBER(1) := 0;
    v_rowid      ROWID;
    v_ind_equipado NUMBER(1):= 1;
    EN_uso_sin_uso  al_celnum_reutil.COD_USO%TYPE;
--  C.A.A.D. 04-12-2006 REQ_35796 INICIO MODIFICACION
    v_Tabla       VARCHAR2(20);
    v_Abonado     ga_abocel.num_abonado%TYPE;
    v_Situacion   ga_abocel.cod_situacion%TYPE;
    v_Cantidad    NUMBER(1);
    Celular_Encontrado EXCEPTION;
--  C.A.A.D. 04-12-2006 REQ_35796 TERMINO MODIFICACION
    BEGIN
       BEGIN
         v_dias := ge_fn_dias_hibernacion(EN_uso);
                  EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
         EXCEPTION
                   WHEN OTHERS THEN
                      SV_error := 1;
           END;
       IF SV_error = 0 THEN
--        C.A.A.D. 04-12-2006 REQ_35796 INICIO MODIFICACION
          BEGIN
            SELECT 'AL_SERIES' tabla, 0 abonado , 'No Aplica' situacion
            INTO v_Tabla, v_Abonado, v_Situacion
            FROM al_series WHERE num_telefono = v_celular
            UNION
            SELECT 'GA_ABOAMIST' tabla, num_abonado abonado, cod_situacion situacion
            FROM ga_aboamist WHERE num_celular = v_celular
            UNION
            SELECT 'GA_ABOCEL' tabla, num_abonado abonado, cod_situacion situacion
            FROM ga_abocel WHERE num_celular = v_celular;
            IF v_tabla IS NOT NULL THEN
              RAISE Celular_Encontrado;
            END IF;
          EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
          WHEN  Celular_Encontrado THEN
             RAISE_APPLICATION_ERROR(-20180, 'Número de celular [' || v_celular || '], esta asignado, Tabla [' || v_Tabla || '] Abonado [' || v_Abonado || '] Situación [' || v_Situacion || ']');
          WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20179, 'Número de celular [' || v_celular || '], esta asignado en mas de una tabla, favor de verificar en tablas de abonados y series');
          END;
--        C.A.A.D. 04-12-2006 REQ_35796 TERMINO MODIFICACION
          BEGIN
            SELECT ROWID INTO v_rowid
            FROM al_celnum_reutil
            WHERE num_celular = v_celular
            AND cod_subalm  = EV_subalm
            AND cod_central = EN_central
            AND cod_cat     = EN_cat
            AND cod_uso      IN (EN_uso, EN_uso_sin_uso)
            AND ind_equipado = v_ind_equipado
                  AND (fec_baja + v_dias <= TRUNC(SYSDATE) OR v_dias = 0)
--          C.A.A.D. 04-12-2006 REQ_35796 INICIO MODIFICACION
                  AND NOT EXISTS (SELECT 1 FROM al_series b WHERE b.num_telefono = v_celular)
            AND NOT EXISTS (SELECT 1 FROM ga_abocel c WHERE c.num_celular = v_celular AND c.cod_situacion NOT IN ('BAA', 'BAP'))
            AND NOT EXISTS (SELECT 1 FROM ga_aboamist d WHERE d.num_celular = v_celular AND d.cod_situacion  NOT IN ('BAA', 'BAP'))
--          C.A.A.D. 04-12-2006 REQ_35796 TERMINO MODIFICACION
            FOR UPDATE OF num_celular NOWAIT;
              DELETE al_celnum_reutil
              WHERE ROWID = v_rowid;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
--            C.A.A.D. 04-12-2006 REQ_35796 INICIO MODIFICACION
              RAISE_APPLICATION_ERROR(-20178, 'Número de celular no encontrado, según caracteristicas ingresadas, verificar datos del celular');
--            C.A.A.D. 04-12-2006 REQ_35796 TERMINO MODIFICACION
            WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20123, '');
          END;
       END IF;
    END p_numero_manual_al;

  PROCEDURE p_manual_reutil(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  v_celular IN al_series.num_telefono%TYPE ,
  v_producto IN al_series.cod_producto%TYPE ,
  EN_categoria IN al_series.cod_cat%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  v_dias IN al_usos.num_dias_hibernacion%TYPE ,
  SV_error IN OUT NUMBER )
  IS
       v_rowid      ROWID;
       v_ind_equipado NUMBER(1):= 1;
           EN_uso_sin_uso ga_celnum_reutil.COD_USO%TYPE;
    BEGIN
            EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
       SELECT ROWID INTO v_rowid
         FROM ga_celnum_reutil
        WHERE num_celular = v_celular
          AND cod_subalm  = EV_subalm
          AND cod_central = EN_central
          AND cod_cat     = EN_categoria
          AND cod_uso      IN (EN_uso, EN_uso_sin_uso)
          AND ind_equipado = v_ind_equipado
          AND (fec_baja + v_dias <= TRUNC(SYSDATE)
                       OR v_dias = 0)
       FOR UPDATE OF num_celular NOWAIT;
          DELETE ga_celnum_reutil
           WHERE ROWID = v_rowid;
    EXCEPTION
       WHEN NO_DATA_FOUND THEN
            SV_error := 1;
       WHEN OTHERS THEN
            SV_error := 2;
    END p_manual_reutil;

  PROCEDURE p_manual_uso(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  v_celular IN al_series.num_telefono%TYPE ,
  v_producto IN al_series.cod_producto%TYPE ,
  EN_categoria IN al_series.cod_cat%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  SV_error IN OUT NUMBER )
  IS
      v_num_des    ga_celnum_uso.num_desde%TYPE;
      v_num_has    ga_celnum_uso.num_hasta%TYPE;
      v_num_sig    ga_celnum_uso.num_siguiente%TYPE;
      v_rowid      ROWID;
      v_num_libres NUMBER(1):=0;
      v_uno        NUMBER(1):=1;
          EN_uso_sin_uso ga_celnum_uso.COD_USO%TYPE;
    BEGIN
          EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
      SELECT num_desde,num_hasta,num_siguiente,ROWID
        INTO v_num_des,v_num_has,v_num_sig,v_rowid
        FROM ga_celnum_uso
       WHERE cod_subalm  = EV_subalm
         AND cod_central = EN_central
         AND cod_cat     = EN_categoria
         AND cod_uso      IN (EN_uso, EN_uso_sin_uso)
         AND num_libres  > v_num_libres
         AND v_celular BETWEEN num_siguiente AND num_hasta
         FOR UPDATE OF num_siguiente NOWAIT;
      IF v_celular = v_num_sig THEN
         IF v_celular = v_num_has THEN
            UPDATE ga_celnum_uso
               SET num_libres    = num_libres - v_uno
             WHERE ROWID = v_rowid;
         ELSE
            UPDATE ga_celnum_uso
               SET num_siguiente = num_siguiente + v_uno,
                   num_libres    = num_libres - v_uno
             WHERE ROWID = v_rowid;
         END IF;
      ELSIF v_celular = v_num_has THEN
         UPDATE ga_celnum_uso
            SET num_hasta  = num_hasta  - v_uno,
                num_libres = num_libres - v_uno
          WHERE ROWID = v_rowid;
         INSERT INTO ga_celnum_uso
                (num_desde,num_hasta,
                 cod_subalm,cod_producto,
                 cod_central,cod_cat,
                 cod_uso,num_libres,
                 num_siguiente)
         VALUES (v_celular,v_celular,
                 EV_subalm,v_uno,
                 EN_central,EN_categoria,
                 EN_uso,v_num_libres,v_celular);
      ELSE
         UPDATE ga_celnum_uso
            SET num_hasta = v_celular - v_uno,
                num_libres = ((v_celular - v_uno) - num_siguiente) + v_uno
          WHERE ROWID = v_rowid;
         INSERT INTO ga_celnum_uso
                (num_desde,num_hasta,
                 cod_subalm,cod_producto,
                 cod_central,cod_cat,
                 cod_uso,num_libres,
                 num_siguiente)
         VALUES (v_celular,v_celular,
                 EV_subalm,v_uno,
                 EN_central,EN_categoria,
                 EN_uso,v_num_libres,v_celular);
         INSERT INTO ga_celnum_uso
                (num_desde,num_hasta,
                 cod_subalm,cod_producto,
                 cod_central,cod_cat,
                 cod_uso,num_libres,
                 num_siguiente)
         VALUES (v_celular + v_uno,v_num_has,
                 EV_subalm,v_uno,
                 EN_central,EN_categoria,
                 EN_uso,(v_num_has - (v_celular + v_uno)) + v_uno,
                 v_celular + v_uno);
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
           SV_error := 1;
      WHEN OTHERS THEN
           SV_error := 2;
    END p_manual_uso;

  PROCEDURE p_upd_intervbpl(
  v_interfaz IN al_inter_vbpl.num_interfaz%TYPE ,
  EN_numero IN al_inter_vbpl.num_telefono%TYPE )
  IS
    BEGIN
      UPDATE al_inter_vbpl
         SET num_telefono = EN_numero
       WHERE num_interfaz = v_interfaz;
    EXCEPTION
       WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20159,'Error Actualizacion Interfaz '
                                     || TO_CHAR(SQLCODE));
  END p_upd_intervbpl;

  PROCEDURE p_select_articulo(
  v_orden IN al_lineas_ordenes.num_orden%TYPE ,
  v_tipo IN al_lineas_ordenes.tip_orden%TYPE ,
  EN_linea IN al_lineas_ordenes.num_linea%TYPE ,
  v_articulo IN OUT al_articulos.cod_articulo%TYPE )
  IS
    BEGIN
       SELECT cod_articulo
         INTO v_articulo
         FROM al_vlineas_ordenes
        WHERE num_orden = v_orden
          AND tip_orden = v_tipo
          AND num_linea = EN_linea;
    EXCEPTION
       WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20159,'Error Obtencion Articulo '
                                     || TO_CHAR(SQLCODE));
    END p_select_articulo;

  PROCEDURE p_select_terminal(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_terminal IN OUT al_articulos.tip_terminal%TYPE )
  IS
    BEGIN
       SELECT tip_terminal
         INTO v_terminal
         FROM al_articulos
        WHERE cod_articulo = v_articulo;
    EXCEPTION
       WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR (-20159,'Error Obtencion Tipo Terminal '
                                     || TO_CHAR(SQLCODE));
    END p_select_terminal;

  PROCEDURE p_select_prefijo(
  v_cod_uso IN al_usos.cod_uso%TYPE ,
  v_prefijo IN OUT al_usos_min.num_min%TYPE )
  IS
    BEGIN
      SELECT num_min
        INTO v_prefijo
        FROM al_usos_min
       WHERE cod_uso=v_cod_uso
         AND fec_desde <= TRUNC(SYSDATE)
         AND NVL(fec_hasta ,TRUNC(SYSDATE)) >= TRUNC(SYSDATE);
    EXCEPTION
       WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR (-20124,'Error obteniendo el Prefijo Min '
                                     || TO_CHAR(SQLCODE));
    END p_select_prefijo;

  PROCEDURE p_select_prefijo_baja(
  v_cod_uso IN al_usos.cod_uso%TYPE ,
  v_num_serie IN al_series.num_serie%TYPE ,
  v_prefijo IN OUT al_usos_min.num_min%TYPE )
  IS
    -- si v_num_serie='0' esto se comporta igual que p_select_prefijo
    v_fecha DATE;
    v_fecha1 DATE;
    v_fecha2 DATE;
    v_zero   NUMBER(1):=0;
    v_cod_estado  VARCHAR2(2);
    BEGIN
       v_cod_estado := 'CE';
       IF v_num_serie <> '0' THEN
          SELECT MAX(a.fec_cierre)
            INTO v_fecha1
            FROM al_cab_numeracion a,
                 al_ser_numeracion b
           WHERE a.num_numeracion=b.num_numeracion
             AND b.num_numeracion > v_zero
             AND b.num_serie=v_num_serie
             AND a.tip_numeracion > v_zero
             AND a.cod_estado=v_cod_estado;
          SELECT fec_entrada
            INTO v_fecha2
            FROM al_series
           WHERE num_serie = v_num_serie;
          IF NVL(v_fecha1,TO_DATE('01-01-1990','DD-MM-YYYY')) >= v_fecha2 THEN
             v_fecha:=v_fecha1;
          ELSE v_fecha:=v_fecha2;
          END IF;
       ELSE
          v_fecha:=SYSDATE;
       END IF;
       SELECT num_min
         INTO v_prefijo
         FROM al_usos_min
        WHERE cod_uso=v_cod_uso
          AND fec_desde <= TRUNC(v_fecha)
          AND NVL(fec_hasta ,TRUNC(v_fecha)) >= TRUNC(v_fecha);
    EXCEPTION
       WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR (-20124,'Error obteniendo el Prefijo Min '
                                    || TO_CHAR(SQLCODE));
    END p_select_prefijo_baja;

PROCEDURE p_asigna_numeracion_almacen(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  EN_cat IN ga_catnumer.cod_cat%TYPE ,
  EN_cantidad IN NUMBER ,
  SV_error IN OUT NUMBER,
  p_num_sol IN al_reserva_to.num_solicitud%TYPE)
  IS
    v_ind_equipado ga_celnum_reutil.ind_equipado%TYPE;
    v_num_libres   ga_celnum_uso.num_libres%TYPE;
    v_rownum       NUMBER(4);
    v_producto     ge_datosgener.prod_celular%TYPE;
    v_dias         al_usos.num_dias_hibernacion%TYPE;
    v_total        NUMBER;
    EN_uso_sin_uso  ga_celnum_uso.COD_USO%TYPE;

        v_fecha_baja  ga_celnum_reutil.fec_baja%TYPE;
        v_tipo_proceso al_reserva_to.tipo_proceso%TYPE;
        v_cod_accion al_reserva_to.cod_accion%TYPE;
        v_audita_nro PLS_INTEGER;

        CURSOR c_tel_reutil(p_uso_sin_uso NUMBER) IS
           SELECT num_celular
            FROM ga_celnum_reutil
           WHERE cod_subalm        = EV_subalm
             AND cod_producto      = v_producto
             AND cod_central       = EN_central
             AND cod_cat           = EN_cat
             AND cod_uso      IN (EN_uso,p_uso_sin_uso)
             AND (fec_baja + v_dias <= TRUNC(SYSDATE)
                              OR v_dias = 0)
             AND ind_equipado      = v_ind_equipado;
    CURSOR c_tel_uso(p_uso_sin_uso NUMBER) IS
             SELECT * FROM ga_celnum_uso
              WHERE cod_subalm    = EV_subalm
                AND cod_producto  = v_producto
                AND cod_central   = EN_central
                AND cod_cat       = EN_cat
                AND cod_uso      IN (EN_uso, p_uso_sin_uso)
                AND num_libres    > v_num_libres;
        v_rowid       ROWID;
        v_hasta       ga_celnum_uso.num_hasta%TYPE;
        v_celular     ga_celnum_reutil.num_celular%TYPE;
        v_telefono    ga_celnum_reutil.num_celular%TYPE;
        v_tel_uso     ga_celnum_uso%ROWTYPE;
        v_fec_baja    ga_celnum_reutil.fec_baja%TYPE;
        v_zero        NUMBER := 0;
 BEGIN
                v_num_libres   := 0;
                v_ind_equipado := 1;
                v_rownum       := 10;
                v_producto := 1;
                v_total := EN_cantidad;
         BEGIN
                  SELECT a.val_parametro, b.val_parametro
                      INTO v_cod_accion, v_tipo_proceso
                      FROM ged_parametros a, ged_parametros b
                      WHERE a.nom_parametro='RESERVA_NUMERO'
                        AND a.cod_modulo='AL'
                        AND a.cod_producto=1
                                AND b.nom_parametro='ALEATORIO'
                                AND b.cod_modulo='AL'
                                AND b.cod_producto=1;
             EXCEPTION
                WHEN NO_DATA_FOUND THEN
                           SV_error := 1;
                       RAISE_APPLICATION_ERROR(-20003, 'Error(AL_ASINA_NUMERACION_ALMACEN): PROBLEMAS CON PARAMETROS DE PROCESO');
             END;

         BEGIN
           v_dias := ge_fn_dias_hibernacion(EN_uso);
                   EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
           EXCEPTION
                     WHEN OTHERS THEN
                       SV_error := 1;
         END;
                IF SV_error = 0 THEN
                   OPEN c_tel_reutil(EN_uso_sin_uso);
                   WHILE v_total > 0 LOOP
                   FETCH c_tel_reutil INTO v_celular;
                   EXIT WHEN c_tel_reutil%NOTFOUND;
                   BEGIN

                       v_telefono := NULL;
                       SELECT num_celular, fec_baja
                         INTO v_telefono, v_fec_baja
                         FROM ga_celnum_reutil
                        WHERE num_celular = v_celular
                        FOR UPDATE NOWAIT;

                         -- si estaba bloqueado salta la excepcion y busca otro numero
                                                v_fecha_baja:= TRUNC(v_fec_baja);
                        INSERT INTO al_celnum_reutil (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado,num_proceso)
                        VALUES (v_telefono, EV_subalm,v_producto,EN_central,EN_cat,EN_uso,v_fecha_baja ,v_ind_equipado, NULL );

                        DELETE ga_celnum_reutil
                        WHERE num_celular = v_telefono;
                              v_total := v_total - 1;

                                    v_audita_nro:=al_genera_auditoria_fn(v_telefono,EV_subalm,EN_central,EN_cat,EN_uso,v_fecha_baja,v_ind_equipado,v_producto,p_num_sol,v_tipo_proceso,v_cod_accion);
                        IF v_audita_nro<>0 THEN
                                                   SV_error := 1;
                                           RAISE_APPLICATION_ERROR(-20004, 'Error(AL_ASIGNA_NUMERACION_ALMACEN): PROBLEMAS AL GENERAR AUDITORIA - NUMERO:'|| TO_CHAR(v_telefono) ||' SOLICITUD :'||TO_CHAR(p_num_sol));
                                    END IF;


                   EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                           NULL;
                      WHEN OTHERS THEN
                          IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                              -- Vamos a por otro numero de telefono
                              NULL;
                          ELSE
                             SV_error := 1;
                             RAISE_APPLICATION_ERROR (-20002,'Error:' || TO_CHAR(SQLCODE) || ' ' || SQLERRM || '. ERROR EN ASIGNACION DE NUMERACION PARA NUMEROS REUTILIZABLES.' );
                             --      RAISE;
                          END IF;

                   END;
          END LOOP;
                        IF v_total <> 0 THEN
                                -- pues vamos a sacar de celnum_uso
                                OPEN c_tel_uso(EN_uso_sin_uso);
                                WHILE v_total > 0 LOOP
                                     FETCH c_tel_uso INTO v_tel_uso;
                                     EXIT WHEN c_tel_uso%NOTFOUND;
                                     BEGIN
                                        v_celular := NULL;
                                        WHILE v_total > 0  LOOP
                                                        SELECT num_siguiente,ROWID,num_hasta
                                          INTO v_celular,v_rowid,v_hasta
                                          FROM ga_celnum_uso
                                          WHERE num_desde = v_tel_uso.num_desde
                                          ORDER BY num_desde
                                          FOR UPDATE OF num_siguiente,num_libres NOWAIT;

                                          -- sirve para saber si esta bloqueado
                                                                                  v_fecha_baja:=TRUNC(SYSDATE - v_dias);
                                          INSERT INTO al_celnum_reutil (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado,num_proceso)
                                          VALUES (v_celular, EV_subalm,v_producto,EN_central,EN_cat,EN_uso, v_fecha_baja,v_ind_equipado, NULL );

                                                  v_audita_nro:=al_genera_auditoria_fn(v_celular,EV_subalm,EN_central,EN_cat,EN_uso,v_fecha_baja,v_ind_equipado,v_producto,p_num_sol,v_tipo_proceso,v_cod_accion);
                                          IF v_audita_nro<>0 THEN
                                                                     SV_error := 1;
                                                             RAISE_APPLICATION_ERROR(-20004, 'Error(AL_ASIGNA_NUMERACION_ALMACEN): PROBLEMAS AL GENERAR AUDITORIA - NUMERO:'|| TO_CHAR(v_telefono) ||' SOLICITUD :'||TO_CHAR(p_num_sol));
                                                      END IF;

                                          IF v_hasta = v_celular THEN
                                             UPDATE ga_celnum_uso
                                             SET num_libres = v_zero
                                             WHERE ROWID = v_rowid;

                                                                                         v_total := v_total - 1;
                                             EXIT;
                                          ELSE
                                                UPDATE ga_celnum_uso
                                                SET num_siguiente = num_siguiente +1,
                                                num_libres = num_libres -1
                                                WHERE ROWID = v_rowid;
                                          END IF;
                                          v_total := v_total - 1;
                                        END LOOP;
                                     EXCEPTION
                                       WHEN NO_DATA_FOUND THEN
                                            NULL;
                                       WHEN OTHERS THEN
                                            IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                                                -- Vamos a por otro numero de telefono
                                                NULL;
                                            ELSE
                                                SV_error := 1;
                                                RAISE_APPLICATION_ERROR (-20002,'Error:' || TO_CHAR(SQLCODE) || ' '|| SQLERRM || '. ERROR EN ASIGNACION DE NUMERACION PARA NUMEROS EN RANGOS.' );
                                                --              RAISE;
                                            END IF;

                                     END;

              END LOOP;
                        END IF;
                        IF c_tel_uso%ISOPEN  THEN
                CLOSE c_tel_uso;
               END IF;
               IF c_tel_reutil%ISOPEN  THEN
                    CLOSE c_tel_reutil;
               END IF;
                END IF;
END p_asigna_numeracion_almacen;

PROCEDURE p_desasigna_numeracion_almacen(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  EN_cat IN ga_catnumer.cod_cat%TYPE ,
  EN_cantidad IN NUMBER ,
  SV_error IN OUT NUMBER,
  p_num_sol IN al_reserva_to.num_solicitud%TYPE)

  IS
    v_ind_equipado ga_celnum_reutil.ind_equipado%TYPE;
    v_rownum       NUMBER(4);
    v_producto     ge_datosgener.prod_celular%TYPE;
    v_dias         al_usos.num_dias_hibernacion%TYPE;
    v_total        NUMBER;

    CURSOR c_tel_reutil(p_uso_sin_uso NUMBER) IS
           SELECT num_celular
            FROM al_celnum_reutil
           WHERE cod_subalm        = EV_subalm
             AND cod_producto      = v_producto
             AND cod_central       = EN_central
             AND cod_cat           = EN_cat
            AND cod_uso      IN (EN_uso, p_uso_sin_uso)
           --  AND (fec_baja + v_dias <= TRUNC(SYSDATE)
            --                  OR v_dias = 0)
             AND ind_equipado      = v_ind_equipado;

     v_celular     ga_celnum_reutil.num_celular%TYPE;
     v_telefono     al_celnum_reutil.num_celular%TYPE;
     v_fec_baja     al_celnum_reutil.fec_baja%TYPE;
     v_zero        NUMBER := 0;
     EN_uso_sin_uso  al_celnum_reutil.COD_USO%TYPE;

         v_tipo_proceso al_reserva_to.tipo_proceso%TYPE;
         v_cod_accion al_reserva_to.cod_accion%TYPE;
         v_audita_nro PLS_INTEGER;

     BEGIN
          v_ind_equipado := 1;
          v_producto := 1;
          v_total := EN_cantidad;
          BEGIN
                  SELECT a.val_parametro, b.val_parametro
                      INTO v_cod_accion, v_tipo_proceso
                      FROM ged_parametros a, ged_parametros b
                      WHERE a.nom_parametro='DESRESERVA_NUMERO'
                        AND a.cod_modulo='AL'
                        AND a.cod_producto=1
                                AND b.nom_parametro='ALEATORIO'
                                AND b.cod_modulo='AL'
                                AND b.cod_producto=1;
              EXCEPTION
                WHEN NO_DATA_FOUND THEN
                           SV_error := 1;
                       RAISE_APPLICATION_ERROR(-20003, 'Error(AL_DESASIGNA_NUMERACION_ALMACEN): PROBLEMAS CON PARAMETROS DE PROCESO');
              END;

          BEGIN
                v_dias := ge_fn_dias_hibernacion(EN_uso);
                EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
          EXCEPTION
             WHEN OTHERS THEN
                SV_error := 1;
          END;

          IF SV_error = 0 THEN
             OPEN c_tel_reutil(EN_uso_sin_uso);
             WHILE v_total > 0 LOOP
             FETCH c_tel_reutil INTO v_celular;
             EXIT WHEN c_tel_reutil%NOTFOUND;
             BEGIN
                  v_telefono := NULL;
                  SELECT num_celular, fec_baja
                                  INTO v_telefono, v_fec_baja
                  FROM al_celnum_reutil
                  WHERE num_celular = v_celular
                  FOR UPDATE NOWAIT;

                                  -- si estaba bloqueado salta la excepcion y busca otro numero
                  INSERT INTO ga_celnum_reutil (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado,uso_anterior)
                  VALUES (v_telefono,EV_subalm,v_producto,EN_central,EN_cat, EN_uso,v_fec_baja,v_ind_equipado,EN_uso );

                  DELETE al_celnum_reutil
                  WHERE num_celular = v_telefono;

                                  v_total := v_total - 1;

                              v_audita_nro:=al_genera_auditoria_fn(v_telefono,EV_subalm,EN_central,EN_cat,EN_uso,v_fec_baja,v_ind_equipado,v_producto,p_num_sol,v_tipo_proceso,v_cod_accion);
                  IF v_audita_nro<>0 THEN
                                         SV_error := 1;
                                     RAISE_APPLICATION_ERROR(-20004, 'Error(AL_DESASIGNA_NUMERACION_ALMACEN): PROBLEMAS AL GENERAR AUDITORIA - NUMERO:'|| TO_CHAR(v_telefono) ||' SOLICITUD :'||TO_CHAR(p_num_sol));
                              END IF;

             EXCEPTION
                WHEN NO_DATA_FOUND THEN
                   NULL;
                WHEN OTHERS THEN
                   IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                      --Vamos a por otro numero de telefono
                      NULL;
                   ELSE
                      RAISE;
                   END IF;
             END;
             END LOOP;
             IF c_tel_reutil%ISOPEN  THEN
                CLOSE c_tel_reutil;
             END IF;
          END IF;
END p_desasigna_numeracion_almacen;

PROCEDURE p_asigna_numero_ordenes(
  v_numeracion IN al_ser_numeracion.num_numeracion%TYPE ,
  EN_linea IN al_ser_numeracion.lin_numeracion%TYPE ,
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  SN_nro_reutil IN OUT NUMBER ,
  EN_cat IN ga_catnumer.cod_cat%TYPE ,
  SV_error IN OUT NUMBER )
  IS
    v_ind_equipado ga_celnum_reutil.ind_equipado%TYPE;
    v_rownum       NUMBER(4);
    v_producto     ge_datosgener.prod_celular%TYPE;
    v_dias         al_usos.num_dias_hibernacion%TYPE;
        EN_uso_sin_uso al_celnum_reutil.COD_USO%TYPE;
    CURSOR c_sernumera IS
           SELECT * FROM al_ser_numeracion
                  WHERE num_numeracion = v_numeracion
                                AND lin_numeracion = EN_linea
                    AND cod_subalm  = EV_subalm
                    AND cod_central = EN_central
                    AND cod_cat     = EN_cat
                    AND num_telefono IS NULL
                                AND ind_numerado > 0
                  FOR UPDATE OF num_telefono NOWAIT;
    CURSOR c_tel_libres(p_uso_sin_uso NUMBER) IS
           SELECT num_celular
            FROM al_celnum_reutil a
           WHERE cod_subalm        = EV_subalm
            AND cod_producto      = v_producto
            AND cod_central       = EN_central
            AND cod_cat           = EN_cat
            AND cod_uso      IN (EN_uso, p_uso_sin_uso)
            AND (fec_baja + v_dias <= TRUNC(SYSDATE) OR v_dias = 0)
--          C.A.A.D. 04-12-2006 REQ_35796 INICIO MODIFICACION
                  AND NOT EXISTS (SELECT 1 FROM al_series b WHERE b.num_telefono = a.num_celular)
            AND NOT EXISTS (SELECT 1 FROM ga_abocel c WHERE c.num_celular = a.num_celular AND c.cod_situacion NOT IN ('BAA', 'BAP'))
            AND NOT EXISTS (SELECT 1 FROM ga_aboamist d WHERE d.num_celular = a.num_celular AND d.cod_situacion  NOT IN ('BAA', 'BAP'))
--          C.A.A.D. 04-12-2006 REQ_35796 TERMINO MODIFICACION
            AND ind_equipado      = v_ind_equipado
            AND ROWNUM < v_rownum;
    v_sernumera   al_ser_numeracion%ROWTYPE;
    v_celular     al_celnum_reutil.num_celular%TYPE;
    EN_numero      al_ser_numeracion.num_telefono%TYPE;
    v_zero        NUMBER := 0;
    BEGIN
        v_ind_equipado := 1;
        v_rownum       := 11;
        p_select_celular (v_producto,
                          SV_error);
        BEGIN
           v_dias := ge_fn_dias_hibernacion(EN_uso);
                   EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
           EXCEPTION
                     WHEN OTHERS THEN
                        SV_error := 1;
        END;
        IF SV_error = 0 THEN
           OPEN c_sernumera;
           LOOP
           FETCH c_sernumera INTO v_sernumera;
           EXIT WHEN c_sernumera%NOTFOUND;
           -- Nos han quitado un numero, y ademas este era el ultimo reutilizable,
           -- mientras estabamos procesando!!
           EN_numero := NULL;
           IF SN_nro_reutil > 0 THEN
              OPEN c_tel_libres(EN_uso_sin_uso);
              LOOP
              FETCH c_tel_libres
               INTO v_celular;
                  IF c_tel_libres%NOTFOUND THEN
                     SN_nro_reutil := 0;
                     CLOSE c_tel_libres;
                  END IF;
                  BEGIN
                     EN_numero := NULL;
                     SELECT num_celular
                       INTO EN_numero
                       FROM al_celnum_reutil
                      WHERE num_celular = v_celular
                        FOR UPDATE NOWAIT;
                        -- si estaba bloqueado salta la excepcion y busca otro numero
                           SN_nro_reutil := SN_nro_reutil -1;
                           DELETE al_celnum_reutil
                            WHERE num_celular = v_celular;
                           EXIT;
                           EXCEPTION
                              WHEN NO_DATA_FOUND THEN
                                 NULL;
                              WHEN OTHERS THEN
                                 IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                                 -- Vamos a por otro numero de telefono
                                    NULL;
                                 ELSE
                                    RAISE;
                                 END IF;
                  END;
              END LOOP;
           END IF;
     -- ahora update al_ser_numeracion y activacion
           IF EN_numero IS NOT NULL THEN
              UPDATE al_ser_numeracion
                 SET num_telefono = EN_numero
               WHERE CURRENT OF c_sernumera;
           ELSE
              SV_error:=1;
              EXIT;  -- del LOOP principal
           END IF;
           IF c_tel_libres%ISOPEN  THEN
              CLOSE c_tel_libres;
           END IF;
           IF SV_error = 7 THEN
              RAISE_APPLICATION_ERROR (-20175,' ');
           END IF;
           END LOOP;
           CLOSE c_sernumera;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
             IF SV_error = 7 THEN
                   RAISE_APPLICATION_ERROR (-20175, 'Error Creacion Mvto. Activacion');
                 ELSE
                        SV_error := 1;
              END IF;
    END p_asigna_numero_ordenes;

PROCEDURE p_asigna_un_numero_al(
  EV_subalm IN al_series.cod_subalm%TYPE ,
  EN_central IN al_series.cod_central%TYPE ,
  EN_uso IN al_series.cod_uso%TYPE ,
  EN_cat IN al_series.cod_cat%TYPE ,
  EN_numero IN OUT al_series.num_telefono%TYPE )
  IS
            v_producto     ge_datosgener.prod_celular%TYPE;
            v_dias         al_usos.num_dias_hibernacion%TYPE;
            v_rowid        ROWID;
            SN_nro_reutil   NUMBER := 0;
            SV_error        NUMBER(1) := 0;
            v_celular      ga_celnum_reutil.num_celular%TYPE;
            v_ind_equipado ga_celnum_reutil.ind_equipado%TYPE;
            v_rownum       NUMBER(4);
                        EN_uso_sin_uso  al_celnum_reutil.COD_USO%TYPE;
            CURSOR c_cel_reutil(p_uso_sin_uso NUMBER) IS
            SELECT num_celular
              FROM al_celnum_reutil a
             WHERE cod_subalm    = EV_subalm
              AND cod_producto  = v_producto
              AND cod_central   = EN_central
              AND cod_cat       = EN_cat
              AND cod_uso      IN (EN_uso, p_uso_sin_uso)
              AND (fec_baja + v_dias <= TRUNC(SYSDATE) OR v_dias = 0)
              AND ind_equipado = v_ind_equipado
--            C.A.A.D. 04-12-2006 REQ_35796 INICIO MODIFICACION
                  AND NOT EXISTS (SELECT 1 FROM al_series b WHERE b.num_telefono = a.num_celular)
              AND NOT EXISTS (SELECT 1 FROM ga_abocel c WHERE c.num_celular = a.num_celular AND c.cod_situacion NOT IN ('BAA', 'BAP'))
              AND NOT EXISTS (SELECT 1 FROM ga_aboamist d WHERE d.num_celular = a.num_celular AND d.cod_situacion  NOT IN ('BAA', 'BAP'))
--            C.A.A.D. 04-12-2006 REQ_35796 TERMINO MODIFICACION
              AND ROWNUM < v_rownum ORDER BY num_celular;
  BEGIN
      EN_numero:=0;
      v_ind_equipado := 1;
      v_rownum := 11;
      p_select_celular (v_producto,SV_error);
      IF SV_error = 0 THEN
         p_cuenta_reutil_al (EV_subalm,v_producto,EN_central,
                          EN_cat,EN_uso,SN_nro_reutil);
         IF SN_nro_reutil > 0 THEN
            BEGIN
              v_dias := ge_fn_dias_hibernacion(EN_uso);
                          EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
              EXCEPTION
                WHEN OTHERS THEN
                            SV_error := 1;
            END;
            IF SV_error = 0 THEN
            OPEN c_cel_reutil(EN_uso_sin_uso);
            LOOP
               FETCH c_cel_reutil INTO v_celular;
               EXIT WHEN c_cel_reutil%NOTFOUND;
               BEGIN
                  SELECT num_celular
                    INTO EN_numero
                    FROM al_celnum_reutil
                   WHERE num_celular = v_celular FOR UPDATE NOWAIT;
                  SN_nro_reutil := SN_nro_reutil -1;
                  DELETE al_celnum_reutil WHERE num_celular = v_celular;
                  EXIT;
                  EXCEPTION
                             WHEN NO_DATA_FOUND THEN
                                        NULL;
                    WHEN OTHERS THEN
                        IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                           NULL;
                        ELSE
                           RAISE;
                        END IF;
               END;
            END LOOP;
            CLOSE c_cel_reutil;
            ELSE
               RAISE_APPLICATION_ERROR (-20120,'' || TO_CHAR(SQLCODE));
            END IF;
         ELSE
            RAISE_APPLICATION_ERROR (-20120,'' || TO_CHAR(SQLCODE));
            -- Error Controlado en VB (NO HAY NUMERACION)
         END IF;
      END IF;
      IF EN_numero=0 THEN
         RAISE_APPLICATION_ERROR (-54,'--' || TO_CHAR(SQLCODE));
      END IF;
      EXCEPTION
      WHEN OTHERS THEN
             IF SQLCODE <> -20120 THEN
                RAISE_APPLICATION_ERROR (-20123,'');
             ELSE
                RAISE_APPLICATION_ERROR (-20120,'');
             END IF;
    -- Error Controlado en VB (ERROR ASIGNACION NUMERACION)
  END p_asigna_un_numero_al;

  PROCEDURE AL_RESERVA_PUNTUAL_PR (
      p_num_celular IN ga_celnum_reutil.num_celular%TYPE,
          p_cod_subalm  IN ga_celnum_reutil.cod_subalm%TYPE,
          p_cod_central IN ga_celnum_reutil.cod_central%TYPE,
          p_cod_cat     IN ga_celnum_reutil.cod_cat%TYPE,
          p_cod_uso     IN ga_celnum_reutil.cod_uso%TYPE,
          p_num_sol     IN al_reserva_to.num_solicitud%TYPE,
          p_tipo_proceso IN al_reserva_to.tipo_proceso%TYPE)
  IS

  v_DiasHibernacion  al_usos.num_dias_hibernacion%TYPE;
  EN_uso_sin_uso    al_usos.cod_uso%TYPE;
  v_abre_rango       PLS_INTEGER;

  v_num_celular ga_celnum_reutil.num_celular%TYPE;
  v_num_reserva ga_celnum_reutil.num_celular%TYPE;
  v_cod_subalm  ga_celnum_reutil.cod_subalm%TYPE;
  v_cod_central ga_celnum_reutil.cod_central%TYPE;
  v_cod_cat     ga_celnum_reutil.cod_cat%TYPE;
  v_cod_uso     ga_celnum_reutil.cod_uso%TYPE;
  v_cod_producto ga_celnum_reutil.cod_producto%TYPE;
  v_fecha_baja   ga_celnum_reutil.fec_baja%TYPE;
  v_ind_equipado ga_celnum_reutil.ind_equipado%TYPE;

   v_num_desde       ga_celnum_uso.num_desde%TYPE;
   v_num_hasta       ga_celnum_uso.num_hasta%TYPE;
   v_num_siguiente   ga_celnum_uso.num_siguiente%TYPE;
   v_num_libres      ga_celnum_uso.num_libres%TYPE;
   v_ind_contaminado ga_celnum_uso.ind_contaminado%TYPE;

   v_num_sig  ga_celnum_uso.num_siguiente%TYPE;
   v_libres   ga_celnum_uso.num_libres%TYPE;
   v_desde       ga_celnum_uso.num_desde%TYPE;
   v_hasta       ga_celnum_uso.num_hasta%TYPE;

   v_sig_rgo    ga_celnum_uso.num_siguiente%TYPE;
   v_libres_rgo ga_celnum_uso.num_libres%TYPE;
   v_desde_rgo  ga_celnum_uso.num_desde%TYPE;
   v_hasta_rgo  ga_celnum_uso.num_hasta%TYPE;

   v_nro_valido PLS_INTEGER;
   v_cod_accion PLS_INTEGER;
   v_audita_nro PLS_INTEGER;

  BEGIN
       BEGIN
             SELECT val_parametro
                 INTO v_cod_accion
                 FROM ged_parametros
                 WHERE nom_parametro='RESERVA_NUMERO'
                   AND cod_modulo='AL'
                   AND cod_producto=1;
           EXCEPTION
             WHEN NO_DATA_FOUND THEN
                   RAISE_APPLICATION_ERROR(-20001, 'Error(AL_RESERVA_PUNTUAL_PR): PROBLEMAS CON PARAMETROS DE PROCESO');
           END;

       v_abre_rango:=0;
           v_nro_valido:=0;
           v_DiasHibernacion:=ge_fn_dias_hibernacion(p_cod_uso);
       EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,p_cod_uso);
           v_nro_valido:= adn_numeracion_pg.adn_es_portado_in_fn(p_num_celular);

           IF v_nro_valido=0 THEN
              v_nro_valido:= adn_numeracion_pg.adn_es_nro_contaminado_fn(p_num_celular);

          IF v_nro_valido=0 THEN

                 BEGIN
                      SELECT num_celular, cod_subalm, cod_producto, cod_central, cod_cat, cod_uso, fec_baja, ind_equipado
                      INTO v_num_celular, v_cod_subalm, v_cod_producto, v_cod_central, v_cod_cat, v_cod_uso, v_fecha_baja, v_ind_equipado
                      FROM ga_celnum_reutil
                      WHERE num_celular=p_num_celular
                      AND cod_subalm=p_cod_subalm
                      AND cod_central=p_cod_central
                      AND cod_cat=p_cod_cat
                      AND cod_uso IN (p_cod_uso,EN_uso_sin_uso)
                          AND (fec_baja + v_DiasHibernacion <= TRUNC(SYSDATE)
                                       OR v_DiasHibernacion = 0);
             EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                         v_abre_rango:=1;
             END;

                     IF v_abre_rango=0 THEN
                       --El numero esta en la tabla ga_celnum_reutil
                       BEGIN
                            SELECT num_celular
                            INTO  v_num_reserva
                            FROM ga_celnum_reutil
                        WHERE num_celular=v_num_celular
                          AND cod_subalm=v_cod_subalm
                          AND cod_central=v_cod_central
                          AND cod_cat=v_cod_cat
                          AND cod_uso IN (p_cod_uso,EN_uso_sin_uso)
                              FOR UPDATE NOWAIT;
               EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                     RAISE_APPLICATION_ERROR(-20002, 'Error(AL_RESERVA_PUNTUAL_PR): NUMERO ('|| TO_CHAR(p_num_celular) ||') NO SE ENCUENTRA COMO DISPONIBLE PARA RESERVA' );
                                WHEN OTHERS THEN
                                     IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                             RAISE_APPLICATION_ERROR(-20003, 'Error(AL_RESERVA_PUNTUAL_PR):NUMERO ('|| TO_CHAR(p_num_celular) ||') ESTA TOMADO POR OTRO USUARIO');
                                     END IF;
                           END;
                           v_fecha_baja:=TRUNC(v_fecha_baja);
                       INSERT INTO al_celnum_reutil (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado,num_proceso)
               VALUES (p_num_celular,v_cod_subalm,v_cod_producto,v_cod_central,v_cod_cat,v_cod_uso,v_fecha_baja,v_ind_equipado,NULL);

                       DELETE ga_celnum_reutil
               WHERE num_celular = v_num_reserva;


                     ELSE
                      --El número esta en la tabla  ga_celnum_uso
                       v_ind_equipado:=1;

                       BEGIN
                          SELECT num_desde, num_hasta, cod_subalm, cod_producto, cod_central, cod_cat, cod_uso, num_libres, num_siguiente, ind_contaminado
                          INTO v_num_desde, v_num_hasta, v_cod_subalm, v_cod_producto, v_cod_central, v_cod_cat, v_cod_uso, v_num_libres, v_num_siguiente, v_ind_contaminado
                              FROM ga_celnum_uso
                              WHERE p_num_celular BETWEEN num_desde AND num_hasta
                                AND num_siguiente <= p_num_celular
                                AND cod_subalm=p_cod_subalm
                        AND cod_central=p_cod_central
                        AND cod_cat=p_cod_cat
                        AND cod_uso IN (p_cod_uso,EN_uso_sin_uso)
                                FOR UPDATE NOWAIT;

                       EXCEPTION
                             WHEN NO_DATA_FOUND THEN
                                RAISE_APPLICATION_ERROR(-20002, 'Error(AL_RESERVA_PUNTUAL_PR): NUMERO ('|| TO_CHAR(p_num_celular) ||') NO SE ENCUENTRA COMO DISPONIBLE PARA RESERVA' );
                             WHEN OTHERS THEN
                                IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                       RAISE_APPLICATION_ERROR(-20003, 'Error(AL_RESERVA_PUNTUAL_PR):NUMERO ('|| TO_CHAR(p_num_celular) ||') ESTA TOMADO POR OTRO USUARIO');
                                END IF;
                       END;

                       --Abrir Rangos

                       IF p_num_celular=v_num_siguiente THEN

                          v_num_sig:=(v_num_siguiente + 1);
                              v_libres:=(v_num_hasta - v_num_sig + 1);
                          IF v_num_siguiente=v_num_hasta THEN
                                 v_num_sig:=v_num_hasta;
                                     v_libres:=0;
                              END IF;

                              UPDATE ga_celnum_uso
                              SET num_siguiente=v_num_sig,
                                  num_libres=v_libres
                              WHERE num_desde=v_num_desde;

                              v_fecha_baja:=TRUNC(SYSDATE - v_DiasHibernacion);
                              INSERT INTO al_celnum_reutil (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado,num_proceso)
                  VALUES (p_num_celular,v_cod_subalm,v_cod_producto,v_cod_central,v_cod_cat,v_cod_uso,v_fecha_baja,v_ind_equipado,NULL);

                       ELSE
                         IF  p_num_celular> v_num_siguiente AND p_num_celular < v_num_hasta THEN

                                     v_hasta:=(p_num_celular - 1);
                                         v_libres:= (v_hasta - v_num_siguiente + 1);

                                 UPDATE ga_celnum_uso
                                 SET num_hasta=v_hasta,
                                     num_libres=v_libres
                                 WHERE num_desde=v_num_desde;

                                         v_desde_rgo:=p_num_celular;
                                         v_hasta_rgo:=v_num_hasta ;
                                         v_sig_rgo:=v_desde_rgo +1 ;
                                         v_libres_rgo:=(v_hasta_rgo - v_sig_rgo + 1);

                                         INSERT INTO ga_celnum_uso(num_desde, num_hasta, cod_subalm, cod_producto, cod_central, cod_cat, cod_uso, num_libres, num_siguiente, ind_contaminado)
                                         VALUES (v_desde_rgo, v_hasta_rgo,v_cod_subalm,v_cod_producto,v_cod_central,v_cod_cat,v_cod_uso, v_libres_rgo, v_sig_rgo, 0);

                                         v_fecha_baja:=TRUNC(SYSDATE - v_DiasHibernacion);
                                         INSERT INTO al_celnum_reutil (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado,num_proceso)
                     VALUES (p_num_celular,v_cod_subalm,v_cod_producto,v_cod_central,v_cod_cat,v_cod_uso,v_fecha_baja,v_ind_equipado,NULL);

                             ELSE
                                IF p_num_celular=v_num_hasta THEN

                                       v_hasta:=(v_num_hasta - 1);
                                           v_libres:= (v_hasta - v_num_siguiente + 1);

                                           v_hasta_rgo:=v_num_hasta;
                                           v_desde_rgo:=v_num_hasta;
                                           v_libres_rgo:=0;
                                           v_sig_rgo:=v_hasta_rgo;

                                           UPDATE ga_celnum_uso
                                   SET num_hasta=v_hasta,
                                       num_libres=v_libres
                                   WHERE num_desde=v_num_desde;

                                           INSERT INTO ga_celnum_uso(num_desde, num_hasta, cod_subalm, cod_producto, cod_central, cod_cat, cod_uso, num_libres, num_siguiente, ind_contaminado)
                                           VALUES (v_desde_rgo, v_hasta_rgo,v_cod_subalm,v_cod_producto,v_cod_central,v_cod_cat,v_cod_uso, v_libres_rgo, v_sig_rgo, 0);

                                           v_fecha_baja:=TRUNC(SYSDATE - v_DiasHibernacion);
                                           INSERT INTO al_celnum_reutil (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado,num_proceso)
                       VALUES (p_num_celular,v_cod_subalm,v_cod_producto,v_cod_central,v_cod_cat,v_cod_uso,v_fecha_baja,v_ind_equipado,NULL);

                                    END IF;
                         END IF;

                       END IF;

                     END IF;

                         v_audita_nro:=al_genera_auditoria_fn(p_num_celular,v_cod_subalm,v_cod_central,v_cod_cat,v_cod_uso,v_fecha_baja,v_ind_equipado,v_cod_producto,p_num_sol,p_tipo_proceso,v_cod_accion);
             IF v_audita_nro<>0 THEN
                                RAISE_APPLICATION_ERROR(-20004, 'Error(AL_RESERVA_PUNTUAL_PR): PROBLEMAS AL GENERAR AUDITORIA - NUMERO:'|| TO_CHAR(p_num_celular) ||' SOLICITUD :'||TO_CHAR(p_num_sol));
                         END IF;
                  ELSE
                       RAISE_APPLICATION_ERROR(-20005, 'Error(AL_RESERVA_PUNTUAL_PR): NUMERO ('|| TO_CHAR(p_num_celular) ||') NO SE ENCUENTRA COMO DISPONIBLE PARA RESERVA' );
          END IF;
           ELSE
               RAISE_APPLICATION_ERROR(-20006, 'Error(AL_RESERVA_PUNTUAL_PR): NUMERO ('|| TO_CHAR(p_num_celular) ||') NO SE ENCUENTRA COMO DISPONIBLE PARA RESERVA' );
           END IF;

  EXCEPTION
     WHEN OTHERS THEN
        IF (SQLCODE=-54 OR SQLCODE=-60) THEN
          RAISE_APPLICATION_ERROR(-20007, 'Error(AL_RESERVA_PUNTUAL_PR):NUMERO ('|| TO_CHAR(p_num_celular) ||') ESTA TOMADO POR OTRO USUARIO' );
                ELSE
                  RAISE_APPLICATION_ERROR (-20008,'Error(AL_RESERVA_PUNTUAL_PR):NUMERO ('|| TO_CHAR(p_num_celular) ||')' || TO_CHAR(SQLCODE) || ' ' || SQLERRM );
                END IF;

  END AL_RESERVA_PUNTUAL_PR;

  PROCEDURE AL_DESRESERVA_PUNTUAL_PR(
      p_num_celular IN ga_celnum_reutil.num_celular%TYPE,
          p_cod_subalm  IN ga_celnum_reutil.cod_subalm%TYPE,
          p_cod_central IN ga_celnum_reutil.cod_central%TYPE,
          p_cod_cat     IN ga_celnum_reutil.cod_cat%TYPE,
          p_cod_uso     IN ga_celnum_reutil.cod_uso%TYPE,
          p_num_sol     IN al_reserva_to.num_solicitud%TYPE,
          p_tipo_proceso IN al_reserva_to.tipo_proceso%TYPE)
  IS

  v_fec_baja     ga_celnum_reutil.fec_baja%TYPE;
  v_cod_producto ga_celnum_reutil.cod_producto%TYPE;
  v_ind_equip    ga_celnum_reutil.ind_equipado%TYPE;
  v_cod_accion   al_reserva_to.cod_accion%TYPE;
  v_audita_nro   PLS_INTEGER;

  BEGIN
       BEGIN
             SELECT val_parametro
                 INTO v_cod_accion
                 FROM ged_parametros
                 WHERE nom_parametro='DESRESERVA_NUMERO'
                   AND cod_modulo='AL'
                   AND cod_producto=1;
           EXCEPTION
             WHEN NO_DATA_FOUND THEN
                   RAISE_APPLICATION_ERROR(-20001, 'Error(AL_DESRESERVA_PUNTUAL_PR): PROBLEMAS CON PARAMETROS DE PROCESO');
           END;

       BEGIN
               SELECT fec_baja,cod_producto, ind_equipado
               INTO v_fec_baja, v_cod_producto, v_ind_equip
                   FROM al_celnum_reutil
                   WHERE num_celular=p_num_celular
               FOR UPDATE NOWAIT;

           INSERT INTO ga_celnum_reutil (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado, uso_anterior)
           VALUES (p_num_celular,p_cod_subalm,v_cod_producto,p_cod_central,p_cod_cat,p_cod_uso,v_fec_baja,v_ind_equip,p_cod_uso );


           DELETE al_celnum_reutil
           WHERE num_celular = p_num_celular;

                   v_audita_nro:=al_genera_auditoria_fn(p_num_celular,p_cod_subalm,p_cod_central,p_cod_cat,p_cod_uso,v_fec_baja,v_ind_equip,v_cod_producto,p_num_sol,p_tipo_proceso,v_cod_accion);
           IF v_audita_nro<>0 THEN
                          RAISE_APPLICATION_ERROR(-20002, 'Error(AL_DESRESERVA_PUNTUAL_PR): PROBLEMAS AL GENERAR AUDITORIA - NUMERO:'|| TO_CHAR(p_num_celular) ||' SOLICITUD :'||TO_CHAR(p_num_sol));
                   END IF;

           EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            RAISE_APPLICATION_ERROR(-20003, 'Error(AL_DESRESERVA_PUNTUAL_PR): NUMERO ('|| TO_CHAR(p_num_celular) ||') NO SE ENCUENTRA COMO DISPONIBLE PARA DESRESERVA' );
           END;


  EXCEPTION
     WHEN OTHERS THEN
        IF (SQLCODE=-54 OR SQLCODE=-60) THEN
          RAISE_APPLICATION_ERROR(-20004, 'Error(AL_DESRESERVA_PUNTUAL_PR):NUMERO ('|| TO_CHAR(p_num_celular) ||') ESTA TOMADO POR OTRO USUARIO' );
                ELSE
                  RAISE_APPLICATION_ERROR (-20005,'Error(AL_DESRESERVA_PUNTUAL_PR):NUMERO ('|| TO_CHAR(p_num_celular) ||')' || TO_CHAR(SQLCODE) || ' ' || SQLERRM );
                END IF;
  END AL_DESRESERVA_PUNTUAL_PR;

  FUNCTION AL_GENERA_AUDITORIA_FN (
      p_num_celular IN ga_celnum_reutil.num_celular%TYPE,
          p_cod_subalm  IN ga_celnum_reutil.cod_subalm%TYPE,
          p_cod_central IN ga_celnum_reutil.cod_central%TYPE,
          p_cod_cat     IN ga_celnum_reutil.cod_cat%TYPE,
          p_cod_uso     IN ga_celnum_reutil.cod_uso%TYPE,
          p_fec_baja    IN ga_celnum_reutil.fec_baja%TYPE,
          p_ind_equip   IN ga_celnum_reutil.ind_equipado%TYPE,
          p_cod_producto IN ga_celnum_reutil.cod_producto%TYPE,
          p_num_sol     IN al_reserva_to.num_solicitud%TYPE,
          p_tipo_proceso IN al_reserva_to.tipo_proceso%TYPE,
          p_cod_accion   IN al_reserva_to.cod_accion%TYPE)
          RETURN PLS_INTEGER
  IS

  v_retorno_err PLS_INTEGER;
  v_existe_sol PLS_INTEGER;

  EN_cantidad al_reserva_to.cantidad%TYPE;

  BEGIN


       BEGIN
          v_retorno_err:=0; -- Sin errores
          v_existe_sol :=1; --Si existe (por default)
          EN_cantidad:=0;

          BEGIN
               SELECT cantidad
               INTO EN_cantidad
               FROM al_reserva_to
               WHERE num_solicitud=p_num_sol;
          EXCEPTION
              WHEN NO_DATA_FOUND THEN
                 v_existe_sol :=0;
          END;
          IF v_existe_sol=0 THEN
          --Crear Cabecera
             INSERT INTO al_reserva_to (num_solicitud, cantidad, cod_accion, tipo_proceso, cod_subalm, cod_central, cod_cat, cod_uso, cod_producto, fec_solicitud, nom_usuario)
             VALUES (p_num_sol,EN_cantidad,p_cod_accion, p_tipo_proceso,p_cod_subalm,p_cod_central,p_cod_cat,p_cod_uso,p_cod_producto, SYSDATE, USER);
          END IF;

              INSERT INTO al_det_reserva_to(num_solicitud, num_celular, fec_baja, ind_equipado)
              VALUES (p_num_sol,p_num_celular,p_fec_baja,p_ind_equip);

                  UPDATE al_reserva_to
                  SET cantidad=EN_cantidad + 1
                  WHERE num_solicitud=p_num_sol;

       EXCEPTION
            WHEN OTHERS THEN
                    v_retorno_err:=1;
       END;

  RETURN v_retorno_err;

  END AL_GENERA_AUDITORIA_FN;


  PROCEDURE AL_RESERVA_RANGO_PR (
      p_num_desde   IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta   IN ga_celnum_uso.num_hasta%TYPE,
          p_cod_subalm  IN ga_celnum_reutil.cod_subalm%TYPE,
          p_cod_central IN ga_celnum_reutil.cod_central%TYPE,
          p_cod_cat     IN ga_celnum_reutil.cod_cat%TYPE,
          p_cod_uso     IN ga_celnum_reutil.cod_uso%TYPE,
          p_cantidad    IN ga_celnum_uso.num_libres%TYPE,
          p_num_sol     IN al_reserva_to.num_solicitud%TYPE)
  IS
  v_cod_accion   al_reserva_to.cod_accion%TYPE;
  v_tipo_proceso al_reserva_to.tipo_proceso%TYPE;
  v_producto     ga_celnum_reutil.cod_producto%TYPE;
  v_ind_equip    ga_celnum_reutil.ind_equipado%TYPE;
  v_celular      ga_celnum_reutil.num_celular%TYPE;
  v_celular1     ga_celnum_reutil.num_celular%TYPE;
  v_fecha_baja   ga_celnum_reutil.fec_baja%TYPE;
  EN_uso_sin_uso  al_usos.cod_uso%TYPE;
  v_DiasHibernacion al_usos.num_dias_hibernacion%TYPE;
  v_total        ga_celnum_uso.num_libres%TYPE;
  v_num_sig      ga_celnum_uso.num_siguiente%TYPE;
  v_num_libres   ga_celnum_uso.num_libres%TYPE;
  v_sig          ga_celnum_uso.num_siguiente%TYPE;
  v_libres       ga_celnum_uso.num_libres%TYPE;

  v_audita_nro   PLS_INTEGER;

  CURSOR c_reutil(p_num_desde  ga_celnum_uso.num_desde%TYPE,
                  p_num_hasta  ga_celnum_uso.num_hasta%TYPE,
                  p_subalm  ga_celnum_reutil.cod_subalm%TYPE,
                      p_central ga_celnum_reutil.cod_central%TYPE,
                      p_cat     ga_celnum_reutil.cod_cat%TYPE,
                      p_uso     ga_celnum_reutil.cod_uso%TYPE,
                                  p_uso_sin_uso  al_usos.cod_uso%TYPE,
                                  p_producto ga_celnum_reutil.cod_producto%TYPE,
                                  p_diasHib  al_usos.num_dias_hibernacion%TYPE,
                                  p_ind_equip ga_celnum_reutil.ind_equipado%TYPE)
  IS
    SELECT num_celular, cod_subalm, cod_producto, cod_central, cod_cat, cod_uso, fec_baja
    FROM ga_celnum_reutil
    WHERE num_celular BETWEEN p_num_desde AND p_num_hasta
          AND cod_subalm        = p_subalm
      AND cod_producto      = p_producto
      AND cod_central       = p_central
      AND cod_cat           = p_cat
      AND cod_uso      IN (p_uso,p_uso_sin_uso)
      AND (fec_baja + p_diasHib <= TRUNC(SYSDATE) OR p_diasHib = 0)
      AND ind_equipado      = p_ind_equip
  ;

  v_cur_reutil c_reutil%ROWTYPE;


  BEGIN
       BEGIN
                SELECT a.val_parametro, b.val_parametro
                    INTO v_cod_accion, v_tipo_proceso
                    FROM ged_parametros a, ged_parametros b
                    WHERE a.nom_parametro='RESERVA_NUMERO'
                      AND a.cod_modulo='AL'
                      AND a.cod_producto=1
                          AND b.nom_parametro='RANGO'
                          AND b.cod_modulo='AL'
                          AND b.cod_producto=1;
           EXCEPTION
             WHEN NO_DATA_FOUND THEN
                   RAISE_APPLICATION_ERROR(-20001, 'Error(AL_RESERVA_RANGO_PR): PROBLEMAS CON PARAMETROS DE PROCESO');
           END;

           v_DiasHibernacion:=ge_fn_dias_hibernacion(p_cod_uso);
       EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,p_cod_uso);

       v_ind_equip:= 1;
       v_producto:= 1;
       v_total:= p_cantidad;

           --ga_celnum_reutil
           OPEN c_reutil(p_num_desde,p_num_hasta,p_cod_subalm,p_cod_central,p_cod_cat,p_cod_uso,EN_uso_sin_uso,v_producto,v_DiasHibernacion,v_ind_equip);
       WHILE v_total > 0 LOOP
           FETCH c_reutil INTO v_cur_reutil;
           EXIT WHEN c_reutil%NOTFOUND;
           BEGIN
                v_celular := NULL;
                SELECT num_celular
                INTO v_celular
                FROM ga_celnum_reutil
                WHERE num_celular = v_cur_reutil.num_celular
                FOR UPDATE NOWAIT;

                                v_fecha_baja:= TRUNC(v_cur_reutil.fec_baja);
                INSERT INTO al_celnum_reutil (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado,num_proceso)
                VALUES (v_celular, p_cod_subalm,v_producto,p_cod_central,p_cod_cat,p_cod_uso,v_fecha_baja ,v_ind_equip, NULL );

                DELETE ga_celnum_reutil
                WHERE num_celular = v_celular;

                                v_total := v_total - 1;

                            v_audita_nro:=al_genera_auditoria_fn(v_celular,p_cod_subalm,p_cod_central,p_cod_cat,p_cod_uso,v_fecha_baja,v_ind_equip,v_producto,p_num_sol,v_tipo_proceso,v_cod_accion);
                IF v_audita_nro<>0 THEN
                                   RAISE_APPLICATION_ERROR(-20002, 'Error(AL_RESERVA_RANGO_PR): PROBLEMAS AL GENERAR AUDITORIA - RANGO:'|| TO_CHAR(p_num_desde) ||' SOLICITUD :'||TO_CHAR(p_num_sol));
                            END IF;

           EXCEPTION
               WHEN NO_DATA_FOUND THEN
                  NULL;
               WHEN OTHERS THEN
                  IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                    -- Vamos a por otro numero de telefono
                    NULL;
                  ELSE
                    RAISE_APPLICATION_ERROR (-20003,'Error(AL_RESERVA_RANGO_PR):' || TO_CHAR(SQLCODE) || ' ' || SQLERRM || '. ERROR EN ASIGNACION DE RANGOS PARA NUMEROS REUTILIZABLES.' );
                  END IF;
           END;
       END LOOP;
           IF c_reutil%ISOPEN  THEN
          CLOSE c_reutil;
       END IF;

           --ga_celnum_uso
       IF v_total <> 0 THEN

              BEGIN
                 SELECT num_siguiente, num_libres
                     INTO  v_num_sig, v_num_libres
                 FROM ga_celnum_uso
             WHERE num_desde =p_num_desde
                   AND cod_subalm    = p_cod_subalm
               AND cod_producto  = v_producto
               AND cod_central   = p_cod_central
               AND cod_cat       = p_cod_cat
               AND cod_uso      = p_cod_uso
               AND num_libres    >= v_total
                           FOR UPDATE NOWAIT;

                  EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                            RAISE_APPLICATION_ERROR(-20004, 'Error(AL_RESERVA_RANGO_PR): RANGO ('|| TO_CHAR(p_num_desde) ||') NO SE ENCUENTRA COMO DISPONIBLE PARA RESERVA' );
                          WHEN OTHERS THEN
                            IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                  RAISE_APPLICATION_ERROR(-20003, 'Error(AL_RESERVA_RANGO_PR):RANGO ('|| TO_CHAR(p_num_desde) ||') ESTA TOMADO POR OTRO USUARIO');
                            END IF;
                  END;

                  v_sig:=v_num_sig + v_total;
                  IF v_sig>p_num_hasta THEN
                    v_sig:=p_num_hasta;
                    v_libres:=0;
                  ELSE
                    v_libres:=(p_num_hasta - v_sig + 1);
                  END IF;

                  UPDATE ga_celnum_uso
                  SET num_siguiente=v_sig,
                      num_libres=v_libres
                  WHERE num_desde=p_num_desde;

                  v_fecha_baja:=TRUNC(SYSDATE - v_DiasHibernacion);
                  v_celular1:=v_num_sig -1;
                  WHILE v_total >0 LOOP
                     v_celular1:=v_celular1 + 1;

             INSERT INTO al_celnum_reutil (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado,num_proceso)
             VALUES (v_celular1, p_cod_subalm,v_producto,p_cod_central,p_cod_cat,p_cod_uso, v_fecha_baja,v_ind_equip, NULL );

             v_audita_nro:=al_genera_auditoria_fn(v_celular1,p_cod_subalm,p_cod_central,p_cod_cat,p_cod_uso,v_fecha_baja,v_ind_equip,v_producto,p_num_sol,v_tipo_proceso,v_cod_accion);
             IF v_audita_nro<>0 THEN
                RAISE_APPLICATION_ERROR(-20005, 'Error(AL_RESERVA_RANGO_PR): PROBLEMAS AL GENERAR AUDITORIA - RANGO:'|| TO_CHAR(p_num_desde) ||' SOLICITUD :'||TO_CHAR(p_num_sol));
             END IF;

                     v_total := v_total - 1;

                  END LOOP;
       END IF;

  EXCEPTION
     WHEN OTHERS THEN
        IF (SQLCODE=-54 OR SQLCODE=-60) THEN
          RAISE_APPLICATION_ERROR(-20003, 'Error(AL_RESERVA_RANGO_PR):RANGO ('|| TO_CHAR(p_num_desde) ||') ESTA TOMADO POR OTRO USUARIO' );
                ELSE
                  RAISE_APPLICATION_ERROR (-20007,'Error(AL_RESERVA_RANGO_PR):RANGO ('|| TO_CHAR(p_num_desde) ||')' || TO_CHAR(SQLCODE) || ' ' || SQLERRM );
                END IF;

  END AL_RESERVA_RANGO_PR;


  PROCEDURE AL_DESRESERVA_RANGO_PR (
      p_num_desde   IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta   IN ga_celnum_uso.num_hasta%TYPE,
          p_cod_subalm  IN ga_celnum_reutil.cod_subalm%TYPE,
          p_cod_central IN ga_celnum_reutil.cod_central%TYPE,
          p_cod_cat     IN ga_celnum_reutil.cod_cat%TYPE,
          p_cod_uso     IN ga_celnum_reutil.cod_uso%TYPE,
          p_cantidad    IN ga_celnum_uso.num_libres%TYPE,
          p_num_sol     IN al_reserva_to.num_solicitud%TYPE)
  IS

  CURSOR c_almacen(p_num_desde  ga_celnum_uso.num_desde%TYPE,
                   p_num_hasta  ga_celnum_uso.num_hasta%TYPE,
                   p_subalm  ga_celnum_reutil.cod_subalm%TYPE,
                       p_central ga_celnum_reutil.cod_central%TYPE,
                       p_cat     ga_celnum_reutil.cod_cat%TYPE,
                       p_uso     ga_celnum_reutil.cod_uso%TYPE,
                                   p_producto ga_celnum_reutil.cod_producto%TYPE,
                                   p_ind_equip ga_celnum_reutil.ind_equipado%TYPE)
  IS
    SELECT num_celular, cod_subalm, cod_producto, cod_central, cod_cat, cod_uso, fec_baja
    FROM al_celnum_reutil
    WHERE num_celular BETWEEN p_num_desde AND p_num_hasta
          AND cod_subalm        = p_subalm
      AND cod_producto      = p_producto
      AND cod_central       = p_central
      AND cod_cat           = p_cat
      AND cod_uso           = p_uso
      AND ind_equipado      = p_ind_equip
  ;

  v_cur_alm c_almacen%ROWTYPE;

  v_cod_accion al_reserva_to.cod_accion%TYPE;
  v_tipo_proceso al_reserva_to.tipo_proceso%TYPE;
  v_producto     ga_celnum_reutil.cod_producto%TYPE;
  v_ind_equip    ga_celnum_reutil.ind_equipado%TYPE;
  v_celular      ga_celnum_reutil.num_celular%TYPE;
  v_total        ga_celnum_uso.num_libres%TYPE;
  v_fecha_baja   ga_celnum_reutil.fec_baja%TYPE;

  v_audita_nro   PLS_INTEGER;

  BEGIN
       BEGIN
                SELECT a.val_parametro, b.val_parametro
                    INTO v_cod_accion, v_tipo_proceso
                    FROM ged_parametros a, ged_parametros b
                    WHERE a.nom_parametro='DESRESERVA_NUMERO'
                      AND a.cod_modulo='AL'
                      AND a.cod_producto=1
                          AND b.nom_parametro='RANGO'
                          AND b.cod_modulo='AL'
                          AND b.cod_producto=1;
           EXCEPTION
             WHEN NO_DATA_FOUND THEN
                   RAISE_APPLICATION_ERROR(-20001, 'Error(AL_DESRESERVA_RANGO_PR): PROBLEMAS CON PARAMETROS DE PROCESO');
           END;

       v_ind_equip:= 1;
       v_producto:= 1;
       v_total:= p_cantidad;

           OPEN c_almacen(p_num_desde,p_num_hasta,p_cod_subalm,p_cod_central,p_cod_cat,p_cod_uso,v_producto,v_ind_equip);
       WHILE v_total > 0 LOOP
           FETCH c_almacen INTO v_cur_alm;
           EXIT WHEN c_almacen%NOTFOUND;
           BEGIN
                v_celular := NULL;
                SELECT num_celular
                INTO v_celular
                FROM al_celnum_reutil
                WHERE num_celular = v_cur_alm.num_celular
                FOR UPDATE NOWAIT;

                                v_fecha_baja:= TRUNC(v_cur_alm.fec_baja);
                INSERT INTO ga_celnum_reutil (num_celular, cod_subalm, cod_producto, cod_central, cod_cat, cod_uso, fec_baja, ind_equipado, uso_anterior)
                VALUES (v_celular, p_cod_subalm,v_producto,p_cod_central,p_cod_cat,p_cod_uso,v_fecha_baja ,v_ind_equip, p_cod_uso );

                DELETE al_celnum_reutil
                WHERE num_celular = v_celular;

                                v_total := v_total - 1;

                            v_audita_nro:=al_genera_auditoria_fn(v_celular,p_cod_subalm,p_cod_central,p_cod_cat,p_cod_uso,v_fecha_baja,v_ind_equip,v_producto,p_num_sol,v_tipo_proceso,v_cod_accion);
                IF v_audita_nro<>0 THEN
                                   RAISE_APPLICATION_ERROR(-20002, 'Error(AL_DESRESERVA_RANGO_PR): PROBLEMAS AL GENERAR AUDITORIA - RANGO:'|| TO_CHAR(p_num_desde) ||' SOLICITUD :'||TO_CHAR(p_num_sol));
                            END IF;

           EXCEPTION
               WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR (-20003,'Error(AL_RESERVA_RANGO_PR):' || TO_CHAR(SQLCODE) || ' ' || SQLERRM || '. ERROR EN ASIGNACION DE RANGOS PARA NUMEROS REUTILIZABLES.' );
           END;
       END LOOP;
           IF c_almacen%ISOPEN  THEN
          CLOSE c_almacen;
       END IF;

  EXCEPTION
     WHEN OTHERS THEN
        IF (SQLCODE=-54 OR SQLCODE=-60) THEN
          RAISE_APPLICATION_ERROR(-20003, 'Error(AL_DESRESERVA_RANGO_PR):RANGO ('|| TO_CHAR(p_num_desde) ||') ESTA TOMADO POR OTRO USUARIO' );
                ELSE
                  RAISE_APPLICATION_ERROR (-20007,'Error(AL_DESRESERVA_RANGO_PR):RANGO ('|| TO_CHAR(p_num_desde) ||')' || TO_CHAR(SQLCODE) || ' ' || SQLERRM );
                END IF;
  END AL_DESRESERVA_RANGO_PR;
  --
    PROCEDURE AL_VALIDA_RESERVA_PR (
          p_cod_subalm   IN ga_celnum_reutil.cod_subalm%TYPE,
          p_cod_central  IN ga_celnum_reutil.cod_central%TYPE,
          p_cod_cat      IN ga_celnum_reutil.cod_cat%TYPE,
          p_cod_uso      IN ga_celnum_reutil.cod_uso%TYPE,
          p_num_sol      IN al_reserva_to.num_solicitud%TYPE,
          p_tipo_proceso IN al_reserva_to.tipo_proceso%TYPE) IS
      /* Cursor a tabla temporal */
          CURSOR numeros IS
                         SELECT num_celular
                         FROM   al_numeros_temp_to
                         WHERE  proc_invocador = 'RSV'
                         AND    num_reserva = p_num_sol;
          /* Constantes*/
      CI_cod_producto  CONSTANT PLS_INTEGER:=1;
          CI_zero                  CONSTANT PLS_INTEGER:=0;
      CV_cod_modulo    CONSTANT VARCHAR2(2):='GE';
          CV_nom_parametro CONSTANT VARCHAR2(15):='LARGO_N_CELULAR' ;
          CV_nomproc       CONSTANT VARCHAR2(3):='RSV' ;
             /*Variables */
          TV_largo_celular    ged_parametros.val_parametro%TYPE;
          TN_uso_sin_uso      ga_celnum_reutil.COD_USO%TYPE;
          TN_dias             al_usos.num_dias_hibernacion%TYPE;
          v_fecha_baja   ga_celnum_reutil.fec_baja%TYPE;
      v_ind_equipado ga_celnum_reutil.ind_equipado%TYPE;
          v_cod_producto ga_celnum_reutil.cod_producto%TYPE;
          GI_count                    PLS_INTEGER;
          v_cod_accion        PLS_INTEGER;
          BEGIN
              BEGIN
                          SELECT val_parametro
                          INTO v_cod_accion
                          FROM ged_parametros
                          WHERE nom_parametro='RESERVA_NUMERO'
                          AND cod_modulo='AL'
                          AND cod_producto=1;
                          EXCEPTION
                             WHEN NO_DATA_FOUND THEN
                             RAISE_APPLICATION_ERROR(-20001, 'Error(AL_RESERVA_MASIVA_PR): PROBLEMAS CON PARAMETROS DE PROCESO');
                                WHEN OTHERS THEN
                                     RAISE_APPLICATION_ERROR(-20001, 'Error(AL_RESERVA_MASIVA_PR): PROBLEMAS CON PARAMETROS DE PROCESO, OTHERS');
                  END;
                  SELECT val_parametro
                  INTO   TV_largo_celular
                  FROM   ged_parametros
                  WHERE  cod_modulo  =CV_cod_modulo
                  AND    cod_producto = CI_cod_producto
                  AND    nom_parametro = 'LARGO_N_CELULAR';
                  --
                  TN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,p_cod_uso);
                  --
                  TN_dias := ge_fn_dias_hibernacion(p_cod_uso);
                  FOR cc IN numeros LOOP

                          IF LENGTH(cc.num_celular) = TO_NUMBER(TV_largo_celular) THEN
                            BEGIN

                                          SELECT fec_baja,  ind_equipado, cod_producto
                                          INTO v_fecha_baja, v_ind_equipado, v_cod_producto
                                          FROM GA_CELNUM_REUTIL
                                          WHERE cod_subalm =p_cod_subalm
                                          AND cod_producto = 1
                                          AND cod_central = p_cod_central
                                          AND cod_cat = p_cod_cat
                                          AND cod_uso IN (p_cod_uso,TN_uso_sin_uso)
                                          AND (fec_baja + TN_dias <= TRUNC(SYSDATE)
                                          OR  TN_dias   = CI_zero)
                                          AND ind_equipado = CI_cod_producto
                                          AND num_celular =cc.num_celular
                                          FOR UPDATE NOWAIT;
                                          AL_RESERVA_MASIVA_PR(cc.num_celular, p_cod_subalm, p_cod_central,p_cod_cat,p_cod_uso , v_cod_producto, v_fecha_baja, v_ind_equipado, p_num_sol ,p_tipo_proceso,TN_dias,TN_uso_sin_uso,v_cod_accion) ;
                        EXCEPTION
                                            WHEN NO_DATA_FOUND THEN
                                                  AL_GRABA_ERROR_RESERVA_PR(cc.num_celular,p_num_sol, 1);
                                                WHEN TOO_MANY_ROWS  THEN
                                                      AL_GRABA_ERROR_RESERVA_PR(cc.num_celular,p_num_sol, 3);
                                                WHEN OTHERS THEN

--                                                        RAISE_APPLICATION_ERROR(-20020, 'Error(AL_RESERVA_MASIVA_PR): PROBLEMAS CON PARAMETROS DE PROCESO');
RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM)       ;
                            END;
                          ELSE
                                  AL_GRABA_ERROR_RESERVA_PR(cc.num_celular,p_num_sol, 2);
                          END IF;
                  END LOOP;
                  EXCEPTION WHEN OTHERS THEN
                  RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
  END    AL_VALIDA_RESERVA_PR;
  --
   PROCEDURE AL_VALIDA_DESRESERVA_PR (
          p_cod_subalm   IN ga_celnum_reutil.cod_subalm%TYPE,
          p_cod_central  IN ga_celnum_reutil.cod_central%TYPE,
          p_cod_cat      IN ga_celnum_reutil.cod_cat%TYPE,
          p_cod_uso      IN ga_celnum_reutil.cod_uso%TYPE,
          p_num_sol      IN al_reserva_to.num_solicitud%TYPE,
          p_tipo_proceso IN al_reserva_to.tipo_proceso%TYPE) IS
      /* Cursor a tabla temporal */
          CURSOR numeros IS
                         SELECT num_celular
                         FROM   al_numeros_temp_to
                         WHERE  proc_invocador = 'RSV'
                         AND    num_reserva = p_num_sol;
          /* Constantes*/
      CI_cod_producto  CONSTANT PLS_INTEGER:=1;
          CI_zero                  CONSTANT PLS_INTEGER:=0;
      CV_cod_modulo    CONSTANT VARCHAR2(2):='GE';
          CV_nom_parametro CONSTANT VARCHAR2(15):='LARGO_N_CELULAR' ;
          CV_nomproc       CONSTANT VARCHAR2(3):='RSV' ;
             /*Variables */
          TV_largo_celular    ged_parametros.val_parametro%TYPE;
          TN_uso_sin_uso      ga_celnum_reutil.COD_USO%TYPE;
          TN_dias             al_usos.num_dias_hibernacion%TYPE;
          v_fecha_baja   ga_celnum_reutil.fec_baja%TYPE;
      v_ind_equipado ga_celnum_reutil.ind_equipado%TYPE;
          v_cod_producto ga_celnum_reutil.cod_producto%TYPE;
          GI_count                    PLS_INTEGER;
          v_cod_accion        PLS_INTEGER;
          BEGIN

              BEGIN

                          SELECT val_parametro
                          INTO v_cod_accion
                          FROM ged_parametros
                          WHERE nom_parametro='DESRESERVA_NUMERO'
                          AND cod_modulo='AL'
                          AND cod_producto=1;

                          EXCEPTION
                             WHEN NO_DATA_FOUND THEN

                             RAISE_APPLICATION_ERROR(-20001, 'Error(AL_DESRESERVA_MASIVA_PR): PROBLEMAS CON PARAMETROS DE PROCESO');
                                WHEN OTHERS THEN
                                     RAISE_APPLICATION_ERROR(-20001, 'Error(AL_DESRESERVA_MASIVA_PR): PROBLEMAS CON PARAMETROS DE PROCESO, OTHERS');
                  END;

                  SELECT val_parametro
                  INTO   TV_largo_celular
                  FROM   ged_parametros
                  WHERE  cod_modulo  =CV_cod_modulo
                  AND    cod_producto = CI_cod_producto
                  AND    nom_parametro = 'LARGO_N_CELULAR';

                  --
                  TN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,p_cod_uso);

                  --
                  TN_dias := ge_fn_dias_hibernacion(p_cod_uso);

                  FOR cc IN numeros LOOP

                          IF LENGTH(cc.num_celular) = TO_NUMBER(TV_largo_celular) THEN
                            BEGIN
                                          SELECT fec_baja,  ind_equipado, cod_producto
                                          INTO v_fecha_baja, v_ind_equipado, v_cod_producto
                                          FROM AL_CELNUM_REUTIL
                                          WHERE cod_subalm =p_cod_subalm
                                          AND cod_producto = 1
                                          AND cod_central = p_cod_central
                                          AND cod_cat = p_cod_cat
                                          AND cod_uso IN (p_cod_uso,TN_uso_sin_uso)
                                          AND (fec_baja + TN_dias <= TRUNC(SYSDATE)
                                          OR  TN_dias   = CI_zero)
                                          AND ind_equipado = CI_cod_producto
                                          AND num_celular =cc.num_celular
                                          FOR UPDATE NOWAIT;

                                          AL_DESRESERVA_MASIVA_PR(cc.num_celular, p_cod_subalm, p_cod_central,p_cod_cat,p_cod_uso , v_cod_producto, v_fecha_baja, v_ind_equipado, p_num_sol ,p_tipo_proceso,TN_dias,TN_uso_sin_uso,v_cod_accion) ;
                        EXCEPTION
                                            WHEN NO_DATA_FOUND THEN
                                                  AL_GRABA_ERROR_RESERVA_PR(cc.num_celular,p_num_sol, 4);
                                                WHEN TOO_MANY_ROWS  THEN

                                                      AL_GRABA_ERROR_RESERVA_PR(cc.num_celular,p_num_sol, 3);
                                                WHEN OTHERS THEN

--                                                        RAISE_APPLICATION_ERROR(-20020, 'Error(AL_RESERVA_MASIVA_PR): PROBLEMAS CON PARAMETROS DE PROCESO');
                                  RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM)     ;
                            END;
                          ELSE
                                  AL_GRABA_ERROR_RESERVA_PR(cc.num_celular,p_num_sol, 2);
                          END IF;
                  END LOOP;
                  EXCEPTION WHEN OTHERS THEN
                  RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
  END    AL_VALIDA_DESRESERVA_PR;
  --
   PROCEDURE AL_GRABA_ERROR_RESERVA_PR (
          p_num_celular  IN ga_celnum_reutil.num_celular%TYPE,
      p_num_sol      IN al_reserva_to.num_solicitud%TYPE,
          p_cod_error    IN PLS_INTEGER) IS
          BEGIN
                  UPDATE al_numeros_temp_to
                  SET    cod_error = p_cod_error
                  WHERE  proc_invocador = 'RSV'
                  AND    num_celular = p_num_celular
                  AND    num_reserva = p_num_sol;
          END;
  --
  PROCEDURE AL_RESERVA_MASIVA_PR  (
      p_num_celular IN ga_celnum_reutil.num_celular%TYPE,
          p_cod_subalm  IN ga_celnum_reutil.cod_subalm%TYPE,
          p_cod_central IN ga_celnum_reutil.cod_central%TYPE,
          p_cod_cat     IN ga_celnum_reutil.cod_cat%TYPE,
          p_cod_uso     IN ga_celnum_reutil.cod_uso%TYPE,
          p_cod_producto IN ga_celnum_reutil.cod_producto%TYPE,
          v_fecha_baja   IN ga_celnum_reutil.fec_baja%TYPE,
      v_ind_equipado IN ga_celnum_reutil.ind_equipado%TYPE,
          p_num_sol     IN al_reserva_to.num_solicitud%TYPE,
          p_tipo_proceso IN al_reserva_to.tipo_proceso%TYPE,
      v_DiasHibernacion  IN al_usos.num_dias_hibernacion%TYPE,
      EN_uso_sin_uso      IN al_usos.cod_uso%TYPE,
          v_cod_accion       IN PLS_INTEGER
          )

  IS

  v_num_celular  ga_celnum_reutil.num_celular%TYPE;
  v_num_reserva  ga_celnum_reutil.num_celular%TYPE;
  v_cod_subalm   ga_celnum_reutil.cod_subalm%TYPE;
  v_cod_central  ga_celnum_reutil.cod_central%TYPE;
  v_cod_cat      ga_celnum_reutil.cod_cat%TYPE;
  v_cod_uso      ga_celnum_reutil.cod_uso%TYPE;
  v_cod_producto ga_celnum_reutil.cod_producto%TYPE;


  v_nro_valido PLS_INTEGER;

  v_audita_nro PLS_INTEGER;

  BEGIN
           v_nro_valido:=0;
                           v_nro_valido:= adn_numeracion_pg.adn_es_portado_in_fn(p_num_celular);

                           IF v_nro_valido=0 THEN
                              v_nro_valido:= adn_numeracion_pg.adn_es_nro_contaminado_fn(p_num_celular);
                          IF v_nro_valido=0 THEN

                                    INSERT INTO al_celnum_reutil (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado,num_proceso)
                            VALUES (p_num_celular,p_cod_subalm,p_cod_producto,p_cod_central,p_cod_cat,p_cod_uso,TRUNC(v_fecha_baja),v_ind_equipado,NULL);
                                        DELETE ga_celnum_reutil
                                        WHERE num_celular = p_num_celular;
                                 v_audita_nro:=al_genera_auditoria_fn(p_num_celular,p_cod_subalm,p_cod_central,p_cod_cat,p_cod_uso,TRUNC(v_fecha_baja),v_ind_equipado,p_cod_producto,p_num_sol,p_tipo_proceso,v_cod_accion);
                             IF v_audita_nro<>0 THEN
                                                RAISE_APPLICATION_ERROR(-20010, 'Error(AL_RESERVA_MASIVA_PR): PROBLEMAS AL GENERAR AUDITORIA - NUMERO:'|| TO_CHAR(p_num_celular) ||' SOLICITUD :'||TO_CHAR(p_num_sol));
                                         END IF;
                                  ELSE
                                       RAISE_APPLICATION_ERROR(-20011, 'Error(AL_RESERVA_MASIVA_PR): NUMERO ('|| TO_CHAR(p_num_celular) ||') NO SE ENCUENTRA COMO DISPONIBLE PARA RESERVA' );
                          END IF;
                           ELSE
                               RAISE_APPLICATION_ERROR(-20012, 'Error(AL_RESERVA_MASIVA_PR): NUMERO ('|| TO_CHAR(p_num_celular) ||') NO SE ENCUENTRA COMO DISPONIBLE PARA RESERVA' );
                           END IF;

   EXCEPTION
      WHEN OTHERS THEN
         IF (SQLCODE=-54 OR SQLCODE=-60) THEN
           RAISE_APPLICATION_ERROR(-20013, 'Error(AL_RESERVA_MASIVA_PR):NUMERO ('|| TO_CHAR(p_num_celular) ||') ESTA TOMADO POR OTRO USUARIO' );
                ELSE
                  RAISE_APPLICATION_ERROR (-20014,'Error(AL_RESERVA_MASIVA_PR):NUMERO ('|| TO_CHAR(p_num_celular) ||')' || TO_CHAR(SQLCODE) || ' ' || SQLERRM );
                END IF;

  END AL_RESERVA_MASIVA_PR ;
  --
  PROCEDURE AL_DESRESERVA_MASIVA_PR  (
      p_num_celular IN ga_celnum_reutil.num_celular%TYPE,
          p_cod_subalm  IN ga_celnum_reutil.cod_subalm%TYPE,
          p_cod_central IN ga_celnum_reutil.cod_central%TYPE,
          p_cod_cat     IN ga_celnum_reutil.cod_cat%TYPE,
          p_cod_uso     IN ga_celnum_reutil.cod_uso%TYPE,
          p_cod_producto IN ga_celnum_reutil.cod_producto%TYPE,
          v_fecha_baja   IN ga_celnum_reutil.fec_baja%TYPE,
      v_ind_equipado IN ga_celnum_reutil.ind_equipado%TYPE,
          p_num_sol     IN al_reserva_to.num_solicitud%TYPE,
          p_tipo_proceso IN al_reserva_to.tipo_proceso%TYPE,
      v_DiasHibernacion  IN al_usos.num_dias_hibernacion%TYPE,
      EN_uso_sin_uso      IN al_usos.cod_uso%TYPE,
          v_cod_accion       IN PLS_INTEGER
          )

  IS

  v_num_celular  ga_celnum_reutil.num_celular%TYPE;
  v_num_reserva  ga_celnum_reutil.num_celular%TYPE;
  v_cod_subalm   ga_celnum_reutil.cod_subalm%TYPE;
  v_cod_central  ga_celnum_reutil.cod_central%TYPE;
  v_cod_cat      ga_celnum_reutil.cod_cat%TYPE;
  v_cod_uso      ga_celnum_reutil.cod_uso%TYPE;
  v_cod_producto ga_celnum_reutil.cod_producto%TYPE;


  v_nro_valido PLS_INTEGER;

  v_audita_nro PLS_INTEGER;

  BEGIN
           v_nro_valido:=0;
                           v_nro_valido:= adn_numeracion_pg.adn_es_portado_in_fn(p_num_celular);

                           IF v_nro_valido=0 THEN
                              v_nro_valido:= adn_numeracion_pg.adn_es_nro_contaminado_fn(p_num_celular);
                          IF v_nro_valido=0 THEN
                                    INSERT INTO ga_celnum_reutil (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado,uso_anterior)
                            VALUES (p_num_celular,p_cod_subalm,p_cod_producto,p_cod_central,p_cod_cat,p_cod_uso,TRUNC(v_fecha_baja),v_ind_equipado,p_cod_uso);

                                         DELETE al_celnum_reutil
                     WHERE num_celular = p_num_celular;

                                 v_audita_nro:=al_genera_auditoria_fn(p_num_celular,p_cod_subalm,p_cod_central,p_cod_cat,p_cod_uso,TRUNC(v_fecha_baja),v_ind_equipado,p_cod_producto,p_num_sol,p_tipo_proceso,v_cod_accion);
                             IF v_audita_nro<>0 THEN
                                                RAISE_APPLICATION_ERROR(-20010, 'Error(AL_DESRESERVA_MASIVA_PR): PROBLEMAS AL GENERAR AUDITORIA - NUMERO:'|| TO_CHAR(p_num_celular) ||' SOLICITUD :'||TO_CHAR(p_num_sol));
                                         END IF;
                                  ELSE
                                       RAISE_APPLICATION_ERROR(-20011, 'Error(AL_DESRESERVA_MASIVA_PR): NUMERO ('|| TO_CHAR(p_num_celular) ||') NO SE ENCUENTRA COMO DISPONIBLE PARA RESERVA' );
                          END IF;
                           ELSE
                               RAISE_APPLICATION_ERROR(-20012, 'Error(AL_DESRESERVA_MASIVA_PR): NUMERO ('|| TO_CHAR(p_num_celular) ||') NO SE ENCUENTRA COMO DISPONIBLE PARA RESERVA' );
                           END IF;

   EXCEPTION
      WHEN OTHERS THEN
         IF (SQLCODE=-54 OR SQLCODE=-60) THEN
           RAISE_APPLICATION_ERROR(-20013, 'Error(AL_DESRESERVA_MASIVA_PR):NUMERO ('|| TO_CHAR(p_num_celular) ||') ESTA TOMADO POR OTRO USUARIO' );
                ELSE
                  RAISE_APPLICATION_ERROR (-20014,'Error(AL_DESRESERVA_MASIVA_PR):NUMERO ('|| TO_CHAR(p_num_celular) ||')' || TO_CHAR(SQLCODE) || ' ' || SQLERRM );
                END IF;

  END AL_DESRESERVA_MASIVA_PR ;

PROCEDURE AL_ASIGNA_NRO_ENTRADA_EXTRA_PR (
  EV_num_extra            IN al_ser_es_extras.num_extra%TYPE ,
  EN_linea                                IN al_ser_es_extras.num_linea%TYPE ,
  EV_subalm                       IN ge_subalms.cod_subalm%TYPE ,
  EN_central                      IN icg_central.cod_central%TYPE ,
  EN_uso                                  IN al_usos.cod_uso%TYPE ,
  EN_cat                                  IN ga_catnumer.cod_cat%TYPE ,
  SN_nro_reutil                   IN OUT NOCOPY PLS_INTEGER ,
  SV_error                                IN OUT NOCOPY PLS_INTEGER )
  IS
/*
        <Documentación TipoDoc = "PROCEDURE">
        <Elemento Nombre = "AL_ASIGNA_NRO_ENTRADA_EXTRA_PR" Lenguaje="PL/SQL" Fecha="10-06-2005" Versión="1.0.0" Diseñador="C.C.M." Programador="C.A.Z." Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripción>Asigna número telefono</Descripción>
        <Parámetros>
        <Entrada>
        <param nom="EV_num_extra" Tipo="al_ser_es_extras.num_extra%TYPE">"Número de orden de entrada extra"</param>
        <param nom="EN_linea" Tipo="al_ser_es_extras.num_linea%TYPE">"Número de línea detalle la orden"</param>
        <param nom="EV_subalm" Tipo="ge_subalms.cod_subalm%TYPE">"Código Sub. área local seleccionada obtener nro. celular"</param>
        <param nom="EN_central" Tipo="icg_central.cod_central%TYPE">"Código de Central seleccionada para obtener número celular"</param>
        <param nom="EN_uso" Tipo="al_usos.cod_uso%TYPE">"Código de uso asociado al número celular a obtener"</param>
        <param nom="EN_cat" Tipo="ga_catnumer.cod_cat%TYPE">"Código de categoria asociado al número celular  a obtener"</param>
        <param nom="SN_nro_reutil" Tipo="PLS_INTEGER">"Cantidad de números solicitados"</param>
        <param nom="SV_error" Tipo="PLS_INTEGER">"Código de error"</param>
        </Entrada>
        <Salida>
        <param nom="SN_nro_reutil" Tipo="PLS_INTEGER>Numero telefono</param>
        <param nom="SV_error" Tipo="PLS_INTEGER>Codigo de Error</param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
    */
    v_ind_equipado  ga_celnum_reutil.ind_equipado%TYPE;
    v_rownum        NUMBER(4);
    v_producto      ge_datosgener.prod_celular%TYPE;
    v_dias          al_usos.num_dias_hibernacion%TYPE;
    EN_uso_sin_uso   al_celnum_reutil.COD_USO%TYPE;
    CURSOR c_sernumera IS
           SELECT num_extra,num_linea,num_serie,ind_proceso,cap_code,num_telefono,num_seriemec,cod_central,cod_producto,cod_subalm,
                                  cod_cat,carga,a_key,chk_digits,num_sec_loca,num_sublock,cod_hlr
                     FROM al_ser_es_extras
            WHERE num_extra   = EV_num_extra
              AND num_linea   = EN_linea
              AND cod_subalm  = EV_subalm
              AND cod_central = EN_central
              AND cod_cat     = EN_cat
              AND num_telefono IS NULL
              FOR UPDATE OF num_telefono NOWAIT;

    CURSOR c_tel_libres(p_uso_sin_uso NUMBER) IS
           SELECT num_celular
            FROM al_celnum_reutil a
           WHERE cod_subalm        = EV_subalm
             AND cod_producto      = v_producto
             AND cod_central       = EN_central
             AND cod_cat           = EN_cat
             AND cod_uso      IN (EN_uso, p_uso_sin_uso)
             AND (fec_baja + v_dias <= TRUNC(SYSDATE) OR v_dias = 0)
--           C.A.A.D. 04-12-2006 REQ_35796 INICIO MODIFICACION
                   AND NOT EXISTS (SELECT 1 FROM al_series b WHERE b.num_telefono = a.num_celular)
             AND NOT EXISTS (SELECT 1 FROM ga_abocel c WHERE c.num_celular = a.num_celular AND c.cod_situacion NOT IN ('BAA', 'BAP'))
             AND NOT EXISTS (SELECT 1 FROM ga_aboamist d WHERE d.num_celular = a.num_celular AND d.cod_situacion  NOT IN ('BAA', 'BAP'))
--           C.A.A.D. 04-12-2006 REQ_35796 TERMINO MODIFICACION
             AND ind_equipado      = v_ind_equipado
             AND ROWNUM < v_rownum;
    v_sernumera   al_ser_es_extras%ROWTYPE;
    v_celular     al_celnum_reutil.num_celular%TYPE;
    EN_numero      al_ser_numeracion.num_telefono%TYPE;
    v_zero        NUMBER := 0;
    BEGIN
        v_ind_equipado := 1;
        v_rownum       := 11;
        p_select_celular (v_producto,
                          SV_error);
        BEGIN
           v_dias := ge_fn_dias_hibernacion(EN_uso);
                   EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
           EXCEPTION
                     WHEN OTHERS THEN
                        SV_error := 1;
        END;
        IF SV_error = 0 THEN
           OPEN c_sernumera;
           LOOP
           FETCH c_sernumera INTO v_sernumera;
           EXIT WHEN c_sernumera%NOTFOUND;
           -- Nos han quitado un numero, y ademas este era el ultimo reutilizable,
           -- mientras estabamos procesando!!
           EN_numero := NULL;
           IF SN_nro_reutil > 0 THEN
              OPEN c_tel_libres(EN_uso_sin_uso);
              LOOP
              FETCH c_tel_libres
               INTO v_celular;
                  IF c_tel_libres%NOTFOUND THEN
                     SN_nro_reutil := 0;
                     CLOSE c_tel_libres;
                  END IF;
                  BEGIN
                     EN_numero := NULL;
                     SELECT num_celular
                       INTO EN_numero
                       FROM al_celnum_reutil
                      WHERE num_celular = v_celular
                        FOR UPDATE NOWAIT;
                        -- si estaba bloqueado salta la excepcion y busca otro numero
                           SN_nro_reutil := SN_nro_reutil -1;
                           DELETE al_celnum_reutil
                            WHERE num_celular = v_celular;
                           EXIT;
                           EXCEPTION
                              WHEN NO_DATA_FOUND THEN
                                 NULL;
                              WHEN OTHERS THEN
                                 IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                                 -- Vamos a por otro numero de telefono
                                    NULL;
                                 ELSE
                                    RAISE;
                                 END IF;
                  END;
              END LOOP;
           END IF;
     -- ahora update al_ser_numeracion y activacion
           IF EN_numero IS NOT NULL THEN
              UPDATE al_ser_es_extras
                 SET num_telefono = EN_numero
               WHERE CURRENT OF c_sernumera;
           ELSE
              SV_error:=1;
              EXIT;  -- del LOOP principal
           END IF;
           IF c_tel_libres%ISOPEN  THEN
              CLOSE c_tel_libres;
           END IF;
           IF SV_error = 7 THEN
              RAISE_APPLICATION_ERROR (-20175,' ');
           END IF;
           END LOOP;
           CLOSE c_sernumera;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
             IF SV_error = 7 THEN
                   RAISE_APPLICATION_ERROR (-20175, 'Error Creacion Mvto. Activacion');
                 ELSE
                        SV_error := 1;
              END IF;
END AL_ASIGNA_NRO_ENTRADA_EXTRA_PR;

PROCEDURE AL_HAY_NUMERO_ENTRADA_EXTRA_PR(
  EV_subalm   IN ge_subalms.cod_subalm%TYPE ,
  EN_central  IN icg_central.cod_central%TYPE ,
  EN_uso      IN al_usos.cod_uso%TYPE ,
  EN_can      IN al_lineas_ordenes1.can_orden%TYPE ,
  EN_cat      IN ga_catnumer.cod_cat%TYPE
 )
IS
/*
        <Documentación TipoDoc = "PROCEDURE">
        <Elemento Nombre = "AL_HAY_NUMERO_ENTRADA_EXTRA_PR" Lenguaje="PL/SQL" Fecha="10-06-2005" Versión="1.0.0" Diseñador="C.C.M." Programador="C.A.Z." Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripción>Consulta si hay números para utilizar</Descripción>
        <Parámetros>
        <Entrada>
        <param nom="EV_subalm" Tipo="ge_subalms.cod_subalm%TYPE">"Código Sub. área local seleccionada obtener nro. celular"</param>
        <param nom="EN_central" Tipo="icg_central.cod_central%TYPE">"Código de Central seleccionada para obtener número celular"</param>
        <param nom="EN_uso" Tipo="al_usos.cod_uso%TYPE">"Código de uso asociado al número celular a obtener"</param>
        <param nom="EN_can" Tipo="al_lineas_ordenes1.can_orden%TYPE">"Cantidad de números de celular solicitados"</param>
        <param nom="EN_cat" Tipo="ga_catnumer.cod_cat%TYPE">"Código de categoria asociado al número celular  a obtener"</param>
        </Entrada>
        <Salida>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
    */
  SV_error      PLS_INTEGER := 0;
  SN_nro_reutil PLS_INTEGER := 0;
BEGIN
         p_hay_numeros_al (EV_subalm,
                           EN_central,
                           EN_uso,
                           EN_can,
                           SN_nro_reutil,
                           EN_cat,
                           SV_error);
     IF SV_error > 0 THEN
        RAISE_APPLICATION_ERROR (-20123,'');
     END IF;

END AL_HAY_NUMERO_ENTRADA_EXTRA_PR;


PROCEDURE AL_UN_NRO_ENTRADA_EXTRA_PR(
  EV_subalm  IN al_series.cod_subalm%TYPE ,
  EN_central IN al_series.cod_central%TYPE ,
  EN_uso     IN al_series.cod_uso%TYPE ,
  EN_cat     IN al_series.cod_cat%TYPE ,
  EN_numero  IN OUT NOCOPY al_series.num_telefono%TYPE)
  IS
  /*
        <Documentación TipoDoc = "PROCEDURE">
        <Elemento Nombre = "AL_UN_NRO_ENTRADA_EXTRA_PR" Lenguaje="PL/SQL" Fecha="10-06-2005" Versión="1.0.0" Diseñador="C.C.M." Programador="C.A.Z." Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripción>Busca un número de telefono</Descripción>
        <Parámetros>
        <Entrada>
        <param nom="EV_subalm" Tipo="ge_subalms.cod_subalm%TYPE">"Código Sub. área local seleccionada obtener nro. celular"</param>
        <param nom="EN_central" Tipo="icg_central.cod_central%TYPE">"Código de Central seleccionada para obtener número celular"</param>
        <param nom="EN_uso" Tipo="al_usos.cod_uso%TYPE">"Código de uso asociado al número celular a obtener"</param>
        <param nom="EN_cat" Tipo="ga_catnumer.cod_cat%TYPE">"Código de categoria asociado al número celular  a obtener"</param>
        <param nom="EN_numero" Tipo="al_series.num_telefono%TYPE">"Número de celular "</param>
        </Entrada>
        <Salida>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
    */
            v_producto     ge_datosgener.prod_celular%TYPE;
            v_dias         al_usos.num_dias_hibernacion%TYPE;
            v_rowid        ROWID;
            v_nro_uso      NUMBER := 0;
            SN_nro_reutil   NUMBER := 0;
            v_hasta        ga_celnum_uso.num_hasta%TYPE;
            SV_error        NUMBER(1) := 0;
            v_celular      ga_celnum_reutil.num_celular%TYPE;
            v_cel_uso      ga_celnum_uso%ROWTYPE;
            v_num_libres   ga_celnum_uso.num_libres%TYPE;
            v_ind_equipado ga_celnum_reutil.ind_equipado%TYPE;
            v_rownum       NUMBER(4);
                        EN_uso_sin_uso  ga_celnum_reutil.COD_USO%TYPE;
            CURSOR c_cel_reutil(p_uso_sin_uso NUMBER)  IS
            SELECT num_celular
              FROM al_celnum_reutil
             WHERE cod_subalm    = EV_subalm
               AND cod_producto  = v_producto
               AND cod_central   = EN_central
               AND cod_cat       = EN_cat
               AND cod_uso      IN (EN_uso, p_uso_sin_uso)
               AND (fec_baja + v_dias <= TRUNC(SYSDATE)
                                OR v_dias = 0)
               AND ind_equipado = v_ind_equipado
               AND ROWNUM < v_rownum ORDER BY num_celular;

            CURSOR c_cel_uso(p_uso_sin_uso NUMBER) IS
            SELECT * FROM ga_celnum_uso
             WHERE cod_subalm    = EV_subalm
               AND cod_producto  = v_producto
               AND cod_central   = EN_central
               AND cod_cat       = EN_cat
               AND cod_uso      IN (EN_uso, p_uso_sin_uso)
               AND num_libres > v_num_libres
               AND ROWNUM < v_rownum
             ORDER BY num_desde;
  BEGIN
      EN_numero:=0;
      v_ind_equipado := 1;
      v_rownum := 21;
      v_num_libres := 0;
      p_select_celular (v_producto,SV_error);
      IF SV_error = 0 THEN
         p_cuenta_reutil (EV_subalm,v_producto,EN_central,
                          EN_cat,EN_uso,SN_nro_reutil);
         IF SN_nro_reutil > 0 THEN
            BEGIN
               v_dias := ge_fn_dias_hibernacion(EN_uso);
                           EN_uso_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
            EXCEPTION
                   WHEN OTHERS THEN
                         SV_error := 1;
            END;

            IF SV_error = 0 THEN

                        OPEN c_cel_reutil(EN_uso_sin_uso);
            LOOP
               FETCH c_cel_reutil INTO v_celular;
               EXIT WHEN c_cel_reutil%NOTFOUND;
               BEGIN
                  SELECT num_celular
                    INTO EN_numero
                    FROM al_celnum_reutil
                   WHERE num_celular = v_celular FOR UPDATE NOWAIT;
                  SN_nro_reutil := SN_nro_reutil -1;
                  DELETE al_celnum_reutil WHERE num_celular = v_celular;
                  EXIT;
                  EXCEPTION
                             WHEN NO_DATA_FOUND THEN
                                        NULL;

                    WHEN OTHERS THEN
                        IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                           NULL;
                        ELSE
                           RAISE;
                        END IF;
               END;
            END LOOP;
            CLOSE c_cel_reutil;
            ELSE
               RAISE_APPLICATION_ERROR (-20120,'' || TO_CHAR(SQLCODE));
            END IF;
         ELSE
            p_cuenta_uso (EV_subalm,v_producto,EN_central,EN_cat,EN_uso,v_nro_uso);
            IF v_nro_uso > 0 THEN
               OPEN c_cel_uso(EN_uso_sin_uso);
               LOOP
               FETCH c_cel_uso INTO v_cel_uso;
               EXIT WHEN c_cel_uso%NOTFOUND;
               BEGIN
                  SELECT num_siguiente,ROWID,num_hasta
                    INTO EN_numero,v_rowid,v_hasta
                    FROM ga_celnum_uso
                   WHERE num_desde = v_cel_uso.num_desde
                   ORDER BY num_desde
                   FOR UPDATE OF num_siguiente, num_libres NOWAIT;
                  IF v_hasta = EN_numero THEN
                     UPDATE ga_celnum_uso SET num_libres = 0
                      WHERE ROWID = v_rowid;
                  ELSE
                     UPDATE ga_celnum_uso
                        SET num_siguiente = num_siguiente +1,
                            num_libres = num_libres -1
                      WHERE ROWID = v_rowid;
                  END IF;
                  EXIT;
                  EXCEPTION
                              WHEN NO_DATA_FOUND THEN
                                        NULL;
                     WHEN OTHERS THEN
                     IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                        NULL;
                     ELSE
                        RAISE;
            END IF;
            END;
            END LOOP;
            CLOSE c_cel_uso;
         ELSE
            RAISE_APPLICATION_ERROR (-20120,'' || TO_CHAR(SQLCODE));
            -- Error Controlado en VB (NO HAY NUMERACION)
         END IF;
      END IF;
      IF EN_numero=0 THEN
         RAISE_APPLICATION_ERROR (-20120,'--' || TO_CHAR(SQLCODE));
      END IF;
      END IF;
      EXCEPTION
      WHEN OTHERS THEN
             IF SQLCODE <> -20120 THEN
                RAISE_APPLICATION_ERROR (-20123,'');
             ELSE
                RAISE_APPLICATION_ERROR (-20120,'');
             END IF;
    -- Error Controlado en VB (ERROR ASIGNACION NUMERACION)
  END AL_UN_NRO_ENTRADA_EXTRA_PR;

PROCEDURE AL_ASIGNA_NUMERO_EXTRA_PR(
  EN_interfaz IN al_inter_vbpl.num_interfaz%TYPE,
  EV_subalm     IN al_series.cod_subalm%TYPE ,
  EN_central  IN al_series.cod_central%TYPE ,
  EN_uso      IN al_series.cod_uso%TYPE ,
  EN_cat      IN al_series.cod_cat%TYPE )
IS
/*
        <Documentación TipoDoc = "PROCEDURE">
        <Elemento Nombre = "AL_ASIGNA_NUMERO_EXTRA_PR" Lenguaje="PL/SQL" Fecha="10-06-2005" Versión="1.0.0" Diseñador="C.C.M." Programador="C.A.Z." Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripción>Asigna número telefono</Descripción>
        <Parámetros>
        <Entrada>
        <param nom="EN_interfaz_x  " Tipo="char">"nro. de secuencia oracle para id. número"</param>
        <param nom="EV_subalm      " Tipo="char">"Código Sub. área local seleccionada     "</param>
        <param nom="EN_central_x   " Tipo="char">"Código de Central seleccionada para obtener núemro celular"</param>
        <param nom="EN_uso_x       " Tipo="char">"Código de uso asociado al número celular a obtener"</param>
        <param nom="EN_cat_x       " Tipo="char">"Código de categoria del número celular  a obtener"</param>
        </Entrada>
        <Salida>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
    */
        EN_numero al_series.num_telefono%TYPE;
BEGIN

  AL_UN_NRO_ENTRADA_EXTRA_PR (EV_subalm,
                                        EN_central,
                                        EN_uso,
                                        EN_cat,
                                        EN_numero);
  P_UPD_INTERVBPL(EN_interfaz,
                                    EN_numero);

END AL_ASIGNA_NUMERO_EXTRA_PR;

PROCEDURE p_audit_insert_celnumuso(v_audit_ser_to IN OUT al_audit_celnum_uso_to%ROWTYPE )
IS
PRAGMA AUTONOMOUS_TRANSACTION;
    SV_error         NUMBER(1) :=0;
    v_audit_username    al_audit_celnum_uso_to.cod_usuario%type ;
    v_audit_osuser      al_audit_celnum_uso_to.cod_osusuario%type ;
    v_audit_program     al_audit_celnum_uso_to.des_program%type ;
    v_audit_module      al_audit_celnum_uso_to.des_modulo%type ;
    v_audit_logon_time  al_audit_celnum_uso_to.fec_login%type ;
   
BEGIN

 select username, osuser, program, module, logon_time
    into   v_audit_username,
           v_audit_osuser,
           v_audit_program,
           v_audit_module,
           v_audit_logon_time
    from   v$session
    where  audsid = userenv('sessionid');

        v_audit_ser_to.des_modulo        := v_audit_module;
        v_audit_ser_to.cod_usuario       := v_audit_username;
        v_audit_ser_to.cod_osusuario     := v_audit_osuser;
        v_audit_ser_to.des_program       := v_audit_program;
        v_audit_ser_to.fec_login         := v_audit_logon_time;

        insert into al_audit_celnum_uso_to
        (DES_MODULO,
        COD_USUARIO,
        COD_OSUSUARIO,
        DES_PROGRAM,
        FEC_LOGIN,
        NUM_DESDE,
        NUM_HASTA,
        NUM_LIBRES_ORI,
        NUM_SIGUIENTE_ORI,
        NUM_LIBRES_DES,
        NUM_SIGUIENTE_DES,
        COD_OPERACION,
        FEC_OPERACION,
        COD_SUBALM,
        COD_PRODUCTO,
        COD_CENTRAL,
        COD_CAT,
        COD_USO,
        IND_CONTAMINADO,
        COD_SUBALM_OLD,
        COD_PRODUCTO_OLD,
        COD_CENTRAL_OLD,
        COD_CAT_OLD,
        COD_USO_OLD,
        IND_CONTAMINADO_OLD
        )
        values
        (v_audit_ser_to.des_modulo,
        v_audit_ser_to.cod_usuario,
        v_audit_ser_to.cod_osusuario,
        v_audit_ser_to.des_program,
        v_audit_ser_to.fec_login,
        v_audit_ser_to.num_desde,
        v_audit_ser_to.num_hasta,
        v_audit_ser_to.num_libres_ori,
        v_audit_ser_to.num_siguiente_ori,
        v_audit_ser_to.num_libres_des,
        v_audit_ser_to.num_siguiente_des,
        v_audit_ser_to.cod_operacion,
        v_audit_ser_to.fec_operacion,
        v_audit_ser_to.cod_subalm,
        v_audit_ser_to.cod_producto,
        v_audit_ser_to.cod_central,
        v_audit_ser_to.cod_cat,
        v_audit_ser_to.cod_uso,
        v_audit_ser_to.ind_contaminado,
        v_audit_ser_to.cod_subalm_old,
        v_audit_ser_to.cod_producto_old,
        v_audit_ser_to.cod_central_old,
        v_audit_ser_to.cod_cat_old,
        v_audit_ser_to.cod_uso_old,
        v_audit_ser_to.ind_contaminado_old
        );
        COMMIT;

        EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20142, 'Error al insertar al_audit_celnum_uso_to ' );
        ROLLBACK;

END p_audit_insert_celnumuso;

PROCEDURE p_audit_insert_celnumreutil(v_audit_ser_to IN OUT al_audit_celnum_reutil_to%ROWTYPE )
IS
PRAGMA AUTONOMOUS_TRANSACTION;
   SV_error         NUMBER(1) :=0;
    v_audit_username    al_audit_celnum_reutil_to.cod_usuario%type ;
    v_audit_osuser      al_audit_celnum_reutil_to.cod_osusuario%type ;
    v_audit_program     al_audit_celnum_reutil_to.des_program%type ;
    v_audit_module      al_audit_celnum_reutil_to.des_modulo%type ;
    v_audit_logon_time  al_audit_celnum_reutil_to.fec_login%type ;

    LV_Code                                   VARCHAR2(100);    
    LV_Estado                              VARCHAR2(1);   
    LV_Errm                                   VARCHAR2(2000);

    BEGIN

    select username, osuser, program, module, logon_time
    into   v_audit_username,
           v_audit_osuser,
           v_audit_program,
           v_audit_module,
           v_audit_logon_time
    from   v$session
    where  audsid = userenv('sessionid');

        v_audit_ser_to.des_modulo        := v_audit_module;
        v_audit_ser_to.cod_usuario       := v_audit_username;
        v_audit_ser_to.cod_osusuario     := v_audit_osuser;
        v_audit_ser_to.des_program       := v_audit_program;
        v_audit_ser_to.fec_login         := v_audit_logon_time;

        if (v_audit_ser_to.num_celular is not null) then

        insert into al_audit_celnum_reutil_to
        (DES_MODULO,
        COD_USUARIO,
        COD_OSUSUARIO,
        DES_PROGRAM,
        FEC_LOGIN,
        NOM_TABLA,
        COD_OPERACION,
        FEC_OPERACION,
        NUM_CELULAR_OLD,
        COD_SUBALM_OLD,
        COD_PRODUCTO_OLD,
        COD_CENTRAL_OLD,
        COD_CAT_OLD,
        COD_USO_OLD,
        FEC_BAJA_OLD,
        IND_EQUIPADO_OLD,
        USO_ANTERIOR_OLD,
        NUM_PROCESO_OLD,
        NUM_CELULAR,
        COD_SUBALM,
        COD_PRODUCTO,
        COD_CENTRAL,
        COD_CAT,
        COD_USO,
        FEC_BAJA,
        IND_EQUIPADO,
        USO_ANTERIOR,
        NUM_PROCESO
        )
        values
        (v_audit_ser_to.des_modulo,
        v_audit_ser_to.cod_usuario,
        v_audit_ser_to.cod_osusuario,
        v_audit_ser_to.des_program,
        v_audit_ser_to.fec_login,
        v_audit_ser_to.nom_tabla,
        v_audit_ser_to.cod_operacion,
        v_audit_ser_to.fec_operacion,
        v_audit_ser_to.num_celular_old ,
        v_audit_ser_to.COD_SUBALM_old ,
        v_audit_ser_to.cod_producto_old  ,
        v_audit_ser_to.cod_central_old  ,
        v_audit_ser_to.cod_cat_old  ,
        v_audit_ser_to.cod_uso_old  ,
        v_audit_ser_to.fec_baja_old  ,
        v_audit_ser_to.ind_equipado_old  ,
        v_audit_ser_to.uso_anterior_old ,
        v_audit_ser_to.num_proceso_old ,
        v_audit_ser_to.num_celular ,
        v_audit_ser_to.COD_SUBALM ,
        v_audit_ser_to.cod_producto  ,
        v_audit_ser_to.cod_central  ,
        v_audit_ser_to.cod_cat  ,
        v_audit_ser_to.cod_uso  ,
        v_audit_ser_to.fec_baja  ,
        v_audit_ser_to.ind_equipado  ,
        v_audit_ser_to.uso_anterior ,
        v_audit_ser_to.num_proceso
        );
        
        end if;

        COMMIT;

        EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        if (v_audit_ser_to.num_celular is not null) then

          LV_Errm := sqlcode || ' -- ' || sqlerrm;
          pv_general_ooss_pg.pv_audreg_pr ( 'AL', 99999999, 1, '1', NULL , 'CR', NULL , NULL, 
          'AL_PAC_NUMERACION SALIDA 1'|| ' * PROCESO 1 Celular ' || v_audit_ser_to.num_celular || ' | '|| v_audit_ser_to.cod_usuario || ' | ' || v_audit_ser_to.cod_osusuario || ' | ' || v_audit_ser_to.num_celular_old || ' | ' || v_audit_ser_to.des_program || ' | ' || v_audit_ser_to.nom_tabla || ' | ' || v_audit_ser_to.cod_operacion || ' | ' || sys_context('USERENV','HOST') || ' ** ' ||  sqlcode || ' -- ' || sqlerrm, 
          NULL , NULL , NULL , 0, NULL , NULL , 0, LV_Estado, LV_Code    , LV_Errm );  
          
                insert into al_audit_celnum_reutil_to
                (DES_MODULO,
                COD_USUARIO,
                COD_OSUSUARIO,
                DES_PROGRAM,
                FEC_LOGIN,
                NOM_TABLA,
                COD_OPERACION,
                FEC_OPERACION,
                NUM_CELULAR_OLD,
                COD_SUBALM_OLD,
                COD_PRODUCTO_OLD,
                COD_CENTRAL_OLD,
                COD_CAT_OLD,
                COD_USO_OLD,
                FEC_BAJA_OLD,
                IND_EQUIPADO_OLD,
                USO_ANTERIOR_OLD,
                NUM_PROCESO_OLD,
                NUM_CELULAR,
                COD_SUBALM,
                COD_PRODUCTO,
                COD_CENTRAL,
                COD_CAT,
                COD_USO,
                FEC_BAJA,
                IND_EQUIPADO,
                USO_ANTERIOR,
                NUM_PROCESO
                )
                values
                (v_audit_ser_to.des_modulo,
                v_audit_ser_to.cod_usuario,
                v_audit_ser_to.cod_osusuario,
                v_audit_ser_to.des_program,
                v_audit_ser_to.fec_login,
                v_audit_ser_to.nom_tabla,
                v_audit_ser_to.cod_operacion,
                v_audit_ser_to.fec_operacion + 1/86400,
                v_audit_ser_to.num_celular_old ,
                v_audit_ser_to.COD_SUBALM_old ,
                v_audit_ser_to.cod_producto_old  ,
                v_audit_ser_to.cod_central_old  ,
                v_audit_ser_to.cod_cat_old  ,
                v_audit_ser_to.cod_uso_old  ,
                v_audit_ser_to.fec_baja_old  ,
                v_audit_ser_to.ind_equipado_old  ,
                v_audit_ser_to.uso_anterior_old ,
                v_audit_ser_to.num_proceso_old ,
                v_audit_ser_to.num_celular ,
                v_audit_ser_to.COD_SUBALM ,
                v_audit_ser_to.cod_producto  ,
                v_audit_ser_to.cod_central  ,
                v_audit_ser_to.cod_cat  ,
                v_audit_ser_to.cod_uso  ,
                v_audit_ser_to.fec_baja  ,
                v_audit_ser_to.ind_equipado  ,
                v_audit_ser_to.uso_anterior ,
                v_audit_ser_to.num_proceso);
                
        END IF;
        COMMIT;      
          
        WHEN OTHERS THEN
          LV_Errm := sqlcode || ' -- ' || sqlerrm;
          pv_general_ooss_pg.pv_audreg_pr ( 'AL', 99999999, 1, '1', NULL , 'CR', NULL , NULL, 
          'AL_PAC_NUMERACION SALIDA 1.1'|| ' * PROCESO 1 Celular ' || v_audit_ser_to.num_celular || ' | '|| v_audit_ser_to.cod_usuario || ' | ' || v_audit_ser_to.cod_osusuario || ' | ' || v_audit_ser_to.num_celular_old || ' | ' || v_audit_ser_to.des_program || ' | ' || v_audit_ser_to.nom_tabla || ' | ' || v_audit_ser_to.cod_operacion || ' | ' || sys_context('USERENV','HOST') || ' ** ' ||  sqlcode || ' -- ' || sqlerrm, 
          NULL , NULL , NULL , 0, NULL , NULL , 0, LV_Estado, LV_Code    , LV_Errm ); 
                  
          RAISE_APPLICATION_ERROR(-20142, 'Error al insertar al_audit_celnum_reutil_to ' );
          ROLLBACK;
  END;

END Al_Pac_Numeracion;
/
