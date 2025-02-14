CREATE OR REPLACE PROCEDURE VE_REGULA_DATOS_PROCESOS_PR(
VP_TRANSAC       IN  VARCHAR2,
P_SPROCESO       IN VARCHAR2,
P_SINDPROCESO    IN VARCHAR2,
P_NNUMVENTA      IN NUMBER,
P_STIPODOC       IN VARCHAR2,
P_NNUMFOLIO      IN NUMBER,
P_SESTDESTINO    IN VARCHAR2,
P_SCAUSARECHAZO  IN VARCHAR2,
P_SINDSUSPENSION IN VARCHAR2,
O_ERROR          OUT VARCHAR2,
O_MENSAJE        OUT VARCHAR2 )
IS
--
--Desarrollo :   Optimizacion del Circuito de la venta
--Procedure  :   VE_REGULA_DATOS_PROCESOS_PR()
--Descripcion:   Regularizacion de datos de Procesos Omitidos / Regular
--Parametros :   Nombre Proceso          : Proceso a ejecutar
--               Indicador de Proceso    : Indicador de Proceso "O"mitido / "R"egular
--               Numero de la Venta      : Ingresada por usuario
--               Tipo de Documento       :
--               Numero de Folio         :
--               Estado Destino          :
--               Causa de Rechazo        :
--               Indicador de Suspension :
--Retorno    :   O_ERROR
--               '0'   se hizo todo correcto
--               '1'   se produjeron errores
--
--Recepcion de Documentos
--Rechazo Transitorio
--Rechazo Provisorio
--Rechazo Definitivo
--Anulacion Rechazo Transitorio
--Aceptacion de la Venta

--PENDIENTE
-- 			Colocar valor de los procesos
--
--DBMS_OUTPUT.PUT_LINE('Problemas en p_del_equipabonoser');

v_error VARCHAR2 (1) := '0';
v_mess  VARCHAR2(200);

BEGIN
    IF P_SPROCESO = 'GAC1034' THEN
	   --Recepcion de Documentos
	   VE_RECEPCION_DOCUMENTOS_PR(P_SINDPROCESO,
                               P_NNUMVENTA,
                               P_STIPODOC,
                               P_NNUMFOLIO,
                               P_SESTDESTINO,
                               P_SCAUSARECHAZO,
                               P_SINDSUSPENSION,
                               v_error,
                               v_mess );
    ELSIF P_SPROCESO = 'GAM1025' OR P_SPROCESO = 'GAC1036' THEN
	   --Rechazo Transitorio
	   VE_RECHAZO_TRANSITORIO_PR(P_SINDPROCESO,
                              P_NNUMVENTA,
                              P_STIPODOC,
                              P_NNUMFOLIO,
                              P_SESTDESTINO,
                              P_SCAUSARECHAZO,
                              P_SINDSUSPENSION,
                              v_error,
                              v_mess );
    ELSIF P_SPROCESO = 'GAC103K' THEN
       --Rechazo Provisorio
	   VE_RECHAZO_PROVISORIO_PR(P_SINDPROCESO,
                              P_NNUMVENTA,
                              P_STIPODOC,
                              P_NNUMFOLIO,
                              P_SESTDESTINO,
                              P_SCAUSARECHAZO,
                              P_SINDSUSPENSION,
                              v_error,
                              v_mess );
    --ELSIF P_SPROCESO = 'GAC1020' THEN
    ELSIF P_SPROCESO = 'GAC1030' THEN
       --Rechazo Definitivo

	   VE_RECHAZO_DEFINITIVO_PG.VE_RECHAZO_DEFINITIVO(P_SINDPROCESO,
                              P_NNUMVENTA,
                              P_STIPODOC,
                              P_NNUMFOLIO,
                              P_SESTDESTINO,
                              P_SCAUSARECHAZO,
                              P_SINDSUSPENSION,
                              v_error,
                              v_mess );
    ELSIF P_SPROCESO = 'GAC103M' THEN
       --Anulacion Rechazo Transitorio
	   VE_ANULACION_RECHAZO_PR(P_SINDPROCESO,
                            P_NNUMVENTA,
                            P_STIPODOC,
                            P_NNUMFOLIO,
                            P_SESTDESTINO,
                            P_SCAUSARECHAZO,
                            P_SINDSUSPENSION,
                            v_error,
                            v_mess );

    ELSIF P_SPROCESO = 'GAC1035' Or P_SPROCESO = 'GAM1024' THEN
       --Aceptacion de la Venta
	   VE_ACEPTACION_VENTA_PR(P_SINDPROCESO,
                           P_NNUMVENTA,
                           P_STIPODOC,
                           P_NNUMFOLIO,
                           P_SESTDESTINO,
                           P_SCAUSARECHAZO,
                           P_SINDSUSPENSION,
                           v_error,
                           v_mess );
    END IF;

	--Asigna variables de error --
	O_ERROR:=v_error;
	O_MENSAJE:=v_mess;

	if v_error is null then
	   v_error := '0';
	end if;

	INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
	VALUES (VP_TRANSAC, TO_NUMBER(v_error), v_mess);


EXCEPTION
   WHEN OTHERS THEN
		O_ERROR:=v_error;
		O_MENSAJE:=v_mess;
		if O_ERROR is null then
		   O_ERROR:='1';
		end if;

		INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
		VALUES (VP_TRANSAC, TO_NUMBER(v_error), NULL);

END VE_REGULA_DATOS_PROCESOS_PR;
/
SHOW ERRORS
