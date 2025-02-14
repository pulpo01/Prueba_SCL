CREATE OR REPLACE PACKAGE  AL_INGRESOMERCADERIA_CLS_PG IS

PROCEDURE P_TRATA_INGRESO_PR (
IN_Ordening IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLinea IN al_lineas_ordenes.num_linea%TYPE,
IN_OrdenGsm IN gsm_cabsol_simcard_to.num_seq_solicitud%TYPE  DEFAULT NULL,
IN_Flag     IN PLS_INTEGER DEFAULT 1);
--
PROCEDURE P_INGRESA_SERIES_PR
(
IN_Ordening IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLinea IN al_lineas_ordenes.num_linea%TYPE,
IN_OrdenGsm IN gsm_cabsol_simcard_to.num_seq_solicitud%TYPE DEFAULT NULL,
IN_Flag     IN PLS_INTEGER DEFAULT 1);
--
PROCEDURE P_INSERTA_SERIES_PR  (
IN_Ordening     IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLinea     IN AL_LINEAS_ORDENES.num_linea%TYPE,
IV_NumSerie     IN AL_SERIES_ORDENES2.num_serie%TYPE,
IV_Hlr             IN AL_SERIES_ORDENES2.cod_hlr%TYPE,
IV_aKey         IN AL_SERIES_ORDENES2.a_key%TYPE,
IV_ChkDigits    IN AL_SERIES_ORDENES2.chk_digits%TYPE,
IV_NumSublock   IN AL_SERIES_ORDENES2.num_sublock%TYPE,
IN_Ind_Telefono IN AL_SERIES_ORDENES2.ind_telefono%TYPE,
IN_NumTelefono  IN AL_SERIES_ORDENES2.num_telefono%TYPE,
TN_Central      IN AL_SERIES_ORDENES2.cod_central%TYPE,
TN_Subalm       IN AL_SERIES_ORDENES2.cod_subalm%TYPE,
TN_CodCat       IN AL_SERIES_ORDENES2.cod_cat%TYPE,
IN_tipo_archivo IN AL_INGRESOSERIESTEMP_TO.hexadecimal%TYPE ) ;
--
PROCEDURE P_VALIDA_SERIE_PR
(IN_Ordening IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLinea IN al_lineas_ordenes.num_linea%TYPE,
v_Serie IN AL_SERIES_ORDENES2.NUM_SERIE%TYPE,
v_Terminal IN AL_ARTICULOS.TIP_TERMINAL%TYPE,
szCod_Hlr  OUT GSM_SIMCARD_TO.COD_HLR%TYPE,
v_salida   OUT PLS_INTEGER,
izError    OUT AL_ERRORES_TEMP_TO.COD_ERROR%TYPE,
IN_OrdenGsm IN gsm_cabsol_simcard_to.num_seq_solicitud%TYPE DEFAULT NULL);
--
PROCEDURE P_INSERTA_ERROR_PR(
IN_Ordening IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLinea   IN AL_LINEAS_ORDENES.NUM_LINEA%TYPE,
IV_NumSerie    IN AL_SERIES_ORDENES2.NUM_SERIE%TYPE,
iError        IN NUMBER  ) ;
--
PROCEDURE P_EXISTEN_ERRORES_PR
(IN_Ordening IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLinea IN al_lineas_ordenes.num_linea%TYPE,
bRet          IN OUT  boolean) ;
--
PROCEDURE P_CANTIDADES_ORDENCOMPRA_PR
(
IN_OrdenCompra IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLineaOC IN al_lineas_ordenes.num_linea%TYPE) ;
--
FUNCTION bExisteALFICSERIES (
IN_OrdenCompra IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLineaOC  IN al_lineas_ordenes.num_linea%TYPE,
IV_Num_serie   IN al_series_ordenes.num_serie%TYPE
) RETURN BOOLEAN;
--
--******************************************************
--Variables Globales
 izNum_Orden_Ref    al_cabecera_ordenes.num_orden_ref%TYPE;
 izhTipOrdenRef     al_cabecera_ordenes.tip_orden_ref%TYPE;
 izhNumLineaRef        al_lineas_ordenes.num_linea_ref%TYPE;
 szCod_Hlr          gsm_simcard_to.cod_hlr%TYPE;
 v_tipo_archivo     INTEGER;
 szSinError         VARCHAR2(2);
 dSeriesTotalOC     al_lineas_ordenes2.can_orden%type;
 dSeriesServidas    al_lineas_ordenes1.can_servida%type;
 dSeriesIngresadas  al_lineas_ordenes2.can_orden%type;
 dIngresadasAsp     al_lineas_ordenes2.can_orden%type;
 dPendientesAsp     al_lineas_ordenes2.can_orden%type;
 dNuevasPermitidas  al_lineas_ordenes2.can_orden%type;
 --

-- *************************************************************************************************
--PRIMER CURSOR INVOCADO POR P_TRATA_INGRESO_PR QUE VALIDA SERIES EN TABLA  AL_INGRESOSERIESTEMP_TO
-- *************************************************************************************************
 CURSOR    c_series_temp (IT_Num_OrdenOC IN al_cabecera_ordenes.num_orden%TYPE,
                              IT_Num_OrdenOI IN al_cabecera_ordenes.num_orden%TYPE,
                          IT_Num_lineaOI IN al_lineas_ordenes2.num_linea%TYPE) IS
  SELECT   a.num_serie, a.num_telefono telefonoFic, b.num_min telefonoTemp,
           decode(b.cod_central,NULL,0,1) ind_telefono,
             b.cod_central, b.cod_subalm,b.cod_cat, a.a_key, a.chk_digits, a.num_sublock
  FROM        AL_INGRESOSERIESTEMP_TO a, AL_FIC_SERIES b
  WHERE    a.num_proceso = IT_Num_OrdenOC
  AND      a.num_subproceso = IT_Num_OrdenOI
  AND        a.num_linea = IT_Num_lineaOI
  AND      a.num_proceso = b.num_orden(+)
  AND        a.num_serie = b.num_serie(+);
  --
-- ********************************************************************************************************
--SEGUNDO CURSOR INVOCADO POR P_INGRESA_SERIES QUE INGRESA SERIES YA VALIDADES EN TABLA AL_SERIES_ORDENES2
-- ********************************************************************************************************

  CURSOR   c_series_ok (IT_Num_OrdenOC IN al_cabecera_ordenes.num_orden%TYPE,
                            IT_Num_OrdenOI IN al_cabecera_ordenes.num_orden%TYPE,
                        IT_Num_lineaOI IN al_lineas_ordenes2.num_linea%TYPE) IS
  SELECT   a.num_serie, a.num_telefono telefonoTemp, b.num_telefono telefonoFic,
           decode(b.cod_central,NULL,0,1) ind_telefono,
             b.cod_central, b.cod_subalm,b.cod_cat, a.a_key, a.chk_digits, a.num_sublock
  FROM        AL_INGRESOSERIESTEMP_TO a, AL_FIC_SERIES b
  WHERE    a.num_proceso = IT_Num_OrdenOC
  AND      a.num_subproceso = IT_Num_OrdenOI
  AND        a.num_linea = IT_Num_lineaOI
  AND      a.num_proceso = b.num_orden(+)
  AND        a.num_serie = b.num_serie(+)
  AND      a.cod_error IS NULL;
  ---
--******************************************************
END AL_INGRESOMERCADERIA_CLS_PG;
/
SHOW ERRORS