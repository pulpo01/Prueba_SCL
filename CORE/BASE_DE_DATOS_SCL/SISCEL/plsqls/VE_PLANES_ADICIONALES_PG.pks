CREATE OR REPLACE PACKAGE VE_PLANES_ADICIONALES_PG
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "VE_PLANES_ADICIONALES_PG"
          Lenguaje="PL/SQL"
          Fecha="08-08-2011"
          Versión="1.0"
          Diseñador=""
          Programador=""
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Copia de PV_PLANES_ADICIONALES_PG para Ventas</Descripción>
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

-------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_PA_VENTA_NORMAL_PR( EN_CLIENTE_DESTINO   IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                 EN_ABONADO_DESTINO   IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                 EN_COD_PROD_OFERTADO IN  PF_PRODUCTOS_OFERTADOS_TD.COD_PROD_OFERTADO%TYPE,
                                 EN_NUM_VECES         IN  PF_PAQUETE_OFERTADO_TO.NUM_VECES_HIJO%TYPE,
                                 EN_NUM_PROCESO       IN  PR_PRODUCTOS_CONTRATADOS_TO.NUM_PROCESO%TYPE,  
                                 EN_NUM_MOV_ANT       IN  ICC_MOVIMIENTO.NUM_MOVANT%TYPE,
                                 SN_COD_RETORNO       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_MENS_RETORNO      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 SN_NUM_EVENTO        OUT NOCOPY ge_errores_pg.evento );

END VE_PLANES_ADICIONALES_PG;
/
