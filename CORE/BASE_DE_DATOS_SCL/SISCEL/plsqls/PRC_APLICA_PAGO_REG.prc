CREATE OR REPLACE PROCEDURE Prc_Aplica_Pago_Reg(
hNumRegularizacion         IN NUMBER ,          /* Numero de Regularizacion */
hModoAplicacionPago        IN NUMBER            /* Manera en que se aplicara el pago : */
                                               /* 0 Por monto, 1: Por documento */
)
IS
/*
<Modificación    = 12-04-2006 Versión="1.0" CO-200603290023>
*/
---------------------------------------------------------------------------------------------
-- declaracion de excepciones
---------------------------------------------------------------------------------------------
ERROR_PROCESO  EXCEPTION ;
------------------------------------------------------------------------------------------
-- definicion de variables
---------------------------------------------------------------------------------------------
I BINARY_INTEGER;
iDecimal                NUMBER(2);
hDescError              VARCHAR2 (256);
hCuenta                 NUMBER;
hFecCancelacionDoc      DATE;
hFecEfectividadDes      CO_PAGOS.FEC_EFECTIVIDAD%TYPE;
hCodCajaDes             CO_PAGOS.COD_CAJA%TYPE;
hFecValorDes            CO_PAGOS.FEC_VALOR%TYPE;
hNomUsuarOraDes         CO_PAGOS.NOM_USUARORA%TYPE;
hCodForPagoDes          CO_PAGOS.COD_FORPAGO%TYPE;
hCodSisPagoDes          CO_PAGOS.COD_SISPAGO%TYPE;
hCodBancoDes            CO_PAGOS.COD_BANCO%TYPE;
hCodTipTarjetaDes       CO_PAGOS.COD_TIPTARJETA%TYPE;
hCodSucursalDes         CO_PAGOS.COD_SUCURSAL%TYPE;
hCtaCorrienteDes        CO_PAGOS.CTA_CORRIENTE%TYPE;
hNumTarjetaDes          CO_PAGOS.NUM_TARJETA%TYPE;
hNumComPagoDes          CO_PAGOS.NUM_COMPAGO%TYPE;
hTipoRegulariza         CO_HIST_REGULARIZA.TIPO_REGULARIZA%TYPE;
hFecRegulariza          CO_HIST_REGULARIZA.FEC_REGULARIZA%TYPE;
hStsRegulariza          CO_HIST_REGULARIZA.STS_REGULARIZA%TYPE;
hMontoRegulariza        CO_HIST_REGULARIZA.MONTO_REGULARIZA%TYPE;
hNumDocRespaldo         CO_HIST_REGULARIZA.NUM_DOC_RESPALDO%TYPE;
hCodClienteDes          CO_HIST_REGULARIZA.COD_CLIENTE_ORIGEN%TYPE;
hNumSecuenciDes         CO_HIST_REGULARIZA.NUM_SECUENCI_ORIGEN%TYPE;
hCodTipDocumDes         CO_HIST_REGULARIZA.COD_TIPDOCUM_ORIGEN%TYPE;
hCodVendedorAgenteDes   CO_HIST_REGULARIZA.COD_VENDEDOR_AGENTE_ORIGEN%TYPE;
hLetraDes               CO_HIST_REGULARIZA.COD_LETRA_ORIGEN%TYPE;
hCodCentremiDes         CO_HIST_REGULARIZA.COD_CENTREMI_ORIGEN%TYPE;
hFecPagoDes             CO_HIST_REGULARIZA.FEC_PAGO_ORIGEN%TYPE;
hImportePagoDes         CO_HIST_REGULARIZA.IMPORTE_PAGO_ORIGEN%TYPE;
hSaldoImpago            CO_HIST_REGULARIZA.IMPORTE_PAGO_ORIGEN%TYPE;
hImporteRestante        CO_HIST_REGULARIZA.IMPORTE_PAGO_ORIGEN%TYPE;
hOperadoraOrigen        CO_HIST_REGULARIZA.COD_OPERADORA_SCL_ORI%TYPE;
hPlazaOrigen            CO_HIST_REGULARIZA.COD_PLAZA_ORI%TYPE;
hOperadoraDestino       CO_HIST_REGULARIZA.COD_OPERADORA_SCL_DEST%TYPE;
hPlazaDestino           CO_HIST_REGULARIZA.COD_PLAZA_DEST%TYPE;
--Inicio RA-200512220384 03-02-2006
--hCodProducto            CO_CARTERA.COD_PRODUCTO%TYPE;
--hNumAbonado             CO_CARTERA.NUM_ABONADO%TYPE;
--Fin RA-200512220384 03-02-2006
hNumFolio               CO_CARTERA.NUM_FOLIO%TYPE;
hPref_Plaza				CO_CARTERA.PREF_PLAZA%TYPE;
hNumFolioCtc            CO_CARTERA.NUM_FOLIOCTC%TYPE;
hNumVenta               CO_CARTERA.NUM_VENTA%TYPE;
hFecVencimie            CO_CARTERA.FEC_VENCIMIE%TYPE;
hFecEfectividad         CO_CARTERA.FEC_EFECTIVIDAD%TYPE;
vRetorno                NUMBER(10);
vRetorno1               NUMBER(10);
vRetorno2               VARCHAR2(11);
vRetorno3               VARCHAR2(255);
vRetorno4               NUMBER(10);
hFecPagoDes1            VARCHAR(10);
/*************************************************************************
	INI MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/
sw_copagos              VARCHAR(1);
/*************************************************************************
	FIN MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/

hCodProductoGeneral     GE_DATOSGENER.PROD_GENERAL%TYPE;
-- Defincion de pseudo constantes para legibilidad del programa
COD_CAU_PAGO_REG           NUMBER (2)   :=  50 ;
-- DES_CAU_PAGO_REG          VARCHAR2(40) := 'REGULARIZACION DE PAGOS' ;
REG_PAGO_NO_APLICADO       NUMBER(2)    :=  65 ;
-- ORI_NO_APLI               VARCHAR2(40) := 'REGULARIZACION PAGO NO APLICADO' ;

REG_PAGO_DUPLICADO         NUMBER(2)    :=  66 ;
-- ORI_DUPLI                 VARCHAR2(40) := 'REGULARIZACION PAGO DUPLICADO' ;
REG_PAGO_MAL_APLICADO      NUMBER(2)    :=  67 ;
-- ORI_MAL_APLI              VARCHAR2(40) := 'REGULARIZACION PAGO MAL APLICADO' ;
REG_PAGO_MAYOR_VALOR       NUMBER(2)    :=  68 ;
-- ORI_MAYOR_VAL             VARCHAR2(40) := 'REGULARIZACION PAGO MAYOR VALOR' ;
-- tipos de documentos (ge_tipdocumen)
DOC_APLICA_PAGO_X_REG      NUMBER(2)    :=  83 ;
DES_APLICA_PAGO_X_REG      VARCHAR2(40) := 'PAGO POR REGULARIZACION' ;
--DOC_DESAPLICA_PAGO_X_REG   NUMBER(2)    :=  84 ;
--DES_DESAPLICA_PAGO_X_REG   VARCHAR2(40) := 'REVERSA PAGO POR REGULARIZACION' ;

CAJA_REGULARIZA            VARCHAR2(3)  := 'REG' ;
PAGO_POR_MONTO              NUMBER(1) := 0;
LNcero                      NUMBER(1) := 0; /*CAGV CO-200603290023 12-04-2006*/
---------------------------------------------------------------------------------------------
-- CURSOR : Todos los Documentos que el usuario seleccions para pagarlos.
---------------------------------------------------------------------------------------------
/*CURSOR DOCS_PAGADOS_USUARIO IS
SELECT NUM_SECUENCI,COD_TIPDOCUM,COD_VENDEDOR_AGENTE,COD_LETRA,COD_CENTREMI,
       COD_CONCEPTO,COLUMNA,NVL(NUM_CUOTA,0) AS NUM_CUOTA,NVL(SEC_CUOTA,0) AS SEC_CUOTA,IMPORTE_CONCEPTO
FROM   CO_PAGO_DOC_REGULARIZA
WHERE  NUM_REGULARIZA   = hNumRegularizacion
AND    COD_CLIENTE      = hCodClienteDes
AND    IMPORTE_CONCEPTO > 0; -- ojo validar esta condicion*/

