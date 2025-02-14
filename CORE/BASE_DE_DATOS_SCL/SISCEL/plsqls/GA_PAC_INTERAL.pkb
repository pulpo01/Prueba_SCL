CREATE OR REPLACE package body GA_PAC_INTERAL
IS

PROCEDURE p_trata_interfaz(
  v_inter IN OUT type_inter )
  IS
        v_movim       al_movimientos%rowtype;
        v_usado       ga_datosgener.cod_estusado%type;
        v_reserva     al_datos_generales.cod_estado_rvt%type;
        v_temporal    al_datos_generales.cod_estado_tem%type;
        v_transac     ga_transacabo%rowtype;
        v_indes       al_tipos_movimientos.ind_entsal%type;

BEGIN
        if v_inter.tipo <> 9 THEN --BORRAR LINEA EN DEFINITIVA
                                                                    p_obtiene_tipmovim (v_inter.tipo,v_movim.tip_movimiento,
                            v_usado,v_inter.error,
                            v_transac.des_cadena);
        ELSE --BORRAR LINEA EN DEFINITIVA
            v_movim.tip_movimiento := 40; -- ANULACION DE VENTA,BORRAR LINEA EN DEFINITIVA
        END IF;
 --BORRAR LINEA EN DEFINITIVA
        if v_inter.error = 0 then
           p_valida_tipmovim (v_movim.tip_movimiento,
                              v_indes,
                              v_inter.error,
                              v_transac.des_cadena);
        end if;

        if v_inter.error = 0 then
           if v_inter.tipo = 1 and v_indes <> 'S' then
              v_transac.des_cadena := '/EL TIPO DE MOVIMIENTO DEFINIDO PARA ' ||
              'SALIDA DEFINITIVA NO ES CORRECTO/';
              v_inter.error := 1;
           end if;
           if v_inter.tipo = 2 and v_indes <> 'S' then
              v_transac.des_cadena := '/EL TIPO DE MOVIMIENTO DEFINIDO PARA ' ||
                                  'SALIDA DEFINITIVA DE ARRIENDO NO ES ' ||
                                  'CORRECTO/';
              v_inter.error := 1;
           end if;
           if v_inter.tipo = 3 and v_indes <> 'S' then
               v_inter.error := 1;
               v_transac.des_cadena := '/EL TIPO DE MOVIMIENTO DEFINIDO PARA '||
               'SALIDA POR SINIESTRO NO ES CORRECTO/';
           end if;
           if v_inter.tipo = 4 and v_indes <> 'T' then
              v_inter.error := 1;
              v_transac.des_cadena := '/EL TIPO DE MOVIMIENTO DEFINIDO PARA ' ||
              'RESERVA VENTA NO ES CORRECTO/';
           end if;
           if v_inter.tipo = 5 and v_indes <> 'T' then
              v_inter.error := 1;
              v_transac.des_cadena := '/EL TIPO DE MOVIMIENTO DE CANCELACION '||
              'DE RESERVA NO ES CORRECTO/';
           end if;
           if v_inter.tipo = 6 and v_indes <> 'T' then
              v_inter.error := 1;
              v_transac.des_cadena := '/EL TIPO DE MOVIMIENTO DEFINIDO PARA ' ||
              'SALIDA TEMPORAL NO ES CORRECTO/';
           end if;
        -- Devolucion salida temporal, cambia la bodega destino por la que se le pase como
        -- parametro . Tambien cambia el estado destino por el que se le haya
        -- pasado como parametro .El tipo de stock se mantiene.
           if v_inter.tipo = 7 and v_indes <> 'T' then
               v_inter.error := 1;
               v_transac.des_cadena := '/EL TIPO DE MOVIMIENTO DEFINIDO PARA  ' ||
               'DEVOLUCION SALIDA TEMPORAL NO ES CORRECTO/';
           end if;
           if v_inter.tipo = 8 and v_indes <> 'E' then
               v_inter.error := 1;
               v_transac.des_cadena := '/EL TIPO DE MOVIMIENTO DEFINIDO PARA  ' ||
              'DEVOLUCION CLIENTE NO ES CORRECTO/';
           end if;
           if v_inter.tipo = 9 and v_indes <> 'E' then
               v_inter.error := 1;
               v_transac.des_cadena := '/EL TIPO DE MOVIMIENTO DEFINIDO ENTRADA  ' ||
               'POR ANULACION VENTA NO ES CORRECTO/';
           end if;
        end if;

                                                         if v_inter.error = 0 and v_inter.tipo <> 9 then
           p_select_estados (v_reserva,
                             v_temporal,
                             v_inter.error,
                             v_transac.des_cadena);
        end if;
        if v_inter.error = 0 and
           v_inter.serie is not null and
           v_inter.tipo <> 8 and v_inter.tipo <> 9 then
                        --Obtiene tip_stock de la serie para la actuacion 6, porque
                        -- en ese caso v_inter.tip_stock tiene el tipo de stock destino
           p_select_datos_serie(v_inter.serie,
                                v_movim.cod_central,
                                v_movim.cod_subalm,
                                v_movim.num_telefono,
                                v_movim.cod_cat,
                                                                                                                                                                                                                                                                v_movim.tip_stock,
                                                                                                                                                                                                                                                                v_movim.cod_bodega,
                                                                                                                                                                                                                                                                v_movim.plan,
                                                                                                                                                                                                                                                                v_movim.carga,
                                              v_inter.error,
                                v_transac.des_cadena);
        end if;
        if v_inter.error = 0 then
           p_select_movimiento(v_movim.num_movimiento,
                               v_inter.error,
                               v_transac.des_cadena);
        end if;
        if v_inter.error = 0 and v_inter.tipo <> 9 then
                                                                                        if v_inter.tipo <> 6 then
                                                                                   v_movim.tip_stock         := v_inter.tipstock;
                                                                                        end if;
                                                                                        if v_inter.tipo <> 7 then
                                                                                   v_movim.cod_bodega         := v_inter.bodega;
                                                                                        end if;
                                                            v_movim.cod_articulo      := v_inter.articulo;
           v_movim.cod_uso           := v_inter.uso;
           if v_inter.tipo = 4 or v_inter.tipo = 8 then
              v_movim.cod_estado     := v_inter.estado;
           elsif v_inter.tipo = 2 or
                 v_inter.tipo = 3 or
                 v_inter.tipo = 7 then
                 v_movim.cod_estado := v_temporal;
           else
                 v_movim.cod_estado := v_reserva;
           end if;
           v_movim.num_cantidad     := v_inter.cantid;
           v_movim.cod_estadomov    := 'SO';
           v_movim.nom_usuarora     := USER;
                                                           if v_inter.tipo = 6 then
                                                                      v_movim.tip_stock_dest   := v_inter.tipstock;
                                                                   else
                                                        v_movim.tip_stock_dest   := null;
                                                                   end if;
                                                                   if v_inter.tipo = 7 then
                                                                      v_movim.cod_bodega_dest  := v_inter.bodega;
                                                                   else
                                                        v_movim.cod_bodega_dest  := null;
                                                                   end if;
                                                     v_movim.cod_uso_dest     := null;
           v_movim.cod_cat_dest     := null;
           if v_inter.tipo = 4 then
              v_movim.cod_estado_dest  := v_reserva;
           elsif v_inter.tipo = 5 then
                 v_movim.cod_estado_dest  := v_inter.estado;
           elsif v_inter.tipo = 6 then
                 v_movim.cod_estado_dest  := v_temporal;
           elsif v_inter.tipo = 7 then
                 v_movim.cod_estado_dest := v_inter.estado;
           else
                 v_movim.cod_estado_dest := null;
           end if;
           v_movim.num_serie        := v_inter.serie;
           v_movim.num_desde        := 0;
           v_movim.num_hasta        := null;
           v_movim.num_guia         := null;
           if v_inter.tipo = 8 then
              p_obtiene_valor_dev (v_inter.venta,
                                   v_movim.cod_moneda,
                                   v_movim.prc_unidad,
                                   v_inter.error,
              v_transac.des_cadena);
           else
              v_movim.prc_unidad       := null;
              v_movim.cod_moneda       := null;
           end if;
           if v_inter.tipo = 1 or v_inter.tipo = 2 or
               v_inter.tipo = 4 or v_inter.tipo = 5 then
              v_movim.cod_transaccion := 3;
           elsif v_inter.tipo = 6 or v_inter.tipo = 7 then
                 v_movim.cod_transaccion := 4;
           elsif v_inter.tipo = 8 then
                 v_movim.cod_transaccion := 8;
           else
              v_movim.cod_transaccion    := null;
           end if;
           v_movim.num_transaccion       := v_inter.venta;
           v_movim.num_seriemec          := null;
           if v_inter.tipo = 7 and
              v_inter.indtel = 1 then
              v_movim.ind_telefono       := 0;
              v_movim.num_telefono       := v_inter.celular;
              v_movim.cod_central        := v_inter.central;
              v_movim.cod_subalm         := v_inter.subalm;
              v_movim.cod_cat            := v_inter.cat;
           end if;
           v_movim.cap_code              := null;
           v_movim.cod_producto          := null;
           p_inserta_movim (v_movim,
                            v_inter.error,
                            v_transac.des_cadena);
        end if;
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        if v_inter.error = 0 and v_inter.tipo = 9 then
                p_select_producto(v_inter.articulo,v_movim.cod_producto,
                                  v_inter.error,v_transac.des_cadena);
                v_movim.fec_movimiento    := SYSDATE;
                v_movim.cod_bodega        := v_inter.bodega;
                v_movim.nom_usuarora      := USER;
                v_movim.cod_estadomov     := 'SO';
                v_movim.num_transaccion   := v_inter.venta;
                v_movim.num_serie         := v_inter.serie;
                v_movim.ind_telefono      := v_inter.indtel;
                v_movim.num_cantidad      := v_inter.cantid;
                v_movim.tip_stock         := v_inter.tipstock;
                v_movim.cod_articulo      := v_inter.articulo;
                v_movim.cod_uso           := v_inter.uso;
                v_movim.cod_estado        := v_inter.estado;
                v_movim.tip_stock_dest    := null;
                v_movim.cod_bodega_dest   := null;
                v_movim.cod_uso_dest      := null;
                v_movim.cod_estado_dest   := null;
                v_movim.num_desde         := 0;
                v_movim.num_hasta         := null;
                v_movim.num_guia          := null;
                v_movim.cod_transaccion   := 3;
                                                                                                                        v_movim.cap_code          := null;
 --Venta
                v_movim.cod_moneda        := null;
                v_movim.cod_central_dest  := null;
                v_movim.cod_subalm_dest   := null;
                v_movim.num_telefono_dest := null;
                v_movim.cod_cat_dest      := null;
                                                                                                                         if v_movim.cod_producto<>2 then
                                                                                                                                            if v_inter.serie is null  then
                                                                                                                        v_movim.num_seriemec      := null;
                                                                                                                        v_movim.num_telefono      := null;
                                                                                                                        v_movim.cod_central       := null;
                                                                                                                        v_movim.cod_subalm        := null;
                                                                                                                        v_movim.cod_cat           := null;
                                                                                                                   else
                                                                                                                                                                                                                                                                p_select_datos_serie_mov(v_inter.serie,
                                                                                                                                                                v_movim.cod_central,
                                                                                                                                                    v_movim.cod_subalm,
                                                                                                                                                        v_movim.num_telefono,
                                                                                                                                                v_movim.cod_cat,
                                                                                                                                                v_movim.num_seriemec,
                                                                                                                                                v_inter.error,
                                                                                                                                                v_transac.des_cadena,
                                                                                                                                                v_inter.venta,
                                                                                                                                                v_inter.indtel);
                                                                                                                        end if;
                                                                                                                         end if;
                                                                                                                         if v_movim.cod_producto=2 then
                                                                                                                                p_select_datos_beeper(v_inter.serie,v_movim.cap_code,v_movim.num_seriemec,
                                                                                                                                                                    v_inter.error,v_transac.des_cadena);
                                                                                                                         end if;
                                                                                                    p_select_precio(v_inter.articulo,v_movim.prc_unidad,
                                                                                                                    v_inter.error,v_transac.des_cadena,v_inter.serie);

                                                                                                    if v_inter.error = 0 then
                                                                                                       p_inserta_movim (v_movim,
                                                                                                                        v_inter.error,
                                                                                                                        v_transac.des_cadena);
                                                                                                    end if;


                                    end if;
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                                if v_inter.tipo = 8 then
           p_update_devclte (v_inter.venta,
                             v_movim.tip_movimiento,
                             v_inter.error,
                             v_transac.des_cadena);
        end if;




        v_transac.num_transaccion := v_inter.transac;
        v_transac.cod_retorno     := v_inter.error;
        if v_inter.tipo <> 9 then
            if v_transac.des_cadena is null then
                v_transac.des_cadena := '/' || to_char(v_movim.num_movimiento) || '/';
            end if;
        else
            if v_transac.des_cadena is null then
                if v_movim.num_telefono is null then
                   v_transac.des_cadena := '/' || to_char(v_movim.num_movimiento) || '/0/';
                else
                   v_transac.des_cadena := '/' || to_char(v_movim.num_movimiento) || '/1/';
                end if;
            end if;
        end if;
        p_insert_transacabo (v_transac);

