CREATE OR REPLACE PACKAGE PV_PLANES_ADICIONALES_PG
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "FA_CONCEPTOS_SP_PG"
          Lenguaje="PL/SQL"
          Fecha="30-07-2007"
          Versión="1.0"
          Diseñador=""
          Programador="rao"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción></Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
</Elemento>
</Documentación>
*/
IS
    TYPE refCursor IS REF CURSOR;
    cv_error_no_clasif      VARCHAR2 (50) := 'No es posible clasificar el error';
       cv_cod_modulo           VARCHAR2 (2)  := 'PV';
       cv_version              VARCHAR2 (2)  := '1';
--------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_PLANES_DEFECTO_PR (EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EV_FECHA_BAJA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento

                            );
--------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_INTEGRACION_PR (   EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                EN_NUM_OS_ANULAR   IN ci_orserv.num_os%TYPE,
                                EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EV_FECHA_BAJA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                             );
--------------------------------------------------------------------------------------------------------------------------------------
--Inicio Inc. 170939 / 25-07-2011 / FDL
 PROCEDURE pv_planes_adicionales_oo_pr(en_cliente_origen  IN GE_CLIENTES.cod_cliente%TYPE,
                                        en_abonado_origen  IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        ev_plan_origen     IN TA_PLANTARIF.cod_plantarif%TYPE,
                                        en_num_os_anular   IN CI_ORSERV.num_os%TYPE,
                                        en_cliente_destino IN GE_CLIENTES.cod_cliente%TYPE,
                                        en_abonado_destino IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        ev_plan_destino    IN TA_PLANTARIF.cod_plantarif%TYPE,
                                        ed_fecha_alta      IN DATE,
                                        ed_fecha_baja      IN DATE,
                                        en_num_mov_ant     IN ICC_MOVIMIENTO.num_movant%TYPE,
                                        en_num_proceso     IN pr_productos_contratados_to.num_proceso%TYPE,
                                        ev_cod_canal       IN pr_productos_contratados_to.cod_canal%TYPE,
                                        sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        sn_num_evento      OUT NOCOPY ge_errores_pg.evento
                                    );
--Fin Inc. 170939 / 25-07-2011 / FDL
--------------------------------------------------------------------------------------------------------------------------------------
--Inicio Inc. 170939 / 25-07-2011 / FDL
  PROCEDURE pv_quita_planes_opcionales_pr(en_cliente_origen IN GE_CLIENTES.cod_cliente%TYPE,
                                          en_abonado_origen IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                          en_cliente_destino IN GE_CLIENTES.cod_cliente%TYPE, -- FPP 22-07-2010 Defecto 100
                                          ev_plan_origen    IN TA_PLANTARIF.cod_plantarif%TYPE,
                                          ev_plan_destino   IN TA_PLANTARIF.cod_plantarif%TYPE,
                                          ed_fecha_alta     IN DATE,
                                          ed_fecha_baja     IN DATE,
                                          en_num_mov_ant    IN ICC_MOVIMIENTO.num_movant%TYPE,
                                          en_num_proceso    IN pr_productos_contratados_to.num_proceso%TYPE,
                                          ev_cod_canal      IN pr_productos_contratados_to.cod_canal%TYPE,
                                          ev_tipo_relacion  IN NUMBER,
                                          sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                          sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                          sn_num_evento     OUT NOCOPY ge_errores_pg.evento
                                        );
--Fin Inc. 170939 / 25-07-2011 / FDL
--------------------------------------------------------------------------------------------------------------------------------------
--Inicio Inc. 170939 / 25-07-2011 / FDL
  PROCEDURE pv_agrega_planes_opcionales_pr(ev_plan_origen     IN TA_PLANTARIF.cod_plantarif%TYPE,
                                           en_cliente_destino IN GE_CLIENTES.cod_cliente%TYPE,
                                           en_abonado_destino IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                           ev_plan_destino    IN TA_PLANTARIF.cod_plantarif%TYPE,
                                           ed_fecha_alta      IN DATE,
                                           ed_fecha_baja      IN DATE,
                                           en_num_mov_ant     IN ICC_MOVIMIENTO.num_movant%TYPE,
                                           en_num_proceso     IN pr_productos_contratados_to.num_proceso%TYPE,
                                           ev_cod_canal       IN pr_productos_contratados_to.cod_canal%TYPE,
                                           ev_tipo_relacion   IN NUMBER,
                                           sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                           sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                           sn_num_evento      OUT NOCOPY ge_errores_pg.evento
                                        );
--Fin Inc. 170939 / 25-07-2011 / FDL
--------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_PROVISION_ABONADO_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO       IN pr_productos_contratados_to.num_proceso%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            );
PROCEDURE PV_LLAMADA_ODBC_APROVI_PR(EN_SECUENCIAL      IN GA_TRANSACABO.NUM_TRANSACCION%TYPE,
                                    EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                    EN_NUMERO_VENTA    IN ga_abocel.NUM_VENTA%TYPE,
                                    EN_NUMERO_MOVANT   IN ICC_MOVIMIENTO.NUM_MOVANT%TYPE
                                   );


PROCEDURE PV_FACHADA_UNIX_PR(  EN_NUM_OS  IN PV_IORSERV.NUM_OS%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            );


PROCEDURE PV_FEC_VIGENCIA_PLAN_PR (      EN_CLIENTE         IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO         IN ga_abocel.num_abonado%TYPE,
                                EV_PLAN_DESTINO       IN ta_plantarif.cod_plantarif%TYPE,
                                SD_FECHA           OUT NOCOPY GA_INTARCEL.FEC_DESDE%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                             );
--------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_BAJA_PLANES_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EV_FECHA_BAJA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            );

PROCEDURE PV_PROVISION_BAJA_ABO_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO       IN pr_productos_contratados_to.num_proceso%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            );

PROCEDURE PV_PROVISION_ODBC_BAJA_ABO_PR(EN_SECUENCIAL      IN GA_TRANSACABO.NUM_TRANSACCION%TYPE,
                                        EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                        EN_NUMERO_VENTA    IN ga_abocel.NUM_VENTA%TYPE
                                       );


--------------------------------------------------------------------------------------------------------------------------------------
FUNCTION IC_MANTIENE_PLAN_FN(EN_MOVIMIENTO IN icc_movimiento.num_movimiento%TYPE)
RETURN VARCHAR2;


/*185264 BRC*/
PROCEDURE PV_PROVISION_ABONADO_PR_ALTA(  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
EV_FECHA_ALTA        IN VARCHAR2,
EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
EN_NUM_PROCESO       IN pr_productos_contratados_to.num_proceso%TYPE,
SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
);                                                            
/*185264 BRC*/
END PV_PLANES_ADICIONALES_PG;
/
