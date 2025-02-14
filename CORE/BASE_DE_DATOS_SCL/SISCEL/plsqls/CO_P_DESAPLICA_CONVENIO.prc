CREATE OR REPLACE PROCEDURE CO_P_DESAPLICA_CONVENIO(
	   vp_Secuencia_Co     IN VARCHAR2,
       VP_NUM_COMPAGO      IN VARCHAR2,
       VP_PREF_PLAZA       IN VARCHAR2,
	   vp_Motivo           IN VARCHAR2,
       VP_NUM_CONVENIO     IN VARCHAR2,
       vp_OutGlosa        OUT VARCHAR2,
	   vp_OutRetorno      OUT NUMBER ) IS

ERROR_PROCESO           EXCEPTION;
sNom_User               CO_CAJAS.NOM_USUARORA%TYPE;
vp_cod_caja             CO_MOVIMIENTOSCAJA.COD_CAJA%TYPE;
vp_cod_moneda           CO_MOVIMIENTOSCAJA.COD_MONEDA%TYPE;
vp_cod_operadora        CO_MOVIMIENTOSCAJA.COD_OPERADORA_SCL%TYPE;

vp_cod_plaza            CO_MOVIMIENTOSCAJA.COD_PLAZA%TYPE;
vp_contador             NUMBER(10);
VP_CONVENIO             BOOLEAN := TRUE ;
vp_efectivo             CO_MOVIMIENTOSCAJA.IMPORTE%TYPE;
vp_gls_error            VARCHAR2(255);

vp_cod_oficina          CO_MOVIMIENTOSCAJA.COD_OFICINA%TYPE;
vp_ruteo                NUMBER(2);
vp_tipo_convenio        CO_CONVENIOS.TIPO_CONVENIO%TYPE;
vp_Motivo2				NUMBER;

BEGIN
    	--Obtiene tipo de Convenio
    	vp_gls_error := 'Select Co_CONVENIOS';
    	SELECT TIPO_CONVENIO
      	INTO vp_tipo_convenio
      	FROM CO_CONVENIOS
     	WHERE NUM_CONVENIO = TO_NUMBER(VP_NUM_CONVENIO);

	vp_Motivo2:=TO_NUMBER(vp_Motivo);

    	SELECT 	IMPORTE,	COD_OPERADORA_SCL,	COD_PLAZA,
           	COD_MONEDA,	COD_OFICINA,		COD_CAJA
      	INTO 	vp_efectivo,	vp_cod_operadora,	vp_cod_plaza,
		vp_cod_moneda,	vp_cod_oficina,		vp_cod_caja
	FROM 	CO_MOVIMIENTOSCAJA
	WHERE 	NUM_COMPAGO=TO_NUMBER(VP_NUM_COMPAGO)
	   	AND PREF_PLAZA = VP_PREF_PLAZA
	   	AND ROWNUM=1;

    	SELECT 	NOM_USUARORA
      	INTO 	sNom_User
      	FROM 	CO_CAJAS
     	WHERE 	COD_OFICINA = vp_Cod_Oficina
       		AND COD_CAJA    = vp_Cod_Caja;

