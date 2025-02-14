/* Formatted on 2009/06/19 11:58 (Formatter Plus v4.8.8) */
CREATE OR REPLACE FORCE VIEW sp_vcomprobante_orden (cod_cliente,
                                                                     cod_idioma,
                                                                     num_orden,
                                                                     des_sucursal,
                                                                     nom_cliente,
                                                                     num_ident,
                                                                     des_direccion,
                                                                     num_telefono,
                                                                     num_fax,
                                                                     des_diagnostico,
                                                                     nom_cliente_aut,
                                                                     num_ident_aut,
                                                                     des_direccion_aut,
                                                                     num_telefono_aut,
                                                                     num_fax_aut,
                                                                     des_producto,
                                                                     ind_garantia,
                                                                     des_articulo,
                                                                     cod_modelo,
                                                                     num_serie,
                                                                     num_serie_hex,
                                                                     num_abonado,
                                                                     des_tarea,
                                                                     imp_monto_fijo,
                                                                     des_moneda_fijo,
                                                                     des_articulo_reem,
                                                                     cod_modelo_reem,
                                                                     num_serie_reem,
                                                                     num_serie_reem_hex,
                                                                     num_dias_suspension,
                                                                     num_dias_cargo,
                                                                     num_dias_autoriz_venta,
                                                                     num_dias_rechazo_ppto,
                                                                     des_moneda_rech,
                                                                     imp_rechazo_ppto,
                                                                     nom_contacto,
                                                                     fec_alta,
                                                                     celular,
                                                                     prc_nivel,
                                                                     cod_region,
                                                                     cod_ciudad,
                                                                     cod_comuna,
                                                                     usu_alta,
                                                                     cod_bodega,
                                                                     observacion,
                                                                     chequeos,
                                                                     des_valor,
                                                                     tipotarea,
                                                                     averias,
                                                                     tipo_cliente
                                                                    )
AS
   SELECT c.cod_cliente cod_cliente, c.cod_idioma cod_idioma,
          a.num_orden num_orden, b.des_oficina des_sucursal,
             c.nom_cliente
          || ' '
          || c.nom_apeclien1
          || ' '
          || c.nom_apeclien2 nom_cliente,
          c.num_ident num_ident,
          st_procesos_pg.st_dir_cliente_fn (c.cod_cliente,
                                            1,
                                            2,
                                            1
                                           ) des_direccion,
          c.tef_cliente1 num_telefono, c.num_fax num_fax,
          a.des_diagnostico des_diagnostico,
             a.nom_autorizado
          || ' '
          || a.ape_autorizado1
          || ' '
          || a.ape_autorizado2 nom_cliente_aut,
          a.num_ident_aut num_ident_aut,
          DECODE
             (a.cod_direccion_aut,
              NULL, ' ',
              st_procesos_pg.st_dir_cliente_fn (a.num_orden, 9, 0, 1)
             ) des_direccion_aut,
          a.num_telef_aut num_telefono_aut, a.num_fax_aut num_fax_aut,
          g.des_producto des_producto, a.ind_garantia ind_garantia,
          h.des_articulo des_articulo, h.cod_modelo cod_modelo,
          a.num_serie num_serie,
             dectohex (SUBSTR (a.num_serie, 1, 3))
          || LPAD (dectohex (SUBSTR (a.num_serie, 4, 8)), 6, '0')
                                                                num_serie_hex,
          a.num_abonado num_abonado, i.des_tarea des_tarea,
          a.imp_monto_fijo imp_monto_fijo, j.des_moneda des_moneda_fijo,
          k.des_articulo des_articulo_reem, k.cod_modelo cod_modelo_reem,
          a.num_serie_reem num_serie_reem,
             dectohex (SUBSTR (a.num_serie_reem, 1, 3))
          || LPAD (dectohex (SUBSTR (a.num_serie_reem, 4, 8)), 6, '0')
                                                           num_serie_reem_hex,
          l.num_dias_suspension num_dias_suspension,
          l.num_dias_cargo num_dias_cargo,
          l.num_dias_autoriz_venta num_dias_autoriz_venta,
          l.num_dias_rechazo_ppto num_dias_rechazo_ppto,
          n.des_moneda des_moneda_rech, m.imp_rechazo_ppto imp_rechazo_ppto,
          b.nom_contacto nom_contacto,
          TO_CHAR (a.fec_alta, sp_fn_formatofecha ('FORMATO_SEL2')) fec_alta,
          a.num_telefono celular,
