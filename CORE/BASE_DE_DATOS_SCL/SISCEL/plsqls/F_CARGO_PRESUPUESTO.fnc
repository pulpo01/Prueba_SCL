CREATE OR REPLACE function  F_CARGO_PRESUPUESTO(v_num_proceso in number, v_columna in number, v_cod_concepto in number)
return fa_presupuesto.IMP_FACTURABLE%type is
	   v_imp_facturable fa_presupuesto.IMP_FACTURABLE%type;
begin
SELECT sum(NVL(A.IMP_FACTURABLE,0)) into v_imp_facturable
FROM
       FA_PRESUPUESTO A,
       FA_CONCEPTOS X
WHERE
       a.num_proceso = v_num_proceso AND
	   a.columna = v_columna and
       A.COD_TIPCONCE = 3 AND
       A.IND_FACTUR = 1 AND
       A.IND_CUOTA = 0 AND
       X.COD_CONCEPTO = A.COD_CONCEPTO AND
       X.COD_TIPCONCE = A.COD_TIPCONCE and
	   a.cod_concepto = v_cod_concepto ;
return	  v_imp_facturable ;
end;
/
SHOW ERRORS
