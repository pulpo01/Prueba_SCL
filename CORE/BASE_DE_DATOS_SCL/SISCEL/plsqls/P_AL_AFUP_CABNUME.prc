CREATE OR REPLACE PROCEDURE P_AL_AFUP_CABNUME
(
   v_num_numeracion IN CHAR
)
IS
 v_aux_numeracion   al_cab_numeracion.num_numeracion%TYPE;
    CURSOR c_sernume IS
        SELECT a.*, b.cod_tecnologia
          FROM al_ser_numeracion a, icg_central b
         WHERE a.num_numeracion = v_aux_numeracion
           AND a.cod_central    =  b.cod_central;

    v_serie                  al_ser_numeracion%ROWTYPE;
    v_reutil                 ga_celnum_reutil%ROWTYPE;
    v_tiponume               al_cab_numeracion.tip_numeracion%TYPE;
    v_ind_telefono           al_series.ind_telefono%TYPE;

    v_actuacion_des          ga_actabo.cod_actcen%TYPE;
    v_actuacion_res          ga_actabo.cod_actcen%TYPE;
    v_actuacion_act          ga_actabo.cod_actcen%TYPE;
    v_actuacion_act_gsm      ga_actabo.cod_actcen%TYPE;
    v_actuacion_ami          ga_actabo.cod_actcen%TYPE;
    v_actuacion_res_ami      ga_actabo.cod_actcen%TYPE;
    /*JLA*/
    v_actuacion_des_gsm_ami  ga_actabo.cod_actcen%TYPE;
    v_actuacion_des_gsm      ga_actabo.cod_actcen%TYPE;
    v_actuacion_res_gsm_ami  ga_actabo.cod_actcen%TYPE;
    v_actuacion_res_gsm      ga_actabo.cod_actcen%TYPE;
    v_actuacion_gsm_ami      ga_actabo.cod_actcen%TYPE;

   --Variable de paso
    v_actuacion_ami_aux      ga_actabo.cod_actcen%TYPE;
    v_actuacion_aux          ga_actabo.cod_actcen%TYPE;
    v_terminal_simcard       ged_parametros.val_parametro%TYPE;
        /*JLA */
    v_terminal               al_tipos_terminales.tip_terminal%TYPE;
    v_cod_articulo           al_lin_numeracion.cod_articulo%TYPE;
    v_cod_uso                al_lin_numeracion.cod_uso%TYPE;
    v_error                  NUMBER;
    v_prefijo                      al_usos_min.num_min%TYPE;
    v_cabnume                  al_cab_numeracion%ROWTYPE;
    v_cod_uso_ami            al_usos.cod_uso%TYPE;
    v_actuacion_des_ami      ga_actabo.cod_actcen%TYPE;
    v_central                icg_central.cod_central%TYPE;
    v_tecnologia_aux         al_tecnologia.cod_tecnologia%TYPE :=' ';
    -- INICIO INCIDENCIA XO-200509190694 C.C.A 20-09-2005
    v_existe                 NUMBER(1);
    -- FIN INCIDENCIA XO-200509190694 C.C.A 20-09-2005
---
    CN_modulo      CONSTANT VARCHAR2(2):='AL';
    CN_prOducto    CONSTANT NUMBER(1):=1;
    CN_llamada_libre     CONSTANT    NUMBER(1):=1;

    v_actabo_mi             VARCHAR2(2):= 'MI';
    v_actabo_ar             VARCHAR2(2):= 'AR';
    v_actabo_aa             VARCHAR2(2):= 'AA';
    v_actabo_ag             VARCHAR2(2):= 'AG';
    v_actabo_mm             VARCHAR2(2):= 'MM';
    v_actabo_ra             VARCHAR2(2):= 'RA';
    v_actabo_da             VARCHAR2(2):= 'DA';
    v_actabo_gm             VARCHAR2(2):= 'GM';
    v_actabo_dg             VARCHAR2(2):= 'DG';
    v_actabo_rm             VARCHAR2(2):= 'RM';
    v_actabo_rg             VARCHAR2(2):= 'RG';
    v_actabo_ga             VARCHAR2(2):= 'GA';
    
    v_codactabo_chip         ged_parametros.val_parametro%type;
    v_codactuacion_chip      ged_parametros.val_parametro%type;
    v_aplicachip             ged_parametros.val_parametro%type;
       
    
