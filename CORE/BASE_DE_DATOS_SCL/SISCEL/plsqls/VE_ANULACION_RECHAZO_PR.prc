CREATE OR REPLACE PROCEDURE VE_ANULACION_RECHAZO_PR(
P_SINDPROCESO    IN VARCHAR2,
P_NNUMVENTA      IN NUMBER,
P_NNUMTIPDOC     IN NUMBER,
P_NNUMFOLIO      IN NUMBER,
P_SESTDESTINO    IN VARCHAR2,
P_SCAUSARECHAZO  IN VARCHAR2,
P_SINDSUSPENSION IN VARCHAR2,
O_ERROR          OUT VARCHAR2,
O_MENSAJE        OUT VARCHAR2 )

IS
--
--Desarrollo :   Optimizacion del Circuito de la venta
--Procedure  :   VE_ANULACION_RECHAZO_PR()
--Descripcion:   Proceso de anulacion rechazo
--Obtenido de:	 FRMAnrchCe.frm
--Parametros :   Indicador de Proceso    : Indicador de ProcesoO"mitido /R"egular
--               Numero de la Venta      : Ingresada por usuario
--               Nuevo Vendedor          : Valores [(1) nuevo (0) no nuevo]
--               Usuario                 : Codigo usuario
--               Codigo Vendedor         : Codigo Vendedor
--               Nuevo Tipo Comision     :
--               Causa de Rechazo        :
--               Estado Destino          :
--Retorno    :   O_ERROR
--               '0'   se hizo todo correcto
--               '1'   se produjeron errores
--

v_sCausaRechazo   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_nParam          boolean:= true;

BEGIN
	--Si es Omitido
	IF P_SINDPROCESO='O' THEN
		BEGIN
			SELECT VAL_PARAMETRO
			  INTO v_sCausaRechazo
			  FROM GED_PARAMETROS
			 WHERE NOM_PARAMETRO = 'COD_ANUREC_OMITIDO'
			   AND COD_MODULO    = 'VE'
			   AND COD_PRODUCTO  = 1;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				v_nParam:=false;
				O_ERROR := SQLCODE;
				O_MENSAJE := 'GED_PARAMETROS NO HAY DATOS (PL)VE_ANULACION_RECHAZO_PR ' || SQLERRM;
			WHEN OTHERS THEN
				v_nParam:=false;
				O_ERROR := SQLCODE;
				O_MENSAJE := 'SELECT GED_PARAMETROS (PL)VE_ANULACION_RECHAZO_PR ' || SQLERRM;
		END;
	ELSE
		v_sCausaRechazo := P_SCAUSARECHAZO;

		BEGIN
			UPDATE GA_VENTAS
			   SET IND_ESTVENTA = P_SESTDESTINO
			 WHERE NUM_VENTA = P_NNUMVENTA;

		EXCEPTION
			WHEN OTHERS THEN
				O_ERROR := SQLCODE;
				O_MENSAJE := 'UPDATE GA_VENTAS (PL)VE_ANULACION_RECHAZO_PR ' || SQLERRM;
		END;
	END IF;

	If v_nParam Then
	  BEGIN
	    UPDATE GA_ANULRECH_TH
	       SET   COD_CAUSA_ANULRE = v_sCausaRechazo,
	             NOM_USUA_ANULRE  = USER,
	             FEC_ANULRE       = SYSDATE,
	             COD_VEND_NVO     = NULL,
	             COD_TIP_COMIS_NVO= NULL
	       WHERE NUM_VENTA =  P_NNUMVENTA;

	    EXCEPTION
	     WHEN OTHERS THEN
	         O_ERROR := SQLCODE;
	         O_MENSAJE := 'UPDATE GA_ANULRECH_TH (1) (PL)VE_ANULACION_RECHAZO_PR ' || SQLERRM;
	  END;
	End If;
END VE_ANULACION_RECHAZO_PR;
/
SHOW ERRORS
