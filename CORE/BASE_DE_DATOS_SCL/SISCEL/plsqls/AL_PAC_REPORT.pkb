CREATE OR REPLACE PACKAGE BODY          "AL_PAC_REPORT"  IS
--
--
--
--
--
--
--
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  PROCEDURE p_genera_report(
  v_interrep IN OUT al_interrep%rowtype ,
  v_bodega IN al_bodegas.cod_bodega%type ,
  v_mes IN date ,
  v_moneda IN ge_monedas.cod_moneda%type )
  IS
       CURSOR c_movimientos is
              select a.tip_movimiento,a.fec_movimiento,a.cod_bodega,
                     a.cod_articulo,a.tip_stock,a.num_cantidad,a.num_serie,
                     a.cod_transaccion,a.num_transaccion,b.ind_valorar
			   ,c.ind_entsal
                     from al_movimientos a, al_tipos_stock b,
                          al_tipos_movimientos c
                     where a.fec_movimiento between v_mes and last_day(v_mes)
                       and b.ind_valorar     = 0
                       and c.ind_entsal      = 'S'
                       and a.cod_transaccion = 3
                       and a.tip_stock       = b.tip_stock
                       and a.tip_movimiento  = c.tip_movimiento
              union
              select a.tip_movimiento,a.fec_movimiento,a.cod_bodega,
                     a.cod_articulo,a.tip_stock,a.num_cantidad,a.num_serie,
                     a.cod_transaccion,a.num_transaccion,b.ind_valorar
			   ,c.ind_entsal
                     from al_hmovimientos a, al_tipos_stock b,
                          al_tipos_movimientos c
                     where a.fec_movimiento between v_mes and last_day(v_mes)
                       and b.ind_valorar     = 0
                       and c.ind_entsal      = 'S'
                       and a.cod_transaccion = 3
                       and a.tip_stock       = b.tip_stock
                       and a.tip_movimiento  = c.tip_movimiento;
        v_repcon        al_rep_consignacion%rowtype;
        v_moneda_in     ge_monedas.cod_moneda%type;
        exception_error exception;
    BEGIN
	  dbms_output.put_line('Entra genera report');
        v_repcon.num_informe := v_interrep.num_informe;
        v_repcon.num_linea   := 0;
        for v_movimientos in c_movimientos LOOP
	  dbms_output.put_line('Movimiento');
            v_repcon.num_factura   := null;
            v_repcon.cod_proveedor := null;
            v_repcon.num_lista     := null;
            v_repcon.prc_articulo  := null;
            if v_movimientos.cod_transaccion = 3 then
               if v_movimientos.num_serie is not null then
	  		dbms_output.put_line('factura seriado');
                  p_obtiene_factura_seriado (v_movimientos.num_transaccion,
                                             v_movimientos.cod_articulo,
                                             v_movimientos.num_serie,
                                             v_repcon.num_factura);
               else
	  		dbms_output.put_line('factura no seriado');
                  p_obtiene_factura (v_movimientos.num_transaccion,
                                     v_movimientos.cod_articulo,
                                     v_movimientos.num_cantidad,
                                     v_repcon.num_factura);
               end if;
            else
               v_repcon.num_factura := null;
            end if;
	  	dbms_output.put_line('obtiene lista');
            p_obtiene_lista (v_movimientos.cod_articulo,
                             v_movimientos.fec_movimiento,
                             v_repcon.cod_proveedor,
                             v_repcon.num_lista,
                             v_moneda_in,
                             v_repcon.prc_articulo,
                             v_interrep.cod_retorno,
                             v_interrep.des_cadena);
	  	dbms_output.put_line('fin obtiene lista');
            v_repcon.cod_moneda      := v_moneda;
            if v_moneda_in <> v_moneda then
	  	dbms_output.put_line('convierte precio');
               al_pac_validaciones.p_convertir_precio (v_moneda_in,
                                                       v_repcon.cod_moneda,
                                                       v_repcon.prc_articulo,
                                                       v_repcon.prc_articulo,
                                                       sysdate);
	  	dbms_output.put_line('fin convierte precio');
            end if;
            v_repcon.num_linea      := v_repcon.num_linea + 1;
            v_repcon.cod_bodega     := v_movimientos.cod_bodega;
            v_repcon.cod_articulo   := v_movimientos.cod_articulo;
            v_repcon.num_cantidad   := v_movimientos.num_cantidad;
            v_repcon.tip_movimiento := v_movimientos.tip_movimiento;
            p_inserta_repcon (v_repcon,
                              v_interrep.cod_retorno,
                              v_interrep.des_cadena);
	  	dbms_output.put_line('fin inserta repcon');
            if v_interrep.cod_retorno <> 0 then
              raise EXCEPTION_ERROR;
            end if;
        end LOOP;
    EXCEPTION
        when EXCEPTION_ERROR then
             if c_movimientos%ISOPEN then
                close c_movimientos;
             end if;
        when OTHERS then
             if c_movimientos%ISOPEN then
                close c_movimientos;
             end if;
	  	dbms_output.put_line('Error :' || SQLERRM);
             v_interrep.cod_retorno := 1;
             v_interrep.des_cadena := '/Error Lectura de Movimientos/';
    END p_genera_report;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_factura_seriado(
  v_transaccion IN al_movimientos.num_transaccion%type ,
  v_articulo IN al_movimientos.cod_articulo%type ,
  v_serie IN al_movimientos.num_serie%type ,
  v_factura IN OUT al_rep_consignacion.num_factura%type )
  IS
        v_detalle   al_cab_guias.ind_detalle%type;
    BEGIN
        select ind_detalle into v_detalle
               from al_cab_guias
              where num_venta = v_transaccion
                and rownum = 1;
        if v_detalle = 0 then
           select b.num_factura into v_factura
                  from al_lin_guias a, al_cab_guias b
                 where a.num_serie = v_serie
                   and a.num_guia  = b.num_guia
                   and b.num_venta = v_transaccion;
        else
           select b.num_factura into v_factura
                  from al_ser_guias a, al_cab_guias b
                 where a.num_serie = v_serie
                   and a.num_guia  = b.num_guia
                   and b.num_venta = v_transaccion;
        end if;
    EXCEPTION
        when OTHERS then
             null;
    END p_obtiene_factura_seriado;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_factura(
  v_transaccion IN al_movimientos.num_transaccion%type ,
  v_articulo IN al_movimientos.cod_articulo%type ,
  v_cantidad IN al_movimientos.num_cantidad%type ,
  v_factura IN OUT al_rep_consignacion.num_factura%type )
  IS
    BEGIN
       select a.num_factura into v_factura
              from al_cab_guias a, al_lin_guias b
             where a.num_venta    = v_transaccion
               and a.num_guia     = b.num_guia
               and b.cod_articulo = v_articulo
               and b.can_articulo = v_cantidad
               and rownum = 1;
    EXCEPTION
       when OTHERS then
            null;
    END p_obtiene_factura;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_lista(
  v_articulo IN al_movimientos.cod_articulo%type ,
  v_fecha IN al_movimientos.fec_movimiento%type ,
  v_proveedor IN OUT al_rep_consignacion.cod_proveedor%type ,
  v_numlista IN OUT al_rep_consignacion.num_lista%type ,
  v_moneda IN OUT al_rep_consignacion.cod_moneda%type ,
  v_precio IN OUT al_rep_consignacion.prc_articulo%type ,
  v_error IN OUT al_interrep.cod_retorno%type ,
  v_mensa IN OUT al_interrep.des_cadena%type )
  IS
       CURSOR c_lista is
          select a.num_lista, a.cod_moneda, b.prc_articulo
                 from al_cab_consignacion a,
       al_lin_consignacion b,
       al_articulos c
                where a.fec_validez  >= v_fecha
                  and a.num_lista     = b.num_lista
                  and b.cod_articulo  = v_articulo
        and c.cod_articulo  = b.cod_articulo
        and c.cod_proveedor = a.cod_proveedor
      order by a.num_lista desc;
    BEGIN
    p_obtiene_proveedor (v_articulo,
                         v_proveedor,
                         v_error);
    if v_error <> 1 then
      open c_lista;
        fetch c_lista into v_numlista, v_moneda, v_precio;
   if c_lista%NOTFOUND then
    v_numlista  := null;
    v_moneda    := null;
    v_precio    := null;
   end if;
      close c_lista;
    end if;
    EXCEPTION
        when OTHERS then
         dbms_output.put_line('Error obtiene_lista:' || SQLERRM);
    null;
    END p_obtiene_lista;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_proveedor(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_proveedor IN OUT al_articulos.cod_proveedor%type ,
  v_error IN OUT number )
  IS
    BEGIN
        select cod_proveedor into v_proveedor
               from al_articulos
              where cod_articulo = v_articulo;
    EXCEPTION
        when OTHERS then
             v_error := 1;
    END p_obtiene_proveedor;
  --
  -- Retrofitted
  PROCEDURE p_inserta_repcon(
  v_repcon IN al_rep_consignacion%rowtype ,
  v_error IN OUT al_interrep.cod_retorno%type ,
  v_mensa IN OUT al_interrep.des_cadena%type )
  IS
    BEGIN
        insert into al_rep_consignacion (num_informe,
                                         num_linea,
                                         cod_bodega,
                                         cod_articulo,
                                         num_cantidad,
                                         tip_movimiento,
                                         num_lista,
                                         prc_articulo,
                                         cod_proveedor,
                                         cod_moneda,
                                         num_factura)
                                 values (v_repcon.num_informe,
                                         v_repcon.num_linea,
                                         v_repcon.cod_bodega,
                                         v_repcon.cod_articulo,
                                         v_repcon.num_cantidad,
                                         v_repcon.tip_movimiento,
                                         v_repcon.num_lista,
                                         v_repcon.prc_articulo,
                                         v_repcon.cod_proveedor,
                                         v_repcon.cod_moneda,
                                         v_repcon.num_factura);
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error Generacion Informe/';
    END p_inserta_repcon;
END AL_PAC_REPORT;
/
SHOW ERRORS
