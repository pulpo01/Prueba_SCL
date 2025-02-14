CREATE OR REPLACE PACKAGE PV_CARGOS_CICLO_ODBC_PG IS

    cv_error_no_clasif      VARCHAR2 (50) := 'No es posible clasificar el error';
    cv_cod_modulo           VARCHAR2 (2)  := 'GA';
    cv_version              VARCHAR2 (2)  := '1';

  PROCEDURE PV_CARGOS_ODBC_PR(
     EV_TRANSACCION            IN VARCHAR2
    ,EN_SEQ_CARGO              IN NUMBER
    ,EN_EN_COD_CLIENTE         IN NUMBER
    ,EN_NUM_ABONADO            IN NUMBER
    ,EN_COD_PROD_CONTRATADO    IN NUMBER
    ,EN_COD_PRODUCTO           IN NUMBER
    ,EN_ID_CARGO               IN NUMBER
    ,EN_COD_CONCEPTO           IN NUMBER
    ,EN_COLUMNA                IN NUMBER
    ,ED_FEC_ALTA               IN VARCHAR2
    ,EN_IMP_CARGO              IN NUMBER
    ,EV_COD_MONEDA             IN VARCHAR2
    ,EN_COD_PLANCOM            IN NUMBER
    ,EN_NUM_UNIDADES           IN NUMBER
    ,EN_IND_FACTUR             IN NUMBER
    ,EN_NUM_TRANSACCION        IN NUMBER
    ,EN_NUM_VENTA              IN NUMBER
    ,EN_NUM_PAQUETE            IN NUMBER
    ,EV_NUM_TERMINAL           IN VARCHAR2
    ,EV_COD_CICLFACT           IN VARCHAR2
    ,EV_NUM_SERIE              IN VARCHAR2
    ,EV_NUM_SERIEMEC           IN VARCHAR2
    ,EN_CAP_CODE               IN NUMBER
    ,EN_MES_GARANTIA           IN NUMBER
    ,EV_NUM_PREGUIA            IN VARCHAR2
    ,EV_NUM_GUIA               IN VARCHAR2
    ,EN_COD_CONCEREL           IN NUMBER
    ,EN_COLUMNA_REL            IN NUMBER
    ,EN_COD_CONCEPTO_DTO       IN NUMBER
    ,EN_VAL_DTO                IN NUMBER
    ,EN_TIP_DTO                IN NUMBER
    ,EN_IND_CUOTA              IN NUMBER
    ,EN_NUM_CUOTAS             IN NUMBER
    ,EN_ORD_CUOTA              IN NUMBER
	,EN_IND_SUPERTEL           IN NUMBER
	,EN_IND_MANUAL             IN NUMBER
	,EV_PREF_PLAZA             IN VARCHAR2
	,EV_COD_TECNOLOGIA         IN VARCHAR2
	,EV_GLS_DESCRIP            IN VARCHAR2
	,EN_NUM_FACTURA            IN NUMBER
	,ED_FEC_ULTMOD             IN VARCHAR2
	,EV_NOM_USUARIO            IN VARCHAR2
	
    );
    
    

END PV_CARGOS_CICLO_ODBC_PG;
/
SHOW ERRORS