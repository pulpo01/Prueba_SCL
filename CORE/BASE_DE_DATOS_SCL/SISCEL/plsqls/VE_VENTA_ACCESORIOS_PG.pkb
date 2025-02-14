CREATE OR REPLACE PACKAGE BODY ve_venta_accesorios_pg AS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION al_crea_movimiento_fn(
                                v_movim         IN         al_movimientos%rowtype,
                                sn_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                sv_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                sn_num_evento   OUT NOCOPY ge_errores_pg.Evento
)RETURN BOOLEAN
IS
   lv_des_error       VARCHAR2(300);
   lv_sql             VARCHAR2(1000);

BEGIN

   sn_cod_retorno :=0;
   sv_mens_retorno:=' ';
   sn_num_evento  :=0;

   lv_sql := 'INSERT INTO al_movimientos (num_movimiento,tip_movimiento,fec_movimiento,tip_stock,cod_bodega,cod_articulo,cod_uso,'
                               ||'cod_estado,num_cantidad,cod_estadomov,nom_usuarora,tip_stock_dest,cod_bodega_dest,'
                               ||'cod_uso_dest,cod_estado_dest,num_serie,num_desde,num_hasta,num_guia,prc_unidad,cod_transaccion,'
                               ||'num_transaccion,num_seriemec,num_telefono,cap_code,cod_producto,cod_central,cod_moneda,'
                               ||'cod_subalm,cod_central_dest,cod_subalm_dest,num_telefono_dest,cod_cat,cod_cat_dest,ind_telefono,'
                               ||'PLAN,carga,num_sec_loca,cod_plaza,cod_hlr)'
   ||'VALUES ('||v_movim.num_movimiento||','||v_movim.tip_movimiento||','||v_movim.fec_movimiento||','||v_movim.tip_stock||','||v_movim.cod_bodega||','
   ||v_movim.cod_articulo||','||v_movim.cod_uso||','||v_movim.cod_estado||','||v_movim.num_cantidad||','||v_movim.cod_estadomov||','
   ||v_movim.nom_usuarora||','||v_movim.tip_stock_dest||','||v_movim.cod_bodega_dest||','||v_movim.cod_uso_dest||','||v_movim.cod_estado_dest||','
   ||v_movim.num_serie||','||v_movim.num_desde||','||v_movim.num_hasta||','||v_movim.num_guia||','||v_movim.prc_unidad||','||v_movim.cod_transaccion||','
   ||v_movim.num_transaccion||','||v_movim.num_seriemec||','||v_movim.num_telefono||','||v_movim.cap_code||','||v_movim.cod_producto||','||v_movim.cod_central||','
   ||v_movim.cod_moneda||','||v_movim.cod_subalm||','||v_movim.cod_central_dest||','||v_movim.cod_subalm_dest||','||v_movim.num_telefono_dest||','
   ||v_movim.cod_cat||','||v_movim.cod_cat_dest||','||v_movim.ind_telefono||','||v_movim.PLAN||','||v_movim.carga||','||v_movim.num_sec_loca||','
   ||v_movim.cod_plaza||','||v_movim.cod_hlr||')';



   INSERT INTO al_movimientos (num_movimiento,tip_movimiento,fec_movimiento,tip_stock,cod_bodega,cod_articulo,cod_uso,
                               cod_estado,num_cantidad,cod_estadomov,nom_usuarora,tip_stock_dest,cod_bodega_dest,
                               cod_uso_dest,cod_estado_dest,num_serie,num_desde,num_hasta,num_guia,prc_unidad,cod_transaccion,
                               num_transaccion,num_seriemec,num_telefono,cap_code,cod_producto,cod_central,cod_moneda,
                               cod_subalm,cod_central_dest,cod_subalm_dest,num_telefono_dest,cod_cat,cod_cat_dest,ind_telefono,
                               PLAN,carga,num_sec_loca,cod_hlr,cod_plaza)
   VALUES (v_movim.num_movimiento,v_movim.tip_movimiento,v_movim.fec_movimiento,v_movim.tip_stock,v_movim.cod_bodega,v_movim.cod_articulo,
           v_movim.cod_uso,v_movim.cod_estado,v_movim.num_cantidad,v_movim.cod_estadomov,v_movim.nom_usuarora,v_movim.tip_stock_dest,
           v_movim.cod_bodega_dest,v_movim.cod_uso_dest,v_movim.cod_estado_dest,v_movim.num_serie,v_movim.num_desde,v_movim.num_hasta,
           v_movim.num_guia,v_movim.prc_unidad,v_movim.cod_transaccion,v_movim.num_transaccion,v_movim.num_seriemec,v_movim.num_telefono,
           v_movim.cap_code,v_movim.cod_producto,v_movim.cod_central,v_movim.cod_moneda,v_movim.cod_subalm,v_movim.cod_central_dest,
           v_movim.cod_subalm_dest,v_movim.num_telefono_dest,v_movim.cod_cat,v_movim.cod_cat_dest,v_movim.ind_telefono,v_movim.PLAN,
           v_movim.carga,v_movim.num_sec_loca,v_movim.cod_hlr,v_movim.cod_plaza);

   RETURN TRUE;