/*************************************************************************
	INI MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/
	BEGIN
		CO_DESAPLICAPAGO_UNIVERSAL(
			vp_Num_ComPago,		vp_Pref_Plaza ,		vp_Cod_oficina,
			vp_Cod_Caja   ,		vp_Motivo2     ,	VP_CONVENIO   ,
			VP_NUM_CONVENIO,	sNom_User     ,		vp_OutGlosa    ,
			vp_OutRetorno
		);
		vp_ruteo:=vp_outretorno;
		IF (vp_OutRetorno!=0 OR vp_OutRetorno IS NULL) THEN
			BEGIN
				RAISE ERROR_PROCESO;
			END;
		END IF;
	END;
/*************************************************************************
	FIN MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/

    	vp_gls_error := 'actualizacion de CO_CONVENIOS';
    	UPDATE CO_CONVENIOS
       	SET ESTADO_CONVENIO =3
     	WHERE NUM_CONVENIO=TO_NUMBER(VP_NUM_CONVENIO);

    	vp_gls_error := 'actualizacion de CO_INTERFAZ_CAJA';
    	UPDATE CO_INTERFAZ_CAJA
       	SET 	IND_PROCESADO=0,
           	NUM_SECUENCI_PAGO = NULL
     	WHERE 	NUM_MOVIMIENTO=TO_NUMBER(VP_NUM_CONVENIO);

   	vp_gls_error := 'Select count(*) a la CO_MOVIMIENTOSCAJA';
    	SELECT COUNT(1)
      	INTO vp_contador
      	FROM (	SELECT 1
              	FROM CO_MOVIMIENTOSCAJA
             	WHERE 	NUM_COMPAGO=TO_NUMBER(VP_NUM_COMPAGO)
               		AND TIP_VALOR = 1
               		AND PREF_PLAZA = VP_PREF_PLAZA
               		AND ROWNUM = 1 );

	IF vp_contador > 0 THEN
		vp_gls_error := 'Select a la CO_MOVIMIENTOSCAJA';
	     	SELECT 	IMPORTE,	COD_OPERADORA_SCL,	COD_PLAZA,
                	COD_MONEDA,	COD_OFICINA,		COD_CAJA
		INTO 	vp_efectivo,	vp_cod_operadora,	vp_cod_plaza,
                	vp_cod_moneda,	vp_cod_oficina,		vp_cod_caja
		FROM 	CO_MOVIMIENTOSCAJA
	      	WHERE 	NUM_COMPAGO=TO_NUMBER(VP_NUM_COMPAGO)
		    	AND TIP_VALOR = 1
	        	AND PREF_PLAZA = VP_PREF_PLAZA;

		vp_gls_error := 'Update a la tabla CO_EFECCAJAS';
		UPDATE 	CO_EFECCAJAS
           	SET 	EFEC_CAMBIO = EFEC_CAMBIO - vp_efectivo
		WHERE 	COD_OFICINA = vp_cod_oficina
		   	AND COD_CAJA = vp_cod_caja
		   	AND COD_OPERADORA_SCL = vp_cod_operadora
		   	AND COD_PLAZA = vp_cod_plaza
		   	AND COD_MONEDA = vp_cod_moneda;
	END IF;

	vp_gls_error := 'borrado de CO_MOVIMIENTOSCAJA';
     	DELETE
       	FROM 	CO_MOVIMIENTOSCAJA
      	WHERE 	NUM_COMPAGO=TO_NUMBER(VP_NUM_COMPAGO)
		AND PREF_PLAZA = VP_PREF_PLAZA;

     	vp_gls_error := 'ACTUALIZA FA_INTERFACT 16';
     	UPDATE 	FA_INTERFACT
	SET 	COD_ESTADOC  = 900,
            	COD_ESTPROC  = 3,
            	NOM_USUAELIM   = (SELECT USER FROM DUAL),
            	COD_CAUSAELIM = '00002'
      	WHERE 	NUM_PROCESO IN (SELECT NUM_PROCESO
                              	FROM CO_INTERFAZ_CAJA
                             	WHERE NUM_MOVIMIENTO = TO_NUMBER(VP_NUM_CONVENIO))
        			AND COD_ESTADOC<=300;

    	vp_gls_error := 'ok';
    	RAISE ERROR_PROCESO;
EXCEPTION
	WHEN ERROR_PROCESO THEN
		IF vp_ruteo != 0 THEN
            		ROLLBACK;
			vp_gls_error := RTRIM(vp_gls_error) || 'en orcl->' || RTRIM(SQLERRM(SQLCODE));
        	END IF;
        	INSERT	INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
			VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, 0);
    	WHEN DUP_VAL_ON_INDEX THEN
	        ROLLBACK;
        	vp_gls_error := RTRIM(vp_gls_error) || 'en orcl->' || RTRIM(SQLERRM(SQLCODE));
        	INSERT	INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
        		VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, 0);
    	WHEN NO_DATA_FOUND THEN
	        ROLLBACK;
        	vp_gls_error := RTRIM(vp_gls_error) || 'en orcl->' || RTRIM(SQLERRM(SQLCODE));
        	INSERT	INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
        		VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, 0);
    	WHEN OTHERS THEN
	        ROLLBACK;
        	vp_gls_error := RTRIM(vp_gls_error) || 'en orcl->' || RTRIM(SQLERRM(SQLCODE));
        	INSERT	INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
        		VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, 0);
END Co_P_Desaplica_Convenio;
/
SHOW ERRORS
