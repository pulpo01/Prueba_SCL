CREATE OR REPLACE PROCEDURE p_ga_ins_glosafact ( v_cod_pedido   IN   npt_pedido.cod_pedido%TYPE )
IS
   v_cod_idioma     VARCHAR2 (8);
   v_num_venta      al_ventas.num_venta%TYPE;
   v_num_proceso    fa_interfact.num_proceso%TYPE;
   v_corr_mensaje   fa_mensajes.corr_mensaje%TYPE;
   v_mensaje_01     VARCHAR2 (100);
   v_mensaje_02     VARCHAR2 (100);
   v_mensaje_03     VARCHAR2 (100);
   v_mensaje_04     VARCHAR2 (100);
   v_mensaje_05     VARCHAR2 (100);
   v_mensaje_06     VARCHAR2 (100);
   v_glosa_01       ge_multiidioma.des_concepto%TYPE;
   v_glosa_02       ge_multiidioma.des_concepto%TYPE;
   v_glosa_03       ge_multiidioma.des_concepto%TYPE;
   v_glosa_04       GE_MULTIIDIOMA.des_concepto%TYPE;
   v_errores        al_errores_web%ROWTYPE;
   v_cod_formulario FA_PARMENSAJE.COD_FORMULARIO%TYPE;
   v_cod_bloque		FA_PARMENSAJE.COD_BLOQUE%TYPE;
   v_cant_lineasmen FA_PARMENSAJE.CANT_LINEASMEN%TYPE;
   v_cant_caractlin	FA_PARMENSAJE.CANT_CARACTLIN%TYPE;
   v_parametro		NPT_PARAMETRO.VALOR_PARAMETRO%TYPE;
   v_paso           VARCHAR2(1024);

