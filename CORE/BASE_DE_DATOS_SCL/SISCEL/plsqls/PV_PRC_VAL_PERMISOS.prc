CREATE OR REPLACE PROCEDURE        PV_PRC_VAL_PERMISOS(
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

	 vPROGRAMA	     GE_SEG_PERFILES.COD_PROGRAMA%TYPE;
	 vVERSION	     GE_SEG_PERFILES.NUM_VERSION%TYPE;
	 nABONADO    	 GA_ABOCEL.NUM_ABONADO%TYPE;
	 vACTABO     	 GA_ACTABO.COD_ACTABO%TYPE;
	 nCODCLIENTE 	 GA_ABOCEL.COD_CLIENTE%TYPE;
     vPERFILPROCESO	 GAD_PROCESOS_PERFILES.NOM_PERFIL_PROCESO%TYPE;

------------------------------------------------



	 vCodProceso	 VARCHAR2(7) := 'X';
	 vGenCodProceso	 VARCHAR2(7) := 'X';

BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     vACTABO  		:= string(4);
	 vPERFILPROCESO	:= string(3);
	 vVERSION 		:= string(2);
	 vPROGRAMA 		:= string(1);


     bRESULTADO := 'TRUE';

     SELECT COD_PROCESO
     INTO   vGenCodProceso
     FROM   GAD_PROCESOS_PERFILES
     WHERE  NOM_PERFIL_PROCESO = vPERFILPROCESO;


	 SELECT A.COD_PROCESO
	 INTO   vCodProceso
	 FROM   GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B
	 WHERE  A.COD_GRUPO    = B.COD_GRUPO
	 AND    B.NOM_USUARIO  IN (SELECT USER FROM DUAL)
	 AND    A.COD_PROGRAMA = vPROGRAMA
	 AND    A.NUM_VERSION  = vVERSION
	 AND    A.COD_PROCESO  = vGenCodProceso;



	 ---- Valida permiso usuario para anaular baja de cuenta final
     IF vCodProceso <> vGenCodProceso THEN

		 bRESULTADO := 'FALSE';
         vMENSAJE   := 'NO ESTA PERMITIDA LA ANULACION DE LA BAJA POR CUENTA FINAL';

     END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PRC_VAL_PERMISOS: PARA REALIZAR ANULACION BAJA POR CUENTA FINAL.' || SQLERRM || '.';


END;
/
SHOW ERRORS
