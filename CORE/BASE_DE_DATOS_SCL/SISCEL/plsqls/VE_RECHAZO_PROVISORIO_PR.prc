CREATE OR REPLACE PROCEDURE VE_RECHAZO_PROVISORIO_PR(
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
--Procedure  :   VE_RECHAZO_PROVISORIO_PR()
--Descripcion:   Proceso de rechazo provisorio
--Obtenido de:	 FRMRechProvi.frm
--Parametros :   Indicador de Proceso    : Indicador de Proceso "O"mitido / "R"egular
--               Numero de la Venta      : Ingresada por usuario
--               Tipo de Documento       : Numero de documento de Boleta o Factura
--               Numero de Folio         :
--               Estado Destino          :
--               Causa de Rechazo        :
--               Indicador de Suspension :
--Retorno    :   O_ERROR
--               '0'   se hizo todo correcto
--               '1'   se produjeron errores
--
--DBMS_OUTPUT.PUT_LINE('Problemas en p_del_equipabonoser');
v_sCausaRechazo  GED_PARAMETROS.VAL_PARAMETRO%TYPE;

BEGIN

	--Si es Omitido
	IF P_SINDPROCESO='O' THEN

	   SELECT VAL_PARAMETRO
	     INTO v_sCausaRechazo
	     FROM GED_PARAMETROS
	    WHERE NOM_PARAMETRO = 'COD_CAURECP_OMITIDO'
          AND COD_MODULO = 'VE'
          AND COD_PRODUCTO = 1;

    ELSE

	   v_sCausaRechazo := P_SCAUSARECHAZO;

	END IF;

	IF P_SINDPROCESO='R' THEN
		UPDATE GA_VENTAS
		   SET COD_CAUSAREP = v_sCausaRechazo
		      ,FEC_RECPROV = SYSDATE
		      ,NOM_USUAR_RECPROV = USER
		      ,NUM_DIAS = 0
		      ,IND_ESTVENTA = P_SESTDESTINO
		      ,OBS_RECPROV = ''
		WHERE NUM_VENTA = P_NNUMVENTA;
	ELSE
		UPDATE GA_VENTAS
		   SET COD_CAUSAREP = v_sCausaRechazo
		      ,FEC_RECPROV = SYSDATE
		      ,NOM_USUAR_RECPROV = USER
		      ,NUM_DIAS = 0
		      ,OBS_RECPROV = ''
		WHERE NUM_VENTA = P_NNUMVENTA;
	END IF;



EXCEPTION
   WHEN NO_DATA_FOUND THEN
        NULL;
   WHEN OTHERS THEN
		O_ERROR := SQLCODE;
		O_MENSAJE := 'VE_RECHAZO_PROVISORIO_PR ' || SQLERRM;
END VE_RECHAZO_PROVISORIO_PR;
/
SHOW ERRORS
