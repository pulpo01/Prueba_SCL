CREATE OR REPLACE PROCEDURE        VE_P_LIQEAC(
  vp_liquidacion IN NUMBER ,
  vp_ctoliq IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_vendedor IN NUMBER ,
  vp_catcomis IN NUMBER ,
  vp_tipcomis IN VARCHAR2 ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE )
IS
v_TotComis NUMBER := 0;
v_ctoliq NUMBER := TO_NUMBER(SUBSTR(TO_CHAR(vp_ctoliq), 1, 2));
v_anomliq ve_anomliq.num_anomalia%TYPE := NULL;
--Cuerpo Principal
BEGIN
dbms_output.put_line('-----------------------------------');
dbms_output.put_line('Producto: ' || vp_producto);
dbms_output.put_line('Vendedor: ' || vp_vendedor);
dbms_output.put_line('-----------------------------------');
-- *** Cambios de Equipo
IF v_ctoliq = 50 THEN
 ve_p_cambioequipo (vp_vendedor,vp_producto,vp_cuadrante,vp_liquidacion,
    vp_feciniliq,vp_fecfinliq,v_TotComis,v_anomliq);
END IF;
-- *** Venta de Articulos/Accesorios
IF v_ctoliq = 40  THEN
 ve_p_ventarriendo (vp_vendedor, vp_producto, 'V',
    vp_feciniliq, vp_fecfinliq, v_TotComis);
ELSIF v_ctoliq = 41 THEN
 ve_p_ventarriendo (vp_vendedor, vp_producto, 'R',
    vp_feciniliq, vp_fecfinliq, v_TotComis);
END IF;
dbms_output.put_line('Total Comision: ************* ' || v_totcomis);
INSERT INTO VE_RESLIQUIDAC (
 NUM_LIQUIDACION, COD_TIPCOMIS, COD_VENDEDOR, COD_CTOLIQ, COD_PRODUCTO,
 IMP_COMISION, IND_ACEPTADO, COD_CUADRANTE, NUM_META, IMP_BASE,
 NUM_LIMITE,  NUM_ANOMALIA )
VALUES (
 vp_liquidacion, vp_tipcomis, vp_vendedor, vp_ctoliq, vp_producto,
 v_TotComis,  0,   vp_cuadrante, null,  null,
 null,   v_anomliq);
END;
/
SHOW ERRORS
