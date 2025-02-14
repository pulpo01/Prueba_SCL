CREATE OR REPLACE PROCEDURE
   PV_VAL_SUS_CORBRANZA_CLIE_PR(
      EV_v_param_entrada IN  VARCHAR2,
      EV_bRESULTADO      OUT NOCOPY VARCHAR2,
      EV_vMENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
   )
   IS
      string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
      LN_nCLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
      LN_vCantidad         NUMBER(9);
   BEGIN
      GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_v_param_entrada, string);
      LN_nCLIENTE       := -1;
      LN_nCLIENTE       := TO_NUMBER(string(6));

      EV_bRESULTADO  := 'TRUE';
      EV_vMENSAJE    := 'OK';
      LN_vCantidad   := 0;

      SELECT COUNT (1)
        INTO LN_vCantidad
        FROM co_morosos a, co_acciones b
       WHERE a.cod_cliente = LN_nCLIENTE
         AND a.cod_cliente = b.cod_cliente
         AND b.cod_rutina IN ('SUSUN', 'SUSBI')
         AND b.cod_estado IN ('PND', 'EJE');

      IF (LN_vCantidad > 0) THEN
          EV_bRESULTADO := 'FALSE';
          EV_vMENSAJE      := 'Error: Cliente suspendido por cobranza';
	  END IF;

   END;
/
SHOW ERRORS
