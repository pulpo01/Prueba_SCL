CREATE OR REPLACE PACKAGE BODY fa_intcontable_pg IS
/*
<NOMBRE>		: IC_ACTRESPUESTAS_PG
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >        : Fabian Aedo>
<VERSION >    	: 1>
<DESCRIPCION> 	: Realiza Apertura contable de la facturacion. Las acciones son realizadas para una factura en particular
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >

<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : Parametros de entrada de la funcion  (solo si es funcion o procedimiento) </ParamEntr>
<ParamSal >     : Parametros de salida de la funcion    (solo si es funcion o procedimiento) </ParamEntr>
*/
		-- DETALLE DE LA FACTURA
		TYPE  typ_rec_detfactura  IS RECORD(
			t_v_ordentotal		NUMBER(12),
			t_v_codcliente		NUMBER(8),
			t_v_numproceso		NUMBER(8),
			t_v_numabonado		NUMBER(8),
			t_v_concepto		NUMBER(4),
			t_v_columna			NUMBER(6),
			t_v_importe			NUMBER(14,4),
			t_v_tecno			VARCHAR2(7),
			t_v_oficinappal		VARCHAR2(2),
			t_v_grupo			NUMBER(4),
			t_v_concerel 		NUMBER(4),
			t_v_columna_rel		NUMBER(6));

        TYPE  typ_tab_detfactura IS TABLE OF typ_rec_detfactura
		        INDEX BY BINARY_INTEGER;

		-- DETALLE DE LA NC
		TYPE  typ_rec_detnc  IS RECORD(
			t_v_ordentotal		NUMBER(12),
			t_v_concepto		NUMBER(4),
			t_v_columna			NUMBER(6),
			t_v_concerel 		NUMBER(4),
			t_v_columna_rel		NUMBER(6),
			t_v_grupo			NUMBER(4),
			t_v_procesada		NUMBER(1));

		--DETALLE DE LA NOTA DE CREDITO
        TYPE  typ_tab_detnc IS TABLE OF typ_rec_detnc
		        INDEX BY BINARY_INTEGER;

		-- DETALLE DE LAS PROPORCIONES DE OFICINA Y TECNOLOGIA
		TYPE  typ_rec_proporciones IS RECORD (
	        t_v_CodTecno 			VARCHAR2(8),
	        t_v_CodOficinaPpal 		VARCHAR2(3),
	        t_v_ImpFacturable       NUMBER(14,4),
	        t_v_CantTecno           NUMBER(5),
	        t_v_PrcTecno            NUMBER(14,4),
	        t_v_PrcMonto            NUMBER(14,4));

        TYPE  typ_tab_proporciones IS TABLE OF typ_rec_proporciones
		        INDEX BY BINARY_INTEGER;

		-- REGISTROS A INSERTAR EN FA_FACTENO_TO
		TYPE  typ_rec_tecnologia IS RECORD (
			t_v_ordentotal			NUMBER(12),
			t_v_concepto			NUMBER(4),
			t_v_columna				NUMBER(6),
	        t_v_CodTecno 			VARCHAR2(8),
	        t_v_PrcTecno        	NUMBER(14,4),
	        t_v_CodOficinaPpal 		VARCHAR2(3),
			t_v_grpconcepto			NUMBER(4),
			t_v_concerel			NUMBER(4),
			t_v_columnarel			NUMBER(6));

        TYPE  typ_tab_tecnologia IS TABLE OF typ_rec_tecnologia
		        INDEX BY BINARY_INTEGER;


        TYPE typ_detfactura IS REF CURSOR;

		emp_proporciones	typ_tab_proporciones;
		tab_proporciones	typ_tab_proporciones;
		ind_proporciones	BINARY_INTEGER := 0;

		emp_tecnologia		typ_tab_tecnologia;
		tab_tecnologia		typ_tab_tecnologia;
		ind_tecnologia		BINARY_INTEGER := 0;

		emp_detfactura		typ_tab_detfactura;
		tab_detfactura		typ_tab_detfactura;
		ind_detfactura		BINARY_INTEGER := 0;

		c_v_modomontos  	CONSTANT VARCHAR2(5) :=  'M';
		c_v_modoabonados    CONSTANT VARCHAR2(5) :=  'A';
		c_v_existeapertura	CONSTANT VARCHAR2(5) :=  'S';
/* ************************************************************************* */
PROCEDURE fa_initablas_pr
IS
/*
<NOMBRE>	: FA_INITABLAS_PR
<FECHACREA>	: 22-11-2004
<MODULO >	: FACTURACION </MODULO >
<AUTOR >    : Fabian Aedo>
<VERSION >    	: 1>
<DESCRIPCION>  : INICIALIZA LAS TABLAS DE MEMORIA</DESCRIPCION>
<FECHAMOD >    : DD/MM/YYYY </FECHAMOD >
<DESCMOD >     : Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>    : NO HAY  .</ParamEntr>
<ParamSal >    : NO HAY. </ParamEntr>
*/
BEGIN
	 	tab_proporciones	:= emp_proporciones;
		ind_proporciones	:= 0;

		tab_tecnologia		:= emp_tecnologia;
		ind_tecnologia		:= 0;

		tab_detfactura		:= emp_detfactura;
		ind_detfactura		:= 0;
END fa_initablas_pr;
/* ************************************************************************* */
PROCEDURE fa_acthistdocu_pr(p_v_factdocu	IN VARCHAR2,
							p_n_indorden	IN NUMBER,
							p_i_indicador	IN NUMBER)
IS
/*
<NOMBRE>	: FA_ACTHISTDOCU_PR
<FECHACREA>	: 22-11-2004
<MODULO >	: FACTURACION </MODULO >
<AUTOR >    : Fabian Aedo>
<VERSION >    	: 1>
<DESCRIPCION>  : INICIALIZA LAS TABLAS DE MEMORIA</DESCRIPCION>
<FECHAMOD >    : DD/MM/YYYY </FECHAMOD >
<DESCMOD >     : Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>    : NO HAY  .</ParamEntr>
<ParamSal >    : NO HAY. </ParamEntr>
*/
v_v_stmsql 	VARCHAR2(1000);
BEGIN
	v_v_stmsql := 'UPDATE '||p_v_factdocu;
	v_v_stmsql := v_v_stmsql ||' SET IND_APERTURA = :1 ';
	v_v_stmsql := v_v_stmsql ||' WHERE IND_ORDENTOTAL = :2';

	EXECUTE IMMEDIATE v_v_stmsql USING p_i_indicador, p_n_indorden;

	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20020,'ACTUALIZANDO '||p_v_factdocu||' DOCUMENTO:'||TO_CHAR(p_n_indorden)||' '||SQLERRM , FALSE);
END fa_acthistdocu_pr;
/* ************************************************************************* */
PROCEDURE fa_borrahistecno_pr (p_n_indordentotal IN NUMBER,
						p_v_histecno IN VARCHAR2)
IS
/*
<NOMBRE>		: fa_borrahistecno_pr
<FECHACREA>		: 10-12-2004<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: GENERA APERTURA CONTABLE DE LA FACTURA.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : p_n_indordentotal: NUMERO DE LA NC/ND. a borrar </ParamEntr>
<ParamEntr>     : p_v_histecno: TABLA DESDE DONDE SE VA A BORRAR </ParamEntr>

<ParamSal >     : NO HAY    (solo si es funcion o procedimiento) </ParamEntr>
*/
v_v_stmsql	VARCHAR2(1000);
BEGIN
	v_v_stmsql := 'DELETE FROM '||p_v_histecno;
	v_v_stmsql := v_v_stmsql || ' WHERE IND_ORDENTOTAL = :1';
	EXECUTE IMMEDIATE v_v_stmsql USING p_n_indordentotal;

	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20020, 'ERROR LIMPIANDO:'||p_v_histecno||' - '||SQLERRM, FALSE);
END;
/* ************************************************************************* */
PROCEDURE fa_cargaenlacehist_pr (p_n_codciclfact IN NUMBER, p_v_histdocu IN OUT VARCHAR2, p_v_histconc IN OUT VARCHAR2, p_v_histecno IN OUT VARCHAR2)
IS
/*
<NOMBRE>	: FA_CARGAENLACEHIST_PR
<FECHACREA>	: 22-11-2004
<MODULO >	: FACTURACION </MODULO >
<AUTOR >    : Fabian Aedo>
<VERSION >    	: 1>
<DESCRIPCION>  : CARGA LOS NOMBRES DE LAS TABLAS, DADO EL CICLO DE LA FACTURACION.</DESCRIPCION>
<FECHAMOD >    : DD/MM/YYYY </FECHAMOD >
<DESCMOD >     : Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>      	: p_n_codciclfact CICLO DE FACTURACION   .</ParamEntr>
<ParamSal >       	: p_v_histdocu : tabla de documentos. </ParamEntr>
<ParamSal >       	: p_v_histconc : tabla de conceptos. </ParamEntr>
<ParamSal >       	: p_v_histecno : tabla de tecnologias. </ParamEntr>
*/
BEGIN

		SELECT
	           fa_histdocu,
	           fa_histconc,
	           NVL(fa_tecnologias_th, 'NOTECNO')
	   	INTO
	   		   p_v_histdocu,
	   		   p_v_histconc,
	   		   p_v_histecno
	   	FROM
	   		   fa_enlacehist
	   	WHERE
	   	       cod_ciclfact = p_n_codciclfact;

	EXCEPTION
			 WHEN OTHERS THEN
			 	  RAISE_APPLICATION_ERROR(-20020, 'CICLO DE FACTURACION NO EXISTE EN FA_ENLACEHIST.'||SQLERRM, FALSE);