BEGIN

   v_parametro:='False';

   v_paso :='(p_ga_ins_glosafact) Obteniendo csdigo de idioma de Cliente. Pedido: '|| v_cod_pedido;
   SELECT ge_fn_idioma_cliente (cod_cliente)
     INTO v_cod_idioma
     FROM npt_pedido
     WHERE cod_pedido = v_cod_pedido;

   v_paso :='(p_ga_ins_glosafact) Asignando glosa1 segzn idioma: '|| v_cod_idioma;
   SELECT des_concepto
     INTO v_glosa_01
     FROM ge_multiidioma a, gad_mens_reportes b
     WHERE a.nom_tabla = 'GAD_MENS_REPORTES'
     AND a.nom_campo = 'COD_TITULO'
     AND a.cod_producto = 1
     AND a.cod_idioma = v_cod_idioma
     AND a.cod_concepto = b.cod_titulo
     AND cod_concepto = 18
     AND ROWNUM = 1;

   v_paso :='(p_ga_ins_glosafact) Asignando glosa2 segzn idioma: '|| v_cod_idioma;
   SELECT des_concepto
     INTO v_glosa_02
     FROM ge_multiidioma a, gad_mens_reportes b
     WHERE a.nom_tabla = 'GAD_MENS_REPORTES'
      AND a.nom_campo = 'COD_TITULO'
      AND a.cod_producto = 1
      AND a.cod_idioma = v_cod_idioma
      AND a.cod_concepto = b.cod_titulo
      AND cod_concepto = 19
      AND ROWNUM = 1;

   v_paso :='(p_ga_ins_glosafact) Asignando glosa3 segzn idioma: '|| v_cod_idioma;
   SELECT des_concepto
     INTO v_glosa_03
     FROM ge_multiidioma a, gad_mens_reportes b
    WHERE a.nom_tabla = 'GAD_MENS_REPORTES'
      AND a.nom_campo = 'COD_TITULO'
      AND a.cod_producto = 1
      AND a.cod_idioma = v_cod_idioma
      AND a.cod_concepto = b.cod_titulo
      AND cod_concepto = 20
      AND ROWNUM = 1;

   BEGIN

	   v_paso :='(p_ga_ins_glosafact) Preguntando si Aplica la Impresion de Direccion en NPT_PARAMETRO para Alias_parametro IMPRDIR';
	   SELECT valor_parametro INTO v_parametro
	   FROM   NPT_PARAMETRO
	   WHERE  alias_parametro='IMPRDIR';

	   EXCEPTION
            WHEN NO_DATA_FOUND THEN
			 null;

   END;

   if v_parametro='True' then
	   v_paso :='(p_ga_ins_glosafact) Asignando glosa4 segzn idioma: '|| v_cod_idioma;
	   SELECT des_concepto
	     INTO v_glosa_04
	     FROM GE_MULTIIDIOMA a, gad_mens_reportes b
	    WHERE a.nom_tabla = 'GAD_MENS_REPORTES'
	      AND a.nom_campo = 'COD_TITULO'
	      AND a.cod_producto = 1
	      AND a.cod_idioma = v_cod_idioma
	      AND a.cod_concepto = b.cod_titulo
	      AND cod_concepto = 21
	      AND ROWNUM = 1;
	end if;

   v_paso :='(p_ga_ins_glosafact) Obteniendo venta de Pedido: '|| v_cod_pedido;
   SELECT MAX (num_venta)
     INTO v_num_venta
     FROM al_ventas
     WHERE cod_pedido = v_cod_pedido;

   v_paso :='(p_ga_ins_glosafact) Obteniendo proceso de fa_interfact para n0 venta: '|| v_num_venta;
   SELECT num_proceso, v_glosa_01 || ': '  || TO_CHAR (fec_vencimiento, 'DD-MM-YYYY')
     INTO v_num_proceso, v_mensaje_03
     FROM fa_interfact
    WHERE num_venta = v_num_venta;

   v_paso :='(p_ga_ins_glosafact) Preparando mensaje1 para pedido: '|| v_cod_pedido;
   SELECT    v_glosa_02 || ': ' || a.cod_pedido || ','  || b.des_tipo_canal
     INTO v_mensaje_01
     FROM npt_pedido a, npd_tipo_canal b, npt_usuario_tipo_canal c
     WHERE a.cod_pedido = v_cod_pedido
      AND c.cod_usuario = a.cod_usuario_ing
      AND b.cod_tipo_canal(+) = c.cod_tipo_canal;

   v_paso :='(p_ga_ins_glosafact) Preparando mensaje2 para pedido: '|| v_cod_pedido;
   SELECT    v_glosa_03 || ': '  || a.guia_des_pedido || ',' || b.des_tipo_pago
     INTO v_mensaje_02
     FROM npt_pedido a, npd_tipo_pago b
    WHERE a.cod_pedido = v_cod_pedido
      AND a.cod_tipo_pago = b.cod_tipo_pago;

   v_paso :='(p_ga_ins_glosafact) Preparando mensaje3 y mensaje4 para pedido: '|| v_cod_pedido;
   SELECT    v_glosa_04
          || ': ' ||
          b.des_bodega, '*' || c.nom_calle || ', ' || c.num_calle || ', ' || c.num_piso
		  ,'*' || d.des_ciudad || ', ' || e.des_region
	 INTO v_mensaje_04, v_mensaje_05, v_mensaje_06
     FROM npt_pedido a, al_bodegas b, ge_direcciones c, ge_ciudades d,
	      ge_regiones e
    WHERE a.cod_pedido = v_cod_pedido
          and a.cod_bodega=b.cod_bodega
		  and c.cod_direccion=b.cod_direccion
		  and c.cod_ciudad=d.cod_ciudad
		  and c.cod_provincia=d.cod_provincia
		  and c.cod_region=d.cod_region
		  and c.cod_region=e.cod_region;

   v_paso :='(p_ga_ins_glosafact) Obteniendo correlativo de mensaje';
   SELECT fa_seq_mensajes.NEXTVAL INTO v_corr_mensaje FROM dual;

   v_paso :='(p_ga_ins_glosafact) Obteniendo Parametros desde FA_PARMENSAJE para MENSAJE FACTURA WEB';
   SELECT cod_formulario, cod_bloque, cant_lineasmen, cant_caractlin
   INTO v_cod_formulario, v_cod_bloque, v_cant_lineasmen, v_cant_caractlin
   FROM FA_PARMENSAJE
   WHERE des_bloque='MENSAJE FACTURA WEB';

   v_paso :='(p_ga_ins_glosafact) Insertando mensaje1 en fa_mensajes';
   INSERT INTO FA_MENSAJES
   (corr_mensaje, num_linea, desc_mensaje, desc_menslin, cod_idioma, cant_lineasmen, cant_caractlin)
   VALUES (v_corr_mensaje, 1, 'MSJEVTAWEB', v_mensaje_01, v_cod_idioma, v_cant_lineasmen, v_cant_caractlin);

   v_paso :='(p_ga_ins_glosafact) Insertando en fa_mensproceso';
   INSERT INTO FA_MENSPROCESO
               (num_proceso, cod_formulario, cod_bloque, corr_mensaje,
                num_lineas, cod_origen, desc_mensaje, ind_facturado,
                nom_usuario, fec_ingreso)
   VALUES (v_num_proceso, v_cod_formulario, v_cod_bloque, v_corr_mensaje,
           v_cant_lineasmen, 'FA', 'MSJEVTAWEB', 'I',USER, SYSDATE);

   v_paso :='(p_ga_ins_glosafact) Insertando mensaje2 en fa_mensajes';
   INSERT INTO FA_MENSAJES
               (corr_mensaje, num_linea, desc_mensaje, desc_menslin, cod_idioma, cant_lineasmen, cant_caractlin)
        VALUES (v_corr_mensaje, 2, 'MSJEVTAWEB', v_mensaje_02, v_cod_idioma, v_cant_lineasmen, v_cant_caractlin);

   v_paso :='(p_ga_ins_glosafact) Insertando mensaje3 en fa_mensajes';
   INSERT INTO FA_MENSAJES
               (corr_mensaje, num_linea, desc_mensaje, desc_menslin, cod_idioma, cant_lineasmen, cant_caractlin)
        VALUES (v_corr_mensaje, 3, 'MSJEVTAWEB', v_mensaje_03,v_cod_idioma, v_cant_lineasmen, v_cant_caractlin);

   if v_parametro='True' Then
	   v_paso :='(p_ga_ins_glosafact) Insertando mensaje4 en fa_mensajes';
	   INSERT INTO FA_MENSAJES
	               (corr_mensaje, num_linea, desc_mensaje, desc_menslin, cod_idioma, cant_lineasmen, cant_caractlin)
	        VALUES (v_corr_mensaje, 4, 'MSJEVTAWEB', v_mensaje_04,v_cod_idioma, v_cant_lineasmen, v_cant_caractlin);

	   v_paso :='(p_ga_ins_glosafact) Insertando mensaje5 en fa_mensajes';
	   INSERT INTO FA_MENSAJES
	               (corr_mensaje, num_linea, desc_mensaje, desc_menslin, cod_idioma, cant_lineasmen, cant_caractlin)
	        VALUES (v_corr_mensaje, 5, 'MSJEVTAWEB', v_mensaje_05,v_cod_idioma, v_cant_lineasmen, v_cant_caractlin);

	   v_paso :='(p_ga_ins_glosafact) Insertando mensaje6 en fa_mensajes';
	   INSERT INTO FA_MENSAJES
	               (corr_mensaje, num_linea, desc_mensaje, desc_menslin, cod_idioma, cant_lineasmen, cant_caractlin)
	        VALUES (v_corr_mensaje, 6, 'MSJEVTAWEB', v_mensaje_06,v_cod_idioma, v_cant_lineasmen, v_cant_caractlin);
	end if;


