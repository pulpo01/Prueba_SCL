--Genera un archivo con los clientes en baja para telecobranza
--Genera El Archivo <TeleClientes{DiasMorosidad}{DeudaVencida}_{Fecha}.lst>

SET PAGES 0;
SET PAUSE OFF;
SET VERI OFF;
--SET HEAD OFF;
SET LINESIZE 600;
SET FEEDBACK OFF;
SET COLSEP "|";
SET TAB OFF;
SET TRIMSPOOL ON;

SELECT 	a.num_ident,
		b.nom_cliente || ' ' || b.nom_apeclien1 || ' ' || b.nom_apeclien2,
		a.cod_cliente,
		a.num_celular,
		to_char(decode(b.fec_alta, NULL, trunc(sysdate), b.fec_alta),'dd-mm-yyyy'),
		a.cnt_pagadas,
		a.mto_pagadas,
		a.cnt_pendientes,
		a.mto_pendientes,
		a.cnt_ncred,
		a.mto_ncred,
		b.tef_cliente1,
		a.anti,
		a.cod_categoria,
		a.cnt_abocelu_aaa,
		a.cnt_abobeep_aaa,
		a.cnt_abocelu_saa,
		a.cnt_abobeep_saa,
		a.cnt_abocelu_baa,
		a.cnt_abobeep_baa,
		a.cnt_abocelu_saa_co,
		a.cnt_abobeep_saa_co,
		a.des_comuna,
		a.des_ciudad,
		a.cod_agente
FROM    ge_clientes b,
        tmp_bajas a
WHERE   a.cod_cliente > 0
AND     a.cod_cliente = b.cod_cliente; 
QUIT;
