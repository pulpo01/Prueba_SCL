CREATE OR REPLACE PACKAGE BODY AL_TRASPASO_WS_PG
IS
------------------------------------------------------------------------------------------------------
FUNCTION valida_traspaso_fn(ev_num_serie    IN al_series.num_serie%TYPE,
                            en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                            en_lin_traspaso IN al_lin_traspaso.lin_traspaso%TYPE,
                            en_tipstock     IN al_tipos_stock.tip_stock%TYPE,
                            en_articulo     IN al_articulos.cod_articulo%TYPE,
                            en_uso          IN al_usos.cod_uso%TYPE,
                            en_estado       IN al_estados.cod_estado%TYPE,
                            en_bodega_ori   IN al_bodegas.cod_bodega%TYPE,
                            en_num_peticion IN al_cab_peticion.num_peticion%TYPE,
                            en_bodega_serie IN al_series.cod_bodega%TYPE)
RETURN BOOLEAN
IS
    lv_existe_serie al_series.num_serie%TYPE;
    ln_articulo     al_lin_peticion.cod_articulo%TYPE;
    lv_return       VARCHAR(5);

    BEGIN

        --Se Valida que el Articulo de la Serie este dentro de los articulos ingresados en la AL_LIN_PETICION
        BEGIN

            SELECT cod_articulo
            INTO   ln_articulo
            FROM   al_lin_peticion
            WHERE  num_peticion = en_num_peticion
            AND    cod_articulo = en_articulo;

            lv_return := 'TRUE';

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                al_graba_error_traspaso_pr(en_articulo,ev_num_serie, en_num_traspaso, en_lin_traspaso, 9, 0);
                RETURN FALSE;
        END;

        --Se Valida que la serie pertenesca a la bodega origen del traspaso
        BEGIN
            IF en_bodega_ori <> en_bodega_serie THEN
                al_graba_error_traspaso_pr(en_articulo,ev_num_serie, en_num_traspaso, en_lin_traspaso, 10, 0);
                RETURN FALSE;
            END IF;
        END;

        BEGIN

            SELECT a.num_serie
            INTO   lv_existe_serie
            FROM   al_localiza b, ged_codigos c, ged_codigos d, al_stock_localizacion e, al_series a
            WHERE  a.num_serie = ev_num_serie
            AND    a.tip_stock = en_tipstock
            AND    a.cod_bodega = en_bodega_ori
            AND    a.cod_articulo = en_articulo
            AND    a.cod_uso = en_uso
            AND    a.cod_estado = en_estado
            AND    a.num_sec_loca = b.num_sec_loca(+)
            AND    a.num_sec_loca = e.num_sec_loca(+)
            AND    a.cod_articulo = e.cod_articulo(+)
            AND    b.cod_zona = d.cod_valor(+)
            AND    b.cod_rack = c.cod_valor(+)
            AND    c.cod_modulo(+) = cv_cod_modulo
            AND    c.nom_tabla(+) = cv_nom_tabla
            AND    c.nom_columna(+) = cv_nom_columna1
            AND    d.cod_modulo(+) = cv_cod_modulo
            AND    d.nom_tabla(+) = cv_nom_tabla
            AND    d.nom_columna(+) = cv_nom_columna2;

            lv_return := 'TRUE';

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                al_graba_error_traspaso_pr(en_articulo,ev_num_serie, en_num_traspaso, en_lin_traspaso, 1, 0);
                RETURN FALSE;
            WHEN TOO_MANY_ROWS  THEN
                al_graba_error_traspaso_pr(en_articulo,ev_num_serie, en_num_traspaso, en_lin_traspaso, 2, 0);
                RETURN FALSE;
            WHEN OTHERS THEN
                raise_application_error(SQLCODE, SQLERRM);
                RETURN FALSE;
        END;

        BEGIN
            lv_existe_serie := '' ;

            SELECT a.num_serie
            INTO   lv_existe_serie
            FROM   al_ser_traspaso a, al_traspasos b
            WHERE  a.num_serie = ev_num_serie
            AND    a.num_traspaso <> en_num_traspaso
            AND    a.num_traspaso = b.num_traspaso
            AND    b.cod_estado <> 'RM';

            lv_return := 'TRUE';

            IF lv_existe_serie = ev_num_serie THEN
                lv_return := 'FALSE';
                al_graba_error_traspaso_pr(en_articulo,ev_num_serie, en_num_traspaso, en_lin_traspaso, 6, 0);
            END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN TRUE;
            WHEN TOO_MANY_ROWS  THEN
                al_graba_error_traspaso_pr(en_articulo,ev_num_serie, en_num_traspaso, en_lin_traspaso, 3, 0);
                RETURN FALSE;
            WHEN OTHERS THEN
                raise_application_error(SQLCODE, SQLERRM);
                RETURN FALSE;
        END;

        IF lv_return = 'TRUE' THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END;

------------------------------------------------------------------------------------------------------
FUNCTION obt_uso_articulo_fn(en_cod_articulo IN al_articulos.cod_articulo%TYPE,
                             sn_cod_uso      OUT NOCOPY NUMBER)
