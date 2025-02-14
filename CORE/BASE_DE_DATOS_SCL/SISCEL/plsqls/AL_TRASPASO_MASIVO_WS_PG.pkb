CREATE OR REPLACE PACKAGE BODY AL_TRASPASO_MASIVO_WS_PG
IS  
------------------------------------------------------------------------------------------------------
PROCEDURE al_obtiene_numero_secuencia(ev_nombre_secuencia IN VARCHAR2,
                                      sn_num_secuencia    OUT NOCOPY NUMBER, 
                                      sn_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
                                      sv_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
                                      sn_num_evento       OUT NOCOPY ge_errores_pg.evento
                                      )
IS

    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;

BEGIN
    
    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento   := 0;
    
    lv_ssql := 'SELECT '||ev_nombre_secuencia||'.NEXTVAL FROM dual';    
    
    EXECUTE IMMEDIATE lv_ssql INTO sn_num_secuencia;

EXCEPTION
    WHEN OTHERS THEN
        sn_cod_retorno := 301028;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        ELSE
            sv_mens_retorno := sv_mens_retorno ||' '||ev_nombre_secuencia;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_obtiene_numero_secuencia(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_obtiene_numero_secuencia',
                                                     lv_ssql,SQLCODE,lv_des_error);

END al_obtiene_numero_secuencia;

------------------------------------------------------------------------------------------------------
PROCEDURE al_obtiene_parametro(ev_nombre_parametro IN ged_parametros.nom_parametro%TYPE,
                               ev_cod_modulo       IN ged_parametros.cod_modulo%TYPE,
                               ev_cod_producto     IN ged_parametros.cod_producto%TYPE,
                               sv_val_parametro    OUT NOCOPY ged_parametros.val_parametro%TYPE, 
                               sn_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
                               sv_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
                               sn_num_evento       OUT NOCOPY ge_errores_pg.evento
                               )
IS

    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;

BEGIN
    
    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento   := 0;
    
    lv_ssql := 'SELECT val_parametro '
             ||'FROM   ged_parametros ' 
             ||'WHERE  nom_parametro = '||ev_nombre_parametro||' '
             ||'AND    cod_modulo = '||ev_cod_modulo||' '
             ||'AND    cod_producto = '||ev_cod_producto;
    
    SELECT val_parametro
    INTO   sv_val_parametro   
    FROM   ged_parametros 
    WHERE  nom_parametro = ev_nombre_parametro
    AND    cod_modulo = ev_cod_modulo
    AND    cod_producto = ev_cod_producto;
    
EXCEPTION
    WHEN OTHERS THEN
        sn_cod_retorno := 890069;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_obtiene_parametro(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_obtiene_parametro',
                                                     lv_ssql,SQLCODE,lv_des_error);

END al_obtiene_parametro;

------------------------------------------------------------------------------------------------------
PROCEDURE al_obtiene_datos_serie(ev_num_serie    IN al_series.num_serie%TYPE,
                                 sn_tip_stock    OUT NOCOPY al_series.tip_stock%TYPE,
                                 sn_cod_estado   OUT NOCOPY al_series.cod_estado%TYPE,
                                 sn_cod_uso      OUT NOCOPY al_series.cod_uso%TYPE,
                                 sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento   OUT NOCOPY ge_errores_pg.evento
                                 )
IS

    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;

BEGIN

    lv_ssql := 'SELECT tip_stock, cod_estado, cod_uso ' 
             ||'FROM   al_series '
             ||'WHERE  num_serie = '||ev_num_serie;
    
    SELECT tip_stock, cod_estado, cod_uso
    INTO   sn_tip_stock, sn_cod_estado ,sn_cod_uso 
    FROM   al_series
    WHERE  num_serie = ev_num_serie;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        sn_cod_retorno := 107;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_obtiene_datos_serie(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_obtiene_datos_serie',
                                                     lv_ssql,SQLCODE,lv_des_error);        
    WHEN OTHERS THEN
        sn_cod_retorno := 900063;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_obtiene_datos_serie(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_obtiene_datos_serie',
                                                     lv_ssql,SQLCODE,lv_des_error);

END al_obtiene_datos_serie;

------------------------------------------------------------------------------------------------------
PROCEDURE al_consulta_series_error(ev_num_tras_masiv IN al_series_temp_to.num_traspaso%TYPE,
                                   ev_tip_busqueda   IN VARCHAR2,   
                                   sn_cantidad       OUT NOCOPY NUMBER,
                                   sn_cod_retorno    OUT NOCOPY ge_errores_pg.coderror,
                                   sv_mens_retorno   OUT NOCOPY ge_errores_pg.msgerror,
                                   sn_num_evento     OUT NOCOPY ge_errores_pg.evento
                                   )
IS

    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;

BEGIN

    lv_ssql := 'SELECT COUNT(0) ' 
             ||'FROM   AL_SERIES_TEMP_TO a, AL_ERRORES_TEMP_TO b '  
             ||'WHERE  num_traspaso = '||ev_num_tras_masiv||' ';
    
    IF ev_tip_busqueda = 'CRITICO' THEN --Busca errores criticos
        lv_ssql := lv_ssql ||'AND a.num_serie =''Error General''';  
    ELSE
        lv_ssql := lv_ssql ||'AND a.cod_error > 0 ';
    END IF;           
    
    lv_ssql := lv_ssql ||'AND a.proc_invocador =''TRA'''  
             ||'AND a.proc_invocador = b.proc_invocador ' 
             ||'AND b.cod_modulo = ''AL'''  
             ||'AND a.cod_error = b.cod_error';
    
    EXECUTE IMMEDIATE lv_ssql INTO sn_cantidad;             
    
EXCEPTION        
    WHEN OTHERS THEN
        sn_cod_retorno := 156;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_consulta_series_error(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_consulta_series_error',
                                                     lv_ssql,SQLCODE,lv_des_error);

END al_consulta_series_error;

------------------------------------------------------------------------------------------------------
PROCEDURE al_get_datos_correo_pr(ev_parametro      IN npt_parametro.alias_parametro%TYPE,  
                                 sv_ip_smtp        OUT NOCOPY npt_parametro.valor_parametro%TYPE,
                                 sv_remitente      OUT NOCOPY npt_parametro.valor_parametro%TYPE,
                                 sc_cursor_correos OUT NOCOPY refcursor,
                                 sn_cod_retorno    OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno   OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
IS 
 lv_ssql      ge_errores_pg.vquery;
 lv_des_error ge_errores_pg.desevent;
 
BEGIN
     sn_num_evento :=0;
     sn_cod_retorno :=0;
     
     lv_ssql :='SELECT valor_parametro FROM npt_parametro WHERE alias_parametro='''||cv_param_ipsmtp||'''';
     SELECT valor_parametro INTO sv_ip_smtp FROM npt_parametro WHERE alias_parametro=cv_param_ipsmtp;

     lv_ssql :='SELECT valor_parametro FROM npt_parametro WHERE alias_parametro= ''REM_'||ev_parametro||'';
     SELECT valor_parametro INTO sv_remitente FROM npt_parametro WHERE alias_parametro='REM_'||ev_parametro;
     
     lv_ssql :='SELECT mail_usuario, nombre_usuario FROM npt_grupo_mail WHERE cod_grupo IN(';
     lv_ssql :=lv_ssql||'SELECT valor_parametro FROM npt_parametro WHERE alias_parametro='''||ev_parametro||''');';
     
     OPEN SC_cursor_correos FOR
        SELECT mail_usuario, nombre_usuario FROM npt_grupo_mail WHERE cod_grupo IN(
            SELECT valor_parametro FROM npt_parametro WHERE alias_parametro=ev_parametro);

EXCEPTION
WHEN OTHERS THEN
        SN_cod_retorno := 900023; 
        IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
           sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error := 'al_traspaso_masivo_ws_pg.al_get_datos_correo_pr; - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl( sn_num_evento, 'AL', sn_cod_retorno||' -- '||sv_mens_retorno, '1.0', USER, 'al_traspaso_masivo_ws_pg.al_get_datos_correo_pr', lv_ssql, SQLCODE, lv_des_error );

END al_get_datos_correo_pr;  

------------------------------------------------------------------------------------------------------
PROCEDURE al_ingreso_traspaso_op_pr(en_num_traspaso    IN al_traspasos_op_to.num_traspaso%TYPE,
                                    en_num_traspaso_op IN al_traspasos_op_to.num_trasp_op%TYPE,
                                    en_estado          IN al_traspasos_op_to.des_estado%TYPE,
                                    sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                                    sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                                    sn_num_evento      OUT NOCOPY ge_errores_pg.evento)
IS
lv_ssql      ge_errores_pg.vquery;
lv_des_error ge_errores_pg.desevent;
ln_contador  NUMBER;

BEGIN
    sn_num_evento   := 0;
    sv_mens_retorno := 'OK';
    sn_cod_retorno  := 0;

    lv_ssql := 'INSERT INTO al_traspasos_op_to ('
            || 'num_traspaso,num_trasp_op,des_estado) ' 
            || 'VALUES ( ' 
            ||  en_num_traspaso     || ','
            ||  en_num_traspaso_op  || ','
            ||  '''' ||  en_estado  || ''')';
        

   INSERT INTO  al_traspasos_op_to (
            num_traspaso,
            num_trasp_op,
            des_estado)
   VALUES (en_num_traspaso,
           en_num_traspaso_op,
           en_estado);

