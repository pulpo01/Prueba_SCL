CREATE OR REPLACE PACKAGE Al_Reporte_Consignacion_Pg IS
-- *********************************************************************************************************************
-- <Documentación TipoDoc = "Package Header">
-- <Elemento Nombre = " Al_Reporte_Consignacion_Pg" Lenguaje="PL/SQL" Fecha="17-05-2005" Versión="1.0" Diseñador="****" Programador="******" Ambiente="BD">
-- <Retorno>String</Retorno>
-- <Descripción>package que entrega soluciones para reporte de series en consignación</Descripción>
-- <Parámetros>
-- <Entrada>
-- </Entrada>
-- <Salida>
-- </Salida>
-- </Parámetros>
-- </Elemento>
-- </Documentación>
-- **********************************************************************************************************************
--
FUNCTION AL_RETORNOQUERY_FN (EI_UsaBind  IN  PLS_INTEGER, EI_OnlyCount IN PLS_INTEGER DEFAULT NULL) RETURN VARCHAR2;

END;
/
SHOW ERRORS
