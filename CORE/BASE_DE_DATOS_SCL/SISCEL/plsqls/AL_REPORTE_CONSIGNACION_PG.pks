CREATE OR REPLACE PACKAGE Al_Reporte_Consignacion_Pg IS
-- *********************************************************************************************************************
-- <Documentaci�n TipoDoc = "Package Header">
-- <Elemento Nombre = " Al_Reporte_Consignacion_Pg" Lenguaje="PL/SQL" Fecha="17-05-2005" Versi�n="1.0" Dise�ador="****" Programador="******" Ambiente="BD">
-- <Retorno>String</Retorno>
-- <Descripci�n>package que entrega soluciones para reporte de series en consignaci�n</Descripci�n>
-- <Par�metros>
-- <Entrada>
-- </Entrada>
-- <Salida>
-- </Salida>
-- </Par�metros>
-- </Elemento>
-- </Documentaci�n>
-- **********************************************************************************************************************
--
FUNCTION AL_RETORNOQUERY_FN (EI_UsaBind  IN  PLS_INTEGER, EI_OnlyCount IN PLS_INTEGER DEFAULT NULL) RETURN VARCHAR2;

END;
/
SHOW ERRORS