EXCEPTION
    WHEN OTHERS THEN
        sn_cod_retorno := 900069;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='al_traspaso_masivo_ws_pg.al_ingreso_traspaso_op_pr(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'al_traspaso_masivo_ws_pg.al_ingreso_traspaso_op_pr',
                                                 lv_ssql,SQLCODE,lv_des_error);
END al_ingreso_traspaso_op_pr;
   
-----------------------------------------------------------------------------------------------------
PROCEDURE al_actualiza_traspaso_op_pr(en_num_traspaso    IN al_traspasos_op_to.num_traspaso%TYPE,
                                      en_num_traspaso_op IN al_traspasos_op_to.num_trasp_op%TYPE,
                                      en_estado          IN al_traspasos_op_to.des_estado%TYPE,
                                      sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                                      sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                                      sn_num_evento      OUT NOCOPY ge_errores_pg.evento)
IS
lv_ssql      ge_errores_pg.vquery;
lv_des_error ge_errores_pg.desevent;
ln_contador  NUMBER;

BEGIN
    sn_num_evento   := 0;
    sv_mens_retorno := 'OK';
    sn_cod_retorno  := 0;

    lv_ssql := 'UPDATE al_traspasos_op_to SET ' 
            || '       num_traspaso = '||en_num_traspaso||' '
            || '       des_estado = '||en_estado||' '
            || 'WHERE  num_trasp_op = '||en_num_traspaso_op;
        
    UPDATE al_traspasos_op_to SET 
           num_traspaso = en_num_traspaso,
           des_estado = en_estado
    WHERE  num_trasp_op = en_num_traspaso_op;      

EXCEPTION
    WHEN OTHERS THEN
        sn_cod_retorno := 900075;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='al_traspaso_masivo_ws_pg.al_actualiza_traspaso_op_pr(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'al_traspaso_masivo_ws_pg.al_actualiza_traspaso_op_pr',
                                                 lv_ssql,SQLCODE,lv_des_error);
END al_actualiza_traspaso_op_pr;   

------------------------------------------------------------------------------------------------------
PROCEDURE al_tratamiento_masivo(ev_num_traspaso_mas IN VARCHAR2,
                                ev_obs_traspaso_mas IN al_traspasos.des_observacion%TYPE, 
                                sn_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
                                sv_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
                                sn_num_evento       OUT NOCOPY ge_errores_pg.evento)

IS
    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    v_num_traspaso al_traspasos.num_traspaso%TYPE;
    v_cod_bodega_ori_peti al_traspasos.cod_bodega_ori%TYPE;
    v_cod_bodega_dest_peti al_traspasos.cod_bodega_dest%TYPE;
    v_cod_articulo_peti al_lin_peticion.cod_articulo%TYPE;
    v_can_traspaso_peti al_lin_peticion.can_traspaso%TYPE;
    v_tip_movim_aut al_traspasos.tip_movim_aut%TYPE;
    v_tip_movim_env al_traspasos.tip_movim_env%TYPE;
    v_tip_movim_rec al_traspasos.tip_movim_rec%TYPE;
    v_lin_traspaso al_lin_traspaso.lin_traspaso%TYPE;
    v_tip_stock al_lin_traspaso.tip_stock%TYPE;
    v_cod_articulo al_lin_peticion.cod_articulo%TYPE;
    v_uso al_lin_traspaso.cod_uso%TYPE;
    v_estado al_lin_traspaso.cod_estado%TYPE;
    v_can_traspaso al_lin_traspaso.can_traspaso%TYPE;
    v_num_serie al_ser_traspaso.num_serie%TYPE;
    v_cap_code  al_ser_traspaso.cap_code%TYPE;
    v_num_telefono al_ser_traspaso.num_telefono%TYPE;
    v_cod_central al_ser_traspaso.cod_central%TYPE;
    v_cod_subalm al_ser_traspaso.cod_subalm%TYPE;
    v_cod_cat al_ser_traspaso.cod_cat%TYPE;
    v_num_seriemec al_ser_traspaso.num_seriemec%TYPE;
    v_tip_stock_ori al_lin_traspaso.tip_stock%TYPE;
    v_tip_stock_des al_lin_traspaso.tip_stock%TYPE;
    v_num_peticion al_traspasos.num_peticion%TYPE;
    v_cod_motivo al_cab_peticion.cod_motivo%TYPE;
    v_fecha_traspaso_masivo al_traspasos_masivo.fec_traspaso_masivo%TYPE;
    v_usu_traspaso_masivo al_traspasos_masivo.usu_traspaso_masivo%TYPE;

    v_total_series PLS_INTEGER;
    v_total_traspaso PLS_INTEGER;
    v_total_series_norep PLS_INTEGER;
    v_total_series_rep PLS_INTEGER;

    -- variables para select del num_telefono
    v_cap_code_tel al_series.cap_code%TYPE;
    v_num_telefono_tel al_series.num_telefono%TYPE;
    v_cod_central_tel al_series.cod_central%TYPE;
    v_cod_subalm_tel al_series.cod_subalm%TYPE;
    v_cod_cat_tel al_series.cod_cat%TYPE;
    v_num_seriemec_tel al_series.num_seriemec%TYPE;
    v_cod_proceso_aut al_procesos_tipmovim.cod_proceso%TYPE;
    v_cod_proceso_env al_procesos_tipmovim.cod_proceso%TYPE;
    v_cod_proceso_rec al_procesos_tipmovim.cod_proceso%TYPE;
    v_num_traspaso_masivo al_traspasos_masivo.num_traspaso_masivo%TYPE;
    v_num_cantidad al_traspasos_masivo.num_cantidad%TYPE;
    v_ind_seriado  al_articulos.ind_seriado%TYPE;
    v_can_stock    al_stock.can_stock%TYPE;

    v_nNumero_0 NUMBER(2);
    v_nNumero_1 NUMBER(2);
    v_nNumero_2 NUMBER(2);
    v_vCadenaPD VARCHAR(2);
    v_vCadenaAB VARCHAR(2);
    v_vCadenaPA VARCHAR(2);
    v_vCadenaAU VARCHAR(2);
    v_vCadenaEN VARCHAR(2);
    v_vCadenaRM VARCHAR(2);
    v_vCadenaCE VARCHAR(2);
    v_cNumero_0 CHAR(1);

    v_lin_NUM_SEC_LOCA_ORI  al_lin_traspaso.NUM_SEC_LOCA_ORI%TYPE;
    v_lin_NUM_SEC_LOCA_DEST al_lin_traspaso.NUM_SEC_LOCA_DEST%TYPE;
    v_ser_NUM_SEC_LOCA_ORI  al_ser_traspaso.NUM_SEC_LOCA_ORI%TYPE;
    v_ser_NUM_SEC_LOCA_DEST al_ser_traspaso.NUM_SEC_LOCA_DEST%TYPE;
    v_Series_num_sec_loca   al_series.num_sec_loca%TYPE;

    contador NUMBER(10) :=0;

    --Cursor Serie 
    /*CURSOR c_ser_seriado (p_num_traspaso_masivo al_traspasos_masivo.num_traspaso_masivo%TYPE)IS
        SELECT cod_articulo,num_cantidad,num_traspaso_masivo,num_serie
        FROM   al_traspasos_masivo
        WHERE  num_traspaso_masivo = p_num_traspaso_masivo
        AND    cod_estado_tras ='PD';*/
    CURSOR c_ser_seriado (p_num_traspaso_masivo al_traspasos_masivo.num_traspaso_masivo%TYPE)IS
        SELECT a.cod_articulo,a.num_cantidad,a.num_traspaso_masivo,a.num_serie
        FROM   al_traspasos_masivo a, al_series_temp_to b
        WHERE  a.num_traspaso_masivo = p_num_traspaso_masivo
        AND    a.cod_estado_tras ='PD'
        and    a.num_traspaso_masivo = b.num_traspaso
        and    a.num_serie <> b.num_serie;    

    --Cursor cab_peticion
    CURSOR c_cab_peticion (p_num_traspaso_masivo al_traspasos_masivo.num_traspaso_masivo%TYPE) IS
        SELECT cod_bodega_ori, cod_bodega_dest, tip_stock, tip_stock_dest,
               num_traspaso, usu_traspaso_masivo, fec_traspaso_masivo
        FROM   al_traspasos_masivo
        WHERE  num_traspaso_masivo = p_num_traspaso_masivo
        AND    cod_estado_tras ='PD'
        GROUP BY cod_bodega_ori, cod_bodega_dest, tip_stock, tip_stock_dest,
                 num_traspaso, usu_traspaso_masivo, fec_traspaso_masivo;

    --Cursor lineas peticion
    CURSOR c_lin_peticion (p_num_traspaso_masivo al_traspasos_masivo.num_traspaso_masivo%TYPE
                            ,p_num_traspaso al_traspasos_masivo.num_traspaso%TYPE) IS
        SELECT cod_articulo, SUM(num_cantidad)
        FROM   al_traspasos_masivo
        WHERE  num_traspaso_masivo = p_num_traspaso_masivo
        AND    num_traspaso = p_num_traspaso
        GROUP BY cod_articulo;

    --Cursor linea traspaso
    CURSOR c_lin_traspaso (p_num_traspaso_masivo al_traspasos_masivo.num_traspaso_masivo%TYPE
                           , p_num_traspaso al_traspasos_masivo.num_traspaso%TYPE) IS
        SELECT tip_stock, cod_articulo, cod_uso, cod_estado, SUM(num_cantidad)
        FROM   al_traspasos_masivo
        WHERE  num_traspaso_masivo = p_num_traspaso_masivo
        AND    num_traspaso = p_num_traspaso
        GROUP BY tip_stock, cod_articulo, cod_uso, cod_estado;

    --Cursor serie traspaso
    CURSOR c_ser_traspaso (p_num_traspaso_masivo al_traspasos_masivo.num_traspaso_masivo%TYPE
                           , p_num_traspaso al_traspasos_masivo.num_traspaso%TYPE
                           , p_cod_articulo al_traspasos_masivo.cod_articulo%TYPE
                           , p_tip_stock al_traspasos_masivo.tip_stock%TYPE
                           , p_cod_uso al_traspasos_masivo.cod_uso%TYPE
                           , p_cod_estado al_traspasos_masivo.cod_estado%TYPE) IS
        SELECT  num_serie, cap_code, num_telefono, cod_central,
                cod_subalm, cod_cat, num_seriemec,cod_articulo,
                num_sec_loca_ori, num_sec_loca_dest
        FROM    al_traspasos_masivo
        WHERE   num_traspaso_masivo = p_num_traspaso_masivo
        AND     num_traspaso = p_num_traspaso
        AND     cod_articulo = p_cod_articulo
        AND     tip_stock = p_tip_stock
        AND     cod_uso = p_cod_uso
        AND     cod_estado = p_cod_estado;
        
    --  ***************************************************************************

    exception_ins_peti      EXCEPTION;
    exception_ins_linpeti   EXCEPTION;
    exception_ins_traspa    EXCEPTION;
    exception_ins_lintraspa EXCEPTION;
    exception_ins_sertraspa EXCEPTION;
    exception_upd_traspa    EXCEPTION;
    exception_series        EXCEPTION;
    exception_upd_tel       EXCEPTION;
    
