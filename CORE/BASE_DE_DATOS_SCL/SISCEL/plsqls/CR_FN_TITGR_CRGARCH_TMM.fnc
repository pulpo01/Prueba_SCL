CREATE OR REPLACE FUNCTION cr_fn_titgr_crgarch_tmm RETURN VARCHAR2 IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Funcion            : CR_FN_TITGR_CRGARCH_TMM
-- * Salida             : Titulo de una columna en la grilla
-- * Descripcion        : Funcion que retorna Titulo de una
--                                                columna en la grilla de correspondencia
-- * Fecha de creacion  : Diciembre 2002
-- * Responsable        : Rodrigo Araneda (TM-MAS)
-- *************************************************************
v_encab VARCHAR2(2000);
--
BEGIN
    --
        v_encab:= ' CODIGO COLONIA  ';
         -- ****************************************************
         RETURN v_encab;
         --*********************************************************
EXCEPTION

   WHEN VALUE_ERROR THEN
                RETURN 'ERROR 1 cr_fn_titgr_crgarch_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN INVALID_NUMBER THEN
                RETURN 'ERROR 2 cr_fn_titgr_crgarch_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN OTHERS THEN
      RETURN 'ERROR 3 cr_fn_titgr_crgarch_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
