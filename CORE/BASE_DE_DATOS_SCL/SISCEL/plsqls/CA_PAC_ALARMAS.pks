CREATE OR REPLACE PACKAGE        ca_pac_alarmas IS
  --
  -- Retrofitted
  PROCEDURE ca_p_alarmas(
  v_tipincidencia IN number )
;
  --
  -- Retrofitted
  PROCEDURE ca_p_ctlalarmas(
  v_tipincidencia IN number ,
  v_maximo IN OUT number ,
  v_dias IN OUT number ,
  v_mensaje IN OUT char ,
  v_error IN OUT char )
;
  --
  -- Retrofitted
  PROCEDURE ca_p_existe_acumalarmas(
  v_tipincidencia IN number ,
  v_acumulado IN OUT number ,
  v_error IN OUT char )
;
  --
  -- Retrofitted
  PROCEDURE ca_p_insert_acumalarmas(
  v_tipincidencia IN number ,
  v_dias IN number )
;
  --
  -- Retrofitted
  PROCEDURE ca_p_insert_alarmas(
  v_tipincidencia IN number ,
  v_mensaje IN char )
;
  --
  -- Retrofitted
  PROCEDURE ca_p_update_acumalarmas(
  v_tipincidencia IN number ,
  v_acumulado IN number )
;
END ca_pac_alarmas;
/
SHOW ERRORS
