CREATE OR REPLACE PROCEDURE pv_valida_ospend_cexcep_pr (
--Verifica si existe OoSs pendiente
    	  v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
	 nCLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
     vACTABO     GA_ACTABO.COD_ACTABO%TYPE;

------------------------------------------------

     vCantidad         NUMBER(3);
	 --n_estado_mensaje  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
     iTIPESTADOA        NUMBER(2);
	 iCODESTADO        NUMBER(3);
	 iTIPESTADOB        NUMBER(2);
	 iCODESTCANCELADA	NUMBER(2);


BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
	 vACTABO  		:= string(4);
	 nABONADO 		:= -1;
     nABONADO 		:= TO_NUMBER(string(5));
	 nCLIENTE       := -1;
	 nCLIENTE       := TO_NUMBER(string(6));

     bRESULTADO  := 'FALSE';
	 vCantidad   := 0;
	 iTIPESTADOA := 3;
	 iTIPESTADOB := 1;


	 BEGIN

		 SELECT VAL_PARAMETRO
		 INTO iCODESTADO
		 FROM GED_PARAMETROS
		 WHERE NOM_PARAMETRO = 'ESTADO_PV_MENSAJE';

		 EXCEPTION
			 WHEN NO_DATA_FOUND THEN
	             bRESULTADO := 'FALSE';
	             vMENSAJE   := 'NO SE ENCONTRO PARAMETRO ESTADO_PV_MENSAJES EN GED_PARAMETROS.' || SQLERRM || '.';

     END;

	 BEGIN

		 SELECT VAL_PARAMETRO
		 INTO iCODESTCANCELADA
		 FROM GED_PARAMETROS
		 WHERE NOM_PARAMETRO = 'EST_BAJA_CANCELADA';

		 EXCEPTION
			 WHEN NO_DATA_FOUND THEN
	             bRESULTADO := 'FALSE';
	             vMENSAJE   := 'NO SE ENCONTRO PARAMETRO EST_BAJA_CANCELADA EN GED_PARAMETROS.' || SQLERRM || '.';

     END;


	 BEGIN
	     IF nABONADO <> -1 THEN
	     --Si la OOSS es por un abonado

	        SELECT 1
			INTO vCantidad
			FROM pv_iorserv a, pv_camcom b, pv_erecorrido c
		    WHERE a.num_os = b.num_os
		   	AND a.num_os = c.num_os
		   	AND b.num_os = c.num_os
		   	AND b.num_abonado = nABONADO
		   	AND a.cod_estado < iCODESTADO
			AND a.cod_estado <> iCODESTCANCELADA
		   	AND a.cod_estado = c.cod_estado
		  	AND ( c.tip_estado = iTIPESTADOA OR c.tip_estado = iTIPESTADOB)
			AND NOT EXISTS(SELECT 1 FROM ged_codigos g
						   WHERE g.cod_modulo='GA'
						   AND g.nom_tabla = 'EXCEP_OS_PEND'
						   AND g.nom_columna = vACTABO
						   AND g.cod_valor = a.cod_os )
			AND ROWNUM=1;

		  ELSIF nCLIENTE <> -1 THEN
		  --Si la OOSS es por un Cliente

			  SELECT 1
			  INTO vCantidad
			  FROM pv_iorserv a, pv_camcom b, pv_erecorrido c
		      WHERE a.num_os = b.num_os
		   	  AND a.num_os = c.num_os
		   	  AND b.num_os = c.num_os
		   	  AND b.cod_cliente = ncliente
		   	  AND a.cod_estado < iCODESTADO
			  AND a.cod_estado <> iCODESTCANCELADA
		   	  AND a.cod_estado = c.cod_estado
		  	  AND ( c.tip_estado = iTIPESTADOA OR c.tip_estado = iTIPESTADOB)
			  AND NOT EXISTS(SELECT 1 FROM ged_codigos g
							   WHERE g.cod_modulo='GA'
							   AND g.nom_tabla = 'EXCEP_OS_PEND'
							   AND g.nom_columna = vACTABO
							   AND g.cod_valor = a.cod_os )
			  AND ROWNUM=1;

	      END IF;
	  EXCEPTION
	  		   WHEN NO_DATA_FOUND THEN
			   		vCantidad := 0;
	  END;

      IF vCantidad = 0 THEN
	  	 bRESULTADO := 'TRUE';
	  ELSE
        bRESULTADO := 'FALSE';
        vMENSAJE   := 'ABONADO TIENE ORDEN DE SERVICIO PENDIENTE';
      END IF;

EXCEPTION
   WHEN OTHERS THEN
        bRESULTADO := 'FALSE';
        vMENSAJE   := 'ERROR EN PV_PRC_EJECUTA_OSPENDIENTES: NO SE PUEDE VALIDAR OOSS PENDIENTES.' || SQLERRM || '.';

END;
/
SHOW ERRORS