END fa_cargaenlacehist_pr;
/* ************************************************************************* */
PROCEDURE fa_indapertura_pr (p_v_apetecno IN OUT VARCHAR2, p_v_apeofici IN OUT VARCHAR2, p_v_valtecno IN OUT VARCHAR2, p_v_valofici IN OUT VARCHAR2, p_v_modprorr IN OUT VARCHAR2 )
IS
/*
<NOMBRE>	: FA_CARGAENLACEHIST_PR
<FECHACREA>	: 22-11-2004
<MODULO >	: FACTURACION </MODULO >
<AUTOR >    : Fabian Aedo>
<VERSION >    	: 1>
<DESCRIPCION>  : CARGA LOS NOMBRES DE LAS TABLAS, DADO EL CICLO DE LA FACTURACION.</DESCRIPCION>
<FECHAMOD >    : DD/MM/YYYY </FECHAMOD >
<DESCMOD >     : Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>      	: p_v_apetecno  ind. apertura por tecnologia .</ParamEntr>
<ParamSal >       	: p_v_apeofici : ind. apertura por oficina. </ParamEntr>
<ParamSal >       	: p_v_valtecno : valor por defecto de tecnologia. </ParamEntr>
<ParamSal >       	: p_v_valofici : valor por defecto de oficina. </ParamEntr>
<ParamSal >       	: p_v_modprorr : modalidad de prorrateo (M:montos / A:abonados). </ParamEntr>
*/
BEGIN

		SELECT
	           aper_tecnologia,
	       	   aper_oficina,
	       	   val_tecnologia,
	       	   val_oficina,
	       	   ind_modprorrateo
	   	INTO
	   		   p_v_apetecno,
	   		   p_v_apeofici,
	   		   p_v_valtecno,
			   p_v_valofici,
			   p_v_modprorr
	   	FROM
	   		   sc_indapertura_td
	   	WHERE
	   	       cod_modulo = 'FA';

	EXCEPTION
			 WHEN OTHERS THEN
			 	  RAISE_APPLICATION_ERROR(-20020, 'NO EXISTEN PARAMETROS DE APERTURA EN SC_INDAPERTURA_TD.'||SQLERRM, FALSE);
END fa_indapertura_pr;
/* ************************************************************************* */
FUNCTION fa_recuperasubtecnologia_td (p_v_abonado IN NUMBER) RETURN VARCHAR2
IS
/*
<NOMBRE>		: FA_RECUPERASUBTECNOLOGIA_TD
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: RECUPERA LA TECNOLOGIA DE UN ABONADO.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : </ParamEntr>
<ParamEntr>     : </ParamEntr>
<ParamSal >     : (solo si es funcion o procedimiento) </ParamSal>
*/
--v_v_tecno FA_ABONADOSTECNOLOGIA_TD.COD_SUBTECNOLOGIA%TYPE := '';		XM-200503160283 Soporte RyC CGLagos 17-03-2005. Entregable IV.
v_v_tecno GA_ABOCEL.COD_TECNOLOGIA%TYPE := '';

BEGIN
	SELECT
		cod_tecnologia
	INTO
		v_v_tecno
	FROM
		ga_abocel
	WHERE
		num_abonado = p_v_abonado;
	RETURN
		v_v_tecno;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			BEGIN
				SELECT
					cod_tecnologia
				INTO
					v_v_tecno
				FROM
					ga_aboamist
				WHERE
					num_abonado	= p_v_abonado;
				RETURN
					v_v_tecno;
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
						RETURN 'NOTECNO';
					WHEN OTHERS THEN
						RAISE_APPLICATION_ERROR (-20020, 'Error verificando tabla de proporciones.'||SQLERRM, FALSE);
			END;
END fa_recuperasubtecnologia_td;
/*XM-200503160283 Soporte RyC CGLagos 17-03-2005. Entregable IV.
	SELECT	cod_subtecnologia
	INTO	v_v_tecno
	FROM	fa_abonadostecnologia_td
	WHERE	num_abonado = p_v_abonado;
	RETURN v_v_tecno;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN 'NOTECNO';
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20020, 'ERROR VERIFICANDO TABLA DE PROPORCIONES.'||SQLERRM, FALSE);
END fa_recuperasubtecnologia_td;*/
/* ************************************************************************* */
PROCEDURE fa_cargadetfactura_ciclo_pr (p_n_indordentotal IN NUMBER, p_v_factdocu IN VARCHAR2, p_v_factconc IN VARCHAR2, p_v_factecno IN VARCHAR2)
IS
/*
<NOMBRE>		: FA_CARGADETFACTURA_PR
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo>
<VERSION >    	: 1>
<DESCRIPCION>  	: CARGA DETALLE DE LA FACTURA EN ESTRUCTURA.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>    	: p_n_indordentotal : identificador de la factura   .</ParamEntr>
<ParamEntr>    	: p_v_histdocu : tabla de documentos. </ParamEntr>
<ParamEntr>    	: p_v_histconc : tabla de conceptos. </ParamEntr>
<ParamEntr>    	: p_v_histecno : tabla de tecnologias. </ParamEntr>
*/
v_v_stmsql 		VARCHAR2(500);
v_n_cursor      typ_detfactura;
v_t_temporal	typ_rec_detfactura;

BEGIN

	v_v_stmsql := 'SELECT /*+ Rule */ A.ind_ordentotal, ';
	v_v_stmsql := v_v_stmsql || 'A.cod_cliente, ';
	v_v_stmsql := v_v_stmsql || 'A.num_proceso, ';
	v_v_stmsql := v_v_stmsql || 'B.num_abonado, ';
	v_v_stmsql := v_v_stmsql || 'B.cod_concepto, ';
	v_v_stmsql := v_v_stmsql || 'B.columna,';
	v_v_stmsql := v_v_stmsql || 'B.imp_facturable, ';
	v_v_stmsql := v_v_stmsql || 'NULL, ';
	v_v_stmsql := v_v_stmsql || 'NVL(C.cod_oficina_principal,'' ''), ';
	/*v_v_stmsql := v_v_stmsql || 'NVL(D.cod_grpconcepto, -1) '; Por TM-200502221281 RyC Soporte 23-02-2005 capc*/
	v_v_stmsql := v_v_stmsql || 'NVL(D.cod_grpconcepto, -1), ';
	v_v_stmsql := v_v_stmsql || 'B.cod_concerel, ';
	v_v_stmsql := v_v_stmsql || 'B.columna_rel ';
	/*Por TM-200502221281 RyC Soporte 23-02-2005 capc*/
	v_v_stmsql := v_v_stmsql || 'FROM '|| p_v_factdocu ||' A, ';
	v_v_stmsql := v_v_stmsql || p_v_factconc ||' B, ';
	v_v_stmsql := v_v_stmsql || 'GA_ABOCEL C, ';
	v_v_stmsql := v_v_stmsql || 'FA_CONCEPTOS D ';
	v_v_stmsql := v_v_stmsql || 'WHERE ';
	v_v_stmsql := v_v_stmsql || 'A.ind_ordentotal = :1 AND ';
	v_v_stmsql := v_v_stmsql || 'A.ind_ordentotal = B.ind_ordentotal AND ';
	v_v_stmsql := v_v_stmsql || 'B.num_abonado  = C.num_abonado(+) AND ';
	v_v_stmsql := v_v_stmsql || 'B.cod_concepto = D.cod_concepto ';

	OPEN v_n_cursor FOR v_v_stmsql USING p_n_indordentotal;
	LOOP
		FETCH v_n_cursor INTO v_t_temporal;
      	EXIT WHEN v_n_cursor%NOTFOUND;

      	v_t_temporal.t_v_tecno := fa_recuperasubtecnologia_td(v_t_temporal.t_v_numabonado);
      	tab_detfactura(ind_detfactura) := v_t_temporal;

		ind_detfactura := ind_detfactura +1;
   	END LOOP;
	EXCEPTION
		WHEN OTHERS THEN
			 RAISE_APPLICATION_ERROR(-20020, 'ERROR RECPERANDO DETALLE DE LA FACTURA DE CICLOS.'||TO_CHAR(p_n_indordentotal)||SQLERRM, FALSE);
END fa_cargadetfactura_ciclo_pr;
/* ************************************************************************* */
PROCEDURE fa_cargadetfactura_nc_pr (p_n_indordentotal IN NUMBER,
									p_v_factconc IN VARCHAR2,
									p_tabconc	 IN OUT typ_tab_detnc,
									p_indconc	 IN OUT BINARY_INTEGER)
IS
/*
<NOMBRE>		: fa_cargadetfactura_nc_pr
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo>
<VERSION >    	: 1>
<DESCRIPCION>  	: CARGA DETALLE DE LA FACTURA EN ESTRUCTURA.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>    	: p_n_indordentotal : identificador de la factura   .</ParamEntr>
<ParamEntr>    	: p_v_histdocu : tabla de documentos. </ParamEntr>
<ParamEntr>    	: p_v_histconc : tabla de conceptos. </ParamEntr>
<ParamEntr>    	: p_v_histecno : tabla de tecnologias. </ParamEntr>
*/
v_v_stmsql 		VARCHAR2(500);
v_n_cursor      typ_detfactura;
v_t_temporal	typ_rec_detnc;

BEGIN

	v_v_stmsql := 'SELECT /*+ Rule */ ';
	v_v_stmsql := v_v_stmsql || 'A.ind_ordentotal, ';
	v_v_stmsql := v_v_stmsql || 'A.cod_concepto, ';
	v_v_stmsql := v_v_stmsql || 'A.columna,';
	v_v_stmsql := v_v_stmsql || 'A.cod_concerel, ';
	v_v_stmsql := v_v_stmsql || 'A.columna_rel, ';
	v_v_stmsql := v_v_stmsql || 'NVL(D.cod_grpconcepto, -1), ';
	v_v_stmsql := v_v_stmsql || '0 ';
	v_v_stmsql := v_v_stmsql || 'FROM ';
	v_v_stmsql := v_v_stmsql || p_v_factconc ||' A, ';
	v_v_stmsql := v_v_stmsql || 'FA_CONCEPTOS D ';
	v_v_stmsql := v_v_stmsql || 'WHERE ';
	v_v_stmsql := v_v_stmsql || 'A.ind_ordentotal = :1 AND ';
	v_v_stmsql := v_v_stmsql || 'A.cod_concepto = D.cod_concepto ';

	OPEN v_n_cursor FOR v_v_stmsql USING p_n_indordentotal;
	LOOP
		FETCH v_n_cursor INTO v_t_temporal;
      	EXIT WHEN v_n_cursor%NOTFOUND;

      	p_tabconc(p_indconc) := v_t_temporal;
		p_indconc := p_indconc + 1;
   	END LOOP;

	EXCEPTION
		WHEN OTHERS THEN
			 RAISE_APPLICATION_ERROR(-20020, 'ERROR RECUPERANDO DETALLE DE CONCEPTOS DE NC:'||TO_CHAR(p_n_indordentotal)||SQLERRM, FALSE);
