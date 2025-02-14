CREATE OR REPLACE PROCEDURE CE_APLICA_PAGO_QUIOSCO_PR (
/************************************************************************************************************
   NOMBRE:       CE_APLICA_PAGO_QUIOSCO_PR
   PROPOSITO:    Inserta registro en tabla CO_INTERFAZ_PAGOS

   REVISION:
   Ver       Proyecto    Fecha       Autor                    Acción
   --------  ----------  ----------  ----------------------   ---------------------------
   1.0       *********   **********  **********************   Creación de Procedure

   1.1       TMM_03048   30-01-2004  Arq.Sol: Marco Moreno    Se habilitan funciones de validación
                                     Dis.Tec: Stuver Cañete   CE_IsRevEmpresa_FN, CE_IsRevCaja_FN,
			             Program: Julio Bustos    CE_IsRevOperador_FN, CE_IsRevCliente_FN,
                                                              CE_IsRevBcoDocum_FN, CE_IsRevFechaEfectiva_FN
   1.2		 Req.		29-09-2006	 J.P: Juan Tapia
   			 Soporte 				 A.P: Carlos Perez		  Realizar pagos de garantia via recaudacion en lina.
   			 34406
   1.3		 Req.		03-11-2006	 J.P: Juan Tapia
   			 Soporte 				 A.P: Carlos Perez		  Realizar pagos a Folio especifico via recaudacion en lina.
   			 34846   			 
************************************************************************************************************/
    pRevempresa       IN  VARCHAR2
   ,pRevCaja          IN  VARCHAR2
   ,pRevCodSer        IN  VARCHAR2
   ,pRevFechaEfectiva IN  VARCHAR2
   ,pRevNum_Oper      IN  VARCHAR2
   ,pRevOperador      IN  VARCHAR2
   ,pRevTipo          IN  VARCHAR2
   ,pRevSubTipo       IN  VARCHAR2
   ,pRevCod_Servicio  IN  VARCHAR2
   ,pRevCi_Fecontab   IN  VARCHAR2
   ,pRevCliente       IN  VARCHAR2
   ,pRevCelular       IN  VARCHAR2
   ,pRevMonto         IN  VARCHAR2
   ,pRevFolio         IN  VARCHAR2
   ,pRevRut           IN  VARCHAR2
   ,pRevModPago       IN  VARCHAR2
   ,pRevNumDocum      IN  VARCHAR2
   ,pRevBcoDocum      IN  VARCHAR2
   ,pRevCtaCte        IN  VARCHAR2
   ,pRevCodAuto       IN  VARCHAR2
   ,pNumTarjeta       IN  VARCHAR2
   ,pResul            OUT VARCHAR2
   ,pDescripcion      OUT VARCHAR2
   ,pCodOperacion	  IN  VARCHAR2 default '1'
   ,pNumventa		  IN  NUMBER   default null
   ,pNumFolio		  IN  NUMBER   default null
   ,pCodPlanSrv	  IN  VARCHAR2 default null
   ,pNumTranEmp       IN  VARCHAR2 -- CSR-11002
   ,pDesAgencia       IN  VARCHAR2 -- CSR-11002
   ,pCodTipTarjeta    IN  VARCHAR2 -- CSR-11002
)

IS
    vcErrFrom         VARCHAR2(200);
    vcErrCode         VARCHAR2(200);
    vcErrMens         VARCHAR2(32767);
    tmpDescri         VARCHAR2(32767);
    vExceptio         EXCEPTION;
    LV_nomtabla       GED_CODIGOS.NOM_TABLA%TYPE := 'CO_INTERFAZ_PAGOS'; --MA-70067
    LV_nomcolumna     GED_CODIGOS.NOM_COLUMNA%TYPE := 'TIP_VALOR'; --MA-70067
    LN_contador NUMBER := 0; --MA-70067 Si valor es 0 se valida el banco, en caso contrario no se valida.
    
