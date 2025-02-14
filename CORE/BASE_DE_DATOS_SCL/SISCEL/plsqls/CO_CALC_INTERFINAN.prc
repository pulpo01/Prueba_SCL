CREATE OR REPLACE PROCEDURE        CO_CALC_INTERFINAN(
 vp_secuencia_co    IN VARCHAR2,
 vp_cuotas          IN VARCHAR2,
 vp_deuda	    IN VARCHAR2
 ) IS
iDecimal            NUMBER(2);
usuario	            VARCHAR2(30);
fecha               VARCHAR(10);
vp_error            NUMBER(2);
vp_porcentaje       NUMBER(8,5);
vp_cod_moneda       VARCHAR2(3);
vp_denominador      NUMBER(24,10);
vp_numerador        NUMBER(24,10);
vp_valor_cuota      NUMBER(14,4);
vp_diasint          NUMBER(10);
vp_mon_deuda        NUMBER(24,4);
vp_mon_carrier      NUMBER(24,4);
vp_ind_facturado    NUMBER(1);
vp_cod_tipdocum     NUMBER(2);
vp_ejecuta_in	    VARCHAR(2);
vp_val_int          NUMBER(15);
vp_val_cob          NUMBER(15);
vp_ruteo            NUMBER(2);
vp_cantidad         NUMBER(1);
vp_gls_error        VARCHAR2(255);
ERROR_PROCESO EXCEPTION;
BEGIN
	vp_gls_error := '';
	vp_valor_cuota := 0;
	usuario := '';
	vp_val_cob := 0;
    dbms_output.ENABLE(4000000);
    vp_ruteo := 1;

    vp_gls_error := 'SELECT GE_PAC_GENERAL.PARAM_GENERAL';
    SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal')
    INTO   iDecimal
    FROM   DUAL;

	vp_gls_error := 'Select usuario.';
    SELECT user, RTRIM(to_char(SYSDATE, 'dd-mm-yyyy')) INTO usuario, fecha
    FROM   DUAL;

	vp_ruteo := 2;
	vp_gls_error := 'Select co_int_bancario.';
    SELECT COD_MONEDA, PORCENTAJE/100 INTO
           vp_cod_moneda, vp_porcentaje
    FROM   CO_INT_BANCARIO
    WHERE  SYSDATE BETWEEN FEC_VIGENCIA_DD_DH  AND    FEC_VIGENCIA_HH_DH;

	vp_ruteo := 3;
	vp_gls_error := 'Calculo int. financiero';
    SELECT 1 - POWER(1 + vp_porcentaje, (-1) * TO_NUMBER(vp_cuotas))
    INTO   vp_denominador
    FROM   DUAL;

    vp_numerador := TO_NUMBER(vp_deuda) * vp_porcentaje;
	vp_valor_cuota := vp_numerador / vp_denominador;
    vp_ruteo := 0;
    vp_gls_error := 'Ok.';
    RAISE ERROR_PROCESO;

   EXCEPTION
      WHEN ERROR_PROCESO THEN
           if vp_ruteo != 0 then
                ROLLBACK;
           end if;
           INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_valor_cuota, iDecimal, 0));
      WHEN DUP_VAL_ON_INDEX THEN
           ROLLBACK;
           INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error,  GE_PAC_GENERAL.REDONDEA(vp_valor_cuota, iDecimal, 0));
      WHEN NO_DATA_FOUND THEN
           ROLLBACK;
           INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error,  GE_PAC_GENERAL.REDONDEA(vp_valor_cuota, iDecimal, 0));
      WHEN OTHERS THEN
           ROLLBACK;
      	   INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error,  GE_PAC_GENERAL.REDONDEA(vp_valor_cuota, iDecimal, 0));
END CO_CALC_INTERFINAN;
/
SHOW ERRORS
