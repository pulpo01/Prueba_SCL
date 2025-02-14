CREATE OR REPLACE PROCEDURE PV_PRC_VAL_LISTA_NEGRA_PR (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
     vSERIE      VARCHAR2(25);
     vTip_Lista  GA_LNCELU.TIP_LISTA%TYPE := 'B';
     ICOUNT      INTEGER;
------------------------------------------------

BEGIN

     SISCEL.GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO           := TO_NUMBER(string(5));
     vSERIE             := '';
	 ICOUNT             := 0;
     bRESULTADO         :='TRUE';

     SELECT NVL(NUM_SERIE,'0')
     INTO   vSERIE
     FROM   GA_ABOCEL
     WHERE  NUM_ABONADO = nABONADO
     union
     SELECT NUM_SERIE
	 FROM   GA_ABOAMIST
     WHERE  NUM_ABONADO = nABONADO;

	 IF vSERIE <> '0' THEN

		BEGIN


    		SELECT  COUNT(NUM_SERIE) INTO ICOUNT
    		FROM GA_LNCELU
    		WHERE NUM_SERIE = vSERIE
            AND   TIP_LISTA = vTip_Lista;

		    IF ICOUNT = 0 THEN

			   bRESULTADO := 'TRUE';
      		   vMENSAJE   := 'ERROR EN PV_PRC_VAL_LISTA_NEGRA_PR:SERIE NO SE ENCUENTRA REGISTRADO EN LISTAS NEGRAS';

			ELSE
			   bRESULTADO := 'FALSE';
      		   vMENSAJE   := 'ERROR EN PV_PRC_VAL_LISTA_NEGRA_PR:SERIE SE ENCUENTRA REGISTRADO EN LISTAS NEGRAS';



		    END IF;

		EXCEPTION
				 WHEN NO_DATA_FOUND THEN
	    		      bRESULTADO := 'TRUE';
	          		  vMENSAJE   := 'ERROR EN PV_PRC_VAL_LISTA_NEGRA_PR:SERIE NO SE ENCUENTRA REGISTRADO EN LISTAS NEGRAS';

         	     WHEN OTHERS THEN
                      bRESULTADO := 'FALSE';
                      vMENSAJE   := 'ERROR EN PV_PRC_VAL_LISTA_NEGRA_PR: NO SE PUEDE VALIDAR LISTA NEGRA PARA EL ABONADO';


	 	END;

	 ELSE

	 	bRESULTADO := 'FALSE';
	    vMENSAJE   := 'ERROR EN PV_PRC_VAL_LISTA_NEGRA_PR:NO SE PUEDE VALIDAR LISTA NEGRA PARA EL ABONADO';

	 END IF;



EXCEPTION
		 WHEN NO_DATA_FOUND THEN
	          bRESULTADO := 'FALSE';
	          vMENSAJE   := 'ERROR EN PV_PRC_VAL_LISTA_NEGRA_PR:SERIE NO SE ENCUENTRA REGISTRADO EN LISTAS NEGRAS';


         WHEN OTHERS THEN
              bRESULTADO := 'FALSE';
              vMENSAJE   := 'ERROR EN PV_PRC_VAL_LISTA_NEGRA_PR: NO SE PUEDE VALIDAR LISTA NEGRA PARA EL ABONADO';

END;
/
SHOW ERRORS