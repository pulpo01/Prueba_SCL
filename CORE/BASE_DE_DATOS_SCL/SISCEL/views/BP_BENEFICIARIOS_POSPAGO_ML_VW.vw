CREATE OR REPLACE FORCE VIEW bp_beneficiarios_pospago_ml_vw (cod_cliente,
                                                                              num_abonado,
                                                                              num_ident,
                                                                              fec_ingreso,
                                                                              cod_ciclo,
                                                                              cod_plan,
                                                                              fec_desdeapli,
                                                                              num_periodos,
                                                                              tip_beneficio,
                                                                              ind_exclusion,
                                                                              cod_criterio,
                                                                              tip_entidad,
                                                                              cod_dcto,
                                                                              tip_dcto,
                                                                              row_id
                                                                             )
AS
   SELECT a.cod_cliente, a.num_abonado, a.num_ident, a.fec_ingreso,
          b.cod_ciclo, c.cod_plan, c.fec_desdeapli, c.cnt_periodos,
          c.tip_beneficio, c.ind_exclusion, c.cod_criterio, c.tip_entidad,
          c.cod_dcto, c.tip_dcto, a.ROWID
     FROM bpt_beneficiarios a, ge_clientes b, bpd_planes c,
          tol_descuento_td d
    WHERE a.cod_estado = 'V'
      AND b.cod_cliente = a.cod_cliente
      AND c.cod_plan = a.cod_plan
      AND c.fec_desdeapli = a.fec_desdeapli
      AND c.tip_beneficio = 'ML'
      AND c.cod_estado = 'V'
      AND c.cod_tiplan = '2'
      AND c.tip_periodo = 'D'
      AND d.cod_dcto = c.cod_dcto
      AND d.tip_dcto = c.tip_dcto
      AND c.tip_ejec IN (1, TO_NUMBER (TO_CHAR (SYSDATE, 'd')) + 1)
          WITH READ ONLY
/
SHOW ERRORS