BEGIN 

    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevEmpresa_FN       ( pRevempresa,       vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;
    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevCaja_FN          ( pRevCaja,          vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;
    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevOperador_FN      ( pRevOperador,      vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;
    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevCliente_FN       ( pRevCliente,       vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;

    --MA-70067 Valida si el tipo de  valor está entre los que no requieren el código del Banco
    SELECT COUNT(1) 
    INTO LN_contador
    FROM ged_codigos a
    WHERE a.nom_tabla = 'CO_INTERFAZ_PAGOS'
    AND a.nom_columna = 'TIP_VALOR'
    AND a.cod_valor =  pRevModPago;
    
    --if trim(pRevModPago) != '1' then
    IF LN_contador = 0 THEN
    --Fin MA-70067
		IF NOT CE_VALIDA_PAGO_PG.CE_IsRevBcoDocum_FN      ( pRevBcoDocum,      vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;
	end if;
    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevFechaEfectiva_FN ( pRevFechaEfectiva, vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;

    vcErrFrom := 'CE_APLICA_PAGO_QUIOSCO_PR';
    pResul:='0';
    pDescripcion:='Ejecución Exitosa';


    INSERT INTO CO_INTERFAZ_PAGOS (
        EMP_RECAUDADORA
       ,COD_CAJA_RECAUDA
       ,SER_SOLICITADO
       ,FEC_EFECTIVIDAD
       ,NUM_TRANSACCION
       ,NOM_USUARORA
       ,TIP_TRANSACCION
       ,SUB_TIP_TRANSAC
       ,COD_SERVICIO
       ,NUM_EJERCICIO
       ,COD_CLIENTE
       ,NUM_CELULAR
       ,IMP_PAGO
       ,NUM_FOLIOCTC
       ,NUM_IDENT
       ,TIP_VALOR
       ,NUM_DOCUMENTO
       ,COD_BANCO
       ,CTA_CORRIENTE
       ,COD_AUTORIZA
       ,NUM_TARJETA
       ,COD_OPERACION	-- Requerimiento de Soporte - #34406 capc 28-09-2006
       ,NUM_VENTA 		-- Requerimiento de Soporte - #34406 capc 28-09-2006
       ,NUM_FOLIO 		-- Requerimiento de Soporte - #34846 capc 03-11-2006
       ,COD_PLANSRV      -- MA 41252 - Soporte RyC CPalma 26-06-2007
	   ,NUM_TRANSACCION_EMP -- CSR-11002
       ,DES_AGENCIA         -- CSR-11002
       ,COD_TIPTARJETA      -- CSR-11002
    )
    VALUES (
        pRevempresa
       ,pRevCaja
       ,pRevCodSer
       ,TO_DATE(pRevFechaEfectiva,'YYYYMMDD HH24MISS')
       ,pRevNum_Oper
       ,pRevOperador
       ,pRevTipo
       ,pRevSubTipo
       ,pRevCod_Servicio
       ,pRevCi_Fecontab
       ,pRevCliente
       ,pRevCelular
       ,pRevMonto
       ,pRevFolio
       ,pRevRut
       ,pRevModPago
       ,pRevNumDocum
       ,pRevBcoDocum
       ,pRevCtaCte
       ,pRevCodAuto
       ,pNumTarjeta
       ,pCodOperacion	-- Requerimiento de Soporte - #34406 capc 28-09-2006
       ,pNumventa		-- Requerimiento de Soporte - #34406 capc 28-09-2006
       ,pNumFolio		-- Requerimiento de Soporte - #34846 capc 03-11-2006
       ,pCodPlanSrv      -- MA 41252 - Soporte RyC CPalma 26-06-2007
	   ,pNumTranEmp      -- CSR-11002
       ,pDesAgencia      -- CSR-11002
       ,pCodTipTarjeta   -- CSR-11002
    );

EXCEPTION
    WHEN vExceptio THEN
        pResul:= vcErrCode;
        tmpDescri:= 'ERROR EN TRANSACCIÓN: [' || pRevNum_Oper || '], DESCRIPCIÓN: ' || vcErrMens;
        pDescripcion:= SUBSTR(tmpDescri, 1, 255);
        RETURN;

    WHEN OTHERS THEN
        pResul:= TO_CHAR(SQLCODE);
   	tmpDescri:= 'ERROR EN TRANSACCIÓN: [' || pRevNum_Oper || '], DESCRIPCIÓN: ' || SUBSTR(SQLERRM, 1, 190);
        pDescripcion:= SUBSTR(tmpDescri, 1, 255);
        RETURN;

END CE_APLICA_PAGO_QUIOSCO_PR; 
/
SHOW ERROR

