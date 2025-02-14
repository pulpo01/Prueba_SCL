CREATE OR REPLACE PROCEDURE CO_P_COB_EXT_PTR(	vp_NumProceso	IN NUMBER,
												vp_CodProceso	IN VARCHAR2,
												vp_NumIdent		IN VARCHAR2,
												vp_CodTipIdent	IN VARCHAR2,
												vp_CodCliente	IN NUMBER,
												vp_CodEntidad	IN VARCHAR2,
												vp_CodEnvio		IN VARCHAR2,
												vp_NomUsuario	IN VARCHAR2,
												vp_MtoEnvioAnt	IN NUMBER
) IS

/*    Funcisn        :Genera Registros en Formato COBEXTERNA MPR                                            */
/*    Autor          :Ricardo Salazar                                                                       */
/*    Fecha          :30/05/2002                                                                            */
/*    Modificaciones :31/05/2002 (rmaturan)                                                                 */
/*                   :11/06/2002 (Modesto Aranda)                                                           */
/*                      		se agregs caracter '#', el cual permite distinguir el fin de la 			*/
/*                      		cadena en  el  programa cobexterna.pc                                       */
/*                   :26/06/2002 (Modesto Aranda)                                                           */
/*                      		Se elimina COMMIT y se mueve UPDATE que cambia estado de EP a SM			*/
/*                   :08/07/2002 (Modesto Aranda)                                       					*/
/*                      		Inicializacisn variable  v_fin ='#'                                         */
/*                   :12/07/2002 (Modesto Aranda)                                                           */
/*                              - Control de numero de decimales (segun operadora)                          */
/*                              - Cambio de campo utilizado para obtener descripcisn campos         		*/
/*                                direccisn      (DES_PARAMDIR -> CAPTION)                                  */
/*                              - Se utilizaran nzmeros en vez de letras para identificar el        		*/
/*                                tipo de registro      (encabezado, detalle y pie)                         */
/*                   :01/08/2002 (Modesto Aranda)                                                           */
/*                              - Cambio en Query para obtener la deuda vencida del abonado         		*/
/*                   :08/08/2002 (Modesto Aranda)                                                           */
/*                              - Cambio de forma de obtener la direccion. Se reemplazo uso de  			*/
/*                                funcion por query.                                                        */
/*                   :12/08/2002  (Manuel Garcia)                                                           */
/*                      		- Se recupera la fecha mas antigua de deuda vencida,            			*/
/*                        		  correspondiente a los doctos informados a cobranza externa    			*/
/*                   :14/08/2002 (Modesto Aranda)                                                           */
/*                              - Se cambia el query que obtiene los clientes debido a que se   			*/
/*                                agrega el campo IND_INFORMADO a la tabla CO_COBEXTERNADOC.    			*/
/*                              - Se agrega un update para el campo antes mensionado.                   	*/
/*					 :06/01/2003 (Manuel Garcia)															*/
/*								- Se agrega campo TIPO MOVIMIENTO al archivo generado						*/
/*								  Valores 	B = Baja de Cobranza											*/
/*											M = Movimiento de deuda											*/
/*											A = Alta de Cobranza											*/
/*								-Se elimina un argumento de entrada											*/
/*								-Se agrega parametro de entrada con valor de codigo de cliente				*/
/*     				 :30/04/2003 (Modesto Aranda)                                                           */
/*                      		 Se agrega obtencion del parametro "TIP_DOCTOS_INFORMAR"  de Ged_aparmetros */
/*                      		 y  el campo COD_ENTIDAD al accesar tablas CO_COBEXTERNA y CO_COBEXTERNADOC */
/*    Ult.Paso Pruduc:04/07/2002 (TMC --> BREGO)                                                            */
/*                   :12/06/2002 (DEIMOS)                                                                   */
/*                   :15/07/2002 (HELENA --> Puerto Rico)                                                   */
/*                   :19/08/2002 (TMC --> Produccisn)                                                       */
/*                   :19/08/2002 (MPR --> Puerto Rico)                                                      */