--          sp_fn_formato_numero
--                     (ge_fn_conversion_moneda (a.prc_nivel,
--                                               a.cod_moneda_nivel,
--                                               fa_fn_codmonfact,
--                                               a.fec_alta
--                                              ),
--                      sp_fn_getdecimal (1, fa_fn_codmonfact)
--                     ) prc_nivel,
                                 a.prc_nivel, e.cod_region cod_region,
          e.cod_ciudad cod_ciudad, e.cod_comuna cod_comuna,
          a.usu_alta usu_alta, a.cod_bodega,
          sp_averias_fn (a.num_orden) observacion,
          st_procesos_pg.st_chequeos_orden_fn (a.num_orden) chequeos,
          ge.des_valor,
          DECODE (i.ind_tipotarea,
                  'E', 'Externo',
                  'I', 'Interno',
                  'C', 'Compatibilidad'
                 ) tipotarea,
          st_procesos_pg.st_averias_orden_fn (a.num_orden) averias,
          'I' tipo_cliente
     FROM ge_oficinas b,
          ge_clientes c,
          ge_direcciones e,
          ga_direccli z,
          ge_direcciones f,
          ge_productos g,
          al_articulos h,
          sp_tareas i,
          ge_monedas j,
          al_articulos k,
          sp_datos_productos l,
          sp_productos_taller m,
          ge_monedas n,
          ged_codigos ge,
          sp_ordenes_reparacion a
    WHERE b.cod_oficina = a.cod_oficina
      AND c.cod_cliente = a.cod_cliente
      AND z.cod_cliente = c.cod_cliente
      AND z.cod_tipdireccion = 2                                   -- PRESONAL
      AND e.cod_direccion = z.cod_direccion
      AND f.cod_direccion(+) = a.cod_direccion_aut
      AND g.cod_producto = a.cod_producto
      AND h.cod_articulo = a.cod_articulo
      AND i.cod_tarea = a.cod_tarea
      AND j.cod_moneda = a.cod_moneda
      AND k.cod_articulo(+) = a.cod_articulo_reem
      AND l.cod_producto = a.cod_producto
      AND m.cod_taller(+) = a.cod_taller
      AND m.cod_producto(+) = a.cod_producto
      AND n.cod_moneda(+) = m.cod_moneda_imp
      AND i.cod_tarea(+) = a.cod_tarea
      AND ge.cod_modulo = 'ST'
      AND ge.nom_tabla = 'SP_TAREAS'
      AND ge.nom_columna = 'IND_TIPOTAREA'
      AND ge.cod_valor(+) = i.ind_tipotarea
   UNION
   SELECT c.cod_cliente cod_cliente, c.cod_idioma cod_idioma,
          a.num_orden num_orden, b.des_oficina des_sucursal,
             c.nom_cliente
          || ' '
          || c.nom_apeclien1
          || ' '
          || c.nom_apeclien2 nom_cliente,
          c.num_ident num_ident,
          st_procesos_pg.st_dir_cliente_fn (c.cod_cliente,
                                            1,
                                            2,
                                            1
                                           ) des_direccion,
          c.tef_cliente1 num_telefono, c.num_fax num_fax,
          a.des_diagnostico des_diagnostico,
             a.nom_autorizado
          || ' '
          || a.ape_autorizado1
          || ' '
          || a.ape_autorizado2 nom_cliente_aut,
          a.num_ident_aut num_ident_aut,
          DECODE
             (a.cod_direccion_aut,
              NULL, ' ',
              st_procesos_pg.st_dir_cliente_fn (a.num_orden, 9, 0, 1)
             ) des_direccion_aut,
          a.num_telef_aut num_telefono_aut, a.num_fax_aut num_fax_aut,
          g.des_producto des_producto, a.ind_garantia ind_garantia,
          h.des_articulo des_articulo, h.cod_modelo cod_modelo,
          a.num_serie num_serie,
             dectohex (SUBSTR (a.num_serie, 1, 3))
          || LPAD (dectohex (SUBSTR (a.num_serie, 4, 8)), 6, '0')
                                                                num_serie_hex,
          a.num_abonado num_abonado, i.des_tarea des_tarea,
          a.imp_monto_fijo imp_monto_fijo, j.des_moneda des_moneda_fijo,
          k.des_articulo des_articulo_reem, k.cod_modelo cod_modelo_reem,
          a.num_serie_reem num_serie_reem,
             dectohex (SUBSTR (a.num_serie_reem, 1, 3))
          || LPAD (dectohex (SUBSTR (a.num_serie_reem, 4, 8)), 6, '0')
                                                           num_serie_reem_hex,
          l.num_dias_suspension num_dias_suspension,
          l.num_dias_cargo num_dias_cargo,
          l.num_dias_autoriz_venta num_dias_autoriz_venta,
          l.num_dias_rechazo_ppto num_dias_rechazo_ppto,
          n.des_moneda des_moneda_rech, m.imp_rechazo_ppto imp_rechazo_ppto,
          b.nom_contacto nom_contacto,
          TO_CHAR (a.fec_alta, sp_fn_formatofecha ('FORMATO_SEL2')) fec_alta,
          a.num_telefono celular,
