--Genera un archivo con la cartera de clientes en baja
--Genera El Archivo <TeleCartera{DiasMorosidad}{DeudaVencida}_{Fecha}.lst>

SET PAGES 0;
SET PAUSE OFF;
SET VERI OFF;
SET HEAD OFF;
SET LINESIZE 100;
SET FEEDBACK OFF;
SET COLSEP "|";
SET TAB OFF;
SET TRIMSPOOL ON;

SELECT 	ca.cod_cliente,
		ca.num_folio,
		ca.cod_tipdocum,
		sum(ca.saldo)
FROM    tmp_cartera1 ca, tmp_bajas tm
WHERE   tm.cod_cliente > 0
AND     tm.cod_cliente = ca.cod_cliente
GROUP BY ca.cod_cliente, ca.num_folio, ca.cod_tipdocum; 
QUIT;
