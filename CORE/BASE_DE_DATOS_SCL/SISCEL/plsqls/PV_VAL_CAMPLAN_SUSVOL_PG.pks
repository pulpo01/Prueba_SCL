CREATE OR REPLACE PACKAGE pv_val_camplan_susvol_pg
IS
-------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_val_camplan_a_ciclo_pr (
      seo_dat_abo       IN OUT NOCOPY   pv_abo_sus_vol_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-------------------------------------------------------------------------------------------------------------------------------------
END pv_val_camplan_susvol_pg;
/
SHOW ERRORS
