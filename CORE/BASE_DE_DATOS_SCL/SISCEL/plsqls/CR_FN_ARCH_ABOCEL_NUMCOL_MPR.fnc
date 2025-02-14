CREATE OR REPLACE FUNCTION        cr_fn_arch_abocel_numcol_mpr RETURN NUMBER IS
--
v_cant_cols number;
--v_encab VARCHAR2(2000);
--
BEGIN
    --
	v_cant_cols := 13;

	 -- ****************************************************
	 RETURN v_cant_cols;
	 --*********************************************************
EXCEPTION

   WHEN VALUE_ERROR THEN
   		RETURN 'ERROR 1 cr_fn_arch_abocel_numcol_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN INVALID_NUMBER THEN
   		RETURN 'ERROR 2 cr_fn_arch_abocel_numcol_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN OTHERS THEN
      RETURN 'ERROR 3 cr_fn_arch_abocel_numcol_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
