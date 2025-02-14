CREATE OR REPLACE PACKAGE BODY VE_RECHAZO_DEFINITIVO_PG AS
Error_retorno    exception;
Error_retorno_ok exception;
Error_retorno_i  exception;
/* ************************************************************** */
/* CUERPO DEL PACKAGE, CON LA DEFINICION DE LAS FUNCIONES.        */
/* ************************************************************** */
PROCEDURE VE_RECHAZO_DEFINITIVO(
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
--Procedure  :   VE_RECHAZO_DEFINITIVO()
--Descripcion:   Proceso de rechazo definitivo
--Obtenido de:	 FRMAnulacionRechazoVentaCel.frm
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

v_dFec_ActCen     GA_ABOCEL.FEC_ACTCEN%TYPE;
v_sNumTransaccion NUMBER;
v_sNumProceso     VARCHAR2(255);
bCorrecto         BOOLEAN;
v_bProcesar       BOOLEAN;
v_PROD_CELULAR    GE_DATOSGENER.PROD_CELULAR%TYPE;
v_nValorVenta	  GA_VENTAS.IMP_VENTA%TYPE;


CURSOR c_cada_abonados IS
SELECT NUM_ABONADO
  FROM GA_ABOCEL
 WHERE NUM_VENTA = P_NNUMVENTA
   AND COD_SITUACION = 'REA';

CURSOR c_cada_abon IS
SELECT FEC_ACTCEN
  FROM GA_ABOCEL
 WHERE NUM_VENTA = P_NNUMVENTA;


BEGIN

-- 	SELECT FEC_ACTCEN
-- 	  INTO v_dFec_ActCen
-- 	  FROM GA_ABOCEL
-- 	 WHERE NUM_VENTA = P_NNUMVENTA;

	-- preparando cursor para carga de arreglo cod_paramdir
	--Revisa que todos sus abonados esten activados en centrales --
	v_bProcesar:=TRUE;

	OPEN c_cada_abon;
	LOOP
		FETCH c_cada_abon INTO v_dFec_ActCen;
		EXIT WHEN c_cada_abon%NOTFOUND;
		BEGIN
			IF v_dFec_ActCen IS NULL THEN
			   v_bProcesar:=FALSE;		   --No esta activo no se procesa los omitidos aun --
			END IF;
		END;
	END LOOP;
	CLOSE c_cada_abon;

	IF v_bProcesar THEN

--	IF v_dFec_ActCen IS NOT NULL THEN

	   if bEjecutarRechazoDefinitivo( P_SINDPROCESO
                                     ,P_NNUMVENTA
                                     ,P_NNUMTIPDOC
                                     ,P_NNUMFOLIO
                                     ,P_SESTDESTINO
                                     ,P_SCAUSARECHAZO
                                     ,P_SINDSUSPENSION
                                     ,v_sError
                                     ,v_sMess) then
           If bCargosRechazados( P_NNUMVENTA, v_sError, v_sMess ) Then
				If bvTipComis(P_NNUMVENTA) = '1' Then  --Es distribuidor
				   --Se debe generar cargos al cliente del distribuidor y actaulizar preliquidacion
				   If Not bActPreliq( P_NNUMVENTA, P_SCAUSARECHAZO) then
					  v_sError:='1';
					  v_sMess:='Error al Actualizar Preliquidacion....';
					  RAISE Error_retorno;
				   End If;
				End If;

				SELECT IMP_VENTA
				  INTO v_nValorVenta
				  FROM GA_VENTAS
				 WHERE NUM_VENTA = P_NNUMVENTA;

				if bValidaEjecNC(P_NNUMVENTA) AND v_nValorVenta <> 0 THEN

					SELECT GA_SEQ_TRANSACABO.NEXTVAL
					  INTO v_sNumTransaccion
					  FROM DUAL;

				    If Not bCallPlLiquidacion(P_NNUMVENTA,
					                          v_sNumTransaccion,
											  v_sNumProceso,
                                              v_sError,
											  v_sMess) then
					   RAISE Error_retorno;
				    End If;
				    If v_sNumProceso <> '' Then
				        If Not bInsertSolicLiq(P_NNUMVENTA,
						                       v_sNumProceso,
                                               v_sError,
											   v_sMess) then
                           RAISE Error_retorno;
				        End If;
				    End If;
				End If;


		   else
		   	   v_sError:='1';
		   	   v_sMess:='Error al Generar Cargos Rechazados...';
			   RAISE Error_retorno;
		   end if;
           --NO VA! Lanza movimientos en central
           --NO VA! mnok = iDBTransact(tCon, SQL_COMMIT)
           --NO VA! mnok = bLanzaDLLMovimientos()

		   --Carga Variables Globales de GE_DATOSGENER
		   SELECT PROD_CELULAR
			 INTO v_PROD_CELULAR
			 FROM GE_DATOSGENER;

           bCorrecto := False;
		   FOR CADA_ABONADO IN c_cada_abonados LOOP
				bCorrecto := True;
				--Una vez ejecutado el rechazo, hay que dar de baja los abonados
				If bReutilCelular(cada_abonado.NUM_ABONADO, v_PROD_CELULAR) Then

				   if not bDarBajaAbonado(cada_abonado.NUM_ABONADO, v_PROD_CELULAR) then

				        v_sError:='1';
						v_sMess:='Error en bDarBajaAbonado().';
						raise Error_retorno;

				   end if;

				End If;
		   End Loop;

           If Not bCorrecto Then
              -- No se ha podido realizar la baja de forma automatica,
              -- porque el movimiento del rechazo no se ha ejecutado todavia.
			  -- esto es un warning
		   	   v_sError:='2';
		   	   v_sMess:='Los abonados no han podido ser dados de baja de forma automatica. Debera utilizar la opcion Baja de Abonados Rechazados.';
			   RAISE Error_retorno;
           End If;

	   else
	   	   v_sError:='1';
	   	   v_sMess:='No se pudo proceder al RECHAZO DEFINITIVO de la venta N? ' || P_NNUMVENTA;
		   RAISE Error_retorno;
	   end if;
	ELSE
        v_sError:='1';
		v_sMess:='Para Rechazar la venta es necesario que los abonados esten activos en central.';
		raise Error_retorno;
	END IF;

	--Termino sin error
    O_ERROR := '0';
	O_MENSAJE := '';

EXCEPTION
   WHEN NO_DATA_FOUND THEN
        NULL;
   WHEN Error_retorno THEN
        O_ERROR := v_sError;
		O_MENSAJE := v_sMess;
   WHEN OTHERS THEN
		O_ERROR := SQLCODE;
		O_MENSAJE := 'VE_RECHAZO_DEFINITIVO.' || SQLERRM;
END VE_RECHAZO_DEFINITIVO;
/* ************************************************************** */
FUNCTION bEjecutarRechazoDefinitivo(
P_SINDPROCESO    IN VARCHAR2,
P_NNUMVENTA      IN NUMBER,
P_NNUMTIPDOC     IN NUMBER,
P_NNUMFOLIO      IN NUMBER,
P_SESTDESTINO    IN VARCHAR2,
P_SCAUSARECHAZO  IN VARCHAR2,
P_SINDSUSPENSION IN VARCHAR2,
O_ERROR          OUT VARCHAR2,
O_MENSAJE        OUT VARCHAR2 )

RETURN BOOLEAN IS

CURSOR c_cada_abonados IS
SELECT NUM_ABONADO, NUM_SERIE
  FROM GA_ABOCEL
 WHERE NUM_VENTA = P_NNUMVENTA;

BEGIN

	IF P_SINDPROCESO='R' then
		UPDATE GA_VENTAS
		   SET IND_ESTVENTA = P_SESTDESTINO
		      ,COD_CAUSAREC = P_SCAUSARECHAZO
		      ,NOM_USUAR_ACEREC = USER
		      ,FEC_ACEPREC=SYSDATE
		 WHERE NUM_VENTA = P_NNUMVENTA;
	ELSE
		UPDATE GA_VENTAS
		   SET COD_CAUSAREC = P_SCAUSARECHAZO
		      ,NOM_USUAR_ACEREC = USER
		      ,FEC_ACEPREC=SYSDATE
		 WHERE NUM_VENTA = P_NNUMVENTA;
	END IF;


    If Not bGeneraMovimientos(P_NNUMVENTA, O_ERROR, O_MENSAJE) Then
		RAISE Error_retorno;
    End If;

	--...Continuacion bEjecutarRechazoDefinitivo

	--cursor por cada abonado
	FOR CADA_ABONADO IN c_cada_abonados LOOP
        --Por cada abonado correspondiente a la venta
		If Not bLlamarPLBaja(CADA_ABONADO.NUM_ABONADO,
		                     CADA_ABONADO.NUM_SERIE,
                             O_ERROR,
		                     O_MENSAJE ) Then
		   RAISE Error_retorno;
		End If;

		If Not bDevolucionAlmacen(P_NNUMVENTA,
		                          CADA_ABONADO.NUM_ABONADO,
		                          CADA_ABONADO.NUM_SERIE,
                                  O_ERROR,
		                          O_MENSAJE ) Then
		   RAISE Error_retorno;
		end if;

		If Not bInsertRechazos(P_NNUMVENTA,
		                       CADA_ABONADO.NUM_ABONADO,
		                       CADA_ABONADO.NUM_SERIE,
                               O_ERROR,
		                       O_MENSAJE ) Then
		   RAISE Error_retorno;
		end if;

		--nTipMov =  BAJA_CCONTROL = 2
		If Not bRegMovCControlada(P_NNUMVENTA,
		                          CADA_ABONADO.NUM_ABONADO,
		                          CADA_ABONADO.NUM_SERIE,
							      2,
                                  O_ERROR,
		                          O_MENSAJE ) Then
		   RAISE Error_retorno;
		end if;

		--PATO: Homologacion Paquete 22 (23-09-2003). CH-150720031058
		--Soporte Incidencia CH-150720031053  17-07-2003
		--Se adiciona UPDATE por numero de abonado
		--El objetivo es que el PL P_INTERFASES_ABONADO
		--de baja al abonado 'cero' en el caso de los clientes empresas
		UPDATE GA_ABOCEL
		   SET COD_SITUACION = 'REP',
		       FEC_ULTMOD = SYSDATE
		WHERE NUM_ABONADO = CADA_ABONADO.NUM_ABONADO;

	END LOOP;

	UPDATE GA_ABOCEL
	   SET COD_SITUACION = 'REP'
	       ,FEC_ULTMOD = SYSDATE
     WHERE NUM_VENTA = P_NNUMVENTA;


	RETURN TRUE;

EXCEPTION
	WHEN Error_retorno_i THEN
		RETURN FALSE;
	WHEN OTHERS THEN
		 RAISE;
END bEjecutarRechazoDefinitivo;


/* ************************************************************** */
FUNCTION bCargosRechazados(P_NNUMVENTA IN NUMBER,
                           v_sError    OUT VARCHAR2,
    	                   v_sMess     OUT VARCHAR2)
RETURN BOOLEAN IS

CURSOR c_cargos_rechazados IS
SELECT B.NUM_CARGO,B.COD_CLIENTE,B.COD_PRODUCTO,B.COD_CICLFACT,
       B.COD_CONCEPTO,B.IMP_CARGO,B.COD_MONEDA,B.NUM_UNIDADES,
       B.NUM_PAQUETE,B.NUM_ABONADO,B.NUM_TERMINAL,B.NUM_SERIE,
       B.CAP_CODE,B.COD_CONCEPTO_DTO,B.VAL_DTO,B.TIP_DTO,B.IND_CUOTA, B.ROWID
  FROM GE_CARGOS B, GA_ABOCEL A
 WHERE A.NUM_VENTA=P_NNUMVENTA
   AND A.COD_CLIENTE=B.COD_CLIENTE
   AND A.NUM_ABONADO=B.NUM_ABONADO
   AND TRUNC(B.FEC_ALTA)=TRUNC(A.FEC_ALTA)
   AND B.NUM_VENTA= 0
   FOR UPDATE NOWAIT;

BEGIN

	FOR CADA_CARGO IN c_cargos_rechazados LOOP
		--esto era la funcion bIngresaCargos()
		--Por cada cargo de la venta y abonado
		--Insercion en Cargos Rechazados

		BEGIN
			INSERT INTO GA_CARGOS_RECHAZADOS
				(NUM_VENTA, NUM_CARGO, COD_CLIENTE, COD_PRODUCTO, COD_CICLFACT, NUM_TRANSACCION, COD_CONCEPTO, IMP_CARGO,
				COD_MONEDA, NUM_UNIDADES, NOM_USUARIO, NUM_PAQUETE, NUM_ABONADO, NUM_TERMINAL, NUM_SERIE, CAP_CODE,
				COD_CONCEPTO_DTO, VAL_DTO,TIP_DTO,IND_CUOTA)
			VALUES (P_NNUMVENTA,CADA_CARGO.NUM_CARGO,CADA_CARGO.COD_CLIENTE,CADA_CARGO.COD_PRODUCTO,CADA_CARGO.COD_CICLFACT,0,
			        CADA_CARGO.COD_CONCEPTO,CADA_CARGO.IMP_CARGO,CADA_CARGO.COD_MONEDA,CADA_CARGO.NUM_UNIDADES,USER,
			        CADA_CARGO.NUM_PAQUETE,CADA_CARGO.NUM_ABONADO,CADA_CARGO.NUM_TERMINAL,CADA_CARGO.NUM_SERIE,
			        CADA_CARGO.CAP_CODE,CADA_CARGO.COD_CONCEPTO_DTO,CADA_CARGO.VAL_DTO,CADA_CARGO.TIP_DTO,CADA_CARGO.IND_CUOTA);

		EXCEPTION
			WHEN OTHERS THEN
	             v_sError := SQLCODE;
		         v_sMess  := 'INSERT INTO GA_CARGOS_RECHAZADOS (PKG)VE_RECHAZO_DEFINITIVO.bCargosRechazados ' || SQLERRM;
			     RAISE Error_retorno_i;
		END;

		--Elimina Cargo de GE_CARGOS
		DELETE GE_CARGOS WHERE ROWID = CADA_CARGO.ROWID;

	END LOOP;

	RETURN TRUE;
EXCEPTION
	WHEN Error_retorno_i THEN
		RETURN FALSE;
	WHEN OTHERS THEN
		 RAISE;
END bCargosRechazados;
/* ************************************************************** */
FUNCTION bLlamarPLBaja(NUM_ABONADO IN NUMBER,
                       NUM_SERIE   IN NUMBER,
                       v_sError    OUT VARCHAR2,
    	               v_sMess     OUT VARCHAR2)
RETURN BOOLEAN IS
Error_retorno_i  exception;

v_sCodActAbo   VARCHAR2(2);
v_nSecuencia   NUMBER;
v_PROD_CELULAR GE_DATOSGENER.PROD_CELULAR%TYPE;
v_sCodSalida   VARCHAR2(1);
v_sCadSalida   VARCHAR2(100);

BEGIN

   v_sCodActAbo := sCodActAbo_PlanHibrido(NUM_ABONADO);   --si el tipo de Plan tarifario es hibrido, cambia el CodActAbo   [pmolina 11-03-2003]
   If v_sCodActAbo = '' or v_sCodActAbo is null then
      v_sCodActAbo := 'BA';  --[pmolina 11-03-2003]  baja de abonado
   end if;

   SELECT GA_SEQ_TRANSACABO.NEXTVAL
     INTO v_nSecuencia
     FROM DUAL;

   SELECT PROD_CELULAR
	 INTO v_PROD_CELULAR
	 FROM GE_DATOSGENER;

   p_interfases_abonados(v_nSecuencia, v_sCodActAbo, v_PROD_CELULAR, NUM_ABONADO, '', '', '', v_sCodSalida, v_sCadSalida, '');



   if v_sCodSalida = '4' then
   	  v_sError:='1';
	  v_sMess:='Error Ejecutando P_Interfases_Abonados  no se ha ejecutado correctamente.';
	  RAISE Error_retorno_i;
   end if;

   RETURN TRUE;

EXCEPTION
	WHEN Error_retorno_i THEN
		RETURN FALSE;
	WHEN OTHERS THEN
		 RAISE;
END bLlamarPLBaja;

/* ************************************************************** */
FUNCTION bDevolucionAlmacen(P_NNUMVENTA IN NUMBER,
                            PNUM_ABONADO IN NUMBER,
                            NUM_SERIE   IN NUMBER,
                            v_sError    OUT VARCHAR2,
    	                    v_sMess     OUT VARCHAR2)
RETURN BOOLEAN IS
Error_retorno_i  exception;

v_nCodModVenta    GA_VENTAS.COD_MODVENTA%TYPE;
v_nINDCUOTAS      GE_MODVENTA.IND_CUOTAS%TYPE;
v_CodArticulo     GA_EQUIPABOSER.COD_ARTICULO%TYPE;
v_CodBodega       GA_EQUIPABOSER.COD_BODEGA%TYPE;
v_CodStock        GA_EQUIPABOSER.TIP_STOCK%TYPE;
v_CodEstado       GA_EQUIPABOSER.COD_ESTADO%TYPE;
v_CodUso          GA_EQUIPABOSER.COD_USO%TYPE;
v_NumSerie        GA_EQUIPABOSER.NUM_SERIE%TYPE;
v_IND_PROCEQUI    GA_EQUIPABOSER.IND_PROCEQUI%TYPE;
v_cod_causarec    GA_VENTAS.cod_causarec%TYPE;
v_sCodCategoria   VE_CATPLANTARIF.COD_CATEGORIA%TYPE;
v_sCodTipcontrato GA_ABOCEL.COD_TIPCONTRATO%TYPE;
v_sNumMeses       GA_PERCONTRATO.NUM_MESES%TYPE;
v_sFecMaxDev      VARCHAR2(10);
v_sModContrato    VARCHAR2(8);
v_Ind_Comodato    GA_TIPCONTRATO.IND_COMODATO%TYPE;
v_sCodProducto    GA_VENTAS.COD_PRODUCTO%TYPE;
v_sCodCliente     GA_ABOCEL.COD_CLIENTE%TYPE;
v_sTipComis       GA_VENTAS.COD_TIPCOMIS%TYPE;
v_dFecMaxDev      DATE;
v_sEstado         VARCHAR2(1);
CURSOR C_CADA_ARTICULO IS
	SELECT COD_ARTICULO
	       ,COD_BODEGA
	       ,TIP_STOCK
	       ,COD_ESTADO
	       ,COD_USO
	       ,NUM_SERIE
		   ,IND_PROCEQUI
	  FROM GA_EQUIPABOSER
	 WHERE NUM_ABONADO = PNUM_ABONADO
	   AND IND_EQUIACC = 'E'
	   AND FEC_ALTA = (SELECT MAX(FEC_ALTA)
	                     FROM GA_EQUIPABOSER
	                    WHERE NUM_ABONADO = PNUM_ABONADO );


BEGIN

	SELECT COD_MODVENTA
      INTO v_nCodModVenta
	  FROM GA_VENTAS
	 WHERE NUM_VENTA = P_NNUMVENTA;

	SELECT IND_CUOTAS
	  INTO v_nINDCUOTAS
	  FROM GE_MODVENTA
	 WHERE COD_MODVENTA = v_nCodModVenta;


	FOR CADA_ARTICULO IN C_CADA_ARTICULO LOOP

		v_CodArticulo  :=CADA_ARTICULO.COD_ARTICULO;
		v_CodBodega    :=CADA_ARTICULO.COD_BODEGA;
		v_CodStock     :=CADA_ARTICULO.TIP_STOCK;
		v_CodEstado    :=CADA_ARTICULO.COD_ESTADO;
		v_CodUso       :=CADA_ARTICULO.COD_USO;
		v_NumSerie     :=CADA_ARTICULO.NUM_SERIE;
		v_IND_PROCEQUI :=CADA_ARTICULO.IND_PROCEQUI;

	End Loop;


	--+wjrc/ITS [15.11.2002]
	SELECT cod_causarec, COD_TIPCOMIS
	  INTO v_cod_causarec, v_sTipComis
	  FROM GA_VENTAS
	 WHERE num_venta = P_NNUMVENTA;
	---wjrc/ITS

    If v_IND_PROCEQUI = 'I' Then
		SELECT COD_CATEGORIA
		  INTO v_sCodCategoria
		  FROM VE_CATPLANTARIF
		 WHERE COD_PLANTARIF = (SELECT COD_PLANTARIF
		                          FROM GA_ABOCEL
								 WHERE NUM_ABONADO = PNUM_ABONADO);

		SELECT COD_TIPCONTRATO, COD_CLIENTE, COD_TIPCONTRATO
		  INTO v_sCodTipcontrato, v_sCodCliente, v_sCodTipcontrato
		  FROM GA_ABOCEL
		 WHERE NUM_ABONADO = PNUM_ABONADO;

		SELECT NUM_MESES
		  INTO v_sNumMeses
		  FROM GA_PERCONTRATO
		 WHERE COD_TIPCONTRATO = v_sCodTipcontrato;

        BEGIN
			SELECT TO_CHAR(SYSDATE + DIAS_DEVOLUCION)     ---,['" + gsFormato_sel2 + " " + gsFormato_sel7 + "'])
			  INTO v_sFecMaxDev
			  FROM GAD_PLAZO_DEVDIF
			 WHERE COD_TIPCONTRATO = v_sCodTipcontrato
			   AND NUM_MESES = v_sNumMeses
			   AND COD_OPERACION = 'RV'
			   AND IND_CAUSA = 1
			   AND COD_CAUSA = v_cod_causarec
			   AND COD_CATEGORIA = v_sCodCategoria
			   AND COD_CANAL_VTA = bvTipComis(P_NNUMVENTA)
			   AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
		EXCEPTION
			WHEN OTHERS THEN
		       v_sFecMaxDev:=NULL;
		END;


		IF v_sFecMaxDev IS NULL THEN

		   BEGIN
			   SELECT TO_CHAR(SYSDATE + TO_NUMBER(VAL_PARAMETRO))  ---,['" + gsFormato_sel2 + " " + gsFormato_sel7 + "'])
			     INTO v_sFecMaxDev
			     FROM GED_PARAMETROS
				WHERE NOM_PARAMETRO = 'NUM_DIAS_MAXDEV';
			EXCEPTION
				WHEN OTHERS THEN
			       v_sFecMaxDev:=NULL;
			END;

		END IF;

		SELECT COD_PRODUCTO
		  INTO v_sCodProducto
		  FROM GA_VENTAS
		 WHERE NUM_VENTA = P_NNUMVENTA;

		SELECT IND_COMODATO
		  INTO v_Ind_Comodato
		  FROM GA_TIPCONTRATO
		 WHERE COD_PRODUCTO = v_sCodProducto
		   AND COD_TIPCONTRATO = v_sCodTipcontrato;

        IF v_nINDCUOTAS = '2' THEN
            v_sModContrato := 'ARRIENDO';
        ELSIF v_nINDCUOTAS = '-1' Or v_Ind_Comodato = '1' THEN
            v_sModContrato := 'COMODATO';
        ELSE
            v_sModContrato := 'SUBSIDIO';
        END IF;

		if v_sFecMaxDev is not null then
		   v_dFecMaxDev:= TO_DATE(v_sFecMaxDev);
		ELSE
		   v_dFecMaxDev:= SYSDATE;
		end if;

		if bvTipComis(P_NNUMVENTA) = '1' then
		   v_sEstado := 'E';
		else
		   v_sEstado := 'I';
		end if;

		INSERT INTO GAT_EQUIPOS_DEVDIF
		 (COD_CLIENTE, NUM_ABONADO, NUM_SERIE, COD_TIPMOV, COD_OPERACION, COD_CAUSA, FEC_INGRESO, NOM_USUARIO
		, COD_ESTADO_DEV, FEC_MAXIMA_DEV, IND_COBRO, NUM_CARGO, FEC_DEVOLUCION, NOM_USUARIO_RECEPTOR, NUM_VENTA
		, IND_CANAL, MOD_CONTRATO)
		 VALUES ( v_sCodCliente,  PNUM_ABONADO,  v_NumSerie,  '1',  'RV',  v_cod_causarec,  SYSDATE, USER, 'ND',
		 v_dFecMaxDev, NULL,NULL,NULL,NULL, P_NNUMVENTA,  v_sEstado,  v_sTipComis);

	end if;

	RETURN TRUE;