v_nom_cliente		GE_CLIENTES.NOM_CLIENTE%TYPE;
v_apellidos         VARCHAR2(50);
v_NumCelular        GA_ABOCEL.NUM_CELULAR%TYPE;
v_direccion         VARCHAR2(500);
v_cod_tipident      GE_CLIENTES.COD_TIPIDENT%TYPE;
v_num_ident         GE_CLIENTES.NUM_IDENT%TYPE;
v_fec_vencimiento   CO_CARTERA.FEC_VENCIMIE%TYPE;
v_MtoDeudaCobranza  CO_CARTERA.IMPORTE_DEBE%TYPE;
v_deuda_total       NUMBER  := 0;
v_stg_general       VARCHAR2(1024);
v_stg_general2      VARCHAR2(1024);
v_stg_titulo        VARCHAR2(1024);
v_titulos_direc     VARCHAR2(1024);
v_tel_particular    VARCHAR2(15);
v_fec_alta          VARCHAR2(10);
v_fec_baja          VARCHAR2(10);
v_exis_co_arch      NUMBER(1) := 0;
v_NomArchivo        CO_ARCHIVOS.NOM_ARCHIVO%TYPE;
v_exis_reg          CO_ARCHIVOS.NUM_PROCESO%TYPE;
v_exis_reg_buenos   NUMBER := 0;
v_exis_mto_buenos   NUMBER := 0;
v_exis_total_reg    NUMBER := 0;
v_reg_buenos        NUMBER := 0;
v_total_reg         NUMBER := 0;
v_mto_envio         NUMBER := 0;
v_dias_moroso       NUMBER := 0;
vCntNumIdent        CO_COBEXENV.CNT_NUM_IDENT%TYPE;
v_Pie_Total         VARCHAR2(1024);
v_txt_registro      CO_DET_ARCHIVOS.TXT_REGISTRO%TYPE;
v_fin               CHAR(1) := '#';
iDecimal            NUMBER(2):= 0; --Decimales por Operadora.
v_CodMovimiento	    CO_COBEXTERNA.COD_MOVIMIENTO%TYPE;
v_Tip_Doctos_Infor	VARCHAR2(2) := ' '; -- Parametro que indica el tipo de documentos a considerar  (T = todos)

