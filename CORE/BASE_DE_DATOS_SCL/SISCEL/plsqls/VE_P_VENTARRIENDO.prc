CREATE OR REPLACE PROCEDURE        VE_P_VENTARRIENDO(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_operacion IN VARCHAR2 ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_TotVenArr IN OUT NUMBER )
IS
--Declaracisn de variables.
v_Total NUMBER := 0;
v_ImpCat NUMBER :=0;
v_categoria ve_categorias.cod_categoria%TYPE;
v_feciniliq DATE:= TO_DATE(vp_feciniliq,'DD-MON-YY');
v_fecfinliq DATE:= TO_DATE(vp_fecfinliq,'DD-MON-YY');
--Declaracisn de cursores.
CURSOR c_ventarriendo IS
 SELECT IMP_CATARTIC
 FROM VE_VENTALIN
 WHERE COD_VENDEDOR = vp_vendedor
 AND COD_PRODUCTO = vp_producto
 AND IND_OPERACION = vp_operacion
 AND TO_DATE(FEC_ACEPTVENTA,'DD-MON-YY') BETWEEN v_feciniliq AND v_fecfinliq;
--Cuerpo Principal
BEGIN
 If vp_operacion = 'V' THEN
  dbms_output.put_line('Calculando venta de artmculos/accesorios....');
 ELSE
  dbms_output.put_line('Calculando Rent Phone....');
 END IF;
 v_Total :=0;
 OPEN c_ventarriendo;
 LOOP
  FETCH  c_ventarriendo INTO v_ImpCat;
  EXIT WHEN c_ventarriendo%NOTFOUND;
  v_Total := v_Total + v_ImpCat;
 END LOOP;
 CLOSE c_ventarriendo;
 If vp_operacion = 'V' THEN
  dbms_output.put_line('Total venta de artmculos/accesorios....' || v_Total);
 ELSE
  dbms_output.put_line('Total Rent Phone....' || v_Total);
 END IF;
 vp_TotVenArr := v_Total;
END;
/
SHOW ERRORS