EXCEPTION
	WHEN Error_retorno_i THEN
		RETURN FALSE;
	WHEN OTHERS THEN
		v_sError := SQLCODE;
		v_sMess := 'VE_RECHAZO_DEFINITIVO:bDevolucionAlmacen.' || SQLERRM;
END bDevolucionAlmacen;

/* ************************************************************** */
FUNCTION bInsertRechazos(P_NNUMVENTA  IN NUMBER,
                         PNUM_ABONADO IN NUMBER,
                         PNUM_SERIE   IN NUMBER,
                         v_sError     OUT VARCHAR2,
                         v_sMess      OUT VARCHAR2)
RETURN BOOLEAN IS
Error_retorno_i  exception;

v_cod_causarec    GA_VENTAS.cod_causarec%TYPE;
v_sTipComis       GA_VENTAS.COD_TIPCOMIS%TYPE;
v_COD_CLIENTE     GA_ABOCEL.COD_CLIENTE%TYPE;
v_NUM_CELULAR     GA_ABOCEL.NUM_CELULAR%TYPE;
v_NUM_CONTRATO    GA_ABOCEL.NUM_CONTRATO%TYPE;
v_IND_PROCEQUI    GA_ABOCEL.IND_PROCEQUI%TYPE;
v_FEC_VENTA       GA_VENTAS.FEC_VENTA%TYPE;
v_FEC_RECDOCUM    GA_VENTAS.FEC_RECDOCUM%TYPE;
v_cod_producto    GA_VENTAS.COD_PRODUCTO%TYPE;
v_sCodVendAgte    GA_VENTAS.COD_VENDEDOR_AGENTE%TYPE;
v_COD_VENDEDOR    GA_VENTAS.COD_VENDEDOR%TYPE;
v_COD_VENDEALER   GA_VENTAS.COD_VENDEALER%TYPE;
v_sCodVendedor    GA_VENTAS.COD_VENDEDOR%TYPE;
v_COD_TIPCOMIS    VE_VENDEDORES.COD_TIPCOMIS%TYPE;
v_sEstado         VARCHAR2(8);
v_nCodModVenta    GA_VENTAS.COD_MODVENTA%TYPE;
v_nINDCUOTAS      GE_MODVENTA.IND_CUOTAS%TYPE;
v_Ind_Comodato    GA_TIPCONTRATO.IND_COMODATO%TYPE;
v_sCodTipcontrato GA_ABOCEL.COD_TIPCONTRATO%TYPE;
v_nIND_CANAL      NUMBER;

BEGIN

    --+wjrc/ITS [15.11.2002]
	SELECT cod_causarec, COD_TIPCOMIS, COD_VENDEDOR_AGENTE, COD_VENDEDOR, COD_VENDEALER
	  INTO v_cod_causarec, v_sTipComis, v_sCodVendAgte, v_COD_VENDEDOR, v_COD_VENDEALER
	  FROM GA_VENTAS
	 WHERE num_venta = P_NNUMVENTA;
    ---wjrc/ITS

	BEGIN
		SELECT A.COD_TIPCONTRATO
		      ,A.COD_CLIENTE
		      ,A.NUM_CELULAR
			  ,A.NUM_CONTRATO
		      ,A.IND_PROCEQUI
			  ,B.FEC_VENTA
			  ,B.FEC_RECDOCUM
			  ,B.cod_producto
	      INTO v_sCodTipcontrato
		      ,v_COD_CLIENTE
	          ,v_NUM_CELULAR
	          ,v_NUM_CONTRATO
	          ,v_IND_PROCEQUI
	          ,v_FEC_VENTA
	          ,v_FEC_RECDOCUM
			  ,v_cod_producto
		  FROM GA_ABOCEL A, GA_VENTAS B
		 WHERE NUM_ABONADO = PNUM_ABONADO
		   AND A.NUM_VENTA = B.NUM_VENTA;
	EXCEPTION
	     WHEN OTHERS THEN
				v_sError := '1';
		        v_sMess  := 'Problemas al obtener datos de abonado GA_ABOCEL';
		        RAISE Error_retorno_i;
	END;

	BEGIN
		SELECT COD_TIPCOMIS
		  INTO v_COD_TIPCOMIS
		  FROM VE_VENDEDORES
		 WHERE COD_VENDEDOR = v_sCodVendAgte;
	EXCEPTION
	     WHEN OTHERS THEN
			v_sError := '1';
	        v_sMess  := 'Problemas al obtener datos bInsertRechazos VE_VENDEDORES (COD_TIPCOMIS)';
	        RAISE Error_retorno_i;
    END;

	BEGIN
		SELECT COD_MODVENTA, COD_VENDEDOR
	      INTO v_nCodModVenta, v_sCodVendedor
		  FROM GA_VENTAS
		 WHERE NUM_VENTA = P_NNUMVENTA;
	EXCEPTION
	     WHEN OTHERS THEN
			v_sError := '1';
	        v_sMess  := 'Problemas al obtener datos bInsertRechazos GA_VENTAS (COD_MODVENTA, COD_VENDEDOR)';
	        RAISE Error_retorno_i;
    END;

	BEGIN
		SELECT IND_CUOTAS
		  INTO v_nINDCUOTAS
		  FROM GE_MODVENTA
		 WHERE COD_MODVENTA = v_nCodModVenta;
	EXCEPTION
	     WHEN OTHERS THEN
			v_sError := '1';
	        v_sMess  := 'Problemas al obtener datos bInsertRechazos GE_MODVENTA (IND_CUOTAS)';
	        RAISE Error_retorno_i;
    END;

	BEGIN
		SELECT IND_COMODATO
		  INTO v_Ind_Comodato
	  	  FROM GA_TIPCONTRATO
		 WHERE COD_PRODUCTO = v_cod_producto
		   AND COD_TIPCONTRATO = v_sCodTipcontrato;
	EXCEPTION
	     WHEN OTHERS THEN
			v_sError := '1';
	        v_sMess  := 'Problemas al obtener datos bInsertRechazos GA_TIPCONTRATO (IND_COMODATO)';
	        RAISE Error_retorno_i;
    END;

    If v_nINDCUOTAS = '2' Then
		v_sEstado := 'ARRIENDO';
    ElsIf v_nINDCUOTAS = '-1' Or v_Ind_Comodato = '1' Then
		v_sEstado := 'COMODATO';
    Else
		v_sEstado := 'SUBSIDIO';
    End If;

	if v_COD_VENDEALER is null then
	   v_nIND_CANAL:=v_sCodVendedor;
	else
	   v_nIND_CANAL:=v_COD_VENDEALER;
	end if;

	INSERT INTO GAT_RECHAZOS
	 (NUM_VENTA, NUM_ABONADO, COD_CLIENTE, NUM_CELULAR, NUM_CONTRATO, NUM_SERIE, IND_PROCEQUI, MOD_CONTRATO
	, COD_TIPCOMIS, COD_COMISIONISTA, COD_AGENCIA, COD_VEND_FINAL, IND_CANAL, FEC_VENTA, FEC_RECEPCION
	, FEC_RECHAZO, COD_CAUSAREC, NOM_USUARIO)
	 VALUES
	 (P_NNUMVENTA, PNUM_ABONADO,v_COD_CLIENTE,v_NUM_CELULAR,v_NUM_CONTRATO,PNUM_SERIE,v_IND_PROCEQUI,v_sEstado,
	 v_COD_TIPCOMIS,v_sCodVendAgte,v_COD_VENDEDOR,v_COD_VENDEALER,bvTipComis(P_NNUMVENTA), TO_DATE(v_FEC_VENTA),v_FEC_RECDOCUM, SYSDATE,v_cod_causarec, USER);


	RETURN TRUE;