CURSOR DOCS_PAGADOS_USUARIO IS
SELECT NUM_SECUENCI,COD_TIPDOCUM,COD_VENDEDOR_AGENTE,COD_LETRA,COD_CENTREMI,
       --Inicio RA-200512220384 03-02-2006
       NUM_CUOTA,SEC_CUOTA,SUM(IMPORTE_CONCEPTO) AS IMPORTE_CONCEPTO
       --Fin RA-200512220384 03-02-2006
FROM   CO_PAGO_DOC_REGULARIZA
WHERE  NUM_REGULARIZA   = hNumRegularizacion
AND    COD_CLIENTE      = hCodClienteDes
--Inicio RA-200512220384 03-02-2006
AND    IMPORTE_CONCEPTO > 0
GROUP BY NUM_SECUENCI,COD_TIPDOCUM,COD_VENDEDOR_AGENTE,COD_LETRA,COD_CENTREMI,
       NUM_CUOTA,SEC_CUOTA;
       --Fin RA-200512220384 03-02-2006

---------------------------------------------------------------------------------------------
-- SUBRUTINAS :
---------------------------------------------------------------------------------------------
PROCEDURE  PRC_ESTADO_REGULARIZACION ( status IN CHAR ) IS
BEGIN
    UPDATE CO_HIST_REGULARIZA SET
           STS_REGULARIZA = status
    WHERE  NUM_REGULARIZA = hNumRegularizacion;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR (-20101,'Imposible cambiar estado de regularizacion n0' || hNumRegularizacion);
