CREATE OR REPLACE PACKAGE BODY          "AL_PAC_GUIAS_ABO" 
 IS
  --
  PROCEDURE p_genera_guias(
  v_num_peticion IN al_petiguias_abo.num_peticion%type ,
  v_detalle IN al_cab_guias.ind_detalle%type )
  IS
            --
               CURSOR c_peticion is
                     select *
                            from al_petiguias_abo
                            where num_peticion = v_num_peticion
                            for update of num_peticion;
            --
               v_peticion al_petiguias_abo%rowtype;
            -- G.R.
               v_cabguia  al_cab_guias%rowtype;
               v_linguia  al_lin_guias%rowtype;
               v_linguias al_datos_generales.num_linguias%type;
               v_bodega   al_bodegas.cod_bodega%type;
               v_cabecera number(1) := 0;
               v_inter    al_interguias%rowtype;
               v_contador number(2) := 0;
               v_peso     fa_datosgener.cod_peso%type;
               v_iva      fa_datosgener.cod_iva%type;
               v_pctiva   ge_impuestos.prc_impuesto%type;
               v_decim    ge_monedas.num_decimal%type;
               v_oficina  al_petiguias_abo.cod_oficina%type;
               v_concepto al_petiguias_abo.cod_concepto%type;
               v_serguia  al_ser_guias%rowtype;
               v_val0     al_petiguias_abo.val_linea%type;
               v_vallinea al_petiguias_abo.val_linea%type;
               v_tipdto   ge_cargos.tip_dto%type;
               v_valdto   ge_cargos.val_dto%type;
BEGIN
v_inter.num_peticion   := v_num_peticion;
v_cabguia.num_peticion := v_num_peticion;
v_cabguia.ind_detalle  := v_detalle;
v_inter.cod_retorno    := 0;
p_obtiene_filas (v_linguias,v_inter.cod_retorno,v_inter.des_cadena);
p_obtiene_peso_iva (v_peso,v_iva,v_inter.cod_retorno,v_inter.des_cadena);
if v_inter.cod_retorno <> 0 then
        raise EXCEPTION_ERROR;
end if;
p_carga_cabecera(v_num_peticion,v_cabguia,v_oficina,v_concepto,
                 v_inter.cod_retorno,v_inter.des_cadena);
if v_inter.cod_retorno <> 0 then
        raise EXCEPTION_ERROR;
end if;
al_pac_validaciones.p_decimales(v_peso,v_decim);
p_obtiene_iva (v_cabguia.cod_cliente,v_oficina,v_concepto,v_iva,
               v_pctiva,v_inter.cod_retorno,v_inter.des_cadena);
if v_inter.cod_retorno <> 0 then
          raise EXCEPTION_ERROR;
end if;
if v_inter.cod_retorno = 0 then
v_linguia.lin_guia := 1;
for v_peticion in c_peticion LOOP
        if v_linguia.lin_guia < v_linguias
   -------------------------------------------------------------
   -- S.G.C.
   -- aniado la condicion de que no falle para v_linguias = 1
   -- y peticion de detalle
   -------------------------------------------------------------
        or (v_linguia.lin_guia = 1 and v_detalle = 1) then
                if v_cabecera = 0 then
                        v_contador := v_contador + 1;
                        p_select_numguia(v_cabguia.num_guia,v_cabguia.fec_guia,
                                         v_inter.cod_retorno,v_inter.des_cadena);
                        if v_inter.cod_retorno <> 0 then
                               raise EXCEPTION_ERROR;
                        end if;
                        p_genera_cabecera (v_cabguia,v_inter.cod_retorno,v_inter.des_cadena);
                        if v_inter.cod_retorno <> 0 then
                                  raise EXCEPTION_ERROR;
                        end if;
                        v_linguia.num_guia := v_cabguia.num_guia;
                        v_cabecera := 1;
                else
                        if v_detalle = 0 then
                                 v_linguia.lin_guia := v_linguia.lin_guia + 1;
                        else
                                 if v_peticion.cod_articulo <> nvl(v_linguia.cod_articulo,0)
                                 or nvl(v_val0, -1) <> v_peticion.val_linea then
                                          v_linguia.lin_guia := v_linguia.lin_guia + 1;
                                 end if;
                        end if;
                end if;
        else
                if v_cabecera = 0 then
                        v_linguia.lin_guia := 1;
                        v_contador := v_contador + 1;
                        p_select_numguia(v_cabguia.num_guia,v_cabguia.fec_guia,
                                         v_inter.cod_retorno,v_inter.des_cadena);
                        if v_inter.cod_retorno <> 0 then
                                raise EXCEPTION_ERROR;
                        end if;
                        p_genera_cabecera (v_cabguia,v_inter.cod_retorno,v_inter.des_cadena);
                        if v_inter.cod_retorno <> 0 then
                                raise EXCEPTION_ERROR;
                        end if;
                        v_linguia.num_guia := v_cabguia.num_guia;
                        v_cabecera := 1;
                else
