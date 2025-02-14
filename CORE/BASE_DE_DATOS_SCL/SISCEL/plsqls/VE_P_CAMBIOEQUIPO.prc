CREATE OR REPLACE PROCEDURE        VE_P_CAMBIOEQUIPO(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_liquidacion IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_TotCamEqu IN OUT NUMBER ,
  vp_error IN OUT VARCHAR2 )
IS
--Declaracisn de variables.
v_NumCamEqu NUMBER :=0;
v_Base NUMBER :=0;
v_Total NUMBER :=0;
v_anomliq ve_anomliq.num_anomalia%TYPE := NULL;
--Cuerpo Principal
BEGIN
      vp_TotCamEqu := 0;
 -- Averiguo el nzmero de cambios de equipos realizados
 -- por un vendedor y para un determinado producto.
 SELECT COUNT(*)
 INTO v_NumCamEqu
 FROM VE_VENTALIN
 WHERE COD_VENDEDOR = vp_vendedor
 AND COD_PRODUCTO = vp_producto
 AND IND_OPERACION = 'E'
 AND to_date(FEC_ACEPTVENTA,'dd-mon-yy
') BETWEEN vp_feciniliq AND vp_fecfinliq;
 -- Selecciono el IMP_BASE
 BEGIN
  SELECT IMP_BASE INTO v_Base
  FROM VE_CUADRANTESLIQ
  WHERE COD_CUADRANTE = vp_cuadrante;
 EXCEPTION WHEN NO_DATA_FOUND THEN
  vp_error := sqlcode;
  ve_p_insanomliq ( vp_liquidacion,
'NO SE PUDO OBTENER EL IMPORTE BASE EN CUADRANTE' || vp_cuadrante,
  'VE_P_CAMBIOEQUIPO','VE_CUADRANTESLIQ','S', sqlcode, sqlerrm, v_anomliq);
 END;
 dbms_output.put_line('Base: ' || v_Base || ' N: cambios :' || v_NumCamEqu);
 v_Total := v_NumCamEqu * v_Base;
 dbms_output.put_line('Total por cambios de equipos: ' || v_Total);
 vp_TotCamEqu := v_Total;
END;
/
SHOW ERRORS
