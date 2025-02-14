set veri off
update fa_histdocu
set ind_impresa = 0
where num_secuenci > 0
and cod_tipdocum = 25
and tot_factura = 0
and tot_pagar = 0
and (fec_emision between to_date('&1', 'yyyymmdd') and to_date('&2', 'yyyymmdd'))
and num_folio = 0
and ind_impresa = 1;
commit;
exit;
