CREATE OR REPLACE PACKAGE Co_Ultpago_Pg IS
/*
1.  <Documentaci�n TipoDoc = "Package Header">
2.  <Elemento Nombre = "CO_ULTPAGO_PG" Lenguaje="PL/SQL" Fecha="07-06-2005" Versi�n="1" Dise�ador="****" Programador="****"

Ambiente="BD">
3.  <Retorno></Retorno>
4.  <Descripci�n>Encabezado de package CO_ULTPAGO_PG</Descripci�n>
5.  <Par�metros>
6.  <Entrada>
10. </Entrada>
16. </Par�metros>
17. </Elemento>
18. </Documentaci�n>
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