EXCEPTION
	WHEN Error_retorno_i THEN
		RETURN FALSE;
	WHEN OTHERS THEN
		v_sError := SQLCODE;
		v_sMess := 'VE_RECHAZO_DEFINITIVO:bInsertRechazos.' || SQLERRM;
END bInsertRechazos;
/* ************************************************************** */
FUNCTION bRegMovCControlada(P_NNUMVENTA  IN NUMBER,
                            PNUM_ABONADO IN NUMBER,
                            PNUM_SERIE   IN NUMBER,
							nTipMov      IN NUMBER,
                            v_sError     OUT VARCHAR2,
                            v_sMess      OUT VARCHAR2)
RETURN BOOLEAN IS
Error_retorno_i  exception;

v_CodUsoAmistar     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_CodTipPlanPrepago GED_PARAMETROS.VAL_PARAMETRO%TYPE;

v_COD_USO           GA_ABOCEL.COD_USO%TYPE;
v_NUM_CELULAR       GA_ABOCEL.NUM_CELULAR%TYPE;
v_COD_PLANTARIF     GA_ABOCEL.COD_PLANTARIF%TYPE;
v_TIP_TERMINAL      GA_ABOCEL.TIP_TERMINAL%TYPE;
v_FEC_ALTA          GA_ABOCEL.FEC_ALTA%TYPE;
v_COD_CICLO         GA_ABOCEL.COD_CICLO%TYPE;
v_NUM_SERIE         GA_ABOCEL.NUM_SERIE%TYPE;
v_COD_CLIENTE       GA_ABOCEL.COD_CLIENTE%TYPE;
v_NUM_VENTA         GA_ABOCEL.NUM_VENTA%TYPE;
v_sCodTiplan	    TA_PLANTARIF.COD_TIPLAN%TYPE;
v_nSaldoAmistar     NUMBER;
v_dFec_Alta         DATE;
v_sPlan             TA_PLANTARIF.COD_PLAN_COMVERSE%TYPE;
v_sCodOficina	    GA_VENTAS.COD_OFICINA%TYPE;
v_sCargaCel	        AL_SERIES.CARGA%TYPE;
v_nValor            TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE;
v_sCod_Categoria    VE_CATPLANTARIF.COD_CATEGORIA%TYPE;
v_CODCATCTASEGANT   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_DIA_PERIODO       FA_CICLFACT.DIA_PERIODO%TYPE;
v_FEC_DESDELLAM     FA_CICLFACT.FEC_DESDELLAM%TYPE;
v_FEC_HASTALLAM     FA_CICLFACT.FEC_HASTALLAM%TYPE;
v_nNumTransac       NUMBER;
v_sCod_Concepto     FA_DATOSGENER.COD_ABONOCEL%TYPE;
v_sCod_Tipconce     FA_CONCEPTOS.COD_TIPCONCE%TYPE;
v_cod_catimpos      ge_catimpclientes.cod_catimpos%TYPE;
v_nImpuesto         NUMBER;
v_COD_KIT           AL_COMPONENTE_KIT.COD_KIT%TYPE;
v_COD_ARTICULO      AL_COMPONENTE_KIT.COD_ARTICULO%TYPE;
v_CARGA             AL_COMPONENTE_KIT.CARGA%TYPE;
v_IND_TELEFONO      AL_COMPONENTE_KIT.IND_TELEFONO%TYPE;
v_nCargaCel         GA_PLANTILLAS_KIT.CARGA_INICIAL%TYPE;
v_sConCargaKit      VARCHAR2(1):= '0';
v_bEsKit            BOOLEAN;
v_sMovimiento       ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
v_sActaboMovim      ICC_MOVIMIENTO.COD_ACTABO%TYPE;
v_num_movimiento    ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
sProseq             VARCHAR2(1);
bDealer             BOOLEAN;
v_sACTABO           VARCHAR2(2);
v_nTipMov           NUMBER;
v_sProc             VARCHAR2(50);
v_sQuery            VARCHAR2(5000);

BEGIN

	SELECT VAL_PARAMETRO
	  INTO v_CodUsoAmistar
	  FROM GED_PARAMETROS
	 WHERE NOM_PARAMETRO = 'USO_PREPAGO'
	   AND COD_MODULO = 'GA'
	   AND COD_PRODUCTO = 1;

	SELECT VAL_PARAMETRO
	  INTO v_CodTipPlanPrepago
	  FROM GED_PARAMETROS
	 WHERE NOM_PARAMETRO = 'TIP_PLAN_PREPAGO'
	   AND COD_MODULO = 'GA'
	   AND COD_PRODUCTO = 1;

	SELECT COD_USO, NUM_CELULAR, COD_PLANTARIF, TIP_TERMINAL,FEC_ALTA, 0, NUM_SERIE, COD_CLIENTE, NUM_VENTA
      INTO v_COD_USO,v_NUM_CELULAR,v_COD_PLANTARIF,v_TIP_TERMINAL,v_FEC_ALTA,v_COD_CICLO,v_NUM_SERIE,v_COD_CLIENTE,v_NUM_VENTA
	  FROM GA_ABOAMIST
	 WHERE NUM_ABONADO = PNUM_ABONADO
	 UNION
	SELECT COD_USO, NUM_CELULAR, COD_PLANTARIF, TIP_TERMINAL,FEC_ALTA,COD_CICLO, NUM_SERIE, COD_CLIENTE, NUM_VENTA
	  FROM GA_ABOCEL
	 WHERE NUM_ABONADO = PNUM_ABONADO;

	--USO_AMISTAR = "3"
	--USO_SEGURA_CTC = "15"
	if v_COD_USO is null or
	   (v_COD_USO<>'3' AND v_COD_USO<>'15' AND v_COD_USO<>v_CodUsoAmistar) then
		v_sError := '0';
	    v_sMess  := '';
        RAISE Error_retorno_ok;
	end if;

	SELECT COD_TIPLAN
	  INTO v_sCodTiplan
	  FROM TA_PLANTARIF
	 WHERE COD_PLANTARIF = v_COD_PLANTARIF;

	--este valor es opcional y para este proceso queda en cero
	v_nSaldoAmistar := 0;
	If v_sCodTiplan = v_CodTipPlanPrepago Then
	   v_nSaldoAmistar := 0;
	ElsIf v_nSaldoAmistar < 0 Then
	   v_nSaldoAmistar := 0;
	End If;

    --PATO: (22-ENE-2004) Incidencia MA-200401190323
    --'If asDat(1) = USO_SEGURA And sIndProporcs = "1" Then
    --USO_SEGURA = "10"
    If v_COD_USO = '10' Then
       --'PATO: (22-ENE-2004) Incidencia MA-200401190323
       SELECT SYSDATE
		 INTO v_dFec_Alta
		 FROM DUAL;
    End If;

	SELECT DECODE(COD_PLAN_COMVERSE, NULL, COD_PLANTARIF,COD_PLAN_COMVERSE)
	  INTO v_sPlan
	  FROM TA_PLANTARIF
	 WHERE COD_PLANTARIF = v_COD_PLANTARIF
	--Inicio incidencia CH-200401071607 Soporte mept 23-01-2003, problemas por duplicado de planes por producto
	   AND COD_PRODUCTO = 1;
    --Fin incidencia CH-200401071607 Soporte mept 23-01-2003

	SELECT COD_OFICINA
      INTO v_sCodOficina
	  FROM GA_VENTAS
	 WHERE NUM_VENTA = v_NUM_VENTA;

	--Obtiene Carga (pmolina)
	SELECT NVL(CARGA,0)
	  INTO v_sCargaCel
	  FROM AL_SERIES
	 WHERE NUM_SERIE = v_NUM_SERIE;

	sProseq := sGenMovi(PNUM_ABONADO);

    If (nTipMov = 1 Or nTipMov = 4) and ( v_sCodTiplan <> v_CodTipPlanPrepago ) Then
	    BEGIN
			--Lee el IMP_CARGO de TA_CARGOSBASICO.
			SELECT A.IMP_CARGOBASICO
	             INTO v_nValor
			  FROM TA_CARGOSBASICO A, TA_PLANTARIF B
			--+wjrc/ITS [10.02.2003]
			 WHERE B.COD_PLANTARIF = v_COD_PLANTARIF
			--wjrc/ITS [10.02.2003]
			   AND A.COD_CARGOBASICO = B.COD_CARGOBASICO
			   AND A.COD_PRODUCTO = 1
			   AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE);
		EXCEPTION
			WHEN OTHERS THEN
		       v_nValor:=NULL;
		END;


        If v_nValor is null Then
			v_sError := '0';
			v_sMess  := '';
			RAISE Error_retorno_i;
        End If;

           --Para Cuenta Segura
        SELECT COD_CATEGORIA
		  INTO v_sCod_Categoria
          FROM VE_CATPLANTARIF
         WHERE COD_PRODUCTO = 1
           AND COD_PLANTARIF = v_COD_PLANTARIF;

        SELECT VAL_PARAMETRO
		  INTO v_CODCATCTASEGANT
		  FROM GED_PARAMETROS
		 WHERE NOM_PARAMETRO = 'COD_CAT_CTA_SEG_ANT';

        If v_CODCATCTASEGANT <> v_sCod_Categoria Then
		   --USO_SEGURA = "10"
           If v_COD_USO = '10' Then
			   BEGIN
	              --Es Cuenta Segura y se calcula Proporcionalidad
	              SELECT DIA_PERIODO, FEC_DESDELLAM, FEC_HASTALLAM
	                INTO v_DIA_PERIODO, v_FEC_DESDELLAM, v_FEC_HASTALLAM
	                FROM FA_CICLFACT
	               WHERE COD_CICLO = v_COD_CICLO
	                 AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
				EXCEPTION
					WHEN OTHERS THEN
				       v_DIA_PERIODO:=NULL;
				END;


			  if v_DIA_PERIODO is not null then
				 v_nValor := (v_nValor  * (v_FEC_HASTALLAM - v_dFec_Alta + 1) / v_DIA_PERIODO);
			  end if;
            End If;
		end if;
	end if;

	SELECT FAS_PRESUPTEMP.NEXTVAL
	  INTO v_nNumTransac
	  FROM DUAL;

	SELECT COD_ABONOCEL
	  INTO v_sCod_Concepto
	  FROM FA_DATOSGENER;

    SELECT A.COD_TIPCONCE
	  INTO v_sCod_Tipconce
	  FROM FA_CONCEPTOS A, FA_DATOSGENER B
	 WHERE A.COD_CONCEPTO = B.COD_ABONOCEL;

	INSERT INTO FAT_PRESUPTEMP
	(NUM_PROCESO,COD_CONCEPTO,COLUMNA,COD_CLIENTE,FEC_EFECTIVIDAD,IMP_CONCEPTO,IMP_FACTURABLE,COD_TIPCONCE)
	VALUES (v_nNumTransac, v_sCod_Concepto, 1, v_COD_CLIENTE, SYSDATE, v_nValor, v_nValor, v_sCod_Tipconce);

	SELECT cod_catimpos
	  INTO v_cod_catimpos
	  FROM ge_catimpclientes
	 WHERE cod_cliente = v_COD_CLIENTE
	   AND SYSDATE BETWEEN fec_desde AND fec_hasta;

	v_sError:='';

    FA_PROC_IMPTOS(v_nNumTransac, v_cod_catimpos, v_sCodOficina, v_sProc,v_sProc,v_sProc,v_sProc, v_sError, v_sMess );

	if v_sError<>'' then
	   RAISE Error_retorno_i;
	end if;

	--RECUPERAMOS EL IMPUESTO ASOCIADO AL VALOR
	SELECT SUM(IMP_FACTURABLE)
	  INTO v_nImpuesto
	  FROM FAT_PRESUPTEMP
	 WHERE NUM_PROCESO = v_nNumTransac
	   AND COD_TIPCONCE = '1'
	GROUP BY COD_CONCEREL;

	v_nValor := v_nValor + v_nImpuesto;
	if bvTipComis(P_NNUMVENTA) = '1' then
  	   bDealer :=TRUE ;
	else
  	   bDealer :=FALSE ;
	end if;

    --Genera Comando
	if nTipMov = 1 then
       v_sACTABO := '';  --COD_ACTABO

       If v_COD_USO = v_CodUsoAmistar Then   --Es Amistar
           If sProseq = 'I' Then --si el equipo es interno
		        BEGIN
	               --Si es Kit, debo sacar la carga asociada
	               SELECT COD_KIT, COD_ARTICULO, NVL(CARGA, 0), IND_TELEFONO
	                 INTO v_COD_KIT, v_COD_ARTICULO, v_CARGA, v_IND_TELEFONO
	                 FROM AL_COMPONENTE_KIT
	                WHERE NUM_SERIE = v_NUM_SERIE;
				EXCEPTION
					WHEN OTHERS THEN
				       v_COD_KIT:=NULL;
				END;


               If v_COD_KIT is not null Then
                   v_bEsKit := True;

                   If v_COD_KIT <> '' And v_COD_ARTICULO <> '' And v_CARGA <= 0 Then
				       BEGIN
	                       --Solo aplicable a MPR
	                       SELECT nvl(CARGA_INICIAL,0)
						     INTO v_nCargaCel
	                         FROM GA_PLANTILLAS_KIT
	                        WHERE COD_KIT = v_COD_KIT
	  					      AND COD_ARTICULO = v_COD_ARTICULO
	 					      AND SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;
						EXCEPTION
							WHEN OTHERS THEN
						       v_nCargaCel:=NULL;
						END;


                       if v_nCargaCel is null then
					      v_nCargaCel := 0;
					   end if;
                       v_sConCargaKit := '1';
                   Else
                       v_sCargaCel := v_CARGA;
                   End If;
               End If;
           End If;
       End If;
	elsif nTipMov = 2 then
          v_sACTABO := 'BP';
	elsif nTipMov = 3 then
          v_sACTABO := 'MP';
	elsif nTipMov = 4 then
          v_sACTABO := 'AM';
		  v_nTipMov := 1;
	end if;

	if nTipMov = 1 or v_nTipMov = 1 then

	   SELECT NUM_MOVIMIENTO, COD_ACTABO
	     INTO v_sMovimiento, v_sActaboMovim
         FROM ICC_MOVIMIENTO
        WHERE NUM_CELULAR = v_NUM_CELULAR
          AND COD_ACTABO = v_sACTABO;

        If sProseq = 'E' Then  --Es externo
            If v_sMovimiento = '' Then
			   v_sError := '1';
			   v_sMess  := 'Error al recuperar Movimiento en Central.';
			   RAISE Error_retorno_i;
            End If;

			v_sQuery:= 'UPDATE ICC_MOVIMIENTO';
			v_sQuery:= v_sQuery || 'SET PLAN = ' || v_sPlan ;

            --USO_AMISTAR = "3"
			--USO_SEGURA_CTC = "15"
			--USO_SEGURA = "10"
            If (v_COD_USO = '10') Or (v_COD_USO = '15') Then --Cuenta Segura
			   v_sQuery:= v_sQuery || ', VALOR_PLAN = ' || v_nValor;
            ElsIf v_COD_USO = '3' Then
			   v_sQuery:= v_sQuery || ', CARGA = ' || v_sCargaCel;
            End If;

			v_sQuery:= v_sQuery || ' WHERE NUM_MOVIMIENTO = ' || v_sMovimiento;

			BEGIN
				 EXECUTE IMMEDIATE v_sQuery;
			EXCEPTION
			WHEN OTHERS THEN
                 v_sError := SQLCODE;
 	             v_sMess := 'ICC_MOVIMIENTO 1 PKG VE_RECHAZO_DEFINITIVO bRegMovCControlada ' || SQLERRM;
			     RAISE Error_retorno_i;
			END;

        Else --Es interno
            If v_sConCargaKit = '1' Then --Solo aplicable a MPR
                v_sQuery:= 'UPDATE ICC_MOVIMIENTO ';
                v_sQuery:= v_sQuery || ' SET CARGA = ' || v_sCargaCel;
                v_sQuery:= v_sQuery || ', PLAN = ' || v_sPlan;
                If v_nCargaCel > 0 And v_IND_TELEFONO = '6' Then
                    v_sQuery:= v_sQuery || ', COD_ACTABO = "VD", COD_ACTUACION = 300 ';
                End If;
                v_sQuery:= v_sQuery || ' WHERE NUM_MOVIMIENTO = ' || v_sMovimiento;

				BEGIN
				 EXECUTE IMMEDIATE v_sQuery;
				EXCEPTION
				WHEN OTHERS THEN
	                 v_sError := SQLCODE;
	 	             v_sMess := 'UPDATE ICC_MOVIMIENTO (2)(PK)VE_RECHAZO_DEFINITIVO.bRegMovCControlada ' || SQLERRM;
				     RAISE Error_retorno_i;
				END;
			else   --Si no es MPR y es Interno
                If v_bActEstMovim Then   --Si ind_telefono es 7 -> Prepago con telefono activado PATO: 1278
                    If v_sMovimiento = '' And v_sActaboMovim = '' Then
		               v_sError := '1';
		 	           v_sMess := 'Error al recuperar Movimiento en Central';
					   RAISE Error_retorno_i;
                    End If;

                    If v_sActaboMovim = 'AM' Then
                        v_sQuery:= 'UPDATE ICC_MOVIMIENTO ';
                        v_sQuery:= v_sQuery || 'SET COD_ESTADO = 1';
                        v_sQuery:= v_sQuery || ', PLAN = ' || v_sPlan;
                        If v_nCargaCel > 0 Then
                            v_sQuery:= v_sQuery || ', CARGA = ' || v_sCargaCel;
                        End If;
                        v_sQuery:= v_sQuery || ' WHERE NUM_MOVIMIENTO = ' || v_sMovimiento;

						BEGIN
						   EXECUTE IMMEDIATE v_sQuery;
						EXCEPTION
						WHEN OTHERS THEN
			                 v_sError := SQLCODE;
			 	             v_sMess := 'UPDATE ICC_MOVIMIENTO (3)(PK)VE_RECHAZO_DEFINITIVO.bRegMovCControlada ' || SQLERRM;
						     RAISE Error_retorno_i;
						END;

                        UPDATE ICC_MOVIMIENTO
                           SET COD_ESTADO = 0
                         WHERE NUM_MOVIMIENTO = v_sMovimiento;

                    End If;
                Else    --Si ind_telefono es distinto de 7 PATO: 1278
                    --Envia movimiento dependiente de Indtelefono de Almacen
                    If v_sMovimiento <> '' Then

                        v_sQuery:= 'UPDATE ICC_MOVIMIENTO ';
                        v_sQuery:= v_sQuery || 'SET PLAN = ' || v_sPlan;
			            --USO_AMISTAR = "3" / USO_SEGURA_CTC = "15" / USO_SEGURA = "10"
						If (v_COD_USO = '10') Or (v_COD_USO = '15') Then --Cuenta Segura
                            v_sQuery:= v_sQuery || ', VALOR_PLAN = ' || v_nValor;
                        ElsIf v_COD_USO = '3' Then
                            v_nValor := 0;
                            v_sQuery:= v_sQuery || ', CARGA = ' || v_nValor;
                        End If;
                        v_sQuery:= v_sQuery || ' WHERE NUM_MOVIMIENTO = ' || v_sMovimiento;

						BEGIN
						     EXECUTE IMMEDIATE v_sQuery;
						EXCEPTION
						WHEN OTHERS THEN
			                 v_sError := SQLCODE;
			 	             v_sMess := 'UPDATE ICC_MOVIMIENTO (4)(PK)VE_RECHAZO_DEFINITIVO.bRegMovCControlada ' || SQLERRM;
						     RAISE Error_retorno_i;
						END;

                    End If;
                End If;
			end if;
		end if;
	end if;

    If nTipMov = 1 Then --Alta
        If v_sMovimiento = '' Then
		    BEGIN
	            SELECT NUM_MOVIMIENTO --, COD_ACTABO
				  INTO v_num_movimiento
				  FROM ICC_MOVIMIENTO
	             WHERE NUM_CELULAR = v_NUM_CELULAR
	               AND NUM_ABONADO = PNUM_ABONADO;
			EXCEPTION
				WHEN OTHERS THEN
			       v_num_movimiento:=NULL;
			END;


			if v_num_movimiento is not null then
			   v_sMovimiento:= v_num_movimiento;
			end if;
        End If;

		BEGIN
	        UPDATE ICC_MOVIMIENTO
	           SET CARGA = v_nCargaCel
	         WHERE NUM_MOVIMIENTO = v_sMovimiento;
		EXCEPTION
		WHEN OTHERS THEN
             v_sError := SQLCODE;
             v_sMess := 'UPDATE ICC_MOVIMIENTO (5)(PK)VE_RECHAZO_DEFINITIVO.bRegMovCControlada ' || SQLERRM;
		     RAISE Error_retorno_i;
		END;

    End If;

	RETURN TRUE;

