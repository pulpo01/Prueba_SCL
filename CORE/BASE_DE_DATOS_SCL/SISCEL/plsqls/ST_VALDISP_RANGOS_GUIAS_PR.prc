CREATE OR REPLACE PROCEDURE ST_VALDISP_RANGOS_GUIAS_PR
		(
		v_param_entrada IN  VARCHAR2,
        bRESULTADO      OUT VARCHAR2,
        vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
		)
IS

     string siscel.GE_TABTYPE_VCH2ARRAY:= siscel.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO     GA_ABOCEL.NUM_ABONADO%TYPE;
     vUSUARORA    GE_SEG_USUARIO.NOM_USUARIO%TYPE;
	 vCOD_OFICINA GE_SEG_USUARIO.COD_OFICINA%TYPE;
	 vCOD_OFICINA2 GE_SEG_USUARIO.COD_OFICINA%TYPE;
	 nCOD_DOCGUIA GA_DATOSGENER.COD_DOCGUIA%TYPE;
	 nRAN_USADO	  AL_ASIG_DOCUMENTOS.RAN_USADO%TYPE;

------------------------------------------------

     vCantidad NUMBER(2) := 0;

BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     vUSUARORA 	:= STRING(10);

     bRESULTADO := 'TRUE';
	 vMENSAJE 	:= 'ST_VALDISP_RANGOS_GUIAS_PR';

	 BEGIN
	    SELECT COD_OFICINA
	      INTO vCOD_OFICINA2
	      FROM GE_SEG_USUARIO
	     WHERE NOM_USUARIO = vUSUARORA;

		 SELECT FA_FOLIACION_PG.FA_OFICINA_CONSUMO_FN(vCOD_OFICINA2)
		 INTO	vCOD_OFICINA
		 FROM dual;

		 BEGIN
		    SELECT COD_DOCGUIA INTO nCOD_DOCGUIA FROM GA_DATOSGENER;

			 BEGIN
			    SELECT RAN_USADO INTO nRAN_USADO
			      FROM AL_ASIG_DOCUMENTOS
			     WHERE COD_OFICINA  = vCOD_OFICINA
			       AND COD_TIPDOCUM = nCOD_DOCGUIA
			       AND RAN_USADO    <> RAN_HASTA
			       AND COD_VENDEDOR IS NULL
			       AND ROWNUM 		< 2;

			 EXCEPTION
			    WHEN NO_DATA_FOUND THEN
				   	 bRESULTADO := 'FALSE';
			 	   	 vMENSAJE   := 'ERROR ST_VALDISP_RANGOS_GUIAS_PR, No se dispone de rangos de guias. No se realizara el envio.';
		     END;

		 EXCEPTION
		    WHEN NO_DATA_FOUND THEN
			   	 bRESULTADO := 'FALSE';
		 	   	 vMENSAJE   := 'ERROR ST_VALDISP_RANGOS_GUIAS_PR, No se encontro Codigo de Documento guia.';
		 END;

	 EXCEPTION
	    WHEN NO_DATA_FOUND THEN
			 bRESULTADO := 'FALSE';
	 	   	 vMENSAJE   := 'ERROR ST_VALDISP_RANGOS_GUIAS_PR, No se encontro Codigo de Oficina.';
	 END;

EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN ST_VALDISP_RANGOS_GUIAS_PR: NO SE PUEDE VALIDAR RANGOS DE GUIAS.' || SQLERRM || '.';

END;
/
SHOW ERRORS