--          sp_fn_formato_numero
--                     (ge_fn_conversion_moneda (a.prc_nivel,
--                                               a.cod_moneda_nivel,
--                                               fa_fn_codmonfact,
--                                               a.fec_alta
--                                              ),
--                      sp_fn_getdecimal (1, fa_fn_codmonfact)
--                     ) prc_nivel,
                                 a.prc_nivel, e.cod_region cod_region,
          e.cod_ciudad cod_ciudad, e.cod_comuna cod_comuna,
          a.usu_alta usu_alta, a.cod_bodega,
          sp_averias_fn (a.num_orden) observacion,
          st_procesos_pg.st_chequeos_orden_fn (a.num_orden) chequeos,
          ge.des_valor,
          DECODE (i.ind_tipotarea,
                  'E', 'Externo',
                  'I', 'Interno',
                  'C', 'Compatibilidad'
                 ) tipotarea,
          st_procesos_pg.st_averias_orden_fn (a.num_orden) averias,
          'I' tipo_cliente
     FROM ge_oficinas b,
          ge_clientes c,
          ge_direcciones e,
          ga_direccli z,
          ge_direcciones f,
          ge_productos g,
          al_articulos h,
          sp_tareas i,
          ge_monedas j,
          al_articulos k,
          sp_datos_productos l,
          sp_productos_taller m,
          ge_monedas n,
          ged_codigos ge,
          sp_hordenes_reparacion a
    WHERE b.cod_oficina = a.cod_oficina
      AND c.cod_cliente = a.cod_cliente
      AND z.cod_cliente = c.cod_cliente
      AND z.cod_tipdireccion = 2                                   -- PRESONAL
      AND e.cod_direccion = z.cod_direccion
      AND f.cod_direccion(+) = a.cod_direccion_aut
      AND g.cod_producto = a.cod_producto
      AND h.cod_articulo = a.cod_articulo
      AND i.cod_tarea = a.cod_tarea
      AND j.cod_moneda = a.cod_moneda
      AND k.cod_articulo(+) = a.cod_articulo_reem
      AND l.cod_producto = a.cod_producto
      AND m.cod_taller(+) = a.cod_taller
      AND m.cod_producto(+) = a.cod_producto
      AND n.cod_moneda(+) = m.cod_moneda_imp
      AND i.cod_tarea(+) = a.cod_tarea
      AND ge.cod_modulo = 'ST'
      AND ge.nom_tabla = 'SP_TAREAS'
      AND ge.nom_columna = 'IND_TIPOTAREA'
      AND ge.cod_valor(+) = i.ind_tipotarea
   UNION
   SELECT ju.cod_cliente cod_cliente, '1' cod_idioma, a.num_orden num_orden,
          b.des_oficina des_sucursal,
             ju.nom_cliente
          || ' '
          || ju.nom_apeclien1
          || ' '
          || ju.nom_apeclien2 nom_cliente,
          ju.num_ident num_ident, NULL des_direccion,
          ju.tel_contacto num_telefono, NULL num_fax,
          a.des_diagnostico des_diagnostico,
             a.nom_autorizado
          || ' '
          || a.ape_autorizado1
          || ' '
          || a.ape_autorizado2 nom_cliente_aut,
          a.num_ident_aut num_ident_aut,
          DECODE
             (a.cod_direccion_aut,
              NULL, ' ',
              st_procesos_pg.st_dir_cliente_fn (a.num_orden, 9, 0, 1)
             ) des_direccion_aut,
          a.num_telef_aut num_telefono_aut, a.num_fax_aut num_fax_aut,
          g.des_producto des_producto, a.ind_garantia ind_garantia,
          h.des_articulo des_articulo, h.cod_modelo cod_modelo,
          a.num_serie num_serie,
             dectohex (SUBSTR (a.num_serie, 1, 3))
          || LPAD (dectohex (SUBSTR (a.num_serie, 4, 8)), 6, '0')
                                                                num_serie_hex,
          a.num_abonado num_abonado, i.des_tarea des_tarea,
          a.imp_monto_fijo imp_monto_fijo, j.des_moneda des_moneda_fijo,
          k.des_articulo des_articulo_reem, k.cod_modelo cod_modelo_reem,
          a.num_serie_reem num_serie_reem,
             dectohex (SUBSTR (a.num_serie_reem, 1, 3))
          || LPAD (dectohex (SUBSTR (a.num_serie_reem, 4, 8)), 6, '0')
                                                           num_serie_reem_hex,
          l.num_dias_suspension num_dias_suspension,
          l.num_dias_cargo num_dias_cargo,
          l.num_dias_autoriz_venta num_dias_autoriz_venta,
          l.num_dias_rechazo_ppto num_dias_rechazo_ppto,
          n.des_moneda des_moneda_rech, m.imp_rechazo_ppto imp_rechazo_ppto,
          b.nom_contacto nom_contacto,
          TO_CHAR (a.fec_alta, sp_fn_formatofecha ('FORMATO_SEL2')) fec_alta,
          a.num_telefono celular, a.prc_nivel, NULL cod_region,
          NULL cod_ciudad, NULL cod_comuna, a.usu_alta usu_alta, a.cod_bodega,
          sp_averias_fn (a.num_orden) observacion,
          st_procesos_pg.st_chequeos_orden_fn (a.num_orden) chequeos,
          ge.des_valor,
          DECODE (i.ind_tipotarea,
                  'E', 'Externo',
                  'I', 'Interno',
                  'C', 'Compatibilidad'
                 ) tipotarea,
          st_procesos_pg.st_averias_orden_fn (a.num_orden) averias,
          'E' tipo_cliente
     FROM ge_oficinas b,
          sp_cliente_externo_to ju,
          ge_direcciones f,
          ge_productos g,
          al_articulos h,
          sp_tareas i,
          ge_monedas j,
          al_articulos k,
          sp_datos_productos l,
          sp_productos_taller m,
          ge_monedas n,
          ged_codigos ge,
          sp_ordenes_reparacion a
    WHERE b.cod_oficina = a.cod_oficina
      AND ju.cod_cliente = a.cod_cliente
      AND f.cod_direccion(+) = a.cod_direccion_aut
      AND g.cod_producto = a.cod_producto
      AND h.cod_articulo = a.cod_articulo
      AND i.cod_tarea = a.cod_tarea
      AND j.cod_moneda = a.cod_moneda
      AND k.cod_articulo(+) = a.cod_articulo_reem
      AND l.cod_producto = a.cod_producto
      AND m.cod_taller(+) = a.cod_taller
      AND m.cod_producto(+) = a.cod_producto
      AND n.cod_moneda(+) = m.cod_moneda_imp
      AND i.cod_tarea(+) = a.cod_tarea
      AND i.ind_tipotarea = 'C'
      AND ge.cod_modulo = 'ST'
      AND ge.nom_tabla = 'SP_TAREAS'
      AND ge.nom_columna = 'IND_TIPOTAREA'
      AND ge.cod_valor(+) = i.ind_tipotarea
   UNION
   SELECT ju.cod_cliente cod_cliente, '1' cod_idioma, a.num_orden num_orden,
          b.des_oficina des_sucursal,
             ju.nom_cliente
          || ' '
          || ju.nom_apeclien1
          || ' '
          || ju.nom_apeclien2 nom_cliente,
          ju.num_ident num_ident, NULL des_direccion,
          ju.tel_contacto num_telefono, NULL num_fax,
          a.des_diagnostico des_diagnostico,
             a.nom_autorizado
          || ' '
          || a.ape_autorizado1
          || ' '
          || a.ape_autorizado2 nom_cliente_aut,
          a.num_ident_aut num_ident_aut,
          DECODE
             (a.cod_direccion_aut,
              NULL, ' ',
              st_procesos_pg.st_dir_cliente_fn (a.num_orden, 9, 0, 1)
             ) des_direccion_aut,
          a.num_telef_aut num_telefono_aut, a.num_fax_aut num_fax_aut,
          g.des_producto des_producto, a.ind_garantia ind_garantia,
          h.des_articulo des_articulo, h.cod_modelo cod_modelo,
          a.num_serie num_serie,
             dectohex (SUBSTR (a.num_serie, 1, 3))
          || LPAD (dectohex (SUBSTR (a.num_serie, 4, 8)), 6, '0')
                                                                num_serie_hex,
          a.num_abonado num_abonado, i.des_tarea des_tarea,
          a.imp_monto_fijo imp_monto_fijo, j.des_moneda des_moneda_fijo,
          k.des_articulo des_articulo_reem, k.cod_modelo cod_modelo_reem,
          a.num_serie_reem num_serie_reem,
             dectohex (SUBSTR (a.num_serie_reem, 1, 3))
          || LPAD (dectohex (SUBSTR (a.num_serie_reem, 4, 8)), 6, '0')
                                                           num_serie_reem_hex,
          l.num_dias_suspension num_dias_suspension,
          l.num_dias_cargo num_dias_cargo,
          l.num_dias_autoriz_venta num_dias_autoriz_venta,
          l.num_dias_rechazo_ppto num_dias_rechazo_ppto,
          n.des_moneda des_moneda_rech, m.imp_rechazo_ppto imp_rechazo_ppto,
          b.nom_contacto nom_contacto,
          TO_CHAR (a.fec_alta, sp_fn_formatofecha ('FORMATO_SEL2')) fec_alta,
          a.num_telefono celular, a.prc_nivel, NULL cod_region,
          NULL cod_ciudad, NULL cod_comuna, a.usu_alta usu_alta, a.cod_bodega,
          sp_averias_fn (a.num_orden) observacion,
          st_procesos_pg.st_chequeos_orden_fn (a.num_orden) chequeos,
          ge.des_valor,
          DECODE (i.ind_tipotarea,
                  'E', 'Externo',
                  'I', 'Interno',
                  'C', 'Compatibilidad'
                 ) tipotarea,
          st_procesos_pg.st_averias_orden_fn (a.num_orden) averias,
          'E' tipo_cliente
     FROM ge_oficinas b,
          sp_cliente_externo_to ju,
          ge_direcciones f,
          ge_productos g,
          al_articulos h,
          sp_tareas i,
          ge_monedas j,
          al_articulos k,
          sp_datos_productos l,
          sp_productos_taller m,
          ge_monedas n,
          ged_codigos ge,
          sp_hordenes_reparacion a
    WHERE b.cod_oficina = a.cod_oficina
      AND ju.cod_cliente = a.cod_cliente
      AND f.cod_direccion(+) = a.cod_direccion_aut
      AND g.cod_producto = a.cod_producto
      AND h.cod_articulo = a.cod_articulo
      AND i.cod_tarea = a.cod_tarea
      AND j.cod_moneda = a.cod_moneda
      AND k.cod_articulo(+) = a.cod_articulo_reem
      AND l.cod_producto = a.cod_producto
      AND m.cod_taller(+) = a.cod_taller
      AND m.cod_producto(+) = a.cod_producto
      AND n.cod_moneda(+) = m.cod_moneda_imp
      AND i.cod_tarea(+) = a.cod_tarea
      AND i.ind_tipotarea = 'C'
      AND ge.cod_modulo = 'ST'
      AND ge.nom_tabla = 'SP_TAREAS'
      AND ge.nom_columna = 'IND_TIPOTAREA'
      AND ge.cod_valor(+) = i.ind_tipotarea;