EXCEPTION
	WHEN Error_retorno_ok THEN
		RETURN TRUE;
	WHEN Error_retorno_i THEN
		RETURN FALSE;
	WHEN OTHERS THEN
		v_sError := SQLCODE;
		v_sMess := 'VE_RECHAZO_DEFINITIVO:bInsertRechazos.' || SQLERRM;
END bRegMovCControlada;

/* ************************************************************** */
Function bvTipComis(P_NNUMVENTA IN NUMBER)
RETURN VARCHAR2 IS

vTipComis      ve_tipcomis.IND_VTA_EXTERNA%TYPE;
sDealerInterno GED_PARAMETROS.VAL_PARAMETRO%TYPE;
sTipComis	   GA_VENTAS.COD_TIPCOMIS%TYPE;

BEGIN

	SELECT COD_TIPCOMIS
	  INTO sTipComis
	  FROM GA_VENTAS
	 WHERE NUM_VENTA = P_NNUMVENTA;

--	SELECT VAL_PARAMETRO
--	  INTO sDealerInterno
--	  FROM GED_PARAMETROS
--	 WHERE NOM_PARAMETRO = 'DEALER_INTERNO'
--	   AND COD_MODULO= 'GA'
--	   AND COD_PRODUCTO= 1;

	SELECT ind_vta_externa
	  INTO vTipComis
	  FROM ve_tipcomis
	 WHERE cod_tipcomis = sTipComis;

    --Validacion para caso especial de CTC.
--    If sTipComis = sDealerInterno Then
--	   vTipComis := '0';
--	end if;

	RETURN vTipComis;

END bvTipComis;
/* ************************************************************** */
FUNCTION bGeneraMovimientos(P_NNUMVENTA IN NUMBER,
                            v_sError OUT VARCHAR2,
    	                    v_sMess  OUT VARCHAR2)
RETURN BOOLEAN IS

Error_retorno_i  exception;

--cursor de abonados
CURSOR c_abonados IS
SELECT NUM_ABONADO
       ,IND_PLEXSYS
       ,COD_CENTRAL
       ,COD_CENTRAL_PLEX
       ,NUM_CELULAR
       ,NUM_CELULAR_PLEX
       ,NUM_SERIEHEX
       ,TIP_TERMINAL
       ,COD_TECNOLOGIA
       ,NUM_IMEI
       ,NUM_SERIE
  FROM GA_ABOCEL
 WHERE NUM_VENTA = P_NNUMVENTA;

v_nNumSeqMov1    NUMBER;
v_nNumSeqMov2    NUMBER;
v_sCOD_PLANTARIF GA_ABOCEL.COD_PLANTARIF%TYPE;
v_COD_TIPLAN     TA_PLANTARIF.COD_TIPLAN%TYPE;
v_CodTipPlanHib  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_nSeq_1         NUMBER:=0;
v_nSeq_2         NUMBER:=0;

v_sCausaRechazo GED_PARAMETROS.VAL_PARAMETRO%TYPE;

BEGIN
	--bGeneraMovimientos
	--cursor de abonados
	FOR ABONADOS IN c_abonados LOOP

	    SELECT ICC_SEQ_NUMMOV.NEXTVAL
		  INTO v_nNumSeqMov1
		  FROM DUAL;

		--Miramos si es Plexsys o no
		IF ABONADOS.IND_PLEXSYS = '0' THEN
			--Inserta un solo movimiento
			v_nSeq_1 := v_nNumSeqMov1;
			v_nSeq_2 := 0;

			If Not bInsertaMovimiento(ABONADOS.NUM_ABONADO
	                                       ,ABONADOS.IND_PLEXSYS
	                                       ,ABONADOS.COD_CENTRAL
	                                       ,ABONADOS.COD_CENTRAL_PLEX
	                                       ,ABONADOS.NUM_CELULAR
	                                       ,ABONADOS.NUM_CELULAR_PLEX
	                                       ,ABONADOS.NUM_SERIEHEX
	                                       ,ABONADOS.TIP_TERMINAL
	                                       ,ABONADOS.COD_TECNOLOGIA
	                                       ,ABONADOS.NUM_IMEI
	                                       ,ABONADOS.NUM_SERIE
	                                       ,v_nSeq_1
	                                       ,v_nSeq_2
	                                       ,v_sError
	                                       ,v_sMess) Then
				   RAISE Error_retorno_i;
			end if;

		ELSIF ABONADOS.IND_PLEXSYS = '1' THEN
			--Si lo es, Obtiene el segundo numero de secuencia
		    SELECT ICC_SEQ_NUMMOV.NEXTVAL
			  INTO v_nNumSeqMov2
			  FROM DUAL;

			v_nSeq_1 := v_nNumSeqMov1;
			v_nSeq_2 := v_nNumSeqMov2;

			--Inserta primer movimiento
			--If Not bInsertaMovimiento(asArray1(), v_nNumSeqMov1, v_nNumSeqMov2) Then Exit Function
			If Not bInsertaMovimiento(ABONADOS.NUM_ABONADO
	                                 ,ABONADOS.IND_PLEXSYS
	                                 ,ABONADOS.COD_CENTRAL
	                                 ,ABONADOS.COD_CENTRAL_PLEX
	                                 ,ABONADOS.NUM_CELULAR
	                                 ,ABONADOS.NUM_CELULAR_PLEX
	                                 ,ABONADOS.NUM_SERIEHEX
	                                 ,ABONADOS.TIP_TERMINAL
	                                 ,ABONADOS.COD_TECNOLOGIA
	                                 ,ABONADOS.NUM_IMEI
	                                 ,ABONADOS.NUM_SERIE
	                                 ,v_nSeq_1
	                                 ,v_nSeq_2
	                                 ,v_sError
	                                 ,v_sMess) Then
				   RAISE Error_retorno_i;
			end if;

			--Inserta segundo movimiento
			--If Not bInsertaMovimiento(asArray1(), v_nNumSeqMov2, v_nNumSeqMov1) Then Exit Function
			If Not bInsertaMovimiento(ABONADOS.NUM_ABONADO
	                                 ,ABONADOS.IND_PLEXSYS
	                                 ,ABONADOS.COD_CENTRAL
	                                 ,ABONADOS.COD_CENTRAL_PLEX
	                                 ,ABONADOS.NUM_CELULAR
	                                 ,ABONADOS.NUM_CELULAR_PLEX
	                                 ,ABONADOS.NUM_SERIEHEX
	                                 ,ABONADOS.TIP_TERMINAL
	                                 ,ABONADOS.COD_TECNOLOGIA
	                                 ,ABONADOS.NUM_IMEI
	                                 ,ABONADOS.NUM_SERIE
	                                 ,v_nSeq_2
	                                 ,v_nSeq_1
	                                 ,v_sError
	                                 ,v_sMess) Then
				   RAISE Error_retorno_i;
			end if;

		END IF;

	END LOOP;
	--FIN bGeneraMovimientos


	RETURN TRUE;
EXCEPTION
	WHEN Error_retorno_i THEN
		RETURN FALSE;
	WHEN OTHERS THEN
--		 RAISE_APPLICATION_ERROR(-20204, 'ERROR DETERMINANDO AGRUPACION DE PROYECTOS.');
		 RAISE;
END bGeneraMovimientos;

/* ************************************************************** */
FUNCTION bInsertaMovimiento(
		ABONADOS_NUM_ABONADO      IN NUMBER,
		ABONADOS_IND_PLEXSYS      IN NUMBER,
		ABONADOS_COD_CENTRAL      IN NUMBER,
		ABONADOS_COD_CENTRAL_PLEX IN NUMBER,
		ABONADOS_NUM_CELULAR      IN NUMBER,
		ABONADOS_NUM_CELULAR_PLEX IN NUMBER,
		ABONADOS_NUM_SERIEHEX     IN VARCHAR2,
		ABONADOS_TIP_TERMINAL     IN VARCHAR2,
		ABONADOS_COD_TECNOLOGIA   IN VARCHAR2,
		ABONADOS_NUM_IMEI         IN VARCHAR2,
		ABONADOS_NUM_SERIE        IN VARCHAR2,
		v_nSeq_1                  IN NUMBER,
		v_nSeq_2                  IN NUMBER,
	    v_sError                  OUT VARCHAR2,
	    v_sMess                   OUT VARCHAR2)
RETURN BOOLEAN IS

v_sQuery        VARCHAR2(5000) := '';
v_cod_prod_cel	GE_DATOSGENER.PROD_CELULAR%TYPE;
v_sCodActAbo    VARCHAR2(2);
v_sCodActuacion GA_ACTABO.COD_ACTCEN%TYPE;
v_NUM_MIN       GA_ABOCEL.NUM_MIN%TYPE;
v_sCOD_TEC_GSM  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_sIMSI         VARCHAR2(50);
v_sNum_Seri     GA_ABOCEL.NUM_SERIE%TYPE;

