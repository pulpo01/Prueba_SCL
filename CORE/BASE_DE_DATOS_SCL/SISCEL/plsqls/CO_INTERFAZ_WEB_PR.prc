CREATE OR REPLACE PROCEDURE CO_INTERFAZ_WEB_PR
(
    EN_codcliente IN NUMBER,
    EN_importepago IN NUMBER,
    EN_fecpago IN VARCHAR2,
    EN_codbanco IN VARCHAR2,
    SN_coderror OUT NOCOPY NUMBER,
    SV_glosaerror OUT NOCOPY VARCHAR2
) IS
/*
<NOMBRE>  : CO_INTERFAZ_WEB_PR/NOMBRE>
<FECHACREA>  : 02/09/2005<FECHACREA/>
<MODULO >  : Cobranza </MODULO >
<AUTOR >        : Hilda Quezada </AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Inserta Pago en tabla CO_INTERFAZ_PAGOS validando que parametros sean correctos</DESCRIPCION>
<FECHAMOD >     : DD/MM/YYYY </FECHAMOD >
<DESCMOD >      : Breve descripción de Modificación </DESCMOD >
<ParamEntr>     : EN_codcliente: Código del Cliente que realiza el Pago </ParamEntr>
<ParamEntr>     : EN_importepago: Monto pagado </ParamEntr>
<ParamEntr>     : EN_fecpago: Fecha de Pago </ParamEntr>
<ParamEntr>     : EN_codbanco: Código del Banco </ParamEntr>
<ParamSal >    : SN_coderror: Código del Error Producido </ParamSal >
<ParamSal >    : SV_glosaerror: Descripcion del Error ocurrido. </ParamSal >
*/

LV_retorno VARCHAR2(1);
TV_emprecaudadora CO_INTERFAZ_PAGOS.EMP_RECAUDADORA%TYPE := 'WEB';
TV_cajarecauda CO_INTERFAZ_PAGOS.COD_CAJA_RECAUDA%TYPE := '01';
TV_sersolicitado CO_INTERFAZ_PAGOS.SER_SOLICITADO%TYPE := 'REX';
TN_numtransaccion CO_INTERFAZ_PAGOS.NUM_TRANSACCION%TYPE;
TV_tiptransaccion CO_INTERFAZ_PAGOS.TIP_TRANSACCION%TYPE := 'K';
TV_subtiptransac CO_INTERFAZ_PAGOS.SUB_TIP_TRANSAC%TYPE := 'O';
TN_tipservicio CO_INTERFAZ_PAGOS.COD_SERVICIO%TYPE := 2;
TN_numcelular CO_INTERFAZ_PAGOS.NUM_CELULAR%TYPE := 0;
TN_folioctc CO_INTERFAZ_PAGOS.NUM_FOLIOCTC%TYPE := 0;
TV_numident CO_INTERFAZ_PAGOS.NUM_IDENT%TYPE := '0000';
TN_tipvalor CO_INTERFAZ_PAGOS.TIP_VALOR%TYPE := 12;
TN_numdocumento CO_INTERFAZ_PAGOS.NUM_DOCUMENTO%TYPE := 1;
TV_codestado CO_INTERFAZ_PAGOS.COD_ESTADO%TYPE := NULL;
TN_coderror CO_INTERFAZ_PAGOS.COD_ERROR%TYPE := NULL;

