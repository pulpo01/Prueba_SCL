CREATE OR REPLACE PACKAGE EBZ_SISCEL.NP_ACTIVACION_TARJETAS_PG IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : ACT_TARJETAS_PG
-- * Descripcion        : Activacion de Tarjetas Rascas
-- * Fecha de creacion  : 27-07-2004
-- * Responsable        : Logistica
-- *************************************************************
     CV_cod_modulo CONSTANT GE_PROCESOS_TD.cod_modulo%TYPE := 'VE';
         CV_cod_modulo1 CONSTANT GE_PROCESOS_TD.cod_modulo%TYPE := 'NP';
         CV_cod_modulo2 CONSTANT GE_PROCESOS_TD.cod_modulo%TYPE := 'AL';
         CI_zero CONSTANT PLS_INTEGER :=0;
         CI_uno CONSTANT PLS_INTEGER :=1;
         VG_ind_accion NP_RANGO_SERIES_TO.ind_accion%TYPE;

  PROCEDURE NP_OBTNIENE_PEDIDOS_PR;

  PROCEDURE NP_GENERA_RANGOS_PEDIDOS_PR (TN_cod_pedido IN NPT_DETALLE_PEDIDO.cod_pedido%TYPE,
                                                             TN_lin_det_pedido IN NPT_DETALLE_PEDIDO.lin_det_pedido%TYPE,
                                                                 TN_cod_articulo IN NPT_DETALLE_PEDIDO.cod_articulo%TYPE,
                                                                 OI_ERROR OUT PLS_INTEGER);

  PROCEDURE NP_GENERA_RANGOS_DEVOLUCION_PR (IV_cadenaparametro  IN     VARCHAR2,
                                                                                        OV_tabla                OUT VARCHAR2,
                                                                                        OV_accion                       OUT VARCHAR2,
                                                                                        OV_sqlcode                      OUT VARCHAR2,
                                                                                        OV_sqlerrm                      OUT VARCHAR2);

  PROCEDURE NP_INSERTAR_AL_ERRORES_WEB_PR(V_ERRORES IN AL_ERRORES_WEB%ROWTYPE, CN_fin_cola IN PLS_INTEGER );

  PROCEDURE NP_HISTORICO_RANGOS_SERIES_PR;

END NP_ACTIVACION_TARJETAS_PG; 
/

