CREATE OR REPLACE PROCEDURE        PV_INS_INTERFACT(
 vp_secuencia_ga    IN VARCHAR2,
 vp_num_proceso     IN VARCHAR2,
 vp_num_venta       IN VARCHAR2,
 vp_cod_modgener    IN VARCHAR2,
 vp_cod_tipmovimien IN VARCHAR2,
 vp_cod_catribut    IN VARCHAR2,
 vp_num_folio       IN VARCHAR2,
 vp_cod_estadoc     IN VARCHAR2,
 vp_cod_estproc     IN VARCHAR2,
 vp_fec_vencimiento IN VARCHAR2,
 vp_salida_proc     IN OUT VARCHAR2,
 vp_cod_modventa    IN VARCHAR2,
 vp_num_cuotas	    IN VARCHAR2
 ) IS
vp_error            NUMBER(2);
gls_error           VARCHAR2(100);
ERROR_PROCESO EXCEPTION;
BEGIN
  	vp_error := 0;
  	gls_error := '';
  	vp_salida_proc := '0';
        INSERT INTO FA_INTERFACT
	(
        NUM_PROCESO    ,
        NUM_VENTA      ,
        COD_MODGENER   ,
        COD_ESTADOC    ,
        COD_ESTPROC    ,
        COD_TIPMOVIMIEN,
        COD_CATRIBUT   ,
        COD_TIPDOCUM   ,
        NUM_FOLIO      ,
        NUM_FOLIOREL   ,
        FEC_INGRESO    ,
        FEC_FACTURACION,
        FEC_IMPRESION  ,
        FEC_FOLIACION  ,
        FEC_VISACION   ,
        FEC_PASOCOBRO  ,
        FEC_CIERRE,
        FEC_VENCIMIENTO,
        COD_MODVENTA,
        NUM_CUOTAS
        )
        VALUES
        (
        to_number(vp_num_proceso),
        to_number(vp_num_venta),
        vp_cod_modgener,
        to_number(vp_cod_estadoc),
        to_number(vp_cod_estproc),
        to_number(vp_cod_tipmovimien),
        vp_cod_catribut,
        0,
        null,
        vp_num_folio,
        SYSDATE,
        null,
        null,
        null,
        null,
        null,
        null,
        to_date(vp_fec_vencimiento, 'dd-mm-yyyy'),
        to_number(vp_cod_modventa),
        to_number(vp_num_cuotas)
        );
        vp_salida_proc := '1';
        RAISE ERROR_PROCESO;
   EXCEPTION
      WHEN ERROR_PROCESO THEN
           /*if vp_error != 0 then
                ROLLBACK;
           end if;*/
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), vp_error, gls_error);
      WHEN DUP_VAL_ON_INDEX THEN
           --ROLLBACK;
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Duplicado');
      WHEN NO_DATA_FOUND THEN
           --ROLLBACK;
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 2, 'Datos No Fueron Encontrados');
      WHEN OTHERS THEN
           --ROLLBACK;
      	   INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 3, 'Otros Errores No Esperados');
END PV_INS_INTERFACT;
/
SHOW ERRORS
