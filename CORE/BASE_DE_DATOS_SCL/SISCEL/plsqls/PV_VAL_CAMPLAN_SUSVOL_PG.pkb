CREATE OR REPLACE PACKAGE BODY pv_val_camplan_susvol_pg
AS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_cambioplan_pend_fn (
      seo_dat_abo       IN OUT NOCOPY   pv_abo_sus_vol_qt,
	  sv_num_ooss       OUT NOCOPY      pv_iorserv.num_os%TYPE,
	  sv_estado         OUT NOCOPY      pv_iorserv.cod_estado%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

	  ssql := 'SELECT num_os, cod_estado'
           || ' FROM pv_iorserv'
           || ' WHERE cod_os IN (10020, 10022, 10029, 10233, 10530, 10539)'
           || ' AND num_osf_err <> 1'
           || ' AND TRUNC (fh_ejecucion) >= TRUNC ('||SYSDATE||')'
           || ' AND num_os IN (SELECT num_os'
           || ' FROM pv_camcom'
           || ' WHERE cod_cliente = '||seo_dat_abo.cod_cliente
           || ' AND num_abonado = '||seo_dat_abo.num_abonado
           || ' AND TRUNC (fec_vencimiento) >= TRUNC ('||SYSDATE||'))';

      SELECT num_os, cod_estado
        INTO sv_num_ooss, sv_estado
        FROM pv_iorserv
       WHERE cod_os IN (10020, 10022, 10029, 10233, 10530, 10539)
         AND num_osf_err <> 1
         AND TRUNC (fh_ejecucion) >= TRUNC (SYSDATE)
         AND num_os IN (SELECT num_os
                          FROM pv_camcom
                         WHERE cod_cliente = seo_dat_abo.cod_cliente
						   AND num_abonado = seo_dat_abo.num_abonado
						   AND TRUNC (fec_vencimiento) >= TRUNC (SYSDATE));
      RETURN TRUE;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RETURN TRUE;
      WHEN OTHERS THEN
         sn_cod_retorno  := '10101';
         sv_mens_retorno := 'Error: no determinado al recuperar OOSS pendientes';
         v_des_error     := 'pv_suspvolprog_pg.pv_upd_fh_eje_iorserv_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_upd_fh_eje_iorserv_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_rec_cambioplan_pend_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION pv_rec_fincilco_plantarif_fn (
      seo_dat_abo       IN OUT NOCOPY   pv_abo_sus_vol_qt,
	  sv_plantarif      OUT NOCOPY      ga_finciclo.cod_plantarif%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

	  ssql := 'SELECT cod_plantarif'
           || ' FROM ga_finciclo'
           || ' WHERE cod_cliente = '||seo_dat_abo.cod_cliente
	       || ' AND num_abonado = '||seo_dat_abo.num_abonado
		   || ' AND cod_plantarif <> '||seo_dat_abo.cod_plantarif;

      SELECT cod_plantarif
        INTO sv_plantarif
        FROM ga_finciclo
       WHERE cod_cliente = seo_dat_abo.cod_cliente
	     AND num_abonado = seo_dat_abo.num_abonado
		 AND cod_plantarif <> seo_dat_abo.cod_plantarif;

      RETURN TRUE;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RETURN TRUE;
      WHEN OTHERS THEN
         sn_cod_retorno  := '10102';
         sv_mens_retorno := 'Error: no determinado al recuperar datos de cambio de plan pendiente';
         v_des_error     := 'pv_suspvolprog_pg.pv_upd_fh_eje_iorserv_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_upd_fh_eje_iorserv_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_rec_fincilco_plantarif_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_param_abo_plannuevo_fn (
      seo_dat_abo       IN OUT NOCOPY   pv_abo_sus_vol_qt,
	  ev_num_ooss       IN OUT NOCOPY   pv_param_abocel.NUM_OS%TYPE,
	  sv_plantarif      OUT NOCOPY      ga_finciclo.cod_plantarif%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
	  sv_plan_nuevo VARCHAR2(100);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

	  ssql := 'SELECT cod_plantarif_nue'
           || ' FROM pv_param_abocel'
           || ' WHERE num_os = '||ev_num_ooss
	       || ' AND cod_tipmodi IN (''SS'', ''BA'')'
		   || ' AND cod_plantarif IS NOT NULL'
		   || ' AND cod_plantarif_nue <> '||seo_dat_abo.cod_plantarif;

      SELECT cod_plantarif_nue
        INTO sv_plan_nuevo
        FROM pv_param_abocel
       WHERE num_os = ev_num_ooss
	     AND cod_tipmodi IN ('SS', 'BA')
		 AND cod_plantarif IS NOT NULL
		 AND cod_plantarif_nue <> seo_dat_abo.cod_plantarif;

      RETURN TRUE;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := '10103';
         sv_mens_retorno := 'Error: no existen datos en param_abocel OOSS';
         v_des_error     := 'pv_suspvolprog_pg.pv_upd_fh_eje_iorserv_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_upd_fh_eje_iorserv_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno  := '10104';
         sv_mens_retorno := 'Error: no determinado al recuperar param abocel OOSS';
         v_des_error     := 'pv_suspvolprog_pg.pv_upd_fh_eje_iorserv_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_upd_fh_eje_iorserv_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_rec_param_abo_plannuevo_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE PV_VAL_CAMPLAN_A_CICLO_PR(
      seo_dat_abo       IN OUT NOCOPY   pv_abo_sus_vol_qt,
	  SN_cod_retorno    OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno   OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento     OUT NOCOPY		ge_errores_pg.evento
   )
   IS
      v_des_error          ge_errores_pg.desevent;
      ssql                 ge_errores_pg.vquery;
      v_num_ooss           pv_iorserv.num_os%TYPE;
	  v_estado             pv_iorserv.cod_estado%TYPE;
	  v_plantarif          ta_plantarif.cod_plantarif%TYPE;
	  error_ejecucion      EXCEPTION;
	  error_cam_plan_pedn  EXCEPTION;
   BEGIN
      IF NOT (pv_rec_cambioplan_pend_fn(seo_dat_abo,v_num_ooss,v_estado,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
	     RAISE error_ejecucion;
	  END IF;

      IF v_num_ooss IS NULL OR v_num_ooss=0 THEN
         IF NOT (pv_rec_fincilco_plantarif_fn (seo_dat_abo,v_plantarif,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
	        RAISE error_ejecucion;
	     END IF;

         IF v_plantarif IS NOT NULL THEN
            RAISE error_cam_plan_pedn;
         END IF;

      ELSE
         IF v_estado < 210 THEN

		    IF NOT (pv_rec_param_abo_plannuevo_fn (seo_dat_abo,v_num_ooss,v_plantarif,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
	           RAISE error_ejecucion;
			ELSE
               RAISE error_cam_plan_pedn;
			END IF;
         END IF;
      END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
         v_des_error     := 'pv_val_camplan_susvol_pg.pv_val_camplan_a_ciclo_pr()(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_val_camplan_susvol_pg.pv_val_camplan_a_ciclo_pr()', ssql, SQLCODE, v_des_error);
      WHEN error_cam_plan_pedn THEN
         sn_cod_retorno  := '10105';
         sv_mens_retorno := 'Error: existen ooss pendientes de cambio de plan OOSS';
         v_des_error     := 'pv_val_camplan_susvol_pg.pv_val_camplan_a_ciclo_pr()(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_val_camplan_susvol_pg.pv_val_camplan_a_ciclo_pr()', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno  := '10106';
         sv_mens_retorno := 'Error: no determinado al validar cambio de plan pendiente OOSS';
         v_des_error     := 'pv_val_camplan_susvol_pg.pv_val_camplan_a_ciclo_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_val_camplan_susvol_pg.pv_val_camplan_a_ciclo_pr()', ssql, SQLCODE, v_des_error);
   END pv_val_camplan_a_ciclo_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END pv_val_camplan_susvol_pg;
/
SHOW ERRORS
