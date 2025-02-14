CREATE OR REPLACE PACKAGE BODY AL_TRATA_TIMBRADO IS
--
  PROCEDURE p_proceso_timbre(
  v_timbra IN al_cab_timbrado%rowtype )
  IS
    CURSOR c_lintim is
           select * from al_lin_timbrado
                  where num_orden = v_timbra.num_orden;
    v_movim       al_movimientos%rowtype;
    v_tempor      al_datos_generales.cod_estado_tem%type;
    v_timbre      al_datos_generales.cod_estado_tim%type;
  BEGIN
  --
    p_select_estados (v_tempor,
                      v_timbre);
    v_movim.fec_movimiento    := sysdate;
    v_movim.cod_bodega        := v_timbra.cod_bodega;
    v_movim.cod_estadomov     := 'SO';
    v_movim.nom_usuarora      := USER;
    v_movim.tip_stock_dest    := null;
    v_movim.cod_bodega_dest   := null;
    v_movim.cod_uso_dest      := null;
    v_movim.num_serie         := null;
    v_movim.num_guia          := null;
    v_movim.prc_unidad        := null;
    v_movim.cod_transaccion   := null;
    v_movim.num_transaccion   := null;
    v_movim.num_seriemec      := null;
    v_movim.num_telefono      := null;
    v_movim.cap_code          := null;
    v_movim.cod_producto      := null;
    v_movim.cod_central       := null;
    v_movim.cod_moneda        := null;
    v_movim.cod_subalm        := null;
    v_movim.cod_central_dest  := null;
    v_movim.cod_subalm_dest   := null;
    v_movim.num_telefono_dest := null;
    v_movim.cod_cat           := null;
    v_movim.cod_cat_dest      := null;
    if v_timbra.cod_estado = 'PR' then
       v_movim.tip_movimiento  := v_timbra.tip_movim_envio;
       v_movim.cod_estado_dest := v_tempor;
    else
       v_movim.tip_movimiento  := v_timbra.tip_movim_recep;
       v_movim.cod_estado_dest := v_timbre;
    end if;
  --
    FOR v_lintim in c_lintim LOOP
        p_select_movim(v_movim.num_movimiento);
        v_movim.tip_stock     := v_lintim.tip_stock;
        v_movim.cod_articulo  := v_lintim.cod_articulo;
        v_movim.cod_uso       := v_lintim.cod_uso;
        if v_timbra.cod_estado = 'PR' then
           v_movim.cod_estado    := v_lintim.cod_estado;
        else
           v_movim.cod_estado    := v_tempor;
        end if;
        v_movim.num_cantidad  := v_lintim.num_hasta - v_lintim.num_desde +1;
        v_movim.num_desde     := v_lintim.num_desde;
        v_movim.num_hasta     := v_lintim.num_hasta;
                v_movim.cod_plaza     := v_lintim.cod_plaza; --JLA (TMM) 13122002
        al_pac_validaciones.p_inserta_movim (v_movim);
    end LOOP;
  --
  END p_proceso_timbre;
  --
  PROCEDURE p_select_movim(
  v_movto IN OUT al_movimientos.num_movimiento%type )
  IS
  BEGIN
     select al_seq_mvto.nextval into v_movto
            from dual;
  EXCEPTION
      when OTHERS then
           raise_application_error (-20177,'Error Lectura Secuencia '
                                    || to_char(SQLCODE));
  END p_select_movim;
  --
  PROCEDURE p_select_estados(
  v_tempor IN OUT al_datos_generales.cod_estado_tem%type ,
  v_timbre IN OUT al_datos_generales.cod_estado_tim%type )
  IS
  BEGIN
     select cod_estado_tem,cod_estado_tim
       into v_tempor,v_timbre
       from al_datos_generales;
  EXCEPTION
     when OTHERS then
          raise_application_error (-20177,'Error Select Estados '
                                   || to_char(SQLCODE));
  END p_select_estados;
END AL_TRATA_TIMBRADO;
/
SHOW ERRORS
