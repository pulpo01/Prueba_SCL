CREATE OR REPLACE PACKAGE FA_FOLIACION_PG IS

-- *********************************************************************
-- * Paquete              : FA_FOLIACION_PG
-- * Descripción          : Modulo de asignación de folios a Facturación
-- * Ultima Modificación  : 27-5-2009
-- * Responsable          : JORGE TORO OMAR
-- *********************************************************************
CV_nom_param   CONSTANT VARCHAR2 (20) := 'CONSUMO_CENTRALIZADO';
CV_modulo      CONSTANT VARCHAR2 (2) := 'FA';
CV_producto    CONSTANT NUMBER   (1) := 1;
CV_true        CONSTANT VARCHAR2 (4) := 'TRUE';
CV_param_cons_manual   CONSTANT NUMBER(3) := 101;
CV_consumo_manual CONSTANT VARCHAR2(1) := 'M';
CV_consumo_automatico CONSTANT VARCHAR2(1) := 'A';

FUNCTION FA_CONSULTA_FOLIO_FN     ( p_ntipo_documento IN NUMBER
                                  , p_nCod_vendedor   IN NUMBER
                                  , p_vCod_oficina    IN VARCHAR
                                  , p_vCod_operadora  IN VARCHAR
                                  , p_vprefijo_folio  IN VARCHAR
                                  , p_ncorrela_folio  IN NUMBER
                                  , p_nRango_inicial  IN NUMBER
                                  , p_nop_consulta    IN NUMBER
                                  , p_vInd_Consumo IN VARCHAR2 DEFAULT 'A') RETURN VARCHAR;

FUNCTION FA_CONSUME_FOLIO_FN      ( p_ntipo_documento IN NUMBER
                                  , p_nCod_vendedor   IN NUMBER
                                  , p_vCod_oficina    IN VARCHAR
                                  , p_vCod_operadora  IN VARCHAR
                                  , p_nRango_inicial  IN NUMBER
                                  , p_nNumero_venta   IN NUMBER
                                  , p_nNumero_proceso IN NUMBER
                                  , p_dfecha_proceso  IN DATE
                                  , p_nop_consumo     IN NUMBER
                                  , p_vInd_Consumo IN VARCHAR2 DEFAULT 'A') RETURN VARCHAR;

FUNCTION FA_ANULA_FOLIO_FN        ( p_ntipo_documento IN NUMBER
                                  , p_nCod_vendedor   IN NUMBER
                                  , p_vCod_oficina    IN VARCHAR
                                  , p_vCod_operadora  IN VARCHAR
                                  , p_vprefijo_folio  IN VARCHAR
                                  , p_ncorrela_folio  IN NUMBER
                                  , p_vInd_Consumo    IN VARCHAR2 DEFAULT 'NULL' ) RETURN VARCHAR;

FUNCTION FA_CONSULTA_FOLIO_MDEALER_FN( p_nCod_vendedor IN NUMBER
                                  , p_vCod_oficina    IN VARCHAR
                                  , p_vCod_operadora  IN VARCHAR
                                  , p_vInd_Consumo IN VARCHAR2 DEFAULT 'A') RETURN VARCHAR;

FUNCTION FA_CONSUME_FOLIOPUNTUAL_FN( p_ntipo_documento IN NUMBER
                                  , p_nCod_vendedor   IN NUMBER
                                  , p_vCod_oficina    IN VARCHAR
                                  , p_vCod_operadora  IN VARCHAR
                                  , p_nRango_inicial  IN NUMBER
                                  , p_nNumero_venta   IN NUMBER
                                  , p_nNumero_proceso IN NUMBER
                                  , p_dfecha_proceso  IN DATE
                                  , p_nop_consumo     IN NUMBER
                                  , p_vprefijo_folio  IN VARCHAR
                                  , p_ncorrela_folio  IN NUMBER
                                  , p_vInd_Consumo IN VARCHAR2 DEFAULT 'A') RETURN VARCHAR;

FUNCTION FA_CONSUME_FOLIO_CICLO_FN    ( p_ntipo_documento IN NUMBER
                                      , p_nCod_vendedor   IN NUMBER
                                      , p_vCod_oficina    IN VARCHAR
                                      , p_vCod_operadora  IN VARCHAR
                                      , p_nRango_inicial  IN NUMBER
                                      , p_nNumero_venta   IN NUMBER
                                      , p_nNumero_proceso IN NUMBER
                                      , p_dfecha_proceso  IN DATE
                                      , p_nop_consumo     IN NUMBER
                                      , p_vInd_Consumo IN VARCHAR2 DEFAULT 'A') RETURN VARCHAR;
                                      
FUNCTION FA_CONSUME_FOLIONOCORREL_FN( p_ntipo_documento IN NUMBER
                                  , p_nCod_vendedor   IN NUMBER
                                  , p_vCod_oficina    IN VARCHAR
                                  , p_vCod_operadora  IN VARCHAR
                                  , p_nRango_inicial  IN NUMBER
                                  , p_nNumero_venta   IN NUMBER
                                  , p_nNumero_proceso IN NUMBER
                                  , p_dfecha_proceso  IN DATE
                                  , p_nop_consumo     IN NUMBER
                                  , p_vprefijo_folio  IN VARCHAR
                                  , p_ncorrela_folio  IN NUMBER
                                  , p_vInd_Consumo IN VARCHAR2 DEFAULT 'M') RETURN VARCHAR;                                      

FUNCTION FA_OFICINA_CONSUMO_FN (EV_cod_oficina IN ge_oficinas.cod_oficina%TYPE )
      RETURN ge_oficinas.cod_oficina%TYPE;

FUNCTION FA_DOCUMENTO_CONSUMO_FN (p_ntipo_documento IN NUMBER  )
      RETURN NUMBER;
      
PROCEDURE  FA_BUSQUEDA_FOLIO_PR(p_nTipo_documento IN NUMBER  ,p_nCod_vendedor    IN NUMBER,p_vCod_oficina   IN VARCHAR2,
                                    p_vCod_operadora  IN VARCHAR2,p_nRango_Ini       IN NUMBER,p_nOp_busca      IN NUMBER,
                                    p_vPrefijo_folio  OUT VARCHAR2,p_nCorrela_folio  OUT NUMBER,p_nEstado_folio OUT NUMBER,
                                     p_nEst_funcion   OUT NUMBER  ,p_nRango_Ini_out  OUT NUMBER,p_vInd_Consumo IN VARCHAR2 DEFAULT 'A');                                                                              

END; -- Package Specification FA_FOLIACION_PG_JHTO
/
SHOW ERRORS