CREATE OR REPLACE PROCEDURE p_al_trata_revpetdev(
  v_orden_v IN varchar2 ,
  v_estorden IN al_cabecera_ordenes.cod_estado%TYPE ,
  v_bodega_v IN varchar2)
  IS
       v_canseries number(8);
       v_linord al_vlineas_ordenes%ROWTYPE;
       v_seriado al_articulos.ind_seriado%TYPE;
       v_reserva al_datos_generales.cod_estado_res%TYPE;
       v_movim   al_movimientos%ROWTYPE;
       v_peticion al_petiguias_alma%ROWTYPE;
       v_cabord3  al_cabecera_ordenes3%ROWTYPE;
       v_fec_historico date;
       v_orden     al_cabecera_ordenes.num_orden%TYPE;
       v_bodega    al_cabecera_ordenes.cod_bodega%TYPE;
       CURSOR c_linord IS
              SELECT * FROM al_vlineas_ordenes
                     WHERE num_orden = v_orden
                       AND tip_orden = 3;
       CURSOR c_serord IS
              SELECT * FROM al_vseries_ordenes
                     WHERE num_orden = v_orden
                       AND tip_orden = 3
                       AND num_linea = v_linord.num_linea;
    BEGIN
      v_orden:=    to_number(v_orden_v);
      v_bodega:=   to_number(v_bodega_v);
      al_proc_devolucion.p_obtiene_estados (v_reserva);
      v_movim.fec_movimiento      := SYSDATE;
      v_movim.cod_bodega          := v_bodega;
      v_movim.nom_usuarora        := USER;
      v_movim.cod_estadomov       := 'SO';
      v_movim.cod_estado          := v_reserva;
      v_movim.tip_stock_dest      := NULL;
      v_movim.cod_bodega_dest     := NULL;
      v_movim.cod_uso_dest        := NULL;
      v_movim.prc_unidad          := NULL;
      v_movim.num_guia            := NULL;
      v_movim.cod_transaccion     := 6;
      v_movim.num_transaccion     := v_orden;
      FOR v_linord IN c_linord LOOP
          v_movim.tip_movimiento    := v_linord.tip_movimiento;
          v_movim.tip_stock         := v_linord.tip_stock;
          v_movim.cod_articulo      := v_linord.cod_articulo;
          v_movim.cod_uso           := v_linord.cod_uso;
          v_movim.cod_estado_dest     := v_linord.cod_estado;
          v_movim.cod_central_dest  := NULL;
          v_movim.cod_subalm_dest   := NULL;
          v_movim.num_telefono_dest := NULL;
          v_movim.cod_cat_dest      := NULL;
          al_proc_devolucion.p_obtiene_seriado (v_linord.cod_articulo,v_seriado);
          IF v_seriado = 1 THEN
               v_movim.num_cantidad := 1;
               FOR v_serord IN c_serord LOOP
                   v_movim.num_cantidad      := 1;
                   v_movim.num_serie         := v_serord.num_serie;
                   v_movim.num_desde         := 0;
                   v_movim.num_hasta         := NULL;
                   v_movim.num_seriemec      := v_serord.num_seriemec;
                   v_movim.num_telefono      := v_serord.num_telefono;
                   v_movim.cap_code          := v_serord.cap_code;
                   v_movim.cod_producto      := v_serord.cod_producto;
                   v_movim.cod_central       := v_serord.cod_central;
                   v_movim.cod_moneda        := NULL;
                   v_movim.cod_subalm        := v_serord.cod_subalm;
                   v_movim.cod_cat           := v_serord.cod_cat;
                   v_movim.num_sec_loca      := v_serord.num_sec_loca;
                   SELECT al_seq_mvto.NEXTVAL
                   INTO v_movim.num_movimiento
                   FROM dual;
                   --------------------------------------------------
                   Al_Pac_Validaciones.p_inserta_movim (v_movim);
               END LOOP;
          ELSE
             v_movim.num_cantidad := v_linord.can_orden;
             v_movim.num_serie    := NULL;
             IF v_linord.num_desde IS NULL THEN
                v_movim.num_desde := 0;
             ELSE
                v_movim.num_desde    := v_linord.num_desde;
             END IF;
             v_movim.num_hasta       := v_linord.num_hasta;
             v_movim.num_seriemec    := NULL;
             v_movim.num_telefono    := NULL;
             v_movim.cap_code        := NULL;
             v_movim.cod_producto    := NULL;
             v_movim.cod_central     := NULL;
             v_movim.cod_moneda      := NULL;
             v_movim.cod_subalm      := NULL;
             v_movim.cod_cat         := NULL;
             v_movim.num_sec_loca    := v_linord.num_sec_loca;
             SELECT al_seq_mvto.NEXTVAL
             INTO v_movim.num_movimiento
             FROM dual;
             Al_Pac_Validaciones.p_inserta_movim (v_movim);
          END IF;
      END LOOP;
          --Paso a historico orden devolucion
          v_fec_historico:= sysdate;
          select * into v_cabord3
          from   al_cabecera_ordenes3
          where  num_orden = v_orden;
          v_cabord3.cod_estado:='RE';
          al_pasohis_ord.p_pasohis_ord(v_cabord3,v_fec_historico);
          --
          select count(num_serie) into v_canseries
          from   al_series_ordenes3
          where  num_orden = v_orden;
          if v_canseries > 0 then
             delete al_series_ordenes3
                    where  num_orden = v_orden;
          end if;
          delete al_lineas_ordenes3
                 where  num_orden = v_orden;
          delete al_cabecera_ordenes3
                 where  num_orden = v_orden;
EXCEPTION
  when OTHERS then
    RAISE_APPLICATION_ERROR (-20100,'ERRROR : '|| TO_CHAR(SQLCODE) ||' ' || SQLERRM);


END;
/
SHOW ERRORS
