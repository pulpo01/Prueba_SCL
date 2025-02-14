CREATE OR REPLACE PACKAGE BODY AL_SERIES_PORTABILIDAD_PG AS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION al_crea_movimiento_pr(
      er_movim        IN         al_movimientos%rowtype,
      SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
   )RETURN BOOLEAN
   IS
      LV_des_error       VARCHAR2(300);
      LV_sql             VARCHAR2(1000);

   BEGIN
      SN_cod_retorno :=0;
      SV_mens_retorno:=' ';
      SN_num_evento  :=0;

      LV_sql:='AL_PAC_VALIDACIONES.P_INSERTA_MOVIM(er_movim)';
      AL_PAC_VALIDACIONES.P_INSERTA_MOVIM(er_movim);
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno  := 10046;
            SV_mens_retorno := 'Error al Procesar Movimiento';
            LV_des_error    := 'al_series_portabilidad_pg.al_crea_movimiento_pr(); - ' || SQLERRM;
            SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_crea_movimiento_pr()', LV_sql, SQLCODE, LV_des_error );
            RETURN FALSE;
   END al_crea_movimiento_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION al_val_res_art_fn (
      en_cod_articulo     IN              al_articulos.cod_articulo%TYPE,
    en_cod_vendedor     IN              ve_vendedores.cod_vendedor%TYPE,
    en_cantidad         IN              NUMBER,
    en_num_venta        IN              NUMBER,
    ev_nom_usuario      IN              VARCHAR2,
    en_cod_bodega      IN                al_stock.COD_BODEGA%TYPE,-- CSR-11002
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   RETURN BOOLEAN
   IS
      LV_des_error       VARCHAR2(300);
      LV_sql             VARCHAR2(1000);
    cant               NUMBER;
    n_cod_bodega       NUMBER;
    n_num_movimi       NUMBER;
    rt_movim           al_movimientos%rowtype;
    error_ejecucion    EXCEPTION;
   BEGIN

      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '';

      LV_sql:= 'SELECT cod_uso, cod_estado, c.cod_bodega, b.tip_stock FROM al_articulos a, al_stock b, ve_vendalmac c'
         || ' WHERE a.cod_articulo = '||en_cod_articulo
       || ' AND b.cod_articulo = a.cod_articulo'
       || ' AND b.tip_stock = 2'
       || ' AND a.ind_seriado = 0'
       || ' AND b.cod_bodega = c.cod_bodega'
       || ' AND c.cod_vendedor = '||en_cod_vendedor
       || ' AND b.can_stock >= '||en_cantidad
           || ' AND b.cod_estado = 7'  -- Para salida definitiva de articulo previamente  reservado
       || ' AND rownum < 2';


     SELECT count(1)
       INTO cant
       FROM al_articulos a, al_stock b, ve_vendalmac c
      WHERE a.cod_articulo = en_cod_articulo
      AND b.cod_articulo = a.cod_articulo
      AND b.tip_stock = 2
      AND a.ind_seriado = 0
      AND b.cod_bodega = c.cod_bodega
      AND c.cod_vendedor = en_cod_vendedor
      AND b.can_stock >= en_cantidad
          AND b.cod_estado = 7;

       --SELECT cod_bodega INTO n_cod_bodega FROM ve_vendalmac a where cod_vendedor = en_cod_vendedor and a.FEC_DESASIGNAC is null; CSR-11002
        n_cod_bodega := en_cod_bodega;-- CSR-1002
        
         LV_sql:= 'SELECT al_seq_mvto.NEXTVAL '
                || ' FROM dual';

         SELECT al_seq_mvto.NEXTVAL
           INTO n_num_movimi
           FROM dual;

         rt_movim.num_movimiento := n_num_movimi;
         rt_movim.num_transaccion:= en_num_venta ;
         rt_movim.fec_movimiento := SYSDATE;
         rt_movim.cod_bodega     := n_cod_bodega;
         rt_movim.tip_stock      := 2;
         rt_movim.cod_articulo   := en_cod_articulo;
         rt_movim.cod_uso        := 3;
         rt_movim.cod_estado     := 1;
         rt_movim.num_cantidad   := en_cantidad;
         rt_movim.cod_estadomov  := 'SO';
         rt_movim.nom_usuarora   := ev_nom_usuario;
         rt_movim.cod_producto   := 1;
         rt_movim.tip_movimiento := 6;
         rt_movim.cod_transaccion:= 3;
         rt_movim.num_desde      := 0;
     rt_movim.cod_estado_dest:= 7;

      IF NOT (al_crea_movimiento_pr(rt_movim,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;


      RETURN TRUE;

      EXCEPTION
         WHEN error_ejecucion THEN
            SN_cod_retorno  := 10042;
            SV_mens_retorno := 'No existe informacion de articulo en almacén';
            LV_des_error    := 'al_series_portabilidad_pg.al_rec_info_art_fn(); - ' || SQLERRM;
            SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_rec_info_serie_fn()', LV_sql, SQLCODE, LV_des_error );
            RETURN FALSE;
         WHEN NO_DATA_FOUND THEN
            SN_cod_retorno  := 10042;
            SV_mens_retorno := 'No existe informacion de articulo en almacén';
            LV_des_error    := 'al_series_portabilidad_pg.al_rec_info_art_fn(); - ' || SQLERRM;
            SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_rec_info_serie_fn()', LV_sql, SQLCODE, LV_des_error );
            RETURN FALSE;

         WHEN OTHERS THEN
            SN_cod_retorno  := 10043;
            SV_mens_retorno := 'Error no definido al recuperar informacion de articulo en almacén';
            LV_des_error    := 'al_series_portabilidad_pg.al_rec_info_art_fn(); - ' || SQLERRM;
            SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_rec_info_serie_fn()', LV_sql, SQLCODE, LV_des_error );
            RETURN FALSE;
   END al_val_res_art_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION al_rec_info_art_fn (
      en_cod_articulo     IN              al_articulos.cod_articulo%TYPE,
    en_cod_vendedor     IN              ve_vendedores.cod_vendedor%TYPE,
    en_cantidad         IN              NUMBER,
    sn_cod_uso          OUT NOCOPY      al_stock.COD_USO%TYPE,
    sn_cod_estado       OUT NOCOPY      al_stock.cod_estado%TYPE,
    sn_cod_bodega       OUT NOCOPY      al_stock.cod_bodega%TYPE,
    sn_tip_stock        OUT NOCOPY      al_stock.tip_stock%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   RETURN BOOLEAN
   IS
      LV_des_error       VARCHAR2(300);
      LV_sql             VARCHAR2(1000);
   BEGIN

      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '';

      LV_sql:= 'SELECT cod_uso, cod_estado, c.cod_bodega, b.tip_stock FROM al_articulos a, al_stock b, ve_vendalmac c'
         || ' WHERE a.cod_articulo = '||en_cod_articulo
       || ' AND b.cod_articulo = a.cod_articulo'
       || ' AND b.tip_stock = 2'
       || ' AND a.ind_seriado = 0'
       || ' AND b.cod_bodega = c.cod_bodega'
       || ' AND c.cod_vendedor = '||en_cod_vendedor
       || ' AND b.can_stock >= '||en_cantidad
           || ' AND b.cod_estado = 7'  -- Para salida definitiva de articulo previamente  reservado
       || ' AND rownum < 2';


     SELECT cod_uso, cod_estado, c.cod_bodega, b.tip_stock
       INTO sn_cod_uso, sn_cod_estado, sn_cod_bodega, sn_tip_stock
       FROM al_articulos a, al_stock b, ve_vendalmac c
      WHERE a.cod_articulo = en_cod_articulo
      AND b.cod_articulo = a.cod_articulo
      AND b.tip_stock = 2
      AND a.ind_seriado = 0
      AND b.cod_bodega = c.cod_bodega
      AND c.cod_vendedor = en_cod_vendedor
      AND b.can_stock >= en_cantidad
          AND b.cod_estado = 7  -- Para salida definitiva de articulo previamente  reservado
          --INICIO INC 144922 GDO 05-10-2010
          AND c.FEC_DESASIGNAC is null
          --FIN INC 144922 GDO 05-10-2010
          AND rownum < 2;

      RETURN TRUE;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            SN_cod_retorno  := 10042;
            SV_mens_retorno := 'No existe informacion de articulo en almacén';
            LV_des_error    := 'al_series_portabilidad_pg.al_rec_info_art_fn(); - ' || SQLERRM;
            SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_rec_info_serie_fn()', LV_sql, SQLCODE, LV_des_error );
            RETURN FALSE;

         WHEN OTHERS THEN
            SN_cod_retorno  := 10043;
            SV_mens_retorno := 'Error no definido al recuperar informacion de articulo en almacén';
            LV_des_error    := 'al_series_portabilidad_pg.al_rec_info_art_fn(); - ' || SQLERRM;
            SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_rec_info_serie_fn()', LV_sql, SQLCODE, LV_des_error );
            RETURN FALSE;
   END al_rec_info_art_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION al_rec_info_serie_fn (
      ev_num_serie        IN              al_series.num_serie%TYPE,
      sr_series           OUT NOCOPY      al_series%rowtype,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   RETURN BOOLEAN
   IS
      LV_des_error       VARCHAR2(300);
      LV_sql             VARCHAR2(1000);
   BEGIN

      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '';

      LV_sql := 'SELECT a.cod_articulo,a.num_serie, a.cod_bodega,a.tip_stock,a.cod_uso,a.ind_telefono, a.num_telefono, a.cod_central, a.plan, a.carga, a.cod_estado, a.cod_subalm, a.cod_cat, a.cod_hlr FROM al_series a'
             || ' WHERE a.num_serie= '||ev_num_serie;

      SELECT a.cod_articulo,a.num_serie, a.cod_bodega,a.tip_stock,a.cod_uso,a.ind_telefono, a.num_telefono, a.cod_central, a.plan, a.carga, a.cod_estado, a.cod_subalm, a.cod_cat, a.cod_hlr
        INTO sr_series.cod_articulo, sr_series.num_serie, sr_series.cod_bodega, sr_series.tip_stock,sr_series.cod_uso, sr_series.ind_telefono,sr_series.num_telefono, sr_series.cod_central,sr_series.plan, sr_series.carga, sr_series.cod_estado, sr_series.cod_subalm, sr_series.cod_cat, sr_series.cod_hlr
        FROM al_series a
       WHERE a.num_serie=ev_num_serie ;
      RETURN TRUE;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            SN_cod_retorno  := 10042;
            SV_mens_retorno := 'No existe informacion de serie en almacén';
            LV_des_error    := 'al_series_portabilidad_pg.al_rec_info_serie_fn(); - ' || SQLERRM;
            SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_rec_info_serie_fn()', LV_sql, SQLCODE, LV_des_error );
            RETURN FALSE;

         WHEN OTHERS THEN
            SN_cod_retorno  := 10043;
            SV_mens_retorno := 'Error no definido al recuperar informacion de serie en almacén';
            LV_des_error    := 'al_series_portabilidad_pg.al_rec_info_serie_fn(); - ' || SQLERRM;
            SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_rec_info_serie_fn()', LV_sql, SQLCODE, LV_des_error );
            RETURN FALSE;
   END al_rec_info_serie_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION al_rec_info_serie_mov_fn (
      ev_num_serie        IN              al_series.num_serie%TYPE,
      rt_movim            OUT NOCOPY      al_movimientos%rowtype,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   RETURN BOOLEAN
   IS
      LV_des_error       VARCHAR2(300);
      LV_sql             VARCHAR2(1000);
   BEGIN

      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '';

      LV_sql := 'SELECT num_movimiento, tip_movimiento, fec_movimiento, tip_stock, cod_bodega, cod_articulo, cod_uso, cod_estado, num_cantidad, cod_estadomov, nom_usuarora, tip_stock_dest, cod_bodega_dest, cod_uso_dest, cod_estado_dest, num_serie, num_desde, num_hasta, num_guia, prc_unidad, cod_transaccion, num_transaccion, num_seriemec, num_telefono, cap_code, cod_producto, cod_central, cod_moneda, cod_subalm, cod_central_dest, cod_subalm_dest, num_telefono_dest, cod_cat, cod_cat_dest, ind_telefono, plan, carga, num_sec_loca, cod_hlr, cod_plaza'
             || ' FROM al_movimientos'
             || ' WHERE num_serie = '''||ev_num_serie||''' '
             || ' AND fec_movimiento = (SELECT MAX(fec_movimiento) FROM al_movimientos WHERE num_serie = '''||ev_num_serie ||'''AND ROWNUM < 2)';

      SELECT num_movimiento, tip_movimiento, fec_movimiento, tip_stock, cod_bodega, cod_articulo, cod_uso, cod_estado, num_cantidad, cod_estadomov, nom_usuarora, tip_stock_dest, cod_bodega_dest, cod_uso_dest, cod_estado_dest, num_serie, num_desde, num_hasta, num_guia, prc_unidad, cod_transaccion, num_transaccion, num_seriemec, num_telefono, cap_code, cod_producto, cod_central, cod_moneda, cod_subalm, cod_central_dest, cod_subalm_dest, num_telefono_dest, cod_cat, cod_cat_dest, ind_telefono, plan, carga, num_sec_loca, cod_hlr, cod_plaza
        INTO rt_movim.num_movimiento, rt_movim.tip_movimiento, rt_movim.fec_movimiento, rt_movim.tip_stock, rt_movim.cod_bodega, rt_movim.cod_articulo, rt_movim.cod_uso, rt_movim.cod_estado, rt_movim.num_cantidad, rt_movim.cod_estadomov, rt_movim.nom_usuarora, rt_movim.tip_stock_dest, rt_movim.cod_bodega_dest, rt_movim.cod_uso_dest, rt_movim.cod_estado_dest, rt_movim.num_serie, rt_movim.num_desde, rt_movim.num_hasta, rt_movim.num_guia, rt_movim.prc_unidad, rt_movim.cod_transaccion, rt_movim.num_transaccion, rt_movim.num_seriemec, rt_movim.num_telefono,
             rt_movim.cap_code, rt_movim.cod_producto, rt_movim.cod_central, rt_movim.cod_moneda, rt_movim.cod_subalm, rt_movim.cod_central_dest, rt_movim.cod_subalm_dest, rt_movim.num_telefono_dest, rt_movim.cod_cat, rt_movim.cod_cat_dest, rt_movim.ind_telefono, rt_movim.plan, rt_movim.carga, rt_movim.num_sec_loca, rt_movim.cod_hlr, rt_movim.cod_plaza
        FROM al_movimientos
       WHERE num_serie = ev_num_serie
         AND fec_movimiento = (SELECT MAX(fec_movimiento) FROM al_movimientos WHERE num_serie = ev_num_serie AND ROWNUM < 2);
      RETURN TRUE;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            SN_cod_retorno  := 10044;
            SV_mens_retorno := 'No existe informacion de movimientos de serie en almacen';
            LV_des_error    := 'al_series_portabilidad_pg.al_rec_info_serie_mov_fn(); - ' || SQLERRM;
            SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_rec_info_serie_mov_fn()', LV_sql, SQLCODE, LV_des_error );
            RETURN FALSE;

         WHEN OTHERS THEN
            SN_cod_retorno  := 10045;
            SV_mens_retorno := 'Error no definido al recuperar informacion de moviminetos de la serie';
            LV_des_error    := 'al_series_portabilidad_pg.al_rec_info_serie_mov_fn(); - ' || SQLERRM;
            SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_rec_info_serie_mov_fn()', LV_sql, SQLCODE, LV_des_error );
            RETURN FALSE;
   END al_rec_info_serie_mov_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE al_reserva_series_pr (
      ev_num_serie         IN              VARCHAR2,
      ev_nom_usuario       IN              VARCHAR2,
      en_num_venta         IN              VARCHAR2,
      sn_num_movimiento    OUT NOCOPY      VARCHAR2,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
   AS
      LV_des_error       VARCHAR2(300);
      LV_sql             VARCHAR2(1000);
      rt_series          al_series%rowtype;
      rt_movim           al_movimientos%rowtype;
      error_ejecucion    EXCEPTION;

   BEGIN
      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '';

      IF NOT (al_rec_info_serie_fn (ev_num_serie,rt_series,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      LV_sql:=' SELECT al_seq_mvto.NEXTVAL'
            ||' FROM dual';

      SELECT al_seq_mvto.NEXTVAL
        INTO rt_movim.num_movimiento
        FROM dual;

      sn_num_movimiento := rt_movim.num_movimiento;
      rt_movim.num_transaccion:= en_num_venta ;
      rt_movim.fec_movimiento := SYSDATE;
      rt_movim.cod_bodega     := rt_series.cod_bodega;
      rt_movim.tip_stock      := rt_series.tip_Stock;
      rt_movim.cod_articulo   := rt_series.cod_Articulo;
      rt_movim.cod_uso        := rt_series.cod_Uso;
      rt_movim.cod_estado     := rt_series.cod_Estado;
      rt_movim.num_serie      := rt_series.num_Serie;
      rt_movim.num_cantidad   := 1;
      rt_movim.cod_estadomov  := 'SO';
      rt_movim.nom_usuarora   := ev_nom_usuario;
      rt_movim.cod_producto   := 1;
      rt_movim.ind_telefono   := rt_series.Ind_Telefono;
      rt_movim.num_telefono   := rt_series.num_Telefono;
      rt_movim.cod_central    := rt_series.cod_Central;
      rt_movim.tip_movimiento := 6;
      rt_movim.tip_stock_dest := rt_series.tip_Stock;
      rt_movim.cod_transaccion:= 3;
      rt_movim.cod_bodega_dest:= NULL;
      rt_movim.cod_central    := rt_series.cod_central;
      rt_movim.cod_estado_dest:= 7;
      rt_movim.cod_subalm     := rt_series.cod_subalm;
      rt_movim.cod_cat        := rt_series.cod_Cat;
      rt_movim.PLAN           := rt_series.Plan;
      rt_movim.carga          := rt_series.Carga;
      rt_movim.num_sec_loca   := NULL;
      rt_movim.prc_unidad     := rt_series.prc_compra;
      rt_movim.cod_hlr        := rt_series.cod_hlr;
      rt_movim.cod_plaza      := rt_series.cod_plaza;
      rt_movim.cod_moneda     := '001';

      IF NOT (al_crea_movimiento_pr(rt_movim,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      EXCEPTION
         WHEN error_ejecucion THEN
            LV_des_error    := 'al_series_portabilidad_pg.al_reserva_series_pr(); - ' || SQLERRM;
            SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_reserva_series_pr()', LV_sql, SQLCODE, LV_des_error );

         WHEN OTHERS THEN
            SN_cod_retorno  := 10047;
            SV_mens_retorno := 'Error no definido al reservar serie';
            LV_des_error    := 'al_series_portabilidad_pg.al_reserva_series_pr(); - ' || SQLERRM;
            SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_reserva_series_pr()', LV_sql, SQLCODE, LV_des_error );
   END al_reserva_series_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE al_desreserva_series_pr (
      ev_num_serie         IN              VARCHAR2,
      ev_nom_usuario       IN              VARCHAR2,
      en_num_venta         IN              VARCHAR2,
      sn_num_movimiento    OUT NOCOPY      VARCHAR2,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
   AS
      LV_des_error       VARCHAR2(300);
      LV_sql             VARCHAR2(1000);
      rt_series          al_series%rowtype;
      rt_movim           al_movimientos%rowtype;
      error_ejecucion    EXCEPTION;

   BEGIN
      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '';

      IF NOT (al_rec_info_serie_fn (ev_num_serie,rt_series,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

       LV_sql  := 'SELECT al_seq_mvto.NEXTVAL'
               || ' FROM dual';

      SELECT al_seq_mvto.NEXTVAL
        INTO rt_movim.num_movimiento
        FROM dual;

      sn_num_movimiento := rt_movim.num_movimiento;
      rt_movim.num_transaccion:= en_num_venta ;
      rt_movim.fec_movimiento := SYSDATE;
      rt_movim.cod_bodega     := rt_series.cod_bodega;
      rt_movim.tip_stock      := rt_series.tip_Stock;
      rt_movim.cod_articulo   := rt_series.cod_Articulo;
      rt_movim.cod_uso        := rt_series.cod_Uso;
      rt_movim.cod_estado     := rt_series.cod_Estado;
      rt_movim.num_serie      := rt_series.num_Serie;
      rt_movim.num_cantidad   := 1;
      rt_movim.cod_estadomov  := 'SO';
      rt_movim.nom_usuarora   := ev_nom_usuario;
      rt_movim.cod_producto   := 1;
      rt_movim.ind_telefono   := rt_series.Ind_Telefono;
      rt_movim.num_telefono   := rt_series.num_Telefono;
      rt_movim.cod_central    := rt_series.cod_Central;
      rt_movim.tip_movimiento := 6;
      rt_movim.tip_stock_dest := rt_series.tip_Stock;
      rt_movim.cod_transaccion:= 3;
      rt_movim.cod_bodega_dest:= NULL;
      rt_movim.cod_central    := rt_series.cod_central;
      rt_movim.cod_estado_dest:= 1;
      rt_movim.cod_subalm     := rt_series.cod_subalm;
      rt_movim.cod_cat        := rt_series.cod_Cat;
      rt_movim.PLAN           := rt_series.Plan;
      rt_movim.carga          := rt_series.Carga;
      rt_movim.num_sec_loca   := NULL;
      rt_movim.prc_unidad     := rt_series.prc_compra;
      rt_movim.cod_hlr        := rt_series.cod_hlr;
      rt_movim.cod_plaza      := rt_series.cod_plaza;
      rt_movim.cod_moneda     := '001';

      IF NOT (al_crea_movimiento_pr(rt_movim,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
         LV_des_error    := 'al_series_portabilidad_pg.al_desreserva_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_desreserva_series_pr()', LV_sql, SQLCODE, LV_des_error );

      WHEN OTHERS THEN
         SV_mens_retorno := 'Error no definido al desreservar serie';
         LV_des_error    := 'al_series_portabilidad_pg.al_desreserva_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_desreserva_series_pr()', LV_sql, SQLCODE, LV_des_error );
   END al_desreserva_series_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE al_salida_def_series_pr (
      ev_num_serie         IN              VARCHAR2,
      ev_nom_usuario       IN              VARCHAR2,
      en_num_venta         IN              VARCHAR2,
      sn_num_movimiento    OUT NOCOPY      VARCHAR2,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento) AS

      LV_des_error         VARCHAR2(300);
      LV_sql               VARCHAR2(1000);
      error_ejecucion      EXCEPTION;
      rt_series            al_series%rowtype;
      rt_movim             al_movimientos%rowtype;

   BEGIN
      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '';

      IF NOT (al_rec_info_serie_fn (ev_num_serie,rt_series,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

       LV_sql:= 'SELECT al_seq_mvto.NEXTVAL '
             || ' FROM dual';

      SELECT al_seq_mvto.NEXTVAL
        INTO rt_movim.num_movimiento
        FROM dual;

      sn_num_movimiento := to_char(rt_movim.num_movimiento);
      rt_movim.num_transaccion:= en_num_venta ;
      rt_movim.fec_movimiento := SYSDATE;
      rt_movim.cod_bodega     := rt_series.cod_bodega;
      rt_movim.tip_stock      := rt_series.tip_Stock;
      rt_movim.cod_articulo   := rt_series.cod_Articulo;
      rt_movim.cod_uso        := rt_series.cod_Uso;
      rt_movim.cod_estado     := rt_series.cod_Estado;
      rt_movim.num_serie      := rt_series.num_Serie;
      rt_movim.num_cantidad   := 1;
      rt_movim.cod_estadomov  := 'SO';
      rt_movim.nom_usuarora   := ev_nom_usuario;
      rt_movim.cod_producto   := 1;
      rt_movim.ind_telefono   := rt_series.Ind_Telefono;
      rt_movim.num_telefono   := rt_series.num_Telefono;
      rt_movim.cod_central    := rt_series.cod_Central;
      rt_movim.tip_movimiento := 3;
      rt_movim.tip_stock_dest := rt_series.tip_Stock;
      rt_movim.cod_transaccion:= 3;
      rt_movim.cod_bodega_dest:= NULL;
      rt_movim.cod_central    := rt_series.cod_central;
      rt_movim.cod_estado_dest:= CV_EstadoDestinoRes;
      rt_movim.cod_subalm     := rt_series.cod_subalm;
      rt_movim.cod_cat        := rt_series.cod_Cat;
      rt_movim.PLAN           := rt_series.Plan;
      rt_movim.carga          := rt_series.Carga;
      rt_movim.num_sec_loca   := NULL;
      rt_movim.prc_unidad     := rt_series.prc_compra;
      rt_movim.cod_hlr        := rt_series.cod_hlr;
      rt_movim.cod_plaza      := rt_series.cod_plaza;
      rt_movim.cod_moneda     := '001';

      IF NOT (al_crea_movimiento_pr(rt_movim,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
         LV_des_error    := 'al_series_portabilidad_pg.al_salida_def_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_salida_def_series_pr()', LV_sql, SQLCODE, LV_des_error );

     WHEN OTHERS THEN
         SN_cod_retorno  := 10049;
         SV_mens_retorno := 'Error no definido en la salida definitiva de la serie';
         LV_des_error    := 'al_series_portabilidad_pg.al_salida_def_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_salida_def_series_pr()', LV_sql, SQLCODE, LV_des_error );

   END al_salida_def_series_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE al_reingreso_series_pr (
      ev_num_serie         IN              al_series.num_serie%TYPE,
      ev_nom_usuario       IN              VARCHAR2,
      en_cod_USO           IN              al_bodegas.cod_bodega%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
   AS
      LV_des_error       VARCHAR2(300);
      LV_sql             VARCHAR2(1000);
      rt_movim_info      al_movimientos%rowtype;
      rt_movim           al_movimientos%rowtype;
      error_ejecucion    EXCEPTION;

   BEGIN
      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '';

      IF NOT (al_rec_info_serie_mov_fn (ev_num_serie,rt_movim_info,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      LV_sql  := 'SELECT  al_seq_mvto.NEXTVAL'
              || ' FROM dual';

      SELECT  al_seq_mvto.NEXTVAL
        INTO rt_movim.num_movimiento
        FROM dual;

      rt_movim.num_transaccion:= null ;
      rt_movim.fec_movimiento := SYSDATE;
      rt_movim.cod_bodega     := rt_movim_info.cod_bodega;
      rt_movim.tip_stock      := rt_movim_info.tip_stock;
      rt_movim.cod_articulo   := rt_movim_info.cod_Articulo;
      rt_movim.cod_uso        := en_cod_USO;   --rt_movim_info.cod_Uso;
      rt_movim.cod_estado     := rt_movim_info.cod_Estado;
      rt_movim.num_serie      := rt_movim_info.num_Serie;
      rt_movim.num_cantidad   := 1;
      rt_movim.cod_estadomov  := 'SO';
      rt_movim.nom_usuarora   := ev_nom_usuario;
      rt_movim.cod_producto   := 1;
      rt_movim.ind_telefono   := rt_movim_info.Ind_Telefono;
      rt_movim.num_telefono   := rt_movim_info.num_Telefono;
      rt_movim.cod_central    := rt_movim_info.cod_Central;
      rt_movim.tip_movimiento := 10;
      rt_movim.tip_stock_dest := rt_movim_info.tip_Stock;
      rt_movim.cod_transaccion:= 3;
      rt_movim.cod_bodega_dest:= NULL;
      rt_movim.cod_central    := rt_movim_info.cod_central;
      rt_movim.cod_estado_dest:= 1;
      rt_movim.cod_subalm     := rt_movim_info.cod_subalm;
      rt_movim.cod_cat        := rt_movim_info.cod_Cat;
      rt_movim.PLAN           := rt_movim_info.Plan;
      rt_movim.carga          := rt_movim_info.Carga;
      rt_movim.num_sec_loca   := NULL;
      rt_movim.prc_unidad     := rt_movim_info.prc_unidad;
      rt_movim.cod_hlr        := rt_movim_info.cod_hlr;
      rt_movim.cod_plaza      := rt_movim_info.cod_plaza;
      rt_movim.cod_moneda     := '001';

      IF NOT (al_crea_movimiento_pr(rt_movim,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
         LV_des_error    := 'al_series_portabilidad_pg.al_reingreso_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_reingreso_series_pr()', LV_sql, SQLCODE, LV_des_error );

      WHEN OTHERS THEN
         SN_cod_retorno  := 10050;
         SV_mens_retorno := 'Error no definido en el reingreso de la serie a almacén';
         LV_des_error    := 'al_series_portabilidad_pg.al_reingreso_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_reingreso_series_pr()', LV_sql, SQLCODE, LV_des_error );
   END al_reingreso_series_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE al_cambio_bodega_series_pr (
      ev_num_serie         IN              al_series.num_serie%TYPE,
      ev_nom_usuario       IN              VARCHAR2,
      en_cod_uso           IN              al_movimientos.cod_uso%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
   AS
      LV_des_error       VARCHAR2(300);
      LV_sql             VARCHAR2(1000);
      rt_movim_info      al_movimientos%rowtype;
      rt_movim           al_movimientos%rowtype;
      error_ejecucion    EXCEPTION;

   BEGIN
      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '';

      IF NOT (al_rec_info_serie_mov_fn (ev_num_serie,rt_movim_info,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      LV_sql:=' SELECT  al_seq_mvto.NEXTVAL'
            ||' FROM dual';

      SELECT  al_seq_mvto.NEXTVAL
        INTO rt_movim.num_movimiento
        FROM dual;

      rt_movim.num_transaccion:= 3;
      rt_movim.fec_movimiento := SYSDATE;
      rt_movim.cod_bodega     := rt_movim_info.cod_bodega;
      rt_movim.tip_stock      := rt_movim_info.tip_Stock;
      rt_movim.cod_articulo   := rt_movim_info.cod_Articulo;
      rt_movim.cod_uso        := rt_movim_info.cod_Uso;
      rt_movim.cod_estado     := rt_movim_info.cod_Estado;
      rt_movim.num_serie      := rt_movim_info.num_Serie;
      rt_movim.num_cantidad   := 1;
      rt_movim.cod_estadomov  := 'SO';
      rt_movim.nom_usuarora   := ev_nom_usuario;
      rt_movim.cod_producto   := 1;
      rt_movim.ind_telefono   := rt_movim_info.Ind_Telefono;
      rt_movim.num_telefono   := rt_movim_info.num_Telefono;
      rt_movim.cod_central    := rt_movim_info.cod_Central;
      rt_movim.tip_movimiento := 16;
      rt_movim.tip_stock_dest := rt_movim_info.tip_Stock;
      rt_movim.cod_transaccion:= 2;
      rt_movim.cod_bodega_dest:= rt_movim_info.cod_bodega;
      rt_movim.cod_central    := rt_movim_info.cod_central;
      rt_movim.cod_estado_dest:= 1;
      rt_movim.cod_subalm     := rt_movim_info.cod_subalm;
      rt_movim.cod_cat        := rt_movim_info.cod_Cat;
      rt_movim.PLAN           := rt_movim_info.Plan;
      rt_movim.carga          := rt_movim_info.Carga;
      rt_movim.num_sec_loca   := NULL;
      rt_movim.prc_unidad     := rt_movim_info.prc_unidad;
      rt_movim.cod_hlr        := rt_movim_info.cod_hlr;
      rt_movim.cod_plaza      := rt_movim_info.cod_plaza;
      rt_movim.cod_moneda     := rt_movim_info.cod_moneda;
      rt_movim.cod_uso_dest   := en_cod_uso;

      IF NOT (al_crea_movimiento_pr(rt_movim,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
         LV_des_error    := 'al_series_portabilidad_pg.al_reingreso_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_reingreso_series_pr()', LV_sql, SQLCODE, LV_des_error );

      WHEN OTHERS THEN
         SN_cod_retorno  := 10050;
         SV_mens_retorno := 'Error no definido en el reingreso de la serie a almacén';
         LV_des_error    := 'al_series_portabilidad_pg.al_reingreso_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_reingreso_series_pr()', LV_sql, SQLCODE, LV_des_error );
   END al_cambio_bodega_series_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE al_sal_def_art_vend_pr (
      en_cod_articulo      IN              al_articulos.cod_articulo%TYPE,
      ev_nom_usuario       IN              ge_seg_usuario.nom_usuario%TYPE ,
      en_num_venta         IN              ga_ventas.num_venta%TYPE,
    en_cod_vendedor      IN              ve_vendedores.cod_vendedor%TYPE,
    en_num_cantidad      IN              NUMBER,
      en_cod_bodega      IN                al_stock.COD_BODEGA%TYPE,-- CSR-11002
      sn_num_movimiento    OUT NOCOPY      al_movimientos.num_movimiento%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
   AS
      LV_des_error         VARCHAR2(300);
      LV_sql               VARCHAR2(1000);
      error_ejecucion      EXCEPTION;
      n_cod_uso            NUMBER;
    n_cod_estado         NUMBER;
    n_cod_bodega         NUMBER;
    n_tip_stock          NUMBER;
      rt_movim             al_movimientos%rowtype;
   BEGIN
      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '';


    --IF NOT (al_val_res_art_fn (en_cod_articulo,en_cod_vendedor, en_num_cantidad,en_num_venta,ev_nom_usuario,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
    IF NOT (al_val_res_art_fn (en_cod_articulo,en_cod_vendedor, en_num_cantidad,en_num_venta,ev_nom_usuario,en_cod_bodega,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
       RAISE error_ejecucion;
    END IF;

    IF NOT (al_rec_info_art_fn (en_cod_articulo,en_cod_vendedor, en_num_cantidad,n_cod_uso,n_cod_estado,n_cod_bodega, n_tip_stock,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
       RAISE error_ejecucion;
    END IF;


       LV_sql:= 'SELECT al_seq_mvto.NEXTVAL '
             || ' FROM dual';

      SELECT al_seq_mvto.NEXTVAL
        INTO rt_movim.num_movimiento
        FROM dual;

      sn_num_movimiento := to_char(rt_movim.num_movimiento);
      rt_movim.num_transaccion:= en_num_venta ;
      rt_movim.fec_movimiento := SYSDATE;
      rt_movim.cod_bodega     := n_cod_bodega;
      rt_movim.tip_stock      := n_tip_stock;
      rt_movim.cod_articulo   := en_cod_Articulo;
      rt_movim.cod_uso        := n_cod_Uso;
      rt_movim.cod_estado     := n_cod_Estado;
      rt_movim.num_cantidad   := en_num_cantidad;
      rt_movim.cod_estadomov  := 'SO';
      rt_movim.nom_usuarora   := ev_nom_usuario;
      rt_movim.cod_producto   := 1;
      rt_movim.tip_movimiento := 3;
      rt_movim.cod_transaccion:= 3;
      rt_movim.num_desde      := 0;

      IF NOT (al_crea_movimiento_pr(rt_movim,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
         LV_des_error    := 'al_series_portabilidad_pg.al_salida_def_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_salida_def_series_pr()', LV_sql, SQLCODE, LV_des_error );

     WHEN OTHERS THEN
         SN_cod_retorno  := 10049;
         SV_mens_retorno := 'Error no definido en la salida definitiva de la serie';
         LV_des_error    := 'al_series_portabilidad_pg.al_salida_def_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_salida_def_series_pr()', LV_sql, SQLCODE, LV_des_error );

   END al_sal_def_art_vend_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 END AL_SERIES_PORTABILIDAD_PG;
/

SHOW ERRORS