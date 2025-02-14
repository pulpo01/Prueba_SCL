CREATE OR REPLACE PACKAGE FA_OBTIENE_DIRCLIE_PG AS

FUNCTION FA_OBTIENE_DIRCLIE_FN ( v_cod_sujeto VARCHAR2, 
                                 v_tip_sujeto NUMBER, 
                                 v_cod_tipdireccion NUMBER, 
                                 v_cod_display NUMBER, 
                                 v_val_fac VARCHAR2 := '1' )
RETURN VARCHAR2;

END FA_OBTIENE_DIRCLIE_PG;
/
SHOW ERRORS