EXCEPTION
   WHEN OTHERS THEN
         sn_cod_retorno  := 1111;
         sv_mens_retorno := 'Error al Insertar en la tabla AL_MOVIMIENTOS';
         lv_des_error    := 've_venta_accesorios_pg.al_crea_movimiento_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl( sn_num_evento, cv_modulove,sv_mens_retorno,cv_version , USER, 've_venta_accesorios_pg.al_crea_movimiento_fn()', lv_sql, SQLCODE, lv_des_error );
         RETURN FALSE;
END al_crea_movimiento_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_ins_acce_reserv_movim_pr (
                                         ev_cod_bodega      IN al_movimientos.cod_bodega%TYPE,
                                       ev_cod_articulo      IN al_movimientos.cod_articulo%TYPE,
                                       ev_cod_uso          IN al_movimientos.cod_uso%TYPE,
                                       ev_nom_usuario     IN al_movimientos.nom_usuarora%TYPE,
                                       ev_num_cantidad      IN al_movimientos.num_cantidad%TYPE,
                                       ev_num_serie          IN al_movimientos.num_serie%TYPE,
                                       ev_num_transaccion IN al_movimientos.num_transaccion%TYPE,
                                       sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                         sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                         sn_num_evento      OUT NOCOPY ge_errores_pg.evento
) IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
v_movim         al_movimientos%ROWTYPE;
error_ejecucion EXCEPTION;

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;

     v_movim.cod_bodega      := ev_cod_bodega;
     v_movim.cod_articulo      := ev_cod_articulo;
     v_movim.cod_uso          := ev_cod_uso;
     v_movim.num_cantidad      := ev_num_cantidad;
     v_movim.nom_usuarora      := ev_nom_usuario;
     v_movim.num_serie          := ev_num_serie;
     v_movim.num_transaccion := ev_num_transaccion;
     v_movim.cod_estado         := cn_estado_reser;

     IF v_movim.num_serie IS NOT NULL THEN
       ve_select_datos_serie(v_movim.num_serie,
                            v_movim.cod_central,
                            v_movim.cod_subalm,
                            v_movim.num_telefono,
                            v_movim.cod_cat,
                            v_movim.tip_stock,
                            v_movim.PLAN,
                            v_movim.carga,
                            sn_cod_retorno,
                            sv_mens_retorno,
                            sn_num_evento);
     END IF;

     lv_sql:= 'SELECT al_seq_mvto.NEXTVAL FROM dual';

     SELECT al_seq_mvto.NEXTVAL
     INTO v_movim.num_movimiento
     FROM dual;

     ve_select_producto (v_movim.cod_articulo,v_movim.cod_producto,sn_cod_retorno,sv_mens_retorno,sn_num_evento);

     --ve_select_tip_stock (v_movim.cod_bodega,v_movim.cod_articulo,v_movim.cod_uso,v_movim.cod_estado,v_movim.tip_stock,sn_cod_retorno,sv_mens_retorno,sn_num_evento);

     v_movim.tip_movimiento   := cn_mov_reserv;
     v_movim.fec_movimiento      := SYSDATE;
     v_movim.cod_estadomov      := 'SO';
     v_movim.tip_stock_dest      := NULL;
     v_movim.cod_bodega_dest  := NULL;
     v_movim.cod_uso_dest      := NULL;
     v_movim.cod_estado_dest  := cn_est_reser_dest;
     v_movim.num_desde          := 0;
     v_movim.num_hasta          := NULL;
     v_movim.num_guia          := NULL;
     v_movim.prc_unidad          := NULL;
     v_movim.tip_stock        := 2;
     v_movim.cod_transaccion  := 3;    ------ consultar si va ser siempre 3 ....
     v_movim.num_seriemec      := NULL;
     v_movim.cap_code          := NULL;
     v_movim.cod_moneda          := NULL;
     v_movim.cod_central_dest := NULL;
     v_movim.cod_subalm_dest  := NULL;
     v_movim.num_telefono_dest:= NULL;
     v_movim.cod_cat_dest      := NULL;
     v_movim.ind_telefono      := NULL;
     v_movim.num_sec_loca      := NULL;
     v_movim.cod_plaza          := NULL;
     v_movim.cod_hlr          := NULL;


      IF NOT (al_crea_movimiento_fn(v_movim,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
          sn_cod_retorno  := 22222;
         RAISE error_ejecucion;
     END IF;

EXCEPTION
      WHEN error_ejecucion THEN
         lv_des_error    := 've_venta_accesorios_pg.ve_ins_acce_reserv_movim_pr() - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl( sn_num_evento, cv_modulove,sv_mens_retorno,cv_version , USER, 've_venta_accesorios_pg.ve_ins_acce_reserv_movim_pr()', lv_sql, SQLCODE, lv_des_error );

      WHEN OTHERS THEN
         sn_cod_retorno  := 33333;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_venta_accesorios_pg.ve_ins_acce_reserv_movim_pr() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_ins_acce_reserv_movim_pr()', lv_sql, SQLCODE, SQLERRM);
END ve_ins_acce_reserv_movim_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_ins_acce_salida_movim_pr (
                                         ev_cod_bodega      IN al_movimientos.cod_bodega%TYPE,
                                       ev_cod_articulo      IN al_movimientos.cod_articulo%TYPE,
                                       ev_cod_uso          IN al_movimientos.cod_uso%TYPE,
                                       ev_nom_usuario     IN al_movimientos.nom_usuarora%TYPE,
                                       ev_num_cantidad      IN al_movimientos.num_cantidad%TYPE,
                                       ev_num_serie          IN al_movimientos.num_serie%TYPE,
                                       ev_num_transaccion IN al_movimientos.num_transaccion%TYPE,
                                       sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                         sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                         sn_num_evento      OUT NOCOPY ge_errores_pg.evento
) IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
v_movim         al_movimientos%ROWTYPE;
error_ejecucion EXCEPTION;

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;

     v_movim.cod_bodega      := ev_cod_bodega;
     v_movim.cod_articulo      := ev_cod_articulo;
     v_movim.cod_uso          := ev_cod_uso;
     v_movim.num_cantidad      := ev_num_cantidad;
     v_movim.nom_usuarora      := ev_nom_usuario;
     v_movim.num_serie          := ev_num_serie;
     v_movim.num_transaccion := ev_num_transaccion;
      v_movim.cod_estado         := cn_estado_salida;

     IF v_movim.num_serie IS NOT NULL THEN
       ve_select_datos_serie(v_movim.num_serie,
                            v_movim.cod_central,
                            v_movim.cod_subalm,
                            v_movim.num_telefono,
                            v_movim.cod_cat,
                            v_movim.tip_stock,
                            v_movim.PLAN,
                            v_movim.carga,
                            sn_cod_retorno,
                            sv_mens_retorno,
                            sn_num_evento);
     END IF;

     lv_sql:= 'SELECT al_seq_mvto.NEXTVAL FROM dual';

     SELECT al_seq_mvto.NEXTVAL
     INTO v_movim.num_movimiento
     FROM dual;

     ve_select_producto (v_movim.cod_articulo,v_movim.cod_producto,sn_cod_retorno,sv_mens_retorno,sn_num_evento);

      --ve_select_tip_stock (v_movim.cod_bodega,v_movim.cod_articulo,v_movim.cod_uso,v_movim.cod_estado,v_movim.tip_stock,sn_cod_retorno,sv_mens_retorno,sn_num_evento);

     v_movim.tip_movimiento   := cn_mov_salida;
     v_movim.fec_movimiento      := SYSDATE;
     v_movim.cod_estadomov      := 'SO';
     v_movim.tip_stock_dest      := NULL;
     v_movim.cod_bodega_dest  := NULL;
     v_movim.cod_uso_dest      := NULL;
     v_movim.cod_estado_dest  := NULL;
     v_movim.num_desde          := 0;
     v_movim.num_hasta          := NULL;
     v_movim.num_guia          := NULL;
     v_movim.prc_unidad          := NULL;
     v_movim.tip_stock        := 2;
     v_movim.cod_transaccion  := 3;    ------ consultar si va ser siempre 3 ....
     v_movim.num_seriemec      := NULL;
     v_movim.cap_code          := NULL;
     v_movim.cod_moneda          := NULL;
     v_movim.cod_central_dest := NULL;
     v_movim.cod_subalm_dest  := NULL;
     v_movim.num_telefono_dest:= NULL;
     v_movim.cod_cat_dest      := NULL;
     v_movim.ind_telefono      := NULL;
     v_movim.num_sec_loca      := NULL;
     v_movim.cod_plaza          := NULL;
     v_movim.cod_hlr          := NULL;


      IF NOT (al_crea_movimiento_fn(v_movim,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
          sn_cod_retorno  := 22222;
         RAISE error_ejecucion;
     END IF;

EXCEPTION
      WHEN error_ejecucion THEN
         lv_des_error    := 've_venta_accesorios_pg.ve_ins_acce_salida_movim_pr() - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl( sn_num_evento, cv_modulove,sv_mens_retorno,cv_version , USER, 've_venta_accesorios_pg.ve_ins_acce_salida_movim_pr()', lv_sql, SQLCODE, lv_des_error );

      WHEN OTHERS THEN
         sn_cod_retorno  := 33333;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_venta_accesorios_pg.ve_ins_acce_salida_movim_pr() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_ins_acce_salida_movim_pr()', lv_sql, SQLCODE, SQLERRM);
END ve_ins_acce_salida_movim_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_select_datos_serie(
                                v_serie         IN al_series.num_serie%TYPE,
                              v_central          OUT NOCOPY al_series.cod_central%TYPE,
                              v_subalm           OUT NOCOPY al_series.cod_subalm%TYPE,
                              v_telefono         OUT NOCOPY al_series.num_telefono%TYPE,
                              v_cat              OUT NOCOPY al_series.cod_cat%TYPE,
                              v_tip_stock        OUT NOCOPY al_series.tip_stock%TYPE,
                              v_plan              OUT NOCOPY al_series.PLAN%TYPE,
                              v_carga              OUT NOCOPY al_series.carga%TYPE,
                              sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento   OUT NOCOPY ge_errores_pg.evento
) IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;

     lv_sql:= 'SELECT cod_central,cod_subalm,num_telefono,cod_cat,tip_stock, PLAN, carga '
               || 'FROM   al_series '
               || 'WHERE  num_serie = '|| v_serie ||' ';

     SELECT cod_central,cod_subalm,num_telefono,cod_cat,tip_stock, PLAN, carga
     INTO   v_central,v_subalm,v_telefono,v_cat,v_tip_stock,v_plan, v_carga
     FROM   al_series
     WHERE  num_serie = v_serie;

EXCEPTION
    WHEN OTHERS THEN
         sn_cod_retorno  := 4444;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_venta_accesorios_pg.ve_select_datos_serie() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_select_datos_serie', lv_sql, SQLCODE, SQLERRM);
END ve_select_datos_serie;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_select_producto(
                             v_articulo      IN al_series.cod_articulo%TYPE,
                           v_producto        OUT NOCOPY al_series.cod_producto%TYPE,
                           sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                             sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                             sn_num_evento   OUT NOCOPY ge_errores_pg.evento
) IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;

     lv_sql:= 'SELECT cod_producto '
               ||'FROM    al_articulos '
               ||'WHERE  cod_articulo = '||v_articulo|| ' ';

     SELECT cod_producto
     INTO     v_producto
     FROM    al_articulos
     WHERE  cod_articulo = v_articulo;

EXCEPTION
   WHEN OTHERS THEN
         sn_cod_retorno  := 55555;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_venta_accesorios_pg.ve_select_producto() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_select_producto()', lv_sql, SQLCODE, SQLERRM);
END ve_select_producto;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_select_tip_stock(
                              v_cod_bodega     IN al_stock.cod_bodega%TYPE,
                            v_cod_articulo    IN al_stock.cod_articulo%TYPE,
                            v_cod_uso        IN al_stock.cod_uso%TYPE,
                            v_cod_estado    IN al_stock.cod_estado%TYPE,
                            sn_tip_stock    OUT NOCOPY al_stock.tip_stock%TYPE,
                            sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                              sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                              sn_num_evento   OUT NOCOPY ge_errores_pg.evento
) IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;

     lv_sql:= ' SELECT tip_stock '
               ||'FROM     al_stock '
               ||'WHERE     cod_bodega = '||v_cod_bodega||' '
               ||'AND     cod_uso = '||v_cod_uso||''
               ||'AND     cod_articulo = '||v_cod_articulo||' '
               ||'AND     cod_estado = '||v_cod_estado||'';


     sn_tip_stock := 2;

EXCEPTION
   WHEN OTHERS THEN
         sn_cod_retorno  := 66666;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_venta_accesorios_pg.ve_select_tip_stock() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_select_tip_stock()', lv_sql, SQLCODE, SQLERRM);
END ve_select_tip_stock;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_existe_serie(
                              v_num_serie     IN al_series.num_serie%TYPE,
                            v_cod_articulo    IN al_stock.cod_articulo%TYPE,
                            v_cod_uso        IN al_stock.cod_uso%TYPE,
                            sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                              sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                              sn_num_evento   OUT NOCOPY ge_errores_pg.evento
) IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
ln_existe        NUMBER;

error_ejecucion EXCEPTION;

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;

      lv_sql:= 'SELECT count(1) '
     ||'FROM      al_series a '
     ||'WHERE     a.cod_articulo = '||v_cod_articulo||' '
     ||'AND      a.cod_uso = '||v_cod_uso||' '
     ||'AND      a.num_serie = '||v_num_serie||' '
     ||'AND      a.ind_telefono <>  (SELECT val_parametro '
                                     ||'FROM   ged_parametros '
                                 ||'WHERE  cod_modulo = "GE" '
                                 ||'AND    cod_producto = 1 '
                                 ||'AND    nom_parametro = "IND_TEL_OUT")';


     SELECT count(1)
     INTO    ln_existe
     FROM      al_series a
     WHERE     a.cod_articulo = v_cod_articulo
     AND      a.cod_uso = v_cod_uso
     AND      a.num_serie = v_num_serie
     AND      a.ind_telefono <>  (SELECT val_parametro
                                     FROM   ged_parametros
                                 WHERE  cod_modulo = 'GE'
                                 AND    cod_producto = 1
                                 AND    nom_parametro = 'IND_TEL_OUT');

     IF ln_existe = 0 THEN
          sn_cod_retorno  := 22222;
         RAISE error_ejecucion;
     END IF;

EXCEPTION
   WHEN error_ejecucion THEN
         lv_des_error    := 've_venta_accesorios_pg.ve_existe_serie() - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl( sn_num_evento, cv_modulove,sv_mens_retorno,cv_version , USER, 've_venta_accesorios_pg.ve_existe_serie()', lv_sql, SQLCODE, lv_des_error );

   WHEN OTHERS THEN
         sn_cod_retorno  := 66666;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_venta_accesorios_pg.ve_existe_serie() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_existe_serie()', lv_sql, SQLCODE, SQLERRM);
END ve_existe_serie;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_insert_reserv_art_pr(
                                    ev_cod_bodega           IN ga_reservart.cod_bodega%TYPE,
                                     ev_cod_articulo     IN ga_reservart.cod_articulo%TYPE,
                                     ev_cod_uso         IN ga_reservart.cod_uso%TYPE,
                                     ev_nom_usuario     IN ga_reservart.nom_usuario%TYPE,
                                     ev_num_cantidad     IN ga_reservart.num_unidades%TYPE,
                                     ev_num_serie         IN ga_reservart.num_serie%TYPE,
                                     ev_num_transaccion IN ga_reservart.num_transaccion%TYPE,
                                  ev_num_venta         IN ga_reservart.num_venta%TYPE,
                                  ev_num_linea         IN ga_reservart.num_linea%TYPE,
                                     sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento      OUT NOCOPY ge_errores_pg.evento
) IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
ln_contador      NUMBER;
ln_cod_producto NUMBER;

ln_tip_stock    al_stock.tip_stock%TYPE;

le_exception_fin     EXCEPTION;

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;

     lv_sql:= 'SELECT COUNT (1) '
     ||'FROM ga_reservart a '
     ||'WHERE a.num_serie = '||ev_num_serie||'';

     SELECT COUNT (1)
     INTO ln_contador
     FROM ga_reservart a
     WHERE a.num_serie = ev_num_serie;

     IF (ln_contador > 0) THEN
         sn_cod_retorno  := 77777;
        RAISE le_exception_fin;
     END IF;

     ve_select_producto (ev_cod_articulo,ln_cod_producto,sn_cod_retorno,sv_mens_retorno,sn_num_evento);
     ve_select_tip_stock (ev_cod_bodega,ev_cod_articulo,ev_cod_uso,cn_estado_reser,ln_tip_stock,sn_cod_retorno,sv_mens_retorno,sn_num_evento);

     lv_sql:= 'INSERT INTO ga_reservart '
     ||'(num_transaccion, num_linea, num_orden, cod_articulo, cod_producto, fec_reserva, cod_bodega, tip_stock, cod_uso, cod_estado, num_unidades,'
     ||'nom_usuario, num_serie) '
     ||'VALUES'
     ||'('||ev_num_transaccion||','||ev_num_linea||',1,'||ev_cod_articulo||','||ln_cod_producto||','||SYSDATE||','||ev_cod_bodega||','||ln_tip_stock||','
     ||','||ev_cod_uso||','||cn_estado_reser||','||ev_num_cantidad||','||ev_nom_usuario||','||ev_num_serie||')';

     INSERT INTO ga_reservart
     (num_transaccion, num_linea, num_orden, cod_articulo, cod_producto, fec_reserva, cod_bodega, tip_stock, cod_uso, cod_estado, num_unidades,
     nom_usuario, num_serie,cap_code,num_venta)
     VALUES
     (ev_num_transaccion,ev_num_linea,1,ev_cod_articulo,ln_cod_producto,SYSDATE,ev_cod_bodega,ln_tip_stock,ev_cod_uso,cn_estado_reser,ev_num_cantidad,
     ev_nom_usuario,ev_num_serie,NULL,ev_num_venta);

EXCEPTION
   WHEN le_exception_fin THEN
         lv_des_error := 've_venta_accesorios_pg.ve_insert_reserv_art_pr;- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_insert_reserv_art_pr', lv_sql, SQLCODE, lv_des_error);

   WHEN OTHERS THEN
         sn_cod_retorno  := 66666;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_venta_accesorios_pg.ve_insert_reserv_art_pr() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_insert_reserv_art_pr()', lv_sql, SQLCODE, SQLERRM);
END ve_insert_reserv_art_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_select_datos_vendedor(
                              v_cod_vendedor        IN  ve_vendedores.cod_vendedor%TYPE,
                            sn_cod_tipcomis       OUT NOCOPY ve_vendedores.cod_tipcomis%TYPE,
                            sn_tipventa           OUT NOCOPY ve_vendedores.ind_tipventa%TYPE,
                            sn_cod_vende_raiz  OUT NOCOPY ve_vendedores.cod_vende_raiz%TYPE,
                            sv_cod_oficina       OUT NOCOPY ve_vendedores.cod_oficina%TYPE,
                            sv_cod_plaza       OUT NOCOPY ve_vendedores.cod_plaza%TYPE,
                            sv_cod_ciudad       OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                            sv_cod_region       OUT NOCOPY ge_direcciones.cod_region%TYPE,
                            sv_cod_provincia   OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                            sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                              sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                              sn_num_evento      OUT NOCOPY ge_errores_pg.evento
) IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;

     lv_sql:= 'SELECT a.cod_tipcomis, a.ind_tipventa, a.cod_vende_raiz, a.cod_oficina, a.cod_plaza, b.cod_ciudad, b.cod_region, b.cod_provincia '
               ||'FROM      ve_vendedores a, ge_direcciones b '
               ||'WHERE  a.cod_vendedor = '||v_cod_vendedor||' '
               ||'AND     a.cod_direccion = b.cod_direccion';

     SELECT a.cod_tipcomis, a.ind_tipventa, a.cod_vende_raiz, a.cod_oficina, a.cod_plaza, b.cod_ciudad, b.cod_region, b.cod_provincia
     INTO    sn_cod_tipcomis,sn_tipventa, sn_cod_vende_raiz,sv_cod_oficina,sv_cod_plaza,sv_cod_ciudad,sv_cod_region,sv_cod_provincia
     FROM      ve_vendedores a, ge_direcciones b
     WHERE  a.cod_vendedor = v_cod_vendedor
     AND     a.cod_direccion = b.cod_direccion;

EXCEPTION
   WHEN OTHERS THEN
         sn_cod_retorno  := 66666;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_venta_accesorios_pg.ve_select_datos_vendedor() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_select_datos_vendedor()', lv_sql, SQLCODE, SQLERRM);
END ve_select_datos_vendedor;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_insert_venta_pr(
                              v_num_venta           IN ga_ventas.num_venta%TYPE,
                            v_cod_producto           IN ga_ventas.cod_producto%TYPE,
                            v_cod_oficina          IN ga_ventas.cod_oficina%TYPE,
                            v_cod_tipcomis          IN ga_ventas.cod_tipcomis%TYPE,
                            v_cod_vendedor           IN ga_ventas.cod_vendedor%TYPE,
                            v_cod_vendedor_agente IN ga_ventas.cod_vendedor_agente%TYPE,
                            v_num_unidades          IN ga_ventas.num_unidades%TYPE,
                            v_cod_region          IN ga_ventas.cod_region%TYPE,
                            v_cod_provincia          IN ga_ventas.cod_provincia%TYPE,
                            v_cod_ciudad          IN ga_ventas.cod_ciudad%TYPE,
                            v_ind_estventa          IN ga_ventas.ind_estventa%TYPE,
                            v_num_transaccion      IN ga_ventas.num_transaccion%TYPE,
                            v_nom_usuario          IN ga_ventas.nom_usuar_vta%TYPE,
                            v_ind_venta              IN ga_ventas.ind_venta%TYPE,
                            v_ind_tipventa          IN ga_ventas.ind_tipventa%TYPE,
                            v_cod_cliente          IN ga_ventas.cod_cliente%TYPE,
                            v_tip_foliacion          IN ga_ventas.tip_foliacion%TYPE,
                            v_cod_tipdocum          IN ga_ventas.cod_tipdocum%TYPE,
                            v_cod_plaza              IN ga_ventas.cod_plaza%TYPE,
                            sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                              sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                              sn_num_evento   OUT NOCOPY ge_errores_pg.evento
) IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
v_cod_modventa    ga_ventas.cod_modventa%TYPE;
v_cod_operadora    ga_ventas.cod_operadora%TYPE;

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;

--      SELECT cod_operadora_scl
--        INTO v_cod_operadora
--        FROM ge_operadora_scl a
--       WHERE ind_oper_principal = 1;
       
       v_cod_operadora:= GE_OBTIENE_OPERADORA_LOCAL_FN(SN_cod_retorno,SV_mens_retorno,SN_num_evento); -- ahott

     lv_sql:= 'SELECT cod_contado '
               ||'FROM    ga_datosgener';

     SELECT cod_contado
     INTO    v_cod_modventa
     FROM    ga_datosgener;

     lv_sql:= 'INSERT INTO ga_ventas '
     ||'(num_venta, cod_producto, cod_oficina, cod_tipcomis, cod_vendedor, cod_vendedor_agente, num_unidades, fec_venta, cod_region, cod_provincia,'
     ||'cod_ciudad, ind_estventa, num_transaccion, nom_usuar_vta, ind_venta, ind_tipventa, cod_cliente, cod_modventa, tip_foliacion, cod_tipdocum,'
     ||'cod_plaza, cod_operadora)'
     ||'VALUES'
     ||'('||v_num_venta||','||v_cod_producto||','||v_cod_oficina||','||v_cod_tipcomis||','||v_cod_vendedor||','||v_cod_vendedor_agente||','||v_num_unidades||','
     ||SYSDATE||','||v_cod_region||','||v_cod_provincia||','||v_cod_ciudad||','||v_ind_estventa||','||v_num_transaccion||','||v_nom_usuario||','
     ||v_ind_venta||','||v_ind_tipventa||','||v_cod_cliente||','||v_cod_modventa||','||v_tip_foliacion||','||v_cod_tipdocum||','||v_cod_plaza||','
     ||v_cod_operadora||')';

     INSERT INTO ga_ventas
     (num_venta, cod_producto, cod_oficina, cod_tipcomis, cod_vendedor, cod_vendedor_agente, num_unidades, fec_venta, cod_region, cod_provincia,
     cod_ciudad, ind_estventa, num_transaccion, nom_usuar_vta, ind_venta, ind_tipventa, cod_cliente, cod_modventa, tip_foliacion, cod_tipdocum,
     cod_plaza, cod_operadora)
     VALUES
     (v_num_venta,v_cod_producto,v_cod_oficina,v_cod_tipcomis,v_cod_vendedor,v_cod_vendedor_agente,v_num_unidades,SYSDATE,v_cod_region,v_cod_provincia,
      v_cod_ciudad,v_ind_estventa,v_num_transaccion,v_nom_usuario,v_ind_venta,v_ind_tipventa,v_cod_cliente,v_cod_modventa,v_tip_foliacion,v_cod_tipdocum,
      v_cod_plaza,v_cod_operadora);

EXCEPTION
   WHEN OTHERS THEN
         sn_cod_retorno  := 66666;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_venta_accesorios_pg.ve_insert_venta_pr() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_insert_venta_pr()', lv_sql, SQLCODE, SQLERRM);
END ve_insert_venta_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_ciclo_factura_cliente(
                                  ev_cod_cliente       IN ge_clientes.cod_cliente%TYPE,
                                sn_cod_ciclfact    OUT NOCOPY fa_ciclfact.cod_ciclfact%TYPE,
                                sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  sn_num_evento      OUT NOCOPY ge_errores_pg.evento
) IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;

     lv_sql:= 'SELECT b.cod_ciclfact '
             ||'FROM      fa_ciclfact b '
             ||'WHERE     b.cod_ciclo =  (SELECT a.cod_ciclo '
                                             ||'FROM   ge_clientes a '
                                     ||'WHERE  a.cod_cliente = '||ev_cod_cliente||') '
             ||'AND      SYSDATE BETWEEN b.fec_desdeocargos AND nvl(b.fec_hastaocargos, SYSDATE)';

     SELECT b.cod_ciclfact
     INTO     sn_cod_ciclfact
     FROM      fa_ciclfact b
     WHERE     b.cod_ciclo =  (SELECT a.cod_ciclo
                                    FROM   ge_clientes a
                            WHERE  a.cod_cliente = ev_cod_cliente)
     AND      SYSDATE BETWEEN b.fec_desdeocargos AND nvl(b.fec_hastaocargos, SYSDATE);

EXCEPTION
   WHEN OTHERS THEN
         sn_cod_retorno  := 66666;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_venta_accesorios_pg.ve_ciclo_factura_cliente() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_ciclo_factura_cliente()', lv_sql, SQLCODE, SQLERRM);
END ve_ciclo_factura_cliente;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_update_venta_pr(
                            en_imp_venta       IN ga_ventas.imp_venta%TYPE,
                            ev_ind_estventa       IN ga_ventas.ind_estventa%TYPE,
                            en_num_venta       IN ga_ventas.num_venta%TYPE,
                            sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                              sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                              sn_num_evento      OUT NOCOPY ge_errores_pg.evento
) IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;

     lv_sql:= 'UPDATE ga_ventas SET imp_venta = '||en_imp_venta||', ind_estventa = '||ev_ind_estventa||', fec_aceprec = SYSDATE'
               ||'WHERE     num_venta = en_num_venta';


     UPDATE ga_ventas SET imp_venta = en_imp_venta, ind_estventa = ev_ind_estventa, fec_aceprec = SYSDATE
     WHERE     num_venta = en_num_venta;

EXCEPTION
   WHEN OTHERS THEN
         sn_cod_retorno  := 66666;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_venta_accesorios_pg.ve_update_venta_pr() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_update_venta_pr()', lv_sql, SQLCODE, lv_des_error);
END ve_update_venta_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_elimina_reserva_pr(
                                  ev_num_transaccion IN ga_reservart.num_transaccion%TYPE,
                                sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  sn_num_evento      OUT NOCOPY ge_errores_pg.evento
) IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;

      lv_sql:= 'DELETE ga_reservart WHERE num_transaccion = '||ev_num_transaccion||'';

     DELETE ga_reservart WHERE num_transaccion = ev_num_transaccion;

EXCEPTION
   WHEN OTHERS THEN
         sn_cod_retorno  := 66666;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_venta_accesorios_pg.ve_elimina_reserva_pr() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_elimina_reserva_pr()', lv_sql, SQLCODE, lv_des_error);
END ve_elimina_reserva_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_obt_tip_document_pr(
                                      ev_cod_cliente     IN  ge_clientes.cod_cliente%TYPE,
                                 sn_cod_tipdocum    OUT NOCOPY ge_tipdocumen.cod_tipdocum%TYPE,
                                 sv_tip_foliacion    OUT NOCOPY ge_tipdocumen.tip_foliacion%TYPE,
                                 sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento      OUT NOCOPY ge_errores_pg.evento
) IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;

     lv_sql:= 'SELECT b.cod_tipdocum,b.tip_foliacion '
             ||'FROM   ge_catribdocum a, ge_tipdocumen b '
             ||'WHERE  a.cod_catribut = (SELECT cod_catribut '
                                         ||'FROM   ga_catributclie '
                                       ||'WHERE  cod_cliente = '||ev_cod_cliente||' '
                                       ||'AND SYSDATE BETWEEN fec_desde AND fec_hasta) '
             ||'AND    SYSDATE BETWEEN a.fec_desde AND a.fec_hasta '
             ||'AND    a.cod_tipdocum = b.cod_tipdocum';

     SELECT b.cod_tipdocum,b.tip_foliacion
     INTO     sn_cod_tipdocum,sv_tip_foliacion
     FROM   ge_catribdocum a, ge_tipdocumen b
     WHERE  a.cod_catribut = (SELECT cod_catribut
                                FROM   ga_catributclie
                              WHERE  cod_cliente = ev_cod_cliente
                              AND SYSDATE BETWEEN fec_desde AND fec_hasta)
     AND    SYSDATE BETWEEN a.fec_desde AND a.fec_hasta
     AND    a.cod_tipdocum = b.cod_tipdocum;

EXCEPTION
   WHEN OTHERS THEN
         sn_cod_retorno  := 66666;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_venta_accesorios_pg.ve_obt_tip_document_pr() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_obt_tip_document_pr()', lv_sql, SQLCODE, lv_des_error);
END ve_obt_tip_document_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_obt_centrales_quiosco_pr(
                                 sc_centrales        OUT NOCOPY refcursor,
                                 sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento      OUT NOCOPY ge_errores_pg.evento)
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;



     open sc_centrales for
     select a.COD_VALOR, a.DES_VALOR from GED_CODIGOS a
     WHERE a.COD_MODULO=cv_modulove
     AND   a.NOM_TABLA='VE_CENTRAL_QUIOSCO'
     AND   a.NOM_COLUMNA='COD_CENTRAL';



EXCEPTION
   WHEN OTHERS THEN
         sn_cod_retorno  := 66666;
         sv_mens_retorno := 'No es posible obtener centrales';
         lv_des_error      := 've_venta_accesorios_pg.ve_obt_centrales_quiosco_pr() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_obt_centrales_quiosco_pr()', lv_sql, SQLCODE, lv_des_error);
END ve_obt_centrales_quiosco_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_sel_emp_recaudador_pr(
                                en_cod_caja          IN co_empresas_rex.cod_caja%TYPE,
                              sv_emp_recaudadora   OUT NOCOPY co_empresas_rex.emp_recaudadora%TYPE,
                              sv_cod_oficina       OUT NOCOPY co_empresas_rex.cod_oficina%TYPE,
                              sn_cod_caja          OUT NOCOPY co_empresas_rex.cod_caja%TYPE,
                              sv_cod_estado        OUT NOCOPY co_empresas_rex.cod_estado%TYPE,
                              sn_ind_abierta       OUT NOCOPY co_empresas_rex.ind_abierta%TYPE,
                              sv_cod_operadora_scl OUT NOCOPY co_empresas_rex.cod_operadora_scl%TYPE,
                              sv_cod_plaza         OUT NOCOPY co_empresas_rex.cod_plaza%TYPE,
                              sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento   OUT NOCOPY ge_errores_pg.evento
) IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno :=0;
        sv_mens_retorno:=' ';
        sn_num_evento  :=0;

     lv_sql:= 'SELECT emp_recaudadora, cod_oficina, cod_caja, cod_estado,ind_abierta, cod_operadora_scl, cod_plazaINTO sv_emp_recaudadora, sv_cod_oficina, sn_cod_caja, sv_cod_estado,sn_ind_abierta, sv_cod_operadora_scl, sv_cod_plaza'
           || ' FROM co_empresas_rex a'
           || ' WHERE cod_caja = '||en_cod_caja
           || ' AND cod_oficina = ''NT''';

      SELECT emp_recaudadora, cod_oficina, cod_caja, cod_estado,
             ind_abierta, cod_operadora_scl, cod_plaza
        INTO sv_emp_recaudadora, sv_cod_oficina, sn_cod_caja, sv_cod_estado,
             sn_ind_abierta, sv_cod_operadora_scl, sv_cod_plaza
        FROM co_empresas_rex a
       WHERE cod_caja = en_cod_caja
       AND cod_oficina = 'NT';

EXCEPTION
    WHEN OTHERS THEN
         sn_cod_retorno  := 5444;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_venta_accesorios_pg.ve_select_datos_serie() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_venta_accesorios_pg.ve_select_datos_serie', lv_sql, SQLCODE, SQLERRM);
END ve_sel_emp_recaudador_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END ve_venta_accesorios_pg;
/

SHOW ERRORS