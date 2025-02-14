CREATE OR REPLACE PROCEDURE        VE_P_HABILIEGC(
  vp_cuadrante IN NUMBER ,
  vp_habilitacion IN NUMBER ,
  vp_liquidacion IN NUMBER ,
  vp_ImpHab IN OUT NUMBER ,
  vp_error IN OUT VARCHAR2 )
IS
-- Declaracisn de variables
v_impbase ve_cuadrantesliq.imp_base%TYPE;
v_anomliq ve_anomliq.num_anomalia%TYPE := NULL;
-- Cuerpo Principal
BEGIN
 vp_ImpHab := 0;
 BEGIN
  SELECT IMP_BASE INTO v_impbase
  FROM VE_CUADRANTESLIQ
  WHERE COD_CUADRANTE = vp_cuadrante;
  dbms_output.put_line('Importe base por habilitacisn:....' || v_impbase);
  vp_ImpHab := v_impbase * vp_habilitacion;
 EXCEPTION
  WHEN NO_DATA_FOUND THEN
  vp_error := sqlcode;
  ve_p_insanomliq (vp_liquidacion,'NO EXISTE DATOS EN LA MATRIZ
		PARA HABILITACIONES EGC','VE_P_HABILIEGC','VE_CUADRANTESLIQ',
  'S', sqlcode, sqlerrm, v_anomliq);
 END;
END;
/
SHOW ERRORS
