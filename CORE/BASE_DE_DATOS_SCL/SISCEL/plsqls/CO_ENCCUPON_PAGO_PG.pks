CREATE OR REPLACE PACKAGE        Co_Enccupon_Pago_Pg   IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : O_ENCCUPON_PAGO_PG
-- * Descripcisn        : Procedimientos Almacenados de Creacisn
-- *                      del Encabezado de Comprobantes de Pago
-- * Fecha de creacisn  : 05-01-2005
-- * Responsable        : Area Recaudacisn
-- * Fecha de Modificac : 18-04-2005
-- * Modificacion       : Se agregan funciones CO_NTEL_OPERADORA_FN,
-- *                      CO_CIUD_SUCURSAL_FN y CO_NOMB_CAJERO_FN
-- * Respondable        : HQR
-- *************************************************************

   FUNCTION CO_DESC_OPERADORA_FN(EV_operadora IN VARCHAR2) RETURN VARCHAR2;
   FUNCTION CO_IDEN_OPERADORA_FN(EV_operadora IN VARCHAR2) RETURN VARCHAR2;
   FUNCTION CO_NTEL_OPERADORA_FN(EV_operadora IN VARCHAR2) RETURN VARCHAR2;
   FUNCTION CO_CIUD_SUCURSAL_FN(EV_operadora IN VARCHAR2, EV_sucursal IN VARCHAR2) RETURN VARCHAR2;

END Co_Enccupon_Pago_Pg;
/
SHOW ERRORS
