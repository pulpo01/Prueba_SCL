CREATE OR REPLACE TRIGGER al_afup_cabbolet
AFTER UPDATE
ON AL_CAB_BOLETA
FOR EACH ROW
  
WHEN (
 NEW.COD_ESTADO = 'CE' AND       NEW.COD_ESTADO <> OLD.COD_ESTADO
)
DECLARE
v_cabboleta al_cab_boleta%rowtype;
BEGIN
   v_cabboleta.num_boleta := :new.num_boleta;
   v_cabboleta.cod_bodega := :new.cod_bodega;
   v_cabboleta.fec_boleta := :new.fec_boleta;
   v_cabboleta.tip_movimiento := :new.tip_movimiento;
   v_cabboleta.cod_estado := :new.cod_estado;
   v_cabboleta.des_observacion := :new.des_observacion;
   v_cabboleta.nom_usuario := :new.nom_usuario;
   v_cabboleta.cod_vendedor := :new.cod_vendedor;
   v_cabboleta.cod_tipcomis := :new.cod_tipcomis;
   v_cabboleta.cod_oficina := :new.cod_oficina;

   v_cabboleta.pref_plaza := :new.pref_plaza;
   v_cabboleta.cod_operadora := :new.cod_operadora;
   al_pac_boleta.al_p_trata_boleta(v_cabboleta);
END;
/
SHOW ERRORS
