CREATE OR REPLACE PROCEDURE CE_EJECUTA_PAGO_PR (
/************************************************************************************************************
   NOMBRE:       CE_EJECUTA_PAGO_PR
   PROPOSITO:    Ejecuta CE_APLICA_PAGO_PR

   REVISION:
   Ver       Proyecto     Fecha       Autor                    Accion
   --------  ----------  ----------  ----------------------   ---------------------------
   1.0       TMM_03048  09-02-2004  Arq.Sol: Marco Moreno    Creacion de Procedure
                                    Program: Julio Bustos
************************************************************************************************************/
    pRevEmpresa       IN  VARCHAR2
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
    tmpDescri         VARCHAR2(255);
BEGIN
    CE_APLICA_PAGO_PR ( pRevEmpresa, pRevCaja, pRevCodser, pRevFechaEfectiva, pRevNum_Oper, pRevOperador, pRevTipo, pRevSubTipo, pRevCod_Servicio, pRevci_Fecontab, pRevCliente, pRevCelular, pRevMonto, pRevFolio, pRevRut, pRevModPago, pRevNumDocum, pRevBcoDocum, pRevCtaCte, pRevCodauto, pNumTarjeta, pResul, pDescripcion );
    IF pResul='0' THEN COMMIT; END IF;
    RETURN;
EXCEPTION
    WHEN OTHERS THEN
        pResul:= TO_CHAR(SQLCODE);
	   	tmpDescri:= 'ERROR EN TRANSACCION: [' || pRevNum_Oper || '], DESCRIPCION: ' || SUBSTR(SQLERRM, 1, 190);
        pDescripcion:= SUBSTR(tmpDescri, 1, 255);
        RETURN;
END CE_EJECUTA_PAGO_PR;
/
SHOW ERRORS
