CREATE OR REPLACE PROCEDURE ST_VAL_REEMPLAZO_PR
	   (
       v_param_entrada IN  VARCHAR2,
       bRESULTADO      OUT VARCHAR2,
       vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
	   )
IS
     string SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nNUMABONADO SP_ORDENES_REPARACION.NUM_ABONADO%TYPE;
	 cINDREEM  CHAR(1);

BEGIN

     Ge_Pac_Arreglopr.GE_PR_RetornaArreglo(v_param_entrada, string);
     nNUMABONADO:= TO_NUMBER(string(5));
     bRESULTADO := 'TRUE';


	 BEGIN
		 SELECT IND_PROCED_REEM INTO cINDREEM
	       FROM SP_ORDENES_REPARACION
	      WHERE NUM_ABONADO = nNUMABONADO;

	 EXCEPTION
	 WHEN NO_DATA_FOUND THEN
	     bRESULTADO := 'FALSE';
	     vMENSAJE:='Abonado no tiene equipo en Servicio Tecnico';
	 END;

     IF cINDREEM = 'I' THEN
       bRESULTADO := 'TRUE';
	 ELSE
	   bRESULTADO := 'FALSE';
	   vMENSAJE:='Abonado no posee equipo en reemplazo';
     END IF;

EXCEPTION
   WHEN OTHERS THEN
      bRESULTADO := 'FALSE';
      vMENSAJE:='Problemas en Restriccion ST_VAL_REEMPLAZO_PR';

END;
/
SHOW ERRORS