END fa_cargadetfactura_nc_pr;
/* ************************************************************************* */
FUNCTION fa_validafacteno_fn (p_n_indordentotal IN NUMBER, p_v_factconc IN VARCHAR2, p_v_factecno IN VARCHAR2) RETURN BOOLEAN
IS
/*
<NOMBRE>		: FA_VALIDAFACTENO_FN
<FECHACREA>		: 07-01-2005
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo>
<VERSION >    	: 1>
<DESCRIPCION>  	: VALIDA LA DATA GENERADA COMO APERTURA PARA UNA FACTURA INDIVIDUAL.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>    	: p_n_indordentotal : identificador de la factura   .</ParamEntr>
<ParamEntr>    	: p_v_histconc : tabla de conceptos. </ParamEntr>
<ParamEntr>    	: p_v_histecno : tabla de tecnologias. </ParamEntr>
*/
v_v_stmsql 		VARCHAR2(500);
v_n_contador	NUMBER(6) := 0;
v_b_bandera		BOOLEAN := TRUE;
v_v_bandera		VARCHAR2(100);
BEGIN

	v_v_stmsql := ' SELECT COUNT(1) ';
	v_v_stmsql := v_v_stmsql ||  ' FROM (';
	v_v_stmsql := v_v_stmsql ||  ' SELECT IND_ORDENTOTAL, ';
	v_v_stmsql := v_v_stmsql ||  ' COD_CONCEPTO, ';
	v_v_stmsql := v_v_stmsql ||  ' COLUMNA';
	v_v_stmsql := v_v_stmsql ||  ' FROM '|| p_v_factconc ;
	v_v_stmsql := v_v_stmsql ||  ' WHERE IND_ORDENTOTAL = :1';
	v_v_stmsql := v_v_stmsql ||  ' MINUS';
	v_v_stmsql := v_v_stmsql ||  ' SELECT IND_ORDENTOTAL, ';
	v_v_stmsql := v_v_stmsql ||  ' COD_CONCEPTO, ';
	v_v_stmsql := v_v_stmsql ||  ' COLUMNA';
	v_v_stmsql := v_v_stmsql ||  ' FROM '|| p_v_factecno;
	v_v_stmsql := v_v_stmsql ||  ' WHERE IND_ORDENTOTAL = :2';
	v_v_stmsql := v_v_stmsql ||  ' )';

	EXECUTE IMMEDIATE  v_v_stmsql INTO v_n_contador USING p_n_indordentotal, p_n_indordentotal;

	IF v_n_contador <> 0 THEN
		v_b_bandera := FALSE;
	END IF;

	v_v_stmsql := ' SELECT COUNT(1) ';
	v_v_stmsql := v_v_stmsql ||  ' FROM (';
	v_v_stmsql := v_v_stmsql ||  ' SELECT COD_CONCEPTO, ';
	v_v_stmsql := v_v_stmsql ||  ' COLUMNA, ';
	v_v_stmsql := v_v_stmsql ||  ' COUNT(1) CANTIDAD ';
	v_v_stmsql := v_v_stmsql ||  ' FROM '|| p_v_factconc ;
	v_v_stmsql := v_v_stmsql ||  ' WHERE IND_ORDENTOTAL = :1 ';
	v_v_stmsql := v_v_stmsql ||  ' GROUP BY COD_CONCEPTO, COLUMNA) A, (';
	v_v_stmsql := v_v_stmsql ||  ' SELECT COD_CONCEPTO, ';
	v_v_stmsql := v_v_stmsql ||  ' COLUMNA, ';
	v_v_stmsql := v_v_stmsql ||  ' ROUND(SUM(PRC_TECNOLOGIA)/100) CANTIDAD ';
	v_v_stmsql := v_v_stmsql ||  ' FROM '|| p_v_factecno;
	v_v_stmsql := v_v_stmsql ||  ' WHERE IND_ORDENTOTAL = :2';
	v_v_stmsql := v_v_stmsql ||  ' GROUP BY COD_CONCEPTO, COLUMNA) B';
	v_v_stmsql := v_v_stmsql ||  ' WHERE A.COD_CONCEPTO = B.COD_CONCEPTO ';
	v_v_stmsql := v_v_stmsql ||  ' AND A.COLUMNA = B.COLUMNA ';
	v_v_stmsql := v_v_stmsql ||  ' AND A.CANTIDAD <> B.CANTIDAD ';

	EXECUTE IMMEDIATE  v_v_stmsql INTO v_n_contador USING p_n_indordentotal, p_n_indordentotal;
	IF v_n_contador <> 0 THEN
		v_b_bandera := FALSE;
	END IF;

	RETURN v_b_bandera;

	EXCEPTION
		WHEN OTHERS THEN
			RETURN FALSE;
END fa_validafacteno_fn;

/* ************************************************************************* */
FUNCTION fa_recuperatecno_fn (p_v_proceso IN NUMBER, p_v_cliente IN NUMBER, p_v_concepto IN NUMBER, p_v_columna IN NUMBER) RETURN VARCHAR2
IS
/*
<NOMBRE>		: FA_CARGADETFACTURA_PR
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo>
<VERSION >    	: 1>
<DESCRIPCION>  	: RECUPERA LA TECNOLOGIA PARA CONCEPTOS DE DOCUMENTOS NO-CICLO.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>    	: p_v_proceso : NUMERO DE PROCESO DE FACTURACION .</ParamEntr>
<ParamEntr>    	: p_v_cliente : CLIENTE DE LA FACTURACION </ParamEntr>
<ParamEntr>    	: p_v_concepto : CONCEPTO ESPECIFICO A REVISAR </ParamEntr>
<ParamEntr>    	: p_v_columna : COLUMANA ASOCIADA AL CONCEPTO. </ParamEntr>
<ParamSal>    	: RETORNA LA TECNOLOGIA ASOCIADA </ParamSal>
*/

v_n_nulprefactura 		  FA_CONCEPTOS.IND_TECNOLOGIA%TYPE;
v_v_tecprefactura 		  FA_CONCEPTOS.DEF_TECNOLOGIA%TYPE;
v_n_indteconcepto 		  FA_CONCEPTOS.IND_TECNOLOGIA%TYPE;
v_v_deftecnologia 		  FA_CONCEPTOS.DEF_TECNOLOGIA%TYPE;

v_v_auxtecno			  FA_CONCEPTOS.DEF_TECNOLOGIA%TYPE;
BEGIN

	SELECT
		a.cod_tecnologia,
		a.ind_nulo,
		b.def_tecnologia,
		b.ind_tecnologia
	INTO
		v_v_tecprefactura,
		v_n_nulprefactura,
		v_v_deftecnologia,
		v_n_indteconcepto
	FROM (
			SELECT
				cod_concepto,
				cod_tecnologia,
				DECODE(cod_tecnologia, NULL, 1, 0) ind_nulo
			FROM fa_prefactura
			WHERE
				num_proceso = p_v_proceso AND
				cod_cliente = p_v_cliente AND
				cod_concepto = p_v_concepto AND
				columna = p_v_columna
			UNION SELECT
				cod_concepto,
				cod_tecnologia,
				DECODE(cod_tecnologia, NULL, 1, 0) ind_nulo
			FROM fa_presupuesto
			WHERE
				num_proceso = p_v_proceso AND
				cod_cliente = p_v_cliente AND
				cod_concepto = p_v_concepto AND
				columna = p_v_columna ) a,
			fa_conceptos b
	WHERE a.cod_concepto = b.cod_concepto;

	IF v_n_indteconcepto = 1 AND v_n_nulprefactura <> 1 THEN
	   v_v_auxtecno := v_v_tecprefactura;
	ELSE
	   v_v_auxtecno := v_v_deftecnologia;
	END IF;

	RETURN 	v_v_auxtecno;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 return 'ST';
		WHEN OTHERS THEN
			 RAISE;

END fa_recuperatecno_fn;
/* ************************************************************************* */
PROCEDURE fa_cargadetfactura_nociclo_pr (p_n_indordentotal IN NUMBER, p_v_factdocu IN VARCHAR2, p_v_factconc IN VARCHAR2, p_v_factecno IN VARCHAR2)
IS
/*
<NOMBRE>		: FA_CARGADETFACTURA_PR
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo>
<VERSION >    	: 1>
<DESCRIPCION>  	: CARGA DETALLE DE LA FACTURA EN ESTRUCTURA.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>    	: p_n_indordentotal : identificador de la factura   .</ParamEntr>
<ParamEntr>    	: p_v_histdocu : tabla de documentos. </ParamEntr>
<ParamEntr>    	: p_v_histconc : tabla de conceptos. </ParamEntr>
<ParamEntr>    	: p_v_histecno : tabla de tecnologias. </ParamEntr>
*/
v_v_stmsql 		VARCHAR2(500);
v_n_cursor      typ_detfactura;
v_t_temporal	typ_rec_detfactura;
v_v_stmsql_rel	VARCHAR2(500);
v_n_cursor_rel  typ_detfactura;
v_n_concerel	NUMBER(4);
v_n_columnarel	NUMBER(6);
v_n_concepto_aux   NUMBER(4);
v_n_columna_aux    NUMBER(6);
v_n_tecno          NUMBER(1);
v_s_tecno          VARCHAR2(7);
k               NUMBER(1);

