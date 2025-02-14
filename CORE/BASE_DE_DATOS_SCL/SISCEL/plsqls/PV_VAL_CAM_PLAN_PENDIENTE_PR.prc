CREATE OR REPLACE PROCEDURE PV_VAL_CAM_PLAN_PENDIENTE_PR(
      v_param_entrada IN  VARCHAR2,
      bRESULTADO      OUT VARCHAR2,
      vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
   )
   IS
      string                  GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
      nABONADO                GA_ABOCEL.NUM_ABONADO%TYPE;
      o_dat_abo               PV_ABO_SUS_VOL_QT := NEW PV_ABO_SUS_VOL_QT;
	  SN_cod_retorno          NUMBER;
	  SV_mens_retorno         VARCHAR2(200);
	  SN_num_evento           NUMBER;
	  error_ejecucion         EXCEPTION;
      error_cam_paln          EXCEPTION;
   BEGIN

      GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
      nABONADO         := -1;
      nABONADO         := TO_NUMBER(string(5));
      bRESULTADO  := 'TRUE';
	  o_dat_abo.num_abonado := nABONADO;

      IF NOT (pv_suspvolprog_pg.pv_rec_info_abonado_fn(o_dat_abo,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
	     RAISE error_ejecucion;
	  END IF;

      pv_val_camplan_susvol_pg.pv_val_camplan_a_ciclo_pr(o_dat_abo,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
	  IF SN_cod_retorno = 10105 THEN
	     RAISE error_cam_paln;
	  ELSIF SN_cod_retorno <> 0 THEN
	     RAISE error_ejecucion;
	  END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ERROR: NO SE PUEDE VALIDAR CAMBIOS DE PLAN PENDIENTES, VERIFICAR EVENTO: ['||SN_num_evento ||'].';
      WHEN error_cam_paln THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ERROR: EXISTEN CAMBIOS DE PLAN PENDIENTES.';
      WHEN OTHERS THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ERROR: NO SE PUEDE VALIDAR CAMBIOS DE PLAN PENDIENTES.';
END;
/
SHOW ERRORS
