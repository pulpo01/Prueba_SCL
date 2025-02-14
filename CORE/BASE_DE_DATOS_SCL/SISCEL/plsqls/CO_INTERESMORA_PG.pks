CREATE OR REPLACE PACKAGE Co_Interesmora_Pg IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : CO_INTERESMORA_PG
-- * Descripcion        : Procedimientos Almacenados de Calculo de Interes por Mora
-- * Fecha de creacion  : 26-04-2005
-- * Responsable        : Area Cobranza
-- * Numero de Version  :
-- *    version 1.0.0  Inicial
-- *    version 1.0.1  Soporte RyC RA-200512090264 09.12.2005. Se modifica PL Co_Calculo_Pr()
-- *    version 1.0.2  Soporte RyC RA-200601160584 17.01.2006. Se genera nuevo numero de secuencia en CO_INSERTAR_ERRORES_PR()
-- *    version 1.0.3  Soporte RyC CO-200603220007 21.03.2006. Inc. 35235 24-04-2007 Se modifica PL Co_Calculo_Pr()
-- *    version 1.0.4  Soporte RyC Inc. 38166      21.06.2007  Se modifica PL Co_Calculo_Pr()

-- *************************************************************
	PROCEDURE CO_INSERTAR_ERRORES_PR(
	EV_SecuenciAco	IN VARCHAR2,
	EV_Concfact		IN VARCHAR2,
	EN_Ruteo		IN NUMBER,
	EV_Glserror		IN VARCHAR2,
	EN_Valcob		IN NUMBER );

	PROCEDURE Co_Calculo_Pr(
	EV_SecuenciaTran  	IN VARCHAR2,
	EV_CodCliente     	IN VARCHAR2,
	EV_NumFolio       	IN VARCHAR2,
	EV_PrefPlaza      	IN VARCHAR2,
	EV_NumSecuenci    	IN VARCHAR2,
	EV_TipDocum       	IN VARCHAR2,
	EV_MontoFact      	IN VARCHAR2,
	EV_SecCuota       	IN VARCHAR2,
	EV_FechaCalcAct   	IN VARCHAR2,
 	EV_CodConcepto      IN NUMBER DEFAULT -1,
	EV_Columna          IN NUMBER DEFAULT -1);  /*CAGV 21-03-2006 CO-200603220007 - CGLagos 24-04-2007 Inc. 35235 21-06-2007 Inc. 38166 */

	PROCEDURE Co_Obtiene_Param_Negocio_Pr (
	EV_ValidarBaja	   IN OUT NOCOPY VARCHAR2,
	EV_FactorCPPC	   IN OUT NOCOPY VARCHAR2,
	EV_FactorIVA	   IN OUT NOCOPY VARCHAR2,
	EV_EventoInteres   IN OUT NOCOPY VARCHAR2,
	EV_MedidaInteres   IN OUT NOCOPY VARCHAR2,
	EV_FactorCarrier   IN OUT NOCOPY VARCHAR2,
	EV_TipoPago        IN OUT NOCOPY VARCHAR2,
	EV_retorno		   IN OUT NOCOPY NUMBER,
	EV_DescError	   IN OUT NOCOPY VARCHAR2);

	PROCEDURE Co_Verifica_Baja_Pr (
	EV_cliente 		   IN NUMBER,
	EN_retorno 		   OUT NOCOPY NUMBER);

	PROCEDURE Co_Fecha_Calculoint_Apli_Pr (
	EN_cliente 		   IN NUMBER,
	EN_folio 		   IN NUMBER,
	EN_prefplaza 	   IN VARCHAR2,
	EN_seccuota 	   IN VARCHAR2,
	EN_TipoPago 	   IN VARCHAR2,
	EN_RetFechaCalc    IN OUT NOCOPY VARCHAR2);

	PROCEDURE Co_Obtener_Cppc_Pr (
	EN_retorno         OUT NOCOPY NUMBER );

	PROCEDURE Co_Obtener_Pct_Iva_Pr (
	EN_retorno         OUT NOCOPY NUMBER);

END Co_Interesmora_Pg;
/
SHOW ERRORS