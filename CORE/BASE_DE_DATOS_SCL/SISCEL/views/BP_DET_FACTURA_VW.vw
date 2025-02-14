CREATE OR REPLACE FORCE VIEW bp_det_factura_vw (cod_cliente,
                                                       num_abonado,
                                                       fec_llamada,
                                                       cod_agrullam,
                                                       dur_llamada,
                                                       ind_unidad,
                                                       mto_real
                                                      )
AS
   SELECT a.num_clie, a.num_abon, TO_DATE (a.date_start_charg, 'yyyymmdd'),
          a.cod_agrl, a.dur_real, b.cod_unidad, a.mto_real
     FROM tol_detfactura_00 a, tol_tipollam_td b
    WHERE TRUNC (SYSDATE - 7) <= TO_DATE (a.date_start_charg, 'yyyymmdd')
      AND a.cod_llam = b.cod_llam
      AND a.cod_sent = b.cod_sentido
   UNION ALL
   SELECT a.num_clie, a.num_abon, TO_DATE (a.date_start_charg, 'yyyymmdd'),
          a.cod_agrl, a.dur_real, b.cod_unidad, a.mto_real
     FROM tol_detfactura_01 a, tol_tipollam_td b
    WHERE TRUNC (SYSDATE - 7) <= TO_DATE (a.date_start_charg, 'yyyymmdd')
      AND a.cod_llam = b.cod_llam
      AND a.cod_sent = b.cod_sentido
   UNION ALL
   SELECT a.num_clie, a.num_abon, TO_DATE (a.date_start_charg, 'yyyymmdd'),
          a.cod_agrl, a.dur_real, b.cod_unidad, a.mto_real
     FROM tol_detfactura_02 a, tol_tipollam_td b
    WHERE TRUNC (SYSDATE - 7) <= TO_DATE (a.date_start_charg, 'yyyymmdd')
      AND a.cod_llam = b.cod_llam
      AND a.cod_sent = b.cod_sentido
   UNION ALL
   SELECT a.num_clie, a.num_abon, TO_DATE (a.date_start_charg, 'yyyymmdd'),
          a.cod_agrl, a.dur_real, b.cod_unidad, a.mto_real
     FROM tol_detfactura_03 a, tol_tipollam_td b
    WHERE TRUNC (SYSDATE - 7) <= TO_DATE (a.date_start_charg, 'yyyymmdd')
      AND a.cod_llam = b.cod_llam
      AND a.cod_sent = b.cod_sentido
   UNION ALL
   SELECT a.num_clie, a.num_abon, TO_DATE (a.date_start_charg, 'yyyymmdd'),
          a.cod_agrl, a.dur_real, b.cod_unidad, a.mto_real
     FROM tol_detfactura_04 a, tol_tipollam_td b
    WHERE TRUNC (SYSDATE - 7) <= TO_DATE (a.date_start_charg, 'yyyymmdd')
      AND a.cod_llam = b.cod_llam
      AND a.cod_sent = b.cod_sentido
   UNION ALL
   SELECT a.num_clie, a.num_abon, TO_DATE (a.date_start_charg, 'yyyymmdd'),
          a.cod_agrl, a.dur_real, b.cod_unidad, a.mto_real
     FROM tol_detfactura_05 a, tol_tipollam_td b
    WHERE TRUNC (SYSDATE - 7) <= TO_DATE (a.date_start_charg, 'yyyymmdd')
      AND a.cod_llam = b.cod_llam
      AND a.cod_sent = b.cod_sentido
   UNION ALL
   SELECT a.num_clie, a.num_abon, TO_DATE (a.date_start_charg, 'yyyymmdd'),
          a.cod_agrl, a.dur_real, b.cod_unidad, a.mto_real
     FROM tol_detfactura_06 a, tol_tipollam_td b
    WHERE TRUNC (SYSDATE - 7) <= TO_DATE (a.date_start_charg, 'yyyymmdd')
      AND a.cod_llam = b.cod_llam
      AND a.cod_sent = b.cod_sentido
   UNION ALL
   SELECT a.num_clie, a.num_abon, TO_DATE (a.date_start_charg, 'yyyymmdd'),
          a.cod_agrl, a.dur_real, b.cod_unidad, a.mto_real
     FROM tol_detfactura_07 a, tol_tipollam_td b
    WHERE TRUNC (SYSDATE - 7) <= TO_DATE (a.date_start_charg, 'yyyymmdd')
      AND a.cod_llam = b.cod_llam
      AND a.cod_sent = b.cod_sentido
   UNION ALL
   SELECT a.num_clie, a.num_abon, TO_DATE (a.date_start_charg, 'yyyymmdd'),
          a.cod_agrl, a.dur_real, b.cod_unidad, a.mto_real
     FROM tol_detfactura_08 a, tol_tipollam_td b
    WHERE TRUNC (SYSDATE - 7) <= TO_DATE (a.date_start_charg, 'yyyymmdd')
      AND a.cod_llam = b.cod_llam
      AND a.cod_sent = b.cod_sentido
   UNION ALL
   SELECT a.num_clie, a.num_abon, TO_DATE (a.date_start_charg, 'yyyymmdd'),
          a.cod_agrl, a.dur_real, b.cod_unidad, a.mto_real
     FROM tol_detfactura_09 a, tol_tipollam_td b
    WHERE TRUNC (SYSDATE - 7) <= TO_DATE (a.date_start_charg, 'yyyymmdd')
      AND a.cod_llam = b.cod_llam
      AND a.cod_sent = b.cod_sentido;
