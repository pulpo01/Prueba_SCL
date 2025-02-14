CREATE OR REPLACE PROCEDURE        VE_P_PLANTARIFARIO(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_TotPlan IN OUT NUMBER )
IS
--Declaracisn de variables.
v_Total NUMBER :=0;
v_ImpCat NUMBER :=0;
v_categoria ve_categorias.cod_categoria%TYPE;
--Declaracisn de cursores.
CURSOR c_plantarif IS
      SELECT IMP_CATPLAN
      FROM VE_VENTALIN
      WHERE COD_VENDEDOR = vp_vendedor
 AND COD_PRODUCTO = vp_producto
 AND IND_OPERACION = 'V'
      AND FEC_ACEPTVENTA BETWEEN vp_feciniliq AND vp_fecfinliq;
--Cuerpo Principal
BEGIN
 dbms_output.put_line('Calculando Plan Tarifario....');
 v_Total :=0;
 OPEN c_plantarif;
 LOOP
  FETCH  c_plantarif INTO v_ImpCat;
  EXIT WHEN c_plantarif%NOTFOUND;
  v_Total := v_Total + v_ImpCat;
 END LOOP;
 CLOSE c_plantarif;
 dbms_output.put_line('Total Plan Tarifario....' || v_Total);
 vp_TotPlan := v_Total;
END;
/
SHOW ERRORS
