CREATE OR REPLACE PACKAGE        ca_pac_historico IS
  --
  -- Retrofitted
  PROCEDURE ca_p_historico_incidencias(
  v_record IN ca_incidencias%rowtype )
;
  --
  -- Retrofitted
  PROCEDURE ca_p_inserta_hincidencias(
  v_record IN ca_incidencias%rowtype )
;
  --
  -- Retrofitted
  PROCEDURE ca_p_inserta_hincicomentarios(
  v_incidencia IN number )
;
  --
  -- Retrofitted
  PROCEDURE ca_p_inserta_hincisectores(
  v_incidencia IN number )
;
  --
  -- Retrofitted
  PROCEDURE ca_p_inserta_hvalincidencias(
  v_incidencia IN number )
;
  --
  -- Retrofitted
  PROCEDURE ca_p_delete_incidencias
;
  --
  -- Retrofitted
  PROCEDURE ca_p_delete_incisectores
;
  --
  -- Retrofitted
  PROCEDURE ca_p_delete_incicomentarios
;
  --
  -- Retrofitted
  PROCEDURE ca_p_delete_valincidencias
;
END ca_pac_historico;
/
SHOW ERRORS
