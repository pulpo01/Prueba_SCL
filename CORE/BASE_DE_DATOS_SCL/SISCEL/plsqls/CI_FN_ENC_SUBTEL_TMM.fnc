CREATE OR REPLACE FUNCTION ci_fn_enc_subtel_tmm RETURN VARCHAR2 IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Funcion            : CI_FN_ENC_SUBTEL_TMM
-- * Salida             : Encabezado para Reporte Subtel
-- * Descripcion        : Funcion que retorna el Encabezado
-- *                      del Reporte Subtel
-- * Fecha de creacion  : Diciembre 2002
-- * Responsable        : Rodrigo Araneda (TM-MAS)
-- *************************************************************
v_encab VARCHAR2(2000);
--
BEGIN
    --
        v_encab:= '"N? Reclamo|Nombre Reclamante|Num.Identificacion|Direccion|Colonia|Ciudad|Telefono|Fecha Reclamo|Empresa Reclamada| Situacion  |N? Celular|Monto Reclamado|Estado Reclamo|Resp. Solucion|Fecha Solucion|Monto Reclamado Aceptado " ';
         -- ****************************************************
         RETURN v_encab;
         --*********************************************************
EXCEPTION

   WHEN VALUE_ERROR THEN
                RETURN 'ERROR 1 ci_fn_enc_subtel_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN INVALID_NUMBER THEN
                RETURN 'ERROR 2 ci_fn_enc_subtel_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN OTHERS THEN
      RETURN 'ERROR 3 ci_fn_enc_subtel_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
