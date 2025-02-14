CREATE OR REPLACE PROCEDURE p_genera_cabecera(
  v_cabguia IN al_cab_guias%ROWTYPE ,
  v_error IN OUT al_interguias.cod_retorno%TYPE ,
  v_mensa IN OUT al_interguias.des_cadena%TYPE )
IS
BEGIN
   INSERT INTO al_cab_guias (num_guia,
                             num_peticion,
                             fec_guia,
                             des_bodega_ori,
                             nom_destinatario,
                             cod_estado,
                             ind_detalle,
                             num_ident,
                             des_direccion,
                             des_ciudad,
                             num_telefono,
                             num_fax,
                             des_actividad,
                             des_bodega_des,
                             cod_cliente,
                             num_folio,
                             des_literal,
                             num_venta,
                             num_devolucion,
                             num_traspaso)
                     VALUES (v_cabguia.num_guia,
                             v_cabguia.num_peticion,
                             v_cabguia.fec_guia,
                             v_cabguia.des_bodega_ori,
                             v_cabguia.nom_destinatario,
                             v_cabguia.cod_estado,
                             v_cabguia.ind_detalle,
                             v_cabguia.num_ident,
                             v_cabguia.des_direccion,
                             v_cabguia.des_ciudad,
                             v_cabguia.num_telefono,
                             v_cabguia.num_fax,
                             v_cabguia.des_actividad,
                             v_cabguia.des_bodega_des,
                             v_cabguia.cod_cliente,
                             v_cabguia.num_folio,
                             v_cabguia.des_literal,
                             v_cabguia.num_venta,
                             v_cabguia.num_devolucion,
                             v_cabguia.num_traspaso);
EXCEPTION
   WHEN OTHERS THEN
        v_error := 1;
        v_mensa := '/Error al Generar Cabecera Guia/';
END P_Genera_Cabecera;
/
SHOW ERRORS
