CREATE OR REPLACE PACKAGE BODY EBZ_SISCEL.NP_ACTIVACION_TARJETAS_PG IS
/*
<NOMBRE>           : CT_TARJETAS_PG   .</NOMBRE>
<FECHACREA>        : 27-07-2004<FECHACREA/>
<MODULO >          : Logistica </MODULO >
<AUTOR >       :  </AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Activacion de Tarjetas Rascas</DESCRIPCION>
<FECHAMOD >    : 23/06/2006 </FECHAMOD >
<DESCMOD >     : Optimizar los accesos que se realizan a la tabla NPT_ESTADO_PEDIDO Inc MA-200606190940  </DESCMOD >
<VERSIONMOD>   : 1.2</VERSIONMOD>
<FECHAMOD >    : 11/08/2009 </FECHAMOD >
<DESCMOD >     : Modificación a PL para: P-MIX-09003-Guatemala-Salvador   </DESCMOD >
<VERSIONMOD>   : 1.3    </VERSIONMOD>
<AUTOR>        : Z.M.H. </AUTORMOD>
*/
        PROCEDURE NP_OBTNIENE_PEDIDOS_PR
        IS
        -- ************************************************************************************
        -- * DESCRIPCION :
        -- *
        -- *
        -- ************************************************************************************
        TN_estado NPT_ESTADO_PEDIDO.cod_estado_flujo%TYPE;
        TN_estado_exitoso NPT_ESTADO_PEDIDO.cod_estado_flujo%TYPE;
        TN_tip_articulo AL_ARTICULOS.tip_articulo%TYPE:=1;
        TN_ind_seriado  AL_ARTICULOS.ind_seriado%TYPE;
        TV_ind_equiacc  AL_ARTICULOS.ind_equiacc%TYPE;
        TN_lin_det_pedido NPT_DETALLE_PEDIDO.lin_det_pedido%TYPE;
        TN_cod_articulo NPT_DETALLE_PEDIDO.cod_articulo%TYPE;
        TN_cod_pedido NPT_DETALLE_PEDIDO.cod_pedido%TYPE;
        TN_cod_pedido_ant NPT_DETALLE_PEDIDO.cod_pedido%TYPE;
        TV_errores  AL_ERRORES_WEB%ROWTYPE;
        VN_num_errores PLS_INTEGER;
        GI_error PLS_INTEGER;
        TV_parametro GED_PARAMETROS.nom_parametro%TYPE;

        CV_cod_modgener      CONSTANT FA_INTQUEUEPROC.cod_modgener%TYPE:='LYP';
        CV_cod_aplic         CONSTANT FA_INTQUEUEPROC.cod_aplic%TYPE:='LYP';
        CN_cod_proceso       CONSTANT FA_INTQUEUEPROC.cod_proceso%TYPE:= 978;
        CN_cod_estado        CONSTANT FA_INTQUEUEPROC.cod_estado%TYPE:= 1;



        CURSOR PEDIDOS(TN_TIP_ARTICULO AL_ARTICULOS.tip_articulo%TYPE,
                       TN_IND_SERIADO  AL_ARTICULOS.ind_seriado%TYPE,
                       TN_ESTADO NPT_ESTADO_PEDIDO.cod_estado_flujo%TYPE)
        IS
        SELECT UNIQUE a.cod_pedido
        FROM NPT_DETALLE_PEDIDO a, AL_ARTICULOS b
        WHERE a.cod_pedido IN(SELECT cod_pedido
                   FROM NPT_ESTADO_PEDIDO z
                   WHERE fec_inf_est_pedido = (
                             SELECT MAX(fec_inf_est_pedido)
                             FROM NPT_ESTADO_PEDIDO b
                             WHERE b.cod_pedido=z.cod_pedido AND nvl(b.cod_pedido,b.cod_pedido) > 0) -- MA-200606190940 ipct
                   AND NVL(z.cod_estado_flujo, z.cod_estado_flujo) = tn_estado      -- P-MIX-09003-Guatemala-Salvador
                   AND nvl(cod_pedido,cod_pedido) > 0)                           -- MA-200606190940 ipct
        AND nvl(a.cod_pedido,a.cod_pedido) > 0                                   -- MA-200606190940 ipct
        AND nvl(a.LIN_DET_PEDIDO,a.LIN_DET_PEDIDO) > 0                           -- MA-200606190940 ipct
        AND a.cod_articulo = b.cod_articulo
        AND b.tip_articulo = tn_tip_articulo
        AND b.ind_seriado  = tn_ind_seriado
        AND b.ind_equiacc  = tv_ind_equiacc
        AND not exists (SELECT 1 FROM AL_ERRORES_WEB  x
                        WHERE x.cod_pedido=a.cod_pedido);


        CURSOR LIN_PEDIDOS (TN_cod_pedido IN NPT_DETALLE_PEDIDO.cod_pedido%TYPE)
        IS
             SELECT a.cod_pedido, a.lin_det_pedido, b.cod_articulo
             FROM NPT_DETALLE_PEDIDO a, AL_ARTICULOS b
             WHERE a.cod_pedido = TN_cod_pedido
             AND a.cod_articulo = b.cod_articulo
             AND b.tip_articulo = tn_tip_articulo
             AND b.ind_seriado  = tn_ind_seriado
             AND b.ind_equiacc = tv_ind_equiacc;

        BEGIN

           BEGIN
                   TV_parametro :='RECEP_CONFORME_PED';
                   SELECT val_parametro
                   INTO  TN_estado
                   FROM GED_PARAMETROS
                   WHERE nom_parametro = TV_parametro
                   AND cod_modulo = CV_cod_modulo1
                   AND cod_producto = CI_uno;

                   TV_parametro :='PEDIDO_TARJETA_EXITO';
                   SELECT val_parametro
                   INTO  TN_estado_exitoso
                   FROM GED_PARAMETROS
                   WHERE nom_parametro = TV_parametro
                   AND cod_modulo = CV_cod_modulo1
                   AND cod_producto = CI_uno;

                   TV_parametro:='IND_SERIADO';
                   SELECT val_parametro
                   INTO  TN_ind_seriado
                   FROM GED_PARAMETROS
                   WHERE nom_parametro = TV_parametro
                   AND cod_modulo = CV_cod_modulo2
                   AND cod_producto = CI_uno;

                   TV_parametro:='IND_ACCESORIO';
                   SELECT val_parametro
                   INTO  TV_ind_equiacc
                   FROM GED_PARAMETROS
                   WHERE nom_parametro = TV_parametro
                   AND cod_modulo = CV_cod_modulo2
                   AND cod_producto = CI_uno;

		   TV_parametro:='TIP_ART_ACTIVACION2';  -- P-MIX-09003-Guatemala-Salvador
		   SELECT VAL_PARAMETRO
		   INTO TN_tip_articulo
		   FROM GED_PARAMETROS
		   WHERE nom_parametro = TV_parametro
		   AND cod_modulo = CV_cod_modulo1
		   AND cod_producto = CI_uno;
           EXCEPTION
             WHEN NO_DATA_FOUND THEN
                  TV_errores.cod_pedido:= CI_zero;
                  TV_errores.GLOSA_ERROR_TRASPASO:= 'PARAMETRO ' || TV_parametro ||' NO ENCONTRADO';
                  NP_INSERTAR_AL_ERRORES_WEB_PR(TV_errores,CI_uno);
                  TV_errores:= NULL;
                  RETURN;
              WHEN OTHERS THEN
                  TV_errores.cod_pedido:= CI_zero;
                  TV_errores.GLOSA_ERROR_TRASPASO:= 'ERROR AL RECUPERAR PARAMETRO ' || TV_parametro || to_char(SQLCODE);
                  NP_INSERTAR_AL_ERRORES_WEB_PR(TV_errores,CI_uno);
                  TV_errores:= NULL;
                  RETURN;
          END;


           FOR C_PEDIDOS IN PEDIDOS(TN_tip_articulo,TN_ind_seriado,TN_estado) LOOP
                    FOR C_LIN_PEDIDOS IN LIN_PEDIDOS(C_PEDIDOS.cod_pedido) LOOP
                        NP_GENERA_RANGOS_PEDIDOS_PR(C_LIN_PEDIDOS.cod_pedido,C_LIN_PEDIDOS.lin_det_pedido,C_LIN_PEDIDOS.cod_articulo,GI_error);
                    END LOOP;

                    IF GI_error = CI_zero THEN
                       BEGIN
                          INSERT INTO NPT_ESTADO_PEDIDO
                                 SELECT cod_pedido,SYSDATE,cod_usuario_cre,cod_usuario_ing,cod_motivo_rechazo,cod_motivo_excepcion,TN_estado_exitoso,SYSDATE,obs_est_pedido
                                 FROM  NPT_ESTADO_PEDIDO
                                 WHERE fec_cre_est_pedido = (SELECT MAX(fec_cre_est_pedido)
                                                             FROM NPT_ESTADO_PEDIDO
                                                             WHERE cod_pedido  = C_PEDIDOS.cod_pedido AND NVL(cod_pedido,cod_pedido) > 0)   -- MA-200606190940 ipct
                                 AND cod_pedido  = C_PEDIDOS.cod_pedido;
                          COMMIT;

                       EXCEPTION
                           WHEN OTHERS THEN
                                TV_errores.cod_pedido:= C_PEDIDOS.cod_pedido;
                                TV_errores.GLOSA_ERROR_TRASPASO:= 'ERROR AL INSERTAR EN LA TABLA NPT_ESTADO_PEDIDO ' ;
                                NP_INSERTAR_AL_ERRORES_WEB_PR(TV_errores,CI_zero);
                                TV_errores:= NULL;
                                ROLLBACK;
                       END;
                    ELSE
                       ROLLBACK;
                    END IF;
           END LOOP;

           BEGIN
                   UPDATE FA_INTQUEUEPROC
                   SET   cod_estado  = CN_cod_estado,
                         pid_proceso =  NULL
                   WHERE cod_aplic   = CV_cod_aplic
                   AND   cod_modgener= CV_cod_modgener
                   AND   cod_proceso = CN_cod_proceso;

                   COMMIT;
           EXCEPTION
                    WHEN OTHERS THEN
                         TV_errores.cod_pedido:= CI_zero;
                         TV_errores.GLOSA_ERROR_TRASPASO:= 'ERROR AL INSERTAR EN LA TABLA FA_INTQUEUEPROC ' ;
                         NP_INSERTAR_AL_ERRORES_WEB_PR(TV_errores,CI_zero);
                         TV_errores:= NULL;
                         ROLLBACK;
           END;

        END;

        PROCEDURE NP_GENERA_RANGOS_PEDIDOS_PR (TN_cod_pedido     IN NPT_DETALLE_PEDIDO.cod_pedido%TYPE,
                                               TN_lin_det_pedido IN NPT_DETALLE_PEDIDO.lin_det_pedido%TYPE,
                                               TN_cod_articulo   IN NPT_DETALLE_PEDIDO.cod_articulo%TYPE,
                                               OI_error          OUT PLS_INTEGER)
        IS
        GV_rango_inicial NPT_SERIE_PEDIDO.cod_serie_pedido%TYPE;
        GV_rango_final NPT_SERIE_PEDIDO.cod_serie_pedido%TYPE;
        GV_serie_anterior NPT_SERIE_PEDIDO.cod_serie_pedido%TYPE;
        TV_cod_actcen GA_ACTABO.cod_actcen%TYPE;
        TV_cod_actabo ICC_MOVIMIENTO.cod_actabo%TYPE;
        TV_errores  AL_ERRORES_WEB%ROWTYPE;
        TV_parametro GED_PARAMETROS.nom_parametro%TYPE;
        TV_cod_tecnologia CONSTANT GA_ACTABO.cod_tecnologia%TYPE:= 'GSM';
        TV_tip_tecnologia CONSTANT ICC_MOVIMIENTO.tip_tecnologia%TYPE:='GSM';
        TV_tip_terminal CONSTANT ICC_MOVIMIENTO.TIP_TERMINAL%TYPE:='G';
        TV_num_intentos CONSTANT ICC_MOVIMIENTO.num_intentos%TYPE:= 0;
        TV_des_respuesta CONSTANT ICC_MOVIMIENTO.des_respuesta%TYPE:= 'PENDIENTE';
        SN_icc_seq_nummov INTEGER;
        Ind PLS_INTEGER := 0;

        TYPE TYP_RANGO_INI IS TABLE OF NPT_SERIE_PEDIDO.cod_serie_pedido%TYPE  INDEX BY BINARY_INTEGER;
        TYPE TYP_RANGO_FIN IS TABLE OF NPT_SERIE_PEDIDO.cod_serie_pedido%TYPE  INDEX BY BINARY_INTEGER;
        TYPE TYP_MOVIMIENTO IS TABLE OF NP_RANGO_SERIES_TO.num_movimiento%TYPE  INDEX BY BINARY_INTEGER;

        RANGO_INI TYP_RANGO_INI;
        RANGO_FIN TYP_RANGO_FIN;
        MOVIMIENTO TYP_MOVIMIENTO;

        CURSOR SERIES(TN_cod_pedido NPT_ESTADO_PEDIDO.cod_pedido%TYPE,
                      TN_lin_det_pedido NPT_DETALLE_PEDIDO.lin_det_pedido%TYPE)
        IS
                SELECT a.cod_serie_pedido serie
                FROM NPT_SERIE_PEDIDO a
                WHERE a.cod_pedido = TN_cod_pedido
                AND a.lin_det_pedido = TN_lin_det_pedido
                ORDER BY a.cod_serie_pedido;

        BEGIN
          OI_error:= CI_zero;
          BEGIN
                TV_parametro := 'ACTIVA_TARJETA';
                SELECT val_parametro
                INTO TV_cod_actabo
                FROM GED_PARAMETROS
                WHERE nom_parametro = TV_parametro
                AND cod_modulo = CV_cod_modulo
                AND cod_producto = CI_uno;
          EXCEPTION
             WHEN NO_DATA_FOUND THEN
                  TV_errores.cod_pedido:=TN_cod_pedido;
                  TV_errores.glosa_error_traspaso:= 'PARAMETRO ACTIVA_TARJETA NO ENCONTRADO';
                  NP_INSERTAR_AL_ERRORES_WEB_PR(TV_errores,CI_zero);
                  TV_errores:= NULL;
                  OI_error:=CI_uno;
                  RETURN;
              WHEN OTHERS THEN
                  TV_errores.cod_pedido:=TN_cod_pedido;
                  TV_errores.glosa_error_traspaso:= 'ERROR AL RECUPERAR PARAMETRO ACTIVA_TARJETA ' || to_char(SQLCODE);
                  NP_INSERTAR_AL_ERRORES_WEB_PR(TV_errores,CI_zero);
                  TV_errores:= NULL;
                  OI_error:=CI_uno;
                  RETURN;
          END;

      BEGIN
          SELECT cod_actcen
          INTO TV_cod_actcen
          FROM GA_ACTABO
          WHERE cod_actabo = TV_cod_actabo
          AND cod_modulo = CV_cod_modulo
          AND cod_producto = CI_uno
          AND cod_tecnologia = TV_cod_tecnologia;

      EXCEPTION
             WHEN NO_DATA_FOUND THEN
                  TV_errores.cod_pedido:=TN_cod_pedido;
                  TV_errores.glosa_error_traspaso:= 'CODIGO ACTIVACION CENTRALES NO ENCONTRADO';
                  NP_INSERTAR_AL_ERRORES_WEB_PR(TV_errores,CI_zero);
                  TV_errores:= NULL;
                  OI_error:=CI_uno;
                  RETURN;
              WHEN OTHERS THEN
                  TV_errores.cod_pedido:=TN_cod_pedido;
                  TV_errores.glosa_error_traspaso:= 'ERROR AL RECUPERAR CODIGO ACTIVACION CENTRALES ' || to_char(SQLCODE);
                  NP_INSERTAR_AL_ERRORES_WEB_PR(TV_errores,CI_zero);
                  TV_errores:= NULL;
                  OI_error:=CI_uno;
                  RETURN;
      END;
           VG_ind_accion:= 'A';
           GV_serie_anterior:= NULL;

           FOR C_SERIES IN SERIES(TN_cod_pedido,TN_lin_det_pedido) LOOP
                   IF GV_rango_inicial IS NULL THEN
                      GV_rango_inicial := GV_serie_anterior;
                   END IF;
                   IF GV_serie_anterior IS NOT NULL THEN