BEGIN
    v_nNumero_0 := 0;
    v_nNumero_1 := 1;
    v_nNumero_2 := 2;
    v_vCadenaPD := 'PD';
    v_vCadenaAB := 'AB';
    v_vCadenaPA := 'PA';
    v_vCadenaAU := 'AU';
    v_vCadenaEN := 'EN';
    v_vCadenaRM := 'RM';
    v_vCadenaCE := 'CE';
    v_cNumero_0 := '0';
    v_cod_motivo := 1;
    v_cod_proceso_aut := 'ALARTRA';
    v_cod_proceso_env := 'ALDMTRA';
    v_cod_proceso_rec := 'ALRMTRA';
    v_num_traspaso_masivo := TO_NUMBER(ev_num_traspaso_mas);

    SELECT COUNT(DISTINCT num_serie) INTO v_total_series_norep
    FROM   al_traspasos_masivo
    WHERE  num_traspaso_masivo > v_nnumero_0
    AND    cod_estado_tras = v_vCadenaPD;

    SELECT COUNT(num_serie) INTO v_total_series_rep
    FROM   al_traspasos_masivo
    WHERE  num_traspaso_masivo > v_nNumero_0
    AND    cod_estado_tras = v_vCadenaPD;

    IF v_total_series_norep <> v_total_series_rep THEN
        RAISE exception_series;
    END IF;    
    
    SELECT COUNT(v_nNumero_1) INTO v_total_series
    FROM   al_series a,al_traspasos_masivo b, al_articulos c
    WHERE  c.ind_seriado = v_nNumero_1
    AND    b.cod_articulo = c.cod_articulo
    AND    b.num_traspaso_masivo > v_nNumero_0
    AND    b.cod_estado_tras = v_vCadenaPD
    AND    b.num_traspaso_masivo = v_num_traspaso_masivo
    AND    a.num_serie = b.num_serie
    AND    a.tip_stock = b.tip_stock
    AND    a.cod_uso = b.cod_uso
    AND    a.cod_bodega = b.cod_bodega_ori
    AND    a.cod_estado = b.cod_estado
    AND    a.cod_articulo = b.cod_articulo
    AND    a.num_serie > v_cNumero_0;

    SELECT COUNT(v_nNumero_1) INTO v_total_traspaso
    FROM   al_traspasos_masivo a, al_articulos b
    WHERE  b.ind_seriado = v_nNumero_1
    AND    a.cod_articulo = b.cod_articulo
    AND    a.num_traspaso_masivo > v_nNumero_0
    AND    a.cod_estado_tras = v_vCadenaPD
    AND    a.num_traspaso_masivo = v_num_traspaso_masivo;

    IF v_total_traspaso <> v_total_series THEN
        RAISE exception_series;
    END IF;

    SELECT SUM(a.num_cantidad) INTO v_num_cantidad
    FROM   al_traspasos_masivo a, al_articulos b
    WHERE  a.num_traspaso_masivo > v_nNumero_0
    AND    a.num_traspaso_masivo = v_num_traspaso_masivo
    AND    a.cod_estado_tras = v_vCadenaPD
    AND    a.cod_articulo = b.cod_articulo
    AND    b.ind_seriado <> v_nNumero_1;

    SELECT SUM(a.can_stock) INTO v_can_stock
    FROM   al_stock a,al_traspasos_masivo b, al_articulos c
    WHERE  b.num_traspaso_masivo > v_nNumero_0
    AND    b.cod_estado_tras = v_vCadenaPD
    AND    b.num_traspaso_masivo = v_num_traspaso_masivo
    AND    a.tip_stock = b.tip_stock
    AND    a.cod_uso = b.cod_uso
    AND    a.cod_bodega = b.cod_bodega_ori
    AND    a.cod_estado = b.cod_estado
    AND    a.cod_articulo = b.cod_articulo
    AND    b.cod_articulo = c.cod_articulo
    AND    c.ind_seriado <> v_nNumero_1;

    IF v_num_cantidad > v_can_stock THEN
        RAISE exception_series;
    END IF;

    v_num_cantidad:=0;

    OPEN c_ser_seriado (v_num_traspaso_masivo);
        LOOP
            FETCH c_ser_seriado INTO v_cod_articulo,v_num_cantidad,v_num_traspaso_masivo,v_num_serie;
            EXIT WHEN c_ser_seriado%NOTFOUND;
            BEGIN
                SELECT ind_seriado INTO v_ind_seriado
                FROM   al_articulos 
                WHERE  cod_articulo = v_cod_articulo;

                IF v_ind_seriado <> 1 THEN
                    SELECT SUM(a.can_stock) INTO v_can_stock
                    FROM   al_stock a,al_traspasos_masivo b
                    WHERE  b.num_traspaso_masivo > v_nNumero_0
                    AND    b.cod_estado_tras = v_vCadenaPD
                    AND    b.num_traspaso_masivo = v_num_traspaso_masivo
                    AND    a.cod_articulo = v_cod_articulo
                    AND    a.tip_stock = b.tip_stock
                    AND    a.cod_uso = b.cod_uso
                    AND    a.cod_bodega = b.cod_bodega_ori
                    AND    a.cod_estado = b.cod_estado
                    AND    b.num_serie = v_num_serie;

                    IF v_can_stock = 0 THEN
                        RAISE exception_series;
                    END IF;

                    IF v_can_stock < v_num_cantidad THEN
                        RAISE EXCEPTION_SERIES;
                    END IF;
                END IF;
                
            EXCEPTION WHEN OTHERS THEN
                RAISE EXCEPTION_SERIES;
            END;

            BEGIN
                SELECT ind_seriado INTO v_ind_seriado
                FROM   al_articulos
                WHERE  cod_articulo = v_cod_articulo;
                
            IF v_ind_seriado = 1 THEN
                SELECT cap_code ,num_telefono ,cod_central ,
                       cod_subalm ,cod_cat, num_seriemec
                INTO   v_cap_code_tel, v_num_telefono_tel, v_cod_central_tel,
                       v_cod_subalm_tel, v_cod_cat_tel, v_num_seriemec_tel
                FROM   al_series
                WHERE  num_serie = v_num_serie;

                IF v_num_telefono_tel IS NOT NULL THEN
                    UPDATE al_traspasos_masivo SET cap_code = v_cap_code_tel,
                        num_telefono = v_num_telefono_tel ,cod_central = v_cod_central_tel,
                        cod_subalm = v_cod_subalm_tel ,cod_cat = v_cod_cat_tel ,
                        num_seriemec = v_num_seriemec_tel
                    WHERE num_traspaso_masivo = v_num_traspaso_masivo
                    AND   num_serie = v_num_serie
                    AND   cod_estado_tras = v_vCadenaPD;
                END IF;
            END IF;
            EXCEPTION 
                WHEN OTHERS THEN
                    RAISE EXCEPTION_UPD_TEL;
            END;
        END LOOP;
    CLOSE    c_ser_seriado;


    SELECT tip_movimiento INTO v_tip_movim_aut
    FROM   al_procesos_tipmovim
    WHERE  cod_proceso = v_cod_proceso_aut AND ROWNUM < v_nNumero_2;

    SELECT TIP_MOVIMIENTO INTO v_tip_movim_env
    FROM   AL_PROCESOS_TIPMOVIM
    WHERE  COD_PROCESO = v_cod_proceso_env AND ROWNUM < v_nNumero_2;


    OPEN c_cab_peticion (v_num_traspaso_masivo);
        LOOP
            FETCH c_cab_peticion INTO v_cod_bodega_ori_peti,
            v_cod_bodega_dest_peti ,v_tip_stock_ori, v_tip_stock_des,
            v_num_traspaso, v_usu_traspaso_masivo, v_fecha_traspaso_masivo;
            EXIT WHEN c_cab_peticion%NOTFOUND;

            SELECT al_seq_peticion_tras.NEXTVAL INTO v_num_peticion FROM dual;
            
            BEGIN
                INSERT INTO AL_CAB_PETICION (NUM_PETICION, COD_BODEGA_ORI,
                        COD_BODEGA_DEST, FEC_PETICION,USU_PETICION, COD_MOTIVO,
                        COD_ESTADO, DES_OBSERVACION)
                VALUES
                        (v_num_peticion, v_cod_bodega_ori_peti, v_cod_bodega_dest_peti,
                        v_fecha_traspaso_masivo, v_usu_traspaso_masivo,
                        v_cod_motivo, v_vCadenaAB, NULL);
            EXCEPTION 
                WHEN OTHERS THEN
                    RAISE exception_ins_peti;
            END;

            OPEN c_lin_peticion (v_num_traspaso_masivo, v_num_traspaso);
                LOOP
                    FETCH c_lin_peticion INTO v_cod_articulo_peti, v_can_traspaso_peti;
                    EXIT WHEN c_lin_peticion%NOTFOUND;
                BEGIN
                    INSERT INTO al_lin_peticion (num_peticion, cod_articulo, can_traspaso)
                    VALUES
                        (v_num_peticion, v_cod_articulo_peti, v_can_traspaso_peti);
                EXCEPTION
                    WHEN OTHERS THEN
                        RAISE exception_ins_linpeti;
                END;
                END LOOP;            
            CLOSE c_lin_peticion;
            
            BEGIN
                UPDATE al_cab_peticion SET cod_estado = v_vcadenapa
                WHERE num_peticion = v_num_peticion;
                UPDATE al_cab_peticion SET cod_estado = v_vCadenaPA
                WHERE num_peticion = v_num_peticion;

                INSERT INTO al_traspasos (num_traspaso, num_peticion, cod_bodega_ori,
                cod_bodega_dest, fec_autoriza, usu_autoriza, cod_estado,
                fec_despacho, usu_despacho, fec_recepcion, usu_recepcion,
                des_observacion, tip_movim_aut, tip_movim_env, tip_movim_rec)
                    VALUES
                    (v_num_traspaso, v_num_peticion, v_cod_bodega_ori_peti,
                    v_cod_bodega_dest_peti, v_fecha_traspaso_masivo,
                    v_usu_traspaso_masivo, 'AP',NULL,
                    NULL, NULL, NULL, ev_obs_traspaso_mas, v_tip_movim_aut, NULL, NULL);

            EXCEPTION
                WHEN OTHERS THEN
                    RAISE EXCEPTION_INS_TRASPA;
            END;

            v_lin_traspaso := 0;
            OPEN c_lin_traspaso(v_num_traspaso_masivo, v_num_traspaso);
                LOOP
                    FETCH c_lin_traspaso INTO v_tip_stock, v_cod_articulo,
                    v_uso, v_estado, v_can_traspaso;
                    EXIT WHEN c_lin_traspaso%NOTFOUND;
                    
                    v_lin_traspaso := v_lin_traspaso + 1;
                    
                    BEGIN   
                        v_lin_num_sec_loca_ori:= NULL;
                        v_lin_num_sec_loca_dest:= NULL;

                        SELECT DISTINCT num_sec_loca_ori, num_sec_loca_dest
                        INTO  v_lin_num_sec_loca_ori, v_lin_num_sec_loca_dest
                        FROM  AL_TRASPASOS_MASIVO
                        WHERE num_traspaso = v_num_traspaso AND
                        cod_articulo = v_cod_articulo AND
                        tip_stock = v_tip_stock AND
                        cod_uso = v_uso AND
                        cod_estado = v_estado AND
                        num_serie IS NOT NULL;

                        INSERT INTO al_lin_traspaso (num_traspaso, lin_traspaso,
                        tip_stock, cod_articulo, cod_uso, cod_estado, can_traspaso,
                        num_sec_loca_ori, num_sec_loca_dest)
                            VALUES
                            (v_num_traspaso, v_lin_traspaso, v_tip_stock,
                            v_cod_articulo, v_uso, v_estado, v_can_traspaso,
                            v_lin_num_sec_loca_ori, v_lin_num_sec_loca_dest);
            
                    EXCEPTION
                        WHEN OTHERS THEN
                            raise exception_ins_lintraspa;
                    END;

                    OPEN c_ser_traspaso (v_num_traspaso_masivo , v_num_traspaso , v_cod_articulo
                        , v_tip_stock , v_uso , v_estado);

                    LOOP
                        FETCH c_ser_traspaso INTO v_num_serie, v_cap_code,
                        v_num_telefono, v_cod_central,v_cod_subalm,
                        v_cod_cat, v_num_seriemec,v_cod_articulo,
                        v_ser_num_sec_loca_ori, v_ser_num_sec_loca_dest;               
                        EXIT WHEN c_ser_traspaso%NOTFOUND;
                        
                        BEGIN
                            SELECT ind_seriado INTO v_ind_seriado
                            FROM   al_articulos
                            WHERE  cod_articulo = v_cod_articulo;
                            
                            IF v_ind_seriado = 1 THEN
                                INSERT INTO al_ser_traspaso (num_traspaso, lin_traspaso,
                                        num_serie, cap_code,num_telefono, num_seriemec,
                                        cod_central, cod_subalm, cod_cat,
                                        num_sec_loca_ori, num_sec_loca_dest)
                                VALUES
                                    (v_num_traspaso, v_lin_traspaso, v_num_serie,
                                    v_cap_code, v_num_telefono, v_num_seriemec,
                                    v_cod_central, v_cod_subalm, v_cod_cat,
                                    v_ser_num_sec_loca_ori, v_ser_num_sec_loca_dest);
                            END IF;
                        EXCEPTION
                            WHEN OTHERS THEN
                                RAISE exception_ins_sertraspa;
                        END;
                    END LOOP;
                    CLOSE c_ser_traspaso;
                END LOOP;
            CLOSE c_lin_traspaso;
            
            begin
                UPDATE al_cab_peticion SET cod_estado = v_vcadenaau
                WHERE  num_peticion = v_num_peticion;
                UPDATE al_traspasos SET cod_estado = v_vcadenaau
                WHERE  num_traspaso = v_num_traspaso;

                UPDATE al_traspasos SET num_peticion = v_num_peticion,
                fec_autoriza = v_fecha_traspaso_masivo,
                usu_autoriza = v_usu_traspaso_masivo,
                cod_estado = v_vcadenaen, tip_movim_aut = v_tip_movim_aut,
                tip_movim_env = v_tip_movim_env, tip_movim_rec = NULL,
                fec_despacho = v_fecha_traspaso_masivo,
                usu_despacho = v_usu_traspaso_masivo,
                fec_recepcion = NULL, usu_recepcion = NULL,
                des_observacion = ev_obs_traspaso_mas,
                --des_observacion = NULL, cod_bodega_ori = v_cod_bodega_ori_peti,
                cod_bodega_dest = v_cod_bodega_dest_peti
                WHERE num_traspaso = v_num_traspaso;

                SELECT a.tip_movimiento INTO v_tip_movim_rec
                FROM   al_procesos_tipmovim a, al_tipos_movimientos b
                WHERE  a.tip_movimiento = b.tip_movimiento
                AND    a.cod_proceso = v_cod_proceso_rec 
                AND    b.tip_stock = v_tip_stock_des
                AND    ROWNUM < v_nNumero_2;

                UPDATE al_traspasos SET num_peticion = v_num_peticion,
                fec_autoriza = v_fecha_traspaso_masivo,
                usu_autoriza = v_usu_traspaso_masivo,
                cod_estado = v_vcadenarm, tip_movim_aut = v_tip_movim_aut,
                tip_movim_env = v_tip_movim_env, tip_movim_rec = v_tip_movim_rec,
                fec_despacho = v_fecha_traspaso_masivo,
                usu_despacho = v_usu_traspaso_masivo,
                fec_recepcion = v_fecha_traspaso_masivo,
                usu_recepcion = v_usu_traspaso_masivo,
                cod_bodega_ori = v_cod_bodega_ori_peti,
                cod_bodega_dest = v_cod_bodega_dest_peti,
                des_observacion = ev_obs_traspaso_mas
                --des_observacion = ' MASIVO '|| TO_CHAR(v_num_traspaso_masivo) || ' ' ||
                --v_usu_traspaso_masivo || ' ' ||
                --TO_CHAR(v_fecha_traspaso_masivo,'DD-MM-YYYY HH24:MI:SS')
                WHERE NUM_TRASPASO = v_num_traspaso;

            EXCEPTION
                WHEN OTHERS THEN
                    RAISE EXCEPTION_UPD_TRASPA;
            END;
        END LOOP;
    CLOSE c_cab_peticion;

    UPDATE al_traspasos_masivo SET cod_estado_tras = v_vcadenace,
    nom_usuaproc = USER, fec_proceso = SYSDATE
    WHERE num_traspaso_masivo = v_num_traspaso_masivo;
    
    EXCEPTION
        WHEN exception_ins_peti THEN
            
            IF c_ser_seriado%ISOPEN  THEN CLOSE c_ser_seriado;END IF;
            IF c_lin_peticion%ISOPEN THEN CLOSE c_lin_peticion;END IF;
            IF c_ser_traspaso%ISOPEN THEN CLOSE c_ser_traspaso;END IF;
            IF c_lin_traspaso%ISOPEN THEN CLOSE c_lin_traspaso;END IF;
            IF c_cab_peticion%ISOPEN THEN CLOSE c_cab_peticion;END IF;
            
            sn_cod_retorno := 900071;
            
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo',
                                                         lv_ssql,SQLCODE,lv_des_error);

        WHEN exception_ins_linpeti THEN
                
            IF c_ser_seriado%ISOPEN  THEN CLOSE c_ser_seriado;END IF;
            IF c_lin_peticion%ISOPEN THEN CLOSE c_lin_peticion;END IF;
            IF c_ser_traspaso%ISOPEN THEN CLOSE c_ser_traspaso;END IF;
            IF c_lin_traspaso%ISOPEN THEN CLOSE c_lin_traspaso;END IF;
            IF c_cab_peticion%ISOPEN THEN CLOSE c_cab_peticion;END IF;
            
            sn_cod_retorno := 900072;
            
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo',
                                                         lv_ssql,SQLCODE,lv_des_error);
        WHEN exception_ins_traspa THEN

            IF c_ser_seriado%ISOPEN  THEN CLOSE c_ser_seriado;END IF;
            IF c_lin_peticion%ISOPEN THEN CLOSE c_lin_peticion;END IF;
            IF c_ser_traspaso%ISOPEN THEN CLOSE c_ser_traspaso;END IF;
            IF c_lin_traspaso%ISOPEN THEN CLOSE c_lin_traspaso;END IF;
            IF c_cab_peticion%ISOPEN THEN CLOSE c_cab_peticion;END IF;
            
            sn_cod_retorno := 900069;
            
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo',
                                                         lv_ssql,SQLCODE,lv_des_error);
            
        WHEN exception_ins_lintraspa THEN
                
            IF c_ser_seriado%ISOPEN  THEN CLOSE c_ser_seriado;END IF;
            IF c_lin_peticion%ISOPEN THEN CLOSE c_lin_peticion;END IF;
            IF c_ser_traspaso%ISOPEN THEN CLOSE c_ser_traspaso;END IF;
            IF c_lin_traspaso%ISOPEN THEN CLOSE c_lin_traspaso;END IF;
            IF c_cab_peticion%ISOPEN THEN CLOSE c_cab_peticion;END IF;
            
            sn_cod_retorno := 900073;
            
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo',
                                                         lv_ssql,SQLCODE,lv_des_error);                
                            
                            
        WHEN exception_ins_sertraspa THEN
            
            IF c_ser_seriado%ISOPEN  THEN CLOSE c_ser_seriado;END IF;
            IF c_lin_peticion%ISOPEN THEN CLOSE c_lin_peticion;END IF;
            IF c_ser_traspaso%ISOPEN THEN CLOSE c_ser_traspaso;END IF;
            IF c_lin_traspaso%ISOPEN THEN CLOSE c_lin_traspaso;END IF;
            IF c_cab_peticion%ISOPEN THEN CLOSE c_cab_peticion;END IF;
            
            sn_cod_retorno := 900074;
            
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo',
                                                         lv_ssql,SQLCODE,lv_des_error);

        WHEN exception_upd_traspa THEN
        
            IF c_ser_seriado%ISOPEN  THEN CLOSE c_ser_seriado;END IF;
            IF c_lin_peticion%ISOPEN THEN CLOSE c_lin_peticion;END IF;
            IF c_ser_traspaso%ISOPEN THEN CLOSE c_ser_traspaso;END IF;
            IF c_lin_traspaso%ISOPEN THEN CLOSE c_lin_traspaso;END IF;
            IF c_cab_peticion%ISOPEN THEN CLOSE c_cab_peticion;END IF;
            
            sn_cod_retorno := 900088;
            
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo',
                                                         lv_ssql,SQLCODE,lv_des_error);
                                                         
        WHEN exception_series THEN
            
            IF c_ser_seriado%ISOPEN  THEN CLOSE c_ser_seriado;END IF;
            IF c_lin_peticion%ISOPEN THEN CLOSE c_lin_peticion;END IF;
            IF c_ser_traspaso%ISOPEN THEN CLOSE c_ser_traspaso;END IF;
            IF c_lin_traspaso%ISOPEN THEN CLOSE c_lin_traspaso;END IF;
            IF c_cab_peticion%ISOPEN THEN CLOSE c_cab_peticion;END IF;
            
            sn_cod_retorno := 900089;
            
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo',
                                                         lv_ssql,SQLCODE,lv_des_error);
        WHEN OTHERS THEN
            IF c_ser_seriado%ISOPEN  THEN CLOSE c_ser_seriado;END IF;
            IF c_lin_peticion%ISOPEN THEN CLOSE c_lin_peticion;END IF;
            IF c_ser_traspaso%ISOPEN THEN CLOSE c_ser_traspaso;END IF;
            IF c_lin_traspaso%ISOPEN THEN CLOSE c_lin_traspaso;END IF;
            IF c_cab_peticion%ISOPEN THEN CLOSE c_cab_peticion;END IF;
            
            sn_cod_retorno := 900090;
            
            IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
                sv_mens_retorno := cv_error_no_clasif;
            END IF;
            lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo(); - ' || SQLERRM;
            sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo',
                                                         lv_ssql,SQLCODE,lv_des_error);
