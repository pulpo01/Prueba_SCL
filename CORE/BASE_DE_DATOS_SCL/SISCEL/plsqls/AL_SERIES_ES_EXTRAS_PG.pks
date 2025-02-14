CREATE OR REPLACE PACKAGE AL_SERIES_ES_EXTRAS_PG IS
/*
<Documentación TipoDoc = "Package">
<Elemento Nombre = "AL_SERIES_ES_EXTRAS_PG" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Valida e inserta las series procesadas para entradas y salidas extras.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

TYPE refcursor IS REF CURSOR;

CV_EstadoCE   VARCHAR2(2):= 'CE';
CV_EstadoNU   VARCHAR2(2):= 'NU';
CV_OBS        VARCHAR2(100):= 'Proceso Ajuste Movimiento Extra';
CN_RegCommit  NUMBER(4):= 5000;
CN_uno        PLS_INTEGER:=1;
CN_cero       PLS_INTEGER:=0;
CN_dos       PLS_INTEGER:=2;
CV_Salidas    VARCHAR2(1):= 'S';
CV_Entradas   VARCHAR2(1):= 'E';
CV_Modulo   VARCHAR2(2):= 'AL';
CV_paramGSM  VARCHAR2(30):='COD_SIMCARD_GSM';
CV_MovSimultaneo VARCHAR2(1):= 'T';
CV_Accesorio VARCHAR2(1):= 'A';

CN_IndRecambio PLS_INTEGER:=9;
CN_Categoria VARCHAR2(3):= 'ZZZ';
CN_num_meses PLS_INTEGER:=0;
CN_cod_promedio PLS_INTEGER:=0;
CN_cod_antiguedad PLS_INTEGER:=0;
CN_cod_modventa PLS_INTEGER:=0;



PROCEDURE AL_LIBERA_NUMERO_ORDEN_PR (EN_num_extra IN al_ser_es_extras.num_extra%TYPE);

PROCEDURE AL_LIBERA_NUMERO_SALIDA_PR (EN_num_extra IN al_ser_es_extras.num_extra%TYPE ,
                                                                   EN_num_linea IN al_ser_es_extras.num_linea%TYPE);

PROCEDURE AL_SER_ES_EXTRAS_PR( EN_num_extra IN AL_SER_ES_EXTRAS.NUM_EXTRA%TYPE ,
                                                           EN_num_linea IN AL_SER_ES_EXTRAS.NUM_LINEA%TYPE) ;

PROCEDURE AL_SER_SALIDAS_EXTRAS_PR( EN_num_extra IN AL_SER_ES_EXTRAS.NUM_EXTRA%TYPE ,
                                                                EN_num_linea IN AL_SER_ES_EXTRAS.NUM_LINEA%TYPE) ;

PROCEDURE AL_VALIDA_ES_EXTRAS_PR( EN_num_extra  IN AL_SER_ES_EXTRAS.NUM_EXTRA%TYPE,
                                                              EN_num_linea  IN AL_SER_ES_EXTRAS.NUM_LINEA%TYPE);


PROCEDURE AL_VALIDA_SALIDAS_EXTRAS_PR( EN_num_extra  IN AL_SER_ES_EXTRAS.NUM_EXTRA%TYPE,
                                                                   EN_num_linea  IN AL_SER_ES_EXTRAS.NUM_LINEA%TYPE,
                                                                           EN_tip_stock IN AL_LIN_ES_EXTRAS.TIP_STOCK%TYPE,
                                                                           EN_articulo  IN AL_LIN_ES_EXTRAS.COD_ARTICULO%TYPE,
                                                                           EN_uso       IN AL_LIN_ES_EXTRAS.cod_uso%TYPE,
                                                                           EN_estado    IN AL_LIN_ES_EXTRAS.cod_estado%TYPE);

PROCEDURE AL_INSERTA_SERIES_ES_EXTRAS_PR( EN_num_extra IN AL_SER_ES_EXTRAS.NUM_EXTRA%TYPE ,
                                                                                  EN_num_linea IN AL_SER_ES_EXTRAS.NUM_LINEA%TYPE);

PROCEDURE AL_INSERTA_SALIDAS_EXTRAS_PR( EN_num_extra IN AL_SER_ES_EXTRAS.NUM_EXTRA%TYPE ,
                                                                                       EN_num_linea IN AL_SER_ES_EXTRAS.NUM_LINEA%TYPE,
                                                                                           EN_tip_stock IN AL_LIN_ES_EXTRAS.TIP_STOCK%TYPE,
                                                                                           EN_articulo  IN AL_LIN_ES_EXTRAS.COD_ARTICULO%TYPE,
                                                                                           EN_uso       IN AL_LIN_ES_EXTRAS.cod_uso%TYPE,
                                                                                           EN_estado    IN AL_LIN_ES_EXTRAS.cod_estado%TYPE,
                                                                                           EN_nro       IN AL_LIN_ES_EXTRAS.can_extra%TYPE);

FUNCTION AL_OBTIENE_HLR_FN( EV_num_serie  IN AL_SERIES.NUM_SERIE%TYPE)
          RETURN al_series.cod_hlr%TYPE ;


FUNCTION AL_OBTIENE_PARAMETRO_FN( EV_nom_parametro  IN GED_PARAMETROS.NOM_PARAMETRO%TYPE,
                                                                  EV_cod_modulo         IN GED_PARAMETROS.COD_MODULO%TYPE)
          RETURN GED_PARAMETROS.VAL_PARAMETRO%TYPE ;

FUNCTION AL_VALIDAESTADOSIMCARD_FN( EV_num_serie  IN AL_SERIES.NUM_SERIE%TYPE)
                  RETURN AL_SERIES.COD_PRODUCTO%TYPE ;



PROCEDURE AL_MOVIMIENTO_EXTRA_PR (EN_num_extra IN al_ser_es_extras.num_extra%TYPE ,
                                                                  EN_num_linea IN al_ser_es_extras.num_linea%TYPE,
                                                          EN_bodega IN al_cab_es_extras.cod_bodega%TYPE,
                                                                  EN_motivo IN al_cab_es_extras.cod_motivo%TYPE,
                                                          EN_articulo  IN al_lin_es_extras.cod_articulo%TYPE,
                                                          EN_uso     IN al_lin_es_extras.cod_uso%TYPE,
                                                          EN_estado  IN al_lin_es_extras.cod_estado%TYPE,
                                                          EN_stock   IN al_lin_es_extras.tip_stock%TYPE,
                                                                  EV_mov     IN al_cab_es_extras.ind_entsal%TYPE);

PROCEDURE AL_VALIDA_SIMULTANEO_PR(EN_num_extra IN al_ser_es_extras.num_extra%TYPE ,
                                                                  EN_num_linea IN al_ser_es_extras.num_linea%TYPE,
                                                          EN_bodegaDest IN al_cab_es_extras.cod_bodega%TYPE,
                                                          EN_articulo  IN al_lin_es_extras.cod_articulo%TYPE,
                                                          EN_usoDest     IN al_lin_es_extras.cod_uso%TYPE,
                                                          EN_estadoDest  IN al_lin_es_extras.cod_estado%TYPE,
                                                          EN_stockDest   IN al_lin_es_extras.tip_stock%TYPE,
                                                                  EN_Movim       IN al_tipos_movimientos.tip_movimiento%TYPE);

PROCEDURE AL_MOVIMIENTO_SIMULTANEO_PR (EN_num_extra IN al_ser_es_extras.num_extra%TYPE ,
                                                                  EN_num_linea IN al_ser_es_extras.num_linea%TYPE,
                                                          EN_bodega IN al_cab_es_extras.cod_bodega%TYPE,
                                                                  EN_motivo IN al_cab_es_extras.cod_motivo%TYPE,
                                                          EN_articulo  IN al_lin_es_extras.cod_articulo%TYPE,
                                                          EN_uso     IN al_lin_es_extras.cod_uso%TYPE,
                                                          EN_estado  IN al_lin_es_extras.cod_estado%TYPE,
                                                          EN_stock   IN al_lin_es_extras.tip_stock%TYPE,
                                                                  EN_proceso IN al_series_es_extras_tt.ind_proceso%TYPE);

PROCEDURE AL_ASIGNA_NUMERACION_PR(EN_orden IN al_lin_es_extras.num_extra%type ,
                                  EN_linea IN al_lin_es_extras.num_linea%type ,
                                  EV_subalm IN ge_subalms.cod_subalm%type ,
                                  EN_central IN icg_central.cod_central%type ,
                                  EN_uso IN al_usos.cod_uso%type ,
                                  EN_nro_reutil IN al_lin_es_extras.num_extra%type ,
                                  EN_cat IN ga_catnumer.cod_cat%type);

PROCEDURE AL_INSERTA_MOVSIMULTANEO_PR (ER_cabextra al_cab_es_extras%rowtype);


PROCEDURE AL_VALIDA_SIMULTANEO_DOBLE_PR(EN_num_extra    IN al_ser_es_extras.num_extra%TYPE ,
                                                                        EN_num_linea    IN al_ser_es_extras.num_linea%TYPE,
                                                                EN_bodegaDest   IN al_cab_es_extras.cod_bodega%TYPE,
                                                                EN_articulo     IN al_lin_es_extras.cod_articulo%TYPE,
                                                                EN_usoDest      IN al_lin_es_extras.cod_uso%TYPE,
                                                                EN_estadoDest   IN al_lin_es_extras.cod_estado%TYPE,
                                                                EN_stockDest    IN al_lin_es_extras.tip_stock%TYPE,
                                                                        EN_Movim        IN al_tipos_movimientos.tip_movimiento%TYPE,
                                                                                EN_SwValoArt    IN NUMBER);

PROCEDURE AL_INSERTA_MOVSIMULTANEO_D_PR (EN_num_extra   IN al_ser_es_extras.num_extra%TYPE ,
                                                                         EN_num_linea   IN al_ser_es_extras.num_linea%TYPE,
                                                                                 EN_motivo IN al_cab_es_extras.cod_motivo%TYPE);

END AL_SERIES_ES_EXTRAS_PG ;
/
SHOW ERRORS