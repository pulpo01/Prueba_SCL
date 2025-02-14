CREATE OR REPLACE TRIGGER AL_BEIN_GEN_KIT
AFTER UPDATE
ON AL_CAB_AGREDES_KIT
FOR EACH ROW
 
WHEN (
NEW.COD_ESOL = 1 OR NEW.COD_ESOL = 4 OR NEW.COD_ESOL = 3
      )
declare
  v_cab_gen_kit  al_cab_agredes_kit%rowtype;
begin
  v_cab_gen_kit.NUM_GEN_KIT 	:= :NEW.NUM_GEN_KIT;
  v_cab_gen_kit.COD_BODEGA  	:= :NEW.COD_BODEGA;
  v_cab_gen_kit.TIP_STOCK	:= :NEW.TIP_STOCK;
  v_cab_gen_kit.COD_USO		:= :NEW.COD_USO;
  v_cab_gen_kit.COD_ESTADO	:= :NEW.COD_ESTADO;
  v_cab_gen_kit.COD_KIT		:= :NEW.COD_KIT;
  v_cab_gen_kit.CAN_SOLI	:= :NEW.CAN_SOLI;
  v_cab_gen_kit.PRC_UNIDAD	:= :NEW.PRC_UNIDAD;
  v_cab_gen_kit.FEC_GENERA	:= :NEW.FEC_GENERA;
  v_cab_gen_kit.COD_ESOL  	:= :NEW.COD_ESOL;
  v_cab_gen_kit.DES_OBSERVACION := :NEW.DES_OBSERVACION;
  v_cab_gen_kit.IND_AGREDES     := :NEW.IND_AGREDES;
  v_cab_gen_kit.NOM_USUARIO     := :NEW.NOM_USUARIO;
  v_cab_gen_kit.IND_TELEFONO    := :NEW.IND_TELEFONO;
  v_cab_gen_kit.COD_TECNOLOGIA  := :NEW.COD_TECNOLOGIA;
  v_cab_gen_kit.NUM_SERINICIAL  := :NEW.NUM_SERINICIAL;
  v_cab_gen_kit.NUM_SERFINAL   := :NEW.NUM_SERFINAL;
  v_cab_gen_kit.USUARIO_CIERRE  := :NEW.USUARIO_CIERRE;
  v_cab_gen_kit.FEC_CIERRE      := :NEW.FEC_CIERRE;
  v_cab_gen_kit.ID_SECUENCIA    := :NEW.ID_SECUENCIA;
  v_cab_gen_kit.CAN_INGRESADA   := :NEW.CAN_INGRESADA;
  IF V_CAB_GEN_KIT.COD_ESOL = 1 THEN
	  IF V_CAB_GEN_KIT.IND_AGREDES = 0 THEN
	      AL_PAC_KIT.P_AL_GENERACION_KIT(V_CAB_GEN_KIT);
	  ELSE
	      AL_PAC_KIT.P_AL_DESVINCULACION_KIT(V_CAB_GEN_KIT);
	  END IF;
  ELSE
  	  AL_PAC_KIT.P_AL_HISTORICO_KIT(V_CAB_GEN_KIT);
  END IF;
END;
/
SHOW ERRORS