BEGIN


   --RECUPERAR EL TIPO TERMINAL ASOCIADO A UNA SIMCARD
          SELECT val_parametro
            INTO v_terminal_simcard
            FROM ged_parametros
           WHERE nom_parametro = 'COD_SIMCARD_GSM'
             AND cod_modulo ='AL'
             AND cod_producto = 1;

      v_aux_numeracion := TO_NUMBER(v_num_numeracion);
      SELECT num_numeracion,cod_bodega,tip_numeracion,fec_cierre,usu_cierre,des_observaciones,cod_estado,tip_llamada
        INTO v_cabnume.num_numeracion,v_cabnume.cod_bodega,v_cabnume.tip_numeracion,
             v_cabnume.fec_cierre,v_cabnume.usu_cierre,v_cabnume.des_observaciones,
             v_cabnume.cod_estado,v_cabnume.tip_llamada
        FROM al_cab_numeracion WHERE num_numeracion=v_aux_numeracion;
        IF v_cabnume.cod_estado<>'CE' THEN
                RAISE_APPLICATION_ERROR (-20140,'');
        END IF;


    ---Inicio 123235
    v_codactabo_chip:=null;
    v_codactuacion_chip:=null;
    v_aplicachip:=null;
    if trim(v_cabnume.tip_llamada) is not null and trim(v_cabnume.tip_llamada)= CN_llamada_libre then
        begin
            select trim(val_parametro)  into v_aplicachip
              from ged_parametros
             where  nom_parametro = 'NUMERA_APLICACHIP' AND cod_modulo='AL' AND cod_producto=1;
        exception
        when others then
             v_aplicachip:=null;
        end; 
        
        if v_aplicachip='S' then
            begin
                select trim(val_parametro)  into v_codactuacion_chip
                  from ged_parametros
                 where  nom_parametro = 'NUMERA_ACTUACIONCHIP' AND cod_modulo='AL' AND cod_producto=1;
            exception
            when others then
                 v_codactuacion_chip:=null;
            end;     

            begin
                select trim(val_parametro)  into v_codactabo_chip
                  from ged_parametros
                 where  nom_parametro = 'NUMERA_ACTABOCHIP' AND cod_modulo='AL' AND cod_producto=1;
            exception
            when others then
                v_codactabo_chip:=null;
            end;     
        end if;
    end if;
   ---Fin 123235       



       SELECT cod_uso_ami
         INTO v_cod_uso_ami
         FROM al_datos_generales;

