CREATE OR REPLACE PROCEDURE        PV_PRC_VAL_SITUACIONCLIENTE (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

	 vPROGRAMA	 	   	  		GE_SEG_PERFILES.COD_PROGRAMA%TYPE;
	 vVERSION	 				GE_SEG_PERFILES.NUM_VERSION%TYPE;
	 nABONADO    				GA_ABOCEL.NUM_ABONADO%TYPE;
	 vACTABO     				GA_ACTABO.COD_ACTABO%TYPE;
	 nCODCLIENTE 				GA_ABOCEL.COD_CLIENTE%TYPE;
	 vPERFILPROCESO				GAD_PROCESOS_PERFILES.NOM_PERFIL_PROCESO%TYPE;

------------------------------------------------
     v_param_salida      VARCHAR2(2000) := '';
     v_param_entrada_cte VARCHAR2(2000) := '';
	 v_param_entrada_cte2 VARCHAR2(2000) := '';
     v_comando_sql       VARCHAR2(2000) := '';
     V_param_ok          VARCHAR(5);


	 vCodCuentaFinal VARCHAR2(2) := 'XX';
	 vGenCuentaFinal VARCHAR2(2) := 'CF';

	 v_nom_rutina    pv_restricciones.nom_rutina%TYPE;
	 vCodCausaBaja   ga_abocel.cod_causabaja%TYPE;
	 nIndAnulacion   ga_causabaja.ind_anulacion%TYPE;




BEGIN

	 v_nom_rutina := 'PV_PRC_VAL_PERMISOS';

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
	 nCODCLIENTE	:= TO_NUMBER(string(6));
     nABONADO 		:= TO_NUMBER(string(5));
     vACTABO  		:= string(4);
	 vVERSION 		:= string(2);
	 vPROGRAMA 		:= string(1);

     bRESULTADO := 'TRUE';



     SELECT IND_SITUACION
     INTO   vCodCuentaFinal
     FROM   GE_CLIENTES
     WHERE  COD_CLIENTE = nCODCLIENTE;


     SELECT A.COD_CAUSABAJA
     INTO   vCodCausaBaja
     FROM   GA_ABOCEL A
     WHERE  A.NUM_ABONADO    = nABONADO
     AND    A.COD_SITUACION IN (SELECT COD_SITUACION
                                FROM   PVD_ACTUACION_SITUACION B
                                WHERE  B.COD_PRODUCTO  = A.COD_PRODUCTO
                                AND    B.COD_ACTABO    = vACTABO
                                AND    B.COD_SITUACION = A.COD_SITUACION);


   	 vPERFILPROCESO	:= '';
     IF vCodCuentaFinal = vGenCuentaFinal THEN
	 	vPERFILPROCESO := 'COD_PROC_ANUBAJAFINAL';
	 ELSE
		vPERFILPROCESO := 'COD_PROC_ANUBAJA';
	 END IF;

  	 v_param_entrada_cte := '';
	 v_param_entrada_cte2 := '|' || vPROGRAMA || '|' || vVERSION || '|' || vPERFILPROCESO || '|' || vACTABO || '|' ;

--                  v_param_entrada_cte := ':v_param_entrada,:V_param_ok,:v_param_salida';
--                  v_comando_sql:= 'BEGIN ' || v_nom_rutina||'('|| v_param_entrada_cte ||'); END;';
--                    EXECUTE IMMEDIATE v_comando_sql USING IN v_param_entrada, OUT V_param_ok, OUT v_param_salida;

 	-- Valida permiso usuario para anaular baja de cuenta final
     v_param_entrada_cte := ':v_param_entrada,:V_param_ok,:v_param_salida';
     v_comando_sql:= 'BEGIN ' || v_nom_rutina||'('|| v_param_entrada_cte ||'); END;';
     EXECUTE IMMEDIATE v_comando_sql USING IN v_param_entrada_cte2, OUT V_param_ok, OUT v_param_salida;

	 IF V_param_ok = 'FALSE' THEN

	 	SELECT IND_ANULACION
		INTO   nIndAnulacion
		FROM   GA_CAUSABAJA
		WHERE  COD_CAUSABAJA = vCodCausaBaja
		AND    COD_PRODUCTO  = 1;

		IF nIndAnulacion <> 1 THEN
	       bRESULTADO := 'FALSE';
	       vMENSAJE   := 'NO ESTA PERMITIDA LA ANULACION DE LA BAJA DEL ABONADO';
		END IF;

	END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PRC_VAL_SITUACIONCLIENTE: NO SE PUEDE VALIDAR SITUACION DEL CLIENTE.' || SQLERRM || '.';


END;
/
SHOW ERRORS