Error_retorno_i exception;
Destination_Cursor INTEGER;
Rows_Processed     INTEGER;

BEGIN
    --bInsertaMovimiento

	v_sCodActAbo:= sCodActAbo_PlanHibrido(ABONADOS_NUM_ABONADO);
	if v_sCodActAbo='' or v_sCodActAbo is null then
	   v_sCodActAbo:='RV';
	end if;

	--Carga Variables Globales de GE_DATOSGENER
	SELECT PROD_CELULAR
	  INTO v_cod_prod_cel
	  FROM GE_DATOSGENER;

	SELECT COD_ACTCEN
	  INTO v_sCodActuacion
	  FROM GA_ACTABO
	 WHERE COD_PRODUCTO = v_cod_prod_cel
	   AND COD_ACTABO = v_sCodActAbo
	   AND COD_TECNOLOGIA = ABONADOS_COD_TECNOLOGIA
	   AND COD_MODULO = 'GA';

	IF v_sCodActuacion = '' THEN
	   v_sError:='1';
	   v_sMess :='No existe actuacion en centrales';
	   raise Error_retorno_i;
	end if;

	v_NUM_MIN := nObtieneMinBaja(ABONADOS_NUM_ABONADO);

	if v_NUM_MIN = -1 then
	   v_sError:='1';
	   v_sMess :='No existe Prefijo asociado al Abonado';
	   raise Error_retorno_i;
	end if;


	SELECT VAL_PARAMETRO
	  INTO v_sCOD_TEC_GSM
	  FROM GED_PARAMETROS
	 WHERE NOM_PARAMETRO = 'TECNOLOGIA_GSM'
	   AND COD_MODULO = 'GA'
	   AND COD_PRODUCTO = 1;

	If v_nSeq_1 is null Then
        --No lo es : Inserta un solo movimiento en ICC_MOVIMIENTO
		If ABONADOS_COD_TECNOLOGIA = v_sCOD_TEC_GSM Then --Si es GSM
	         v_sNum_Seri :=ABONADOS_NUM_SERIE;

	         v_sIMSI:=FRECUPERSIMCARD_FN( v_sNum_Seri, 'IMSI' );

	         If v_sIMSI = 0 Then
			    v_sError:='1';
			    v_sMess :='No se pudo recuperar IMSI de serie seleccionada';
			    raise Error_retorno_i;
	         End If;

	    Else
	         v_sNum_Seri := ABONADOS_NUM_SERIEHEX; --SERIE HEXADECIMAL EN TDMA
	    End If;

		If ABONADOS_COD_TECNOLOGIA = v_sCOD_TEC_GSM Then --Si es GSM
			INSERT INTO ICC_MOVIMIENTO
	 		   ( NUM_MOVIMIENTO, NUM_ABONADO, COD_ESTADO, COD_MODULO, NOM_USUARORA, COD_CENTRAL,
			     NUM_CELULAR, COD_ACTUACION, FEC_INGRESO, NUM_SERIE, TIP_TERMINAL, COD_ACTABO,
			     NUM_MIN, TIP_TECNOLOGIA,IMSI,IMEI,ICC )
			Values
			   ( v_nSeq_1,ABONADOS_NUM_ABONADO,'1','GA',USER,ABONADOS_COD_CENTRAL,ABONADOS_NUM_CELULAR,
			     v_sCodActuacion,SYSDATE,v_sNum_Seri,ABONADOS_TIP_TERMINAL,v_sCodActAbo,v_NUM_MIN,
			     ABONADOS_COD_TECNOLOGIA,v_sIMSI,ABONADOS_NUM_IMEI,ABONADOS_NUM_SERIE);
        else
			INSERT INTO ICC_MOVIMIENTO
	 		   ( NUM_MOVIMIENTO, NUM_ABONADO, COD_ESTADO, COD_MODULO, NOM_USUARORA, COD_CENTRAL,
			     NUM_CELULAR, COD_ACTUACION, FEC_INGRESO, NUM_SERIE, TIP_TERMINAL, COD_ACTABO,
			     NUM_MIN, TIP_TECNOLOGIA)
			Values
			   ( v_nSeq_1,ABONADOS_NUM_ABONADO,'1','GA',USER,ABONADOS_COD_CENTRAL,ABONADOS_NUM_CELULAR,
			     v_sCodActuacion,SYSDATE,v_sNum_Seri,ABONADOS_TIP_TERMINAL,v_sCodActAbo,v_NUM_MIN,
			     ABONADOS_COD_TECNOLOGIA);
		end if;


	ELSIF v_nSeq_1 > v_nSeq_2 Then

		--GSM-SIMCARD
		If ABONADOS_COD_TECNOLOGIA = v_sCOD_TEC_GSM Then --Si es GSM
	         v_sNum_Seri :=ABONADOS_NUM_SERIE;

	         v_sIMSI:=FRECUPERSIMCARD_FN( v_sNum_Seri, 'IMSI' );

	         If v_sIMSI = 0 Then
			    v_sError:='1';
			    v_sMess :='No se pudo recuperar IMSI de SimCard seleccionada';
			    raise Error_retorno_i;
	         End If;
	    Else
	         v_sNum_Seri := ABONADOS_NUM_SERIEHEX; --SERIE HEXADECIMAL EN TDMA
	    End If;
	    --FIN GSM-SIMCARD

		If ABONADOS_COD_TECNOLOGIA = v_sCOD_TEC_GSM Then         --Si es GSM
			INSERT INTO ICC_MOVIMIENTO ( NUM_MOVANT, NUM_MOVIMIENTO, NUM_ABONADO, COD_ESTADO,COD_MODULO,NOM_USUARORA,COD_CENTRAL
			                             ,NUM_CELULAR,COD_ACTUACION,FEC_INGRESO, NUM_SERIE,TIP_TERMINAL,COD_ACTABO,NUM_MIN,TIP_TECNOLOGIA,IMSI,IMEI,ICC)
			VALUES (v_nSeq_2,v_nSeq_1, ABONADOS_NUM_ABONADO,'1','GA',USER,ABONADOS_COD_CENTRAL,
			        ABONADOS_NUM_CELULAR,v_sCodActuacion,SYSDATE,v_sNum_Seri,ABONADOS_TIP_TERMINAL,'RV',v_NUM_MIN,ABONADOS_COD_TECNOLOGIA,v_sIMSI,ABONADOS_NUM_IMEI,ABONADOS_NUM_SERIE);
        else
			INSERT INTO ICC_MOVIMIENTO ( NUM_MOVANT, NUM_MOVIMIENTO, NUM_ABONADO, COD_ESTADO,COD_MODULO,NOM_USUARORA,COD_CENTRAL
			                             ,NUM_CELULAR,COD_ACTUACION,FEC_INGRESO, NUM_SERIE,TIP_TERMINAL,COD_ACTABO,NUM_MIN,TIP_TECNOLOGIA)
			VALUES (v_nSeq_2,v_nSeq_1, ABONADOS_NUM_ABONADO,'1','GA',USER,ABONADOS_COD_CENTRAL,
			        ABONADOS_NUM_CELULAR,v_sCodActuacion,SYSDATE,v_sNum_Seri,ABONADOS_TIP_TERMINAL,'RV',v_NUM_MIN,ABONADOS_COD_TECNOLOGIA);
		end if;

	ELSIF v_nSeq_2 > v_nSeq_1 Then

		--GSM-SIMCARD
		If ABONADOS_COD_TECNOLOGIA = v_sCOD_TEC_GSM Then --Si es GSM
	         v_sNum_Seri :=ABONADOS_NUM_SERIE;

	         v_sIMSI:=FRECUPERSIMCARD_FN( v_sNum_Seri, 'IMSI' );

	         If v_sIMSI = 0 Then
			    v_sError:='1';
			    v_sMess :='No se pudo recuperar IMSI de SimCard seleccionada';
			    raise Error_retorno_i;
	         End If;
	    Else
	         v_sNum_Seri := ABONADOS_NUM_SERIEHEX; --SERIE HEXADECIMAL EN TDMA
	    End If;

		--GSM-SIMCARD
		If ABONADOS_COD_TECNOLOGIA = v_sCOD_TEC_GSM Then --Si es GSM
			INSERT INTO ICC_MOVIMIENTO
			  (NUM_MOVPOS,NUM_MOVIMIENTO,NUM_ABONADO,COD_ESTADO,COD_MODULO,NOM_USUARORA,COD_CENTRAL,NUM_CELULAR,
			  COD_ACTUACION,FEC_INGRESO,NUM_SERIE,TIP_TERMINAL,COD_ACTABO,NUM_MIN,TIP_TECNOLOGIA,IMSI,IMEI,ICC)
			VALUES
			  (v_nSeq_2, v_nSeq_1, ABONADOS_NUM_ABONADO,'1','GA',USER,ABONADOS_COD_CENTRAL,ABONADOS_NUM_CELULAR,
			  v_sCodActuacion,SYSDATE,v_sNum_Seri,ABONADOS_TIP_TERMINAL,'RV',v_NUM_MIN,ABONADOS_COD_TECNOLOGIA,
			  v_sIMSI,ABONADOS_NUM_IMEI,ABONADOS_NUM_SERIE);
		else
			INSERT INTO ICC_MOVIMIENTO
			(NUM_MOVPOS,NUM_MOVIMIENTO,NUM_ABONADO,COD_ESTADO,COD_MODULO,NOM_USUARORA,COD_CENTRAL,NUM_CELULAR,
			COD_ACTUACION,FEC_INGRESO,NUM_SERIE,TIP_TERMINAL,COD_ACTABO,NUM_MIN,TIP_TECNOLOGIA)
			VALUES
			(v_nSeq_2, v_nSeq_1, ABONADOS_NUM_ABONADO,'1','GA',USER,ABONADOS_COD_CENTRAL,ABONADOS_NUM_CELULAR,
			v_sCodActuacion,SYSDATE,v_sNum_Seri,ABONADOS_TIP_TERMINAL,'RV',v_NUM_MIN,ABONADOS_COD_TECNOLOGIA);
		end if;

	END IF;
	--FIN bInsertaMovimiento


	RETURN TRUE;
EXCEPTION
	WHEN Error_retorno_i THEN
		RETURN FALSE;
	WHEN OTHERS THEN
--		 RAISE_APPLICATION_ERROR(-20204, 'ERROR DETERMINANDO AGRUPACION DE PROYECTOS.');
   DBMS_OUTPUT.PUT_LINE (SQLCODE );
   DBMS_OUTPUT.PUT_LINE (SQLERRM );

	    v_sError := TO_CHAR(SQLCODE);
	    v_sMess  := SQLERRM;

		 RAISE;
END bInsertaMovimiento;
/* ************************************************************** */
FUNCTION sCodActAbo_PlanHibrido( ABONADOS_NUM_ABONADO IN NUMBER )
RETURN VARCHAR2 IS

v_CodTipPlanHib  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_sCOD_PLANTARIF GA_ABOCEL.COD_PLANTARIF%TYPE;
v_COD_TIPLAN     TA_PLANTARIF.COD_TIPLAN%TYPE;

v_sRetorno VARCHAR2(2);

BEGIN
	 v_sRetorno:='';

	BEGIN
		--funcion que entrega codigo de Actuacion si el plan tarifario del Abonado es de Tipo hibrido
		SELECT COD_PLANTARIF
		  INTO v_sCOD_PLANTARIF
		  FROM GA_ABOCEL
		 WHERE NUM_ABONADO = ABONADOS_NUM_ABONADO;
	EXCEPTION
		WHEN OTHERS THEN
	       v_sCOD_PLANTARIF:=NULL;
	END;


	If v_sCOD_PLANTARIF is not null Then
		SELECT VAL_PARAMETRO
		  INTO v_CodTipPlanHib
		  FROM GED_PARAMETROS
		 WHERE NOM_PARAMETRO = 'TIP_PLAN_HIBRIDO'
		   AND COD_MODULO = 'GA'
		   AND COD_PRODUCTO = 1;

		SELECT COD_TIPLAN
		  INTO v_COD_TIPLAN
		  FROM TA_PLANTARIF
		 WHERE COD_PLANTARIF = v_sCOD_PLANTARIF;

		IF v_COD_TIPLAN = v_CodTipPlanHib THEN
		   v_sRetorno := 'BH';
		END IF;
	End If;

	RETURN v_sRetorno;
EXCEPTION
	WHEN OTHERS THEN
--		 RAISE_APPLICATION_ERROR(-20204, 'ERROR DETERMINANDO AGRUPACION DE PROYECTOS.');
		 RAISE;
END sCodActAbo_PlanHibrido;

/* ************************************************************** */
FUNCTION nObtieneMinBaja( ABONADOS_NUM_ABONADO IN NUMBER )
RETURN NUMBER IS

v_CodTipPlanHib  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_sCOD_PLANTARIF GA_ABOCEL.COD_PLANTARIF%TYPE;
v_COD_TIPLAN     TA_PLANTARIF.COD_TIPLAN%TYPE;

v_nRetorno NUMBER;

BEGIN
	 v_nRetorno:=-1;

	--bObtieneMinBaja
	--JLV 06-99 A?adido prefijo min para abonados
	--Obtiene el Min de " y sNomTablaAbo y " para un abonado ya existente a partir del num_abonado
	BEGIN
		SELECT NUM_MIN
		  INTO v_nRetorno
		  FROM GA_ABOCEL
	     WHERE NUM_ABONADO= ABONADOS_NUM_ABONADO;
	EXCEPTION
		WHEN OTHERS THEN
	       v_nRetorno:=NULL;
	END;

	if v_nRetorno is null then
	   v_sError:='1';
	   v_sMess :='No existe Prefijo asociado al Abonado';
	   raise Error_retorno;
	end if;
	--FIN bObtieneMinBaja

	RETURN v_nRetorno;
EXCEPTION
	WHEN OTHERS THEN
--		 RAISE_APPLICATION_ERROR(-20204, 'ERROR DETERMINANDO AGRUPACION DE PROYECTOS.');
		 RAISE;
END nObtieneMinBaja;
/* ************************************************************** */
FUNCTION sGenMovi( sNumAbonado IN VARCHAR2 )
RETURN VARCHAR2 IS

v_sRetorno       VARCHAR2(1);

v_NUM_SERIE      GA_ABOCEL.NUM_SERIE%TYPE;
v_sNUM_SERIE     GA_ABOCEL.NUM_SERIE%TYPE;
v_NUM_IMEI       GA_ABOCEL.NUM_IMEI%TYPE;
v_COD_TECNOLOGIA GA_ABOCEL.COD_TECNOLOGIA%TYPE;
v_sTEC           ged_parametros.VAL_PARAMETRO%TYPE;
v_sNumSerieAbo   GA_ABOCEL.NUM_SERIE%TYPE;

v_IND_PROCEQUI   GA_EQUIPABOSER.IND_PROCEQUI%TYPE;
v_COD_ARTICULO   GA_EQUIPABOSER.COD_ARTICULO%TYPE;

v_sIndProcequi   AL_SERIES.ind_telefono%TYPE;


