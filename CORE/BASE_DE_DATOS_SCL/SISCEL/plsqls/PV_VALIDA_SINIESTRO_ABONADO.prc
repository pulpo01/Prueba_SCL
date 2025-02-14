CREATE OR REPLACE PROCEDURE PV_VALIDA_SINIESTRO_ABONADO(
      v_param_entrada IN  VARCHAR2,
      bRESULTADO      OUT VARCHAR2,
      vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
   )
   IS
      string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
      nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
      o_dat_abo         pv_datos_abo_qt := NEW pv_datos_abo_qt;
	  n_cant_siniestro_serie  NUMBER;
   	  n_cant_siniestro_imei   NUMBER;
	  SN_cod_retorno          NUMBER;
	  SV_mens_retorno         VARCHAR2(200);
	  SN_num_evento           NUMBER;
	  error_ejecucion         EXCEPTION;
   BEGIN

      GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
      nABONADO         := -1;
      nABONADO         := TO_NUMBER(string(5));
      bRESULTADO  := 'TRUE';
	  o_dat_abo.num_abonado := nABONADO;
      pv_cambio_serie_sb_pg.pv_rec_info_abonado_pr(o_dat_abo,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
	  IF SN_cod_retorno <> 0 THEN
	     RAISE error_ejecucion;
	  END IF;


	  IF (o_dat_abo.cod_tecnologia <> 'GSM') THEN

         SELECT COUNT(1)
		   INTO n_cant_siniestro_serie
		   FROM ga_siniestros
	      WHERE num_abonado = o_dat_abo.num_abonado
	        AND num_serie = o_dat_abo.num_serie;

         IF n_cant_siniestro_serie > 0 THEN
            bRESULTADO := 'FALSE';
            vMENSAJE   := 'EL ABONADO YA CUENTA CON SINIESTROS DEL EQUIPO y SIMCARD';
		 END IF;
      ELSE

         SELECT COUNT(1)
		   INTO n_cant_siniestro_serie
		   FROM ga_siniestros
	      WHERE num_abonado = o_dat_abo.num_abonado
	        AND num_serie = o_dat_abo.num_serie;


		 /*SELECT COUNT(1)
		   INTO n_cant_siniestro_imei
		   FROM ga_siniestros
	      WHERE num_abonado = o_dat_abo.num_abonado
	        AND num_serie = o_dat_abo.num_imei;*/  	-- RRG 79606 COL 25-02-2009


		 n_cant_siniestro_imei := 0; -- RRG 79606 COL 25-02-2009

         IF (n_cant_siniestro_serie > 0 AND n_cant_siniestro_imei > 0 )THEN
             bRESULTADO := 'FALSE';
             --vMENSAJE   := 'EL ABONADO YA CUENTA CON SINIESTROS DEL EQUIPO y SIMCARD';  -- RRG 79606 COL 25-02-2009
			 vMENSAJE   := 'EL ABONADO YA CUENTA CON SINIESTROS DE SIMCARD';   			  -- RRG 79606 COL 25-02-2009
		 END IF;
    END IF;


   EXCEPTION
      WHEN error_ejecucion THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ERROR EN PV_VALIDA_SINIESTRO_ABONADO: NO SE PUEDE RECUPERAR INFO. ABONADO.' || SQLERRM || '.';
      WHEN OTHERS THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ERROR EN PV_VALIDA_SINIESTRO_ABONADO: NO SE PUEDE VALIDAR SINIESTROS PENDIENTES.' || SQLERRM || '.';
END;
/
SHOW ERRORS