BEGIN

    v_n_tecno := 0;
	ind_detfactura := 0;
	v_s_tecno := 'ST';  -- 'ST' = SIN TECNOLOGIA'

	v_v_stmsql := 'SELECT /*+ Rule */ A.ind_ordentotal, ';
	v_v_stmsql := v_v_stmsql || 'A.cod_cliente, ';
	v_v_stmsql := v_v_stmsql || 'A.num_proceso, ';
	v_v_stmsql := v_v_stmsql || 'B.num_abonado, ';
	v_v_stmsql := v_v_stmsql || 'B.cod_concepto, ';
	v_v_stmsql := v_v_stmsql || 'B.columna,';
	v_v_stmsql := v_v_stmsql || 'B.imp_facturable, ';
	v_v_stmsql := v_v_stmsql || 'NULL, ';    	   	 -- LA TECNOLOGIA SE RECUPERA EN SEGUNDA INSTANCIA
	v_v_stmsql := v_v_stmsql || 'A.cod_oficina, '; 	 -- LA OFICINA DE LA VENTA VIENE EN LA HISTDOCU
	v_v_stmsql := v_v_stmsql || 'NVL(D.cod_grpconcepto, -1), ';
	v_v_stmsql := v_v_stmsql || 'B.cod_concerel, ';
	v_v_stmsql := v_v_stmsql || 'B.columna_rel ';
	v_v_stmsql := v_v_stmsql || 'FROM '|| p_v_factdocu ||' A, ';
	v_v_stmsql := v_v_stmsql || p_v_factconc ||' B, ';
	v_v_stmsql := v_v_stmsql || 'FA_CONCEPTOS D ';
	v_v_stmsql := v_v_stmsql || 'WHERE ';
	v_v_stmsql := v_v_stmsql || 'D.cod_concepto = B.cod_concepto AND ';
	v_v_stmsql := v_v_stmsql || 'B.ind_ordentotal = A.ind_ordentotal AND ';
	v_v_stmsql := v_v_stmsql || 'A.ind_ordentotal = :1';

	OPEN v_n_cursor FOR v_v_stmsql USING p_n_indordentotal;
	LOOP
		FETCH v_n_cursor INTO v_t_temporal;
      	EXIT WHEN v_n_cursor%NOTFOUND;

      	tab_detfactura(ind_detfactura) := v_t_temporal;
		BEGIN
			v_n_concepto_aux := tab_detfactura(ind_detfactura).t_v_concepto;
			v_n_columna_aux  := tab_detfactura(ind_detfactura).t_v_columna;
			v_s_tecno := fa_recuperatecno_fn(tab_detfactura(ind_detfactura).t_v_numproceso, tab_detfactura(ind_detfactura).t_v_codcliente, v_n_concepto_aux, v_n_columna_aux);
			IF v_s_tecno <> 'ST' THEN
				tab_detfactura(ind_detfactura).t_v_tecno := v_s_tecno;
				ind_detfactura := ind_detfactura + 1;
			ELSE
				k := ind_detfactura;
				v_n_tecno := 0;
				LOOP
					v_n_concepto_aux := tab_detfactura(k).t_v_concerel;
					v_n_columna_aux  := tab_detfactura(k).t_v_columna_rel;

					v_s_tecno := fa_recuperatecno_fn(tab_detfactura(k).t_v_numproceso, tab_detfactura(k).t_v_codcliente, v_n_concepto_aux, v_n_columna_aux);
					IF v_s_tecno <> 'ST' THEN
						tab_detfactura(ind_detfactura).t_v_tecno := v_s_tecno;
						ind_detfactura := ind_detfactura + 1;
						v_n_tecno := 1;
					ELSE
						k := k - 1;
					END IF;
					IF k = 0 THEN
						v_n_tecno := 1;
					END IF;
				EXIT WHEN v_n_tecno = 1;
				END LOOP;
			END IF;

		EXCEPTION
			WHEN OTHERS THEN
			 	RAISE_APPLICATION_ERROR(-20021, 'NO HAY CONCEPTOS RELACIONADOS:'||SQLERRM);
		END;
   	END LOOP;


	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			NULL;
		WHEN OTHERS THEN
			 RAISE_APPLICATION_ERROR(-20020, 'ERROR RECUPERANDO DETALLE DE LA FACTURA DE NOCICLOS.'||TO_CHAR(p_n_indordentotal)||SQLERRM, FALSE);
END fa_cargadetfactura_nociclo_pr;
/* ************************************************************************* */
FUNCTION fa_existepar_pr (p_v_tecnologia IN VARCHAR2, p_v_oficina IN VARCHAR2) RETURN NUMBER
IS
/*
<NOMBRE>		: FA_EXISTEPAR_PR
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: VALIDA EXISTENCIA DE COMBINACION, PARA DETERMINAR LAS PROPORCIONES.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : p_v_tecnologia : CODIGO DE LA TECNOLOGIA. </ParamEntr>
<ParamEntr>     : p_v_oficina : CODIGO DE LA OFICINA PRINCIPAL. </ParamEntr>
<ParamSal >     : SI EXISTE, SU POSICION, SI NO (-1). (solo si es funcion o procedimiento) </ParamSal>
*/
v_n_indice		BINARY_INTEGER := 0 ;
v_n_posicion 	BINARY_INTEGER := -1;
BEGIN
	FOR v_n_indice IN 0..ind_proporciones - 1 LOOP
		IF tab_proporciones(v_n_indice).t_v_CodTecno = p_v_tecnologia AND tab_proporciones(v_n_indice).t_v_CodOficinaPpal = p_v_oficina THEN
			v_n_posicion :=  v_n_indice;
		END IF;
	END LOOP;
	RETURN v_n_posicion;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20020, 'ERROR VERIFICANDO TABLA DE PROPORCIONES.'||SQLERRM, FALSE);
END fa_existepar_pr;
/* ************************************************************************* */
PROCEDURE fa_analizafact_ciclo_pr (p_v_abonado0 IN OUT BOOLEAN, p_v_apetecno IN VARCHAR2, p_v_apeofici IN VARCHAR2, p_v_valtecno IN VARCHAR2, p_v_valofici IN VARCHAR2)
IS
/*
<NOMBRE>		: FA_ANALIZAFACT_CICLO_PR
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: GENERA APERTURA CONTABLE DE LA FACTURA - CICLO.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : NO HAY. </ParamEntr>
<ParamSal >     : p_b_abonado INDICA SI ENCONTRO ABONADO CERO. (solo si es funcion o procedimiento) </ParamSal>
*/
v_n_indice		BINARY_INTEGER := 0;
v_n_posicion	BINARY_INTEGER := 0;
v_v_auxtecno	GA_ABOCEL.COD_TECNOLOGIA%TYPE;
v_v_auxoficina	GA_ABOCEL.COD_OFICINA_PRINCIPAL%TYPE;

BEGIN
	FOR v_n_indice IN 0..ind_detfactura -1 LOOP
		IF tab_detfactura(v_n_indice).t_v_numabonado = 0 OR tab_detfactura(v_n_indice).t_v_numabonado = -1 THEN
			p_v_abonado0 := TRUE;
		ELSE
			IF p_v_apetecno = c_v_existeapertura THEN
				v_v_auxtecno := tab_detfactura(v_n_indice).t_v_tecno;
			ELSE
				v_v_auxtecno := p_v_valtecno;
			END IF;

			IF p_v_apeofici = c_v_existeapertura THEN
				v_v_auxoficina := tab_detfactura(v_n_indice).t_v_oficinappal;
			ELSE
				v_v_auxoficina := p_v_valofici;
			END IF;

			tab_tecnologia(ind_tecnologia).t_v_ordentotal		:= tab_detfactura(v_n_indice).t_v_ordentotal;
			tab_tecnologia(ind_tecnologia).t_v_concepto		    := tab_detfactura(v_n_indice).t_v_concepto;
			tab_tecnologia(ind_tecnologia).t_v_columna			:= tab_detfactura(v_n_indice).t_v_columna;
			tab_tecnologia(ind_tecnologia).t_v_CodTecno 		:= v_v_auxtecno;
			tab_tecnologia(ind_tecnologia).t_v_PrcTecno         := 100;
			tab_tecnologia(ind_tecnologia).t_v_CodOficinaPpal 	:= v_v_auxoficina;
			tab_tecnologia(ind_tecnologia).t_v_grpconcepto		:= tab_detfactura(v_n_indice).t_v_grupo;
			ind_tecnologia := ind_tecnologia + 1;

			v_n_posicion := fa_existepar_pr(v_v_auxtecno, v_v_auxoficina);
			IF v_n_posicion = -1 THEN
				tab_proporciones(ind_proporciones).t_v_CodTecno 		:= v_v_auxtecno;
				tab_proporciones(ind_proporciones).t_v_CodOficinaPpal 	:= v_v_auxoficina;
				tab_proporciones(ind_proporciones).t_v_ImpFacturable    := tab_detfactura(v_n_indice).t_v_importe;
				tab_proporciones(ind_proporciones).t_v_CantTecno        := 1;
				tab_proporciones(ind_proporciones).t_v_PrcTecno         := 0;
				tab_proporciones(ind_proporciones).t_v_PrcMonto         := 0;
				ind_proporciones := ind_proporciones + 1;
			ELSE
				tab_proporciones(v_n_posicion).t_v_ImpFacturable    := tab_proporciones(v_n_posicion).t_v_ImpFacturable + tab_detfactura(v_n_indice).t_v_importe;
			END IF;

		END IF;
	END LOOP;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20020, 'ERROR ANALIZANDO FACTURA DE CICLOS.'||SQLERRM, FALSE);
END fa_analizafact_ciclo_pr;
/* ************************************************************************* */
PROCEDURE fa_analizafact_nociclo_pr (p_v_apetecno IN VARCHAR2, p_v_apeofici IN VARCHAR2, p_v_valtecno IN VARCHAR2, p_v_valofici IN VARCHAR2)
IS
/*
<NOMBRE>		: FA_ANALIZAFACT_CICLO_PR
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: GENERA APERTURA CONTABLE DE LA FACTURA - CICLO.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : NO HAY. </ParamEntr>
<ParamSal >     : p_b_abonado INDICA SI ENCONTRO ABONADO CERO. (solo si es funcion o procedimiento) </ParamSal>
*/
v_n_indice		BINARY_INTEGER := 0;
v_n_posicion	BINARY_INTEGER := 0;
v_v_auxtecno	GA_ABOCEL.COD_TECNOLOGIA%TYPE;
v_v_auxoficina	GA_ABOCEL.COD_OFICINA_PRINCIPAL%TYPE;

BEGIN

	FOR v_n_indice IN 0..ind_detfactura -1 LOOP
			IF p_v_apetecno = c_v_existeapertura THEN
				v_v_auxtecno := tab_detfactura(v_n_indice).t_v_tecno;
			ELSE
				v_v_auxtecno := p_v_valtecno;
			END IF;

			IF p_v_apeofici = c_v_existeapertura THEN
				v_v_auxoficina := tab_detfactura(v_n_indice).t_v_oficinappal;
			ELSE
				v_v_auxoficina := p_v_valofici;
			END IF;

			tab_tecnologia(ind_tecnologia).t_v_ordentotal		:= tab_detfactura(v_n_indice).t_v_ordentotal;
			tab_tecnologia(ind_tecnologia).t_v_concepto		    := tab_detfactura(v_n_indice).t_v_concepto;
			tab_tecnologia(ind_tecnologia).t_v_columna			:= tab_detfactura(v_n_indice).t_v_columna;
			tab_tecnologia(ind_tecnologia).t_v_grpconcepto		:= tab_detfactura(v_n_indice).t_v_grupo;
			tab_tecnologia(ind_tecnologia).t_v_PrcTecno         := 100;
			tab_tecnologia(ind_tecnologia).t_v_CodTecno 		:= v_v_auxtecno;
			tab_tecnologia(ind_tecnologia).t_v_CodOficinaPpal 	:= v_v_auxoficina;
			ind_tecnologia := ind_tecnologia + 1;
	END LOOP;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20020, 'ERROR ANALIZANDO FACTURA DE NOCICLOS.'||SQLERRM, FALSE);
