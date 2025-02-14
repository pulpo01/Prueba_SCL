CREATE OR REPLACE PACKAGE Co_Ultpago_Pg IS
/*
1.  <Documentación TipoDoc = "Package Header">
2.  <Elemento Nombre = "CO_ULTPAGO_PG" Lenguaje="PL/SQL" Fecha="07-06-2005" Versión="1" Diseñador="****" Programador="****"

Ambiente="BD">
3.  <Retorno></Retorno>
4.  <Descripción>Encabezado de package CO_ULTPAGO_PG</Descripción>
5.  <Parámetros>
6.  <Entrada>
10. </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/

FUNCTION CO_CARGAPAGOS_FN ( EN_Codciclo IN NUMBER ) RETURN CHAR;

FUNCTION CO_ULTPAGO_FN ( EN_Cod_Cliente IN NUMBER ) RETURN VARCHAR2;

FUNCTION CO_CARGATOTALPAGOS_FN ( EN_Cicfactu       IN NUMBER,
                                 EN_ExisteRango    IN NUMBER,
                                 EN_ClienteInicial IN NUMBER,
                                 EN_ClienteFinal   IN NUMBER) RETURN VARCHAR2;

FUNCTION CO_VALIDAMODPAGO_FN (EN_codcliente  IN NUMBER, EN_numpago     IN NUMBER ) RETURN NUMBER;

FUNCTION CO_CARGAJUSTES_FN ( EN_Cicfactu       IN NUMBER,
                             EN_ExisteRango    IN NUMBER,
                             EN_ClienteInicial IN NUMBER,
                             EN_ClienteFinal   IN NUMBER ) RETURN VARCHAR2 ;

END Co_Ultpago_Pg;
/
SHOW ERRORS
