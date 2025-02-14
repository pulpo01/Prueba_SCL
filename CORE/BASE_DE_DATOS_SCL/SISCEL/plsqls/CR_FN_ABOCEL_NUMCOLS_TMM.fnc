CREATE OR REPLACE FUNCTION cr_fn_abocel_numcols_tmm RETURN NUMBER IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Funcion            : CR_FN_ABOCEL_NUMCOLS_TMM
-- * Salida             : N? de Columnas de archivo AboCel para TMM
-- * Descripcion        : Funcion que retorna N? de Columnas de
-- *                      archivo AboCel
-- * Fecha de creacion  : Diciembre 2002
-- * Responsable        : Rodrigo Araneda (TM-MAS)
-- *************************************************************
v_cant_cols number;
--v_encab VARCHAR2(2000);
--
BEGIN
    --
        v_cant_cols := 15;
        --v_encab:= 'Cod. Cliente|N? Guia|N? Evento|Tipo Documento|Desc.Tipo Documento|Numero Folio|Codigo Ciclo Facturacion| Nombre Cliente|Calle|N?Externo|N?Interno|Colonia|Ciudad|Codigo Postal|N?Celular ';
         -- ****************************************************
         RETURN v_cant_cols;
         --*********************************************************
EXCEPTION

   WHEN VALUE_ERROR THEN
                RETURN 'ERROR 1 cr_fn_abocel_numcols_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN INVALID_NUMBER THEN
                RETURN 'ERROR 2 cr_fn_abocel_numcols_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN OTHERS THEN
      RETURN 'ERROR 3 cr_fn_abocel_numcols_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
