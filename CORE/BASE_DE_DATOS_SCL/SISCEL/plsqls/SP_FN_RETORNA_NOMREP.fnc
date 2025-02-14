CREATE OR REPLACE FUNCTION          "SP_FN_RETORNA_NOMREP" (p_CodReporte varchar) return varchar  is

error_salida EXCEPTION;
v_nombre     sp_qry_reportes.nom_reporte%type;

BEGIN
    SELECT nom_reporte
	INTO v_nombre
	FROM sp_qry_reportes
	WHERE cod_reporte=p_CodReporte AND
	      cod_operadora=ge_fn_operadora_scl;

	if sqlcode <> 0 then
      raise  error_salida;
   end if;


   RETURN v_nombre;

EXCEPTION
   WHEN error_salida THEN
    RETURN 'ERROR :'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
   WHEN NO_DATA_FOUND THEN
    RETURN 'Error reporte No existe en tabla....';
   WHEN OTHERS THEN
    RETURN 'ERROR :'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

END;
/
SHOW ERRORS