END fa_analizafact_nociclo_pr;
/* ************************************************************************* */
FUNCTION fa_recuperaofcentral_fn RETURN VARCHAR2
IS
/*
<NOMBRE>		: fa_recuperaofcentral_fn
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: GENERA APERTURA CONTABLE DE LA FACTURA.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : NO HAY. </ParamEntr>
<ParamSal >     : NO HAY. (solo si es funcion o procedimiento) </ParamSal>
*/
v_v_oficina	GE_DATOSGENER.COD_OFICCENTRAL%TYPE;
BEGIN
	SELECT
		cod_oficcentral
	INTO
		v_v_oficina
	FROM GE_DATOSGENER;

	RETURN v_v_oficina;

	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20020, 'ERROR, NO ESTA DEFINIDA LA OFICINA CENTRAL - GE_DATOSGENER'||SQLERRM, FALSE);
END fa_recuperaofcentral_fn;

/* ************************************************************************* */
PROCEDURE fa_aplicaproporciones_pr (p_v_modprorr IN VARCHAR2,
                                    p_v_valtecno IN VARCHAR2)
IS
/*
<NOMBRE>		: fa_aplicaproporciones_pr
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: GENERA APERTURA CONTABLE DE LA FACTURA.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : NO HAY. </ParamEntr>
<ParamSal >     : NO HAY. (solo si es funcion o procedimiento) </ParamSal>
*/
v_n_indice		BINARY_INTEGER := 0;
v_n_tecnologia	BINARY_INTEGER := 0;
v_n_posicion	BINARY_INTEGER := 0;
v_b_abonado0	BOOLEAN := FALSE;
v_v_oficina		GE_DATOSGENER.COD_OFICCENTRAL%TYPE;
BEGIN


	FOR v_n_indice IN 0..ind_detfactura -1 LOOP
		IF tab_detfactura(v_n_indice).t_v_numabonado = 0 OR tab_detfactura(v_n_indice).t_v_numabonado = -1 THEN
			IF ind_proporciones > 0 THEN
				FOR v_n_tecnologia IN 0..ind_proporciones -1 LOOP

					tab_tecnologia(ind_tecnologia).t_v_ordentotal		:= tab_detfactura(v_n_indice).t_v_ordentotal;
					tab_tecnologia(ind_tecnologia).t_v_concepto		    := tab_detfactura(v_n_indice).t_v_concepto;
					tab_tecnologia(ind_tecnologia).t_v_columna			:= tab_detfactura(v_n_indice).t_v_columna;
					tab_tecnologia(ind_tecnologia).t_v_grpconcepto		:= tab_detfactura(v_n_indice).t_v_grupo;
					tab_tecnologia(ind_tecnologia).t_v_CodTecno 		:= tab_proporciones(v_n_tecnologia).t_v_CodTecno;
					tab_tecnologia(ind_tecnologia).t_v_CodOficinaPpal 	:= tab_proporciones(v_n_tecnologia).t_v_CodOficinaPpal;

					IF p_v_modprorr = c_v_modomontos THEN
						tab_tecnologia(ind_tecnologia).t_v_PrcTecno         := tab_proporciones(v_n_tecnologia).t_v_PrcMonto;
					ELSIF p_v_modprorr = c_v_modoabonados THEN
						tab_tecnologia(ind_tecnologia).t_v_PrcTecno         := tab_proporciones(v_n_tecnologia).t_v_PrcTecno;
					ELSE
						RAISE_APPLICATION_ERROR(-20010, 'ERROR, MODALIDAD DE PRORRATEO NO RECONOCIDA', FALSE);
					END IF;
					ind_tecnologia := ind_tecnologia + 1;

				END LOOP;
			ELSE
				-- NO SE CREO LA TABLA DE PROPORCIONES... LA FACTURA SOLO TIENE ABONADO 0....
				-- SE INFORMA CON TECNOLOGIA POR DEFECTO (NOTECNO), OFICINA = OFICCENTRAL, 100%
				v_v_oficina := fa_recuperaofcentral_fn;
				tab_tecnologia(ind_tecnologia).t_v_ordentotal		:= tab_detfactura(v_n_indice).t_v_ordentotal;
				tab_tecnologia(ind_tecnologia).t_v_concepto		    := tab_detfactura(v_n_indice).t_v_concepto;
				tab_tecnologia(ind_tecnologia).t_v_columna			:= tab_detfactura(v_n_indice).t_v_columna;
				tab_tecnologia(ind_tecnologia).t_v_grpconcepto		:= tab_detfactura(v_n_indice).t_v_grupo;
				tab_tecnologia(ind_tecnologia).t_v_PrcTecno			:= 100;
				tab_tecnologia(ind_tecnologia).t_v_CodTecno 		:= NVL(p_v_valtecno,'NOTECNO');
				tab_tecnologia(ind_tecnologia).t_v_CodOficinaPpal 	:= v_v_oficina;
				ind_tecnologia := ind_tecnologia + 1;

			END IF;
		END IF;
	END LOOP;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20020, 'ERROR APLICANDO PROPORCIONES ABONADO 0.'||SQLERRM, FALSE);
END fa_aplicaproporciones_pr;
/* ************************************************************************* */
PROCEDURE fa_calculaproprociones_pr
IS
/*
<NOMBRE>		: FA_CALCULAPROPROCIONES_PR
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: COMPLETA LA ESTRUCTURA DE PROPORCIONES, CALCULANDO LAS PRESENCIAS DE CADA PAR.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : NO HAY    (solo si es funcion o procedimiento).</ParamEntr>
<ParamSal >     : NO HAY    (solo si es funcion o procedimiento) </ParamEntr>
*/
v_n_indice 			NUMBER(6) := 0;
v_n_monto			NUMBER(14,4);
v_n_acumprcmonto	NUMBER(14,4):= 0;
v_n_acumprcabonado	NUMBER(14,4):= 0;

BEGIN
	FOR v_n_indice IN 0..ind_proporciones - 1 LOOP

		IF v_n_indice = ind_proporciones - 1 THEN
			tab_proporciones(v_n_indice).t_v_PrcTecno := 100 - v_n_acumprcabonado;
			tab_proporciones(v_n_indice).t_v_PrcMonto := 100 - v_n_acumprcmonto;
		ELSE
			tab_proporciones(v_n_indice).t_v_PrcTecno := tab_proporciones(v_n_indice).t_v_CantTecno * 100 / (ind_proporciones);
			v_n_acumprcabonado := v_n_acumprcabonado + tab_proporciones(v_n_indice).t_v_PrcTecno;

			tab_proporciones(v_n_indice).t_v_PrcMonto := tab_proporciones(v_n_indice).t_v_ImpFacturable * 100 / (ind_proporciones);
			v_n_acumprcmonto := v_n_acumprcmonto + tab_proporciones(v_n_indice).t_v_PrcMonto;
		END IF;
	END LOOP;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20020, 'ERROR CALCULANDO PROPORCIONES ABONADO 0.'||SQLERRM, FALSE);
END fa_calculaproprociones_pr;
/* ************************************************************************* */
PROCEDURE fa_grabafactecno_pr (p_v_factecno IN VARCHAR2)
IS
/*
<NOMBRE>		: FA_GRABAFACTECNO_PR
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: GRABA LOS REGISTROS FINALES EN TABLA FA_FACTECNO_TO....</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : p_v_factecno: NOMBRE FISICO DE LA TABLA FINAL. (solo si es funcion o procedimiento).</ParamEntr>
<ParamSal >     : NO HAY    (solo si es funcion o procedimiento) </ParamEntr>
*/
v_n_indice 			NUMBER(6) := 0;
v_v_stmsql 			VARCHAR2(500);
v_variables_ins		VARCHAR2(500);
BEGIN
	v_v_stmsql := 'INSERT INTO '||p_v_factecno||' (';
	v_v_stmsql := v_v_stmsql || 'ind_ordentotal, ';
	v_v_stmsql := v_v_stmsql || 'cod_concepto, ';
	v_v_stmsql := v_v_stmsql || 'columna, ';
	v_v_stmsql := v_v_stmsql || 'cod_tecnologia, ';
	v_v_stmsql := v_v_stmsql || 'prc_tecnologia, ';
	v_v_stmsql := v_v_stmsql || 'cod_oficina_principal, ';
	v_v_stmsql := v_v_stmsql || 'cod_grpconcepto) VALUES (';
	v_v_stmsql := v_v_stmsql || ':1, ';
	v_v_stmsql := v_v_stmsql || ':2, ';
	v_v_stmsql := v_v_stmsql || ':3, ';
	v_v_stmsql := v_v_stmsql || ':4, ';
	v_v_stmsql := v_v_stmsql || ':5, ';
	v_v_stmsql := v_v_stmsql || ':6, ';
	v_v_stmsql := v_v_stmsql || ':7)';

	FOR v_n_indice IN 0..ind_tecnologia - 1 LOOP
		v_variables_ins := 'ind:['||v_n_indice||'/'||ind_tecnologia||'] ';
		v_variables_ins := v_variables_ins ||'ordentotal:['||tab_tecnologia(v_n_indice).t_v_ordentotal||'] ';
		v_variables_ins := v_variables_ins ||'concepto:['||tab_tecnologia(v_n_indice).t_v_concepto||'] ';
		v_variables_ins := v_variables_ins ||'columna:['||tab_tecnologia(v_n_indice).t_v_columna||'] ';
		v_variables_ins := v_variables_ins ||'tecnologia:['||tab_tecnologia(v_n_indice).t_v_CodTecno||'] ';
		v_variables_ins := v_variables_ins ||'prc:['||tab_tecnologia(v_n_indice).t_v_PrcTecno||'] ';
		v_variables_ins := v_variables_ins ||'of_principal:['||tab_tecnologia(v_n_indice).t_v_CodOficinaPpal||'] ';
		v_variables_ins := v_variables_ins ||'grpconcepto:['||tab_tecnologia(v_n_indice).t_v_grpconcepto||'] ';

		EXECUTE IMMEDIATE v_v_stmsql USING tab_tecnologia(v_n_indice).t_v_ordentotal, tab_tecnologia(v_n_indice).t_v_concepto,
		                                   tab_tecnologia(v_n_indice).t_v_columna,    tab_tecnologia(v_n_indice).t_v_CodTecno,
		                                   tab_tecnologia(v_n_indice).t_v_PrcTecno,   tab_tecnologia(v_n_indice).t_v_CodOficinaPpal,
										   tab_tecnologia(v_n_indice).t_v_grpconcepto;
	END LOOP;

	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20020, 'ERROR fa_grabafactecno_pr.'||v_variables_ins||' - '||SQLERRM, FALSE);