BEGIN

	v_sRetorno:='';

	SELECT NUM_SERIE, NUM_IMEI, COD_TECNOLOGIA
      INTO v_NUM_SERIE, v_NUM_IMEI, v_COD_TECNOLOGIA
	  FROM GA_ABOCEL
	 WHERE NUM_ABONADO = sNumAbonado;

	SELECT VAL_PARAMETRO
	  INTO v_sTEC
	  FROM ged_parametros
	 WHERE NOM_PARAMETRO = 'TECNOLOGIA_GSM'
	   AND COD_MODULO = 'GA';

    if v_COD_TECNOLOGIA = v_sTEC then
	   v_sNUM_SERIE := v_NUM_IMEI;
	else
	   v_sNUM_SERIE := v_NUM_SERIE;
	end if;


    v_sNumSerieAbo := v_NUM_SERIE;

	SELECT IND_PROCEQUI, NUM_SERIE, COD_ARTICULO
      INTO v_IND_PROCEQUI, v_NUM_SERIE, v_COD_ARTICULO
	  FROM GA_EQUIPABOSER
	 WHERE num_abonado = sNumAbonado
	   AND NUM_SERIE = v_sNum_Serie
	   AND FEC_ALTA = (SELECT MAX(FEC_ALTA)
	                     FROM GA_EQUIPABOSER
	                    WHERE NUM_ABONADO = sNumAbonado
	                      AND NUM_SERIE = v_sNum_Serie);

    If v_IND_PROCEQUI = 'E' Then --procedencia del equipo Externa
        v_sRetorno := v_IND_PROCEQUI;
    ELSE
	    v_sRetorno := v_IND_PROCEQUI;

		BEGIN
			SELECT ind_telefono
			  INTO v_sIndProcequi
			  FROM AL_SERIES
			 WHERE NUM_SERIE = v_sNumSerieAbo
			   AND NUM_TELEFONO IS NOT NULL
			   AND NUM_TELEFONO > 0
			   AND IND_TELEFONO <> (SELECT VAL_PARAMETRO
			                          FROM GED_PARAMETROS
									 WHERE COD_MODULO = 'GE'
									   AND COD_PRODUCTO = 1
									   AND NOM_PARAMETRO = 'IND_TEL_OUT');
		EXCEPTION
			WHEN OTHERS THEN
		       v_sIndProcequi:=NULL;
		END;


        If v_sIndProcequi = '' OR v_sIndProcequi is null Then
		   SELECT ind_telefono
		     INTO v_sIndProcequi
		     FROM AL_COMPONENTE_KIT
            WHERE NUM_SERIE = v_sNumSerieAbo
              AND NUM_TELEFONO IS NOT NULL
              AND NUM_TELEFONO > 0
              AND IND_TELEFONO <> (SELECT VAL_PARAMETRO
			                         FROM GED_PARAMETROS
									WHERE COD_MODULO = 'GE'
									  AND COD_PRODUCTO = 1
									  AND NOM_PARAMETRO = 'IND_TEL_OUT');
        End If;

        If (v_sIndProcequi = '1') Or (v_sIndProcequi = '6') Then
            v_bActEstMovim := False;
        ElsIf (v_sIndProcequi = '4') Or (v_sIndProcequi = '5') Or (v_sIndProcequi = '7') Then
            v_bActEstMovim := True;
        End If;

	    --No tiene sentido de todas formas devuelve el valor y en la funcion principal no se consulta por
		--si retorna true o false!!!
        --If (Trim$(sIndProcequi) = "0" Or Trim$(sIndProcequi) = "") Then
        --    bGenMovi = True
        --    Exit Function
        --Else
        --    bGenMovi = False
        --    Exit Function
        --End If

	END IF;

	RETURN v_sRetorno;

EXCEPTION
	WHEN OTHERS THEN
		 RAISE;
END sGenMovi;


/* ************************************************************** */
FUNCTION bActPreliq(P_NNUMVENTA     IN NUMBER,
					P_SCAUSARECHAZO IN VARCHAR2 )
RETURN BOOLEAN IS

BEGIN

	UPDATE GA_PRELIQUIDACION
	   SET IND_ESTVENTA = 'RE',
	       FEC_ACEPREC=SYSDATE,
	       COD_CAUSAREC = P_SCAUSARECHAZO
	 WHERE NUM_VENTA= P_NNUMVENTA;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bActPreliq;