--------------------------------------------------------------------
-- Se realizara cambio de pagina si se realizara el salto de linea
-- Si no hay detalle siempre se salta de linea. Si hay detalle
-- se produce el cambio de linea si cambia el articulo o el valor.
--------------------------------------------------------------------
                        if v_detalle = 0 or v_peticion.cod_articulo <>nvl(v_linguia.cod_articulo,0)
                        or nvl(v_val0, -1) <> v_peticion.val_linea then
                                      v_linguia.lin_guia := 1;
                                v_contador := v_contador + 1;
                                p_select_numguia(v_cabguia.num_guia,v_cabguia.fec_guia,
                                                 v_inter.cod_retorno,v_inter.des_cadena);
                                if v_inter.cod_retorno <> 0 then
                                        raise EXCEPTION_ERROR;
                                 end if;
                                p_genera_cabecera (v_cabguia,v_inter.cod_retorno,
                                                   v_inter.des_cadena);
                                if v_inter.cod_retorno <> 0 then
                                        raise EXCEPTION_ERROR;
                                end if;
                                   v_linguia.num_guia := v_cabguia.num_guia;
                        end if;
                end if;
        end if;
        if v_peticion.cod_moneda <> v_peso then
                al_pac_validaciones.p_convertir_precio(v_peticion.cod_moneda,v_peso,
                                                       v_peticion.val_linea,v_peticion.val_linea,
                                                       sysdate);
        end if;
        if v_detalle = 1 then
  ------------------------------------------------------------------
  -- Se debe cambiar de linea tanto si cambiamos de articulo como --
  -- si cambiamos de precio unitario. Para detectar esto creo la  --
  -- variable v_val0 en la que llevo el precio unitario.     --
  ------------------------------------------------------------------
                if nvl(v_linguia.cod_articulo ,0) <> v_peticion.cod_articulo
                or nvl(v_val0, -1) <> v_peticion.val_linea then
     -- JLV 04-99 Modificado el calculo del precio para que muestre lo mismo
     -- que el presupuesto
                        v_val0 := v_peticion.val_linea;
                        -- v_vallinea := round(v_peticion.val_linea
                        -- + ((v_peticion.val_linea * v_pctiva ) / 100),v_decim);
                        --
                        select tip_dto,NVL(val_dto,0) into v_tipdto,v_valdto from ge_cargos
                        where num_cargo = v_peticion.num_cargo;
                        if v_tipdto is null then -- sin descuento
   v_vallinea := round(
                           v_peticion.val_linea +
                           ((v_peticion.val_linea * v_pctiva ) / 100)
                           ,v_decim);
                        elsif v_tipdto=0 then -- monto
                           v_vallinea := round(
                           (v_peticion.val_linea - v_valdto) +
                           (((v_peticion.val_linea - v_valdto) * v_pctiva)/100)
                           ,v_decim);
                               elsif v_tipdto=1 then -- porcentaje
                           v_vallinea := round(
                           (v_peticion.val_linea - ((v_peticion.val_linea * v_valdto)/100)) +
                           (((v_peticion.val_linea - ((v_peticion.val_linea * v_valdto)/100)) * v_pctiva)/100)
                           ,v_decim);
                        end if ;
                        --
