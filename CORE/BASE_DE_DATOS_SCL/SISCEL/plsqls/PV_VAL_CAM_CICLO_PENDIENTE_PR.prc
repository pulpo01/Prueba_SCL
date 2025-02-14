CREATE OR REPLACE PROCEDURE PV_VAL_CAM_CICLO_PENDIENTE_PR(
      v_param_entrada IN  VARCHAR2,
      bRESULTADO      OUT VARCHAR2,
      vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
   )
   IS
      string                  GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
      nABONADO                GA_ABOCEL.NUM_ABONADO%TYPE;
      o_dat_abo               PV_ABO_SUS_VOL_QT := NEW PV_ABO_SUS_VOL_QT;
	  n_cod_ciclo             NUMBER;
	  SN_cod_retorno          NUMBER;
	  SV_mens_retorno         VARCHAR2(200);
	  SN_num_evento           NUMBER;
	  error_ciclo             EXCEPTION;
	  error_ejecucion         EXCEPTION;

   BEGIN

      GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
      nABONADO         := -1;
      nABONADO         := TO_NUMBER(string(5));
      bRESULTADO  := 'TRUE';
	  o_dat_abo.num_abonado := nABONADO;

      IF NOT (pv_suspvolprog_pg.pv_rec_info_abonado_fn(o_dat_abo,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
	     RAISE error_ejecucion;
	  END IF;

       SELECT cod_ciclo
         INTO n_cod_ciclo
         FROM ga_finciclo
        WHERE cod_cliente = o_dat_abo.cod_cliente
     	  AND num_abonado = o_dat_abo.num_abonado;

	   IF n_cod_ciclo <> NULL THEN
	      RAISE error_ciclo;
	   END IF;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         bRESULTADO  := 'TRUE';
         vMENSAJE    := '';
      WHEN error_ejecucion THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ERROR: NO SE PUEDE VALIDAR CAMBIOS DE PLAN PENDIENTES, VERIFICAR EVENTO: ['||SN_num_evento ||'].';
      WHEN error_ciclo THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ERROR: ABONADO CON CAMBIO DE CICLO PENDIENTE.';
      WHEN OTHERS THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ERROR: NO ES POSIBLE VALIDAR CAMBIOS DE PLAN PENDIENTES.';
END;
/
SHOW ERRORS
