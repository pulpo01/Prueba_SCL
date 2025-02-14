CREATE OR REPLACE PROCEDURE        VE_P_BMOVILIZACION(
  vp_cuadrante IN NUMBER ,
  vp_habilitaciones IN NUMBER ,
  vp_TotBono IN OUT NUMBER )
IS
--Declaracisn de variables.
v_base ve_cuadrantesliq.imp_base%TYPE;
v_limite ve_cuadrantesliq.num_limite%TYPE;
v_Total NUMBER :=0;
--Cuerpo Principal
BEGIN
      dbms_output.put_line('Calculando Bono Movilizacisn....');
 v_base := 0;
 v_limite := 0;
 vp_TotBono :=0;
      SELECT  IMP_BASE, NUM_LIMITE
      INTO  v_base, v_limite
      FROM  VE_CUADRANTESLIQ
      WHERE  COD_CUADRANTE = vp_cuadrante;
      IF vp_habilitaciones < v_limite THEN
       v_Total := vp_habilitaciones * v_base;
            dbms_output.put_line('Base: ' || v_base);
            dbms_output.put_line('Habilitaciones: ' || vp_habilitaciones);
      ELSE
            v_Total := v_limite * v_base;
            dbms_output.put_line('Base: ' || v_base);
            dbms_output.put_line('Lmmite: ' || v_limite);
      END IF;
      dbms_output.put_line('Total Bono Movilizacisn : ' || v_Total);
 vp_TotBono := v_Total;
END;
/
SHOW ERRORS
