CREATE OR REPLACE TRIGGER SP_AFUP_ORDEN
AFTER UPDATE
ON SP_ORDENES_REPARACION FOR EACH ROW
WHEN (
NEW.COD_ESTADO_ORDEN <> OLD.COD_ESTADO_ORDEN
      )
DECLARE
   v_estado sp_ordenes_reparacion%rowtype;
BEGIN
   v_estado.num_orden    := :new.num_orden;
   v_estado.cod_estado_orden   := :new.cod_estado_orden;
   insert into sp_hestados_orden
   (num_orden, cod_estado_orden, fec_estado, nom_usuarora)
   values
   (v_estado.num_orden, v_estado.cod_estado_orden, sysdate, user );
   ST_PROCESOS_PG.ST_HISTORICO_OBSERVACIONES_PR(:new.num_orden, :new.cod_estado_orden );
END;
/
SHOW ERRORS

