CREATE OR REPLACE PROCEDURE
   PV_VAL_SUS_VOLPROG_ABONADO_PR(
      EV_v_param_entrada IN  VARCHAR2,
      EV_bRESULTADO      OUT NOCOPY VARCHAR2,
      EV_vMENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
   )
   IS
      string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
      LN_ABONADO           GA_ABOCEL.NUM_ABONADO%TYPE;
      LN_vCantidad         NUMBER(8);
   BEGIN
      GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_v_param_entrada, string);
      LN_ABONADO        := -1;
      LN_ABONADO        := TO_NUMBER(string(5));

      EV_bRESULTADO  := 'TRUE';
      EV_vMENSAJE    := 'OK';
      LN_vCantidad   := 0;

      SELECT COUNT (1)
        INTO LN_vCantidad
        FROM PV_DET_SUSPVOLPROG_TO
       WHERE num_abonado = LN_ABONADO
         AND estado	IN ('PRG','SUS');

      IF (LN_vCantidad > 0) THEN
          EV_bRESULTADO    := 'FALSE';
          EV_vMENSAJE      := 'Error: ABONADO POSEE SUSPENSIONES VOLUNTARIAS / PROGRAMADAS';
	  END IF;

   END;
/
SHOW ERRORS
