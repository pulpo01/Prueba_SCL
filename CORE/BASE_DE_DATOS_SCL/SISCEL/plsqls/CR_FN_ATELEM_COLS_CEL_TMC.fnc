CREATE OR REPLACE FUNCTION        cr_fn_atelem_cols_cel_tmc RETURN VARCHAR2 IS
--
v_encab VARCHAR2(2000);
--
BEGIN
    --
	v_encab:= 'Cod. Cliente|N? Guia|N? Evento|Tipo Documento|Desc.Tipo Documento|Numero Folio|Codigo Ciclo Facturacion| Nombre Cliente|Calle|N?Calle|N?Piso|N? Casilla|Obs.Direccion|Comuna|Ciudad|N?Celular ';
	 -- ****************************************************
	 RETURN v_encab;
	 --*********************************************************
EXCEPTION

   WHEN VALUE_ERROR THEN
   		RETURN 'ERROR 1 cr_fn_atelem_cols_cel_tmc, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN INVALID_NUMBER THEN
   		RETURN 'ERROR 2 cr_fn_atelem_cols_cel_tmc, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN OTHERS THEN
      RETURN 'ERROR 3 cr_fn_atelem_cols_cel_tmc, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