RETURN BOOLEAN
IS
    lv_existe_serie al_series.num_serie%TYPE;
    lv_return       VARCHAR(5);
    ln_contador     NUMBER;
    lv_des_articulo al_articulos.des_articulo%TYPE;
    ln_pocision     NUMBER;
    lv_parametro    ged_parametros.val_parametro%TYPE;

    BEGIN

        -- Se Valida si articulo es Rasca
        SELECT COUNT(0)
        INTO   ln_contador
        FROM   al_articulos
        WHERE  tip_articulo = 22 --Tip_Articulo 22 es Rasca
        AND    cod_articulo = en_cod_articulo;

        IF ln_contador > 0 THEN
            --Articulo es Rasca el cod_uso es por defecto 3
            sn_cod_uso := 3;
            RETURN TRUE;
        END IF;

        --Se valida si articulo es terminal
        SELECT COUNT(0)
        INTO   ln_contador
        FROM   al_articulos
        WHERE  tip_terminal = 'T' -- tipo terminal
        AND    cod_articulo = en_cod_articulo;

        IF ln_contador > 0 THEN
            --Articulo es de tipo terminal el cod_uso esta configurado en el parametro USO_TRAS_TER
            SELECT val_parametro
            INTO   lv_parametro
            FROM   ged_parametros
            WHERE  nom_parametro = 'USO_TRAS_TER'
            AND    cod_modulo = 'GA'
            AND    cod_producto = 1;

            sn_cod_uso := TO_NUMBER(TRIM(lv_parametro));

            RETURN TRUE;
        END IF;

        --Se valida si articulo es Simcard
        SELECT COUNT(0)
        INTO   ln_contador
        FROM   al_articulos
        WHERE  tip_terminal = 'G' --
        AND    cod_articulo = en_cod_articulo;

        IF ln_contador > 0 THEN

            --Articulo es de tipo Simcard
            SELECT des_articulo
            INTO   lv_des_articulo
            FROM   al_articulos
            WHERE  tip_terminal = 'G' -- tipo simcard
            AND    cod_articulo = en_cod_articulo;

            --Se consulta si simcard es pospago
            SELECT INSTR(lv_des_articulo,'POSPAGO')INTO ln_pocision FROM dual;

            IF ln_pocision > 0 THEN
                sn_cod_uso := 2;
                RETURN TRUE;
            END IF;

            --Se consulta si simcard es prepago
            SELECT INSTR(lv_des_articulo,'PREPAGO')INTO ln_pocision FROM dual;

            IF ln_pocision > 0 THEN
                sn_cod_uso := 3;
                RETURN TRUE;
            END IF;

            --Se consulta si simcard es control
            SELECT INSTR(lv_des_articulo,'CONTROL')INTO ln_pocision FROM dual;

            IF ln_pocision > 0 THEN
                sn_cod_uso := 10;
                RETURN TRUE;
            ELSE
                RETURN FALSE;
            END IF;
        ELSE
            RETURN FALSE;
        END IF;
    END;

------------------------------------------------------------------------------------------------------
FUNCTION val_exis_serie_fn(ev_num_serie    IN al_series.num_serie%TYPE,
                           en_cod_articulo IN al_articulos.cod_articulo%TYPE,
                           en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                           en_lin_traspaso IN al_lin_traspaso.lin_traspaso%TYPE,
                           en_estado       IN al_estados.cod_estado%TYPE)
RETURN BOOLEAN
IS
    ln_contador     NUMBER;

    BEGIN
        --Se valida si la serie existe en la al_series
        DBMS_OUTPUT.PUT_LINE('aNTES DE LA QUERY DE SERIES');
        SELECT COUNT(0)
        INTO   ln_contador
        FROM   al_series
        WHERE  num_serie = ev_num_serie
        AND    cod_articulo = en_cod_articulo;

        IF ln_contador > 0 THEN
            -- se valida si el estado de la serie es el correcto

            SELECT COUNT(0)
            INTO   ln_contador
            FROM   al_series
            WHERE  num_serie = ev_num_serie
            AND    cod_articulo = en_cod_articulo
            AND    cod_estado = en_estado;

            IF ln_contador > 0 THEN
                RETURN TRUE;
            ELSE
                al_graba_error_traspaso_pr(en_cod_articulo,ev_num_serie, en_num_traspaso, en_lin_traspaso, 8, 0);
                RETURN FALSE;
            END IF;
        ELSE
            al_graba_error_traspaso_pr(en_cod_articulo,ev_num_serie, en_num_traspaso, en_lin_traspaso, 1, 0);
            RETURN FALSE;
        END IF;
    END;
