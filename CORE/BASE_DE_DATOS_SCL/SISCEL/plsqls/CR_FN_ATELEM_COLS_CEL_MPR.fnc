CREATE OR REPLACE FUNCTION        cr_fn_atelem_cols_cel_mpr RETURN VARCHAR2 IS
--
v_encab VARCHAR2(2000);
--
BEGIN
    --
	v_encab:= 'Cod. Cliente|N? Guia|N? Evento|Tipo Documento|Desc.Tipo Documento|Numero Folio|Codigo Ciclo Facturacion|Nombre Cliente|Des. Direc1|Des. Direc2|Pueblo|Estado|ZIP|Obs.Direccion|N?Celular ';
	 -- ****************************************************
	 RETURN v_encab;
	 --*********************************************************
EXCEPTION

   WHEN VALUE_ERROR THEN
   		RETURN 'ERROR 1 cr_fn_atelem_cols_cel_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN INVALID_NUMBER THEN
   		RETURN 'ERROR 2 cr_fn_atelem_cols_cel_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN OTHERS THEN
      RETURN 'ERROR 3 cr_fn_atelem_cols_cel_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