END fa_grabafactecno_pr;
/* ************************************************************************* */
PROCEDURE fa_apertura_nociclo_pr (p_n_indordentotal IN NUMBER,
						  p_v_factdocu IN VARCHAR2,
						  p_v_factconc IN VARCHAR2,
						  p_v_factecno IN VARCHAR2,
						  p_v_apetecno IN VARCHAR2,
						  p_v_apeofici IN VARCHAR2,
						  p_v_valtecno IN VARCHAR2,
						  p_v_valofici IN VARCHAR2,
						  p_v_modprorr IN VARCHAR2 )
IS
/*
<NOMBRE>		: FA_ANALIZAFACTURA_PR
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: GENERA APERTURA CONTABLE DE LA FACTURA.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : p_n_indordentotal: NUMERO DE LA FACTURA.</ParamEntr>
<ParamEntr>     : p_n_documento: TIPO DE DOCUMENTO (CICLO / NOCICLO/ NC-ND)</ParamEntr>
<ParamEntr>     : p_n_historico: INDICADOR DE DOCUMENTO HISTORICO/EN PROCESO.</ParamEntr>
<ParamSal >     : NO HAY    (solo si es funcion o procedimiento) </ParamEntr>
*/
BEGIN
	-- BORRA EL REGISTRO EXISTENTE DE APERTURA PARA REPROCESARLO...
	fa_borrahistecno_pr(p_n_indordentotal, p_v_factecno);

	-- LIMPIA LAS VARIABLES DE TIPO TABLA A UTILIZAR
	fa_initablas_pr();

	-- CARGA LOS CONCEPTOS DE LA FACTURA EN ESTRUCTURA
	fa_cargadetfactura_nociclo_pr(p_n_indordentotal, p_v_factdocu, p_v_factconc, p_v_factecno);

	-- ANALIZA LA FACTURA
	fa_analizafact_nociclo_pr(p_v_apetecno, p_v_apeofici, p_v_valtecno, p_v_valofici);

	-- GRABA LA TABLA FA_FACTECNO_TO
	fa_grabafactecno_pr(p_v_factecno);

	--VALIDA LA INFORMACION GENERADA
	IF NOT fa_validafacteno_fn(p_n_indordentotal, p_v_factconc, p_v_factecno) THEN
		fa_acthistdocu_pr(p_v_factdocu, p_n_indordentotal, -1);
		RAISE_APPLICATION_ERROR(-20020, 'LOS DATOS GENERADOS ESTAN DESCUADRADOS, SE ANULA LA APERTURA DE FACTURA:'||TO_CHAR(p_n_indordentotal), FALSE);
	ELSE
		fa_acthistdocu_pr(p_v_factdocu, p_n_indordentotal, 1);
	END IF;

	EXCEPTION
			 WHEN OTHERS THEN
			 	  RAISE_APPLICATION_ERROR(-20020, 'ERROR EN APERTURA DE NO-CICLOS: '||SQLERRM, FALSE);
END fa_apertura_nociclo_pr;
/* ************************************************************************* */
PROCEDURE fa_apertura_ciclo_pr (p_n_indordentotal IN NUMBER,
						  p_v_factdocu IN VARCHAR2,
						  p_v_factconc IN VARCHAR2,
						  p_v_factecno IN VARCHAR2,
						  p_v_apetecno IN VARCHAR2,
						  p_v_apeofici IN VARCHAR2,
						  p_v_valtecno IN VARCHAR2,
						  p_v_valofici IN VARCHAR2,
						  p_v_modprorr IN VARCHAR2 )
IS
/*
<NOMBRE>		: FA_ANALIZAFACTURA_PR
<FECHACREA>		: 22-11-2004
<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: GENERA APERTURA CONTABLE DE LA FACTURA.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : p_n_indordentotal: NUMERO DE LA FACTURA.</ParamEntr>
<ParamEntr>     : p_n_documento: TIPO DE DOCUMENTO (CICLO / NOCICLO/ NC-ND)</ParamEntr>
<ParamEntr>     : p_n_historico: INDICADOR DE DOCUMENTO HISTORICO/EN PROCESO.</ParamEntr>
<ParamSal >     : NO HAY    (solo si es funcion o procedimiento) </ParamEntr>
*/
v_n_abonado0	BOOLEAN := FALSE;
BEGIN
	-- LIMPIA LAS VARIABLES DE TIPO TABLA A UTILIZAR
	fa_initablas_pr();
	/*Por TM-200502221281 RyC Soporte 23-02-2005 capc*/
	-- BORRA EL REGISTRO EXISTENTE DE APERTURA PARA REPROCESARLO...
	fa_borrahistecno_pr(p_n_indordentotal, p_v_factecno);

	-- CARGA LOS CONCEPTOS DE LA FACTURA EN ESTRUCTURA
	v_glosaerr:='CARGA LOS CONCEPTOS DE LA FACTURA EN ESTRUCTURA';
	fa_cargadetfactura_ciclo_pr(p_n_indordentotal, p_v_factdocu, p_v_factconc, p_v_factecno);

	-- ANALIZA LA FACTURA
	v_glosaerr:='ANALIZA LA FACTURA';
	fa_analizafact_ciclo_pr(v_n_abonado0, p_v_apetecno, p_v_apeofici, p_v_valtecno, p_v_valofici);

	IF v_n_abonado0 THEN
		v_glosaerr:='fa_calculaproprociones_pr';
		fa_calculaproprociones_pr();
		v_glosaerr:='fa_aplicaproporciones_pr';
		fa_aplicaproporciones_pr(p_v_modprorr, p_v_valtecno);
	END IF;

	-- GRABA LA TABLA FA_FACTECNO_TO
	v_glosaerr:='GRABA LA TABLA FA_FACTECNO_TO';
	fa_grabafactecno_pr(p_v_factecno);

	--VALIDA LA INFORMACION GENERADA
	IF NOT fa_validafacteno_fn(p_n_indordentotal, p_v_factconc, p_v_factecno) THEN
		fa_acthistdocu_pr(p_v_factdocu, p_n_indordentotal, -1);
		RAISE_APPLICATION_ERROR(-20020, 'LOS DATOS GENERADOS ESTAN DESCUADRADOS, SE ANULA LA APERTURA DE FACTURA:'||TO_CHAR(p_n_indordentotal), FALSE);
	ELSE
		fa_acthistdocu_pr(p_v_factdocu, p_n_indordentotal, 1);
	END IF;

	EXCEPTION
			 WHEN OTHERS THEN
			 	  RAISE_APPLICATION_ERROR(-20020, 'ERROR EN PACKAGE: '||v_glosaerr||' ->'||SQLERRM, FALSE);
END fa_apertura_ciclo_pr;
/* ************************************************************************* */
PROCEDURE fa_recuperafactura_pr(p_n_indordentotal IN NUMBER,
						  p_n_ordentotalfac IN OUT NUMBER,
						  p_n_ciclfact IN OUT NUMBER,
						  p_n_numproceso IN OUT NUMBER)
IS
/*
<NOMBRE>		: FA_RECUPERAFACTURA_PR
<FECHACREA>		: 10-12-2004<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: RECUPERA LOS DATOS DE LA FACTURA/BOLETA QUE ORIGINA LA NC/ND.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : p_n_indordentotal: NUMERO DE LA FACTURA.</ParamEntr>
<ParamEntr>     : v_n_ordentotalfac: INDICADOR DE DOCUMENTO HISTORICO/EN PROCESO.</ParamEntr>
<ParamEntr>     : v_n_ciclfact: INDICADOR DE DOCUMENTO HISTORICO/EN PROCESO.</ParamEntr>
<ParamSal >     : NO HAY    (solo si es funcion o procedimiento) </ParamEntr>
*/
BEGIN
	SELECT
	   ind_ordentotal,
	   cod_ciclfact,
	   num_proceso
	INTO
		p_n_ordentotalfac,
		p_n_ciclfact,
		p_n_numproceso
	FROM
		 fa_histdocu a,
		 (SELECT
		 		 num_securel,
		 		 cod_tipdocumrel,
				 cod_vendedor_agenterel,
				 letrarel,
				 cod_centrrel
		  FROM
		  	    fa_histdocu
		  WHERE
		  		ind_ordentotal = p_n_indordentotal) b
	WHERE
		  	a.num_secuenci = b.num_securel
	AND 	a.cod_tipdocum = b.cod_tipdocumrel
	AND 	a.cod_vendedor_agente = b.cod_vendedor_agenterel
	AND 	a.letra = b.letrarel
	AND 	a.cod_centremi = b.cod_centrrel;

	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20020, 'ERROR RECUPERANDO DOCUMENTO ASOCIADO A NC/ND'||SQLERRM, FALSE );
END fa_recuperafactura_pr;
/* ************************************************************************* */
FUNCTION fa_validacampo_fn(p_v_nomtabla IN VARCHAR2,
						p_v_nomcolumna IN VARCHAR2) RETURN BOOLEAN
IS
/*
<NOMBRE>		: FA_VALIDACAMPO_FN
<FECHACREA>		: 10-12-2004<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: VALIDA SI LA TABLA p_v_nomtabla POSEE LA COLUMNA p_v_nomcolumna.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : p_v_nomtabla: NOMBRE DE LA TABLA.</ParamEntr>
<ParamEntr>     : p_v_nomcolumna: NOMBRE DE LA COLUMNA (CICLO / NOCICLO/ NC-ND)</ParamEntr>
<ParamSal >     : TRUE: SI EL CAMPO EXISTE / FALSE SI NO. (solo si es funcion o procedimiento) </ParamEntr>
*/
v_n_res		NUMBER(6);
BEGIN
	SELECT
		COUNT(1)
	INTO
		 v_n_res
	FROM
		all_tab_columns
	WHERE
		table_name = p_v_nomtabla AND
		column_name = p_v_nomcolumna;

	IF v_n_res = 1 THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN FALSE;
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20020, 'ERROR DETERMINANDO APERTURA FACTURA TABLA:'||p_v_nomtabla||' COLUMNA:'||p_v_nomcolumna);
			RETURN FALSE;
END fa_validacampo_fn;
/* ************************************************************************* */
FUNCTION fa_validaconceptos_nc_pr(tab_conceptosnc  IN typ_tab_detnc,
							   	  ind_conceptosnc  IN BINARY_INTEGER) RETURN BOOLEAN