--***************************************************************
       v_tiponume:= v_cabnume.tip_numeracion;

       FOR v_serie IN c_sernume LOOP

         IF  v_tecnologia_aux <> v_serie.cod_tecnologia THEN
             v_tecnologia_aux:= v_serie.cod_tecnologia;
             -- Selecciono actuaciones
                BEGIN
                 SELECT cod_actcen
                   INTO v_actuacion_des
                   FROM ga_actabo
                  WHERE cod_modulo     = CN_modulo
                    AND cod_producto   = CN_producto
                    AND cod_tecnologia = v_serie.cod_tecnologia
                    AND cod_actabo     = v_actabo_mi;
              EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                        v_actuacion_des := null;
                END;
               BEGIN
                SELECT cod_actcen
                  INTO v_actuacion_res
                  FROM ga_actabo
                 WHERE cod_modulo     = CN_modulo
                   AND cod_producto   = CN_producto
                   AND cod_tecnologia = v_serie.cod_tecnologia
                   AND cod_actabo     = v_actabo_ar ;
               EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         v_actuacion_res := null;
                END;
               BEGIN
                 SELECT cod_actcen
                   INTO v_actuacion_act
                   FROM ga_actabo
                  WHERE cod_modulo     = CN_modulo
                    AND cod_producto   = CN_producto
                    AND cod_tecnologia = v_serie.cod_tecnologia
                    AND cod_actabo     = v_actabo_aa;
               EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                          v_actuacion_act := null;
                END;
                BEGIN
                 SELECT cod_actcen
                   INTO v_actuacion_act_gsm
                   FROM ga_actabo
                  WHERE cod_modulo     = CN_modulo
                    AND cod_producto   = CN_producto
                    AND cod_tecnologia = v_serie.cod_tecnologia
                    AND cod_actabo     = v_actabo_ag;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                          v_actuacion_act_gsm := null;
                END;
               BEGIN
                SELECT cod_actcen
                  INTO v_actuacion_ami
                  FROM ga_actabo
                 WHERE cod_modulo     = CN_modulo
                   AND cod_producto   = CN_producto
                   AND cod_tecnologia = v_serie.cod_tecnologia
                   AND cod_actabo     = v_actabo_mm;
               EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                        v_actuacion_ami := null;
                END;
               BEGIN
                SELECT cod_actcen
                  INTO v_actuacion_res_ami
                  FROM ga_actabo
                 WHERE cod_modulo     = CN_modulo
                   AND cod_producto   = CN_producto
                       AND cod_tecnologia = v_serie.cod_tecnologia
                   AND cod_actabo     = v_actabo_ra;
               EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         v_actuacion_res_ami := null;
                END;
               BEGIN
                 SELECT cod_actcen
                   INTO v_actuacion_des_ami
                   FROM ga_actabo
                  WHERE cod_modulo     = CN_modulo
                    AND cod_producto   = CN_producto
                        AND cod_tecnologia = v_serie.cod_tecnologia
                    AND cod_actabo     = v_actabo_da;
                EXCEPTION
                     WHEN NO_DATA_FOUND THEN
                          v_actuacion_des_ami := null;
                END;
               BEGIN
                 SELECT cod_actcen
                   INTO v_actuacion_des_gsm_ami
                   FROM ga_actabo
                  WHERE cod_modulo     = CN_modulo
                    AND cod_producto   = CN_producto
                        AND cod_tecnologia = v_serie.cod_tecnologia
                    AND cod_actabo     = v_actabo_gm;
               EXCEPTION
                     WHEN NO_DATA_FOUND THEN
                      v_actuacion_des_gsm_ami := null;
               END;
               BEGIN
                 SELECT cod_actcen
                   INTO v_actuacion_des_gsm
                   FROM ga_actabo
                  WHERE cod_modulo     = CN_modulo
                    AND cod_producto   = CN_producto
                        AND cod_tecnologia = v_serie.cod_tecnologia
                    AND cod_actabo     = v_actabo_dg;
               EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         v_actuacion_des_gsm := null;
               END;
               BEGIN
                 SELECT cod_actcen
                   INTO v_actuacion_res_gsm_ami
                   FROM ga_actabo
                  WHERE cod_modulo     = CN_modulo
                    AND cod_producto   = CN_producto
                        AND cod_tecnologia = v_serie.cod_tecnologia
                    AND cod_actabo     = v_actabo_rm;
               EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         v_actuacion_res_gsm_ami:= null;
               END;
               BEGIN
                 SELECT cod_actcen
                   INTO v_actuacion_res_gsm
                   FROM ga_actabo
                  WHERE cod_modulo     = CN_modulo
                    AND cod_producto   = CN_producto
                        AND cod_tecnologia = v_serie.cod_tecnologia
                    AND cod_actabo     = v_actabo_rg;
               EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         v_actuacion_res_gsm:= null;
               END;
               BEGIN
                SELECT cod_actcen
                   INTO v_actuacion_gsm_ami
                  FROM ga_actabo
                 WHERE cod_modulo     = CN_modulo
                   AND cod_producto   = CN_producto
                   AND cod_tecnologia = v_serie.cod_tecnologia
                   AND cod_actabo     = v_actabo_ga;
              EXCEPTION
                   WHEN  NO_DATA_FOUND THEN
                         v_actuacion_gsm_ami:= null;
              END;

        END IF;


           SELECT cod_articulo, cod_uso
             INTO v_cod_articulo, v_cod_uso
             FROM al_lin_numeracion
            WHERE num_numeracion = v_serie.num_numeracion
              AND lin_numeracion = v_serie.lin_numeracion;

           SELECT ind_telefono
             INTO v_ind_telefono
             FROM al_series
            WHERE num_serie = v_serie.num_serie;


           Al_Proc_Ingreso.p_select_terminal (v_cod_articulo,v_terminal);

          IF (v_ind_telefono <> v_tiponume AND v_serie.num_telefono IS NOT NULL) THEN
           -- **************************************************************************
              IF (v_tiponume = 0) THEN
                 -- Liberar telefono
                 v_reutil.num_celular    := v_serie.num_telefono;
                 v_reutil.cod_subalm     := v_serie.cod_subalm;
                 v_reutil.cod_producto   := v_serie.cod_producto;
                 v_reutil.cod_central    := v_serie.cod_central;
                 v_reutil.cod_uso        := v_cod_uso;
                 v_reutil.cod_cat        := v_serie.cod_cat;
                 Al_Proc_Ingreso.p_select_terminal (v_cod_articulo,v_terminal);
                 Al_Pac_Numeracion.p_libera_numero (v_reutil);
                 IF v_ind_telefono <> 1 THEN
                     --SELECT al_fn_prefijo_numero(v_serie.num_telefono)
                     --INTO v_prefijo
                     --FROM dual;

                     v_prefijo := al_fn_prefijo_numero(v_serie.num_telefono);


                     IF v_cod_uso = v_cod_uso_ami THEN
                          IF v_terminal=v_terminal_simcard THEN
                             v_actuacion_aux := v_actuacion_des_gsm_ami;
                          ELSE
                             v_actuacion_aux := v_actuacion_des_ami;
                          END IF ;
                     ELSE
                          IF v_terminal=v_terminal_simcard THEN
                              v_actuacion_aux := v_actuacion_des_gsm ;
                          ELSE
                              v_actuacion_aux := v_actuacion_des;
                          END IF;
                     END IF;
                     Al_Proc_Ingreso.p_desactiva_central (v_actuacion_aux, v_prefijo,v_serie.cod_central,
                                                                                  v_serie.num_telefono, v_serie.num_serhex,
                                                                                                   v_terminal, v_serie.num_serie);
                 END IF;
                 -- Updateamos la serie de AL_SERIES
                 UPDATE al_series
                    SET num_telefono = NULL,
                        cod_central  = NULL,
                        cod_subalm   = NULL,
                        cod_cat      = NULL,
                        PLAN         = NULL,
                        carga        = NULL,
                        ind_telefono = 0
                    WHERE num_serie = v_serie.num_serie;
              END IF;

              -- **************************************************************************
              IF (v_tiponume = 1) THEN

                 -- Asignar numero desactivado
                 Al_Proc_Ingreso.p_select_terminal (v_cod_articulo,v_terminal);
                 IF v_ind_telefono <> 0 THEN
                     --SELECT al_fn_prefijo_numero(v_serie.num_telefono)
                     --    INTO v_prefijo
                     --    FROM dual;
                     v_prefijo := al_fn_prefijo_numero(v_serie.num_telefono);
                     IF v_cod_uso = v_cod_uso_ami THEN
                         IF v_terminal=v_terminal_simcard THEN
                             v_actuacion_aux :=  v_actuacion_des_gsm_ami;
                         ELSE
                             v_actuacion_aux := v_actuacion_des_ami;
                         END IF;
                     ELSE
                         IF v_terminal=v_terminal_simcard THEN
                            v_actuacion_aux := v_actuacion_des_gsm;
                         ELSE
                            v_actuacion_aux := v_actuacion_des;
                         END IF;
                     END IF;

                     Al_Proc_Ingreso.p_desactiva_central (v_actuacion_aux, v_prefijo,v_serie.cod_central,
                                                           v_serie.num_telefono, v_serie.num_serhex,v_terminal,v_serie.num_serie);
                 END IF;
                 UPDATE al_series
                    SET num_telefono = v_serie.num_telefono,
                        cod_central = v_serie.cod_central,
                        cod_subalm = v_serie.cod_subalm,
                        cod_cat = v_serie.cod_cat,
                       ind_telefono = 1
                    WHERE num_serie = v_serie.num_serie;
              END IF;
              -- **************************************************************************
              IF (v_tiponume = 2 AND v_ind_telefono <> 4 AND v_ind_telefono <> 5 AND v_ind_telefono <> 6
                      AND v_ind_telefono <> 7 ) THEN

                 -- Asignar numero con restriccion no hablar
                     IF v_ind_telefono = 3 THEN
                     --SELECT al_fn_prefijo_numero(v_serie.num_telefono)
                     --INTO v_prefijo
                     --FROM dual;
                     v_prefijo := al_fn_prefijo_numero(v_serie.num_telefono);


                     IF v_terminal=v_terminal_simcard THEN
                        v_actuacion_aux := v_actuacion_des_gsm;
                     ELSE
                        v_actuacion_aux := v_actuacion_des;
                     END IF;

                     Al_Proc_Ingreso.p_desactiva_central (v_actuacion_aux, v_prefijo, v_serie.cod_central,
                                                          v_serie.num_telefono, v_serie.num_serhex, v_terminal,v_serie.num_serie);
                 END IF;
                 --SELECT al_fn_prefijo_numero(v_serie.num_telefono)
                 --INTO v_prefijo
                 --FROM dual;
                 v_prefijo := al_fn_prefijo_numero(v_serie.num_telefono);

                         IF v_terminal=v_terminal_simcard THEN
                            v_actuacion_aux := v_actuacion_res_gsm;
                         ELSE
                            v_actuacion_aux := v_actuacion_res;
                         END IF;
                 Al_Pac_Numeracion.p_activar_central (v_actuacion_aux, v_prefijo, v_serie.cod_central, v_serie.num_telefono,
                                                      v_serie.num_serhex, v_terminal, v_error,  NULL,  NULL,
                                                                                                          v_serie.num_serie);
                 UPDATE al_series
                    SET num_telefono = v_serie.num_telefono,
                        ind_telefono = 2,
                        cod_central  = v_serie.cod_central,
                        cod_subalm   = v_serie.cod_subalm,
                        cod_cat      = v_serie.cod_cat
                    WHERE num_serie  = v_serie.num_serie;
              END IF;
              -- **************************************************************************
              IF (v_tiponume = 3 AND v_ind_telefono <> 4 AND v_ind_telefono <> 5 AND v_ind_telefono <> 6
                   AND v_ind_telefono <> 7) THEN

                   -- Asignar numero activado
                   IF v_ind_telefono = 2 THEN
                           --SELECT al_fn_prefijo_numero(v_serie.num_telefono)
                           --INTO v_prefijo
                           --FROM dual;
                           v_prefijo := al_fn_prefijo_numero(v_serie.num_telefono);
                               IF v_cod_uso = v_cod_uso_ami THEN
                                     IF v_terminal=v_terminal_simcard THEN
                                         v_actuacion_aux := v_actuacion_des_gsm_ami;
                                     ELSE
                                         v_actuacion_aux := v_actuacion_des_ami;
                                     END IF;
                               ELSE
                                     IF v_terminal=v_terminal_simcard THEN
                                           v_actuacion_aux := v_actuacion_des_gsm;
                                     ELSE
                                           v_actuacion_aux := v_actuacion_des;
                                     END IF;
                               END IF;

                       Al_Proc_Ingreso.p_desactiva_central (v_actuacion_aux, v_prefijo,v_serie.cod_central,v_serie.num_telefono,
                                 v_serie.num_serhex,v_terminal, v_serie.num_serie);

                   END IF;
                     --SELECT al_fn_prefijo_numero(v_serie.num_telefono)
                     --INTO v_prefijo
                     --FROM dual;
                     v_prefijo := al_fn_prefijo_numero(v_serie.num_telefono);

                     IF v_terminal=v_terminal_simcard THEN
                        v_actuacion_aux:=v_actuacion_act_gsm;
                     ELSE
                        v_actuacion_aux:=v_actuacion_act;
                     END IF ;


                   Al_Pac_Numeracion.p_activar_central (v_actuacion_aux,v_prefijo,
                                                    v_serie.cod_central, v_serie.num_telefono,
                                                    v_serie.num_serhex, v_terminal, v_error,
                                                    NULL, NULL, v_serie.num_serie);
                   UPDATE al_series
                      SET num_telefono = v_serie.num_telefono,
                          cod_central  = v_serie.cod_central,
                          cod_subalm   = v_serie.cod_subalm,
                          cod_cat      = v_serie.cod_cat,
                          ind_telefono = 3
                    WHERE num_serie    = v_serie.num_serie;
              END IF;
              -- **************************************************************************
              IF (v_tiponume = 7 AND v_ind_telefono IN (0,1) ) THEN

                 -- Asignar numero activado amistar
                 --al_pac_numeracion.p_select_prefijo(v_cod_uso,v_prefijo);
                    --SELECT al_fn_prefijo_numero(v_serie.num_telefono)
                    --INTO v_prefijo
                    --FROM dual;
                    v_prefijo := al_fn_prefijo_numero(v_serie.num_telefono);
                                         IF v_terminal=v_terminal_simcard THEN
                                           v_actuacion_aux:=v_actuacion_act_gsm;
                                         ELSE
                                           v_actuacion_aux:=v_actuacion_act;
                                         END IF;
                  -- INICIO INCIDENCIA XO-200509190694 C.C.A 20-09-2005
                  BEGIN
                  SELECT 1
                  INTO v_existe
                  FROM GED_PARAMETROS
                  WHERE NOM_PARAMETRO='COD_ACTCEN_AA' AND
                  COD_MODULO = CN_modulo AND
                  COD_PRODUCTO = CN_producto AND
                  VAL_PARAMETRO = v_actuacion_aux;

                     Al_Pac_Numeracion.p_activar_central (v_actuacion_aux,                                                                                     v_prefijo,
                                                      v_serie.cod_central,
                                                      v_serie.num_telefono,
                                                      v_serie.num_serhex,
                                                      v_terminal,
                                                      v_error,  NULL,  NULL, v_serie.num_serie);
                  EXCEPTION WHEN OTHERS THEN
                     NULL;
                  END;
         -- FIN INCIDENCIA XO-200509190694 C.C.A 20-09-2005

                 -- 28-09-99 Como la activacion amistar pasa a ser un servicio en centrales,
                 -- hay que activar antes...

                IF v_terminal=v_terminal_simcard THEN
                    if v_aplicachip='S' then
                       v_actuacion_aux:=v_codactuacion_chip;
                    else    
                       v_actuacion_aux := v_actuacion_gsm_ami;
                    end if; 
                 ELSE
                      v_actuacion_aux := v_actuacion_ami;
                 END IF;

                  BEGIN
                      if v_aplicachip='S' then
                          SELECT 1
                          INTO v_existe
                          FROM GED_PARAMETROS
                          WHERE NOM_PARAMETRO='NUMERA_ACTUACIONCHIP' AND
                          COD_MODULO = CN_modulo AND
                          COD_PRODUCTO = CN_producto AND
                          VAL_PARAMETRO = v_codactuacion_chip;     

                     else
                          -- INICIO INCIDENCIA XO-200509190694 C.C.A 20-09-2005
                          SELECT 1
                          INTO v_existe
                          FROM GED_PARAMETROS
                          WHERE NOM_PARAMETRO='COD_ACTCEN_AA' AND
                          COD_MODULO = CN_modulo AND
                          COD_PRODUCTO = CN_producto AND
                          VAL_PARAMETRO = v_actuacion_aux;                 
                     end if;
                     
                     Al_Pac_Numeracion.p_activar_central (v_actuacion_aux,
                                                          v_prefijo,
                                                          v_serie.cod_central,
                                                          v_serie.num_telefono,
                                                          v_serie.num_serhex,
                                                          v_terminal,
                                                          v_error,v_serie.PLAN,  v_serie.carga, v_serie.num_serie,v_codactabo_chip);


                  EXCEPTION WHEN OTHERS THEN
                     NULL;
                  END;
         -- FIN INCIDENCIA XO-200509190694 C.C.A 20-09-2005

                 IF v_ind_telefono = 0 THEN
                    UPDATE al_series
                       SET num_telefono = v_serie.num_telefono,
                           ind_telefono = 7 ,
                           cod_central  = v_serie.cod_central,
                           cod_subalm   = v_serie.cod_subalm,
                           cod_cat      = v_serie.cod_cat,
                           carga        = v_serie.carga,
                           PLAN   = v_serie.PLAN
                       WHERE num_serie = v_serie.num_serie;
                 ELSE
                    UPDATE al_series
                       SET ind_telefono = 7
                     WHERE num_serie = v_serie.num_serie;
                 END IF;
              END IF;
              -- **************************************************************************
              IF (v_tiponume = 6 AND v_ind_telefono IN (0,1) ) THEN

                 -- Asignar numero activado amistar
                 --al_pac_numeracion.p_select_prefijo(v_cod_uso,v_prefijo);
                    --SELECT al_fn_prefijo_numero(v_serie.num_telefono)
                    --INTO v_prefijo
                    --FROM dual;
                    v_prefijo := al_fn_prefijo_numero(v_serie.num_telefono);

                                         IF v_terminal=v_terminal_simcard THEN
                                           v_actuacion_aux:=v_actuacion_act_gsm;
                                         ELSE
                                           v_actuacion_aux:=v_actuacion_act;
                                         END IF;

                  -- INICIO INCIDENCIA XO-200509190694 C.C.A 20-09-2005
                  BEGIN
                  SELECT 1
                  INTO v_existe
                  FROM GED_PARAMETROS
                  WHERE NOM_PARAMETRO='COD_ACTCEN_AR' AND
                  COD_MODULO = CN_modulo AND
                  COD_PRODUCTO = CN_producto AND
                  VAL_PARAMETRO = v_actuacion_aux;

                  Al_Pac_Numeracion.p_activar_central (v_actuacion_aux,                                                                                     v_prefijo,
                                                       v_serie.cod_central,
                                                       v_serie.num_telefono,
                                                       v_serie.num_serhex,
                                                       v_terminal,
                                                       v_error, NULL,  NULL, v_serie.num_serie);

                  EXCEPTION WHEN OTHERS THEN
                     NULL;
                  END;
                  -- FIN INCIDENCIA XO-200509190694 C.C.A 20-09-2005

                  -- 28-09-99 Como la activacion amistar pasa a ser un servicio en centrales,
                  -- hay que activar antes...
                  IF v_terminal=v_terminal_simcard THEN
                     v_actuacion_aux := v_actuacion_res_gsm_ami;
                  ELSE
                     v_actuacion_aux := v_actuacion_res_ami;
                  END IF;

                  -- INICIO INCIDENCIA XO-200509190694 C.C.A 20-09-2005
                  BEGIN
                  SELECT 1
                  INTO v_existe
                  FROM GED_PARAMETROS
                  WHERE NOM_PARAMETRO='COD_ACTCEN_AR' AND
                  COD_MODULO = CN_modulo AND
                  COD_PRODUCTO = CN_producto AND
                  VAL_PARAMETRO = v_actuacion_aux;

                  Al_Pac_Numeracion.p_activar_central (v_actuacion_aux,
                                                       v_prefijo,
                                                       v_serie.cod_central,
                                                       v_serie.num_telefono,
                                                       v_serie.num_serhex,
                                                       v_terminal,
                                                       v_error, v_serie.PLAN,  v_serie.carga, v_serie.num_serie);

                  EXCEPTION WHEN OTHERS THEN
                     NULL;
                  END;
                  -- FIN INCIDENCIA XO-200509190694 C.C.A 20-09-2005

                  IF v_ind_telefono = 0 THEN
                      UPDATE al_series
                         SET num_telefono = v_serie.num_telefono,
                             ind_telefono = 6 ,
                             cod_central  = v_serie.cod_central,
                             cod_subalm   = v_serie.cod_subalm,
                             cod_cat      = v_serie.cod_cat,
                             carga        = v_serie.carga,
                             PLAN         = v_serie.PLAN
                         WHERE  num_serie = v_serie.num_serie;
                  ELSE
                      UPDATE al_series
                         SET ind_telefono = 6
                         WHERE num_serie  = v_serie.num_serie;
                  END IF;
              END IF;
           END IF;
      END LOOP;
 EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20140,
        '<ALMACEN> Error Ordenes Numeracion ' || (SQLERRM));
END P_Al_Afup_Cabnume;
/
SHOW ERRORS