if v_inter.cod_retorno <> 0 then
                                       raise EXCEPTION_ERROR;
                        end if;
                        v_linguia.cod_articulo  := v_peticion.cod_articulo;
                        v_linguia.can_articulo  := v_peticion.num_cantidad;
                        v_linguia.num_serie     := null;
                        v_linguia.num_telefono  := null;
                        v_linguia.cod_moneda    := v_peticion.cod_moneda;
                        v_linguia.val_articulo  := v_peticion.num_cantidad * v_vallinea;
                        v_linguia.num_cargo     := null;
                        p_select_articulo(v_linguia.cod_articulo,v_linguia.des_articulo,
                                          v_inter.cod_retorno,v_inter.des_cadena);
                        if v_inter.cod_retorno <> 0 then
                                raise EXCEPTION_ERROR;
                        end if;
                        p_genera_linea(v_linguia,v_inter.cod_retorno,v_inter.des_cadena);
                        if v_inter.cod_retorno <> 0 then
                                raise EXCEPTION_ERROR;
                        end if;
                else
                        p_updatea_linea(v_linguia.num_guia,v_linguia.lin_guia,
                        v_vallinea * v_peticion.num_cantidad,
                        v_peticion.num_cantidad,v_inter.cod_retorno,v_inter.des_cadena);
                        if v_inter.cod_retorno <> 0 then
                                raise EXCEPTION_ERROR;
                        end if;
                end if;
-- G.R. 19-12 para que si no hay serie no inserte (aunque pidan detalle)
                if v_peticion.num_serie is not null then
-- solo en ese caso se hace el insert en al_ser_guias
                        v_serguia.num_guia  := v_linguia.num_guia;
                        v_serguia.lin_guia  := v_linguia.lin_guia;
-- 18-12 G.R. tomo los valores de v_peticion pues v_linguia no posee valores
                           v_serguia.num_serie := v_peticion.num_serie;
                        v_serguia.num_telefono := v_peticion.num_telefono;
                        v_serguia.num_cargo := v_peticion.num_cargo;
                        p_genera_serguia (v_serguia,v_inter.cod_retorno,v_inter.des_cadena);
                        if v_inter.cod_retorno <> 0 then
                                raise EXCEPTION_ERROR;
                        end if;
                end if;
-- end if; G.R. quitado y puesto antes, del insert en al_lin_guias ...
        else
-- SGC duplica el calculo v_peticion.val_linea :=
-- v_peticion.num_cantidad * v_peticion.val_linea;
     -- JLV 04-99 Modificado el calculo del precio para que muestre lo mismo
     -- que el presupuesto
                select tip_dto,NVL(val_dto,0) into v_tipdto,v_valdto from ge_cargos
                where num_cargo = v_peticion.num_cargo;
                if v_tipdto is null then -- sin descuento
                   v_vallinea := round(
                   v_peticion.val_linea +
                   ((v_peticion.val_linea * v_pctiva ) / 100)
                   ,v_decim);
                elsif v_tipdto=0 then -- monto
                   v_vallinea := round(
                   (v_peticion.val_linea - v_valdto) +
                   (((v_peticion.val_linea - v_valdto) * v_pctiva)/100)
                   ,v_decim);
                elsif v_tipdto=1 then -- porcentaje
                   v_vallinea := round(
                   (v_peticion.val_linea - ((v_peticion.val_linea * v_valdto)/100)) +
                   (((v_peticion.val_linea - ((v_peticion.val_linea * v_valdto)/100)) * v_pctiva)/100)
                   ,v_decim);
                end if ;
                v_peticion.val_linea := v_vallinea;
                v_peticion.val_linea := v_peticion.num_cantidad *
                v_peticion.val_linea;
                v_linguia.cod_articulo  := v_peticion.cod_articulo;
                v_linguia.can_articulo  := v_peticion.num_cantidad;
                v_linguia.num_serie     := v_peticion.num_serie;
                v_linguia.num_telefono  := v_peticion.num_telefono;
                v_linguia.cod_moneda    := v_peticion.cod_moneda;
                v_linguia.val_articulo  := v_peticion.val_linea;
                v_linguia.num_cargo     := v_peticion.num_cargo;
                p_select_articulo(v_linguia.cod_articulo,v_linguia.des_articulo,
                                  v_inter.cod_retorno,v_inter.des_cadena);
                if v_inter.cod_retorno <> 0 then
                        raise EXCEPTION_ERROR;
                end if;
                p_genera_linea(v_linguia,v_inter.cod_retorno,v_inter.des_cadena);
                if v_inter.cod_retorno <> 0 then
                         raise EXCEPTION_ERROR;
                end if;
        end if;
        p_actualiza_cargo(v_peticion.num_cargo,v_cabguia.num_guia,
                          v_inter.cod_retorno,v_inter.des_cadena);
        if v_inter.cod_retorno <> 0 then
                raise EXCEPTION_ERROR;
        end if;
        delete al_petiguias_abo where current of c_peticion;