END p_trata_interfaz;


  PROCEDURE p_obtiene_tipmovim(
  v_tipo IN number ,
  v_tipmo IN OUT al_movimientos.tip_movimiento%type ,
  v_usado IN OUT ga_datosgener.cod_estusado%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
  IS
      v_sentencia      varchar2(1024) := null;
      v_filas          integer;
      v_cursor         integer;
    BEGIN
      v_cursor := dbms_sql.open_cursor;
      v_sentencia := 'SELECT ';
      if v_tipo = 1 then
         v_sentencia := v_sentencia || 'TIP_MOV_SALDN';
      elsif v_tipo = 2 then
         v_sentencia := v_sentencia || 'TIP_MOV_SALDA';
      elsif v_tipo = 3 then
         v_sentencia := v_sentencia || 'TIP_MOV_SALDS';
      elsif v_tipo = 4 then
         v_sentencia := v_sentencia || 'TIP_MOV_RES';
      elsif v_tipo = 5 then
         v_sentencia := v_sentencia || 'TIP_MOV_DESRES';
      elsif v_tipo = 6 then
         v_sentencia := v_sentencia || 'TIP_MOV_SALT';
      elsif v_tipo = 7 then
         v_sentencia := v_sentencia || 'TIP_MOV_ENTT';
      elsif v_tipo = 8 then
         v_sentencia := v_sentencia || 'TIP_MOV_DEVCL';
      elsif v_tipo = 9 then
         v_sentencia := v_sentencia || 'TIP_MOV_ENT';
      else  v_error := 1;
      end if;
      if v_error = 0 then
         v_sentencia := v_sentencia || ',COD_ESTUSADO FROM GA_DATOSGENER';
         dbms_sql.parse (v_cursor,v_sentencia,dbms_sql.v7);
         dbms_sql.define_column(v_cursor,1,v_tipmo);
         dbms_sql.define_column(v_cursor,2,v_usado);
         v_filas := dbms_sql.execute(v_cursor);
         if dbms_sql.fetch_rows(v_cursor) > 0 then
     dbms_sql.column_value(v_cursor,1,v_tipmo);
     dbms_sql.column_value(v_cursor,2,v_usado);
         end if;
      end if;
      dbms_sql.close_cursor(v_cursor);
    EXCEPTION
      when OTHERS then
           if dbms_sql.is_open(v_cursor) then
       dbms_sql.close_cursor(v_cursor);
           end if;
           v_error := 1;
           v_mensa := '/Error obtencion Tipo de Movimiento/';
    END p_obtiene_tipmovim;
  PROCEDURE p_select_datos_serie_mov(
  v_serie IN al_series.num_serie%type ,
  v_central IN OUT al_series.cod_central%type ,
  v_subalm IN OUT al_series.cod_subalm%type ,
  v_telefono IN OUT al_series.num_telefono%type ,
  v_cat IN OUT al_series.cod_cat%type ,
  v_seriemec IN OUT al_series.num_seriemec%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type,
  v_venta IN al_movimientos.num_transaccion%type,
  v_indtel IN al_series.ind_telefono%type)
  IS
    BEGIN
          if v_indtel=0 then
                select NULL,NULL,NULL,NULL,a.num_seriemec
                  into v_central,v_subalm,v_telefono,v_cat,v_seriemec
                  from al_movimientos a, al_tipos_movimientos b
                  where a.num_serie = v_serie
                  and a.tip_movimiento = b.tip_movimiento
                  and b.ind_entsal = 'S'
                  and a.cod_estado in (select cod_estado_rvt from al_datos_generales)
                  and a.num_transaccion = v_venta;
          else
                select a.cod_central,a.cod_subalm,a.num_telefono,a.cod_cat,
                  a.num_seriemec
                  into v_central,v_subalm,v_telefono,v_cat,v_seriemec
                  from al_movimientos a, al_tipos_movimientos b
                  where a.num_serie = v_serie
                  and a.tip_movimiento = b.tip_movimiento
                  and b.ind_entsal = 'S'
                  and a.cod_estado in (select cod_estado_rvt from al_datos_generales)
                  and a.num_transaccion = v_venta;
          end if;
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error obtencion datos de la Serie en movimientos/';
    END p_select_datos_serie_mov;
  PROCEDURE p_select_precio(
  v_articulo IN al_series.cod_articulo%type ,
  v_precio IN OUT al_series.prc_compra%type,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type ,
  v_serie IN al_series.num_serie%type )
  IS
        v_contaux NUMBER;
    BEGIN
        select max(a.prec_pmp),count(*) into v_precio,v_contaux
                from al_pmp_articulo a
                where a.cod_articulo = v_articulo
                and a.fec_periodo IN
                   (select b.fec_periodo from al_pmp_articulo b
                    where rownum < 2 );
                if v_contaux = 0 then -- no valorado
                   select prc_unidad into v_precio
                                  from al_movimientos where num_serie=v_serie
                                  and prc_unidad is not null and rownum<2;
                end if;
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error obtencion precio para entrada de la serie/';
    END p_select_precio;
  PROCEDURE p_select_estados(
  v_reserva IN OUT al_datos_generales.cod_estado_rvt%type ,
  v_temporal IN OUT al_datos_generales.cod_estado_tem%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
  IS
    BEGIN
        select cod_estado_rvt,cod_estado_tem
          into v_reserva,v_temporal
          from al_datos_generales;
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error obtencion Estados/';
    END p_select_estados;
  PROCEDURE p_select_producto(
  v_articulo IN al_series.cod_articulo%type ,
  v_producto IN OUT al_series.cod_producto%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
  IS
    BEGIN
        select cod_producto into v_producto
                from al_articulos
                where cod_articulo = v_articulo;
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error obtencion codigo de producto del articulo/';
    END p_select_producto;
  PROCEDURE p_select_datos_serie(
  v_serie IN al_series.num_serie%type ,
  v_central IN OUT al_series.cod_central%type ,
  v_subalm IN OUT al_series.cod_subalm%type ,
  v_telefono IN OUT al_series.num_telefono%type ,
  v_cat IN OUT al_series.cod_cat%type ,
  v_tip_stock IN OUT al_series.tip_stock%type ,
  v_cod_bodega IN OUT al_series.cod_bodega%type ,
  v_plan IN OUT al_series.plan%type ,
  v_carga IN OUT al_series.carga%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
  IS
    BEGIN
        select cod_central,cod_subalm,num_telefono,cod_cat,tip_stock,cod_bodega, plan, carga
          into v_central,v_subalm,v_telefono,v_cat,v_tip_stock,v_cod_bodega,v_plan, v_carga
          from al_series
         where num_serie = v_serie;
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error obtencion datos de la Serie/';
    END p_select_datos_serie;
  PROCEDURE p_inserta_movim(
  v_movim IN al_movimientos%rowtype ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
  IS
    BEGIN
       if v_movim.ind_telefono is not null then
                insert into al_movimientos (num_movimiento,tip_movimiento,
                                           fec_movimiento,tip_stock,
                                           cod_bodega,cod_articulo,
                                           cod_uso,cod_estado,
                                           num_cantidad,cod_estadomov,
                                           nom_usuarora,tip_stock_dest,
                                           cod_bodega_dest,cod_uso_dest,
                                           cod_estado_dest,num_serie,
                                           num_desde,num_hasta,
                                           num_guia,prc_unidad,
                                           cod_transaccion,num_transaccion,
                                           num_seriemec,num_telefono,
                                           cap_code,cod_producto,
                                           cod_central,cod_moneda,
                                           cod_subalm,cod_central_dest,
                                           cod_subalm_dest,num_telefono_dest,
                                           cod_cat,cod_cat_dest,
                                           ind_telefono, plan, carga)
                           values (v_movim.num_movimiento,v_movim.tip_movimiento,
                                   sysdate,v_movim.tip_stock,
                                   v_movim.cod_bodega,v_movim.cod_articulo,
                                   v_movim.cod_uso,v_movim.cod_estado,
                                   v_movim.num_cantidad,v_movim.cod_estadomov,
                                   v_movim.nom_usuarora,v_movim.tip_stock_dest,
                                   v_movim.cod_bodega_dest,v_movim.cod_uso_dest,
                                   v_movim.cod_estado_dest,v_movim.num_serie,
                                   v_movim.num_desde,v_movim.num_hasta,
                                   v_movim.num_guia,v_movim.prc_unidad,
                                   v_movim.cod_transaccion,v_movim.num_transaccion,
                                   v_movim.num_seriemec,v_movim.num_telefono,
                                   v_movim.cap_code,v_movim.cod_producto,
                                   v_movim.cod_central,v_movim.cod_moneda,
                                   v_movim.cod_subalm,v_movim.cod_central_dest,
                                   v_movim.cod_subalm_dest,v_movim.num_telefono_dest,
                                   v_movim.cod_cat,v_movim.cod_cat_dest,
                                   v_movim.ind_telefono,v_movim.plan, v_movim.carga);
        else
        insert into al_movimientos (num_movimiento,tip_movimiento,
                                           fec_movimiento,tip_stock,
                                           cod_bodega,cod_articulo,
                                           cod_uso,cod_estado,
                                           num_cantidad,cod_estadomov,
                                           nom_usuarora,tip_stock_dest,
                                           cod_bodega_dest,cod_uso_dest,
                                           cod_estado_dest,num_serie,
                                           num_desde,num_hasta,
                                           num_guia,prc_unidad,
                                           cod_transaccion,num_transaccion,
                                           num_seriemec,num_telefono,
                                           cap_code,cod_producto,
                                           cod_central,cod_moneda,
                                           cod_subalm,cod_central_dest,
                                           cod_subalm_dest,num_telefono_dest,
                                           cod_cat,cod_cat_dest,
                                                                                   plan, carga)
                           values (v_movim.num_movimiento,v_movim.tip_movimiento,
                                   sysdate,v_movim.tip_stock,
                                   v_movim.cod_bodega,v_movim.cod_articulo,
                                   v_movim.cod_uso,v_movim.cod_estado,
                                   v_movim.num_cantidad,v_movim.cod_estadomov,
                                   v_movim.nom_usuarora,v_movim.tip_stock_dest,
                                   v_movim.cod_bodega_dest,v_movim.cod_uso_dest,
                                   v_movim.cod_estado_dest,v_movim.num_serie,
                                   v_movim.num_desde,v_movim.num_hasta,
                                   v_movim.num_guia,v_movim.prc_unidad,
                                   v_movim.cod_transaccion,v_movim.num_transaccion,
                                   v_movim.num_seriemec,v_movim.num_telefono,
                                   v_movim.cap_code,v_movim.cod_producto,
                                   v_movim.cod_central,v_movim.cod_moneda,
                                   v_movim.cod_subalm,v_movim.cod_central_dest,
                                   v_movim.cod_subalm_dest,v_movim.num_telefono_dest,
                                   v_movim.cod_cat,v_movim.cod_cat_dest,
                                                                   v_movim.plan, v_movim.carga);
        end if;
    EXCEPTION
        when OTHERS then
         if (to_char(SQLCODE) = '-20155') then
      v_error := 1;
           v_mensa :=
  '/Registro de Stock temporalmente bloqueado por otro usuario/'||
          'CODE='||to_char(SQLCODE)||'/'||
          'serie='||v_movim.num_serie||'/'||
          'nro.='||to_char(v_movim.num_movimiento)||'/'||
          'tipmo='||to_char(v_movim.tip_movimiento)||'/'||
          'bodega='||to_char(v_movim.cod_bodega)||'/'||
          'tipsto='||to_char(v_movim.tip_stock)||'/'||
          'artic='||to_char(v_movim.cod_articulo)||'/'||
          'uso='||to_char(v_movim.cod_uso)||'/'||
          'estado='||to_char(v_movim.cod_estado)||'/'||
          'est.dest='||to_char(v_movim.cod_estado_dest)||'/'||
                  'tipsto.dest='||to_char(v_movim.tip_stock_dest)||'/'||
          'num_tel='||to_char(v_movim.num_telefono)||'/'||
          'cantidad='||to_char(v_movim.num_cantidad)||'/';
         else
   v_error := 1;
          v_mensa := '/Error generacion Movimiento de Stock/'||
          'CODE='||to_char(SQLCODE)||'/'||
          'serie='||v_movim.num_serie||'/'||
          'nro.='||to_char(v_movim.num_movimiento)||'/'||
          'tipmo='||to_char(v_movim.tip_movimiento)||'/'||
          'bodega='||to_char(v_movim.cod_bodega)||'/'||
          'tipsto='||to_char(v_movim.tip_stock)||'/'||
          'artic='||to_char(v_movim.cod_articulo)||'/'||
          'uso='||to_char(v_movim.cod_uso)||'/'||
          'estado='||to_char(v_movim.cod_estado)||'/'||
          'est.dest='||to_char(v_movim.cod_estado_dest)||'/'||
                  'tipsto.dest='||to_char(v_movim.tip_stock_dest)||'/'||
          'num_tel='||to_char(v_movim.num_telefono)||'/'||
          'cantidad='||to_char(v_movim.num_cantidad)||'/';
         end if;
    END p_inserta_movim;
  PROCEDURE p_insert_transacabo(
  v_transac IN ga_transacabo%rowtype )
  IS
    BEGIN
        insert into ga_transacabo (num_transaccion,
                                   cod_retorno,
                                   des_cadena)
                           values (v_transac.num_transaccion,
                                   v_transac.cod_retorno,
                                   v_transac.des_cadena);
    EXCEPTION
       when OTHERS then
            raise_application_error (-20075,'Error Generacion Transacabo '
                                     || SQLERRM);
    END p_insert_transacabo;
  PROCEDURE p_valida_tipmovim(
  v_tipmo IN al_tipos_movimientos.tip_movimiento%type ,
  v_indes IN OUT al_tipos_movimientos.ind_entsal%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
  IS
    BEGIN
       select ind_entsal into v_indes
              from al_tipos_movimientos
             where tip_movimiento = v_tipmo;
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error validacion tipo de movimiento/';
    END p_valida_tipmovim;
  PROCEDURE p_select_movimiento(
  v_movim IN OUT al_movimientos.num_movimiento%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
  IS
    BEGIN
       select al_seq_mvto.nextval into v_movim
              from dual;
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error obtencion Numero de Movimiento de Stock/';
    END p_select_movimiento;
  PROCEDURE p_obtiene_valor_dev(
  v_devol IN ga_devcliente.num_devolucion%type ,
  v_moneda IN OUT ga_devcliente.cod_moneda_sto%type ,
  v_valor IN OUT ga_devcliente.val_stock%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
  IS
    BEGIN
       select cod_moneda_sto,val_stock
         into v_moneda,v_valor
         from ga_devcliente
        where num_devolucion = v_devol;
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error obtencion Valor Devolucion Cliente/';
    END p_obtiene_valor_dev;
  PROCEDURE p_update_devclte(
  v_devol IN ga_devcliente.num_devolucion%type ,
  v_tipmo IN al_tipos_movimientos.tip_movimiento%type ,
  v_error IN OUT ga_transacabo.cod_retorno%type ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
  IS
    BEGIN
       update ga_devcliente
              set tip_movimiento   = v_tipmo
              where num_devolucion = v_devol;
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error Actualizacion Devolucion Cliente/';
    END p_update_devclte;
  PROCEDURE p_select_datos_beeper(
  v_serie IN al_series.num_serie%type ,
  v_capcode IN OUT al_series.cap_code%type,
  v_seriemec IN OUT al_series.num_seriemec%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type
)
  IS
    BEGIN
        select cap_code,num_seriemec into v_capcode,v_seriemec from GA_ABOBEEP
                  where num_serie = v_serie
                           and cod_situacion IN ('ATA', 'AOA', 'AAA', 'AOP', 'ATP');
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error obtencion capcode de GA_ABOBEEP/';
    END p_select_datos_beeper;
END GA_PAC_INTERAL;
/
SHOW ERRORS