--                           IF TO_number(substr(GV_serie_anterior,1,length(GV_serie_anterior)-1)) + 1 < TO_NUMBER(substr(C_SERIES.serie,1,length(C_SERIES.serie)-1)) THEN   -- P-MIX-09003-Guatemala-Salvador
                           IF TO_number(GV_serie_anterior) + 1 < TO_NUMBER(C_SERIES.serie) THEN
                                  Ind := Ind + 1;

                                  GV_rango_final := GV_serie_anterior;

                                  RANGO_INI(Ind):= GV_RANGO_INICIAL;
                                  RANGO_FIN(Ind):= GV_RANGO_FINAL;

                                  SELECT ICC_SEQ_NUMMOV.NEXTVAL
                                  INTO SN_ICC_SEQ_NUMMOV
                                  FROM DUAL;

                                  MOVIMIENTO(Ind):= SN_ICC_SEQ_NUMMOV;

                                  GV_rango_inicial := NULL;
                                  GV_rango_final := NULL;
                           END IF;
                   END IF;
                   GV_serie_anterior:=C_SERIES.serie;
           END LOOP;

           Ind := Ind + 1;
           IF GV_rango_inicial IS NOT NULL THEN
                  IF GV_serie_anterior IS NULL THEN
                          GV_rango_final := GV_rango_inicial;
                  ELSE
                          GV_rango_final := GV_serie_anterior;
                  END IF;
           ELSE
                  GV_rango_inicial:= GV_serie_anterior;
                  GV_rango_final:= GV_serie_anterior;
           END IF;
                  RANGO_INI(Ind):= GV_rango_inicial;
                  RANGO_FIN(Ind):= GV_rango_final;

                  SELECT ICC_SEQ_NUMMOV.NEXTVAL
                  INTO SN_ICC_SEQ_NUMMOV
                  FROM DUAL;

                  MOVIMIENTO(Ind):= SN_ICC_SEQ_NUMMOV;


           BEGIN
                   FORALL v_j IN 1..Ind
                           INSERT INTO NP_RANGO_SERIES_TO
                                          (num_proceso,num_linea,serie_inicial,ind_accion,serie_final,num_movimiento,cod_articulo,nom_usuario,fec_rangos)
                                   VALUES (TN_cod_pedido,TN_lin_det_pedido,RANGO_INI(v_j),VG_ind_accion,RANGO_FIN(v_j),MOVIMIENTO(v_j),TN_cod_articulo,USER,SYSDATE);
           EXCEPTION
              WHEN OTHERS THEN
                  TV_errores.cod_pedido:=TN_cod_pedido;
                  TV_errores.GLOSA_ERROR_TRASPASO:= 'ERROR AL INSERTAR EN NP_RANGO_SERIES_TO ' || to_char(SQLCODE);
                  NP_INSERTAR_AL_ERRORES_WEB_PR(TV_errores,CI_zero);
                  TV_errores:= NULL;
                  OI_error:=CI_uno;
                  RETURN;
           END;

           BEGIN
                  FORALL v_j IN 1..Ind
                                  INSERT INTO ICC_MOVIMIENTO
                                         (num_movimiento, num_abonado,cod_modulo,num_intentos, des_respuesta,
                                          cod_actuacion, cod_actabo, cod_central,num_celular, num_serie, tip_terminal,tip_tecnologia)
                                  VALUES (MOVIMIENTO(v_j),CI_zero,CV_cod_modulo,TV_num_intentos,TV_des_respuesta,
                                          TV_cod_actcen,TV_cod_actabo,CI_zero,CI_uno,CI_zero,TV_tip_terminal,TV_tip_tecnologia);
           EXCEPTION
              WHEN OTHERS THEN
                  TV_errores.cod_pedido:=TN_cod_pedido;
                  TV_errores.glosa_error_traspaso:= 'ERROR AL INSERTAR EN ICC_MOVIMIENTO ' || to_char(SQLCODE);
                  NP_INSERTAR_AL_ERRORES_WEB_PR(TV_errores,CI_zero);
                  TV_errores:= NULL;
                  OI_error:=CI_uno;
                  RETURN;
           END;
        EXCEPTION
              WHEN OTHERS THEN
                  TV_errores.cod_pedido:=TN_cod_pedido;
                  TV_errores.GLOSA_ERROR_TRASPASO:= 'ERROR EN EL PROCEDIMIENTO NP_GENERA_RANGOS_PEDIDOS_PR ' || to_char(SQLCODE);
                  NP_INSERTAR_AL_ERRORES_WEB_PR(TV_errores,CI_zero);
                  OI_error:=CI_uno;
                  TV_errores:= NULL;
        END;


        PROCEDURE NP_GENERA_RANGOS_DEVOLUCION_PR (
                IV_cadenaparametro  IN  VARCHAR2,
                OV_tabla            OUT VARCHAR2,
                OV_accion           OUT VARCHAR2,
                OV_sqlcode          OUT VARCHAR2,
                OV_sqlerrm          OUT VARCHAR2)
        IS
                GN_COD_DEVOLUCION NPT_DETALLE_DEVOLUCION.COD_DEVOLUCION%TYPE;
                GN_LIN_DET_PEDIDO NPT_DETALLE_DEVOLUCION.LIN_DET_PEDIDO%TYPE;
                GV_RANGO_INICIAL NPT_DETALLE_DEVOLUCION.COD_SERIE_PEDIDO%TYPE;
                GV_RANGO_FINAL NPT_DETALLE_DEVOLUCION.COD_SERIE_PEDIDO%TYPE;
                GV_SERIE_ANTERIOR NPT_DETALLE_DEVOLUCION.COD_SERIE_PEDIDO%TYPE;
                TN_COD_ARTICULO AL_ARTICULOS.COD_ARTICULO%TYPE;
                TV_COD_ACTCEN GA_ACTABO.COD_ACTCEN%TYPE;
                TV_COD_ACTABO ICC_MOVIMIENTO.COD_ACTABO%TYPE;
                TV_parametro GED_PARAMETROS.NOM_PARAMETRO%TYPE;
                TV_cod_tecnologia CONSTANT GA_ACTABO.COD_TECNOLOGIA%TYPE:= 'GSM';
                TV_tip_terminal CONSTANT ICC_MOVIMIENTO.TIP_TERMINAL%TYPE:='G';
                TV_tip_tecnologia CONSTANT ICC_MOVIMIENTO.tip_tecnologia%TYPE:='GSM';
                TV_num_intentos CONSTANT ICC_MOVIMIENTO.NUM_INTENTOS%TYPE:= 0;
                TV_des_respuesta CONSTANT ICC_MOVIMIENTO.DES_RESPUESTA%TYPE:= 'PENDIENTE';
                SN_ICC_SEQ_NUMMOV INTEGER;
                GN_EJECUTA_PROCESO PLS_INTEGER;
                Ind PLS_INTEGER := 0;


                TYPE TYP_RANGO_INI IS TABLE OF NPT_DETALLE_DEVOLUCION.COD_SERIE_PEDIDO%TYPE  INDEX BY BINARY_INTEGER;
                TYPE TYP_RANGO_FIN IS TABLE OF NPT_DETALLE_DEVOLUCION.COD_SERIE_PEDIDO%TYPE  INDEX BY BINARY_INTEGER;
                TYPE TYP_MOVIMIENTO IS TABLE OF NP_RANGO_SERIES_TO.NUM_MOVIMIENTO %TYPE  INDEX BY BINARY_INTEGER;

                RANGO_INI TYP_RANGO_INI;
                RANGO_FIN TYP_RANGO_FIN;
                MOVIMIENTO TYP_MOVIMIENTO;

                CURSOR LIN_DEVOLUCION(TN_COD_DEVOLUCION NPT_DETALLE_DEVOLUCION.COD_DEVOLUCION%TYPE)
                IS
                        SELECT COD_PEDIDO,LIN_DET_PEDIDO
                        FROM  NPT_DETALLE_DEVOLUCION
                        WHERE COD_DEVOLUCION = TN_COD_DEVOLUCION
                        GROUP BY COD_PEDIDO,LIN_DET_PEDIDO;

                CURSOR SERIES(TN_COD_DEVOLUCION NPT_DETALLE_DEVOLUCION.COD_DEVOLUCION%TYPE,
                                          TN_LIN_DET_PEDIDO NPT_DETALLE_DEVOLUCION.LIN_DET_PEDIDO%TYPE)
                IS
                        SELECT A.COD_SERIE_PEDIDO SERIE
                        FROM NPT_DETALLE_DEVOLUCION A
                        WHERE A.COD_DEVOLUCION = TN_COD_DEVOLUCION
                        AND A.LIN_DET_PEDIDO = TN_LIN_DET_PEDIDO
                        ORDER BY A.COD_SERIE_PEDIDO;

                        string siscel.GE_TABTYPE_VCH2ARRAY := siscel.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        BEGIN
                        -- ********************************************************************
                -- INICIO DESCOMPOSICION DEL LA CADENA DE ENTRADA V_CADENAENTRADA
                -- ********************************************************************
                   Ge_Pac_Arreglopr.GE_PR_RetornaArreglo(IV_cadenaparametro, string);
                -- Retorna la siguiente cadena
                /*1:= cod_pedido
                 2:=  cod_devolucion.
                 3:=  cod_cliente.
                 4:=  cod_uso.
                 5:=  tip_doc_pedido.
                 6:=  tip_movimiento.
                 7:=  tip_articulo.
                 8:=  cod_serie_pedido.
                 9:=  cod_articulo.
                 10:= ind_equiacc.
                 11:= tip_terminal.
                 12:= ind_seriado.
                 13:= cod_transaccion.
                 14:= cod_estado.
                 15:= num_abonado.
                 16:= num_celular.
                 17:= num_serie.
                 18:= cod_actabo.
                 19:= cod_actuacion.
                 20:= cod_causa.
                 21:= num_usuarora.
                 22:= cod_modulo.
                 23:= saldo.
                 24:= cod_tecnologia.
                 25:= cod_bodega.
                 26:= ind_entsal.
                 27:= fec_modif.
                 28:= tip_artkid.
                 29:= ind_telefono -indicador telefonico.
                 30:= cod_central
                 31:= tip_stock_orig --indicador stock de origen.
                 32:= cod_estado_dev
                 33:= Tip Stock serie actual*/
                -- ********************************************************************
                -- FIN DESCOMPOSICION DEL ARREGLO
                -- ********************************************************************

                GN_COD_DEVOLUCION:= NVL(TO_NUMBER(string(2)),0);
                    BEGIN
                                TV_parametro := 'DESACTIVA_TARJETA';
                                SELECT VAL_PARAMETRO
                                INTO TV_COD_ACTABO
                                FROM GED_PARAMETROS
                                WHERE NOM_PARAMETRO = TV_parametro
                                AND COD_MODULO = CV_cod_modulo
                                AND COD_PRODUCTO = CI_uno;
                        EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                OV_tabla        :='GED_PARAMETROS' ;
                                OV_accion       := 'SELECT';
                                OV_sqlcode      := '-20101';
                                OV_sqlerrm   := 'PARAMETRO ACTIVA_TARJETA NO ENCONTRADO';
                                RETURN;
                        END;

                        BEGIN
                                SELECT COD_ACTCEN
                                INTO TV_COD_ACTCEN
                                FROM GA_ACTABO
                                WHERE COD_ACTABO = TV_COD_ACTABO
                                AND COD_MODULO = CV_cod_modulo
                                AND COD_PRODUCTO = CI_uno
                                AND COD_TECNOLOGIA = TV_cod_tecnologia;
                        EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                OV_tabla        :='GA_ACTABO' ;
                                OV_accion       := 'SELECT';
                                OV_sqlcode      := '-20102';
                                OV_sqlerrm   := 'COD_ACTCEN NO ENCONTRADO';
                                RETURN;
                        END;

                     
                   VG_ind_accion:= 'D';
                   GV_SERIE_ANTERIOR:= NULL;
                   FOR C_LIN_DEVOLUCION IN LIN_DEVOLUCION(GN_COD_DEVOLUCION) LOOP
                           GN_LIN_DET_PEDIDO := C_LIN_DEVOLUCION.LIN_DET_PEDIDO;
                           BEGIN
                                   SELECT COD_ARTICULO
                                   INTO TN_COD_ARTICULO
                                   FROM NPT_DETALLE_PEDIDO
                                   WHERE COD_PEDIDO = C_LIN_DEVOLUCION.COD_PEDIDO
                                   AND LIN_DET_PEDIDO = GN_LIN_DET_PEDIDO;
                           EXCEPTION
	                            WHEN NO_DATA_FOUND THEN
                                         BEGIN
                                                SELECT COD_ARTICULO
                                                INTO TN_COD_ARTICULO
                                                FROM NPT_DETALLE_PEDIDO_HIST_TH
                                                WHERE COD_PEDIDO = C_LIN_DEVOLUCION.COD_PEDIDO
                                                AND LIN_DET_PEDIDO = GN_LIN_DET_PEDIDO;
                                          EXCEPTION
                                                  WHEN NO_DATA_FOUND THEN
                                                                        OV_tabla     :='NPT_DETALLE_PEDIDO Y NPT_DETALLE_PEDIDO_HIST_TH' ;
                                                                        OV_accion    := 'SELECT';
                                                                        OV_sqlcode   := '-20103';
                                                                        OV_sqlerrm   := 'LINEA DE PEDIDO NO ENCONTRADA';
                                                          RETURN;
                                         END;
                                END;

                           FOR C_SERIES IN SERIES(GN_COD_DEVOLUCION,GN_LIN_DET_PEDIDO) LOOP
                                   IF GV_RANGO_INICIAL IS NULL THEN
                                          GV_RANGO_INICIAL := GV_SERIE_ANTERIOR;
                                   END IF;
                                   IF GV_SERIE_ANTERIOR IS NOT NULL THEN