BEGIN
	v_MtoDeudaCobranza := 0;
	v_deuda_total := 0;
	v_reg_buenos  := 0;
	v_total_reg   := 0;
	v_NomArchivo := vp_CodProceso||'_'||vp_CodEntidad||'_'||vp_NumProceso||'.'||'txt';

	/* Obtine la cantidad de decimales a utilizar */
	SELECT GE_PAC_GENERAL.PARAM_GENERAL( 'num_decimal' )
	  INTO iDecimal
	  FROM DUAL;
    /* Parametro que indica el tipo de documentos a considerar (Este se valida en el programa que invoca a este Procedimiento)*/
	SELECT VAL_PARAMETRO
	  INTO v_Tip_Doctos_Infor
	  FROM GED_PARAMETROS
	 WHERE NOM_PARAMETRO = 'TIP_DOCTOS_INFORMAR'
	   AND COD_MODULO = 'CO'
	   AND COD_PRODUCTO = 1;

	v_total_reg := v_total_reg + 1;

	BEGIN
		SELECT NOM_CLIENTE,
			   NOM_APECLIEN1 || ' ' || NOM_APECLIEN2,
			   COD_TIPIDENT,
			   NUM_IDENT,
			   TEF_CLIENTE1,
			   TO_CHAR( FEC_ALTA, 'MMDDYY' ),
			   TO_CHAR( FEC_BAJA, 'MMDDYY' )
		  INTO v_nom_cliente,
		  	   v_apellidos,
		  	   v_cod_tipident,
		  	   v_num_ident,
		  	   v_tel_particular,
		  	   v_fec_alta,
		  	   v_fec_baja
		  FROM GE_CLIENTES
		 WHERE COD_CLIENTE = vp_CodCliente;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				v_nom_cliente := NULL;
				v_apellidos := NULL;
				v_cod_tipident := NULL;
				v_num_ident := NULL;
				v_tel_particular := NULL;
				v_fec_alta := NULL;
				v_fec_baja := NULL;
	END;

	BEGIN
		SELECT NUM_CELULAR
		  INTO v_NumCelular
		  FROM GA_ABOCEL
		 WHERE COD_CLIENTE = vp_CodCliente
		   AND COD_SITUACION <> 'BAA'
		   AND ROWNUM < 2;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				v_NumCelular:= 0;
	END;

	BEGIN
		SELECT NVL( DIR.DES_DIREC1, ' ' ) || ';' ||NVL( DIR.DES_DIREC2, ' ' ) || ';' || NVL( COM.DES_COMUNA, ' ' )
			   ||';'||NVL(PROV.COD_PROVINCIA,' ')||';'||NVL(DIR.ZIP,' ')
		  INTO v_direccion
		  FROM GA_DIRECCLI DIREC,
		  	   GE_COMUNAS COM,
		  	   GE_DIRECCIONES DIR,
		  	   GE_PROVINCIAS PROV
		 WHERE DIREC.COD_CLIENTE = vp_CodCliente
		   AND DIREC.COD_TIPDIRECCION = 3
		   AND DIREC.COD_DIRECCION = DIR.COD_DIRECCION
		   AND DIR.COD_COMUNA = COM.COD_COMUNA
		   AND DIR.COD_PROVINCIA = PROV.COD_PROVINCIA;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				v_direccion:= NULL;
	END;

    BEGIN
      IF vp_CodEnvio <> 'R' AND vp_CodEnvio <> 'B' AND v_Tip_Doctos_Infor = 'T' THEN
		SELECT ROUND( SYSDATE - MIN( FEC_VENCIMIE ) ), SUM( IMPORTE_DEBE -IMPORTE_HABER ) MTO_DEUDA
			INTO v_dias_moroso, v_MtoDeudaCobranza
				FROM CO_COBEXTERNADOC
				WHERE NUM_IDENT    = vp_NumIdent
				  AND COD_TIPIDENT = vp_CodTipIdent
				  AND COD_CLIENTE  = vp_CodCliente
				  AND COD_ENTIDAD = vp_CodEntidad;
	  ELSIF vp_CodEnvio <> 'R' AND vp_CodEnvio <> 'B' AND v_Tip_Doctos_Infor != 'T' THEN
		SELECT ROUND( SYSDATE - MIN( FEC_VENCIMIE ) ), SUM( IMPORTE_DEBE -IMPORTE_HABER ) MTO_DEUDA
			INTO v_dias_moroso, v_MtoDeudaCobranza
				FROM CO_COBEXTERNADOC
				WHERE NUM_IDENT    = vp_NumIdent
				 AND COD_TIPIDENT = vp_CodTipIdent
				 AND COD_CLIENTE  = vp_CodCliente
				 AND IND_INFORMADO = 'N' -- solo se consideran los no informados
				 AND COD_ENTIDAD = vp_CodEntidad;
	  END IF;
	  EXCEPTION
		 WHEN NO_DATA_FOUND THEN
		   v_dias_moroso := 0;
		   v_MtoDeudaCobranza := 0;
	END;

	IF vp_CodEnvio <> 'B' AND vp_CodEnvio <> 'R' THEN /* si no va de baja o reasignado */
		UPDATE CO_COBEXTERNADOC
		   SET IND_INFORMADO = 'S'
		 WHERE NUM_IDENT    = vp_NumIdent
		   AND COD_TIPIDENT = vp_CodTipIdent
		   AND COD_CLIENTE  = vp_CodCliente
		   AND COD_ENTIDAD = vp_CodEntidad;
	ELSE
		v_dias_moroso := 0;
		v_MtoDeudaCobranza := 0;
	END IF;

	/* siempre se actualiza la tabla historica */
	UPDATE CO_HCOBEXTERNADOC
	   SET IND_INFORMADO = 'S'
	 WHERE NUM_IDENT    = vp_NumIdent
	   AND COD_TIPIDENT = vp_CodTipIdent
	   AND COD_CLIENTE  = vp_CodCliente
	   AND COD_ENTIDAD = vp_CodEntidad;

	v_stg_general := vp_CodCliente || ';' || v_numcelular || ';' || v_nom_cliente || ';' || v_apellidos;
	v_stg_general := v_stg_general || ';' || v_direccion || ';' || vp_NumIdent || ';' || v_tel_particular;

	IF vp_CodEnvio = 'R' OR vp_CodEnvio = 'B' THEN
		v_CodMovimiento := 'B';
		v_stg_general := v_stg_general || ';' || v_CodMovimiento || ';' || GE_PAC_GENERAL.REDONDEA( 0, iDecimal, 0 );
		v_stg_general := v_stg_general || ';' || 0 || v_fin;
	ELSE
		v_CodMovimiento := vp_CodEnvio;
		v_stg_general := v_stg_general || ';' || v_CodMovimiento || ';' || GE_PAC_GENERAL.REDONDEA( v_MtoDeudaCobranza, iDecimal, 0 );
		v_stg_general := v_stg_general || ';' || v_dias_moroso || v_fin;
	END IF;

	INSERT INTO CO_DET_ARCHIVOS( NUM_PROCESO, COD_PROCESO, COD_ENTIDAD, TIP_REGITRO, TXT_REGISTRO )
	VALUES( vp_NumProceso, vp_CodProceso, vp_CodEntidad, '2', v_stg_general );
	v_deuda_total := v_deuda_total + v_MtoDeudaCobranza;
	v_reg_buenos := v_reg_buenos + 1;

	BEGIN
		SELECT NVL( MTO_BUENOS, 0 ), REG_BUENOS, TOT_REGISTROS, 0
		  INTO v_exis_mto_buenos, v_exis_reg_buenos, v_exis_total_reg, v_exis_co_arch
		  FROM CO_ARCHIVOS
		 WHERE NUM_PROCESO = vp_NumProceso
		   AND COD_PROCESO = vp_CodProceso
		   AND NOM_ARCHIVO = v_NomArchivo;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				v_exis_co_arch := NULL;
	END;

	v_exis_mto_buenos := v_deuda_total + nvl( v_exis_mto_buenos, 0 );
	v_exis_reg_buenos := nvl( v_exis_reg_buenos, 0 ) + v_reg_buenos;
	v_exis_total_reg := nvl( v_exis_total_reg, 0 ) + v_total_reg;
	v_Pie_Total:= ';'||';'||';'||';'||';'||';'||';'||';'||';'||';'||';'||';'||GE_PAC_GENERAL.REDONDEA( v_exis_mto_buenos, iDecimal, 0 ) || v_fin;

	IF v_exis_co_arch IS NULL THEN
		--insert co_archivos
		INSERT INTO CO_ARCHIVOS( NUM_PROCESO, COD_PROCESO, FEC_PROCESO, COD_ENTIDAD, NOM_ARCHIVO,
								 TOT_REGISTROS, REG_BUENOS, MTO_BUENOS, NOM_USUARIO )
		VALUES( vp_NumProceso, vp_CodProceso, SYSDATE, vp_CodEntidad, v_NomArchivo,
				v_total_reg, v_reg_buenos, v_deuda_total, vp_NomUsuario );

		v_titulos_direc := null;
		v_titulos_direc := v_titulos_direc||';'||'DIRECCION1'||';'||'DIRECCION2'||';';
		v_titulos_direc := v_titulos_direc||'CIUDAD'||';'||'PAIS'||';'||'ZONA POSTAL';

		v_stg_titulo := 'CUENTA'||';'||'TEL_MOVIL'||';'||'NOMBRE'||';'||'APELLIDOS'||v_titulos_direc||';'||'SEGURO_SOCIAL'||';';
		v_stg_titulo := v_stg_titulo||'TEL_RESIDENCIAL'||';'||'TIPO MOVIMIENTO'||';'||'BALANCE_FINAL'||';'||'DIAS DE MOROSIDAD'||v_fin;

		INSERT INTO CO_DET_ARCHIVOS( NUM_PROCESO, COD_PROCESO, COD_ENTIDAD, TIP_REGITRO, TXT_REGISTRO )
		VALUES( vp_NumProceso, vp_CodProceso, vp_CodEntidad, '1', v_stg_titulo );

		INSERT INTO CO_DET_ARCHIVOS( NUM_PROCESO, COD_PROCESO, COD_ENTIDAD, TIP_REGITRO, TXT_REGISTRO )
		VALUES( vp_NumProceso, vp_CodProceso, vp_CodEntidad, '3', v_Pie_Total );
	ELSE
		UPDATE CO_ARCHIVOS
		   SET MTO_BUENOS = GE_PAC_GENERAL.REDONDEA( v_exis_mto_buenos, iDecimal, 0 ),
			   REG_BUENOS = v_exis_reg_buenos,
			   TOT_REGISTROS = v_exis_total_reg
		 WHERE NUM_PROCESO = vp_NumProceso
		   AND COD_PROCESO = vp_CodProceso
		   AND NOM_ARCHIVO = v_NomArchivo;

		UPDATE CO_DET_ARCHIVOS
		   SET TXT_REGISTRO = ';'||';'||';'||';'||';'||';'||';'||';'||';'||';'||';'||';'||GE_PAC_GENERAL.REDONDEA(v_exis_mto_buenos, iDecimal, 0 ) || v_fin
		 WHERE NUM_PROCESO = vp_NumProceso
		   AND COD_PROCESO = vp_CodProceso
		   AND COD_ENTIDAD = vp_CodEntidad
		   AND TIP_REGITRO = '3';
	END IF;

	BEGIN
		SELECT CNT_NUM_IDENT + 1, MTO_ENVIO
		  INTO vCntNumIdent, v_mto_envio
		  FROM CO_COBEXENV
		 WHERE NUM_PROCESO = vp_NumProceso
		   AND COD_ENTIDAD = vp_CodEntidad
		   AND COD_ENVIO = vp_CodEnvio;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				v_mto_envio := NULL;
				vCntNumIdent := 1;
	END;

	IF v_mto_envio IS NULL THEN
		v_mto_envio := v_deuda_total - vp_MtoEnvioAnt;
		INSERT INTO CO_COBEXENV( NUM_PROCESO, COD_ENTIDAD, COD_ENVIO, CNT_NUM_IDENT, MTO_ENVIO )
		VALUES( vp_NumProceso, vp_CodEntidad, vp_CodEnvio, vCntNumIdent, v_mto_envio );
	ELSE
		v_mto_envio := v_mto_envio + ( v_deuda_total - vp_MtoEnvioAnt );
		UPDATE CO_COBEXENV
		   SET CNT_NUM_IDENT = vCntNumIdent,
			   MTO_ENVIO = v_mto_envio
		 WHERE NUM_PROCESO = vp_NumProceso
		   AND COD_ENTIDAD = vp_CodEntidad
		   AND COD_ENVIO = vp_CodEnvio;
	END IF;

	UPDATE CO_COBEXTERNA
	   SET FEC_MOVIMIENTO = SYSDATE,
		   NUM_PROCESO = vp_NumProceso,
		   MTO_ENVIOANT = v_deuda_total
	 WHERE NUM_IDENT = vp_NumIdent
	   AND COD_TIPIDENT = vp_CodTipIdent
	   AND COD_CLIENTE = vp_CodCliente
	   AND COD_ENTIDAD = vp_CodEntidad;

	EXCEPTION
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE( SQLERRM );
END CO_P_COB_EXT_PTR;
/
SHOW ERRORS
