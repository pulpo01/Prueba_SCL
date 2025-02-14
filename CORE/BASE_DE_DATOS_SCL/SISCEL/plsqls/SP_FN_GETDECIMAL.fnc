CREATE OR REPLACE FUNCTION          "SP_FN_GETDECIMAL" (p_tipo  number,p_codigo varchar2) return number
is
-- Tipo Indica el tipo de numero a solicitar la cantidad de decimales
-- Tipo =1  Moneda   (ge_monedas)
-- Tipo <>1  Numero en general (ged_parametros parametro=NUM_DECIMAL )
-- Codigo  solo valido(por el momento)  cuando es moneda (cod_moneda) en otro caso  null

v_num_decimal   number;


begin

   If p_tipo=1 THEN  -- Monedas
     SELECT num_decimal
	 INTO v_num_decimal
	 FROM ge_monedas
	 WHERE cod_moneda=p_codigo;
   ELSE
     SELECT val_parametro
	 INTO v_num_decimal
	 FROM ged_parametros
	 WHERE nom_parametro='NUM_DECIMAL'
	 AND cod_modulo='GE'
	 AND cod_producto=1;
   END IF;

   RETURN v_num_decimal;

EXCEPTION
  when OTHERS then
      raise_application_error(-20147,'Error Entrega Nro. Decimal');
end;
/
SHOW ERRORS