EXCEPTION
   WHEN OTHERS THEN
      SELECT al_seq_errores_web.NEXTVAL INTO v_errores.num_error FROM dual;
      v_errores.num_serie := NULL;
      v_errores.cod_articulo := NULL;
      v_errores.cod_pedido := v_cod_pedido;
      v_errores.fec_error := SYSDATE;
      v_errores.num_venta := v_num_venta;
      v_errores.glosa_error_traspaso := v_paso;
      v_errores.glosa_error_venta := SQLERRM;
	  v_errores.cod_estado_error := 'WARNING: ERROR EN P_GA_INS_GLOSAFACT';
      /*al_pac_trasven_web.insertar_al_errores_web (v_errores);*/
 	  INSERT INTO al_errores_web
	      (num_error,cod_pedido,lin_pedido,num_serie,cod_articulo,fec_error,num_venta,
           num_traspaso_masivo,glosa_error_traspaso,glosa_error_venta,cod_estado_error)
         VALUES
          (v_errores.num_error,v_errores.cod_pedido,v_errores.lin_pedido,v_errores.num_serie,v_errores.cod_articulo,
          v_errores.fec_error,v_errores.num_venta,v_errores.num_traspaso_masivo,v_errores.glosa_error_traspaso,
          v_errores.glosa_error_venta,v_errores.cod_estado_error);

END p_ga_ins_glosafact;
/
SHOW ERRORS
