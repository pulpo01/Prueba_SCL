CREATE OR REPLACE PROCEDURE PV_VAL_SERIE_BODEGA (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------


	 nABONADO	 GA_ABOCEL.NUM_ABONADO%TYPE;
	 sSERIE		 GA_ABOCEL.NUM_SERIE%TYPE;

	 nCodArticulo   GA_EQUIPABOSER.COD_ARTICULO%TYPE;
	 nCodBodega		GA_EQUIPABOSER.COD_BODEGA%TYPE;
	 nTipStock		GA_EQUIPABOSER.TIP_STOCK%TYPE;
	 nCodEstado		GA_EQUIPABOSER.COD_ESTADO%TYPE;

	 nCodArticulo_1     AL_SERIES.COD_ARTICULO%TYPE;
	 nCodBodega_1		AL_SERIES.COD_BODEGA%TYPE;
	 nTipStock_1		AL_SERIES.TIP_STOCK%TYPE;
	 nCodEstado_1		AL_SERIES.COD_ESTADO%TYPE;

	 sCodGSM			ga_abocel.COD_TECNOLOGIA%TYPE;
	 sCodTecnologia     ga_abocel.COD_TECNOLOGIA%TYPE;
	 sNumImei           ga_abocel.NUM_IMEI%TYPE;
	 sIndEqPrestado     ga_abocel.IND_EQPRESTADO%TYPE;


	 RAISE_ERROR EXCEPTION;

BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
	 nABONADO       := TO_NUMBER(string(5));

     bRESULTADO := 'TRUE';

	 -- BUSCAMOS LA SERIE DEL ABONADO

	 	SELECT COD_TECNOLOGIA,NUM_SERIE,NUM_IMEI,IND_EQPRESTADO
		  INTO sCodTecnologia,sSERIE,sNumImei,sIndEqPrestado
		  FROM GA_ABOCEL
		 WHERE NUM_ABONADO = nABONADO;


 		IF ltrim(rtrim(sIndEqPrestado)) = '1' THEN   --COMODATO

			SELECT LTRIM(RTRIM(VAL_PARAMETRO))
    	 	  INTO sCodGSM
	   	 	  FROM GED_PARAMETROS
	    	 WHERE COD_MODULO    = 'GA'
	      	   AND NOM_PARAMETRO = 'TECNOLOGIA_GSM'
			   AND COD_PRODUCTO = 1;

			IF sCodGSM =  sCodTecnologia THEN
			   sSERIE := sNumImei;
		    END IF;

			BEGIN
				 -- BUSCAMOS LOS DATOS EN LA GA_EQUIPABOSER.
				SELECT TIP_STOCK, COD_ARTICULO
				  INTO nTipStock, nCodArticulo
				  FROM GA_EQUIPABOSER
				 WHERE NUM_ABONADO =nABONADO
				   AND NUM_SERIE=sSERIE
				   AND IND_EQUIACC = 'E'
				   AND FEC_ALTA = (SELECT MAX(FEC_ALTA)
				   	   			 	 FROM GA_EQUIPABOSER
								    WHERE NUM_ABONADO =nABONADO
			    					  AND NUM_SERIE=sSERIE
									  AND IND_EQUIACC = 'E');
				SELECT VAL_PARAMETRO
				  INTO nCodBodega
				  FROM GED_PARAMETROS
				 WHERE UPPER(NOM_PARAMETRO) = 'COD_BODEGA_COMODATO';

				SELECT COD_ESTADO_TEM
				  INTO nCodEstado
				  FROM AL_DATOS_GENERALES;

		    EXCEPTION
			    WHEN NO_DATA_FOUND THEN
			      bRESULTADO := 'FALSE';
				  vMENSAJE   := 'NO SE ENCUENTRAN DATOS DE LA SERIE.';
				  RAISE RAISE_ERROR;

			    WHEN OTHERS THEN
			      bRESULTADO := 'FALSE';
				  vMENSAJE   := 'PROBLEMAS AL BUSCAR DATOS DE LA SERIE.';
				  RAISE RAISE_ERROR;

		    END;

			BEGIN
				 -- BUSCAMOS LOS DATOS EN LA AL_SERIES.

				SELECT COD_ARTICULO, COD_BODEGA,TIP_STOCK, COD_ESTADO
				  INTO nCodArticulo_1,nCodBodega_1,nTipStock_1,nCodEstado_1
			      FROM AL_SERIES
			     WHERE NUM_SERIE = sSERIE;

		    EXCEPTION
			    WHEN NO_DATA_FOUND THEN
			      bRESULTADO := 'FALSE';
		 	      vMENSAJE   := 'SERIE NO EXISTE EN AL_SERIES.';
				  RAISE RAISE_ERROR;

			    WHEN OTHERS THEN
			      bRESULTADO := 'FALSE';
		 	      vMENSAJE   := 'PROBLEMAS AL BUSCAR SERIE EN AL_SERIES.';
				  RAISE RAISE_ERROR;

		    END;

			IF nCodBodega_1 <> nCodBodega OR nCodEstado_1 <> nCodEstado OR
			   nTipStock_1 <> nTipStock OR nCodArticulo_1 <> nCodArticulo THEN

			      bRESULTADO := 'FALSE';
		 	      vMENSAJE   := 'DATOS DE LA SERIE NO COINCIDEN (LOGISTICA-POSVENTA).';
				  RAISE RAISE_ERROR;

		    END IF;
	END IF;

    RAISE RAISE_ERROR;

EXCEPTION

	 WHEN RAISE_ERROR THEN
	      NULL;

	 WHEN NO_DATA_FOUND THEN
	      bRESULTADO := 'FALSE';
 	      vMENSAJE   := 'CLIENTE SIN CICLO VIGENTE.';

     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
		  vMENSAJE   := 'ERROR EN PV_VAL_CICLOFACTABO: NO SE PUEDE VALIDAR CICLO DE FACT. PARA ABONADOS DEL CLIENTE.';

END;
/
SHOW ERRORS