------------------------------------------------------------------------------------------------------
PROCEDURE al_total_cantidad_traspaso_pr(en_num_traspaso  IN al_lin_traspaso.num_traspaso%TYPE,
                                        sn_cantidad      OUT NOCOPY NUMBER,
                                        sn_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
                                        sv_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
                                        sn_num_evento    OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;
    ln_peticion  al_traspasos.num_peticion%TYPE;
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'SELECT SUM(can_traspaso) '
                || 'FROM   al_lin_traspaso  '
                || 'WHERE  num_traspaso = '||en_num_traspaso;

        SELECT num_peticion
        INTO   ln_peticion
        FROM   al_traspasos
        WHERE  num_traspaso = en_num_traspaso;

        lv_ssql := 'SELECT SUM(can_traspaso) '
                || 'FROM   al_lin_peticion '
                || 'WHERE  num_peticion = '||ln_peticion;

        SELECT SUM(can_traspaso)
        INTO   sn_cantidad
        FROM   al_lin_peticion
        WHERE  num_peticion = ln_peticion;

    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900031;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_total_cantidad_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_total_cantidad_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
    END al_total_cantidad_traspaso_pr;
------------------------------------------------------------------------------------------------------
PROCEDURE al_elimi_traspaso_temporal_pr(en_num_traspaso  IN al_series_temp_to.num_traspaso%TYPE,
                                        ev_modulo        IN al_series_temp_to.cod_modulo%TYPE,
                                        sn_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
                                        sv_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
                                        sn_num_evento    OUT NOCOPY ge_errores_pg.evento)
IS
PRAGMA AUTONOMOUS_TRANSACTION;

    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;

    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'DELETE al_series_temp_to '
                || 'WHERE  num_traspaso = '||en_num_traspaso
                || 'AND    cod_modulo = '||ev_modulo;

        DELETE al_series_temp_to
        WHERE  num_traspaso = en_num_traspaso
        AND    cod_modulo = ev_modulo;

        COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900032;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_elimi_traspaso_temporal_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_elimi_traspaso_temporal_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_elimi_traspaso_temporal_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_actualiza_peticion_pr(ev_estado       IN al_cab_peticion.cod_estado%TYPE,
                                   en_num_peticion IN al_cab_peticion.num_peticion%TYPE,
                                   sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                   sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                   sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'UPDATE AL_CAB_PETICION '
                || 'SET    COD_ESTADO = '||ev_estado
                || 'WHERE  NUM_PETICION = '||en_num_peticion;

        UPDATE AL_CAB_PETICION
        SET    COD_ESTADO = ev_estado
        WHERE  NUM_PETICION = en_num_peticion;


    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900033;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_actualiza_peticion_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_actualiza_peticion_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_actualiza_peticion_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_tip_movimiento_pr(ev_cod_proceso  IN al_procesos_tipmovim.cod_proceso%TYPE,
                               sn_tip_movim    OUT NOCOPY al_procesos_tipmovim.tip_movimiento%TYPE,
                               sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                               sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                               sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'SELECT tip_movimiento '
                || 'FROM   al_procesos_tipmovim '
                || 'WHERE  cod_proceso = '||ev_cod_proceso;

        SELECT tip_movimiento
        INTO   sn_tip_movim
        FROM   al_procesos_tipmovim
        WHERE  cod_proceso = ev_cod_proceso;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            sn_cod_retorno := 900034;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_datos_peticion_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_tip_movimiento_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
        WHEN OTHERS THEN
            sn_cod_retorno := 900035;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_datos_peticion_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_tip_movimiento_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_tip_movimiento_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_bodega_ori_traspaso_pr(en_num_traspaso   IN al_traspasos.num_traspaso%TYPE,
                                       sn_cod_bodega_ori OUT NOCOPY al_traspasos.cod_bodega_ori%TYPE,
                                    sn_cod_retorno    OUT NOCOPY ge_errores_pg.coderror,
                                    sv_mens_retorno   OUT NOCOPY ge_errores_pg.msgerror,
                                    sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'SELECT cod_bodega_ori '
                || 'FROM   al_traspaso '
                || 'WHERE  num_traspaso = '||en_num_traspaso;

        SELECT cod_bodega_ori
        INTO   sn_cod_bodega_ori
        FROM   al_traspasos
        WHERE  num_traspaso = en_num_traspaso;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            sn_cod_retorno := 900036;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_bodega_ori_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_bodega_ori_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
        WHEN OTHERS THEN
            sn_cod_retorno := 900037;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_bodega_ori_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_bodega_ori_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_bodega_ori_traspaso_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_upd_estad_traspaso_pr(ev_estado       IN al_traspasos.cod_estado%TYPE,
                                   en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                   sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                   sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                   sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'UPDATE AL_TRASPASOS '
                || 'SET    COD_ESTADO = '||ev_estado
                || 'WHERE  NUM_TRASPASO = '||en_num_traspaso;

        UPDATE AL_TRASPASOS
        SET    COD_ESTADO = ev_estado
        WHERE  NUM_TRASPASO = en_num_traspaso;

    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900038;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_upd_estad_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_upd_estad_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_upd_estad_traspaso_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_actualiza_traspaso_pr(ev_cod_estado   IN al_traspasos.cod_estado%TYPE,
                                   en_movim_env    IN al_traspasos.tip_movim_env%TYPE,
                                   en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                   sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                   sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                   sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'UPDATE al_traspasos '
                || 'SET    cod_estado = '||ev_cod_estado||','
                || '       tip_movim_env = '||en_movim_env||','
                || '       fec_despacho = '||SYSDATE||','
                || '       usu_despacho = usu_autoriza,'
                || '       des_observacion = ''EJECUTADO POR INTERFAZ LOGISTICA'''
                || 'WHERE  NUM_TRASPASO = '||en_num_traspaso;

        UPDATE al_traspasos
        SET cod_estado = ev_cod_estado,
            tip_movim_env = en_movim_env,
            fec_despacho = SYSDATE,
            usu_despacho = usu_autoriza,
            des_observacion = 'EJECUTADO POR INTERFAZ LOGISTICA'
        WHERE num_traspaso = en_num_traspaso;

    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900039;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_actualiza_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_actualiza_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_actualiza_traspaso_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_upd_guia_traspaso_pr(ev_guia         IN al_traspasos.num_guia%TYPE,
                                  en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                  sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                  sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                  sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'UPDATE AL_TRASPASOS '
                || 'SET    NUM_GUIA = '||ev_guia
                || 'WHERE  NUM_TRASPASO = '||en_num_traspaso;

        UPDATE AL_TRASPASOS
        SET    NUM_GUIA = ev_guia
        WHERE  NUM_TRASPASO = en_num_traspaso;

    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900040;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_upd_guia_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_upd_guia_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_upd_guia_traspaso_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_seleccion_masiva_pr(en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                 en_estado       IN al_estados.cod_estado%TYPE,
                                 en_tipstock     IN al_tipos_stock.tip_stock%TYPE,
                                 sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
PRAGMA AUTONOMOUS_TRANSACTION;

    le_error           EXCEPTION;
    ln_cantida         NUMBER;
    ln_bodega_ori      al_bodegas.cod_bodega%TYPE;
    ln_ser_ing         al_lin_traspaso.can_traspaso%TYPE;
    li_error           PLS_INTEGER;
    ln_num_peticion    al_traspasos.num_peticion%TYPE;
    ln_cant_traspaso   al_lin_peticion.can_traspaso%TYPE;
    lv_ssql            ge_errores_pg.vquery;
    lv_des_error       ge_errores_pg.desevent;
    lv_cod_uso         al_lin_traspaso.cod_uso%TYPE;
    ln_cod_articulo    al_articulos.cod_articulo%TYPE;
    ln_can_traspaso    al_lin_peticion.can_traspaso%TYPE;
    ln_contador        NUMBER;
    ln_cantidad2       NUMBER;
    ln_cont_lineas     NUMBER;
    ln_cont_lineas_aux NUMBER;

    CURSOR c_ser_tras_mas IS
        SELECT a.num_serie,b.num_telefono, b.cap_code, b.cod_central, b.cod_subalm,
               b.cod_cat, b.num_sec_loca, b.num_seriemec, a.lin_traspaso,
               b.cod_articulo, b.cod_uso, b.cod_bodega, a.cod_error
        FROM   al_series_temp_to a, al_series b
        WHERE  a.cod_modulo = cv_cod_modulo
        AND    a.proc_invocador = cv_proc_invo_aut
        AND    a.num_traspaso = en_num_traspaso
        AND    a.num_serie = b.num_serie(+);

    CURSOR c_lin_peticiones (snum_peticion al_lin_peticion.num_peticion%TYPE) IS
        SELECT cod_articulo, can_traspaso
        FROM   al_lin_peticion
        WHERE  num_peticion = snum_peticion;


    BEGIN


        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;
        ln_cont_lineas  := 0;

        lv_ssql := 'SELECT cod_bodega_ori '
                || 'FROM   al_traspasos '
                || 'WHERE  num_traspaso = '||en_num_traspaso;

        SELECT cod_bodega_ori, num_peticion
        INTO   ln_bodega_ori, ln_num_peticion
        FROM   al_traspasos
        WHERE  num_traspaso = en_num_traspaso;

        li_error := 2;

        lv_ssql := 'UPDATE al_series_temp_to and '
                || 'SET    a.cod_articulo = (SELECT b.cod_articulo FROM al_series b WHERE b.num_serie = a.num_serie) '
                || 'WHERE  a.num_traspaso = '||en_num_traspaso;

        UPDATE al_series_temp_to a
        SET    a.cod_articulo = (SELECT b.cod_articulo FROM al_series b WHERE b.num_serie = a.num_serie)
        WHERE  a.num_traspaso = en_num_traspaso;

        --Inicio Se valida cantidad de Articulos
        OPEN c_lin_peticiones (ln_num_peticion);
        LOOP
            FETCH c_lin_peticiones INTO ln_cod_articulo,ln_can_traspaso;
            EXIT WHEN c_lin_peticiones%NOTFOUND;

            ln_contador := 0;

            /*FOR lc_ser_val IN c_ser_tras_mas LOOP
                IF ln_cod_articulo = lc_ser_val.cod_articulo THEN
                    ln_contador := ln_contador + 1;
                END IF;
            END LOOP;*/

            SELECT COUNT(0)
            INTO   ln_contador
            FROM   al_series_temp_to
            WHERE  cod_articulo = ln_cod_articulo
            AND    num_traspaso = en_num_traspaso;

            IF ln_can_traspaso <> ln_contador THEN
                al_graba_error_validacion_pr(ln_cod_articulo,en_num_traspaso,11);
            END IF;

        END LOOP;
        CLOSE c_lin_peticiones;

        COMMIT;
        --Fin Se valida cantidad de Articulos

        FOR lc_ser_tras IN c_ser_tras_mas LOOP
            IF lc_ser_tras.cod_error IS NULL THEN
                --Aca se llama a funcion que valida si la serie existe en la Tabla AL_SERIES
                IF NOT val_exis_serie_fn(lc_ser_tras.num_serie,lc_ser_tras.cod_articulo,en_num_traspaso, lc_ser_tras.lin_traspaso, en_estado) THEN
                    sn_cod_retorno := 0;
                ELSE
                    -- Aca se llama a funcion que obtiene el cod_uso del articulo
                    lv_cod_uso := 0;
                    IF NOT obt_uso_articulo_fn(lc_ser_tras.cod_articulo, lv_cod_uso) THEN
                        sn_cod_retorno := 0;
                        --RAISE le_error;
                    ELSE
                        IF NOT valida_traspaso_fn(lc_ser_tras.num_serie, en_num_traspaso, lc_ser_tras.lin_traspaso, en_tipstock, lc_ser_tras.cod_articulo, lv_cod_uso, en_estado, ln_bodega_ori, ln_num_peticion, lc_ser_tras.cod_bodega) OR en_estado <> 1 THEN
                            sn_cod_retorno := 0;
                            --RAISE le_error;
                        ELSE
                            --Consulta si existe alguna serie con error en la al_series_temp_to
                            
                            --BEGIN
                            
                            SELECT COUNT(0)
                            INTO   ln_cantidad2
                            FROM   al_series_temp_to
                            WHERE  num_traspaso = en_num_traspaso
                            AND    cod_error IS NOT NULL;
                            
                            --exception 
                            --    when ln_cantidad2 > 0 THEN    

                            --IF ln_cantidad2 > 0 THEN                                
                                --ROLLBACK;
                            --ELSE
                            IF ln_cantidad2 = 0 THEN

                                /*lv_ssql := 'SELECT COUNT(num_serie) '
                                        || 'FROM   al_ser_traspaso '
                                        || 'WHERE  num_traspaso = '||en_num_traspaso
                                        || 'AND    lin_traspaso = '||lc_ser_tras.lin_traspaso;

                                SELECT COUNT(num_serie)
                                INTO   ln_ser_ing
                                FROM   al_ser_traspaso
                                WHERE  num_traspaso = en_num_traspaso
                                AND    lin_traspaso = lc_ser_tras.lin_traspaso;*/
                                
                                lv_ssql := 'SELECT COUNT(0) '
                                        || 'FROM   al_lin_traspaso '
                                        || 'WHERE  num_traspaso = '||en_num_traspaso||' '
                                        || 'AND    cod_articulo = '||lc_ser_tras.cod_articulo;
                                
                                SELECT COUNT(0)
                                INTO   ln_ser_ing 
                                FROM   al_lin_traspaso
                                WHERE  num_traspaso = en_num_traspaso
                                AND    cod_articulo = lc_ser_tras.cod_articulo;

                                IF ln_ser_ing = 0 THEN

                                    lv_ssql := 'SELECT num_peticion '
                                            || 'FROM   al_traspasos '
                                            || 'WHERE  num_traspaso = '||en_num_traspaso;

                                    SELECT num_peticion
                                    INTO   ln_num_peticion
                                    FROM   al_traspasos
                                    WHERE  num_traspaso = en_num_traspaso;

                                    lv_ssql := 'SELECT can_traspaso '
                                            || 'FROM   al_lin_peticion '
                                            || 'WHERE  num_peticion = '||ln_num_peticion
                                            || 'AND    cod_articulo = '||lc_ser_tras.cod_articulo;

                                    SELECT can_traspaso
                                    INTO   ln_cant_traspaso
                                    FROM   al_lin_peticion
                                    WHERE  num_peticion = ln_num_peticion
                                    AND    cod_articulo = lc_ser_tras.cod_articulo;
                                    
                                    ln_cont_lineas := ln_cont_lineas + 1;
                                    ln_cont_lineas_aux := ln_cont_lineas;

                                    lv_ssql := 'INSERT INTO al_lin_traspaso '
                                            || '    (num_traspaso, lin_traspaso, tip_stock, cod_articulo, cod_uso, cod_estado, can_traspaso,fec_entrada,num_sec_loca_ori) '
--                                            || 'VALUES ('||en_num_traspaso||','||lc_ser_tras.lin_traspaso||','||en_tipstock||','||lc_ser_tras.cod_articulo||','||lv_cod_uso
                                            || 'VALUES ('||en_num_traspaso||','||ln_cont_lineas||','||en_tipstock||','||lc_ser_tras.cod_articulo||','||lv_cod_uso
                                            ||','|| en_estado||','||ln_cant_traspaso||','||SYSDATE||',NULL)';

                                    INSERT INTO al_lin_traspaso
                                        (num_traspaso, lin_traspaso, tip_stock, cod_articulo, cod_uso, cod_estado, can_traspaso,fec_entrada,num_sec_loca_ori)
--                                    VALUES (en_num_traspaso, lc_ser_tras.lin_traspaso, en_tipstock, lc_ser_tras.cod_articulo, lv_cod_uso, en_estado, ln_cant_traspaso,SYSDATE,NULL);
                                    VALUES (en_num_traspaso, ln_cont_lineas, en_tipstock, lc_ser_tras.cod_articulo, lv_cod_uso, en_estado, ln_cant_traspaso,SYSDATE,NULL);
                                ELSE
                                    
                                    lv_ssql := 'SELECT lin_traspaso '
                                            || 'FROM   al_lin_traspaso ' 
                                            || 'WHERE  num_traspaso = '||en_num_traspaso||' '
                                            || 'AND    cod_articulo = '||lc_ser_tras.cod_articulo;
                                    
                                    SELECT lin_traspaso
                                    INTO   ln_cont_lineas_aux 
                                    FROM   al_lin_traspaso 
                                    WHERE  num_traspaso = en_num_traspaso
                                    AND    cod_articulo = lc_ser_tras.cod_articulo;                                    
                                
                                END IF;

                                BEGIN
                                    lv_ssql := 'INSERT INTO al_ser_traspaso '
                                            || '       (num_traspaso, lin_traspaso, num_serie, cap_code, num_telefono, num_seriemec, cod_central, cod_subalm, cod_cat,  num_sec_loca_ori) '
--                                            || 'VALUES ('||en_num_traspaso||','||lc_ser_tras.lin_traspaso||','||lc_ser_tras.num_serie||','||lc_ser_tras.cap_code||','||lc_ser_tras.num_telefono
                                            || 'VALUES ('||en_num_traspaso||','||ln_cont_lineas_aux||','||lc_ser_tras.num_serie||','||lc_ser_tras.cap_code||','||lc_ser_tras.num_telefono
                                            ||','||lc_ser_tras.num_seriemec||','||lc_ser_tras.cod_central||','||lc_ser_tras.cod_subalm||','||lc_ser_tras.cod_cat||','||lc_ser_tras.num_sec_loca||')';

                                    INSERT INTO al_ser_traspaso
                                           (num_traspaso, lin_traspaso, num_serie, cap_code, num_telefono, num_seriemec, cod_central, cod_subalm, cod_cat,  num_sec_loca_ori)
--                                    VALUES (en_num_traspaso, lc_ser_tras.lin_traspaso, lc_ser_tras.num_serie, lc_ser_tras.cap_code, lc_ser_tras.num_telefono, lc_ser_tras.num_seriemec,
                                    VALUES (en_num_traspaso, ln_cont_lineas_aux, lc_ser_tras.num_serie, lc_ser_tras.cap_code, lc_ser_tras.num_telefono, lc_ser_tras.num_seriemec,
                                            lc_ser_tras.cod_central, lc_ser_tras.cod_subalm, lc_ser_tras.cod_cat, lc_ser_tras.num_sec_loca);

                                    EXCEPTION
                                    WHEN DUP_VAL_ON_INDEX THEN
                                        ROLLBACK;
                                        al_graba_error_traspaso_pr(lc_ser_tras.cod_articulo,lc_ser_tras.num_serie, en_num_traspaso, lc_ser_tras.lin_traspaso, 6, 0);
                                    WHEN OTHERS THEN
                                        ROLLBACK;
                                        al_graba_error_traspaso_pr(lc_ser_tras.cod_articulo,lc_ser_tras.num_serie, en_num_traspaso, lc_ser_tras.lin_traspaso, 7, 0);
                                END;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
        END LOOP;

        COMMIT;

    EXCEPTION
        WHEN le_error THEN
            ROLLBACK;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_valida_peticion_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_valida_peticion_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);

        WHEN NO_DATA_FOUND THEN
            ROLLBACK;
            sn_cod_retorno := 900042;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_valida_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_valida_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
        WHEN OTHERS THEN
            ROLLBACK;
            sn_cod_retorno := 900056;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            sv_mens_retorno := 'Ocurrio un error al obtener el tipo de valoracion del stock';
            lv_des_error  :='AL_TRASPASO_WS_PG.al_valida_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_valida_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
    END al_seleccion_masiva_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_graba_error_traspaso_pr (en_articulo      IN al_articulos.cod_articulo%TYPE,
                                      ev_num_serie     IN al_series.num_serie%TYPE,
                                      en_num_traspaso  IN al_traspasos.num_traspaso%TYPE,
                                      en_lin_traspaso  IN al_lin_traspaso.lin_traspaso%TYPE,
                                      en_cod_error     IN PLS_INTEGER,
                                      en_opcion        IN PLS_INTEGER,
                                      en_bodega_ori    IN al_traspasos_masivo.cod_bodega_ori%TYPE DEFAULT NULL,
                                      en_bodega_dest   IN al_traspasos_masivo.cod_bodega_dest%TYPE DEFAULT NULL)
IS

    BEGIN
        IF en_opcion = 0 THEN
            UPDATE al_series_temp_to
            SET    cod_error = en_cod_error
            WHERE  cod_modulo = cv_cod_modulo
            AND    proc_invocador = cv_proc_invo_aut
            AND    num_traspaso = en_num_traspaso
            AND    lin_traspaso = en_lin_traspaso
            AND    num_serie = ev_num_serie;
        END IF;
        IF en_opcion = 1 THEN
            INSERT INTO al_series_temp_to
                   (cod_modulo, proc_invocador, num_traspaso, lin_traspaso, num_serie, cod_articulo, cod_error)
            VALUES (cv_cod_modulo, cv_proc_invo_tra, en_num_traspaso, 1, ev_num_serie, en_articulo, en_cod_error);
            IF en_opcion = 1 THEN
                DELETE al_traspasos_masivo
                WHERE  num_traspaso_masivo = en_num_traspaso
                AND    num_serie = ev_num_serie;
            END IF;
        END IF;
        IF en_opcion = 2 THEN
            INSERT INTO al_series_temp_to
                   (cod_modulo, proc_invocador, num_traspaso, lin_traspaso, num_serie,  cod_error, num_sec_loca_ori, num_sec_loca_dest )
            VALUES (cv_cod_modulo, cv_proc_invo_tra, en_num_traspaso, 1, ev_num_serie, en_cod_error, en_bodega_ori, en_bodega_dest );
        END IF;
    END al_graba_error_traspaso_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_graba_error_validacion_pr (en_articulo      IN al_articulos.cod_articulo%TYPE,
                                        en_num_traspaso  IN al_traspasos.num_traspaso%TYPE,
                                        en_cod_error     IN PLS_INTEGER)
IS

    BEGIN

        UPDATE al_series_temp_to
        SET    cod_error = en_cod_error
        WHERE  cod_modulo = cv_cod_modulo
        AND    proc_invocador = cv_proc_invo_aut
        AND    num_traspaso = en_num_traspaso
        AND    cod_articulo = en_articulo;

    END al_graba_error_validacion_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_cons_series_error_pr(en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                  ev_invocador    IN al_series_temp_to.proc_invocador%TYPE,
                                  ev_modulo       IN al_errores_temp_to.cod_modulo%TYPE,
                                  sn_cantidad     OUT NOCOPY NUMBER,
                                  sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                  sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                  sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;

    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        SELECT COUNT(0)
        INTO   sn_cantidad
        FROM   al_series_temp_to a, al_errores_temp_to b
        WHERE  num_traspaso = en_num_traspaso
        AND    a.cod_error > 0
        AND    a.proc_invocador = ev_invocador
        AND    a.proc_invocador =b.proc_invocador
        AND    b.cod_modulo = ev_modulo
        AND    a.cod_error = b.cod_error;

    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900043;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_cons_series_error_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_cons_series_error_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
    END al_cons_series_error_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_obt_series_error_pr(en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                 ev_invocador    IN al_series_temp_to.proc_invocador%TYPE,
                                 ev_modulo       IN al_errores_temp_to.cod_modulo%TYPE,
                                 sc_cursordatos  OUT NOCOPY refcursor,
                                 sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
    le_error     EXCEPTION;
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'SELECT UNIQUE a.num_serie, b.des_error '
                || 'FROM   al_series_temp_to a, al_errores_temp_to b '
                || 'WHERE  num_traspaso = '||en_num_traspaso
                || 'AND    a.cod_error > 0 '
                || 'AND    a.proc_invocador = '||ev_invocador
                || 'AND    a.proc_invocador = b.proc_invocador '
                || 'AND    b.cod_modulo = '||ev_modulo
                || 'AND    a.cod_error = b.cod_error';

        OPEN sc_cursordatos FOR
            SELECT UNIQUE a.num_serie, b.des_error
            FROM   al_series_temp_to a, al_errores_temp_to b
            WHERE  num_traspaso = en_num_traspaso
            AND    a.cod_error > 0
            AND    a.proc_invocador = ev_invocador
            AND    a.proc_invocador =b.proc_invocador
            AND    b.cod_modulo = ev_modulo
            AND    a.cod_error = b.cod_error
            and    a.cod_error <> 11;-- Error de linea

    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900044;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_obt_series_error_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_obt_series_error_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
    END al_obt_series_error_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_obt_lineas_error_pr(en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                 ev_invocador    IN al_series_temp_to.proc_invocador%TYPE,
                                 ev_modulo       IN al_errores_temp_to.cod_modulo%TYPE,
                                 sc_cursordatos  OUT NOCOPY refcursor,
                                 sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
    le_error     EXCEPTION;
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'SELECT a.cod_articulo, b.des_error, COUNT(0) '
                || 'FROM   al_series_temp_to a, al_errores_temp_to b '
                || 'WHERE  num_traspaso = '||en_num_traspaso
                || 'AND    a.cod_error = 11 '
                || 'AND    a.proc_invocador = '||ev_invocador
                || 'AND    a.proc_invocador = b.proc_invocador '
                || 'AND    b.cod_modulo = '||ev_modulo
                || 'AND    a.cod_error = b.cod_error'
                || 'GROUP BY a.cod_articulo, b.des_error';

        OPEN sc_cursordatos FOR
           SELECT a.cod_articulo, b.des_error, COUNT(0)
           FROM   al_series_temp_to a, al_errores_temp_to b
           WHERE  num_traspaso = en_num_traspaso
           AND    a.cod_error = 11 --Error linea
           AND    a.proc_invocador = ev_invocador
           AND    a.proc_invocador =b.proc_invocador
           AND    b.cod_modulo = ev_modulo
           AND    a.cod_error = b.cod_error
           GROUP BY a.cod_articulo, b.des_error;

    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900044;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_obt_lineas_error_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_obt_lineas_error_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
    END al_obt_lineas_error_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_valida_traspaso_pr(en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                ev_cod_estado   IN al_traspasos.cod_estado%TYPE,
                                sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
    le_error     EXCEPTION;
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'SELECT COUNT(0) '
                || 'FROM   al_traspasos '
                || 'WHERE  num_traspaso = '||en_num_traspaso
                || 'AND    cod_estado = '||ev_cod_estado;

        SELECT COUNT(0)
        INTO   ln_contador
        FROM   al_traspasos
        WHERE  num_traspaso = en_num_traspaso
        AND    cod_estado = ev_cod_estado;

        IF ln_contador = 0 THEN
            sn_cod_retorno := 900045;
            RAISE le_error;
        END IF;

    EXCEPTION
        WHEN le_error THEN
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_valida_peticion_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_valida_peticion_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
        WHEN OTHERS THEN
            sn_cod_retorno := 900046;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_valida_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_valida_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
    END al_valida_traspaso_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_obt_operadora_pr(sv_operadora    OUT NOCOPY ge_parametros_sistema_vw.valor_texto%TYPE,
                              sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                              sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                              sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'SELECT valor_texto '
                || 'FROM   ge_parametros_sistema_vw '
                || 'WHERE  nom_parametro = ''COD_OPERADORA_LOCAL'''
                || 'AND    cod_modulo = ''GE''';

        SELECT valor_texto
        INTO   sv_operadora
        FROM   ge_parametros_sistema_vw
        WHERE  nom_parametro = 'COD_OPERADORA_LOCAL'
        AND    cod_modulo = 'GE';

    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900047;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_obt_operadora_prr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_obt_operadora_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
    END al_obt_operadora_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_obt_stock_traspaso_pr(en_num_traspaso IN al_lin_traspaso.num_traspaso%TYPE,
                                   sc_cursordatos  OUT NOCOPY refcursor,
                                   sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                   sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                   sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'SELECT a.tip_stock, a.cod_articulo, a.cod_uso, a.cod_estado,'
                || '           a.can_traspaso, a.fec_entrada, a.num_guia, b.ind_seriado'
                || 'FROM   al_lin_traspaso a, al_articulos b '
                || 'WHERE  a.num_traspaso = '||en_num_traspaso
                || 'AND    a.cod_articulo = b.cod_articulo ';

        OPEN sc_cursordatos FOR
            SELECT a.tip_stock, a.cod_articulo, a.cod_uso, a.cod_estado,
                   a.can_traspaso, TO_CHAR(a.fec_entrada,'DD-MM-YYYY HH24:MI:SS'), a.num_guia, b.ind_seriado
            FROM   al_lin_traspaso a, al_articulos b
            WHERE  a.num_traspaso = en_num_traspaso
            AND    a.cod_articulo = b.cod_articulo;

    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900048;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_obt_stock_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_obt_stock_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_obt_stock_traspaso_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_obtiene_peticion_pr(en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                 sn_num_peticion OUT NOCOPY al_traspasos.num_peticion%TYPE,
                                 sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'SELECT num_peticion '
                || 'FROM   al_traspasos '
                || 'WHERE  num_traspaso = '||en_num_traspaso;

        SELECT num_peticion
        INTO   sn_num_peticion
        FROM   al_traspasos
        WHERE  num_traspaso = en_num_traspaso;

    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900049;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_obtiene_peticion_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_obtiene_peticion_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
    END al_obtiene_peticion_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_obt_cant_stock_pr(en_cod_articulo   IN al_stock.cod_articulo%TYPE,
                               en_cod_bodega     IN al_stock.cod_bodega%TYPE,
                               en_disponibilidad IN al_estados.ind_disponibilidad%TYPE,
                               ev_estados        IN VARCHAR2,
                               en_cod_uso        IN al_stock.cod_uso%TYPE,
                               sv_cant_stock     OUT NOCOPY al_stock.can_stock%TYPE,
                               sn_cod_retorno    OUT NOCOPY ge_errores_pg.coderror,
                               sv_mens_retorno   OUT NOCOPY ge_errores_pg.msgerror,
                               sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    lv_estado_nuevo ged_parametros.VAL_PARAMETRO%TYPE;
    lv_tipo_stock ged_parametros.VAL_PARAMETRO%TYPE;
    
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;


         SELECT VAL_PARAMETRO into lv_estado_nuevo
         FROM ged_parametros
         WHERE nom_parametro = 'ESTADO_STOCK'
         AND cod_modulo = 'AL'
         AND cod_producto = 1;
         
         SELECT VAL_PARAMETRO into lv_tipo_stock
         FROM ged_parametros
         WHERE nom_parametro = 'TIPO_STOCK'
         AND cod_modulo = 'AL'
         AND cod_producto = 1;


        lv_ssql := ' SELECT a.can_stock '
                || ' FROM   al_stock a, al_tipos_stock b, al_usos c, al_estados d '
                || ' WHERE  a.cod_articulo = '||en_cod_articulo
                || ' AND    a.cod_bodega = '||en_cod_bodega
                || ' AND    b.tip_stock = a.tip_stock'
                || ' AND    b.tip_stock = '||lv_tipo_stock
                || ' AND    c.cod_uso = a.cod_uso'
                || ' AND    d.cod_estado = a.cod_estado'
                || ' AND    d.ind_disponibilidad = '||en_disponibilidad
                || ' AND    a.cod_estado ='||lv_estado_nuevo
                || ' AND    a.cod_uso = '||en_cod_uso;

        EXECUTE IMMEDIATE lv_ssql INTO sv_cant_stock;

    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900050;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_obt_cant_stock_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_obt_cant_stock_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_obt_cant_stock_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_obt_parametro_pr(ev_nom_parametro IN ged_parametros.nom_parametro%TYPE,
                              ev_cod_modulo    IN ged_parametros.cod_modulo%TYPE,
                              sv_val_parametro OUT NOCOPY ged_parametros.val_parametro%TYPE,
                              sn_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
                              sv_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
                              sn_num_evento    OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'SELECT val_parametro '
                || 'FROM   ged_parametros '
                || 'WHERE  nom_parametro = '||ev_nom_parametro
                || 'AND    cod_modulo = '||ev_cod_modulo;

        SELECT val_parametro
        INTO   sv_val_parametro
        FROM   ged_parametros
        WHERE  nom_parametro = ev_nom_parametro
        AND    cod_modulo = ev_cod_modulo;

    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900051;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_obt_parametro_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_obt_parametro_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_obt_parametro_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_valida_autoriza_pr(en_num_traspaso  IN al_traspasos.num_traspaso%TYPE,
                                sn_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
                                sv_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
                                sn_num_evento    OUT NOCOPY ge_errores_pg.evento)
IS
    le_error     EXCEPTION;
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;

    CURSOR c_ser_tras_mas IS
        SELECT a.num_serie ns_t, b.num_serie ns_s, b.cod_uso cu_s, b.cod_estado ce_s, c.cod_uso cu_t, c.cod_estado ce_t
        FROM   al_lin_traspaso c, al_series b, al_ser_traspaso a
        WHERE  a.num_traspaso = en_num_traspaso
        AND    a.num_serie = b.num_serie(+)
        AND    a.num_traspaso = c.num_traspaso
        AND    a.lin_traspaso = c.lin_traspaso;

    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'SELECT a.num_serie ns_t, b.num_serie ns_s, b.cod_uso cu_s, b.cod_estado ce_s, c.cod_uso cu_t, c.cod_estado ce_t'
                || 'FROM al_lin_traspaso c, al_series b, al_ser_traspaso a '
                || 'WHERE  a.num_traspaso = '||en_num_traspaso
                || 'AND    a.num_serie = b.num_serie(+) '
                || 'AND    a.num_traspaso = c.num_traspaso '
                || 'AND    a.lin_traspaso = c.lin_traspaso';

        FOR lc_ser_tras IN c_ser_tras_mas LOOP
            IF lc_ser_tras.ns_s is null or trim(lc_ser_tras.ns_s) = '' THEN
                sn_cod_retorno := 900053;
                RAISE le_error;
            END IF;

            IF lc_ser_tras.cu_s <> lc_ser_tras.cu_t THEN
                sn_cod_retorno := 900054;
                RAISE le_error;
            END IF;

            IF lc_ser_tras.ce_s <> lc_ser_tras.ce_t THEN
                sn_cod_retorno := 900055;
                RAISE le_error;
            END IF;
        END LOOP;

    EXCEPTION
        WHEN le_error THEN
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_valida_autoriza_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_valida_autoriza_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
        WHEN OTHERS THEN
            sn_cod_retorno := 900052;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_valida_autoriza_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_valida_autoriza_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_valida_autoriza_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_elim_lin_traspaso_pr(en_num_traspaso  IN al_traspasos.num_traspaso%TYPE,
                                  sn_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
                                  sv_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
                                  sn_num_evento    OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;

    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'DELETE al_lin_traspaso WHERE num_traspaso = '||en_num_traspaso;

        DELETE al_lin_traspaso WHERE num_traspaso = en_num_traspaso;

    EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900052;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_elim_lin_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_elim_lin_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_elim_lin_traspaso_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_ins_esta_traspaso_pr(en_num_traspaso    IN al_traspasos.num_traspaso%TYPE,
                                  ev_estado_traspaso IN al_estado_traspaso_to.estado_traspaso%TYPE,
                                  sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                                  sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                                  sn_num_evento      OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    error_estado EXCEPTION;
    contador NUMBER;
    lv_estado al_estado_traspaso_to.ESTADO_TRASPASO%TYPE;

    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        select count(1) into contador from al_estado_traspaso_to where num_traspaso=en_num_traspaso;

        if contador >0 then
            select estado_traspaso into lv_estado from al_estado_traspaso_to where num_traspaso=en_num_traspaso;

            IF lv_estado <> 'ERRONEO' then

                sv_mens_retorno := 'El traspaso se encuentra en estado '||lv_estado;

                RAISE error_estado;

            ELSE

                DELETE al_estado_traspaso_to where num_traspaso=en_num_traspaso;

            end if;

        end if;

        lv_ssql := 'INSERT INTO al_estado_traspaso_to (num_traspaso, estado_traspaso)'
                || 'VALUES ('||en_num_traspaso||','|| ev_estado_traspaso||')';

        INSERT INTO al_estado_traspaso_to (num_traspaso, estado_traspaso)
        VALUES (en_num_traspaso, ev_estado_traspaso);

EXCEPTION
        WHEN error_estado THEN
            sn_cod_retorno := 900058;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_ins_esta_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_ins_esta_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
        WHEN OTHERS THEN
            sn_cod_retorno := 900058;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_ins_esta_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_ins_esta_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
END al_ins_esta_traspaso_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_upd_esta_traspaso_pr(en_num_traspaso    IN al_traspasos.num_traspaso%TYPE,
                                  ev_estado_traspaso IN al_estado_traspaso_to.estado_traspaso%TYPE,
                                  ev_mens_error      IN al_estado_traspaso_to.mensaje_error%TYPE,
                                  sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                                  sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                                  sn_num_evento      OUT NOCOPY ge_errores_pg.evento)
IS
PRAGMA AUTONOMOUS_TRANSACTION;

    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;

    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        lv_ssql := 'UPDATE al_estado_traspaso_to '
                || 'SET    estado_traspaso = '||ev_estado_traspaso||','
                || '       mensaje_error = '||ev_mens_error||' '
                || 'WHERE  num_traspaso = '||en_num_traspaso;

        UPDATE al_estado_traspaso_to
        SET    estado_traspaso = ev_estado_traspaso,
               mensaje_error = ev_mens_error
        WHERE  num_traspaso = en_num_traspaso;

        COMMIT;

EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900059;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_upd_esta_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_upd_esta_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_upd_esta_traspaso_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_cons_esta_traspaso_pr(en_num_traspaso    IN al_traspasos.num_traspaso%TYPE,
                                   ev_estado_traspaso OUT NOCOPY al_estado_traspaso_to.estado_traspaso%TYPE,
                                   ev_mens_error      OUT NOCOPY al_estado_traspaso_to.mensaje_error%TYPE,
                                   sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                                   sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                                   sn_num_evento      OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;

    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;
        ev_mens_error   := '';
        ev_estado_traspaso := '';

        lv_ssql := 'SELECT estado_traspaso, mensaje_error '
                || 'FROM   al_estado_traspaso_to '
                || 'WHERE  num_traspaso = '||en_num_traspaso;

        SELECT estado_traspaso, mensaje_error
        INTO   ev_estado_traspaso, ev_mens_error
        FROM   al_estado_traspaso_to
        WHERE  num_traspaso = en_num_traspaso;

        IF TRIM(ev_estado_traspaso) = cv_tras_erroneso THEN
            IF UPPER(ev_mens_error) = cv_mens_error THEN
                sn_cod_retorno  := -1;
            END IF;
        END IF;

EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900060;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_cons_esta_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_cons_esta_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_cons_esta_traspaso_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_obt_cant_traspaso_pr(en_num_traspaso    IN al_traspasos.num_traspaso%TYPE,
                                  en_cod_articulo    IN al_articulos.cod_articulo%TYPE,
                                  sn_cantidad        OUT NOCOPY al_lin_peticion.can_traspaso%TYPE,
                                  sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                                  sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                                  sn_num_evento      OUT NOCOPY ge_errores_pg.evento)
IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_peticion  al_lin_peticion.num_peticion%TYPE;

    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        SELECT num_peticion
        INTO   ln_peticion
        FROM   al_traspasos
        WHERE  num_traspaso = en_num_traspaso;

        SELECT can_traspaso
        INTO   sn_cantidad
        FROM   al_lin_peticion
        WHERE  num_peticion = ln_peticion
        AND    cod_articulo = en_cod_articulo;

EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 900060;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_obt_cant_traspaso_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_obt_cant_traspaso_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
   END al_obt_cant_traspaso_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_elimi_ser_tras_pr(en_num_traspaso    IN al_traspasos.num_traspaso%TYPE,
                               sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                               sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                               sn_num_evento      OUT NOCOPY ge_errores_pg.evento)
IS
PRAGMA AUTONOMOUS_TRANSACTION;
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_peticion  al_lin_peticion.num_peticion%TYPE;

    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        DELETE al_ser_traspaso WHERE num_traspaso = en_num_traspaso;

        COMMIT;

EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 156;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_elimi_ser_tras_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_elimi_ser_tras_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
END al_elimi_ser_tras_pr;

------------------------------------------------------------------------------------------------------
PROCEDURE al_elimi_lin_tras_pr(en_num_traspaso    IN al_traspasos.num_traspaso%TYPE,
                               sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                               sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                               sn_num_evento      OUT NOCOPY ge_errores_pg.evento)
IS
PRAGMA AUTONOMOUS_TRANSACTION;
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_peticion  al_lin_peticion.num_peticion%TYPE;

    BEGIN
        sn_num_evento   := 0;
        sv_mens_retorno := 'OK';
        sn_cod_retorno  := 0;

        DELETE al_lin_traspaso WHERE num_traspaso = en_num_traspaso;

        COMMIT;

EXCEPTION
        WHEN OTHERS THEN
            sn_cod_retorno := 156;
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_WS_PG.al_elimi_lin_tras_pr(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_WS_PG.al_elimi_lin_tras_pr',
                                                     lv_ssql,SQLCODE,lv_des_error);
END al_elimi_lin_tras_pr;

------------------------------------------------------------------------------------------------------
END AL_TRASPASO_WS_PG;
/
SHOW ERRORS