IS
/*
<NOMBRE>		: fa_validaconceptos_nc_pr
<FECHACREA>		: 10-12-2004<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: VALIDA QUE EXISTEN CONCEPTOS SIN INFORMAR (IND_PROCESADA = 0).</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : tab_conceptosnc: DETALLE DE CONCEPTOS DE LA NOTA DE CREDITO.</ParamEntr>
<ParamEntr>     : ind_conceptosnc: INDICE DE LA TABLA DE CONCEPTOS DE LA NC.</ParamEntr>
<ParamSal >     : NO HAY    (solo si es funcion o procedimiento) </ParamEntr>
*/
v_ind_conc		BINARY_INTEGER := 0;
v_b_valida		BOOLEAN := TRUE;
BEGIN

	FOR v_ind_conc IN 0..ind_conceptosnc -1 LOOP
		IF (tab_conceptosnc(v_ind_conc).t_v_procesada = 0) THEN
			v_b_valida := FALSE;
		END IF;
	END LOOP;
	RETURN v_b_valida;
END fa_validaconceptos_nc_pr;
PROCEDURE fa_generapertura_nc_pr(tab_tecnofactura IN typ_tab_tecnologia,
								 ind_tecnofactura IN BINARY_INTEGER,
								 tab_conceptosnc  IN OUT typ_tab_detnc,
								 ind_conceptosnc  IN BINARY_INTEGER)
IS
/*
<NOMBRE>		: fa_generapertura_nc_pr
<FECHACREA>		: 10-12-2004<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: GENERA LA APERTURA DE LA NC A PERTIR DE LA APERTURA DE LA FACTURA ORIGINAL.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : tab_tecnofactura: DETALLE DE APERTURA DE LA FACTURA ORIGINAL.</ParamEntr>
<ParamEntr>     : ind_tecnofactura : INDICE DE LA TABLA DE APERTURA DE LA FACTURA ORIGINAL</ParamEntr>
<ParamEntr>     : tab_conceptosnc: DETALLE DE CONCEPTOS DE LA NOTA DE CREDITO.</ParamEntr>
<ParamEntr>     : ind_conceptosnc: INDICE DE LA TABLA DE CONCEPTOS DE LA NC.</ParamEntr>
<ParamSal >     : NO HAY    (solo si es funcion o procedimiento) </ParamEntr>
*/
v_ind_conc		BINARY_INTEGER := 0;
v_ind_conc_aux	BINARY_INTEGER := 0;
v_ind_fact		BINARY_INTEGER := 0;
v_i_numitera	NUMBER(3) := 0;
v_b_valida		BOOLEAN;

tmp_tecnologia	typ_tab_tecnologia;
ind_tmp			BINARY_INTEGER := 0;
ind_tecno_aux	BINARY_INTEGER := 0;
BEGIN

	-- DETERMINA EL NIVEL DE APERTURA ORIGINAL DE LA FACTURA (FA_HISTECNO_TH_xxxxx)
	--v_b_aperofici := fa_validacampo_fn(p_v_histecnofac_fac, 'COD_OFICINA_PRINCIPAL');
	--v_b_grpconcepto := fa_validacampo_fn(p_v_histecnofac_fac, 'COD_GRPCONCEPTO');

	--PRIMERO ANALIZAMOS LOS CONCEPTOS "CABECERA" DE NOTA DE CREDITO
	FOR v_ind_conc IN 0..ind_conceptosnc -1 LOOP
		-- SOLO LOS REGISTROS NO PROCESADOS
		IF (tab_conceptosnc(v_ind_conc).t_v_concerel <= 0) AND (tab_conceptosnc(v_ind_conc).t_v_procesada = 0) THEN
			--ESTE CONCEPTO ES CABECERA, POR LO QUE LO BUSCAMOS TAL CUAL EN LA TABLA DE APERTURA
			FOR v_ind_fact IN 0..ind_tecnofactura -1 LOOP
				--SE VALIDA QUE EL CONCEPTO ESTE INFORMADO EN LA APERTURA DE FACTURA ORIGINAL
				IF tab_conceptosnc(v_ind_conc).t_v_concepto = tab_tecnofactura(v_ind_fact).t_v_concepto AND
				   tab_conceptosnc(v_ind_conc).t_v_columna = tab_tecnofactura(v_ind_fact).t_v_columna THEN

					-- SE AGREGA A LA ESTRUCTURA ACTUAL DE TECNOLOGIAS...
					tab_tecnologia(ind_tecnologia).t_v_ordentotal		:= tab_conceptosnc(v_ind_conc).t_v_ordentotal;
					tab_tecnologia(ind_tecnologia).t_v_concepto			:= tab_conceptosnc(v_ind_conc).t_v_concepto;
					tab_tecnologia(ind_tecnologia).t_v_columna			:= tab_conceptosnc(v_ind_conc).t_v_columna;
					tab_tecnologia(ind_tecnologia).t_v_CodTecno 		:= tab_tecnofactura(v_ind_fact).t_v_CodTecno;
					tab_tecnologia(ind_tecnologia).t_v_PrcTecno        	:= tab_tecnofactura(v_ind_fact).t_v_PrcTecno;
					tab_tecnologia(ind_tecnologia).t_v_CodOficinaPpal 	:= tab_tecnofactura(v_ind_fact).t_v_CodOficinaPpal;
					tab_tecnologia(ind_tecnologia).t_v_grpconcepto		:= tab_conceptosnc(v_ind_conc).t_v_grupo;
					tab_tecnologia(ind_tecnologia).t_v_concerel			:= 0;
					tab_tecnologia(ind_tecnologia).t_v_columnarel		:= 0;
					ind_tecnologia := ind_tecnologia +1;
					-- SE MARCA EL REGISTRO COMO PROCESADO
					tab_conceptosnc(v_ind_conc).t_v_procesada := 1;
				END IF;
			END LOOP;
		END IF;
	END LOOP;
	--SE VALIDA QUE TODOS LOS CONCEPTOS CABECERA ESTEN CON ESTADO "PROCESADO"
	FOR v_ind_conc IN 0..ind_conceptosnc -1 LOOP
		-- SOLO LOS REGISTROS NO PROCESADOS
		IF (tab_conceptosnc(v_ind_conc).t_v_concerel <= 0) AND (tab_conceptosnc(v_ind_conc).t_v_procesada = 0) THEN
			RAISE_APPLICATION_ERROR(-20014, 'EXISTEN CONCEPTOS DE LA NC:'||TO_CHAR(tab_conceptosnc(v_ind_conc).t_v_ordentotal)||' QUE NO ESTAN INFORMADOS EN LA APERTURA DE LA FACTURA ORIGINAL', FALSE);
		END IF;
	END LOOP;

	-- AHORA SE ANALIZAN LOS CONCEPTOS SUBORDINADOS... LOS QUE "HEREDAN" LA APERTURA DE LOS CONCEPTOS CABECERA...
	v_i_numitera := 0;
	LOOP
		-- CONTROL DEL BUCLE DE ACTUALIZACION
		v_b_valida := fa_validaconceptos_nc_pr(tab_conceptosnc, ind_conceptosnc) = TRUE OR (v_i_numitera > 5);
		EXIT WHEN v_b_valida;
		-- SOLO LOS REGISTROS NO PROCESADOS
		FOR v_ind_conc IN 0..ind_conceptosnc -1 LOOP
			IF (tab_conceptosnc(v_ind_conc).t_v_procesada = 0) THEN

				--ESTE CONCEPTO NO ESTA PROCESADO.. BUSCAMOS LA APERTURA DEL PADRE, EN LA MISMA ESTRUCTURA DE CONCEPTOS DE NC
				FOR v_ind_conc_aux IN 0..ind_conceptosnc -1 LOOP
					--SE VALIDA QUE EL CONCEPTO YA ESTE INFORMADO EN LA ESTRUCTURA DE CONCEPTOS, Y ESTE PROCESADO...
					IF tab_conceptosnc(v_ind_conc).t_v_concerel = tab_conceptosnc(v_ind_conc_aux).t_v_concepto AND
					   tab_conceptosnc(v_ind_conc).t_v_columna_rel = tab_conceptosnc(v_ind_conc_aux).t_v_columna AND
					   tab_conceptosnc(v_ind_conc_aux).t_v_procesada = 1 THEN
						--VAMOS A RECUPERAR LA APERTURA DEL CONCEPTO RELACIONADO EN LA TABLA DE APERTURA ACTUAL
						tmp_tecnologia := tab_tecnologia;
						ind_tmp := ind_tecnologia;
						FOR ind_tecno_aux IN 0..ind_tmp -1 LOOP
							--SE VALIDA QUE EL CONCEPTO ESTE INFORMADO EN LA APERTURA DE FACTURA ORIGINAL
							IF tab_conceptosnc(v_ind_conc_aux).t_v_concepto = tmp_tecnologia(ind_tecno_aux).t_v_concepto AND
							   tab_conceptosnc(v_ind_conc_aux).t_v_columna = tmp_tecnologia(ind_tecno_aux).t_v_columna THEN

								-- SE AGREGA A LA ESTRUCTURA ACTUAL DE TECNOLOGIAS...
								tab_tecnologia(ind_tecnologia).t_v_ordentotal		:= tab_conceptosnc(v_ind_conc).t_v_ordentotal;
								tab_tecnologia(ind_tecnologia).t_v_concepto			:= tab_conceptosnc(v_ind_conc).t_v_concepto;
								tab_tecnologia(ind_tecnologia).t_v_columna			:= tab_conceptosnc(v_ind_conc).t_v_columna;
								tab_tecnologia(ind_tecnologia).t_v_CodTecno 		:= tmp_tecnologia(ind_tecno_aux).t_v_CodTecno;
								tab_tecnologia(ind_tecnologia).t_v_PrcTecno        	:= tmp_tecnologia(ind_tecno_aux).t_v_PrcTecno;
								tab_tecnologia(ind_tecnologia).t_v_CodOficinaPpal 	:= tmp_tecnologia(ind_tecno_aux).t_v_CodOficinaPpal;
								tab_tecnologia(ind_tecnologia).t_v_grpconcepto		:= tab_conceptosnc(v_ind_conc).t_v_grupo;
								tab_tecnologia(ind_tecnologia).t_v_concerel			:= 0;
								tab_tecnologia(ind_tecnologia).t_v_columnarel		:= 0;
								ind_tecnologia := ind_tecnologia +1;
								-- SE MARCA EL REGISTRO COMO PROCESADO
								tab_conceptosnc(v_ind_conc).t_v_procesada := 1;
							END IF;
						END LOOP;
					END IF;
				END LOOP;
			END IF;
		END LOOP;
		v_i_numitera := v_i_numitera + 1;
	END LOOP;
	IF v_i_numitera > 5 THEN
		RAISE_APPLICATION_ERROR(-20018, 'PARA LA NOTA DE CREDITO:'||TO_CHAR(tab_conceptosnc(0).t_v_ordentotal)||'NO FUE POSIBLE REPLICAR LA APERTURA ORIGINAL', FALSE);
	END IF;
	exception
		when others	then
			RAISE_APPLICATION_ERROR(-20018, 'ERROR EN PROCESO DE NOTA DE CREDITO:'||TO_CHAR(tab_conceptosnc(0).t_v_ordentotal), FALSE);
