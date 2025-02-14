CREATE OR REPLACE PROCEDURE CO_ACTIVAGARANTIA_PR(EN_codcliente IN NUMBER, EN_numtransaccion IN NUMBER, SN_retorno OUT NUMBER, SV_glosa OUT VARCHAR2) IS
/*
<NOMBRE>	: CO_ACTIVAGARANTIA_PR</NOMBRE>
<FECHACREA>	: 16/12/2004<FECHACREA/>
<MODULO >	: Cobranza </MODULO >
<AUTOR >           : Hilda Quezada </AUTOR >
<VERSION >    	: 1.0</VERSION >
<DESCRIPCION> : Activa Garantia de Pago de un Cliente </DESCRIPCION>
<FECHAMOD >    : DD/MM/YYYY </FECHAMOD >
<DESCMOD >     : Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>      	: EN_codcliente: Codigo del Cliente </ParamEntr>
<ParamEntr>      	: EN_numtransaccion: Numero de Transaccion para errores </ParamEntr>
<ParamSal >       	: SN_retorno: Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </ParamEntr>
<ParamSal >       	: SV_glosa: Descripcion del Error ocurrido. </ParamEntr>
*/

GN_indcarrier NUMBER(1) := 0;
GN_nomparametro VARCHAR2(12) := 'COD_GARANTIA';
GN_codmodulo VARCHAR2(2) := 'RE';
TN_indfacturado CO_CARTERA.IND_FACTURADO%TYPE := 1;
TN_indgpaplicada GA_ABONADO_GARANTIA.IND_GPAPLICADA%TYPE := 1;

BEGIN

	SN_retorno := 0;

	SV_glosa := 'Activacion Garantia de Pago del Cliente : ' || EN_codcliente || ', Fecha : ' || SYSDATE || '. ';
	UPDATE
	        co_cartera
	SET
	        ind_facturado = TN_indfacturado
	WHERE
	        cod_cliente = EN_codcliente
	        AND cod_tipdocum IN
			        (
					 SELECT
					         a.val_parametro
					 FROM
					         ged_parametros a
					 WHERE
					         a.nom_parametro = GN_nomparametro
					         AND a.cod_modulo = GN_codmodulo
					);

	SV_glosa := 'Registro activacion Garantia de Pago de abonados del Cliente : ' || EN_codcliente || ', Fecha : ' || SYSDATE || '. ';
	UPDATE
	        ga_abonado_garantia
	SET
	        ind_gpaplicada = TN_indgpaplicada
	        , fecha_baja = SYSDATE
	WHERE
	        cod_cliente = EN_codcliente
	        AND fecha_baja IS NULL;

	SV_glosa := 'Llamada a Procedimiento CO_CANCELACREDITOS_PR. Cliente : ' || EN_codcliente || ', Fecha : ' || SYSDATE || '. ';
	CO_CANCELACION_PG.CO_CANCELACREDITOS_PR(EN_codcliente, SYSDATE, EN_numtransaccion, GN_indcarrier, NULL, NULL, NULL, SN_retorno, SV_glosa);

EXCEPTION
WHEN OTHERS THEN
	SN_retorno := 1;
	SV_glosa := SV_glosa || SQLERRM;
  	CO_CANCELACION_PG.CO_INSERTAR_ERRORES_PR(EN_numtransaccion, SN_retorno, SV_glosa);
END CO_ACTIVAGARANTIA_PR;
/
SHOW ERRORS
