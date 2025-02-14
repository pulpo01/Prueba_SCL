CREATE OR REPLACE TRIGGER AUD_TOLCDCTO_AFDE_TG
   AFTER DELETE
   ON tol_cliedcto_to
   REFERENCING OLD AS OLD NEW AS NEW
   FOR EACH ROW
DECLARE
   n_respuesta     NUMBER;
   error_proceso   EXCEPTION;
   v_id_registro   VARCHAR2 (300);
   v_detalle       VARCHAR2 (2000);
BEGIN
   v_id_registro :=
         :OLD.tip_dcto
      || ','
      || :OLD.cod_dcto
      || ','
      || :OLD.cod_cliente
      || ','
      || :OLD.num_sec
      || ','
      || TO_CHAR (:OLD.fec_ini_vig, 'DD-MM-YYYY HH24:MI:SS');
   v_detalle :=
         :OLD.tip_dcto
      || ','
      || :OLD.cod_dcto
      || ','
      || :OLD.cod_cliente
      || ','
      || :OLD.num_sec
      || ','
      || TO_CHAR (:OLD.fec_ini_vig, 'DD-MM-YYYY HH24:MI:SS');
   n_respuesta :=
      aud_auditoria_pg.aud_registra_auditoria_fn ('SISCEL',
                                                  'TOL_CLIEDCTO',
                                                  'DELETE',
                                                  v_id_registro,
                                                  v_detalle
                                                 );
EXCEPTION
   WHEN error_proceso
   THEN
      NULL;
END AUD_TOLCDCTO_AFDE_TG;
/
SHOW ERRORS