end al_tratamiento_masivo;  

------------------------------------------------------------------------------------------------------
PROCEDURE al_hist_traspasos_mas (en_num_trasp    IN al_traspasos_masivo.num_traspaso_masivo%type,
                                 sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento   OUT NOCOPY ge_errores_pg.evento) 
IS

lv_ssql      ge_errores_pg.vquery;
lv_des_error ge_errores_pg.desevent;
v            al_traspasos_masivo%ROWTYPE;
v_fila		 ROWID;

CURSOR c_ser_seriado is
   SELECT num_traspaso_masivo,cod_estado_tras,num_traspaso,num_peticion,
                   cod_bodega_ori,cod_bodega_dest,tip_stock,tip_stock_dest,cod_articulo,
                   cod_uso,cod_estado,num_serie,fec_traspaso_masivo,tip_movim_aut,
                   tip_movim_env,tip_movim_rec,usu_traspaso_masivo,des_observacion,
                   cap_code,num_telefono,cod_central,cod_subalm,cod_cat,num_seriemec,
                   nom_usuaproc,fec_proceso,SQLCODE,SQLERRM,num_cantidad,cod_pedido,
                   ROWID fila
   FROM  al_traspasos_masivo
   WHERE num_traspaso_masivo = en_num_trasp
   AND   cod_estado_tras = 'CE';

