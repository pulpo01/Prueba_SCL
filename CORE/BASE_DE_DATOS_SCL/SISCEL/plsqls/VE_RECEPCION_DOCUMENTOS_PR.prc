CREATE OR REPLACE PROCEDURE VE_RECEPCION_DOCUMENTOS_PR(
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
--Procedure  :   VE_RECEPCION_DOCUMENTOS_PR()
--Descripcion:   Proceso de recepcion de documentos
--Obtenido de:	 FRMRecDocuVentaCel.frm
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
v_sMess          VARCHAR2(50);
v_dRecDocum      DATE;
v_dActCen        DATE;
v_sCodTipComis   GA_VENTAS.COD_TIPCOMIS%TYPE;
v_sCodVendAgente GA_VENTAS.COD_VENDEDOR_AGENTE%TYPE;
--v_sDealerInterno GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_sTipComis      VE_TIPCOMIS.IND_VTA_EXTERNA%TYPE;
v_bDealer        BOOLEAN;
v_nIndConsig     NUMBER;
v_nDocDealer     GA_DATOSGENER.COD_DOCBOLETA%TYPE;
v_nNumFolio      NUMBER;
v_nFound         NUMBER;

Error_retorno    exception;

BEGIN

-- 	SELECT FEC_RECDOCUM, FEC_ACTCEN
-- 	  INTO v_dRecDocum, v_dActCen
--       FROM GA_ABOCEL
--      WHERE NUM_VENTA = P_NNUMVENTA;  --No es llave!!!


--	IF not (v_dRecDocum IS NOT NULL OR v_dActCen IS NULL) THEN
		v_nNumFolio := P_NNUMFOLIO;

		SELECT COD_TIPCOMIS, COD_VENDEDOR_AGENTE
		  INTO v_sCodTipComis, v_sCodVendAgente
		  FROM GA_VENTAS
		 WHERE NUM_VENTA = P_NNUMVENTA;

--		SELECT VAL_PARAMETRO
--		  INTO v_sDealerInterno
--		  FROM GED_PARAMETROS
--		 WHERE NOM_PARAMETRO = 'DEALER_INTERNO'
--		   AND COD_MODULO='GA'
--		   AND COD_PRODUCTO=1;

		SELECT ind_vta_externa
		  INTO v_sTipComis
		  FROM ve_tipcomis
		 WHERE COD_TIPCOMIS = v_sCodTipComis;

		--Validacion para caso especial de CTC.
--		If v_sTipComis = v_sDealerInterno Then
--		   v_sTipComis := '0';
--		end if;

	    --Es venta dealer y consignacion
		v_bDealer := false;
		if v_sTipComis = '1' then
		   v_bDealer:=true;
		end if;

		SELECT COUNT(1)
		  INTO v_nIndConsig
		  FROM GA_ABOCEL A, GA_PRELIQUIDACION B
		 WHERE A.NUM_VENTA = P_NNUMVENTA
		   AND A.NUM_VENTA = B.NUM_VENTA;

		If v_bDealer And v_nIndConsig > 0 Then

			--Si es Omitido
			if P_SINDPROCESO='O' then
				--Obtener los parametros segun documentacion

				SELECT VE_NUMFOLIO_SQ.NEXTVAL
				  INTO v_nNumFolio
				  FROM DUAL;

			   	  SELECT COD_DOCBOLETA
				  INTO v_nDocDealer
				  FROM GA_DATOSGENER;
			else
				--Utilizar los parametros
				v_nNumFolio := P_NNUMFOLIO;
				v_nDocDealer := P_NNUMTIPDOC;
			end if;

			SELECT NUM_VENTA
			  INTO v_nFound
			  FROM GA_PRELIQUIDACION
			 WHERE NUM_FOLDEALER = v_nNumFolio
			   AND COD_DOCDEALER = v_nDocDealer
			   AND NUM_VENTA <> P_NNUMVENTA
			   AND COD_MASTER_DEALER = v_sCodVendAgente;

			if v_nFound is null then
			    --Ingreso de folio del distribuidor a preliquidacion
			    UPDATE GA_PRELIQUIDACION
				   SET NUM_FOLDEALER = v_nNumFolio,
			           COD_DOCDEALER = v_nDocDealer,
			           IND_ESTVENTA = 'PC'
			    WHERE NUM_VENTA = P_NNUMVENTA;
			Else
				v_sError:='1';
				v_sMess	:='Numero de Documento Ya existe para este MASTER DEALER';
				raise Error_retorno;
			END IF;

		end if;

		--En caso que sea un proceso regular
		if P_SINDPROCESO='R' and v_sTipComis = '1' and v_bDealer And v_nIndConsig > 0 then
		   --Todo el update
			UPDATE GA_VENTAS SET
			       IND_ESTVENTA = P_SESTDESTINO
			      ,NOM_USUAR_RECDOC = USER
			      ,FEC_RECDOCUM = SYSDATE
			      ,USU_RECEP_ADMVTAS = USER
			      ,FEC_RECEP_ADMVTAS = SYSDATE
			      ,NUM_FOLDEALER = v_nNumFolio
			      ,COD_DOCDEALER = v_nDocDealer
			 WHERE NUM_VENTA = P_NNUMVENTA;
		ELSIF P_SINDPROCESO='R' and v_sTipComis = '1' and not (v_bDealer And v_nIndConsig > 0) then
			UPDATE GA_VENTAS SET
			       IND_ESTVENTA = P_SESTDESTINO
			      ,NOM_USUAR_RECDOC = USER
			      ,FEC_RECDOCUM = SYSDATE
			      ,USU_RECEP_ADMVTAS = USER
			      ,FEC_RECEP_ADMVTAS = SYSDATE
			 WHERE NUM_VENTA = P_NNUMVENTA;
		ELSIF P_SINDPROCESO='R' and v_sTipComis <> '1' and v_bDealer And v_nIndConsig > 0 then
			UPDATE GA_VENTAS SET
			       IND_ESTVENTA = P_SESTDESTINO
			      ,NOM_USUAR_RECDOC = USER
			      ,FEC_RECDOCUM = SYSDATE
			      ,NUM_FOLDEALER = v_nNumFolio
			      ,COD_DOCDEALER = v_nDocDealer
			 WHERE NUM_VENTA = P_NNUMVENTA;
		ELSIF P_SINDPROCESO='R' and v_sTipComis <> '1' and not (v_bDealer And v_nIndConsig > 0) then
			UPDATE GA_VENTAS SET
			       IND_ESTVENTA = P_SESTDESTINO
			      ,NOM_USUAR_RECDOC = USER
			      ,FEC_RECDOCUM = SYSDATE
			 WHERE NUM_VENTA = P_NNUMVENTA;
		--En caso que sea un proceso Omitido
		ELSIF P_SINDPROCESO='O' and v_sTipComis = '1' and v_bDealer And v_nIndConsig > 0 then
		   --Todo el update
			UPDATE GA_VENTAS SET
			       NOM_USUAR_RECDOC = USER
			      ,FEC_RECDOCUM = SYSDATE
			      ,USU_RECEP_ADMVTAS = USER
			      ,FEC_RECEP_ADMVTAS = SYSDATE
			      ,NUM_FOLDEALER = v_nNumFolio
			      ,COD_DOCDEALER = v_nDocDealer
			 WHERE NUM_VENTA = P_NNUMVENTA;
		ELSIF P_SINDPROCESO='O' and v_sTipComis = '1' and not (v_bDealer And v_nIndConsig > 0) then
			UPDATE GA_VENTAS SET
			       NOM_USUAR_RECDOC = USER
			      ,FEC_RECDOCUM = SYSDATE
			      ,USU_RECEP_ADMVTAS = USER
			      ,FEC_RECEP_ADMVTAS = SYSDATE
			 WHERE NUM_VENTA = P_NNUMVENTA;
		ELSIF P_SINDPROCESO='O' and v_sTipComis <> '1' and v_bDealer And v_nIndConsig > 0 then
			UPDATE GA_VENTAS SET
			       NOM_USUAR_RECDOC = USER
			      ,FEC_RECDOCUM = SYSDATE
			      ,NUM_FOLDEALER = v_nNumFolio
			      ,COD_DOCDEALER = v_nDocDealer
			 WHERE NUM_VENTA = P_NNUMVENTA;
		ELSIF P_SINDPROCESO='O' and v_sTipComis <> '1' and not (v_bDealer And v_nIndConsig > 0) then
			UPDATE GA_VENTAS SET
			       NOM_USUAR_RECDOC = USER
			      ,FEC_RECDOCUM = SYSDATE
			 WHERE NUM_VENTA = P_NNUMVENTA;
		END IF;

		UPDATE GA_ABOCEL
		   SET FEC_RECDOCUM = SYSDATE,
		       FEC_ULTMOD = SYSDATE
		 WHERE NUM_VENTA = P_NNUMVENTA;

--	END IF;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
        NULL;
   WHEN OTHERS THEN
   		DBMS_OUTPUT.PUT_LINE(SQLERRM);
        O_ERROR := v_sError;
		O_MENSAJE := v_sMess;
END VE_RECEPCION_DOCUMENTOS_PR;
/
SHOW ERRORS
