ArchivoLog=Regu_Cuotas8_$(date "+%Y%m%d_%H%M%S").log
(
sqlplus -s / << 'EOF'
set tab off lines 132;
--
--Selecciona Registros con Error
--
select  num_proceso, num_venta,cod_tipdocum, cod_estadoc, cod_estproc, fec_facturacion, 
        fec_visacion, fec_pasocobro, cod_modventa, num_cuotas
from    fa_interfact 
where   cod_modventa = 8 and num_cuotas < 12 and cod_estadoc < 600 and cod_estadoc > 200 and cod_estproc = 3;
--
--Actualiza Numero de Cuotas en Facturas/Boletas
--
update  fa_factdocu_nociclo
set     num_cuotas = 12
where   num_proceso in (
            select  num_proceso
            from    fa_interfact 
            where   cod_modventa = 8 and num_cuotas < 12 and cod_estadoc < 600 and cod_estadoc > 200 and cod_estproc = 3);
--
--Actualiza Numero de Cuotas en Interfaz
--
update  fa_interfact 
set     num_cuotas = 12
where   cod_modventa = 8 and num_cuotas < 12 and cod_estadoc < 600 and cod_estadoc > 200 and cod_estproc = 3;
--
--Coomit
--
commit;
--
--Selecciona Registros con Error
--
select  num_proceso, num_venta,cod_tipdocum, cod_estadoc, cod_estproc, fec_facturacion, 
        fec_visacion, fec_pasocobro, cod_modventa, num_cuotas
from    fa_interfact where cod_modventa = 8 and num_cuotas < 12 and cod_estadoc < 600 and cod_estadoc > 200 and cod_estproc = 3;
exit;

EOF
) | tee ${XPF_LOG}/pasocobros/NoCiclo/${ArchivoLog}
