CREATE OR REPLACE PROCEDURE PV_VALIDAHLR_ABOSIM_PR(
                            v_param_entrada   IN  VARCHAR2,
          		  			SV_resultado      OUT VARCHAR2,
          					SV_mensaje        OUT GA_TRANSACABO.DES_CADENA%TYPE)
IS
	/*
	<NOMBRE>  		  		  :PV_VALIDAHLR_ABOSIM</NOMBRE>
	<FECHACREA>				  :18/01/2005</FECHACREA>
	<MODULO>				  :POSTVENTA</MODULO>
	<AUTOR>					  :HECTOR PEREZ GUZMAN</AUTOR>
	<VERSION>				  :1.0</VERSION>
	<DESCRIPCION>			  :VALIDACION DE IGUALDAD ENTRE HLR DE LA CENTRAL DEL ABONADO Y </DESCRIPCION>
	<DESCRIPCION>			  :EL HLR DE LA SERIE DE LA NUEVA SIMCARD </DESCRIPCION>
	<FECHAMOD>				  :</FECHAMOD>
	<PARAMENTR>				  :</PARAMENTR>
	<PARAMSAL>				  : TRUE / FALSE, MENSAJE EN CASO DE FALSE</PARAMSAL>
	*/
    LV_cod_hlr			  ICG_HLRS.COD_HLR%TYPE;
	LV_des_hlr			  ICG_HLRS.DES_HLR%TYPE;
	LV_coderror			  VARCHAR2(1);
	LV_deserror			  VARCHAR2(60);
	LV_hlrsim			  AL_SERIES.COD_HLR%TYPE;

    string siscel.GE_TABTYPE_VCH2ARRAY:= siscel.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

	LV_AuxCentral		  ICG_CENTRAL.COD_CENTRAL%TYPE;
	LV_NumSerie			  AL_SERIES.NUM_SERIE%TYPE;
	LN_NumAbonado		  GA_ABOCEL.NUM_ABONADO%TYPE;

	LV_CodCentral		  ICG_CENTRAL.COD_CENTRAL%TYPE;
	SV_des_hlr			  ICG_HLRS.DES_HLR%TYPE;

	LV_productoCel		  GA_ABOCEL.COD_PRODUCTO%TYPE;

BEGIN

	SV_resultado := 'TRUE';
	SV_mensaje	 := 'OK';

    GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);

	LV_NumSerie		   := string(21);
	LV_AuxCentral      := TO_NUMBER(string(24));
	LN_NumAbonado      := TO_NUMBER(string(5));

	SELECT A.cod_hlr
	INTO   LV_hlrsim
	FROM   AL_SERIES A
	WHERE  A.num_serie =  LV_NumSerie;

	IF LV_AuxCentral IS NOT NULL THEN

	    LV_CodCentral := LV_AuxCentral;

	ELSE

	    BEGIN
		    SELECT A.cod_central
		    INTO   LV_CodCentral
		    FROM   GA_ABOCEL A
		    WHERE  A.num_abonado = LN_NumAbonado;
	    EXCEPTION
			WHEN NO_DATA_FOUND THEN
				BEGIN
					SELECT A.cod_central
					INTO   LV_CodCentral
					FROM   GA_ABOAMIST A
					WHERE  A.num_abonado = LN_NumAbonado;
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					    SV_mensaje   := 'Abonado no existe';
						SV_resultado := 'FALSE';
				END;
	   END;

	END IF;

    IF SV_resultado <> 'FALSE' then

        BEGIN
		    SELECT val_parametro
			INTO   LV_productoCel
			FROM   GED_PARAMETROS
			WHERE  NOM_PARAMETRO = 'PROD_CELULAR'
			AND    COD_MODULO = 'GA'
			AND    COD_PRODUCTO = 1;
		EXCEPTION
			WHEN OTHERS THEN
				 LV_productoCel := 1;
		END;

	    PV_HLRABONADO_PR(LV_CodCentral, LV_productoCel, LV_cod_hlr, LV_des_hlr, LV_coderror, LV_deserror);

		IF LV_cod_hlr <> LV_hlrsim THEN

			BEGIN
				SELECT NVL(b.des_hlr, ' ')
				INTO   SV_des_hlr
				FROM   ICG_HLRS b
				WHERE  b.cod_hlr = LV_hlrsim;
			EXCEPTION
					WHEN OTHERS THEN
						SV_des_hlr := ' ';
			END;

		    SV_mensaje   := 'HLR de la Simcard seleccionada (' ;
		    SV_mensaje   :=  CONCAT(SV_mensaje, SV_des_hlr);
			SV_des_hlr := ') , es distinto al HLR del numero celular.';
			SV_mensaje   :=  CONCAT(SV_mensaje, SV_des_hlr);
			SV_resultado := 'FALSE';

		END IF;

	END IF;

EXCEPTION
	WHEN NO_DATA_FOUND THEN
		SV_mensaje   := 'La Serie ingresada no existe';
		SV_resultado := 'FALSE';
	WHEN OTHERS THEN
		SV_resultado := 'FALSE';
		SV_mensaje   := 'Error validando HLR de la Simcard... : ' || SUBSTR(SQLERRM,1,60);

END PV_VALIDAHLR_ABOSIM_PR;
/
SHOW ERRORS