ERROR_EXCEPTION EXCEPTION;
BEGIN
  SN_coderror := 0;
  SV_glosaerror := 'Proceso Ejecutado Exitosamente';

  --Valida Codigo del Cliente
  BEGIN
    SELECT 1
    INTO   LV_retorno
    FROM   ge_clientes clie
    WHERE  clie.cod_cliente = TO_NUMBER(EN_codcliente);
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      SN_coderror := 501;
      SV_glosaerror := 'Código de Cliente No existe - '||SQLERRM;
    WHEN OTHERS THEN
      SV_glosaerror := 'Error en Código de Cliente - '||SQLERRM;
      RAISE ERROR_EXCEPTION;
  END;

  --Valida Importe del Pago
  IF TO_NUMBER(EN_importepago) <= 0 THEN
     BEGIN
		 SN_coderror := 503;
	     SV_glosaerror := 'Monto del Pago <= 0';
	 END;
  END IF;

  --Valida Código del Banco
  BEGIN
	SELECT 1
	INTO   LV_retorno
	FROM   ge_bancos ban
	WHERE  ban.cod_banco = EN_codbanco;
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	  SN_coderror := 505;
	  SV_glosaerror := 'Código de Banco No existe - '||SQLERRM;
	WHEN OTHERS THEN
	  SV_glosaerror := 'Error en Código de Banco - '||SQLERRM;
	  RAISE ERROR_EXCEPTION;
 END;

   IF SN_coderror > 0 THEN
	  TN_coderror := SN_coderror;
      TV_codestado := 'PEN';
   END IF;

 BEGIN
  SELECT CO_SEQ_TRANSACINT.NEXTVAL
  INTO TN_numtransaccion
  FROM dual;
  EXCEPTION
  WHEN OTHERS THEN
    SV_glosaerror := 'Error en CO_SEQ_TRANSACINT - '||SQLERRM;
	RAISE ERROR_EXCEPTION;
 END;

 --Obtiene Caja de Oficina NT
 BEGIN
    SELECT emp.cod_caja
    INTO   TV_cajarecauda
    FROM   co_empresas_rex emp
    WHERE  emp_recaudadora = TV_emprecaudadora;
    EXCEPTION
    WHEN OTHERS THEN
       SV_glosaerror := 'Error en co_empresas_rex - '||SQLERRM;
  	   RAISE ERROR_EXCEPTION;
 END;

 BEGIN
  INSERT INTO CO_INTERFAZ_PAGOS
  (emp_recaudadora, cod_caja_recauda, ser_solicitado,
  fec_efectividad, num_transaccion, nom_usuarora, tip_transaccion,
  sub_tip_transac, cod_servicio, num_ejercicio, cod_cliente,
  num_celular, imp_pago, num_folioctc, num_ident, tip_valor,
  num_documento, cod_banco, cta_corriente, cod_autoriza, can_debe,
  mto_debe, can_haber, mto_haber, cod_estado, cod_error,
  num_compago, num_tarjeta, cod_tipident, pref_plaza
  )
  VALUES
  (TV_emprecaudadora, TV_cajarecauda, TV_sersolicitado,
  TO_DATE(EN_fecpago, 'DD-MM-YYYY HH24:MI:SS'), TN_numtransaccion, USER, TV_tiptransaccion,
  TV_subtiptransac, TN_tipservicio, TO_CHAR(TO_DATE(EN_fecpago, 'DD-MM-YYYY HH24:MI:SS'), 'YYYYMMDD'), TO_NUMBER(EN_codcliente),
  TN_numcelular, TO_NUMBER(EN_importepago), TN_folioctc, TV_numident, TN_tipvalor,
  TN_numdocumento, EN_codbanco, NULL, NULL, NULL,
  NULL, NULL, NULL, TV_codestado, TN_coderror,
  NULL, NULL, NULL, NULL
  );
 EXCEPTION
 WHEN OTHERS THEN
   SV_glosaerror := 'Error en Insert - '||SQLERRM;
   RAISE ERROR_EXCEPTION;
 END;
 COMMIT;
EXCEPTION
  WHEN ERROR_EXCEPTION THEN
    SN_coderror := 1;
    ROLLBACK;
  WHEN OTHERS THEN
    SN_coderror := 1;
    SV_glosaerror := 'Proceso No se ejecutó Exitosamente - '||SQLERRM;
    ROLLBACK;
END CO_INTERFAZ_WEB_PR;
/
SHOW ERRORS
