CREATE OR REPLACE PROCEDURE VE_RECHAZO_TRANSITORIO_PR(
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
--Procedure  :   VE_RECHAZO_TRANSITORIO_PR()
--Descripcion:   Proceso de recepcion de documentos
--Obtenido de:	 FRMRechazoVentaCel.frm
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
v_sError         VARCHAR2(1) := '0';
v_sMess          VARCHAR2(60);
v_dFecActCen     DATE;
v_sCausaRechazo  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_sCausaDef      GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_sVal_Rut_Bind  VARCHAR2(1);
v_dfecha         DATE;
v_sDiasTope      GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_sCodSuspension GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_nSecuencia     NUMBER;
v_nNumCliente    GA_VENTAS.COD_CLIENTE%TYPE;
v_dDifFecha      NUMBER;

Error_retorno    exception;

BEGIN

	SELECT FEC_ACTCEN
      INTO v_dFecActCen
	  FROM GA_ABOCEL
	 WHERE NUM_VENTA = P_NNUMVENTA;

	IF v_dFecActCen IS NULL THEN
	   v_sError:='1';
	   v_sMess:='Para Rechazar la venta es necesario que los abonados esten activos en central.';
	   raise Error_retorno;
	END IF;


	--Si es Omitido
	IF P_SINDPROCESO='O' THEN

	   SELECT VAL_PARAMETRO
	     INTO v_sCausaRechazo
	     FROM GED_PARAMETROS
	    WHERE NOM_PARAMETRO = 'COD_CAURECT_OMITIDO'
          AND COD_MODULO = 'VE'
          AND COD_PRODUCTO = 1;

    ELSE

		v_sCausaRechazo := P_SCAUSARECHAZO;

	END IF;

	SELECT nvl(VAL_PARAMETRO, '1')
	  INTO v_sCausaDef
	  FROM GED_PARAMETROS
	 WHERE NOM_PARAMETRO = 'FRAUDE_SUSCRIPCION'
	   AND COD_MODULO = 'GA'
	   AND COD_PRODUCTO = 1;

	--Condiciona que sea Codigo de Fraude Por Suscripcion
	IF v_sCausaDef = v_sCausaRechazo THEN

		SELECT FECHA_CONT_TELEF
		  INTO v_dfecha
		  FROM GA_VENTAS
		 WHERE NUM_VENTA = P_NNUMVENTA;

		v_sVal_Rut_Bind := Ge_Fn_Ejecuta_Rutina_Bind('GA',1, TO_CHAR(P_NNUMVENTA) );

		if v_sVal_Rut_Bind = '0' then
           If v_dfecha is not null Then

				SELECT VAL_PARAMETRO
				  INTO v_sDiasTope
				  FROM GED_PARAMETROS
				 WHERE NOM_PARAMETRO = 'DIAS_MAX_FRAUDESUSCR'
				   AND COD_MODULO = 'GA'
				   AND COD_PRODUCTO = 1;

				 If v_sDiasTope = '' or v_sDiasTope is null Then
				    v_sDiasTope := '0';
                 End If;

				 v_dDifFecha := sysdate - v_dfecha; --Diferencia Fecha de contacto y Fecha de Sistema

				 If v_dDifFecha <= TO_NUMBER(v_sDiasTope) Then --Validacion 15 Dias
		   	        v_sError:='1';
					v_sMess := 'No puede Rechazar por esta Causal, No ha expirado';
					raise Error_retorno;
				 End If;
	       Else
		   	   v_sError:='1';
			   v_sMess := 'Debe Registrar Fecha de Contacto Telefonico';
			   raise Error_retorno;
	       End If;

		ELSIF v_sVal_Rut_Bind = '1' then
		   	   v_sError:='1';
			   v_sMess := 'El Cliente ha sido Contactado, en Plazo ' || TO_CHAR(sysdate - v_dfecha) || ' Dias';
			   raise Error_retorno;
		ELSIF v_sVal_Rut_Bind = '' then
		   	   v_sError:='1';
			   v_sMess := 'Debe Registrar Contacto Telefonico';
			   raise Error_retorno;

		End IF;

		--Si es no es Omitido
		IF P_SINDPROCESO='R' THEN
		   --Pendiente: ejecutar suspension
		   SELECT COD_CLIENTE
			 INTO v_nNumCliente
			 FROM GA_VENTAS
			WHERE NUM_VENTA = P_NNUMVENTA;

		   SELECT GA_SEQ_TRANSACABO.NEXTVAL
		     INTO v_nSecuencia
		     FROM DUAL;

           PP_RESRECVTA_HABSUS_ABO( v_nSecuencia, TO_CHAR(P_NNUMVENTA), TO_CHAR(v_nNumCliente), '1' );

		end if;

		--Si es Omitido
		IF P_SINDPROCESO='R' THEN
			UPDATE GA_VENTAS
			   SET IND_ESTVENTA = P_SESTDESTINO
			      ,COD_CAUSAREC = v_sCausaRechazo
				  ,NOM_USUAR_ACEREC = USER
				  ,FEC_ACEPREC=SYSDATE
	 		 WHERE NUM_VENTA = P_NNUMVENTA;
		ELSE
			UPDATE GA_VENTAS
			   SET COD_CAUSAREC = v_sCausaRechazo
				  ,NOM_USUAR_ACEREC = USER
				  ,FEC_ACEPREC=SYSDATE
	 		 WHERE NUM_VENTA = P_NNUMVENTA;
		END IF;
		 v_sCodSuspension := NULL;

		--Si es no es Omitido
		IF P_SINDPROCESO='R' THEN
			SELECT VAL_PARAMETRO
			  INTO v_sCodSuspension
			  FROM GED_PARAMETROS
			 WHERE NOM_PARAMETRO = 'COD_CAUSA_SUSPENSION';
	    End If;

		INSERT INTO ga_anulrech_th
		      (num_venta, cod_causa_rt, fec_rt, nom_usua_rt, cod_causa_susp)
		SELECT num_venta, cod_causarec, SYSDATE, USER, v_sCodSuspension
		  FROM ga_ventas
		 WHERE num_venta = P_NNUMVENTA;


	End If;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
        NULL;
   WHEN Error_retorno THEN
        O_ERROR := v_sError;
		O_MENSAJE := v_sMess;
   WHEN OTHERS THEN
		O_ERROR := SQLCODE;
		O_MENSAJE := 'VE_RECHAZO_TRANSITORIO_PR.' || SQLERRM;
END VE_RECHAZO_TRANSITORIO_PR;
/
SHOW ERRORS
