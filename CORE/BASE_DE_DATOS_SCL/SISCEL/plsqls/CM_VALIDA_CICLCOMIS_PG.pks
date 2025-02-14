CREATE OR REPLACE PACKAGE CM_VALIDA_CICLCOMIS_PG  AS
/* *************************************************************************** */
/* Procedimiento que crea un ciclo comisional normal, mensual.                 */
PROCEDURE  CreaCiclComis(iCodCiclComis IN NUMBER);
/* Para una fecha, determina el ciclo que le corresponde.                      */
FUNCTION GetCiclComisFecha (sFecha IN VARCHAR2, iMeses IN NUMBER ,Cod_Ciclo IN NUMBER ) RETURN NUMBER;
/* Funcion que retorna el estado de un ciclo, dado el cod_periodo.             */
FUNCTION GetEstadoCiclComis (iCodCiclComis IN NUMBER) RETURN VARCHAR2;
/* Funcion que valida la existencia de un ciclo normal, dado un periodo.       */
FUNCTION ExisteCiclComis(iCodCiclComis IN NUMBER) RETURN NUMBER;
/* Funcion que valida que las fechas hasta sean superior al dia de proceso     */
FUNCTION ValidaCiclComis(iCodCiclComis IN NUMBER, szTipCiclComis IN CHAR) RETURN NUMBER;
/* Funcion que retorna el indicador de propiedad de la oficina donde opera el vendedor. */
FUNCTION iGetIndOficinaPropia(plCodVendedor IN NUMBER,piTipoRed IN NUMBER) RETURN NUMBER;
/* Funcion que retorna el vendedor padre del dado, en el tipo de red dado      */
FUNCTION iGetVendTipComis(plCodVendedor IN NUMBER,piTipoRed IN NUMBER, psTipComis IN VARCHAR2) RETURN NUMBER;
/* Funcion que determina si el vendedor es hijo del padre, para el tipo de red */
FUNCTION iEsVendePadre(pTipoRed IN NUMBER, pCodVendePadre IN NUMBER, pCodVendedor IN NUMBER) RETURN NUMBER;
/* *************************************************************************** */

END CM_VALIDA_CICLCOMIS_PG;
/
SHOW ERRORS