BEGIN
    OPEN c_ser_seriado;
        LOOP
            FETCH c_ser_seriado INTO v.num_traspaso_masivo,v.cod_estado_tras,v.num_traspaso,v.num_peticion,
                                     v.cod_bodega_ori,v.cod_bodega_dest,v.tip_stock,v.tip_stock_dest,v.cod_articulo,
                                     v.cod_uso,v.cod_estado,v.num_serie,v.fec_traspaso_masivo,v.tip_movim_aut,
                                     v.tip_movim_env,v.tip_movim_rec,v.usu_traspaso_masivo,v.des_observacion,
                                     v.cap_code,v.num_telefono,v.cod_central,v.cod_subalm,v.cod_cat,v.num_seriemec,
                                     v.nom_usuaproc,v.fec_proceso,v.SQLCODE,v.SQLERRM,v.num_cantidad,v.cod_pedido,
                                     v_fila;
            EXIT WHEN c_ser_seriado%NOTFOUND;
            
            INSERT INTO al_htraspasos_masivo(num_traspaso_masivo,cod_estado_tras,num_traspaso,num_peticion,
                        cod_bodega_ori,cod_bodega_dest,tip_stock,tip_stock_dest,cod_articulo,
                        cod_uso,cod_estado,num_serie,fec_traspaso_masivo,tip_movim_aut,
                        tip_movim_env,tip_movim_rec,usu_traspaso_masivo,des_observacion,
                        cap_code,num_telefono,cod_central,cod_subalm,cod_cat,num_seriemec,
                        nom_usuaproc,fec_proceso,SQLCODE,SQLERRM,num_cantidad,cod_pedido,
                        fec_hist,usu_hist)
            VALUES
                        (v.num_traspaso_masivo,v.cod_estado_tras,v.num_traspaso,v.num_peticion,
                        v.cod_bodega_ori,v.cod_bodega_dest,v.tip_stock,v.tip_stock_dest,v.cod_articulo,
                        v.cod_uso,v.cod_estado,v.num_serie,v.fec_traspaso_masivo,v.tip_movim_aut,
                        v.tip_movim_env,v.tip_movim_rec,v.usu_traspaso_masivo,v.des_observacion,
                        v.cap_code,v.num_telefono,v.cod_central,v.cod_subalm,v.cod_cat,v.num_seriemec,
                        v.nom_usuaproc,v.fec_proceso,v.SQLCODE,v.SQLERRM,v.num_cantidad,v.cod_pedido,
                        SYSDATE,USER);
                        
            DELETE al_traspasos_masivo
            WHERE  ROWID = v_fila;
            
        END LOOP;
    CLOSE    c_ser_seriado;
    