end LOOP;
end if;
if v_inter.cod_retorno = 0 then
        v_inter.des_cadena := '/' || to_char(v_contador) || '/';
end if;
p_insert_interguias(v_inter);
EXCEPTION
        when EXCEPTION_ERROR then
        if c_peticion%ISOPEN then
                close c_peticion;
        end if;
        p_insert_interguias(v_inter);
        when OTHERS then
        if c_peticion%ISOPEN then
                close c_peticion;
        end if;
        v_inter.cod_retorno := 1;
        if SQLCODE = -20185 then
        v_inter.des_cadena := '/Error Obtencion Decimales Moneda/';
        elsif SQLCODE = -20147 then
                v_inter.des_cadena := '/Error Conversion Precio/';
        else
                v_inter.des_cadena  := '/Error Anulacion Peticion de Guia/ ';
        end if;
        p_insert_interguias (v_inter);
END p_genera_guias;
  --
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
  PROCEDURE p_carga_cabecera(
  v_num_peticion IN al_petiguias_abo.num_peticion%type ,
  v_cabguia IN OUT al_cab_guias%rowtype ,
  v_oficina IN OUT al_petiguias_abo.cod_oficina%type ,
  v_concepto IN OUT al_petiguias_abo.cod_concepto%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
              v_tipident       ge_clientes.cod_tipident%type;
              v_numident       ge_clientes.num_ident%type;
              v_actividad      ge_clientes.cod_actividad%type;
              v_tiprut         ge_clientes.cod_tipident%type;
              v_direccion      ge_direcciones.cod_direccion%type;
              v_region         ge_direcciones.cod_region%type;
              v_provincia      ge_direcciones.cod_provincia%type;
              v_ciudad         ge_direcciones.cod_ciudad%type;
              v_bodega         al_petiguias_abo.cod_bodega%type;
            BEGIN
              select cod_bodega,cod_cliente,num_venta,cod_oficina,cod_concepto
                into v_bodega,v_cabguia.cod_cliente,v_cabguia.num_venta,v_oficina
  ,
                     v_concepto
                from al_petiguias_abo
               where num_peticion = v_num_peticion
                 and rownum       = 1;
              v_cabguia.cod_estado      := 'NU';
              p_select_des_bodega(v_bodega,
                                  v_cabguia.des_bodega_ori,
                                  v_error,
                                  v_mensa);
              if v_error <> 0 then
                 raise EXCEPTION_ERROR;
              end if;
              p_select_cliente (v_cabguia.cod_cliente,
                                v_cabguia.nom_destinatario,
                                v_tipident,
                                v_numident,
                                v_actividad,
                                v_cabguia.num_telefono,
                                v_cabguia.num_fax,
                                v_error,
                                v_mensa);
              if v_error <> 0 then
                 raise EXCEPTION_ERROR;
              end if;
              p_obtiene_tiporut (v_tiprut,
                                 v_error,
                                 v_mensa);
              if v_error <> 0 then
                 raise EXCEPTION_ERROR;
              end if;
              if v_tipident = v_tiprut then
                 v_cabguia.num_ident := v_numident;
              else
                 v_cabguia.num_ident := null;
              end if;
              if v_actividad is not null then
                 p_select_giro (v_actividad,
                                v_cabguia.des_actividad,
                                v_error,
                                v_mensa);
                 if v_error <> 0 then
                    raise EXCEPTION_ERROR;
                 end if;
              end if;
              p_obtiene_direccion (v_cabguia.cod_cliente,
                                   v_direccion,
                                   v_error,
                                   v_mensa);
              if v_error <> 0 then
                 raise EXCEPTION_ERROR;
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
            EXCEPTION
              when EXCEPTION_ERROR then
                   null;
            END p_carga_cabecera;
  --
  PROCEDURE p_genera_linea(
  v_linguia IN al_lin_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
               insert into al_lin_guias (num_guia,
                                         lin_guia,
                                         cod_articulo,
                                         des_articulo,
                                         can_articulo,
                                         num_serie,
             num_telefono,
                                         cod_moneda,
                                         val_articulo,
                                         num_cargo)
                                 values (v_linguia.num_guia,
                                         v_linguia.lin_guia,
                                         v_linguia.cod_articulo,
                                         v_linguia.des_articulo,
                                         v_linguia.can_articulo,
                                         v_linguia.num_serie,
             v_linguia.num_telefono,
                                         v_linguia.cod_moneda,
                                         v_linguia.val_articulo,
                                         v_linguia.num_cargo);
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error al Generar Lineas Guias/';
            END p_genera_linea;
  --
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
  PROCEDURE p_select_rut(
  v_rut IN OUT al_cab_guias.num_ident%type )
  IS
            BEGIN
               select num_ident into v_rut
                      from ge_datosgener;
            EXCEPTION
               when OTHERS then
                     raise_application_error(-20157,'Error Lectura RUT'
                                             || to_char(SQLCODE));
            END p_select_rut;
  --
  PROCEDURE p_select_cliente(
  v_cliente IN ge_clientes.cod_cliente%type ,
  v_nombre IN OUT ge_clientes.nom_cliente%type ,
  v_tipident IN OUT ge_clientes.cod_tipident%type ,
  v_numident IN OUT ge_clientes.num_ident%type ,
  v_actividad IN OUT ge_clientes.cod_actividad%type ,
  v_telefono IN OUT ge_clientes.tef_cliente1%type ,
  v_fax IN OUT ge_clientes.num_fax%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
            -- 22-12 G.R. a?adido apellidos
            -- como al_cab_guias.nom_destinatario es varchar2(40)
            --, trunco a eso para evitar errores
                 select substr(nom_cliente ||' '||
                nom_apeclien1 ||' '|| nom_apeclien2, 1, 40),
                 cod_tipident,num_ident,cod_actividad,
                      tef_cliente1,num_fax
                 into v_nombre,v_tipident,v_numident,v_actividad,
                      v_telefono,v_fax
                 from ge_clientes
                where cod_cliente = v_cliente;
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error Lectura Cliente/';
            END p_select_cliente;
  --
  PROCEDURE p_obtiene_tiporut(
  v_tiprut IN OUT ga_datosgener.cod_tipid_num_ident%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
               select cod_tipid_num_ident into v_tiprut
                      from ga_datosgener;
            EXCEPTION
              when OTHERS then
                   v_error := 1;
                   v_mensa := '/Error Obtencion Tipo identificacion = RUT/';
            END p_obtiene_tiporut;
  --
  PROCEDURE p_select_giro(
  v_actividad IN ge_actividades.cod_actividad%type ,
  v_giro IN OUT ge_actividades.des_actividad%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
                select des_actividad
                  into v_giro
                  from ge_actividades
                 where cod_actividad = v_actividad;
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error Obtencion Giro/';
            END p_select_giro;
  --
  PROCEDURE p_obtiene_direccion(
  v_cliente IN ge_clientes.cod_cliente%type ,
  v_direccion IN OUT ge_direcciones.cod_direccion%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
               select cod_direccion
                 into v_direccion
                 from ga_direccli
                where cod_cliente = v_cliente
                  and cod_tipdireccion = 2;
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error Obtencion Direccion Cliente/';
            END p_obtiene_direccion;
  --
  PROCEDURE p_select_articulo(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_desc IN OUT al_articulos.des_articulo%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
               select des_articulo
                 into v_desc
                 from al_articulos
                where cod_articulo = v_articulo;
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error Lectura Articulo/';
            END p_select_articulo;
  --
  PROCEDURE p_actualiza_cargo(
  v_cargo IN ge_cargos.num_cargo%type ,
  v_guia IN al_cab_guias.num_guia%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
               update ge_cargos
                  set num_preguia = v_guia
                where num_cargo = v_cargo;
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error Actualizacion Cargo/';
            END p_actualiza_cargo;
  --
  PROCEDURE p_select_des_bodega(
  v_bodega IN al_bodegas.cod_bodega%type ,
  v_descr IN OUT al_bodegas.des_bodega%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
               select des_bodega
                 into v_descr
                 from al_bodegas
                where cod_bodega = v_bodega;
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error Obtencion Descripcion Bodega/';
            END p_select_des_bodega;
  --
  PROCEDURE p_select_numguia(
  v_guia IN OUT al_cab_guias.num_guia%type ,
  v_fecha IN OUT al_cab_guias.fec_guia%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
              select al_seq_guias.nextval,sysdate
                into v_guia,v_fecha
                from al_datos_generales;
            EXCEPTION
              when OTHERS then
                   v_error := 1;
                   v_mensa := '/Error Obtencion No.Guia/';
            END p_select_numguia;
  --
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
                    raise_application_error (-20177,'Error Insert en INTERGUIAS
  ');
            END p_insert_interguias;
  --
  PROCEDURE p_obtiene_peso_iva(
  v_peso IN OUT fa_datosgener.cod_peso%type ,
  v_iva IN OUT fa_datosgener.cod_iva%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
               select cod_iva,cod_peso
                 into v_iva,v_peso
                 from fa_datosgener;
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error Obtencion Peso e Iva/';
            END p_obtiene_peso_iva;
  --
  PROCEDURE p_obtiene_iva(
  v_cliente IN ge_clientes.cod_cliente%type ,
  v_oficina IN ge_oficinas.cod_oficina%type ,
  v_concepto IN fa_conceptos.cod_concepto%type ,
  v_iva IN fa_datosgener.cod_iva%type ,
  v_impuesto IN OUT ge_impuestos.prc_impuesto%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
              v_catimpos  ge_impuestos.cod_catimpos%type;
              v_zonaimpo  ge_impuestos.cod_zonaimpo%type;
              v_grpservi  ge_impuestos.cod_grpservi%type;
              v_region    ge_direcciones.cod_region%type;
              v_provincia ge_direcciones.cod_provincia%type;
              v_ciudad    ge_direcciones.cod_ciudad%type;
            BEGIN
              p_obtiene_grpservi(v_concepto,
                                 v_grpservi,
                                 v_error,
                                 v_mensa);
              if v_error <> 0 then
                 raise EXCEPTION_ERROR;
              end if;
              p_obtiene_oficina (v_oficina,
                                 v_region,
                                 v_provincia,
                                 v_ciudad,
                                 v_error,
                                 v_mensa);
              if v_error <> 0 then
                 raise EXCEPTION_ERROR;
              end if;
              p_obtiene_zonaimpo (v_region,
                                  v_provincia,
                                  v_ciudad,
                                  v_zonaimpo,
                                  v_error,
                                  v_mensa);
              if v_error <> 0 then
                 raise EXCEPTION_ERROR;
              end if;
              p_obtiene_catimpos (v_cliente,
                                  v_catimpos,
                                  v_error,
                                  v_mensa);
              if v_error <> 0 then
                 raise EXCEPTION_ERROR;
              end if;
              p_obtiene_pct (v_catimpos,
                             v_zonaimpo,
                             v_iva,
                             v_grpservi,
                             v_impuesto,
                             v_error,
                             v_mensa);
            EXCEPTION
               when EXCEPTION_ERROR then
                    null;
            END p_obtiene_iva;
  --
  PROCEDURE p_obtiene_grpservi(
  v_concepto IN fa_grpserconc.cod_concepto%type ,
  v_grpservi IN OUT fa_grpserconc.cod_grpservi%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
               select cod_grpservi into v_grpservi
                 from fa_grpserconc
                where cod_concepto =  v_concepto
                  and fec_desde    <= sysdate
                  and fec_hasta    >= sysdate;
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error Obtencion Grupo de Servicio/';
            END p_obtiene_grpservi;
  --
  PROCEDURE p_obtiene_oficina(
  v_oficina IN ge_oficinas.cod_oficina%type ,
  v_region IN OUT ge_direcciones.cod_region%type ,
  v_provincia IN OUT ge_direcciones.cod_provincia%type ,
  v_ciudad IN OUT ge_direcciones.cod_ciudad%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
               v_direccion  ge_oficinas.cod_direccion%type;
               v_desdirec   al_cab_guias.des_direccion%type;
            BEGIN
               select cod_direccion
                 into v_direccion
                 from ge_oficinas
                where cod_oficina = v_oficina;
                p_select_direccion (v_direccion,
                                    v_desdirec,
                                    v_region,
                                    v_provincia,
                                    v_ciudad,
                                    v_error,
                                    v_mensa);
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error Obtencion Zona Oficina/';
            END p_obtiene_oficina;
  --
  PROCEDURE p_obtiene_zonaimpo(
  v_region IN ge_zonaciudad.cod_region%type ,
  v_provincia IN ge_zonaciudad.cod_provincia%type ,
  v_ciudad IN ge_zonaciudad.cod_ciudad%type ,
  v_zonaimpo IN OUT ge_zonaciudad.cod_zonaimpo%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
               select cod_zonaimpo into v_zonaimpo
                 from ge_zonaciudad
                where cod_region    =  v_region
                  and cod_provincia =  v_provincia
                  and cod_ciudad    =  v_ciudad
                  and fec_desde     <= sysdate
                  and fec_hasta     >= sysdate;
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error Obtencion Zona Impositiva/';
            END p_obtiene_zonaimpo;
  --
  PROCEDURE p_obtiene_catimpos(
  v_cliente IN ge_catimpclientes.cod_cliente%type ,
  v_catimpos IN OUT ge_catimpclientes.cod_catimpos%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
               select cod_catimpos into v_catimpos
                 from ge_catimpclientes
                where cod_cliente =  v_cliente
                  and fec_desde   <= sysdate
                  and fec_hasta   >= sysdate;
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error Obtencion Categoria Impositiva Cliente/
  ' ||
                               to_char(SQLCODE);
            END p_obtiene_catimpos;
  --
  PROCEDURE p_obtiene_pct(
  v_catimpos IN ge_impuestos.cod_catimpos%type ,
  v_zonaimpo IN ge_impuestos.cod_zonaimpo%type ,
  v_iva IN ge_impuestos.cod_tipimpues%type ,
  v_grpservi IN ge_impuestos.cod_grpservi%type ,
  v_impuesto IN OUT ge_impuestos.prc_impuesto%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
               select prc_impuesto into v_impuesto
                 from ge_impuestos
                where cod_catimpos  =  v_catimpos
                  and cod_zonaimpo  =  v_zonaimpo
                  and cod_tipimpues =  v_iva
                  and cod_grpservi  =  v_grpservi
                  and fec_desde     <= sysdate
                  and fec_hasta     >= sysdate;
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error Obtencion % IVA/';
            END p_obtiene_pct;
  --
  PROCEDURE p_genera_serguia(
  v_serguia IN al_ser_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
            BEGIN
               insert into al_ser_guias (num_guia,
                                         lin_guia,
                                         num_serie,
             num_telefono,
                                         num_cargo)
                                 values (v_serguia.num_guia,
                                         v_serguia.lin_guia,
                                         v_serguia.num_serie,
             v_serguia.num_telefono,
                                         v_serguia.num_cargo);
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error Generacion Detalle de Series/';
            END p_genera_serguia;
  --
  PROCEDURE p_updatea_linea(
  v_guia IN al_lin_guias.num_guia%type ,
  v_linea IN al_lin_guias.lin_guia%type ,
  v_val_articulo IN al_lin_guias.val_articulo%type ,
  v_cantidad IN al_lin_guias.can_articulo%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
  IS
        BEGIN
         update al_lin_guias set
           can_articulo = can_articulo + v_cantidad
          ,val_articulo = val_articulo + v_val_articulo
         where num_guia  = v_guia
           and lin_guia  = v_linea;
            EXCEPTION
               when OTHERS then
                    v_error := 1;
                    v_mensa := '/Error Actualizacion de cantidad/';
        END p_updatea_linea;
END AL_PAC_GUIAS_ABO;
/
SHOW ERRORS
