CREATE OR REPLACE FORCE VIEW GA_VCONTRATO(
   NUM_CONTRATO
 , NUM_VENTA
 , FEC_VENTA
 , COD_CLIENTE
 , DES_TIPCONTRATO
 , DES_MODVENTA
 , DES_CUOTA
 ) AS 
(select
ga_ventas.num_contrato,
ga_ventas.num_venta,
ga_ventas.fec_venta,
ga_ventas.cod_cliente,
ga_tipcontrato.des_tipcontrato,
ge_modventa.des_modventa,
ge_tipcuotas.des_cuota
from
ga_ventas,
ga_tipcontrato,
ge_modventa,
ge_tipcuotas
where
ga_ventas.cod_producto = ga_tipcontrato.cod_producto and
ga_ventas.cod_tipcontrato = ga_tipcontrato.cod_tipcontrato(+) and
ga_ventas.cod_modventa = ge_modventa.cod_modventa(+) and
ga_ventas.cod_cuota = ge_tipcuotas.cod_cuota(+)
)
/
SHOW ERRORS
