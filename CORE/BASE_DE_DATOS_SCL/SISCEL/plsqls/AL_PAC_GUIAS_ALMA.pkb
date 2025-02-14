CREATE OR REPLACE PACKAGE BODY          "AL_PAC_GUIAS_ALMA"  IS
  PROCEDURE p_genera_guias(
  v_peticion IN al_petiguias_alma.num_petidor%type ,
  v_detalle IN al_cab_guias.ind_detalle%type )
  IS
        --
           v_cabguia     al_cab_guias%rowtype;
           v_linguia     al_lin_guias%rowtype;
           v_linguias    al_datos_generales.num_linguias%type;
           v_inter       al_interguias%rowtype;
           v_contador    number(2) := 0;
           v_petidor     al_petiguias_alma.tip_petidor%type;
           v_numpeti     al_petiguias_alma.num_petidor%type;
           v_moneda_val  al_datos_generales.cod_moneda_val%type;
           v_peso        fa_datosgener.cod_peso%type;
        BEGIN
           v_inter.num_peticion   := v_peticion;
           v_inter.cod_retorno    := 0;
           v_cabguia.num_peticion := v_peticion;
           v_cabguia.ind_detalle  := v_detalle;
           p_select_peticion (v_peticion,
                              v_petidor,
                              v_numpeti,
                              v_inter.cod_retorno,
                              v_inter.des_cadena);
           if v_inter.cod_retorno <> 0 then
              raise EXCEPTION_ERROR;
           end if;
           p_obtiene_peso(v_peso,
                          v_inter.cod_retorno,
                          v_inter.des_cadena);
           if v_inter.cod_retorno <> 0 then
              raise EXCEPTION_ERROR;
           end if;
           p_obtiene_moneda_val (v_moneda_val,
                                 v_inter.cod_retorno,
                                 v_inter.des_cadena);
           if v_inter.cod_retorno <> 0 then
              raise EXCEPTION_ERROR;
           end if;
           p_carga_cabecera (v_petidor,
                             v_numpeti,
                             v_cabguia,
                             v_inter.cod_retorno,
                             v_inter.des_cadena);
           if v_inter.cod_retorno <> 0 then
              raise EXCEPTION_ERROR;
           end if;
           p_select_numguia(v_cabguia.num_guia,
                            v_cabguia.fec_guia,
                            v_contador,
                            v_inter.cod_retorno,
                            v_inter.des_cadena);
           if v_inter.cod_retorno <> 0 then
              raise EXCEPTION_ERROR;
           end if;
           p_genera_cabecera (v_cabguia,
                              v_inter.cod_retorno,
                              v_inter.des_cadena);
           if v_inter.cod_retorno <> 0 then
              raise EXCEPTION_ERROR;
           end if;
           p_obtiene_filas (v_linguias,
                            v_inter.cod_retorno,
                            v_inter.des_cadena);
           if v_inter.cod_retorno <> 0 then
              raise EXCEPTION_ERROR;
           end if;
           v_linguia.num_guia := v_cabguia.num_guia;
           v_linguia.lin_guia := 0;
           p_carga_lineas (v_numpeti,
                           v_petidor,
                           v_peso,
                           v_moneda_val,
                           v_linguia,
                           v_cabguia,
                           v_linguias,
                           v_contador,
                           v_inter.cod_retorno,
                           v_inter.des_cadena);
           p_borra_peticion (v_peticion,
                             v_inter.cod_retorno,
                             v_inter.des_cadena);
           if v_inter.cod_retorno = 0 then
              v_inter.des_cadena := '/' || to_char(v_contador) || '/';
           end if;
           p_insert_interguias(v_inter);
        EXCEPTION
           when EXCEPTION_ERROR then
                p_insert_interguias(v_inter);
        END p_genera_guias;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_filas(
  v_linguias IN OUT al_datos_generales.num_linguias%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
            select num_linguias into v_linguias
                   from al_datos_generales;
        EXCEPTION
            when OTHERS then
                 v_error := 1;
                 v_mensa := '/Error Lectura Numero Lineas por Guia/';
        END p_obtiene_filas;
  --
  -- Retrofitted
  PROCEDURE p_carga_cabecera(
  v_petidor IN al_petiguias_alma.tip_petidor%type ,
  v_numpeti IN al_petiguias_alma.num_petidor%type ,
  v_cabguia IN OUT al_cab_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        --
          v_direccion      ge_direcciones.cod_direccion%type;
          v_region         ge_direcciones.cod_region%type;
          v_provincia      ge_direcciones.cod_provincia%type;
          v_ciudad         ge_direcciones.cod_ciudad%type;
          v_proveedor      al_vcabecera_ordenes.cod_proveedor%type;
          v_bodega_ori     al_bodegas.cod_bodega%type;
          v_bodega_des     al_bodegas.cod_bodega%type;
          v_responsable    al_bodegas.nom_responsable%type;
        BEGIN
          v_cabguia.cod_estado      := 'NU';
          if v_petidor = 1 then
             v_cabguia.num_devolucion := v_numpeti;
             p_select_devolucion (v_numpeti,
                                  v_proveedor,
                                  v_bodega_ori,
                                  v_error,
                                  v_mensa);
             if v_error <> 0 then
                raise EXCEPTION_ERROR;
             end if;
             p_select_des_bodega (v_bodega_ori,
                                  v_cabguia.des_bodega_ori,
                                  v_direccion,
                                  v_cabguia.nom_destinatario,
                                  v_error,
                                  v_mensa);
             if v_error <> 0 then
                raise EXCEPTION_ERROR;
             end if;
             p_select_proveedor (v_proveedor,
                                 v_cabguia,
                                 v_error,
                                 v_mensa);
             if v_error <> 0 then
                raise EXCEPTION_ERROR;
             end if;
          else
             v_cabguia.num_traspaso := v_numpeti;
             p_select_traspaso (v_numpeti,
                                v_bodega_ori,
                                v_bodega_des,
                                v_error,
                                v_mensa);
             if v_error <> 0 then
                raise EXCEPTION_ERROR;
             end if;
             p_select_des_bodega (v_bodega_ori,
                                  v_cabguia.des_bodega_ori,
                                  v_direccion,
                                  v_responsable,
                                  v_error,
                                  v_mensa);
             if v_error <> 0 then
                raise EXCEPTION_ERROR;
             end if;
             p_select_des_bodega (v_bodega_des,
                                  v_cabguia.des_bodega_des,
                                  v_direccion,
                                  v_cabguia.nom_destinatario,
                                  v_error,
                                  v_mensa);
             if v_error <> 0 then
                raise EXCEPTION_ERROR;
             end if;
             if v_cabguia.nom_destinatario is null then
                v_cabguia.nom_destinatario := v_cabguia.des_bodega_des;
             end if;
             p_select_direccion (v_direccion,
                                 v_cabguia.des_direccion,
                                 v_region,
                                 v_provincia,
                                 v_ciudad,
                                 v_error,
                                 v_mensa);
             if v_error <> 0 then
                raise EXCEPTION_ERROR;
             end if;
             p_select_ciudad (v_region,
                              v_provincia,
                              v_ciudad,
                              v_cabguia.des_ciudad,
                              v_error,
                              v_mensa);
          end if;
        EXCEPTION
          when EXCEPTION_ERROR then
               null;
        END p_carga_cabecera;
  --
  -- Retrofitted
  PROCEDURE p_genera_cabecera(
  v_cabguia IN al_cab_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
           insert into al_cab_guias (num_guia,
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
                             values (v_cabguia.num_guia,
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
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error al Generar Cabecera Guia/';
        END p_genera_cabecera;
  --
  -- Retrofitted
  PROCEDURE p_genera_linea(
  v_linguia IN AL_LIN_GUIAS%rowtype ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%type ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%type )
  IS
  	CN_largomin    CONSTANT PLS_INTEGER:=10;
	CV_tecno_gsm   CONSTANT VARCHAR2(3):='GSM';
	TV_num_min	   al_ser_guias.num_min%TYPE;
	TV_cod_tecnologia al_tecnologia.cod_tecnologia%TYPE;
        BEGIN
		   IF v_linguia.num_telefono IS NOT NULL THEN
				SELECT b.cod_tecnologia
				INTO TV_cod_tecnologia
				FROM ga_celnum_uso a, icg_central b
				WHERE a.cod_central = b.cod_central
				AND v_linguia.num_telefono BETWEEN num_desde AND num_hasta;

			  IF CV_tecno_gsm = TV_cod_tecnologia THEN
			  	 TV_num_min:=v_linguia.num_telefono;
			  ELSE
			   	  TV_num_min:= GE_FN_MIN_DE_MDN(v_linguia.num_telefono);
				  IF LENGTH(TV_num_min) < CN_largomin THEN
			   	  	 TV_num_min:=v_linguia.num_telefono;
				  END IF;
			  END IF;
		   END IF;
           INSERT INTO AL_LIN_GUIAS (num_guia,
                                     lin_guia,
                                     cod_articulo,
                                     des_articulo,
                                     can_articulo,
                                     num_serie,
         							 num_telefono,
                                     cod_moneda,
                                     val_articulo,
                                     num_cargo,
									 num_min)
                             values (v_linguia.num_guia,
                                     v_linguia.lin_guia,
                                     v_linguia.cod_articulo,
                                     v_linguia.des_articulo,
                                     v_linguia.can_articulo,
                                     v_linguia.num_serie,
         							 v_linguia.num_telefono,
                                     v_linguia.cod_moneda,
                                     v_linguia.val_articulo,
                                     v_linguia.num_cargo,
									 TV_num_min);
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error al Generar Lineas Guias/';
        END p_genera_linea;
  --
  -- Retrofitted
  PROCEDURE p_select_direccion(
  v_direccion IN ge_direcciones.cod_direccion%type ,
  v_desdirec IN OUT al_cab_guias.des_direccion%type ,
  v_region IN OUT ge_direcciones.cod_region%type ,
  v_provincia IN OUT ge_direcciones.cod_provincia%type ,
  v_ciudad IN OUT ge_direcciones.cod_ciudad%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
           select nom_calle || ' ' || num_calle ||', '|| num_piso,
                  cod_region,cod_provincia,cod_ciudad
             into v_desdirec,v_region,v_provincia,v_ciudad
             from ge_direcciones
            where cod_direccion = v_direccion;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Lectura Direcciones/';
        END p_select_direccion;
  --
  -- Retrofitted
  PROCEDURE p_select_ciudad(
  v_region IN ge_direcciones.cod_direccion%type ,
  v_provincia IN ge_direcciones.cod_provincia%type ,
  v_ciudad IN ge_direcciones.cod_ciudad%type ,
  v_desciu IN OUT al_cab_guias.des_ciudad%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
          select des_ciudad
            into v_desciu
            from ge_ciudades
           where cod_region = v_region
             and cod_provincia = v_provincia
             and cod_ciudad = v_ciudad;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Lectura Ciudades/';
        END p_select_ciudad;
  --
  -- Retrofitted
  PROCEDURE p_select_articulo(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_desc IN OUT al_articulos.des_articulo%type ,
  v_seriado IN OUT al_articulos.ind_seriado%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
           select des_articulo,ind_seriado
             into v_desc,v_seriado
             from al_articulos
            where cod_articulo = v_articulo;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Lectura Articulo/';
        END p_select_articulo;
  --
  -- Retrofitted
  PROCEDURE p_select_des_bodega(
  v_bodega IN al_bodegas.cod_bodega%type ,
  v_descr IN OUT al_bodegas.des_bodega%type ,
  v_direc IN OUT al_bodegas.cod_direccion%type ,
  v_respon IN OUT al_bodegas.nom_responsable%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
           select des_bodega,cod_direccion,nom_responsable
             into v_descr,v_direc,v_respon
             from al_bodegas
            where cod_bodega = v_bodega;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Obtencion Descripcion Bodega/';
        END p_select_des_bodega;
  --
  -- Retrofitted
  PROCEDURE p_select_numguia(
  v_guia IN OUT al_cab_guias.num_guia%type ,
  v_fecha IN OUT al_cab_guias.fec_guia%type ,
  v_conta IN OUT number ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
          select al_seq_guias.nextval,sysdate
            into v_guia,v_fecha
            from al_datos_generales;
            v_conta := v_conta + 1;
        EXCEPTION
          when OTHERS then
               v_error := 1;
               v_mensa := '/Error Obtencion No.Guia/';
        END p_select_numguia;
  --
  -- Retrofitted
  PROCEDURE p_insert_interguias(
  v_inter IN al_interguias%rowtype )
  IS
        BEGIN
            insert into al_interguias (num_peticion,
                                       cod_retorno,
                                       des_cadena)
                               values (v_inter.num_peticion,
                                       v_inter.cod_retorno,
                                       v_inter.des_cadena);
        EXCEPTION
           when others then
                raise_application_error (-20177,'Error Insert en INTERGUIAS');
        END p_insert_interguias;
  --
  -- Retrofitted
  PROCEDURE p_select_peticion(
  v_peticion IN al_petiguias_alma.num_peticion%type ,
  v_petidor IN OUT al_petiguias_alma.tip_petidor%type ,
  v_numpeti IN OUT al_petiguias_alma.num_petidor%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
           select tip_petidor,num_petidor
             into v_petidor,v_numpeti
             from al_petiguias_alma
            where num_peticion = v_peticion;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Obtencion Datos Peticion de Guia/';
        END p_select_peticion;
  --
  -- Retrofitted
  PROCEDURE p_select_devolucion(
  v_numpeti IN al_petiguias_alma.num_petidor%type ,
  v_proveedor IN OUT al_vcabecera_ordenes.cod_proveedor%type ,
  v_bodega_ori IN OUT al_vcabecera_ordenes.cod_bodega%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
           select cod_proveedor,cod_bodega
             into v_proveedor,v_bodega_ori
             from al_vcabecera_ordenes
            where num_orden = v_numpeti
              and tip_orden = 3;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Obtencion Datos Devolucion/';
        END p_select_devolucion;
  --
  -- Retrofitted
  PROCEDURE p_select_traspaso(
  v_numpeti IN al_petiguias_alma.num_petidor%type ,
  v_bodega_ori IN OUT al_traspasos.cod_bodega_ori%type ,
  v_bodega_des IN OUT al_traspasos.cod_bodega_dest%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
           select cod_bodega_ori,cod_bodega_dest
             into v_bodega_ori,v_bodega_des
             from al_traspasos
            where num_traspaso = v_numpeti;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Obtencion Datos Traspaso/';
        END p_select_traspaso;
  --
  -- Retrofitted
  PROCEDURE p_carga_lineas(
  v_numpeti IN al_petiguias_alma.num_petidor%type ,
  v_petidor IN al_petiguias_alma.tip_petidor%type ,
  v_peso IN OUT fa_datosgener.cod_peso%type ,
  v_moneda_val IN OUT al_datos_generales.cod_moneda_val%type ,
  v_linguia IN OUT al_lin_guias%rowtype ,
  v_cabguia IN OUT al_cab_guias%rowtype ,
  v_linguias IN OUT al_datos_generales.num_linguias%type ,
  v_contador IN OUT number ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        --
           v_sentencia varchar2(1024);
           v_cursor    integer;
           v_filas     integer;
           v_linea     number(3) := 0;
           v_seriado   al_articulos.ind_seriado%type;
           v_tipstock  al_tipos_stock.tip_stock%type;
           v_tipvalor  al_tipos_stock.ind_valorar%type;
        BEGIN
           v_cursor := dbms_sql.open_cursor;
           if v_petidor = 1 then
              v_sentencia := 'SELECT TIP_STOCK,COD_ARTICULO,CAN_ORDEN,NUM_LINEA
  '
                             || 'FROM AL_VLINEAS_ORDENES '
                             || 'WHERE NUM_ORDEN = :var1 AND TIP_ORDEN=3';
           else
              v_sentencia :=
      'SELECT TIP_STOCK,COD_ARTICULO,CAN_TRASPASO,LIN_TRASPASO
        '
                             || 'FROM AL_LIN_TRASPASO WHERE NUM_TRASPASO = :var1
  ';
           end if;
           dbms_sql.parse(v_cursor,v_sentencia,dbms_sql.v7);
           dbms_sql.define_column(v_cursor,1,v_tipstock);
           dbms_sql.define_column(v_cursor,2,v_linguia.cod_articulo);
           dbms_sql.define_column(v_cursor,3,v_linguia.can_articulo);
           dbms_sql.define_column(v_cursor,4,v_linea);
           dbms_sql.bind_variable(v_cursor,'var1',v_numpeti);
           v_filas := dbms_sql.execute(v_cursor);
           LOOP
              if dbms_sql.fetch_rows(v_cursor) > 0 then
                 dbms_sql.column_value(v_cursor,1,v_tipstock);
                 dbms_sql.column_value(v_cursor,2,v_linguia.cod_articulo);
                 dbms_sql.column_value(v_cursor,3,v_linguia.can_articulo);
                 dbms_sql.column_value(v_cursor,4,v_linea);
                 p_obtiene_tipvalor (v_tipstock,
                                     v_tipvalor,
                                     v_error,
                                     v_mensa);
                 if v_error <> 0 then
                    raise EXCEPTION_ERROR;
                 end if;
                 p_select_articulo(v_linguia.cod_articulo,
                                   v_linguia.des_articulo,
                                   v_seriado,
                                   v_error,
                                   v_mensa);
                 if v_error <> 0 then
                    raise EXCEPTION_ERROR;
                 end if;
                 if v_seriado = 1 then
                    if v_cabguia.ind_detalle = 0 then
                       p_carga_seriados(v_numpeti,
                                        v_linea,
                                        v_petidor,
                                        v_peso,
                                        v_moneda_val,
                                        v_tipvalor,
                                        v_linguia,
                                        v_cabguia,
                                        v_linguias,
                                        v_contador,
                                        v_error,
                                        v_mensa);
                      if v_error <> 0 then
                         raise EXCEPTION_ERROR;
                      end if;
                   else
                     if v_linguia.lin_guia < v_linguias then
                        v_linguia.lin_guia := v_linguia.lin_guia + 1;
                     else
                        v_linguia.lin_guia := 1;
                        p_select_numguia(v_cabguia.num_guia,
                                         v_cabguia.fec_guia,
                                         v_contador,
                                         v_error,
                                         v_mensa);
                        if v_error <> 0 then
                           raise EXCEPTION_ERROR;
                        end if;
                        p_genera_cabecera (v_cabguia,
                                           v_error,
                                           v_mensa);
                        if v_error <> 0 then
                           raise EXCEPTION_ERROR;
                        end if;
                        v_linguia.num_guia := v_cabguia.num_guia;
                     end if;
                     if v_error <> 0 then
                        raise EXCEPTION_ERROR;
                     end if;
                     v_linguia.val_articulo := null;
                     v_linguia.cod_moneda   := null;
                     v_linguia.num_serie    := null;
                     p_genera_linea(v_linguia,
                                    v_error,
                                    v_mensa);
                     if v_error <> 0 then
                        raise EXCEPTION_ERROR;
                     end if;
                     p_carga_serguia (v_numpeti,
                                      v_linea,
                                      v_petidor,
                                      v_linguia,
                                      v_peso,
                                      v_moneda_val,
                                      v_tipvalor,
                                      v_error,
                                      v_mensa);
                      if v_error <> 0 then
                         raise EXCEPTION_ERROR;
                      end if;
                      p_revalora_linea (v_linguia,
                                        v_error,
                                        v_mensa);
                      if v_error <> 0 then
                         raise EXCEPTION_ERROR;
                      end if;
                   end if;
                 else
                    p_valorar_linea (v_peso,
                                     v_moneda_val,
                                     v_tipvalor,
                                     v_linguia.cod_articulo,
                                     null,
                                     v_linguia.val_articulo,
                                     v_error,
                                     v_mensa);
                    if v_error <> 0 then
                       raise EXCEPTION_ERROR;
                    end if;
                    v_linguia.val_articulo :=
                              v_linguia.val_articulo * v_linguia.can_articulo;
                    if v_linguia.lin_guia < v_linguias then
                       v_linguia.lin_guia := v_linguia.lin_guia + 1;
                    else
                       v_linguia.lin_guia := 1;
                       p_select_numguia(v_cabguia.num_guia,
                                        v_cabguia.fec_guia,
                                        v_contador,
                                        v_error,
                                        v_mensa);
                       if v_error <> 0 then
                          raise EXCEPTION_ERROR;
                       end if;
                       p_genera_cabecera (v_cabguia,
                                          v_error,
                                          v_mensa);
                       if v_error <> 0 then
                          raise EXCEPTION_ERROR;
                       end if;
                       v_linguia.num_guia := v_cabguia.num_guia;
                    end if;
                    if v_error <> 0 then
                       raise EXCEPTION_ERROR;
                    end if;
                    p_genera_linea(v_linguia,
                                   v_error,
                                   v_mensa);
                    if v_error <> 0 then
                       raise EXCEPTION_ERROR;
                    end if;
                 end if;
              else
                 exit;
              end if;
           end LOOP;
        EXCEPTION
           when EXCEPTION_ERROR then
                if dbms_sql.is_open(v_cursor) then
                   dbms_sql.close_cursor (v_cursor);
                end if;
           when OTHERS then
                if dbms_sql.is_open(v_cursor) then
                   dbms_sql.close_cursor (v_cursor);
                end if;
                v_error := 1;
                v_mensa := '/Error Obtencion Lineas/';
        END p_carga_lineas;
  --
  -- Retrofitted
  PROCEDURE p_carga_seriados(
  v_numpeti IN al_petiguias_alma.num_petidor%type ,
  v_linea IN number ,
  v_petidor IN al_petiguias_alma.tip_petidor%type ,
  v_peso IN OUT fa_datosgener.cod_peso%type ,
  v_moneda_val IN OUT al_datos_generales.cod_moneda_val%type ,
  v_indvalor IN al_tipos_stock.ind_valorar%type ,
  v_linguia IN OUT al_lin_guias%rowtype ,
  v_cabguia IN OUT al_cab_guias%rowtype ,
  v_linguias IN OUT al_datos_generales.num_linguias%type ,
  v_contador IN OUT number ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        --
           v_sentencia varchar2(1024);
           v_cursor    integer;
           v_filas     integer;
        BEGIN
           v_linguia.can_articulo := 1;
           v_cursor               := dbms_sql.open_cursor;
           if v_petidor = 1 then
              v_sentencia :=
    'SELECT NUM_SERIE , NUM_TELEFONO FROM AL_VSERIES_ORDENES WHERE '
                             || 'NUM_ORDEN = :var1 AND TIP_ORDEN = 3 AND '
                             || 'NUM_LINEA = :var2';
           else
              v_sentencia :=
    'SELECT NUM_SERIE , NUM_TELEFONO FROM AL_SER_TRASPASO WHERE '
                             || 'NUM_TRASPASO = :var1 AND LIN_TRASPASO = :var2';
           end if;
           dbms_sql.parse(v_cursor,v_sentencia,dbms_sql.v7);
           dbms_sql.define_column(v_cursor,1,v_linguia.num_serie,25);
           dbms_sql.define_column(v_cursor,2,v_linguia.num_telefono);
           dbms_sql.bind_variable(v_cursor,'var1',v_numpeti);
           dbms_sql.bind_variable(v_cursor,'var2',v_linea);
           v_filas := dbms_sql.execute(v_cursor);
           LOOP
              if dbms_sql.fetch_rows(v_cursor) > 0 then
                 dbms_sql.column_value(v_cursor,1,v_linguia.num_serie);
          dbms_sql.column_value(v_cursor,2,v_linguia.num_telefono);
                 p_valorar_linea (v_peso,
                                  v_moneda_val,
                                  v_indvalor,
                                  v_linguia.cod_articulo,
                                  v_linguia.num_serie,
                                  v_linguia.val_articulo,
                                  v_error,
                                  v_mensa);
                 if v_error <> 0 then
                    raise EXCEPTION_ERROR;
                 end if;
                 if v_linguia.lin_guia < v_linguias then
                    v_linguia.lin_guia := v_linguia.lin_guia + 1;
                 else
                    v_linguia.lin_guia := 1;
                    p_select_numguia(v_cabguia.num_guia,
                                     v_cabguia.fec_guia,
                                     v_contador,
                                     v_error,
                                     v_mensa);
                    if v_error <> 0 then
                       raise EXCEPTION_ERROR;
                    end if;
                    p_genera_cabecera (v_cabguia,
                                       v_error,
                                       v_mensa);
                    if v_error <> 0 then
                       raise EXCEPTION_ERROR;
                    end if;
                    v_linguia.num_guia := v_cabguia.num_guia;
                 end if;
                 if v_error <> 0 then
                    raise EXCEPTION_ERROR;
                 end if;
                 p_genera_linea(v_linguia,
                                v_error,
                                v_mensa);
                 if v_error <> 0 then
                    raise EXCEPTION_ERROR;
                 end if;
              else
                 exit;
              end if;
           end LOOP;
        EXCEPTION
           when EXCEPTION_ERROR then
                if dbms_sql.is_open(v_cursor) then
                   dbms_sql.close_cursor (v_cursor);
                end if;
           when OTHERS then
                if dbms_sql.is_open(v_cursor) then
                   dbms_sql.close_cursor (v_cursor);
                end if;
                v_error := 1;
                v_mensa := '/Error Obtencion Series/' || to_char(SQLCODE);
        END p_carga_seriados;
  --
  -- Retrofitted
  PROCEDURE p_borra_peticion(
  v_peticion IN al_petiguias_alma.num_peticion%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
           delete al_petiguias_alma
                  where num_peticion = v_peticion;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Anulacion Peticion de Guia/';
        END p_borra_peticion;
  --
  -- Retrofitted
  PROCEDURE p_select_proveedor(
  v_proveedor IN al_proveedores.cod_proveedor%type ,
  v_cabguia IN OUT al_cab_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
           select nom_proveedor,num_ident,dir_proveedor,des_comuna||' '||des_region,
                  num_telefono
             into v_cabguia.nom_destinatario,v_cabguia.num_ident
  ,v_cabguia.des_direccion
    ,
                  v_cabguia.des_ciudad,v_cabguia.num_telefono
             from al_proveedores
            where cod_proveedor = v_proveedor;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Obtencion Datos Proveedor/';
        END p_select_proveedor;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_moneda_val(
  v_moneda_val IN OUT al_datos_generales.cod_moneda_val%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
           select cod_moneda_val into v_moneda_val
                  from al_datos_generales;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Datos Generales Inventario/';
        END p_obtiene_moneda_val;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_peso(
  v_peso IN OUT fa_datosgener.cod_peso%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
           select cod_peso into v_peso
                  from fa_datosgener;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Datos Generales Facturacion/';
        END p_obtiene_peso;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_tipvalor(
  v_tipstock IN al_tipos_stock.tip_stock%type ,
  v_indvalor IN OUT al_tipos_stock.ind_valorar%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
           select ind_valorar into v_indvalor
             from al_tipos_stock
            where tip_stock = v_tipstock;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Obtencion Tipo de Valoracion/';
        END p_obtiene_tipvalor;
  --
  -- Retrofitted
  PROCEDURE p_valorar_linea(
  v_peso IN OUT fa_datosgener.cod_peso%type ,
  v_moneda_val IN OUT al_datos_generales.cod_moneda_val%type ,
  v_indvalor IN al_tipos_stock.ind_valorar%type ,
  v_articulo IN al_articulos.cod_articulo%type ,
  v_serie IN al_lin_guias.num_serie%type ,
  v_valor IN OUT al_lin_guias.val_articulo%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
           v_moneda   ge_monedas.cod_moneda%type;
           v_valor_in al_lin_guias.val_articulo%type;
        BEGIN
           if v_indvalor = 0 then
              p_obtiene_consignacion (v_articulo,
                                      v_valor_in,
                                      v_moneda,
                                      v_error,
                                      v_mensa);
              if v_moneda <> v_peso then
                 al_pac_validaciones.p_convertir_precio(v_moneda,
                                                        v_peso,
                                                        v_valor_in,
                                                        v_valor,
                                                        sysdate);
              else
                 v_valor := v_valor_in;
              end if;
           elsif v_indvalor = 1 then
                 p_obtiene_mercaderia (v_articulo,
                                       v_valor_in,
                                       v_error,
                                       v_mensa);
              if v_moneda_val <> v_peso then
                 al_pac_validaciones.p_convertir_precio(v_moneda_val,
                                                        v_peso,
                                                        v_valor_in,
                                                        v_valor,
                                                        sysdate);
              else
                 v_valor := v_valor_in;
              end if;
           else
              if v_serie is  not null then
                 p_obtiene_afijo_s (v_serie,
                                    v_valor_in,
                                    v_error,
                                    v_mensa);
                 if v_moneda_val <> v_peso then
                    al_pac_validaciones.p_convertir_precio(v_moneda_val,
                                                           v_peso,
                                                           v_valor_in,
                                                           v_valor,
                                                           sysdate);
                 else
                    v_valor := v_valor_in;
                 end if;
              else
                 v_valor := 0;
              end if;
           end if;
           if v_error <> 0 then
              raise EXCEPTION_ERROR;
           end if;
        EXCEPTION
           when EXCEPTION_ERROR then
                v_error := 1;
           when OTHERS then
                if SQLCODE = -20147 then
                   v_mensa := '/Error Conversion Precio/';
                else
                   v_mensa := '/Error Valoracion Linea/';
                end if;
                v_error := 1;
        END p_valorar_linea;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_consignacion(
  v_articulo IN al_lin_consignacion.cod_articulo%type ,
  v_valor IN OUT al_lin_consignacion.prc_articulo%type ,
  v_moneda IN OUT al_cab_consignacion.cod_moneda%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
          CURSOR c_consigna is
                 select b.prc_articulo,a.cod_moneda
                   from al_cab_consignacion a, al_lin_consignacion b
                  where a.num_lista = b.num_lista
                    and b.cod_articulo = v_articulo
                  order by fec_validez desc;
        BEGIN
           OPEN c_consigna;
           fetch c_consigna into v_valor,v_moneda;
           CLOSE c_consigna;
        EXCEPTION
           when OTHERS then
                if c_consigna%ISOPEN then
                   close c_consigna;
                end if;
                v_error := 1;
                v_mensa := '/Error Obtencion Precio Consignacion/';
        END p_obtiene_consignacion;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_mercaderia(
  v_articulo IN al_pmp_articulo.cod_articulo%type ,
  v_valor IN OUT al_pmp_articulo.prec_pmp%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
           v_ejercicio   al_pmp_articulo.fec_periodo%type;
           v_ejercicio1  al_pmp_articulo.fec_periodo%type;
           v_existe      number(1) := 0;
        BEGIN
           p_obtiene_ejercicio(v_ejercicio,
                               v_ejercicio1,
                               v_error,
                               v_mensa);
           if v_error = 0 then
              p_select_pmc (v_articulo,
                            v_ejercicio,
                            v_valor,
                            v_existe);
              if v_existe = 0 then
                 p_select_pmc (v_articulo,
                               v_ejercicio1,
                               v_valor,
                               v_existe);
              end if;
           end if;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Obtencion Precio Medio Compra/';
        END p_obtiene_mercaderia;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_afijo_s(
  v_serie IN al_pmp_afijo.num_serie%type ,
  v_valor IN OUT al_pmp_afijo.prc_actual%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
          select prc_actual into v_valor
            from al_pmp_afijo
           where num_serie = v_serie;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Obtencion Precio Activo Fijo/';
        END p_obtiene_afijo_s;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_ejercicio(
  v_ejercicio IN OUT al_cierres_alma.fec_inicio%type ,
  v_ejercicio1 IN OUT al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
           select fec_inicio,fec_fin + 1 into v_ejercicio, v_ejercicio1
                  from al_cierres_alma
                  where ind_cerrado = 0;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Obtencion Ejercicio/';
        END p_obtiene_ejercicio;
  --
  -- Retrofitted
  PROCEDURE p_carga_serguia(
  v_numpeti IN al_petiguias_alma.num_petidor%type ,
  v_linea IN number ,
  v_petidor IN al_petiguias_alma.tip_petidor%type ,
  v_linguia IN OUT al_lin_guias%rowtype ,
  v_peso IN OUT fa_datosgener.cod_peso%type ,
  v_moneda_val IN OUT al_datos_generales.cod_moneda_val%type ,
  v_indvalor IN al_tipos_stock.ind_valorar%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        --
           v_sentencia varchar2(1024);
           v_cursor    integer;
           v_filas     integer;
           v_serguia   al_ser_guias%rowtype;
           v_valor     al_lin_guias.val_articulo%type;
        BEGIN
           v_linguia.can_articulo := 1;
           v_cursor               := dbms_sql.open_cursor;
           if v_petidor = 1 then
              v_sentencia :=
    'SELECT NUM_SERIE , NUM_TELEFONO FROM AL_VSERIES_ORDENES WHERE '
                             || 'NUM_ORDEN = :var1 AND TIP_ORDEN = 3 AND '
                             || 'NUM_LINEA = :var2';
           else
              v_sentencia :=
    'SELECT NUM_SERIE , NUM_TELEFONO FROM AL_SER_TRASPASO WHERE '
                             || 'NUM_TRASPASO = :var1 AND LIN_TRASPASO = :var2';
           end if;
           dbms_sql.parse(v_cursor,v_sentencia,dbms_sql.v7);
           dbms_sql.define_column(v_cursor,1,v_linguia.num_serie,25);
           dbms_sql.define_column(v_cursor,2,v_linguia.num_telefono);
           dbms_sql.bind_variable(v_cursor,'var1',v_numpeti);
           dbms_sql.bind_variable(v_cursor,'var2',v_linea);
           v_filas := dbms_sql.execute(v_cursor);
           LOOP
              if dbms_sql.fetch_rows(v_cursor) > 0 then
                 dbms_sql.column_value(v_cursor,1,v_serguia.num_serie);
          dbms_sql.column_value(v_cursor,2,v_serguia.num_telefono);
                 v_serguia.num_guia  := v_linguia.num_guia;
                 v_serguia.lin_guia  := v_linguia.lin_guia;
                 v_serguia.num_cargo := null;
                 p_genera_serguia(v_serguia,
                                  v_error,
                                  v_mensa);
                 if v_error <> 0 then
                    raise EXCEPTION_ERROR;
                 end if;
                 p_valorar_linea(v_peso,
                                 v_moneda_val,
                                 v_indvalor,
                                 v_linguia.cod_articulo,
                                 v_serguia.num_serie,
                                 v_valor,
                                 v_error,
                                 v_mensa);
                 if v_error <> 0 then
                    raise EXCEPTION_ERROR;
                 end if;
                 v_linguia.val_articulo :=
                           nvl(v_linguia.val_articulo,0) + v_valor;
              else
                 exit;
              end if;
           end LOOP;
        EXCEPTION
           when EXCEPTION_ERROR then
                if dbms_sql.is_open(v_cursor) then
                   dbms_sql.close_cursor (v_cursor);
                end if;
           when OTHERS then
                if dbms_sql.is_open(v_cursor) then
                   dbms_sql.close_cursor (v_cursor);
                end if;
                v_error := 1;
                v_mensa := '/Error Obtencion Series/' || to_char(SQLCODE);
        END p_carga_serguia;
  --
  -- Retrofitted
  PROCEDURE p_genera_serguia(
  v_serguia IN AL_SER_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE)
  IS
  	CN_largomin    CONSTANT PLS_INTEGER:=10;
	CV_tecno_gsm   CONSTANT VARCHAR2(3):='GSM';
	TV_num_min	   al_ser_guias.num_min%TYPE;
	TV_cod_tecnologia al_tecnologia.cod_tecnologia%TYPE;
        BEGIN
		   IF v_serguia.num_telefono IS NOT NULL THEN
				SELECT b.cod_tecnologia
				INTO TV_cod_tecnologia
				FROM ga_celnum_uso a, icg_central b
				WHERE a.cod_central = b.cod_central
				AND v_serguia.num_telefono BETWEEN num_desde AND num_hasta;

		   	  IF CV_tecno_gsm = TV_cod_tecnologia THEN
			  	 TV_num_min:=v_serguia.num_telefono;
			  ELSE
			   	  TV_num_min:= GE_FN_MIN_DE_MDN(v_serguia.num_telefono);
				  IF LENGTH(TV_num_min) < CN_largomin THEN
			   	  	 TV_num_min:=v_serguia.num_telefono;
				  END IF;
			  END IF;
		   END IF;
           insert into al_ser_guias (num_guia,
                                     lin_guia,
                                     num_serie,
         							 num_telefono,
                                     num_cargo,
									 num_min)
                             values (v_serguia.num_guia,
                                     v_serguia.lin_guia,
                                     v_serguia.num_serie,
         							 v_serguia.num_telefono,
                                     v_serguia.num_cargo,
									 TV_num_min);
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error al generar detalle anexo/';
        END p_genera_serguia;
  --
  -- Retrofitted
  PROCEDURE p_revalora_linea(
  v_linguia IN al_lin_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
            update al_lin_guias set val_articulo = v_linguia.val_articulo
                   where num_guia = v_linguia.num_guia
                     and lin_guia = v_linguia.lin_guia;
        EXCEPTION
           when OTHERS then
                v_error := 1;
                v_mensa := '/Error Valoracion Linea/';
        END p_revalora_linea;
  --
  -- Retrofitted
  PROCEDURE p_select_pmc(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_ejercicio IN al_cierres_alma.fec_inicio%type ,
  v_pmc IN OUT al_pmp_articulo.prec_pmp%type ,
  v_existe IN OUT number )
  IS
        BEGIN
            select prec_pmp,1 into v_pmc,v_existe
                   from al_pmp_articulo
                  where cod_articulo  = v_articulo
                    and fec_periodo = v_ejercicio;
        EXCEPTION
            when NO_DATA_FOUND then
                 v_pmc    := 0;
                 v_existe := 0;
            when OTHERS then
                 v_pmc    := 0;
                 v_existe := 1;
        END p_select_pmc;
END AL_PAC_GUIAS_ALMA;
/
SHOW ERRORS
