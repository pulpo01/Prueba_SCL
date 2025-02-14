CREATE OR REPLACE PROCEDURE CE_APLICA_PAGO_PR (
/************************************************************************************************************
   NOMBRE:       CE_APLICA_PAGO_PR
   PROPOSITO:    Inserta registro en tabla CO_INTERFAZ_PAGOS

   REVISION:
   Ver       Proyecto    Fecha       Autor                    Accion
   --------  ----------  ----------  ----------------------   ---------------------------
   1.0       *********   **********  **********************   Creacion de Procedure

   1.1       TMM_03048   30-01-2004  Arq.Sol: Marco Moreno    Se habilitan funciones de validacion
                                     Dis.Tec: Stuver Ca?ete   CE_IsRevEmpresa_FN, CE_IsRevCaja_FN,
			             Program: Julio Bustos    CE_IsRevOperador_FN, CE_IsRevCliente_FN,
                                                              CE_IsRevBcoDocum_FN, CE_IsRevFechaEfectiva_FN
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
)

IS
    vcErrFrom         VARCHAR2(200);
    vcErrCode         VARCHAR2(200);
    vcErrMens         VARCHAR2(32767);
    tmpDescri         VARCHAR2(32767);
    vExceptio         EXCEPTION;

BEGIN

    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevEmpresa_FN       ( pRevempresa,       vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;
    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevCaja_FN          ( pRevCaja,          vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;
    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevOperador_FN      ( pRevOperador,      vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;
    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevCliente_FN       ( pRevCliente,       vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;
    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevBcoDocum_FN      ( pRevBcoDocum,      vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;
    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevFechaEfectiva_FN ( pRevFechaEfectiva, vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;

    vcErrFrom := 'CE_APLICA_PAGO_PR';
    pResul:='0';
    pDescripcion:='Ejecucion Exitosa';


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
    );

EXCEPTION
    WHEN vExceptio THEN
        pResul:= vcErrCode;
        tmpDescri:= 'ERROR EN TRANSACCION: [' || pRevNum_Oper || '], DESCRIPCION: ' || vcErrMens;
        pDescripcion:= SUBSTR(tmpDescri, 1, 255);
        RETURN;

    WHEN OTHERS THEN
        pResul:= TO_CHAR(SQLCODE);
   	tmpDescri:= 'ERROR EN TRANSACCION: [' || pRevNum_Oper || '], DESCRIPCION: ' || SUBSTR(SQLERRM, 1, 190);
        pDescripcion:= SUBSTR(tmpDescri, 1, 255);
        RETURN;

END CE_APLICA_PAGO_PR;
/
SHOW ERRORS
