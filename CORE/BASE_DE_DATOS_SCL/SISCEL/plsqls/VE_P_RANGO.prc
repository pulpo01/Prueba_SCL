CREATE OR REPLACE PROCEDURE        VE_P_RANGO(
  vp_Liquidacion IN NUMBER ,
  vp_Archivo IN VARCHAR2 ,
  vp_Cuadrante IN NUMBER ,
  vp_Habilitaciones IN NUMBER ,
  vp_Rango OUT NUMBER )
IS
v_Rango NUMBER := 0;
v_sqlcode VARCHAR2(10);
v_sqlerrm VARCHAR2(70);
v_anomliq ve_anomliq.num_anomalia%TYPE := NULL;
BEGIN
BEGIN SELECT IMP_RANGO
 INTO  v_Rango
 FROM VE_CUADCOMIS
 WHERE COD_CUADRANTE = vp_Cuadrante
 AND vp_Habilitaciones BETWEEN IMP_DESDE AND IMP_HASTA;
EXCEPTION WHEN NO_DATA_FOUND THEN
 v_Rango := 0;
 v_sqlcode:= sqlcode;
 v_sqlerrm:= sqlerrm;
 ve_p_insanomliq ( vp_liquidacion,
'NO HAY RANGO PARA CALCULAR CUMPLIMIENTO DE METAS',
    vp_Archivo,'VE_CUADCOMIS','S',v_sqlcode,v_sqlerrm, v_anomliq);
END;
dbms_output.put_line('Rango: ' || v_rango);
vp_Rango := v_Rango;
END;
/
SHOW ERRORS
