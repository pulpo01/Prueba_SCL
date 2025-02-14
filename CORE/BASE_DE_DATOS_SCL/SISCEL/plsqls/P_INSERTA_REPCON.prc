CREATE OR REPLACE PROCEDURE        p_inserta_repcon(
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
/
SHOW ERRORS
