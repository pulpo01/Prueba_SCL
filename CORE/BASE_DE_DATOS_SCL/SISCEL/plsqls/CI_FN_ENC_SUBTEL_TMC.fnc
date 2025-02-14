CREATE OR REPLACE FUNCTION        ci_fn_enc_subtel_tmc RETURN VARCHAR2 IS
--
v_encab VARCHAR2(2000);
--
BEGIN
    --
	v_encab:= '"N? Reclamo|Nombre Reclamante|Num.Identificacion|Direccion|Comuna|Ciudad|Telefono|Fecha Reclamo|Empresa Reclamada| Situacion  |N? Celular|Monto Reclamado|Estado Reclamo|Resp. Solucion|Fecha Solucion|Monto Reclamado Aceptado " ';
	 -- ****************************************************
	 RETURN v_encab;
	 --*********************************************************
EXCEPTION

   WHEN VALUE_ERROR THEN
   		RETURN 'ERROR 1 ci_fn_enc_subtel_tmc, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN INVALID_NUMBER THEN
   		RETURN 'ERROR 2 ci_fn_enc_subtel_tmc, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN OTHERS THEN
      RETURN 'ERROR 3 ci_fn_enc_subtel_tmc, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
