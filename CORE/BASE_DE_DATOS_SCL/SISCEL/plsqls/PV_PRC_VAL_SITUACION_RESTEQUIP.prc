CREATE OR REPLACE PROCEDURE PV_PRC_VAL_SITUACION_RESTEQUIP (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

    string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO    	   GA_ABOCEL.NUM_ABONADO%TYPE;
     vACTABO     	   GA_ACTABO.COD_ACTABO%TYPE;
	 vSITUACION  	   GA_ABOCEL.COD_SITUACION%TYPE;
	 vTERMGSM	 	   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
	 vTIPTERMINAL	   GA_ABOCEL.TIP_TERMINAL%TYPE;
	 vDESSITUACION	   GA_SITUABO.DES_SITUACION%TYPE;
	 nCONTABONADO	   NUMBER;
	 ERROR_PROCESO EXCEPTION;


BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO 		:= TO_NUMBER(string(5));


     bRESULTADO := 'FALSE';
  	 vMENSAJE   := 'No se logro obtener Situación del Abonado - Tipo de Terminal';



	 --Inicio Incidencia RA-200511010039, PIC 09-11-2005.
     Begin
	    SELECT COD_SITUACION, TIP_TERMINAL
	    INTO   vSITUACION, vTIPTERMINAL
	    FROM   GA_ABOCEL
	    WHERE  NUM_ABONADO = nABONADO;


	 EXCEPTION
 	     WHEN NO_DATA_FOUND THEN
	         SELECT COD_SITUACION, TIP_TERMINAL
	         INTO   vSITUACION, vTIPTERMINAL
	         FROM   GA_ABOAMIST
	         WHERE  NUM_ABONADO = nABONADO;
	 end;

     --Fin incidencia RA-200511010039.


  	 vMENSAJE   := 'No se logro obtener Tip Terminal GSM';


	 SELECT VAL_PARAMETRO
	 INTO   vTERMGSM
	 FROM   GED_PARAMETROS
	 WHERE  NOM_PARAMETRO = 'COD_TERMINAL_GSM'
	 AND    COD_MODULO    = 'AL'
	 AND    COD_PRODUCTO  = 1;



	 IF vSITUACION ='SAA' OR vSITUACION = 'AOS' OR vSITUACION='ATS' OR  vSITUACION='CVS' OR  vSITUACION='RDS' OR vSITUACION='AAA' OR vSITUACION='RTP' THEN


		 bRESULTADO := 'TRUE';

		IF (vSITUACION='RTP') AND (vTIPTERMINAL <> vTERMGSM) AND (vTIPTERMINAL <> '') THEN

	      	   bRESULTADO := 'FALSE';
			   vMENSAJE   := 'No se encontro descripción de la situación actual del Abonado ' || vDESSITUACION || ' Se requiere que se encuentre en una de los siguientes estados: SAA - AOS - ATS - CVS - RDS - AAA - RTP';

			   SELECT DES_SITUACION
			   INTO   vDESSITUACION
			   FROM   GA_SITUABO
			   WHERE  COD_SITUACION = vSITUACION;

   	    END IF;



		SELECT COUNT(NUM_ABONADO)
		INTO   nCONTABONADO
		FROM   GA_SINIESTROS
		WHERE  NUM_ABONADO = nABONADO;


		IF nCONTABONADO <> 0 THEN
		   bRESULTADO := 'TRUE';
		ELSE
           bRESULTADO := 'FALSE';
           vMENSAJE   := 'El abonado NO tiene realizado un aviso de siniestro.';

		END IF;


	 ELSE


	      	   bRESULTADO := 'FALSE';
       		   vMENSAJE   := 'No se encontro descripción de la situación actual del Abonado : ' || vSITUACION ;

			   SELECT DES_SITUACION
			   INTO   vDESSITUACION
			   FROM   GA_SITUABO
			   WHERE  COD_SITUACION = vSITUACION;

     END IF;



     EXCEPTION
 	     WHEN NO_DATA_FOUND THEN
	          bRESULTADO := 'FALSE';
	          vMENSAJE   := vMENSAJE ;
	     WHEN OTHERS THEN
	          bRESULTADO := 'FALSE';
	          vMENSAJE   := vMENSAJE ;



END;
/
SHOW ERRORS