EXCEPTION
    WHEN OTHERS THEN  	    
        IF c_ser_seriado%ISOPEN THEN CLOSE c_ser_seriado;END IF;
                    
        sn_cod_retorno := 900091;
                    
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_hist_traspasos_mas(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_hist_traspasos_mas',
                                                 lv_ssql,SQLCODE,lv_des_error);
END al_hist_traspasos_mas; 

------------------------------------------------------------------------------------------------------
PROCEDURE al_vali_traspaso_op(en_num_secuencia    IN al_traspasos_op_to.num_trasp_op%TYPE,
                              sn_cantidad         OUT NOCOPY NUMBER, 
                              sn_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
                              sv_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
                              sn_num_evento       OUT NOCOPY ge_errores_pg.evento)
IS

    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;

BEGIN
    
    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento   := 0;
    
    lv_ssql := 'SELECT COUNT(0) ' 
             ||'FROM   al_traspasos_op_to '
             ||'WHERE  num_trasp_op = '||en_num_secuencia;
    
    SELECT COUNT(0) 
    INTO   sn_cantidad
    FROM   al_traspasos_op_to
    WHERE  num_trasp_op = en_num_secuencia;  
    
EXCEPTION
    WHEN OTHERS THEN
        sn_cod_retorno := 900092;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_vali_traspaso_op(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_vali_traspaso_op',
                                                     lv_ssql,SQLCODE,lv_des_error);

END al_vali_traspaso_op;       

------------------------------------------------------------------------------------------------------
PROCEDURE al_consu_estad_tras_op(en_num_secuencia    IN al_traspasos_op_to.num_trasp_op%TYPE,
                                 sn_num_traspaso     OUT NOCOPY al_traspasos_op_to.num_traspaso%TYPE,
                                 sv_des_estado       OUT NOCOPY al_traspasos_op_to.des_estado%TYPE,
                                 sv_esok             OUT NOCOPY VARCHAR,
                                 sc_errores          OUT NOCOPY refcursor,
                                 sn_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento       OUT NOCOPY ge_errores_pg.evento)
IS

    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    

BEGIN
    
    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento   := 0;
    sv_esok         := 'SI';
    
    lv_ssql := 'SELECT a.num_traspaso, a.des_estado ' 
             ||'FROM   al_traspasos_op_to and '
             ||'WHERE  a.num_trasp_op = '||en_num_secuencia; 
    
    SELECT a.num_traspaso, a.des_estado
    INTO   sn_num_traspaso, sv_des_estado 
    FROM   al_traspasos_op_to a
    WHERE  a.num_trasp_op = en_num_secuencia; 
    
    IF sv_des_estado = 'ERROR' THEN
    
        lv_ssql := 'SELECT a.num_serie, b.des_error ' 
                 ||'FROM   al_series_temp_to a, al_errores_temp_to b '
                 ||'WHERE  a.cod_error = b.cod_error ' 
                 ||'AND    a.cod_modulo = b.cod_modulo '
                 ||'AND    a.proc_invocador = b.proc_invocador '
                 ||'AND    a.num_traspaso = '||sn_num_traspaso;
        
        sv_esok         := 'NO';
        
        OPEN sc_errores FOR
            SELECT a.num_serie, b.des_error 
            FROM   al_series_temp_to a, al_errores_temp_to b
            WHERE  a.cod_error = b.cod_error 
            AND    a.cod_modulo = b.cod_modulo
            AND    a.proc_invocador = b.proc_invocador
            AND    a.num_traspaso = sn_num_traspaso;
            
    END IF; 
    
EXCEPTION
    WHEN OTHERS THEN
        sn_cod_retorno := 301028;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_consu_estad_tras_op(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_consu_estad_tras_op',
                                                     lv_ssql,SQLCODE,lv_des_error);

END al_consu_estad_tras_op;  

------------------------------------------------------------------------------------------------------
PROCEDURE al_valida_bodega_dts(en_cod_cliente   IN npt_usuario_cliente.cod_cliente%TYPE,
                               en_cod_bodega    IN npt_usuario_bodega.cod_bodega%TYPE, 
                               sn_cantidad      OUT NOCOPY NUMBER, 
                               sn_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
                               sv_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
                               sn_num_evento    OUT NOCOPY ge_errores_pg.evento)
IS

    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;

BEGIN
    
    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento   := 0;
    
    lv_ssql := 'SELECT COUNT(0) '
             ||'FROM   npt_usuario_bodega a, npt_usuario_cliente b '
             ||'WHERE  a.cod_usuario = b.cod_usuario '
             ||'AND    a.cod_bodega = '||en_cod_bodega||' ' 
             ||'AND    b.cod_cliente = '||en_cod_cliente;
    
    SELECT COUNT(0)
    INTO   sn_cantidad 
    FROM   npt_usuario_bodega a, npt_usuario_cliente b
    WHERE  a.cod_usuario = b.cod_usuario
    AND    a.cod_bodega = en_cod_bodega 
    AND    b.cod_cliente = en_cod_cliente;

EXCEPTION
    WHEN OTHERS THEN
        sn_cod_retorno := 900093;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_valida_bodega_dts(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_valida_bodega_dts',
                                                     lv_ssql,SQLCODE,lv_des_error);

END al_valida_bodega_dts;      

