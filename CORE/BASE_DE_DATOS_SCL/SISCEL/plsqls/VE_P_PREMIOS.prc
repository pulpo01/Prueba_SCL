CREATE OR REPLACE PROCEDURE        VE_P_PREMIOS(
  vp_cuadrante IN NUMBER ,
  vp_cumplimiento IN NUMBER ,
  vp_liquidacion IN NUMBER ,
  vp_catcomis IN NUMBER ,
  vp_meta IN NUMBER ,
  vp_TotPremio IN OUT NUMBER ,
  vp_sqlcode IN OUT VARCHAR2 )
IS
--Declaracisn de variables.
v_totcomis NUMBER :=0;
v_rango ve_cuadcomis.imp_rango%TYPE;
v_sqlerrm VARCHAR2(70);
v_anomliq ve_anomliq.num_anomalia%TYPE := NULL;
v_minval ve_cuadcomis.imp_desde%TYPE:=0;
--Declaracisn de cursores.
--Cuerpo Principal
BEGIN
 vp_TotPremio := 0;
 BEGIN
 SELECT MIN(IMP_DESDE) INTO v_minval
 FROM VE_CUADCOMIS
 WHERE COD_CUADRANTE = vp_cuadrante;
 BEGIN
  SELECT IMP_RANGO INTO v_rango
  FROM VE_CUADCOMIS
  WHERE COD_CUADRANTE = vp_cuadrante
  AND IMP_DESDE <= vp_cumplimiento
  AND IMP_HASTA >= vp_cumplimiento;
  v_totcomis := vp_meta * v_rango;
  IF vp_catcomis = 7 THEN
   dbms_output.put_line('Importe PREMIO para Repr. Venta: '
   || v_rango || ' x Meta: ' || vp_meta);
  ELSIF vp_catcomis = 8 THEN
   dbms_output.put_line('Importe PREMIO para Ejec. Venta: '
   || v_rango || ' x Meta: ' || vp_meta);
  ELSIF vp_catcomis = 1 THEN
   dbms_output.put_line('Importe PREMIO para Master Dealer: '
   || v_rango || ' x Meta: ' || vp_meta);
  ELSIF vp_catcomis = 2 THEN
   dbms_output.put_line('Importe PREMIO para Dealer: '
   || v_rango || ' x Meta: ' || vp_meta);
  ELSIF vp_catcomis = 3 THEN
   dbms_output.put_line('Importe PREMIO para Corredor: '
   || v_rango || ' x Meta: ' || vp_meta);
  END IF;
  vp_TotPremio := v_totcomis;
  EXCEPTION
   WHEN NO_DATA_FOUND THEN
   if v_minval < vp_cumplimiento THEN
    vp_sqlcode := sqlcode;
    ve_p_insanomliq (vp_liquidacion,
'NO SE ENCUENTRAN DATOS EN LA MATRIZ PARA UN CUMPLIMIENTO DE
' || vp_cumplimiento || '%.',
    'VE_P_PREMIOS','VE_CUADCOMIS','S', vp_sqlcode, sqlerrm, v_anomliq);
    dbms_output.put_line('EL CUMPLIMIENTO DE META ' || vp_meta || ' QUE ES UN
' || vp_cumplimiento || '%');
    dbms_output.put_line('NO SUPERA EL PORCENTAJE MINIMO ESTABLECIDO:
' || v_minval || '%');
   END IF;
  END;
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
  vp_sqlcode := sqlcode;
  ve_p_insanomliq (vp_liquidacion,'NO EXISTE NINGUNA MATRIZ DE PREMIOS.',
  'VE_P_PREMIOS','VE_CUADCOMIS','S', sqlcode, sqlerrm, v_anomliq);
  dbms_output.put_line('NO EXISTE NINGUNA MATRIZ DE PREMIOS');
 END;
END;
/
SHOW ERRORS
