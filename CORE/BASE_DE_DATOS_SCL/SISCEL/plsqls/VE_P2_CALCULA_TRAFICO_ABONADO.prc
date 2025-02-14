CREATE OR REPLACE PROCEDURE        VE_P2_CALCULA_TRAFICO_ABONADO
(
vp_cod_cliente                        IN                   GA_ABOCEL.COD_CLIENTE%TYPE,
vp_num_abonado                        IN                   GA_ABOCEL.NUM_ABONADO%TYPE,
vp_num_liquidacion            IN                   VE_CABLIQUIDAC.NUM_LIQUIDACION%TYPE,
vp_importe_trafico                OUT                   NUMBER
)
IS
--*** CONSTANTES ***
vp_0                                     NUMBER(1):= 0;
vp_1                                     NUMBER(1):= 1;
--*** VARIABLES PARA MENSAJE DE ERROR ***
vp_mensaje                           VARCHAR2(120):=' ';
vp_procedure                   VARCHAR2(30) := 'VE_P2_CALCULA_TRAFICO_ABONADO';
vp_tabla                           VARCHAR2(30):='VE_TMP_PAGOSCLIENTE';
vp_accion                           VARCHAR2(1) := 'S';
vp_sqlcode                           VARCHAR2(10);
vp_sqlerrm                           VARCHAR2(70);
--
BEGIN
-- TEST SACAR !!!
-- TEST
SELECT nvl(SUM(HC.IMP_FACTURABLE),0)
 INTO vp_importe_trafico
 FROM VE_FACCTO FAC, FA_HISTCONCCELU HC, FA_HISTDOCU HD, VE_TMP_PAGOSCLIENTE TMP
 WHERE FAC.COD_CTOFAC    = vp_1                 /* categorma de concepto facturable = "TRAFICO" */
   AND FAC.COD_CONCEPTO  = HC.COD_CONCEPTO
   AND HC.NUM_ABONADO    = vp_num_abonado
   AND HC.IND_ORDENTOTAL = HD.IND_ORDENTOTAL
   AND HD.IND_PASOCOBRO  = vp_1
   AND HD.IND_ANULADA         = vp_0
   AND HD.NUM_FOLIO
 <> vp_0
   AND HD.COD_TIPDOCUM   = TMP.COD_TIPDOCUM
   AND HD.NUM_SECUENCI   = TMP.NUM_SECUENCI
   AND TMP.COD_CLIENTE   = vp_cod_cliente;
-- TEST SACAR !!!
-- TEST
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
VE_P2_insanomliqtra(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END VE_P2_CALCULA_TRAFICO_ABONADO;
/
SHOW ERRORS