------------------------------------------------------------------------------------------------------
PROCEDURE al_ins_movimiento_descarga(en_num_serie    IN al_series.num_serie%TYPE,
                                     en_secuencia    IN NUMBER,
                                     en_cod_bodega   IN al_series.cod_bodega%TYPE,
                                     en_cod_cliente  IN npt_usuario_cliente.cod_cliente%TYPE,
                                     sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                     sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                     sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS

    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    v_movim      al_movimientos%rowtype;
    v_series     al_series%rowtype;
    exception_series EXCEPTION;
    ln_nromov    al_movimientos.num_movimiento%type;    
    lv_val_parametro ged_parametros.val_parametro%TYPE;
    ln_contador  NUMBER;

BEGIN
    
    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento   := 0;
    
    
    al_obtiene_parametro(cv_par_mov_dts,cv_moduloal,cv_cod_producto,lv_val_parametro,sn_cod_retorno,sv_mens_retorno,sn_num_evento);
        
    IF sn_cod_retorno <> 0 THEN
        RAISE exception_series;
    END IF;
    
    BEGIN            
        lv_ssql := 'SELECT * FROM al_Series WHERE num_Serie = '||en_num_serie;    
                
        SELECT * INTO v_series FROM al_Series WHERE num_Serie = en_num_serie;

    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            sn_cod_retorno := 900053;
            RAISE exception_series;
                    
        WHEN OTHERS THEN 
            sn_cod_retorno := 777;
            RAISE exception_series;  
    END;
    
    IF lv_val_parametro = 'TRUE' THEN   
        
        --Se valida que la serie pertenesca a la bodega ingresada
        
        IF v_series.cod_bodega = en_cod_bodega THEN
        
            BEGIN            
                SELECT al_seq_mvto.NEXTVAL INTO ln_nromov FROM DUAL;

                v_movim.num_movimiento := ln_nromov;
                v_movim.tip_movimiento := 21;
                v_movim.fec_movimiento := SYSDATE;
                v_movim.tip_stock := v_series.tip_stock;
                v_movim.cod_bodega := en_cod_bodega;
                v_movim.cod_articulo := v_series.cod_articulo;
                v_movim.cod_uso := v_series.cod_uso;
                v_movim.cod_estado := v_series.cod_estado;
                v_movim.num_cantidad := 1;
                v_movim.cod_estadomov := 'SO';
                v_movim.nom_usuarora := USER;
                v_movim.tip_stock_dest := NULL;
                v_movim.cod_bodega_dest := NULL;
                v_movim.cod_uso_dest := NULL;
                v_movim.cod_estado_dest := NULL;
                v_movim.num_serie := v_series.num_serie;
                v_movim.num_desde := 0;
                v_movim.num_hasta := NULL;
                v_movim.num_guia := NULL;
                v_movim.prc_unidad := NULL;
                v_movim.cod_transaccion := 4;
                v_movim.num_transaccion := 4;
                v_movim.num_seriemec := NULL;
                v_movim.num_telefono := NULL;
                v_movim.cap_code := NULL;
                v_movim.cod_producto := 1;
                v_movim.cod_central := NULL;
                v_movim.cod_moneda := NULL;
                v_movim.cod_subalm := NULL;
                v_movim.cod_central_dest := NULL;
                v_movim.cod_subalm_dest := NULL;
                v_movim.num_telefono_dest := NULL;
                v_movim.cod_cat := NULL;
                v_movim.cod_cat_dest := NULL;
                v_movim.ind_telefono := 0;
                v_movim.plan := NULL;
                v_movim.carga := NULL;
                v_movim.num_sec_loca := NULL;
                v_movim.cod_hlr := NULL;
                v_movim.cod_plaza := v_series.cod_plaza;
            
            
                lv_ssql := 'AL_PAC_VALIDACIONES.P_INSERTA_MOVIM()';
                
                AL_PAC_VALIDACIONES.P_INSERTA_MOVIM(v_movim);

            EXCEPTION 
                WHEN OTHERS THEN
                    lv_ssql := 'INSERT INTO al_series_temp_to (cod_modulo, proc_invocador, num_traspaso, lin_traspaso, cod_articulo, num_serie, cod_error) '
                             ||'VALUES (''AL'',''MOV_TRA_DTS'','||en_secuencia||',1,'||v_series.cod_articulo||','||v_series.num_serie||',1)';
                    
                    INSERT INTO al_series_temp_to (cod_modulo, proc_invocador, num_traspaso, lin_traspaso, cod_articulo, num_serie, cod_error)
                    VALUES ('AL','MOV_TRA_DTS',en_secuencia,1,v_series.cod_articulo,v_series.num_serie,1);
            END; 
        
        ELSE
            --Serie ingresada no pertencese a la bodega enviada
            lv_ssql := 'INSERT INTO al_series_temp_to (cod_modulo, proc_invocador, num_traspaso, lin_traspaso, cod_articulo, num_serie, cod_error) '
                     ||'VALUES (''AL'',''MOV_TRA_DTS'','||en_secuencia||',1,'||v_series.cod_articulo||','||v_series.num_serie||',2)';
                    
            INSERT INTO al_series_temp_to (cod_modulo, proc_invocador, num_traspaso, lin_traspaso, cod_articulo, num_serie, cod_error)
            VALUES ('AL','MOV_TRA_DTS',en_secuencia,1,v_series.cod_articulo,v_series.num_serie,2);
            
        END IF;  
        
    ELSE
    
        --Se valida que la serie pertenesca and una bodega del distribuidor
        al_valida_bodega_dts(en_cod_cliente, v_series.cod_bodega, ln_contador, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
        
        IF ln_contador = 0 THEN
            --Serie ingresada no pertencese a una bodega del vendedor
            lv_ssql := 'INSERT INTO al_series_temp_to (cod_modulo, proc_invocador, num_traspaso, lin_traspaso, cod_articulo, num_serie, cod_error) '
                     ||'VALUES (''AL'',''MOV_TRA_DTS'','||en_secuencia||',1,'||v_series.cod_articulo||','||v_series.num_serie||',1)';
                    
            INSERT INTO al_series_temp_to (cod_modulo, proc_invocador, num_traspaso, lin_traspaso, cod_articulo, num_serie, cod_error)
            VALUES ('AL','MOV_TRA_DTS',en_secuencia,1,v_series.cod_articulo,v_series.num_serie,3);
        
        ELSE
        
            BEGIN            
                SELECT al_seq_mvto.NEXTVAL INTO ln_nromov FROM DUAL;

                v_movim.num_movimiento := ln_nromov;
                v_movim.tip_movimiento := 21;
                v_movim.fec_movimiento := SYSDATE;
                v_movim.tip_stock := v_series.tip_stock;
                v_movim.cod_bodega := en_cod_bodega;
                v_movim.cod_articulo := v_series.cod_articulo;
                v_movim.cod_uso := v_series.cod_uso;
                v_movim.cod_estado := v_series.cod_estado;
                v_movim.num_cantidad := 1;
                v_movim.cod_estadomov := 'SO';
                v_movim.nom_usuarora := USER;
                v_movim.tip_stock_dest := NULL;
                v_movim.cod_bodega_dest := NULL;
                v_movim.cod_uso_dest := NULL;
                v_movim.cod_estado_dest := NULL;
                v_movim.num_serie := v_series.num_serie;
                v_movim.num_desde := 0;
                v_movim.num_hasta := NULL;
                v_movim.num_guia := NULL;
                v_movim.prc_unidad := NULL;
                v_movim.cod_transaccion := 4;
                v_movim.num_transaccion := 4;
                v_movim.num_seriemec := NULL;
                v_movim.num_telefono := NULL;
                v_movim.cap_code := NULL;
                v_movim.cod_producto := 1;
                v_movim.cod_central := NULL;
                v_movim.cod_moneda := NULL;
                v_movim.cod_subalm := NULL;
                v_movim.cod_central_dest := NULL;
                v_movim.cod_subalm_dest := NULL;
                v_movim.num_telefono_dest := NULL;
                v_movim.cod_cat := NULL;
                v_movim.cod_cat_dest := NULL;
                v_movim.ind_telefono := 0;
                v_movim.plan := NULL;
                v_movim.carga := NULL;
                v_movim.num_sec_loca := NULL;
                v_movim.cod_hlr := NULL;
                v_movim.cod_plaza := v_series.cod_plaza;
            
            
                lv_ssql := 'AL_PAC_VALIDACIONES.P_INSERTA_MOVIM()';
                
                AL_PAC_VALIDACIONES.P_INSERTA_MOVIM(v_movim);

            EXCEPTION 
                WHEN OTHERS THEN
                    lv_ssql := 'INSERT INTO al_series_temp_to (cod_modulo, proc_invocador, num_traspaso, lin_traspaso, cod_articulo, num_serie, cod_error) '
                             ||'VALUES (''AL'',''MOV_TRA_DTS'','||en_secuencia||',1,'||v_series.cod_articulo||','||v_series.num_serie||',1)';
                    
                    INSERT INTO al_series_temp_to (cod_modulo, proc_invocador, num_traspaso, lin_traspaso, cod_articulo, num_serie, cod_error)
                    VALUES ('AL','MOV_TRA_DTS',en_secuencia,1,v_series.cod_articulo,v_series.num_serie,1);
            END; 
        END IF;
    
    END IF;    

EXCEPTION
    WHEN exception_series THEN
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_ins_movimiento_descarga(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_ins_movimiento_descarga',
                                                     lv_ssql,SQLCODE,lv_des_error);
    
    WHEN OTHERS THEN
        sn_cod_retorno := 900094;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_ins_movimiento_descarga(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_ins_movimiento_descarga',
                                                     lv_ssql,SQLCODE,lv_des_error);

END al_ins_movimiento_descarga;      

------------------------------------------------------------------------------------------------------
PROCEDURE al_series_error_dts(en_secuencia    IN NUMBER,
                              ev_cod_modulo   IN al_series_temp_to.cod_modulo%TYPE,
                              ev_proceso      IN al_series_temp_to.proc_invocador%TYPE,
                              ev_num_linea    IN al_series_temp_to.lin_traspaso%TYPE,                              
                              sc_errores      OUT NOCOPY refcursor, 
                              sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                              sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                              sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS

    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    ln_contador  NUMBER;

BEGIN
    
    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento   := 0;
    
    lv_ssql := 'SELECT a.num_serie, b.des_error '
             ||'FROM   al_series_temp_to a, al_errores_temp_to b '
             ||'WHERE  a.cod_modulo = '||ev_cod_modulo||' '
             ||'AND    a.proc_invocador = '||ev_proceso||' '
             ||'AND    a.cod_modulo = b.cod_modulo '
             ||'AND    a.proc_invocador = b.proc_invocador '
             ||'AND    a.cod_error = b.cod_error '
             ||'AND    a.num_traspaso = '||en_secuencia||' '
             ||'AND    a.lin_traspaso = '||ev_num_linea;
    
    OPEN sc_errores FOR
        SELECT a.num_serie, b.des_error
        FROM   al_series_temp_to a, al_errores_temp_to b
        WHERE  a.cod_modulo = ev_cod_modulo
        AND    a.proc_invocador = ev_proceso
        AND    a.cod_modulo = b.cod_modulo
        AND    a.proc_invocador = b.proc_invocador
        AND    a.cod_error = b.cod_error
        AND    a.num_traspaso = en_secuencia
        AND    a.lin_traspaso = ev_num_linea;
    
    lv_ssql := 'SELECT COUNT(0) '
             ||'FROM   al_series_temp_to a, al_errores_temp_to b '
             ||'WHERE  a.cod_modulo = '||ev_cod_modulo||' '
             ||'AND    a.proc_invocador = '||ev_proceso||' '
             ||'AND    a.cod_modulo = b.cod_modulo '
             ||'AND    a.proc_invocador = b.proc_invocador '
             ||'AND    a.cod_error = b.cod_error '
             ||'AND    a.num_traspaso = '||en_secuencia||' '
             ||'AND    a.lin_traspaso = '||ev_num_linea;
    
    SELECT COUNT(0)
    INTO   ln_contador
    FROM   al_series_temp_to a, al_errores_temp_to b
    WHERE  a.cod_modulo = ev_cod_modulo
    AND    a.proc_invocador = ev_proceso
    AND    a.cod_modulo = b.cod_modulo
    AND    a.proc_invocador = b.proc_invocador
    AND    a.cod_error = b.cod_error
    AND    a.num_traspaso = en_secuencia
    AND    a.lin_traspaso = ev_num_linea;    
    
    IF ln_contador > 0 THEN
        sn_cod_retorno  := 1;
    END IF;    

EXCEPTION
    WHEN OTHERS THEN
        sn_cod_retorno := 156;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_series_error_dts(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_series_error_dts',
                                                     lv_ssql,SQLCODE,lv_des_error);

END al_series_error_dts;

------------------------------------------------------------------------------------------------------
PROCEDURE al_obtiene_series_error(ev_num_tras_masiv IN al_series_temp_to.num_traspaso%TYPE,
                                  ev_tip_busqueda   IN VARCHAR2,   
                                  sc_errores        OUT NOCOPY refcursor,
                                  sn_cod_retorno    OUT NOCOPY ge_errores_pg.coderror,
                                  sv_mens_retorno   OUT NOCOPY ge_errores_pg.msgerror,
                                  sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
IS

    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;

BEGIN

   
    IF ev_tip_busqueda = 'CRITICO' THEN --Busca errores criticos
        lv_ssql := 'SELECT a.num_serie, b.des_error ' 
                 ||'FROM   AL_SERIES_TEMP_TO a, AL_ERRORES_TEMP_TO b '  
                 ||'WHERE  num_traspaso = '||ev_num_tras_masiv||' '
                 ||'AND a.num_serie =''Error General'''
                 ||'AND a.proc_invocador =''TRA'''  
                 ||'AND a.proc_invocador = b.proc_invocador ' 
                 ||'AND b.cod_modulo = ''AL'''  
                 ||'AND a.cod_error = b.cod_error';
                 
         OPEN sc_errores FOR                 
             SELECT a.num_serie, b.des_error  
             FROM   AL_SERIES_TEMP_TO a, AL_ERRORES_TEMP_TO b   
             WHERE  num_traspaso = ev_num_tras_masiv
             AND a.num_serie ='Error General'
             AND a.proc_invocador ='TRA'  
             AND a.proc_invocador = b.proc_invocador  
             AND b.cod_modulo = 'AL'  
             AND a.cod_error = b.cod_error;        
    ELSE
        lv_ssql := 'SELECT a.num_serie, b.des_error ' 
                 ||'FROM   AL_SERIES_TEMP_TO a, AL_ERRORES_TEMP_TO b '  
                 ||'WHERE  num_traspaso = '||ev_num_tras_masiv||' '
                 ||'AND a.cod_error > 0 '
                 ||'AND a.proc_invocador =''TRA'''  
                 ||'AND a.proc_invocador = b.proc_invocador ' 
                 ||'AND b.cod_modulo = ''AL'''  
                 ||'AND a.cod_error = b.cod_error';
                 
         OPEN sc_errores FOR                 
             SELECT a.num_serie, b.des_error  
             FROM   AL_SERIES_TEMP_TO a, AL_ERRORES_TEMP_TO b   
             WHERE  num_traspaso = ev_num_tras_masiv
             AND a.cod_error > 0 
             AND a.proc_invocador ='TRA'  
             AND a.proc_invocador = b.proc_invocador  
             AND b.cod_modulo = 'AL'  
             AND a.cod_error = b.cod_error;        
                 
    END IF;
    
EXCEPTION        
    WHEN OTHERS THEN
        sn_cod_retorno := 156;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_obtiene_series_error(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_obtiene_series_error',
                                                     lv_ssql,SQLCODE,lv_des_error);

END al_obtiene_series_error;

------------------------------------------------------------------------------------------------------
PROCEDURE al_elimina_tras_mas(en_num_traspaso IN al_traspasos_op_to.num_traspaso%TYPE,
                              sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                              sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                              sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS

    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    

BEGIN
    
    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento   := 0;
    
    lv_ssql := 'DELETE al_traspasos_masivo WHERE num_traspaso_masivo = '||en_num_traspaso; 
         
    DELETE al_traspasos_masivo WHERE num_traspaso_masivo = en_num_traspaso;
    
EXCEPTION
    WHEN OTHERS THEN
        sn_cod_retorno := 156;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_elimina_tras_mas(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_elimina_tras_mas',
                                                     lv_ssql,SQLCODE,lv_des_error);

END al_elimina_tras_mas; 

------------------------------------------------------------------------------------------------------
PROCEDURE al_valida_bode_tras(en_num_traspaso IN al_traspasos_op_to.num_traspaso%TYPE,                              
                              sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                              sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                              sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS

    lv_ssql       ge_errores_pg.vquery;
    lv_des_error  ge_errores_pg.desevent;
    lv_num_serie  al_traspasos_masivo.num_serie%TYPE;
    lv_cod_bodega al_traspasos_masivo.cod_bodega_ori%TYPE;
    ln_cod_articulo al_traspasos_masivo.cod_articulo%TYPE;
    ln_contador   NUMBER;
    
    --Cursor Serie 
    CURSOR c_ser_seriado (p_num_traspaso_masivo al_traspasos_masivo.num_traspaso_masivo%TYPE)IS
        SELECT num_serie, cod_bodega_ori, cod_articulo
        FROM   al_traspasos_masivo
        WHERE  num_traspaso_masivo = p_num_traspaso_masivo
        AND    cod_estado_tras ='PD';    

BEGIN
    
    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento   := 0;
    ln_contador     := 0;
    
    lv_ssql := 'SELECT num_serie, cod_bodega_ori, cod_articulo '
             ||'FROM   al_traspasos_masivo '
             ||'WHERE  num_traspaso_masivo = '||en_num_traspaso||' '
             ||'AND    cod_estado_tras =''PD''';
    
    OPEN c_ser_seriado (en_num_traspaso);
        LOOP
            FETCH c_ser_seriado INTO lv_num_serie, lv_cod_bodega, ln_cod_articulo;
            EXIT WHEN c_ser_seriado%NOTFOUND;
            
            lv_ssql := 'SELECT COUNT(0) '
                     ||'FROM   al_series '
                     ||'WHERE  num_serie = '||lv_num_serie||' '
                     ||'AND    cod_bodega = '||lv_cod_bodega;
            
            SELECT COUNT(0)
            INTO   ln_contador 
            FROM   al_series
            WHERE  num_serie = lv_num_serie
            AND    cod_bodega = lv_cod_bodega;
            
            IF ln_contador = 0 THEN 
                lv_ssql := 'al_traspasocls_pg.al_graba_error_traspaso_pr('||ln_cod_articulo||','||lv_num_serie||','|| en_num_traspaso||', 1, 14, 1)';
                al_traspasocls_pg.al_graba_error_traspaso_pr(ln_cod_articulo,lv_num_serie, en_num_traspaso, 1, 14, 1);
            END IF;
            
            ln_contador := 0;
            
            SELECT COUNT(0)
            INTO   ln_contador 
            FROM   al_series
            WHERE  num_serie = lv_num_serie
            AND    tip_stock IN (4);
            
            IF ln_contador = 0 THEN 
                lv_ssql := 'al_traspasocls_pg.al_graba_error_traspaso_pr('||ln_cod_articulo||','||lv_num_serie||','|| en_num_traspaso||', 1, 15, 1)';
                al_traspasocls_pg.al_graba_error_traspaso_pr(ln_cod_articulo,lv_num_serie, en_num_traspaso, 1, 15, 1);
            END IF;
                         
        END LOOP;
    CLOSE    c_ser_seriado;    
    
EXCEPTION
    WHEN OTHERS THEN
        IF c_ser_seriado%ISOPEN  THEN CLOSE c_ser_seriado;END IF;
        sn_cod_retorno := 156;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_valida_bode_tras(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_valida_bode_tras',
                                                     lv_ssql,SQLCODE,lv_des_error);

END al_valida_bode_tras; 

------------------------------------------------------------------------------------------------------
PROCEDURE al_elimina_des_in_mas(en_num_secuencia IN al_series_temp_to.num_traspaso%TYPE,
                                ev_cod_modulo    IN al_series_temp_to.cod_modulo%TYPE,
                                ev_proceso       IN al_series_temp_to.proc_invocador%TYPE,
                                ev_num_linea     IN al_series_temp_to.lin_traspaso%TYPE,
                                sn_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
                                sv_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
                                sn_num_evento    OUT NOCOPY ge_errores_pg.evento)
IS

    lv_ssql      ge_errores_pg.vquery;
    lv_des_error ge_errores_pg.desevent;
    

BEGIN
    
    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento   := 0;
    
    lv_ssql := 'DELETE al_series_temp_to and ' 
             ||'WHERE  a.num_traspaso = '||en_num_secuencia||' '
             ||'AND   a.cod_modulo = '||ev_cod_modulo||' '
             ||'AND    a.proc_invocador = '||ev_proceso||' '
             ||'AND    a.lin_traspaso = '||ev_num_linea; 
         
    DELETE al_series_temp_to a 
    WHERE  a.num_traspaso = en_num_secuencia
    AND    a.cod_modulo = ev_cod_modulo
    AND    a.proc_invocador = ev_proceso
    AND    a.lin_traspaso = ev_num_linea;
    
EXCEPTION
    WHEN OTHERS THEN
        sn_cod_retorno := 156;
        IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
        END IF;
        lv_des_error  :='AL_TRASPASO_MASIVO_WS_PG.al_elimina_des_in_mas(); - ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'AL',sn_cod_retorno||' -- '||sv_mens_retorno,'1.0',USER,'AL_TRASPASO_MASIVO_WS_PG.al_elimina_des_in_mas',
                                                     lv_ssql,SQLCODE,lv_des_error);

END al_elimina_des_in_mas; 
------------------------------------------------------------------------------------------------------
END AL_TRASPASO_MASIVO_WS_PG;
/
SHOW ERROR