/* ************************************************************** */
FUNCTION bValidaEjecNC(P_NNUMVENTA IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno BOOLEAN:=FALSE;
v_IND_PAGADO  GE_MODVENTA.IND_PAGADO%TYPE;

v_COD_ESTADOC FA_INTERFACT.COD_ESTADOC%TYPE;
v_COD_ESTPROC FA_INTERFACT.COD_ESTPROC%TYPE;


BEGIN

	SELECT A.IND_PAGADO
	  INTO v_IND_PAGADO
	  FROM GE_MODVENTA A, GA_VENTAS B
	 WHERE B.NUM_VENTA= P_NNUMVENTA
	   AND  A.COD_MODVENTA=B.COD_MODVENTA;

	If v_IND_PAGADO <> '1' Then
		--Valida si la venta se encuentra en estado < 500, aun no ha sido visada
		--Debe actualizar registro en interfact con estado 920.
		SELECT COD_ESTADOC,COD_ESTPROC
		  INTO v_COD_ESTADOC,v_COD_ESTPROC
		  FROM FA_INTERFACT
		 WHERE NUM_VENTA= P_NNUMVENTA;

         If (v_COD_ESTADOC >= 400 And v_COD_ESTPROC = 3) AND (bvTipComis(P_NNUMVENTA) <> '1') Then  --Venta aun no visada luego se anula 920 solo si es Consignacion
             v_bRetorno := True;
         ElsIf (v_COD_ESTADOC < 500 And v_COD_ESTPROC = 3) AND (bvTipComis(P_NNUMVENTA) = '1') Then
             UPDATE FA_INTERFACT
			    SET COD_ESTADOC = '920'
                   ,NOM_USUAELIM = USER
                   ,COD_CAUSAELIM= '00007'
             WHERE NUM_VENTA = P_NNUMVENTA;

         End If;
	END IF;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bValidaEjecNC;


/* ************************************************************** */
FUNCTION bCallPlLiquidacion(P_NNUMVENTA       IN NUMBER,
                            v_sNumTransaccion IN NUMBER,
							v_sNumProceso     IN NUMBER,
                            v_sError          OUT VARCHAR2,
							v_sMess           OUT VARCHAR2)

RETURN BOOLEAN IS

v_bRetorno   BOOLEAN:=FALSE;
v_sCodSalida GA_TRANSACABO.COD_RETORNO%TYPE;
v_sCadSalida GA_TRANSACABO.DES_CADENA%TYPE;


BEGIN

	P_LIQUIDACION_DEUDA(P_NNUMVENTA, v_sNumTransaccion);

	SELECT COD_RETORNO, DES_CADENA
	  INTO v_sCodSalida, v_sCadSalida
	  FROM GA_TRANSACABO
	 WHERE NUM_TRANSACCION = v_sNumTransaccion;

	DELETE GA_TRANSACABO WHERE NUM_TRANSACCION = v_sNumTransaccion;

	if v_sCodSalida = '0' then
	   v_bRetorno := TRUE;
       --v_sNumProceso := v_sCadSalida;
	ELSIF v_sCodSalida = '9' then
	   v_bRetorno := TRUE;
       --v_sNumProceso := '';
	Else
	    If v_sCodSalida = '8' Then
          v_sCadSalida := v_sCadSalida || ' VALIDAR SI POSEE PERMISO PARA GENERAR NOTA DE CREDITO ';
        End If;
		v_sError:= '1';
		v_sMess := 'Error en P_LIQUIDACION_DEUDA ' || v_sCadSalida;
    END IF;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bCallPlLiquidacion;

/* ************************************************************** */
FUNCTION bInsertSolicLiq(P_NNUMVENTA   IN NUMBER,
						 v_sNumProceso IN NUMBER,
                         v_sError      OUT VARCHAR2,
					  	 v_sMess       OUT VARCHAR2)
RETURN BOOLEAN IS

v_COD_VENDEDOR  GA_VENTAS.COD_VENDEDOR%TYPE;
v_COD_CLIENTE   GA_VENTAS.COD_CLIENTE%TYPE;
v_Cod_CanalVta  VE_TIPCOMIS.IND_VTA_EXTERNA%TYPE;
v_sQuery        VARCHAR2(5000);
v_nCOD_TIPDOCUM NUMBER;
v_nNUM_FOLIO    NUMBER;
v_nPREF_PLAZA   VARCHAR2(10);
v_sNUM_FOLIO    GA_DOCVENTA.NUM_FOLIO%TYPE;
v_nPos          NUMBER;

BEGIN

	SELECT COD_VENDEDOR, COD_CLIENTE
	  INTO v_COD_VENDEDOR, v_COD_CLIENTE
	  FROM GA_VENTAS
	 WHERE NUM_VENTA = P_NNUMVENTA;

	BEGIN
		SELECT IND_VTA_EXTERNA
		  INTO v_Cod_CanalVta
		  FROM VE_TIPCOMIS
		 WHERE COD_TIPCOMIS IN (SELECT COD_TIPCOMIS
		                          FROM VE_VENDEDORES
								 WHERE COD_VENDEDOR = v_COD_VENDEDOR);
	EXCEPTION
		WHEN OTHERS THEN
	       v_Cod_CanalVta:=NULL;
	END;


    IF v_Cod_CanalVta = '0' THEN
	    BEGIN
			SELECT COD_TIPDOCUM, NUM_FOLIO
			  INTO v_nCOD_TIPDOCUM, v_sNUM_FOLIO
			  FROM GA_DOCVENTA
			 WHERE NUM_VENTA = P_NNUMVENTA
			   AND (COD_TIPDOCUM IN (SELECT COD_DOCBOLETA
			                           FROM GA_DATOSGENER)
			    OR COD_TIPDOCUM IN (SELECT COD_DOCGUIA
				                      FROM GA_DATOSGENER));
		EXCEPTION
			WHEN OTHERS THEN
		       v_nCOD_TIPDOCUM:=NULL;
			   v_sNUM_FOLIO   :='0';
		END;

        v_nPos := INSTR(v_sNUM_FOLIO, '-');
		if v_nPos>0 then
           v_nPREF_PLAZA := TO_NUMBER(SUBSTR(v_sNUM_FOLIO, 1, v_nPos - 1));
           v_nNUM_FOLIO := TO_NUMBER(SUBSTR(v_sNUM_FOLIO, v_nPos + 1));
		else
           v_nPREF_PLAZA := 0;
           v_nNUM_FOLIO:= TO_NUMBER(v_sNUM_FOLIO);
		end if;

    elsif v_Cod_CanalVta = '1' THEN
		SELECT COD_DOCDEALER, 0, NUM_FOLDEALER
		  INTO v_nCOD_TIPDOCUM, v_nNUM_FOLIO, v_nPREF_PLAZA
		  FROM GA_PRELIQUIDACION
		 WHERE NUM_VENTA = P_NNUMVENTA;

    else
		v_nCOD_TIPDOCUM :=0;
		v_nPREF_PLAZA   :=0;
		v_nNUM_FOLIO    :=0;
	END IF;

    If v_nCOD_TIPDOCUM is not null And v_nPREF_PLAZA is not null Then
		v_sQuery := 'INSERT INTO GAT_SOLICLIQ_DEUDA';
		v_sQuery := v_sQuery || '(NUM_VENTA';
		v_sQuery := v_sQuery || ', COD_CLIENTE';
		v_sQuery := v_sQuery || ', COD_TIPDOCUM';
		v_sQuery := v_sQuery || ', NUM_FOLIO';
		v_sQuery := v_sQuery || ', NUM_PROCESO';
		v_sQuery := v_sQuery || ', NUM_SEC_NCP';
		v_sQuery := v_sQuery || ', FEC_INGRESO_SOL';
		v_sQuery := v_sQuery || ', FEC_PROCESO';
		v_sQuery := v_sQuery || ', PREF_PLAZA)';
		v_sQuery := v_sQuery || ' VALUES (';
		v_sQuery := v_sQuery || ' :1';
		v_sQuery := v_sQuery || ',:2';
		v_sQuery := v_sQuery || ',:3';
		v_sQuery := v_sQuery || ',:4';
		v_sQuery := v_sQuery || ',:5';
		v_sQuery := v_sQuery || ',NULL';
		v_sQuery := v_sQuery || ',SYSDATE';
		v_sQuery := v_sQuery || ',NULL';
		v_sQuery := v_sQuery || ',:6)';

		BEGIN
			EXECUTE IMMEDIATE v_sQuery USING P_NNUMVENTA,
							  		   v_COD_CLIENTE,
							  		   v_nCOD_TIPDOCUM,
							  		   v_nPREF_PLAZA,
							  		   v_sNumProceso,
							  		   v_nNUM_FOLIO;
		EXCEPTION
			WHEN OTHERS THEN
	             v_sError := SQLCODE;
		         v_sMess := 'Error al INSERTAR en GAT_SOLICLIQ_DEUDA ' || SQLERRM;
			     RAISE Error_retorno_i;
		END;

    End If;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bInsertSolicLiq;

/* ************************************************************** */
FUNCTION bReutilCelular(P_NNUMABONADO  IN NUMBER,
						P_cod_prod_cel IN NUMBER)
RETURN BOOLEAN IS

v_sNumCelular GA_ABOCEL.NUM_CELULAR%TYPE;

BEGIN

	 SELECT NUM_CELULAR
	   INTO v_sNumCelular
	   FROM GA_ABOCEL
	  WHERE NUM_ABONADO = P_NNUMABONADO;


    If bNum_Duplicado(v_sNumCelular, P_NNUMABONADO) Then

		INSERT INTO GA_CELNUM_REUTIL (NUM_CELULAR, COD_SUBALM, COD_PRODUCTO,
		            COD_CENTRAL, COD_CAT, USO_ANTERIOR, FEC_BAJA, IND_EQUIPADO, COD_USO )
		(SELECT b.NUM_CELULAR, a.COD_SUBALM, a.COD_PRODUCTO,b.COD_CENTRAL,
		        a.COD_CAT, a.COD_USO, SYSDATE, 1, B.COD_USO
		   FROM GA_CELNUM_USO a, GA_ABOCEL b
		  WHERE b.NUM_ABONADO = P_NNUMABONADO
		    AND a.COD_PRODUCTO =  P_cod_prod_cel
		    AND b.NUM_CELULAR >= a.NUM_DESDE AND b.NUM_CELULAR <= a.NUM_HASTA);

    End If;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bReutilCelular;


/* ************************************************************** */
FUNCTION bDarBajaAbonado(P_NNUMABONADO  IN NUMBER,
						  P_cod_prod_cel IN NUMBER)
RETURN BOOLEAN IS
v_bRetorno BOOLEAN;

BEGIN

	if bPasarAHistoricoAbo(P_NNUMABONADO, P_cod_prod_cel) Then

       v_bRetorno := bBorrarAbonado(P_NNUMABONADO);

	end if;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
	    RAISE;
END bDarBajaAbonado;

/* ************************************************************** */
FUNCTION bPasarAHistoricoAbo(P_NNUMABONADO  IN NUMBER,
						     P_cod_prod_cel IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno  BOOLEAN:= FALSE;

BEGIN

	v_bRetorno := bHistABOCEL(P_NNUMABONADO);

	if v_bRetorno then
		v_bRetorno :=bHistEQUIPABOSER(P_NNUMABONADO);
	end if;

	if v_bRetorno then
		v_bRetorno :=bHistEQUIPABONOSER(P_NNUMABONADO, P_cod_prod_cel);
	end if;

	if v_bRetorno then
		v_bRetorno :=bHistMODABOCEL(P_NNUMABONADO);
	end if;

	if v_bRetorno then
		v_bRetorno :=bHistSEGURABO(P_NNUMABONADO);
	end if;

	if v_bRetorno then
		v_bRetorno :=bHistSERVSUPLABO(P_NNUMABONADO);
	end if;

	if v_bRetorno then
		v_bRetorno :=bHistDIASABO(P_NNUMABONADO);
	end if;

	if v_bRetorno then
		v_bRetorno :=bHistNUMESPABO(P_NNUMABONADO);
	end if;

	if v_bRetorno then
		v_bRetorno :=bHistSINIESTROS(P_NNUMABONADO);
	end if;

	if v_bRetorno then
		v_bRetorno :=bHistDETSINIE(P_NNUMABONADO, P_cod_prod_cel);
	end if;

	if v_bRetorno then
		v_bRetorno :=bHistSUSPREHABO(P_NNUMABONADO);
	end if;

	if v_bRetorno then
		v_bRetorno :=bHistTRASPABO(P_NNUMABONADO);
	end if;

	if v_bRetorno then
		v_bRetorno :=bHistDTOSTARIF(P_NNUMABONADO);
	end if;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bPasarAHistoricoAbo;

/* ************************************************************** */
FUNCTION bHistABOCEL(P_NNUMABONADO IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno  BOOLEAN:= FALSE;
v_sQuery    VARCHAR2(5000);
v_sQueryEnd VARCHAR2(5000);
BEGIN

	BEGIN
		INSERT INTO GA_HABOCEL (
		NUM_ABONADO, NUM_CELULAR, COD_PRODUCTO, COD_CLIENTE,
		 COD_CUENTA, COD_SUBCUENTA, COD_USUARIO, COD_REGION,
		 COD_PROVINCIA, COD_CIUDAD, COD_CELDA, COD_CENTRAL,
		 COD_USO, COD_SITUACION, IND_PROCALTA, IND_PROCEQUI,
		 COD_VENDEDOR, COD_VENDEDOR_AGENTE, TIP_PLANTARIF,
		 TIP_TERMINAL, COD_PLANTARIF, COD_CARGOBASICO,
		 COD_PLANSERV, COD_LIMCONSUMO, NUM_SERIE, NUM_SERIEHEX,
		 NOM_USUARORA, FEC_ALTA, NUM_PERCONTRATO, COD_ESTADO,
		 NUM_SERIEMEC, COD_HOLDING, COD_EMPRESA, COD_GRPSERV,
		 IND_SUPERTEL, NUM_TELEFIJA, COD_OPREDFIJA, COD_CARRIER,
		 IND_PREPAGO, IND_PLEXSYS, COD_CENTRAL_PLEX,
		 NUM_CELULAR_PLEX, NUM_VENTA, COD_MODVENTA, COD_TIPCONTRATO,
		 NUM_CONTRATO, NUM_ANEXO, FEC_CUMPLAN, COD_CREDMOR,
		 COD_CREDCON, COD_CICLO, IND_FACTUR, IND_SUSPEN,
		 IND_REHABI, IND_INSGUIAS, FEC_FINCONTRA, FEC_RECDOCUM,
		 FEC_CUMPLIMEN, FEC_ACEPVENTA, FEC_ACTCEN,
		 FEC_BAJACEN, FEC_ULTMOD, COD_CAUSABAJA, NUM_PERSONAL,
		 IND_SEGURO, CLASE_SERVICIO, PERFIL_ABONADO, FEC_BAJA, NUM_MIN,
		 COD_TECNOLOGIA, NUM_IMEI, FEC_HISTORICO )
		SELECT
		NUM_ABONADO, NUM_CELULAR, COD_PRODUCTO, COD_CLIENTE,
		 COD_CUENTA, COD_SUBCUENTA, COD_USUARIO, COD_REGION,
		 COD_PROVINCIA, COD_CIUDAD, COD_CELDA, COD_CENTRAL,
		 COD_USO, COD_SITUACION, IND_PROCALTA, IND_PROCEQUI,
		 COD_VENDEDOR, COD_VENDEDOR_AGENTE, TIP_PLANTARIF,
		 TIP_TERMINAL, COD_PLANTARIF, COD_CARGOBASICO,
		 COD_PLANSERV, COD_LIMCONSUMO, NUM_SERIE, NUM_SERIEHEX,
		 NOM_USUARORA, FEC_ALTA, NUM_PERCONTRATO, COD_ESTADO,
		 NUM_SERIEMEC, COD_HOLDING, COD_EMPRESA, COD_GRPSERV,
		 IND_SUPERTEL, NUM_TELEFIJA, COD_OPREDFIJA, COD_CARRIER,
		 IND_PREPAGO, IND_PLEXSYS, COD_CENTRAL_PLEX,
		 NUM_CELULAR_PLEX, NUM_VENTA, COD_MODVENTA, COD_TIPCONTRATO,
		 NUM_CONTRATO, NUM_ANEXO, FEC_CUMPLAN, COD_CREDMOR,
		 COD_CREDCON, COD_CICLO, IND_FACTUR, IND_SUSPEN,
		 IND_REHABI, IND_INSGUIAS, FEC_FINCONTRA, FEC_RECDOCUM,
		 FEC_CUMPLIMEN, FEC_ACEPVENTA, FEC_ACTCEN,
		 FEC_BAJACEN, FEC_ULTMOD, COD_CAUSABAJA, NUM_PERSONAL,
		 IND_SEGURO, CLASE_SERVICIO, PERFIL_ABONADO, FEC_BAJA, NUM_MIN,
		 COD_TECNOLOGIA, NUM_IMEI,  SYSDATE
		FROM GA_ABOCEL WHERE NUM_ABONADO = P_NNUMABONADO;

	EXCEPTION
		WHEN OTHERS THEN
		     RAISE Error_retorno_i;
	END;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bHistABOCEL;


/* ************************************************************** */
FUNCTION bHistEQUIPABOSER(P_NNUMABONADO IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno  BOOLEAN:= FALSE;
v_sQuery    VARCHAR2(5000);
v_sQueryEnd VARCHAR2(5000);
BEGIN

	BEGIN
		INSERT INTO GA_HEQUIPABOSER (
			NUM_ABONADO, NUM_SERIE, COD_PRODUCTO,
			IND_PROCEQUI, FEC_ALTA, IND_PROPIEDAD,
			COD_BODEGA, TIP_STOCK, COD_ARTICULO,
			IND_EQUIACC, COD_MODVENTA, TIP_TERMINAL,
			COD_USO, COD_ESTADO, CAP_CODE, NUM_SERIEMEC,
			DES_EQUIPO, COD_PAQUETE, NUM_MOVIMIENTO, COD_CAUSA,
			 COD_PROTOCOLO, COD_FRECUENCIA, NUM_VELOCIDAD, COD_CUOTA,
			COD_VERSION, NUM_IMEI, FEC_HISTORICO )
		SELECT NUM_ABONADO, NUM_SERIE, COD_PRODUCTO,
			IND_PROCEQUI, FEC_ALTA, IND_PROPIEDAD,
			COD_BODEGA, TIP_STOCK, COD_ARTICULO,
			IND_EQUIACC, COD_MODVENTA, TIP_TERMINAL,
			COD_USO, COD_ESTADO, CAP_CODE, NUM_SERIEMEC,
			DES_EQUIPO, COD_PAQUETE, NUM_MOVIMIENTO, COD_CAUSA,
			 COD_PROTOCOLO, COD_FRECUENCIA, NUM_VELOCIDAD, COD_CUOTA,
			COD_VERSION, NUM_IMEI, SYSDATE
		FROM GA_EQUIPABOSER WHERE NUM_ABONADO = P_NNUMABONADO;

	EXCEPTION
		WHEN OTHERS THEN
		     RAISE Error_retorno_i;
	END;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bHistEQUIPABOSER;
/* ************************************************************** */
FUNCTION bHistEQUIPABONOSER(P_NNUMABONADO IN NUMBER,
						    P_cod_prod_cel IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno  BOOLEAN:= FALSE;
v_sQuery    VARCHAR2(5000);
v_sQueryEnd VARCHAR2(5000);
BEGIN

	BEGIN
		INSERT INTO GA_HEQUIPABONOSER (
			NUM_ABONADO, COD_ARTICULO, FEC_ALTA, NUM_MOVIMIENTO,
			 COD_PRODUCTO, NUM_UNIDADES, COD_BODEGA, TIP_STOCK,
			 COD_USO, COD_ESTADO, COD_PAQUETE, FEC_HISTORICO )
		SELECT NUM_ABONADO, COD_ARTICULO, FEC_ALTA, NUM_MOVIMIENTO,
			 COD_PRODUCTO, NUM_UNIDADES, COD_BODEGA, TIP_STOCK,
			 COD_USO, COD_ESTADO, COD_PAQUETE, SYSDATE
		FROM GA_EQUIPABONOSER WHERE
		NUM_ABONADO = P_NNUMABONADO;
	EXCEPTION
		WHEN OTHERS THEN
		     RAISE Error_retorno_i;
	END;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bHistEQUIPABONOSER;
/* ************************************************************** */
FUNCTION bHistMODABOCEL(P_NNUMABONADO IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno  BOOLEAN:= FALSE;
v_sQuery    VARCHAR2(5000);
v_sQueryEnd VARCHAR2(5000);
BEGIN

	BEGIN
		INSERT INTO GA_HMODABOCEL (
			NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA, NOM_USUARORA,
			NUM_CELULAR, COD_REGION, COD_PROVINCIA,
			COD_CIUDAD, COD_CELDA, COD_CENTRAL, COD_USO,
			TIP_PLANTARIF, TIP_TERMINAL, COD_PLANTARIF,
			COD_CARGOBASICO, COD_PLANSERV, COD_LIMCONSUMO,
			NUM_SERIE, NUM_SERIEHEX, NUM_SERIEMEC, COD_HOLDING,
			COD_EMPRESA, COD_GRPSERV, NUM_TELEFIJA, COD_CARRIER,
			IND_PLEXSYS, COD_CENTRAL_PLEX, NUM_CELULAR_PLEX,
			COD_CREDMOR, COD_CREDCON, COD_CICLO, IND_FACTUR,
			IND_SUSPEN, IND_REHABI, IND_INSGUIAS, NUM_PERSONAL, COD_CAUSA,
			COD_TECNOLOGIA, NUM_IMEI
			, FEC_HISTORICO)
		SELECT NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA, NOM_USUARORA,
			NUM_CELULAR, COD_REGION, COD_PROVINCIA,
			COD_CIUDAD, COD_CELDA, COD_CENTRAL, COD_USO,
			TIP_PLANTARIF, TIP_TERMINAL, COD_PLANTARIF,
			COD_CARGOBASICO, COD_PLANSERV, COD_LIMCONSUMO,
			NUM_SERIE, NUM_SERIEHEX, NUM_SERIEMEC, COD_HOLDING,
			COD_EMPRESA, COD_GRPSERV, NUM_TELEFIJA, COD_CARRIER,
			IND_PLEXSYS, COD_CENTRAL_PLEX, NUM_CELULAR_PLEX,
			COD_CREDMOR, COD_CREDCON, COD_CICLO, IND_FACTUR,
			IND_SUSPEN, IND_REHABI, IND_INSGUIAS, NUM_PERSONAL, COD_CAUSA,
			COD_TECNOLOGIA, NUM_IMEI
			, SYSDATE
		FROM GA_MODABOCEL WHERE NUM_ABONADO = P_NNUMABONADO;

	EXCEPTION
		WHEN OTHERS THEN
		     RAISE Error_retorno_i;
	END;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bHistMODABOCEL;
/* ************************************************************** */
FUNCTION bHistSEGURABO(P_NNUMABONADO IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno  BOOLEAN:= FALSE;
v_sQuery    VARCHAR2(5000);
v_sQueryEnd VARCHAR2(5000);
BEGIN

	BEGIN
		INSERT INTO GA_HSEGURABO ( NUM_ABONADO, FEC_ALTA, COD_PRODUCTO,
			NUM_TERMINAL, NUM_SERIE, COD_TIPSEGU,
			NUM_CONTRATO, NUM_PERIODO, FEC_FINCONTRATO,
			NOM_USUARORA, NUM_ANEXO, FEC_HISTORICO )
		SELECT NUM_ABONADO, FEC_ALTA, COD_PRODUCTO,
			NUM_TERMINAL, NUM_SERIE, COD_TIPSEGU,
			NUM_CONTRATO, NUM_PERIODO, FEC_FINCONTRATO,
			NOM_USUARORA, NUM_ANEXO, SYSDATE
		FROM GA_SEGURABO WHERE NUM_ABONADO = P_NNUMABONADO;

	EXCEPTION
		WHEN OTHERS THEN
		     RAISE Error_retorno_i;
	END;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bHistSEGURABO;

/* ************************************************************** */
FUNCTION bHistSERVSUPLABO(P_NNUMABONADO IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno  BOOLEAN:= FALSE;
v_sQuery    VARCHAR2(5000);
v_sQueryEnd VARCHAR2(5000);
BEGIN

	BEGIN
		INSERT INTO GA_HSERVSUPLABO (
			NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL,
			COD_NIVEL, COD_PRODUCTO, NUM_TERMINAL,
			NOM_USUARORA, IND_ESTADO, FEC_ALTACEN,
			FEC_BAJABD, FEC_BAJACEN, COD_CONCEPTO, NUM_DIASNUM, FEC_HISTORICO )
		SELECT NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL,
			COD_NIVEL, COD_PRODUCTO, NUM_TERMINAL,
			NOM_USUARORA, IND_ESTADO, FEC_ALTACEN,
			FEC_BAJABD, FEC_BAJACEN, COD_CONCEPTO, NUM_DIASNUM, SYSDATE
		FROM GA_SERVSUPLABO WHERE NUM_ABONADO = P_NNUMABONADO;
	EXCEPTION
		WHEN OTHERS THEN
		     RAISE Error_retorno_i;
	END;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bHistSERVSUPLABO;
/* ************************************************************** */
FUNCTION bHistDIASABO(P_NNUMABONADO IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno  BOOLEAN:= FALSE;
v_sQuery    VARCHAR2(5000);
v_sQueryEnd VARCHAR2(5000);
BEGIN

	v_sQuery := 'NUM_ABONADO, COD_PRODUCTO, DES_DIAESP, COD_TIPDIA, ';
	v_sQuery := v_sQuery || 'FEC_DIAESP, NUM_DIASNUM ';
	v_sQueryEnd := 'INSERT INTO GA_HDIASABO (';
	v_sQueryEnd := v_sQueryEnd || v_sQuery || ' , FEC_HISTORICO )';
	v_sQueryEnd := v_sQueryEnd || 'SELECT ' || v_sQuery || ', SYSDATE ';
	v_sQueryEnd := v_sQueryEnd || 'FROM GA_DIASABO WHERE NUM_ABONADO = :1';

	BEGIN
		EXECUTE IMMEDIATE v_sQuery USING P_NNUMABONADO;
	EXCEPTION
		WHEN OTHERS THEN
		     RAISE Error_retorno_i;
	END;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bHistDIASABO;
/* ************************************************************** */
FUNCTION bHistNUMESPABO(P_NNUMABONADO IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno  BOOLEAN:= FALSE;
v_sQuery    VARCHAR2(5000);
v_sQueryEnd VARCHAR2(5000);
BEGIN

	v_sQuery := 'NUM_ABONADO, NUM_TELEFESP, NUM_DIASNUM ';
	v_sQueryEnd := 'INSERT INTO GA_HNUMESPABO (';
	v_sQueryEnd := v_sQueryEnd || v_sQuery || ', FEC_HISTORICO )';
	v_sQueryEnd := v_sQueryEnd || ' SELECT ' || v_sQuery || ', SYSDATE ';
	v_sQueryEnd := v_sQueryEnd || 'FROM GA_NUMESPABO WHERE NUM_ABONADO = :1';

	BEGIN
		EXECUTE IMMEDIATE v_sQuery USING P_NNUMABONADO;
	EXCEPTION
		WHEN OTHERS THEN
		     RAISE Error_retorno_i;
	END;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bHistNUMESPABO;
/* ************************************************************** */
FUNCTION bHistSINIESTROS(P_NNUMABONADO IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno  BOOLEAN:= FALSE;
v_sQuery    VARCHAR2(5000);
v_sQueryEnd VARCHAR2(5000);
BEGIN

	BEGIN
		INSERT INTO GA_HSINIESTROS (
			NUM_SINIESTRO, NUM_ABONADO, COD_PRODUCTO, COD_CAUSA,
			COD_ESTADO, NUM_TERMINAL, NUM_SERIE,
			FEC_SINIESTRO, COD_CARGOBASICO, COD_SERVICIO, FEC_FORMALIZA,
			FEC_ANULA, FEC_RESTITUC, NUM_CONSTPOL, NUM_SOLLIQ,
			NUM_SERIEREP, FEC_HISTORICO)
		 SELECT NUM_SINIESTRO, NUM_ABONADO, COD_PRODUCTO, COD_CAUSA,
			COD_ESTADO, NUM_TERMINAL, NUM_SERIE,
			FEC_SINIESTRO, COD_CARGOBASICO, COD_SERVICIO, FEC_FORMALIZA,
			FEC_ANULA, FEC_RESTITUC, NUM_CONSTPOL, NUM_SOLLIQ,
			NUM_SERIEREP
			, SYSDATE
		 FROM GA_SINIESTROS WHERE NUM_ABONADO = P_NNUMABONADO;

	EXCEPTION
		WHEN OTHERS THEN
		     RAISE Error_retorno_i;
	END;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bHistSINIESTROS;
/* ************************************************************** */
FUNCTION bHistDETSINIE(P_NNUMABONADO IN NUMBER,
				       sCodProducto  IN NUMBER)
RETURN BOOLEAN IS

CURSOR c_siniestros IS
SELECT NUM_SINIESTRO
  FROM GA_SINIESTROS
 WHERE NUM_ABONADO = P_NNUMABONADO
   AND COD_PRODUCTO = sCodProducto;

v_sQuery    VARCHAR2(5000);
v_sQueryEnd VARCHAR2(5000);
BEGIN

	FOR CADA_SINIESTRO IN c_siniestros LOOP

		v_sQuery := 'NUM_SINIESTRO, COD_ESTADO, FEC_DETALLE, NOM_USUARORA, ';
		v_sQuery := v_sQuery || 'OBS_DETALLE';
		v_sQueryEnd := 'INSERT INTO GA_HDETSINIE (';
		v_sQueryEnd := v_sQueryEnd || v_sQuery || ', FEC_HISTORICO ) ';
		v_sQueryEnd := v_sQueryEnd || 'SELECT ' || v_sQuery || ', SYSDATE';
		v_sQueryEnd := v_sQueryEnd || ' FROM GA_DETSINIE WHERE NUM_SINIESTRO = :1';

		BEGIN
			EXECUTE IMMEDIATE v_sQuery USING CADA_SINIESTRO.NUM_SINIESTRO;
		EXCEPTION
			WHEN OTHERS THEN
			    RAISE Error_retorno_i;
		END;

	END LOOP;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bHistDETSINIE;
/* ************************************************************** */
FUNCTION bHistSUSPREHABO(P_NNUMABONADO IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno  BOOLEAN:= FALSE;
v_sQuery    VARCHAR2(5000);
v_sQueryEnd VARCHAR2(5000);
BEGIN

	BEGIN
		INSERT INTO GA_HSUSPREHABO (
			NUM_ABONADO, COD_SERVICIO, FEC_SUSPBD, COD_PRODUCTO,
			NUM_TERMINAL, NOM_USUARORA, COD_MODULO,
			TIP_REGISTRO, COD_CAUSUSP, TIP_SUSP, COD_SERVSUPL,
			COD_NIVEL, FEC_SUSPCEN, FEC_REHABD, FEC_REHACEN, COD_CARGOBASICO,
			COD_OPERADOR, IND_SINIESTRO, FEC_HISTORICO)
		SELECT NUM_ABONADO, COD_SERVICIO, FEC_SUSPBD, COD_PRODUCTO,
			NUM_TERMINAL, NOM_USUARORA, COD_MODULO,
			TIP_REGISTRO, COD_CAUSUSP, TIP_SUSP, COD_SERVSUPL,
			COD_NIVEL, FEC_SUSPCEN, FEC_REHABD, FEC_REHACEN, COD_CARGOBASICO,
			COD_OPERADOR, IND_SINIESTRO, SYSDATE
		FROM GA_SUSPREHABO WHERE NUM_ABONADO = P_NNUMABONADO;

	EXCEPTION
		WHEN OTHERS THEN
		     RAISE Error_retorno_i;
	END;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bHistSUSPREHABO;

/* ************************************************************** */
FUNCTION bHistTRASPABO(P_NNUMABONADO IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno  BOOLEAN:= FALSE;
v_sQuery    VARCHAR2(5000);
v_sQueryEnd VARCHAR2(5000);
BEGIN

	BEGIN
		INSERT INTO GA_HTRASPABO (
			 NUM_ABONADO, FEC_MODIFICA, COD_CLIENNUE, COD_CUENTANUE,
			COD_SUBCTANUE, COD_USUARNUE, COD_PRODUCTO,
			NUM_TERMINAL, NUM_ABONADOANT, COD_CLIENANT,
			COD_CUENTAANT, COD_SUBCTAANT, COD_USUARANT,
			IND_TRASDEUDA, NOM_USUARORA, FEC_HISTORICO)
		SELECT  NUM_ABONADO, FEC_MODIFICA, COD_CLIENNUE, COD_CUENTANUE,
			COD_SUBCTANUE, COD_USUARNUE, COD_PRODUCTO,
			NUM_TERMINAL, NUM_ABONADOANT, COD_CLIENANT,
			COD_CUENTAANT, COD_SUBCTAANT, COD_USUARANT,
			IND_TRASDEUDA, NOM_USUARORA,SYSDATE
		FROM GA_TRASPABO
		WHERE NUM_ABONADO = P_NNUMABONADO;

	EXCEPTION
		WHEN OTHERS THEN
		     RAISE Error_retorno_i;
	END;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bHistTRASPABO;


/* ************************************************************** */
FUNCTION bHistDTOSTARIF(P_NNUMABONADO IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno  BOOLEAN:= FALSE;
v_sQuery    VARCHAR2(5000);
v_sQueryEnd VARCHAR2(5000);
BEGIN

	v_sQuery := 'NUM_ABONADO, COD_CICLFACT, NUM_MINUTOS, TIP_PLANTARIF, ';
	v_sQuery := v_sQuery || 'COD_VENDEDOR, NOM_USUARORA, FEC_GRABACION ';
	v_sQueryEnd := 'INSERT INTO GA_HDTOSTARIF ( ';
	v_sQueryEnd := v_sQueryEnd || v_sQuery || ', FEC_BAJA) ';
	v_sQueryEnd := v_sQueryEnd || 'SELECT ' || v_sQuery || ', SYSDATE ';
	v_sQueryEnd := v_sQueryEnd || 'FROM GA_DTOSTARIF WHERE NUM_ABONADO = :1' ;

	BEGIN
		EXECUTE IMMEDIATE v_sQuery USING P_NNUMABONADO;
	EXCEPTION
		WHEN OTHERS THEN
		     RAISE Error_retorno_i;
	END;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bHistDTOSTARIF;

/* ************************************************************** */
FUNCTION bBorrarAbonado(P_NNUMABONADO IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno    BOOLEAN:= FALSE;
v_num_celular GA_ABOCEL.num_celular%TYPE;

BEGIN

--asNomTabl(0) = "GA_EQUIPABOSER"
--asNomTabl(1) = "GA_EQUIPABONOSER"
--asNomTabl(2) = "GA_SEGURABO"
--asNomTabl(3) = "GA_SERVSUPLABO"
--asNomTabl(4) = "GA_DIASABO"
--asNomTabl(5) = "GA_NUMESPABO"
--asNomTabl(6) = "GA_SUSPREHABO"
--asNomTabl(7) = "GA_TRASPABO"
--asNomTabl(8) = "GA_SINIESTROS"
--asNomTabl(9) = "GA_MODABOCEL"
--asNomTabl(10) = "GA_POST_MOVIVOX"
--asNomTabl(11) = "GA_DET_MOVIVOX"
--asNomTabl(12) = "GA_CAB_MOVIVOX"
--asNomTabl(13) = sNomTablaAbo
--asNomTabl(14) = "GA_DTOSTARIF"
--asNomTabl(15) = "GA_PETSR"

    BEGIN
		SELECT num_celular
		  INTO v_num_celular
		  FROM GA_ABOCEL
		 WHERE num_abonado = P_NNUMABONADO;
	EXCEPTION
		WHEN OTHERS THEN
	       v_num_celular:=NULL;
	END;


	If v_num_celular is not null Then
	    --Se borran todos los registros de la tabla GA_NUMESPABO
	    --asociados al numero de celular del abonado que hayan sido
	    --ingresados a otros abonados como N? frecuentes
	    DELETE GA_NUMESPABO WHERE num_telefesp = v_num_celular;
	End If;

	BEGIN

		DELETE GA_EQUIPABOSER   WHERE NUM_ABONADO = P_NNUMABONADO;
		DELETE GA_EQUIPABONOSER WHERE NUM_ABONADO = P_NNUMABONADO;
		DELETE GA_SEGURABO      WHERE NUM_ABONADO = P_NNUMABONADO;
		DELETE GA_SERVSUPLABO   WHERE NUM_ABONADO = P_NNUMABONADO;
		DELETE GA_DIASABO       WHERE NUM_ABONADO = P_NNUMABONADO;
		DELETE GA_NUMESPABO     WHERE NUM_ABONADO = P_NNUMABONADO;
		DELETE GA_SUSPREHABO    WHERE NUM_ABONADO = P_NNUMABONADO;
		DELETE GA_TRASPABO      WHERE NUM_ABONADO = P_NNUMABONADO;

		--Si es La tabla ga_siniestros antes hay que Eliminar los detalles de GA_DETSINIE
		if not bBorraDETSINIE(P_NNUMABONADO) then
		     RAISE Error_retorno_i;
		end if;

		DELETE GA_SINIESTROS    WHERE NUM_ABONADO = P_NNUMABONADO;
		DELETE GA_MODABOCEL     WHERE NUM_ABONADO = P_NNUMABONADO;
		DELETE GA_POST_MOVIVOX  WHERE NUM_ABONADO = P_NNUMABONADO;
		DELETE GA_DET_MOVIVOX   WHERE NUM_ABONADO = P_NNUMABONADO;
		DELETE GA_CAB_MOVIVOX   WHERE NUM_ABONADO = P_NNUMABONADO;
		DELETE GA_ABOCEL        WHERE NUM_ABONADO = P_NNUMABONADO;
		DELETE GA_DTOSTARIF     WHERE NUM_ABONADO = P_NNUMABONADO;
		DELETE GA_PETSR         WHERE NUM_ABONADO = P_NNUMABONADO;


	EXCEPTION
		WHEN OTHERS THEN
		     RAISE Error_retorno_i;
	END;

	RETURN v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bBorrarAbonado;
/* ************************************************************** */
FUNCTION bBorraDETSINIE(P_NNUMABONADO IN NUMBER)
RETURN BOOLEAN IS

CURSOR c_siniestros IS
SELECT NUM_SINIESTRO
  FROM GA_SINIESTROS
 WHERE NUM_ABONADO = P_NNUMABONADO;

BEGIN

	FOR CADA_SINIESTRO IN c_siniestros LOOP

		BEGIN
			DELETE GA_DETSINIE WHERE NUM_SINIESTRO = CADA_SINIESTRO.NUM_SINIESTRO;
		EXCEPTION
			WHEN OTHERS THEN
			    RAISE Error_retorno_i;
		END;

	END LOOP;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bBorraDETSINIE;

/* ************************************************************** */
FUNCTION bNum_Duplicado(sNumCelular   IN NUMBER,
                        P_NNUMABONADO IN NUMBER)
RETURN BOOLEAN IS

v_bRetorno   BOOLEAN;
v_sSituacion VARCHAR2(3):='BAA';
v_sROWID     VARCHAR2(50);

BEGIN

    BEGIN
		SELECT ROWID
		  INTO v_sROWID
		  FROM GA_ABOCEL
		 WHERE NUM_CELULAR = sNumCelular
		   AND NUM_ABONADO != P_NNUMABONADO
		   AND COD_SITUACION != v_sSituacion;
	EXCEPTION
		WHEN OTHERS THEN
	       v_sROWID:=NULL;
	END;


	if v_sROWID is null or v_sROWID = '' then
	    BEGIN
			SELECT ROWID
			  INTO v_sROWID
			  FROM AL_SERIES
			  WHERE NUM_TELEFONO = sNumCelular;
		EXCEPTION
			WHEN OTHERS THEN
		       v_sROWID:=NULL;
		END;

    end if;
	if v_sROWID is null or v_sROWID = '' then
	    BEGIN
			SELECT ROWID
			  INTO v_sROWID
			  FROM AL_FIC_SERIES
			 WHERE NUM_TELEFONO = sNumCelular;
		EXCEPTION
			WHEN OTHERS THEN
		       v_sROWID:=NULL;
		END;
    end if;

	if v_sROWID is null or v_sROWID = '' then
	    BEGIN
			SELECT ROWID
			  INTO v_sROWID
			  FROM GA_RESNUMCEL
			 WHERE NUM_CELULAR = sNumCelular;
		EXCEPTION
			WHEN OTHERS THEN
		       v_sROWID:=NULL;
		END;
    end if;

	if v_sROWID is null or v_sROWID = '' then
	    BEGIN
			SELECT ROWID
			  INTO v_sROWID
			  FROM GA_CELNUM_USO
			 WHERE sNumCelular BETWEEN NUM_DESDE AND NUM_HASTA
			   AND  NUM_SIGUIENTE <= sNumCelular;
		EXCEPTION
			WHEN OTHERS THEN
		       v_sROWID:=NULL;
		END;
    end if;

	if v_sROWID is null or v_sROWID = '' then
	   v_bRetorno:=FALSE;
	else
	   v_bRetorno:=TRUE;
	end if;

	return v_bRetorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
	    RAISE;
END bNum_Duplicado;

/* ************************************************************** */
/* FIN DEL CUERPO DEL PACKAGE.                                    */
/* ************************************************************** */

END VE_RECHAZO_DEFINITIVO_PG;
/
SHOW ERRORS
