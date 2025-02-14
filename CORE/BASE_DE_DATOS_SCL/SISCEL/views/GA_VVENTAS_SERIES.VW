CREATE OR REPLACE FORCE VIEW GA_VVENTAS_SERIES(
   NUM_CARGO
 , COD_PRODUCTO
 , COD_CONCEPTO
 , IMP_CARGO
 , COD_MONEDA
 , NUM_UNIDADES
 , NUM_VENTA
 , NUM_ABONADO
 , NUM_TERMINAL
 , NUM_SERIE
 , NUM_SERIEMEC
 , NUM_FACTURA
 , COD_CONCEPTO_DTO
 , VAL_DTO
 , TIP_DTO
 , NOM_USUARORA
 , HISTCARGOS
 ) AS 
SELECT a.num_cargo, a.cod_producto, a.cod_concepto, a.imp_cargo,
          a.cod_moneda, a.num_unidades, a.num_venta, a.num_abonado,
          a.num_terminal, xc.num_serie, xc.num_serie as num_seriemec, a.num_factura,
          a.cod_concepto_dto, a.val_dto, a.tip_dto, a.nom_usuarora,
          0 AS histcargos
     FROM al_traspasos_masivo xc, al_cargos xa, al_ventas xb, ge_cargos a
    WHERE xa.num_cargo = a.num_cargo
      AND a.num_venta IN (SELECT zb.num_venta
                            FROM ga_ventas za, al_ventas zb
                           WHERE zb.tip_venta = 'W'
						     AND zb.fec_venta >   SYSDATE - 90
                             AND za.num_venta = zb.num_venta)
      AND xa.num_venta = xb.num_venta
      AND xb.cod_pedido = xc.cod_pedido
      AND xa.cod_articulo = xc.cod_articulo
      AND xc.cod_estado_tras = 'CE'
      AND (a.num_serie is null OR a.num_serie = '0')
      AND a.num_factura > 0
   UNION ALL
   SELECT a.num_cargo, a.cod_producto, a.cod_concepto, a.imp_cargo,
          a.cod_moneda, a.num_unidades, a.num_venta, a.num_abonado,
          a.num_terminal, xc.num_serie, xc.num_serie as num_seriemec, a.num_factura,
          a.cod_concepto_dto, a.val_dto, a.tip_dto, a.nom_usuario,
          1 AS histcargos
     FROM al_traspasos_masivo xc, al_cargos xa, al_ventas xb, fa_histcargos a
    WHERE xa.num_cargo = a.num_cargo
      AND a.num_venta IN (SELECT zb.num_venta
                            FROM ga_ventas za, al_ventas zb
                           WHERE zb.tip_venta = 'W'
                             AND zb.fec_venta >   SYSDATE - 90
                             AND za.num_venta = zb.num_venta)
      AND xa.num_venta = xb.num_venta
      AND xb.cod_pedido = xc.cod_pedido
      AND xa.cod_articulo = xc.cod_articulo
      AND xc.cod_estado_tras = 'CE'
      AND (a.num_serie is null OR a.num_serie = '0')
      AND a.num_factura > 0
/
SHOW ERRORS