--                                      IF TO_NUMBER(GV_SERIE_ANTERIOR) + 1 < TO_NUMBER(C_SERIES.SERIE) THEN
                                      IF TO_number(substr(GV_serie_anterior,1,length(GV_serie_anterior)-1)) + 1 < TO_NUMBER(substr(C_SERIES.serie,1,length(C_SERIES.serie)-1)) THEN
                                          Ind := Ind + 1;
                                          GV_RANGO_FINAL := GV_SERIE_ANTERIOR;
                                          RANGO_INI(Ind):= GV_RANGO_INICIAL;
                                          RANGO_FIN(Ind):= GV_RANGO_FINAL;

                                          IF tv_cod_actcen IS NOT NULL THEN  
                                            BEGIN
                                                  SELECT ICC_SEQ_NUMMOV.NEXTVAL
                                                  INTO SN_ICC_SEQ_NUMMOV
                                                  FROM DUAL;
                                                EXCEPTION
                                                WHEN NO_DATA_FOUND THEN
                                                        OV_tabla        :='ICC_SEQ_NUMMOV' ;
                                                        OV_accion       := 'SECUENCIA';
                                                        OV_sqlcode      := '-20104';
                                                        OV_sqlerrm   := 'NO RETORNO SECUENCIA ICC_SEQ_NUMMOV';
                                                        RETURN;
                                                END;
                                          ELSE
                                                SN_ICC_SEQ_NUMMOV:=0;
                                          END IF;  
                                                MOVIMIENTO(Ind):= SN_ICC_SEQ_NUMMOV;
                                        
                                          GV_RANGO_INICIAL := NULL;
                                          GV_RANGO_FINAL := NULL;
                                      END IF;
                                   END IF;
                                   GV_SERIE_ANTERIOR:=C_SERIES.SERIE;
                           END LOOP;
                           Ind := Ind + 1;
                           IF GV_RANGO_INICIAL IS NOT NULL THEN
                                  IF GV_SERIE_ANTERIOR IS NULL THEN
                                          GV_RANGO_FINAL := GV_RANGO_INICIAL;
                                  ELSE
                                          GV_RANGO_FINAL := GV_SERIE_ANTERIOR;
                                  END IF;
                           ELSE
                                  GV_RANGO_INICIAL := GV_SERIE_ANTERIOR;
                                  GV_RANGO_FINAL := GV_SERIE_ANTERIOR;
                           END IF;
                           RANGO_INI(Ind):= GV_RANGO_INICIAL;
                           RANGO_FIN(Ind):= GV_RANGO_FINAL;
 
                          IF tv_cod_actcen IS NOT NULL THEN 
                              BEGIN
                                        SELECT ICC_SEQ_NUMMOV.NEXTVAL
                                        INTO SN_ICC_SEQ_NUMMOV
                                        FROM DUAL;
                               EXCEPTION
                                    WHEN NO_DATA_FOUND THEN
                                            OV_tabla        :='ICC_SEQ_NUMMOV' ;
                                            OV_accion       := 'SECUENCIA';
                                            OV_sqlcode      := '-20105';
                                            OV_sqlerrm   := 'NO RETORNO SECUENCIA ICC_SEQ_NUMMOV';
                                            RETURN;
                               END;
                          ELSE  
                                 SN_ICC_SEQ_NUMMOV:=0;
                          END IF;    
 

                           MOVIMIENTO(Ind):= SN_ICC_SEQ_NUMMOV;
                           BEGIN
                              FORALL v_j IN 1..Ind
                                   INSERT INTO NP_RANGO_SERIES_TO
                                                         (NUM_PROCESO,NUM_LINEA,SERIE_INICIAL,IND_ACCION,SERIE_FINAL,NUM_MOVIMIENTO,COD_ARTICULO,NOM_USUARIO,FEC_RANGOS)
                                           VALUES (GN_COD_DEVOLUCION,GN_LIN_DET_PEDIDO,RANGO_INI(v_j),VG_ind_accion,RANGO_FIN(v_j),MOVIMIENTO(v_j),TN_COD_ARTICULO,USER,SYSDATE);
                            EXCEPTION
                              WHEN OTHERS THEN
                                  OV_tabla        :='NP_RANGO_SERIES_TO' ;
                                  OV_accion       := 'INSERT';
                                  OV_sqlcode      := SQLCODE;
                                  OV_sqlerrm   := 'ERROR AL INSERTAR EN LA TABLA NP_RANGO_SERIES_TO';
                                  RETURN;
                           END;


                       IF tv_cod_actcen IS NOT NULL THEN
                               BEGIN
 
                               FORALL v_j IN 1..Ind
                                         INSERT INTO ICC_MOVIMIENTO
                                                (NUM_MOVIMIENTO, NUM_ABONADO,COD_MODULO,NUM_INTENTOS, DES_RESPUESTA,
                                                COD_ACTUACION, COD_ACTABO, COD_CENTRAL,NUM_CELULAR, NUM_SERIE, TIP_TERMINAL,TIP_TECNOLOGIA)
                                         VALUES (MOVIMIENTO(v_j),CI_zero,CV_cod_modulo,TV_num_intentos,TV_des_respuesta,tv_cod_actcen,tv_cod_actabo,CI_zero,CI_uno,CI_zero,TV_tip_terminal,TV_tip_tecnologia);
                               EXCEPTION
                                    WHEN OTHERS THEN
                                            OV_tabla        :='ICC_MOVIMIENTO' ;
                                            OV_accion       := 'INSERT';
                                            OV_sqlcode      := '-20106';
                                            OV_sqlerrm   := 'ERROR AL INSERTAR EN LA TABLA ICC_MOVIMIENTO';
                                            RETURN;
                               END;
                        END IF; 
                          
                           Ind  := 0; -- 75629  ZMH  09/01/2009
                           GV_SERIE_ANTERIOR:= NULL;  -- P-MIX-09003-Guatemala-Salvador
                           GV_RANGO_INICIAL := null;  -- P-MIX-09003-Guatemala-Salvador
                           GV_RANGO_FINAL := null;    -- P-MIX-09003-Guatemala-Salvador
                        END LOOP;
        EXCEPTION
        WHEN OTHERS THEN
                OV_tabla     :='NP_GENERA_RANGOS_PEDIDOS_PR' ;
                OV_accion    := 'PROCEDURE';
                OV_sqlcode   := '-20107';
                OV_sqlerrm   := 'ERROR EN EL PROCEDIMIENTO NP_GENERA_RANGOS_PEDIDOS_PR';
                RETURN;
        END;


        PROCEDURE NP_INSERTAR_AL_ERRORES_WEB_PR(V_ERRORES IN AL_ERRORES_WEB%ROWTYPE,CN_fin_cola IN PLS_INTEGER) IS
        CV_cod_modgener      CONSTANT FA_INTQUEUEPROC.cod_modgener%TYPE:='LYP';
        CV_cod_aplic         CONSTANT FA_INTQUEUEPROC.cod_aplic%TYPE:='LYP';
        CN_cod_proceso       CONSTANT FA_INTQUEUEPROC.cod_proceso%TYPE:= 978;
        CN_cod_estado        CONSTANT FA_INTQUEUEPROC.cod_estado%TYPE:= 1;
        PRAGMA AUTONOMOUS_TRANSACTION;
        BEGIN
           INSERT
           INTO AL_ERRORES_WEB (NUM_ERROR,COD_PEDIDO,LIN_PEDIDO,NUM_SERIE,COD_ARTICULO,FEC_ERROR,NUM_VENTA,
                                NUM_TRASPASO_MASIVO,GLOSA_ERROR_TRASPASO,GLOSA_ERROR_VENTA,COD_ESTADO_ERROR)
           VALUES
                (AL_SEQ_ERRORES_WEB.NEXTVAL,V_ERRORES.COD_PEDIDO,V_ERRORES.LIN_PEDIDO,V_ERRORES.NUM_SERIE,V_ERRORES.COD_ARTICULO,
                 SYSDATE,V_ERRORES.NUM_VENTA,V_ERRORES.NUM_TRASPASO_MASIVO,V_ERRORES.GLOSA_ERROR_TRASPASO,
                 V_ERRORES.GLOSA_ERROR_VENTA,V_ERRORES.COD_ESTADO_ERROR);

           IF CN_fin_cola=CI_uno THEN
              UPDATE FA_INTQUEUEPROC
                  SET   cod_estado  = CN_cod_estado,
                        pid_proceso =  null
                  WHERE cod_aplic   = CV_cod_aplic
                  AND   cod_modgener= CV_cod_modgener
                  AND   cod_proceso = CN_cod_proceso;
           END IF;
          COMMIT;
        END;

         PROCEDURE NP_HISTORICO_RANGOS_SERIES_PR
         IS
            TV_errores  AL_ERRORES_WEB%ROWTYPE;
                TV_parametro GED_PARAMETROS.NOM_PARAMETRO%TYPE;
                TN_pedido_exitoso NPT_ESTADO_PEDIDO.COD_ESTADO_FLUJO%TYPE;
                TN_desv_exitoso NPT_ESTADO_PEDIDO.COD_ESTADO_FLUJO%TYPE;

                CV_cod_modgener      CONSTANT FA_INTQUEUEPROC.cod_modgener%TYPE:='LYP';
                CV_cod_aplic         CONSTANT FA_INTQUEUEPROC.cod_aplic%TYPE:='LYP';
                CN_cod_proceso       CONSTANT FA_INTQUEUEPROC.cod_proceso%TYPE:= 979;
                CN_cod_estado        CONSTANT FA_INTQUEUEPROC.cod_estado%TYPE:= 1;
                CS_cod_activacion    CONSTANT FA_INTQUEUEPROC.cod_activacion%TYPE:= 'D';
                CS_Pedido            CONSTANT NP_RANGO_SERIES_TO.ind_accion%TYPE:='A';
                CS_Devolucion        CONSTANT NP_RANGO_SERIES_TO.ind_accion%TYPE:='D';

                TYPE TYP_num_proceso IS TABLE OF NP_RANGO_SERIES_TO.num_proceso%TYPE INDEX BY BINARY_INTEGER;
                TYPE TYP_num_linea IS TABLE OF NP_RANGO_SERIES_TO.num_linea%TYPE INDEX BY BINARY_INTEGER;
                TYPE TYP_serie_inicial IS TABLE OF NP_RANGO_SERIES_TO.serie_inicial%TYPE INDEX BY BINARY_INTEGER;
                TYPE TYP_ind_accion IS TABLE OF NP_RANGO_SERIES_TO.ind_accion%TYPE INDEX BY BINARY_INTEGER;
                TYPE TYP_serie_final IS TABLE OF NP_RANGO_SERIES_TO.serie_final%TYPE INDEX BY BINARY_INTEGER;
                TYPE TYP_num_movimiento IS TABLE OF NP_RANGO_SERIES_TO.num_movimiento%TYPE INDEX BY BINARY_INTEGER;
                TYPE TYP_cod_articulo IS TABLE OF NP_RANGO_SERIES_TO.cod_articulo%TYPE INDEX BY BINARY_INTEGER;
                TYPE TYP_nom_usuario IS TABLE OF NP_RANGO_SERIES_TO.nom_usuario%TYPE INDEX BY BINARY_INTEGER;
                TYPE TYP_fec_rangos IS TABLE OF NP_RANGO_SERIES_TO.fec_rangos%TYPE INDEX BY BINARY_INTEGER;

                COL_num_proceso TYP_num_proceso;
                COL_num_linea TYP_num_linea;
                COL_serie_inicial TYP_serie_inicial;
                COL_ind_accion TYP_ind_accion;
                COL_serie_final TYP_serie_final;
                COL_num_movimiento TYP_num_movimiento;
                COL_cod_articulo TYP_cod_articulo;
                COL_nom_usuario TYP_nom_usuario;
                COL_fec_rangos TYP_fec_rangos;

                Ind PLS_INTEGER := 0;

     CURSOR ProcA_Historico (TN_accionA NP_RANGO_SERIES_TO.ind_accion%TYPE,
                             TN_accionD NP_RANGO_SERIES_TO.ind_accion%TYPE,
                             TN_estado_des NPD_ESTADO_FLUJO.cod_estado_flujo%TYPE,
                             TN_estado_ped NPD_ESTADO_FLUJO.cod_estado_flujo%TYPE)
     IS
     SELECT a.num_proceso,a.num_linea,a.serie_inicial,a.ind_accion,a.serie_final,
            a.num_movimiento,a.cod_articulo,a.nom_usuario,a.fec_rangos
     FROM NP_RANGO_SERIES_TO a, NPT_DEVOLUCION c
     WHERE c.estado_devolucion=TN_estado_des -- Devoluicones Exitosas
     AND c.cod_devolucion=a.num_proceso
     AND a.ind_accion=TN_accionD
     AND not exists (SELECT 1 FROM ICC_MOVIMIENTO b
                     WHERE b.num_movimiento=a.num_movimiento)
     UNION
     SELECT a.num_proceso,a.num_linea,a.serie_inicial,a.ind_accion,a.serie_final,
            a.num_movimiento,a.cod_articulo,a.nom_usuario,a.fec_rangos
     FROM NP_RANGO_SERIES_TO a, NPT_PEDIDO d, NPT_ESTADO_PEDIDO e
     WHERE e.cod_estado_flujo=TN_estado_ped -- Pedidos Exitosos
     AND e.cod_pedido=d.cod_pedido
     AND NVL(e.cod_pedido,e.cod_pedido) > 0                  -- MA-200606190940 ipct
     AND d.cod_pedido=a.num_proceso
     AND a.ind_accion=TN_accionA
     AND not exists (SELECT 1 FROM ICC_MOVIMIENTO b
                     WHERE b.num_movimiento=a.num_movimiento);

     BEGIN

          TV_parametro := 'DEV_PROC_EXITO';
          TV_errores:= NULL;
          TV_errores.cod_pedido:= CI_zero;
          TV_errores.glosa_error_traspaso:= 'ERROR AL RECUPERAR PARAMETRO ' || TV_parametro;

          SELECT val_parametro
          INTO  TN_desv_exitoso
          FROM GED_PARAMETROS
          WHERE  nom_parametro = TV_parametro
          AND cod_modulo = CV_cod_modulo
          AND cod_producto = CI_uno;

          TV_parametro :='PEDIDO_TARJETA_EXITO';
          TV_errores := NULL;
          TV_errores.cod_pedido := CI_zero;
          TV_errores.glosa_error_traspaso := 'ERROR AL RECUPERAR PARAMETRO ' || TV_parametro;

          SELECT val_parametro
          INTO  TN_pedido_exitoso
          FROM GED_PARAMETROS
          WHERE nom_parametro = TV_parametro
          AND cod_modulo = CV_cod_modulo1
          AND cod_producto = CI_uno;

          FOR v_pasohist IN ProcA_Historico(CS_Pedido,CS_Devolucion,TN_desv_exitoso,TN_pedido_exitoso) LOOP
                            Ind:=Ind+1;
                            COL_num_proceso(Ind):= v_pasohist.num_proceso;
                            COL_num_linea(Ind):= v_pasohist.num_linea;
                            COL_serie_inicial(Ind):= v_pasohist.serie_inicial;
                            COL_ind_accion(Ind):= v_pasohist.ind_accion;
                            COL_serie_final(Ind):= v_pasohist.serie_final;
                            COL_num_movimiento(Ind):= v_pasohist.num_movimiento;
                            COL_cod_articulo(Ind):= v_pasohist.cod_articulo;

                            TV_errores:= NULL;
                            TV_errores.cod_pedido:=v_pasohist.num_proceso;
                            TV_errores.glosa_error_traspaso:= 'ERROR AL BORRAR EN NP_RANGO_SERIES_TO ';

                            DELETE NP_RANGO_SERIES_TO
                            WHERE num_proceso = v_pasohist.num_proceso
                                  AND num_linea = v_pasohist.num_linea
                                  AND serie_inicial = v_pasohist.serie_inicial
                                  AND ind_accion = v_pasohist.ind_accion;

          END LOOP;

          TV_errores:= NULL;
          TV_errores.cod_pedido:=0;
          TV_errores.glosa_error_traspaso:= 'ERROR AL INSERTAR EN NP_RANGO_SERIES_TH ';

          FORALL v_j IN 1..Ind
                INSERT INTO NP_RANGO_SERIES_TH
                    (num_proceso,num_linea,serie_inicial,ind_accion,fec_baja,serie_final,num_movimiento,cod_articulo,nom_usuario)
                    VALUES(col_num_proceso(v_j),
                           col_num_linea(v_j),
                           col_serie_inicial(v_j),
                           col_ind_accion(v_j),
                           sysdate,
                           col_serie_final(v_j),
                           col_num_movimiento(v_j),
                           col_cod_articulo(v_j),
                           user);

                TV_errores:= NULL;
                TV_errores.cod_pedido:=0;
                TV_errores.glosa_error_traspaso:= 'ERROR AL DESACTIVAR LA COLA DEL SCHEDULER ';

                UPDATE FA_INTQUEUEPROC
                SET   cod_estado  = CN_cod_estado,
                      pid_proceso =  NULL,
                      cod_activacion=CS_cod_activacion
                WHERE cod_aplic   = CV_cod_aplic
                AND   cod_modgener= CV_cod_modgener
                AND   cod_proceso = CN_cod_proceso;

                COMMIT;

     EXCEPTION
        WHEN OTHERS THEN
            TV_errores.glosa_error_traspaso:=TV_errores.glosa_error_traspaso || ' - ' || to_char(SQLCODE);
            NP_INSERTAR_AL_ERRORES_WEB_PR(TV_errores,CI_uno);
            ROLLBACK;
     END;

END NP_ACTIVACION_TARJETAS_PG; 
/

