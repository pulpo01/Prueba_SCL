CREATE OR REPLACE PROCEDURE FA_INS_INTERFACT(
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
 vp_num_cuotas      IN VARCHAR2,
 vp_pref_plaza_rel  IN VARCHAR2,
 vp_tip_foliacion   IN VARCHAR2,
 vp_cod_tipdocum	IN VARCHAR2
 ) IS
vp_error            NUMBER(2);
gls_error           VARCHAR2(100);
sFormatoFecha       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
ERROR_PROCESO EXCEPTION;
BEGIN
        vp_error := 0;
        gls_error := '';
        vp_salida_proc := '0';
    /* Obtiene el formato de fecha para PL */
    sFormatoFecha :=GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2');
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
        FEC_CIERRE 	   ,
        FEC_VENCIMIENTO,
        COD_MODVENTA   ,
        NUM_CUOTAS     ,
		PREF_PLAZAREL  ,
		TIP_FOLIACION
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
        to_number(nvl(vp_cod_tipdocum,0)),
        null,
        to_number(vp_num_folio),
        SYSDATE,
        null,
        null,
        null,
        null,
        null,
        null,
        to_date(vp_fec_vencimiento,sFormatoFecha),
        to_number(vp_cod_modventa),
        to_number(vp_num_cuotas),
	/* nvl(vp_pref_plaza_rel,'   '), */  /* Comentado   por PGonzalez 15-03-2004 */
	nvl(vp_pref_plaza_rel,'          '), /* Incorporado por PGonzalez 15-03-2004 */
        nvl(vp_tip_foliacion,'P')
		);
        vp_salida_proc := '1';
        RAISE ERROR_PROCESO;
   EXCEPTION
      WHEN ERROR_PROCESO THEN
           IF vp_error = 0 THEN
           DBMS_OUTPUT.PUT_LINE('vp_error==0');
                INSERT INTO GA_TRANSACABO
                           (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                    VALUES (TO_NUMBER(vp_secuencia_ga), vp_error, gls_error);

            ELSE
            DBMS_OUTPUT.PUT_LINE('vp_error<>0');
                INSERT INTO GA_TRANSACABO
                           (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                    VALUES (TO_NUMBER(vp_secuencia_ga), vp_error, gls_error);
           END IF;
      WHEN DUP_VAL_ON_INDEX THEN
           DBMS_OUTPUT.PUT_LINE('1:INSERT INTO GA_TRANSACABO');
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Duplicado');
      WHEN NO_DATA_FOUND THEN
           DBMS_OUTPUT.PUT_LINE('2:INSERT INTO GA_TRANSACABO');
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 2, 'Datos No Fueron Encontrados');
      WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE('OTHERS');
           DBMS_OUTPUT.PUT_LINE('3:INSERT INTO GA_TRANSACABO');
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 3, 'Otros Errores No Esperados');
END FA_INS_INTERFACT;
/
SHOW ERRORS
