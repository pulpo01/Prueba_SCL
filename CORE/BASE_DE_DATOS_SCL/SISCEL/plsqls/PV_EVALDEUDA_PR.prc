CREATE OR REPLACE PROCEDURE PV_EVALDEUDA_PR(
	   	  		  							v_param_entrada IN  VARCHAR2,
											bRESULTADO   	OUT VARCHAR2,
          									vMENSAJE     	OUT GA_TRANSACABO.DES_CADENA%TYPE)
IS
    string SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	---- parametros reales de entrada --------------
    sCodCliente	  GA_ABOCEL.COD_CLIENTE%TYPE;
        --Ini RA-200511010017 04/11/2005 EFR/POSTVENTA
	--sCodCategoria GE_CLIENTES.COD_CATEGORIA%TYPE;
	sCodCategoria VARCHAR2(5);
	--Fin RA-200511010017 04/11/2005 EFR/POSTVENTA
	sCodTasa	  CO_CATEGORIAS_TD.cod_tasa%TYPE;
	------------------------------------------------
    Sdiasaplic      NUMBER;
  	Sdeuda 	        CO_CARTERA.IMPORTE_DEBE%TYPE;
	sDeudaPermitida CO_CARTERA.IMPORTE_DEBE%TYPE;

	sCodProceso		GAD_PROCESOS_PERFILES.COD_PROCESO%TYPE;
	sAux			GAD_PROCESOS_PERFILES.COD_PROCESO%TYPE;
    sSimMoneda      GED_PARAMETROS.VAL_PARAMETRO%TYPE;
BEGIN
	GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
    sCodCliente	:= TO_NUMBER(string(6));

	SELECT VAL_PARAMETRO
	  INTO sDeudaPermitida
	  FROM GED_PARAMETROS
	 WHERE COD_MODULO = 'GA'
	   AND COD_PRODUCTO = 1
	   AND NOM_PARAMETRO = 'DEUDA_ABONADO';
       
	SELECT VAL_PARAMETRO
	  INTO sSimMoneda
	  FROM GED_PARAMETROS
	 WHERE COD_MODULO = 'GE'
	   AND COD_PRODUCTO = 1
	   AND NOM_PARAMETRO = 'SIM_MONEDA';       

    SELECT COD_PROCESO INTO sCodProceso FROM GAD_PROCESOS_PERFILES WHERE NOM_PERFIL_PROCESO = 'PER_PL_PERMISO';

	BEGIN
	    SELECT A.COD_PROCESO
		  INTO sAux
	     FROM  GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B
	     WHERE B.NOM_USUARIO  IN (SELECT USER FROM DUAL)
	     AND   A.COD_GRUPO    = B.COD_GRUPO
	     AND   A.COD_PROCESO  = sCodProceso
	     AND ROWNUM 		  = 1;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 sAux:=NULL;
	END;

	IF sAux IS NOT NULL THEN
	   bRESULTADO := 'TRUE';
	ELSE

		SELECT COD_CATEGORIA
		  INTO sCodCategoria
		  FROM GE_CLIENTES
		 WHERE COD_CLIENTE = sCodCliente;


		SELECT COD_TASA
		  INTO sCodTasa
		  FROM CO_CATEGORIAS_TD
		 WHERE COD_CATEGORIA = sCodCategoria;


		SELECT DIAS_APLICACION
		  INTO Sdiasaplic
		  FROM CO_INTERESES
		 WHERE COD_TASA = sCodTasa
		   AND SYSDATE BETWEEN FEC_VIGENCIA_DD_DH AND FEC_VIGENCIA_HH_DH;

		SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)
		  INTO Sdeuda
		  FROM CO_CARTERA
		 WHERE COD_CLIENTE   = sCodCliente
		   --AND IND_FACTURADO = 2
		   AND IND_FACTURADO = 1
		   AND FEC_VENCIMIE  < TRUNC(SYSDATE)
		   AND FEC_VENCIMIE  + Sdiasaplic  < TRUNC(SYSDATE)
		   AND COD_TIPDOCUM  NOT IN (SELECT TO_NUMBER(COD_VALOR)
		   	   					       FROM CO_CODIGOS
		 							  WHERE NOM_TABLA   = 'CO_CARTERA'
									    AND NOM_COLUMNA = 'COD_TIPDOCUM');

		IF Sdeuda <= sDeudaPermitida THEN
		   bRESULTADO := 'TRUE';
		ELSE
           
		   vMENSAJE   := 'No puede realizar OOSS para este abonado, Debe Regularizar deuda de '|| sSimMoneda ||' '|| sDeuda;
		   bRESULTADO := 'FALSE';  --CLIENTE CON DEUDA --
		END IF;
	END IF;

EXCEPTION
     WHEN OTHERS THEN
          vMENSAJE   := 'ERROR EN PV_EVALDEUDA_PR: NO SE PUEDE VALIDAR DEUDA DEL ABONADO.';
		  bRESULTADO := 'FALSE';
END PV_EVALDEUDA_PR;
/
SHOW ERRORS
