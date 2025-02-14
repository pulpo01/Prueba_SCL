CREATE OR REPLACE FUNCTION cr_fn_atelem_cols_beep_tmm RETURN VARCHAR2 IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Funcion            : CR_FN_ATELEM_COLS_BEEP_TMM
-- * Salida             : Encabezado para Archivo Beeper TMM
-- * Descripcion        : Funcion que retorna el Encabezado para
-- *                      Archivo Beeper
-- * Fecha de creacion  : Diciembre 2002
-- * Responsable        : Rodrigo Araneda (TM-MAS)
-- *************************************************************
v_encab VARCHAR2(2000);
--
BEGIN
    --
        v_encab:= 'Cod. Cliente|N? Guia|N? Evento|Tipo Documento|Desc.Tipo Documento|Numero Folio|Codigo Ciclo Facturacion| Nombre Cliente|Calle|N?Externo|N?Interno|Colonia|Ciudad|Codigo Postal|Telefono ConT1|Telefono ConT2|N?Beeper ';
         -- ****************************************************
         RETURN v_encab;
         --*********************************************************
EXCEPTION

   WHEN VALUE_ERROR THEN
                RETURN 'ERROR 1 cr_fn_atelem_cols_beep_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN INVALID_NUMBER THEN
                RETURN 'ERROR 2 cr_fn_atelem_cols_beep_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN OTHERS THEN
      RETURN 'ERROR 3 cr_fn_atelem_cols_beep_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