END fa_generapertura_nc_pr;
/* ************************************************************************* */
FUNCTION fa_cargahistecno_fn (p_n_indordentotal IN NUMBER,
						  	  p_v_factconc IN VARCHAR2,
						  	  p_v_factecno IN VARCHAR2,
						      p_tabtecno   IN OUT typ_tab_tecnologia,
						      p_indtecno   IN OUT BINARY_INTEGER) RETURN BOOLEAN
IS
/*
<NOMBRE>		: FA_CARGAHISTECNO_FN
<FECHACREA>		: 10-12-2004<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: CARGA LA APERTURA DEL DOCUMENTO ORIGINAL.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : p_n_indordentotal: NUMERO DE LA NC/ND.</ParamEntr>
<ParamEntr>     : p_v_factconc: TABLA DE CONCEPTOS DONDE ESTA LA NC/ND).</ParamEntr>
<ParamEntr>     : p_v_factecno: TABLA DE APERTURA DONDE QUEDARA LA NC/ND).</ParamEntr>
<ParamEntr>     : p_tabtecno: TABLA EN MEMORIA DONDE SE CARGA A APERTURA ORIGINAL.</ParamEntr>
<ParamEntr>     : p_indtecno: INDICE DE LA TABLA EN MEMORIA.</ParamEntr>
<ParamSal >     : TRUE: SI CARGA REGISTROS / FALSE SI NO. (solo si es funcion o procedimiento) </ParamEntr>
*/
v_v_stmsql		VARCHAR2(2000);
v_b_aperofici	BOOLEAN;
v_n_cursor      typ_detfactura;
v_t_temporal	typ_rec_tecnologia;
BEGIN
	v_b_aperofici := fa_validacampo_fn(p_v_factecno, 'COD_OFICINA_PRINCIPAL');
	v_v_stmsql := 'SELECT /*+ Rule */ ';
	v_v_stmsql := v_v_stmsql || ' A.IND_ORDENTOTAL, ';
	v_v_stmsql := v_v_stmsql || ' A.COD_CONCEPTO, ';
	v_v_stmsql := v_v_stmsql || ' A.COLUMNA, ';
	v_v_stmsql := v_v_stmsql || ' B.COD_TECNOLOGIA, ';
	v_v_stmsql := v_v_stmsql || ' B.PRC_TECNOLOGIA, ';
	IF v_b_aperofici THEN
		v_v_stmsql := v_v_stmsql ||' B.COD_OFICINA_PRINCIPAL, ';
	ELSE
		v_v_stmsql := v_v_stmsql ||' C.COD_OFICCENTRAL, ';
	END IF;
	v_v_stmsql := v_v_stmsql || ' NULL, ';
	v_v_stmsql := v_v_stmsql || ' A.COD_CONCEREL, ';
	v_v_stmsql := v_v_stmsql || ' A.COLUMNA_REL ';
	v_v_stmsql := v_v_stmsql || ' FROM '||p_v_factconc||' A, '||p_v_factecno||' B ';
	IF NOT v_b_aperofici THEN
		v_v_stmsql := v_v_stmsql ||' , GE_DATOSGENER C ';
	END IF;
	v_v_stmsql := v_v_stmsql || 'WHERE B.IND_ORDENTOTAL = A.IND_ORDENTOTAL ';
	v_v_stmsql := v_v_stmsql || '  AND A.COD_CONCEPTO = B.COD_CONCEPTO ';
	v_v_stmsql := v_v_stmsql || '  AND A.COLUMNA = B.COLUMNA ';
	v_v_stmsql := v_v_stmsql || '  AND A.IND_ORDENTOTAL = :1 ';
	OPEN v_n_cursor FOR v_v_stmsql USING p_n_indordentotal;
	LOOP
		FETCH v_n_cursor INTO v_t_temporal;
      	EXIT WHEN v_n_cursor%NOTFOUND;
      	p_tabtecno(p_indtecno) := v_t_temporal;
		p_indtecno := p_indtecno +1;
   	END LOOP;

	IF p_indtecno = 0 THEN
		RETURN FALSE;
	END IF;
	RETURN TRUE;
END fa_cargahistecno_fn;

/* ************************************************************************* */
PROCEDURE fa_apertura_nc_pr (p_n_indordentotal IN NUMBER,
						  p_v_factdocu IN VARCHAR2,
						  p_v_factconc IN VARCHAR2,
						  p_v_factecno IN VARCHAR2)
IS
/*
<NOMBRE>		: FA_APERTURA_NC_PR
<FECHACREA>		: 10-12-2004<MODULO >		: FACTURACION </MODULO >
<AUTOR >    	: Fabian Aedo </AUTOR >
<VERSION >    	: 1 </VERSION >
<DESCRIPCION>  	: GENERA APERTURA CONTABLE DE LA FACTURA.</DESCRIPCION>
<FECHAMOD >    	: DD/MM/YYYY </FECHAMOD >
<DESCMOD >     	: Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>     : p_n_indordentotal: NUMERO DE LA NC/ND.</ParamEntr>
<ParamEntr>     : p_v_factdocu: TABLA DE DOCUMENTOS DONDE ESTA LA NC/ND)</ParamEntr>
<ParamEntr>     : p_v_factconc: TABLA DE CONCEPTOS DONDE ESTA LA NC/ND).</ParamEntr>
<ParamEntr>     : p_v_factecno: TABLA DE APERTURA DONDE QUEDARA LA NC/ND).</ParamEntr>
<ParamSal >     : NO HAY    (solo si es funcion o procedimiento) </ParamEntr>
*/
v_n_ordentotalfac	FA_HISTDOCU.IND_ORDENTOTAL%TYPE := 0;
v_n_ciclfact		FA_HISTDOCU.COD_CICLFACT%TYPE := 0;
v_n_procesofac		FA_HISTDOCU.NUM_PROCESO%TYPE := 0;
v_v_histdocufac		FA_ENLACEHIST.FA_HISTDOCU%TYPE := '';
v_v_histconcfac		FA_ENLACEHIST.FA_HISTCONC%TYPE := '';
v_v_histecnofac		FA_ENLACEHIST.FA_TECNOLOGIAS_TH%TYPE := '';
emp_tecnofactura	typ_tab_tecnologia;
tab_tecnofactura	typ_tab_tecnologia;
ind_tecnofactura	BINARY_INTEGER := 0;

emp_conceptosnc 	typ_tab_detnc;
tab_conceptosnc 	typ_tab_detnc;
ind_conceptosnc		BINARY_INTEGER := 0;

BEGIN
	-- LIMPIA LAS VARIABLES DE TIPO TABLA A UTILIZAR
	fa_initablas_pr();
	-- LIMPIA LAS TABLAS DE NC UTILIZADAS...
	tab_conceptosnc := emp_conceptosnc;
	ind_conceptosnc := 0;

	tab_tecnofactura := emp_tecnofactura;
	ind_tecnofactura := 0;

	-- BORRA EL REGISTRO EXISTENTE DE APERTURA PARA REPROCESARLO...
	fa_borrahistecno_pr(p_n_indordentotal, p_v_factecno);

	-- DETERMINAR EL IND_ORDENTOTAL, EL CICLFACT Y EL NUM_PROCESO DE FACTURA/BOLETA A LA QUE SE LE ESTA HACIENDO LA NC/ND
	fa_recuperafactura_pr(p_n_indordentotal, v_n_ordentotalfac, v_n_ciclfact, v_n_procesofac);

	-- DETERMINAR EL JUEGO DE TABLAS ASOCIADO AL CICLO DEL DOCUMENTO ORIGINAL
	fa_cargaenlacehist_pr(v_n_ciclfact, v_v_histdocufac, v_v_histconcfac, v_v_histecnofac);

	IF v_v_histecnofac <> 'NOTECNO' THEN

		--CARGA APERTURA ORIGINAL DE LA FACTURA
		IF fa_cargahistecno_fn(v_n_ordentotalfac, v_v_histconcfac, v_v_histecnofac, tab_tecnofactura, ind_tecnofactura) THEN

			--CARGA DETALLE DE CONCEPTOS DE LA NOTA DE CREDITO
			fa_cargadetfactura_nc_pr (p_n_indordentotal, p_v_factconc, tab_conceptosnc, ind_conceptosnc	);

			-- REPETIR LA APERTURA DE LA FACTURA, SOBRE LOS CONCEPTOS CONTENIDOS EN LA NC
			fa_generapertura_nc_pr(tab_tecnofactura, ind_tecnofactura, tab_conceptosnc, ind_conceptosnc);

			-- GRABA LA TABLA FA_FACTECNO_TO
			fa_grabafactecno_pr(p_v_factecno);

			--VALIDA LA INFORMACION GENERADA
			IF NOT fa_validafacteno_fn(p_n_indordentotal, p_v_factconc, p_v_factecno) THEN
				fa_acthistdocu_pr(p_v_factdocu, p_n_indordentotal, -1);
				RAISE_APPLICATION_ERROR(-20020, 'LOS DATOS GENERADOS ESTAN DESCUADRADOS, SE ANULA LA APERTURA DE FACTURA:'||TO_CHAR(p_n_indordentotal), FALSE);
			ELSE
				fa_acthistdocu_pr(p_v_factdocu, p_n_indordentotal, 1);
			END IF;
		ELSE
			RAISE_APPLICATION_ERROR(-20020, 'FACTURA ORIGINAL PARA NOTA DE CREDITO, NO FUE APERTURADA. '||SQLERRM, FALSE);
		END IF;
	ELSE
		RAISE_APPLICATION_ERROR(-20020, 'NO EXISTE TABLA (CICLO) DE APERTURA PARA FACTURA ORIGINAL.'||SQLERRM, FALSE);
	END IF;
	-- LIMPIA LAS TABLAS UTILIZADAS...
	tab_conceptosnc := emp_conceptosnc;
	ind_conceptosnc := 0;

	tab_tecnofactura := emp_tecnofactura;
	ind_tecnofactura := 0;

	EXCEPTION
			 WHEN OTHERS THEN
			 	  RAISE_APPLICATION_ERROR(-20020, 'ERROR EN PROCESO APERTURA NOTA DE CREDITO: '||SQLERRM, FALSE);
END fa_apertura_nc_pr;
/* ************************************************************************* */
END fa_intcontable_pg;
/
SHOW ERRORS