END PRC_ESTADO_REGULARIZACION;

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
-- PROGRAMA PRINCIPAL
---------------------------------------------------------------------------------------------
BEGIN
    -- Verificacisn de parametros
    IF ( hNumRegularizacion  IS NULL OR hModoAplicacionPago IS NULL
        OR ( hModoAplicacionPago <> 0 AND hModoAplicacionPago <> 1 ) ) THEN
        RAISE_APPLICATION_ERROR(-20101, 'Error en el nzmero de regularizacisn o en el Modo de aplicacion del pago');
    END IF;

    SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal')
    INTO   iDecimal
    FROM   DUAL;


    -- Recupera datos de la regularizacion actual
    SELECT TIPO_REGULARIZA,     FEC_REGULARIZA   , STS_REGULARIZA, MONTO_REGULARIZA, NUM_DOC_RESPALDO,
           COD_CLIENTE_DESTINO, FEC_PAGO_DESTINO ,IMPORTE_PAGO_DESTINO, COD_OPERADORA_SCL_DEST, COD_PLAZA_DEST
           --MARCA -- Operadora_destino, Plaza_destino
    INTO   hTipoRegulariza , hFecRegulariza, hStsRegulariza , hMontoRegulariza , hNumDocRespaldo,
           hCodClienteDes  , hFecPagoDes   , hImportePagoDes, hOperadoraDestino, hPlazaDestino
    FROM   CO_HIST_REGULARIZA
    WHERE  NUM_REGULARIZA = hNumRegularizacion;

    hFecPagoDes1:= TO_CHAR(hFecPagoDes,'DD-MM-YYYY');

    -- Validacion de valores no nulables.
    IF (hCodClienteDes IS NULL OR hFecPagoDes1 IS NULL OR hImportePagoDes IS NULL OR
       hTipoRegulariza IS NULL OR hFecRegulariza IS NULL OR hStsRegulariza IS NULL OR
       hMontoRegulariza IS NULL OR hNumDocRespaldo IS NULL OR
	   hOperadoraDestino IS NULL OR hPlazaDestino IS NULL)
       --MARCA -- Operador_destino IS NULL OR Plaza_destino IS NULL
       THEN
       hDescError := 'Alguno de los parametros requeridos para aplicar el pago es nulo.';
       RAISE ERROR_PROCESO ;
    END IF;

    IF ( hTipoRegulariza = REG_PAGO_NO_APLICADO ) THEN
        IF (hStsRegulariza = 'I' ) THEN
            PRC_ESTADO_REGULARIZACION('P'); /* en proceso */
        ELSE
            hDescError := 'Regularizacisn no esta en estado Inicial, lista para aplicarse';
            RAISE ERROR_PROCESO ;
        END IF;
    ELSIF ( hTipoRegulariza = REG_PAGO_DUPLICADO ) THEN
        hDescError := 'Error : Regularizacion por Pago Duplicado no requiere volverlo a aplicar';
        RAISE ERROR_PROCESO ;
    ELSIF ((hTipoRegulariza = REG_PAGO_MAYOR_VALOR) OR (hTipoRegulariza = REG_PAGO_MAL_APLICADO)) THEN
        IF (hStsRegulariza = 'D' ) THEN
            PRC_ESTADO_REGULARIZACION('P'); /* en proceso */
        ELSE
            hDescError := 'Regularizacisn no esta en estado Desaplicada, lista para volver a aplicarse';
            RAISE ERROR_PROCESO ;
        END IF;
    ELSE
        hDescError := 'TIPO DE REGULARIZACION DESCONOCIDA ';
        RAISE ERROR_PROCESO ;
    END IF;

    ---------------------------------------------------------------------------------------------
    -- aplicacion del pago segun pl solange y segun modo de aplicacion definido
    ---------------------------------------------------------------------------------------------

    -- obtiene valores que necesitara para insertar el pago
    SELECT LETRA_COBROS , AGENTE_INTERNO
    INTO   hLetraDes , hCodVendedorAgenteDes
    FROM   CO_DATGEN;

    SELECT PROD_GENERAL
    INTO   hCodProductoGeneral
    FROM   GE_DATOSGENER;

    SELECT CO_SEQ_PAGO.NEXTVAL, '1',0, 5  /* Pago ficiticio por regularizacion Nota: ingresar en GE_SISPAGO */
    INTO   hNumSecuenciDes, hCodCentremiDes  , hCodForPagoDes, hCodSisPagoDes
    FROM   DUAL;

    -- actualizar la informacion del pago destino en co_hist_regulariza, para consolidar la informacion
    UPDATE CO_HIST_REGULARIZA  SET
          COD_TIPDOCUM_DESTINO = DOC_APLICA_PAGO_X_REG,
          NUM_SECUENCI_DESTINO = hNumSecuenciDes,
          COD_VENDEDOR_AGENTE_DESTINO = hCodVendedorAgenteDes,
          COD_LETRA_DESTINO = hLetraDes,
          COD_CENTREMI_DESTINO = hCodCentremiDes
    WHERE  NUM_REGULARIZA = hNumRegularizacion;

    -- verifica si el pago es por monto (generacion de abono) o por documentos (especifica uno a uno)

    IF (hModoAplicacionPago = PAGO_POR_MONTO) THEN
        BEGIN
      -- Se crea como abono y no se hace nada mas. La cancelacisn de criditos se encargara de 'matar' el abono despues.
      	/*************************************************************************
			INI MODIFICACION THALES-IS UC AGOSTO 2004
		*************************************************************************/
        Co_Aplicapago_Universal('REB'  ,
                            hCodClienteDes,
                            hImportePagoDes,
                            hFecPagoDes1,
                            NULL,
                            hTipoRegulariza,
                            COD_CAU_PAGO_REG,
                            NULL ,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            hNumDocRespaldo,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            hNumRegularizacion,
                            NULL,
                            hNumFolio,
                            '0',
                            NULL,
                            '0' ,
                            NULL,
                            hNumSecuenciDes,
                            DOC_APLICA_PAGO_X_REG,
                            NULL,
                            NULL,
                            NULL,
                            hImportePagoDes,
                            vRetorno1,
                            vRetorno2,
                            vRetorno3,
                            vRetorno4);
			IF (vRetorno4!=0) THEN
				BEGIN
					RAISE ERROR_PROCESO;
				END;
            		END IF;
                END;
	/*************************************************************************
			FIN MODIFICACION THALES-IS UC AGOSTO 2004
		*************************************************************************/
             -- Abono por el total del pago

    ELSE -- (hModoAplicacionPago = PAGO_POR_DOCUMENTO)
        sw_copagos:='0';
        hImporteRestante := hImportePagoDes; -- lo setea con el Total del Pago
        FOR DOC IN DOCS_PAGADOS_USUARIO LOOP
         -- verificar en todo momento si el monto total del pago, menos el importe a aplicar sobre cada documento
         -- alcanza para pagarlo
            IF ( hImporteRestante >= DOC.IMPORTE_CONCEPTO ) THEN  -- Si lo que queda alcanza para pagar, procede al pago
            -- Pagar documento en Co_cartera
                IF (DOC.SEC_CUOTA > 0) THEN
                    --Inicio RA-200512220384 03-02-2006
                    SELECT SUM(IMPORTE_DEBE-IMPORTE_HABER) AS SALDO_IMPAGO,
                    NUM_FOLIO,PREF_PLAZA,
					--Fin RA-200512220384 03-02-2006
					NUM_FOLIOCTC,NUM_VENTA,
                    FEC_VENCIMIE, FEC_EFECTIVIDAD
					--Inicio RA-200512220384 03-02-2006
                    INTO   hSaldoImpago, --hCodProducto, hNumAbonado,
					--Fin RA-200512220384 03-02-2006
                    hNumFolio, hPref_Plaza, hNumFolioCtc, hNumVenta,
                    hFecVencimie, hFecEfectividad
                    FROM  CO_CARTERA
                    WHERE COD_CLIENTE  = hCodClienteDes
                    AND   COD_TIPDOCUM = DOC.COD_TIPDOCUM
                    AND   NUM_SECUENCI = DOC.NUM_SECUENCI
                    AND   COD_VENDEDOR_AGENTE = DOC.COD_VENDEDOR_AGENTE
                    AND   LETRA        = DOC.COD_LETRA
                    AND   COD_CENTREMI = DOC.COD_CENTREMI
                    --Inicio RA-200512220384 03-02-2006
                    --AND   COD_CONCEPTO = DOC.COD_CONCEPTO
                    --AND   COLUMNA      = DOC.COLUMNA
                    AND   SEC_CUOTA    = DOC.SEC_CUOTA
					GROUP BY NUM_FOLIO,PREF_PLAZA,
					NUM_FOLIOCTC,NUM_VENTA,
					FEC_VENCIMIE, FEC_EFECTIVIDAD ;
                    --Fin RA-200512220384 03-02-2006
                ELSE
                    --Inicio RA-200512220384 03-02-2006
                    SELECT SUM(IMPORTE_DEBE-IMPORTE_HABER) AS SALDO_IMPAGO,
                          NUM_FOLIO, PREF_PLAZA,
						  --Fin RA-200512220384 03-02-2006
                    	  NUM_FOLIOCTC,NUM_VENTA,
                          FEC_VENCIMIE, FEC_EFECTIVIDAD
						  --Inicio RA-200512220384 03-02-2006
                    INTO   hSaldoImpago, --hCodProducto, hNumAbonado,
						  --Fin RA-200512220384 03-02-2006
                          hNumFolio, hPref_Plaza, hNumFolioCtc, hNumVenta,
                          hFecVencimie, hFecEfectividad
                    FROM   CO_CARTERA
                    WHERE  COD_CLIENTE  = hCodClienteDes
                    AND    COD_TIPDOCUM = DOC.COD_TIPDOCUM
                    AND    NUM_SECUENCI = DOC.NUM_SECUENCI
                    AND    COD_VENDEDOR_AGENTE = DOC.COD_VENDEDOR_AGENTE
                    AND    LETRA        = DOC.COD_LETRA
                    AND    COD_CENTREMI = DOC.COD_CENTREMI
                    AND    (SEC_CUOTA   = LNcero OR SEC_CUOTA IS NULL) /*CAGV CO-200603290023 12-04-2006*/
                    --Inicio RA-200512220384 03-02-2006
                    --AND    COD_CONCEPTO = DOC.COD_CONCEPTO
                    --AND    COLUMNA      = DOC.COLUMNA
					GROUP BY NUM_FOLIO,PREF_PLAZA,
					NUM_FOLIOCTC,NUM_VENTA,
					FEC_VENCIMIE, FEC_EFECTIVIDAD ;
					--Fin RA-200512220384 03-02-2006
                END IF;
            -- ------------------------------------------------------------------------------------------
                IF ( (hSaldoImpago - DOC.IMPORTE_CONCEPTO) > 0) THEN -- se paga parte y queda deuda,
   	/*************************************************************************
		INI MODIFICACION THALES-IS UC AGOSTO 2004
    *************************************************************************/
                    BEGIN
                        Co_Aplicapago_Universal('RED'  ,
                                        hCodClienteDes,
                                        hImportePagoDes,
                                        hFecPagoDes1,
                                        NULL,
                                        hTipoRegulariza,
                                        COD_CAU_PAGO_REG,
                                        NULL,
                                        NULL,
                                        NULL,
                                        NULL,
                                        NULL,
                                        hNumDocRespaldo,
                                        NULL,
                                        NULL,
                                        NULL,
                                        NULL,
                                        NULL,
                                        DOC.num_secuenci,
                                        hNumRegularizacion,
                                        NULL,
                                        hNumFolio,
                                        '1',
                                        NULL,
                                        sw_copagos ,
                                        'Parcial',
                                        hNumSecuenciDes,
                                        DOC.cod_tipdocum,
                                        DOC.cod_vendedor_agente,
                                        DOC.cod_letra,
                                        DOC.sec_cuota,
                                        DOC.IMPORTE_CONCEPTO,
                                        vRetorno1,
                                        hPref_Plaza,
                                        vRetorno3,
                                        vRetorno4);
                                        sw_copagos:='1';

                                IF (vRetorno4!=0) THEN
					BEGIN
                				RAISE ERROR_PROCESO;
					END;
            			END IF;
                            END;
	/*************************************************************************
			FIN MODIFICACION THALES-IS UC AGOSTO 2004
	************************************************************************/
                        hFecCancelacionDoc := NULL;

                    ELSIF ( (hSaldoImpago - DOC.IMPORTE_CONCEPTO) = 0) THEN -- se paga el total
	/*************************************************************************
			INI MODIFICACION THALES-IS UC AGOSTO 2004
		*************************************************************************/
                        BEGIN
                             Co_Aplicapago_Universal('RED',
                                                        hCodClienteDes,
                                                        hImportePagoDes,
                                                        hFecPagoDes1,
                                                        NULL,
                                                        hTipoRegulariza,
                                                        COD_CAU_PAGO_REG,
                                                        NULL,
                                                        NULL,
                                                        NULL,
                                                        NULL,
                                                        NULL,
                                                        hNumDocRespaldo,
                                                        NULL,
                                                        NULL,
                                                        NULL,
                                                        NULL,
                                                        NULL,
                                                        DOC.num_secuenci,
                                                        hNumRegularizacion,
                                                        NULL,
                                                        hNumFolio,
                                                        '1',
                                                        NULL,
                                                        sw_copagos ,
                                                        'Total',
                                                        hNumSecuenciDes,
                                                        DOC.cod_tipdocum,
                                                        DOC.cod_vendedor_agente,
                                                        DOC.cod_letra,
                                                        DOC.sec_cuota,
                                                        DOC.IMPORTE_CONCEPTO,
                                                        vRetorno1,
                                                        hPref_Plaza,
                                                        vRetorno3,
                                                        vRetorno4);
                                                        sw_copagos:='1';
                                IF (vRetorno4!=0) THEN
					BEGIN
                				RAISE ERROR_PROCESO;
					END;
            			END IF;
	/*************************************************************************
			FIN MODIFICACION THALES-IS UC AGOSTO 2004
		*************************************************************************/                            END;

                            SELECT SYSDATE
                            INTO hFecCancelacionDoc
                            FROM DUAL;

                        ELSIF ( (hSaldoImpago - DOC.IMPORTE_CONCEPTO) < 0 ) THEN -- paga mas de lo que debe, error

                            EXIT;

                        END IF;

                        -- Insertar la relacion con el documento pagado en co_pagosconc

                        hImporteRestante := hImporteRestante - DOC.IMPORTE_CONCEPTO ;-- Rebaja el monto para la siguiente iteracion


                    ELSE
                     -- No alcanza el dinero para pagar mas documentos, se sale del ciclo
                        EXIT;

                    END IF;

        END LOOP;

      -- si al final del pago por documentos hay saldo disponible del pago se genera un abono. por el monto de la diferencia
      IF ( hImporteRestante > 0 ) THEN
	/*************************************************************************
			INI MODIFICACION THALES-IS UC AGOSTO 2004
		*************************************************************************/
        BEGIN
          Co_Aplicapago_Universal('REA'  ,
                            hCodClienteDes,
                            hImporteRestante,
                            hFecPagoDes1,
                            NULL,
                            hTipoRegulariza,
                            COD_CAU_PAGO_REG,
                            NULL ,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            hNumDocRespaldo,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            hNumRegularizacion,
                            NULL,
                            hNumFolio,
                            '0',
                            NULL,
                            '1' ,
                            NULL,
                            hNumSecuenciDes,
                            DOC_APLICA_PAGO_X_REG,
                            NULL,
                            NULL,
                            NULL,
                            hImporteRestante,
                            vRetorno1,
                            vRetorno2,
                            vRetorno3,
                            vRetorno4);
            IF (vRetorno4!=0) THEN
		BEGIN
                	RAISE ERROR_PROCESO;
		END;
            END IF;
        END;
	/*************************************************************************
			FIN MODIFICACION THALES-IS UC AGOSTO 2004
		*************************************************************************/
             -- Abono por el total del pago

      END IF;

      --  borra los documentos que se pagan de forma especifica.
      DELETE CO_PAGO_DOC_REGULARIZA
      WHERE  NUM_REGULARIZA = hNumRegularizacion
      AND    COD_CLIENTE = hCodClienteDes;

      COMMIT;

    END IF;

    PRC_ESTADO_REGULARIZACION('O'); /* proceso termino OK, se ha Desaplicado */

EXCEPTION

   WHEN ERROR_PROCESO THEN
      ROLLBACK;
      PRC_ESTADO_REGULARIZACION('E'); /* proceso termino con error */
      RAISE_APPLICATION_ERROR(-20103, hDescError);

   WHEN OTHERS THEN
      ROLLBACK;
      PRC_ESTADO_REGULARIZACION('E'); /* proceso termino con error */
      RAISE_APPLICATION_ERROR(-20104,'Error inesperado, Codigo:'||SQLCODE||'  Descripcion:'||SQLERRM);

END Prc_Aplica_Pago_Reg;
/
SHOW ERRORS
