CREATE OR REPLACE PACKAGE AL_DEVOLUCIONKIT_PG IS
                 /* package con procedimientos y funciones para proyecto devoluvión de kit sin desvilcular
                    version 1.0
                    modificaciones:.--->  */
--

PROCEDURE P_INSERTASERIE_PR (
IV_cadenaparametro   IN VARCHAR2,
OV_tabla                OUT VARCHAR2,
OV_accion                       OUT VARCHAR2,
OV_sqlcode                      OUT VARCHAR2,
OV_sqlerrm                      OUT VARCHAR2);

--
PROCEDURE   P_INSERTAMOVIMIENTO_PR(
RW_movim                        IN al_movimientos%ROWTYPE,
OV_tabla                IN OUT VARCHAR2,
OV_accion                       IN OUT VARCHAR2,
OV_sqlcode                      IN OUT VARCHAR2,
OV_sqlerrm                      IN OUT VARCHAR2);

--
PROCEDURE   P_INSERTATRASPASO_PR(
RW_trasp IN al_traspasos_masivo%ROWTYPE,
OV_tabla                IN OUT VARCHAR2,
OV_accion                       IN OUT VARCHAR2,
OV_sqlcode                      IN OUT VARCHAR2,
OV_sqlerrm                      IN OUT VARCHAR2);

--
PROCEDURE   P_CAMBIOESTADO_PR(
TS_serie          IN al_series.num_Serie%TYPE,
TI_cod_Estado IN al_estados.cod_estado%TYPE);

--
FUNCTION P_OBTIENECATARTICULO_FN(
IV_tipterminal   IN al_articulos.tip_terminal%TYPE,
IV_indequiacc   IN al_articulos.ind_equiacc%TYPE          ) RETURN VARCHAR2;

--
PROCEDURE P_PMPARTICULO_PR(
IN_cod_articulo IN    al_articulos.cod_articulo%TYPE,
ON_precio          OUT   number,
OV_tabla        IN OUT   VARCHAR2,
OV_accion          IN OUT        VARCHAR2,
OV_sqlcode         IN OUT        VARCHAR2,
OV_sqlerrm         IN OUT        VARCHAR2 );

--
PROCEDURE P_OBTIENEMOVIMIENTO_PR(
IN_MOVIM       IN OUT    al_movimientos.num_movimiento%type,
OV_tabla       IN OUT    VARCHAR2,
OV_accion          IN OUT        VARCHAR2,
OV_sqlcode         IN OUT        VARCHAR2,
OV_sqlerrm         IN OUT    VARCHAR2);

--
PROCEDURE P_OBTIENEPRECIOKIT_PR(
-- Inicio : XO-200510160888  Responsable cambio: Zenen Muñoz H.  fecha: 17-10-2005  Desc.: Cambio de tipo de datos de number a number (14,4)*
IN_PRECIOUNIDAD       IN OUT    al_series.prc_compra%TYPE,
-- Fin incidencia: XO-200510160888
TV_numkit             IN        al_Series.num_Serie%type,
OV_tabla       IN OUT    VARCHAR2,
OV_accion          IN OUT        VARCHAR2,
OV_sqlcode         IN OUT        VARCHAR2,
OV_sqlerrm         IN OUT    VARCHAR2);

--
PROCEDURE P_OBTIENEHLR_PR(
TV_hlr         IN OUT       al_movimientos.cod_hlr%type,
TV_simcard     IN                       al_series.num_Serie%type,
OV_tabla       IN OUT    VARCHAR2,
OV_accion          IN OUT        VARCHAR2,
OV_sqlcode         IN OUT        VARCHAR2,
OV_sqlerrm         IN OUT    VARCHAR2);

--
PROCEDURE P_ESNUMERADO_PR(
IV_celular     IN           varchar2,
TV_subalm      IN OUT           ga_celnum_uso.cod_subalm%type,
TV_central     IN OUT           ga_celnum_uso.cod_central%type,
TV_cat         IN OUT           ga_celnum_uso.cod_cat%type,
OV_tabla       IN OUT           VARCHAR2,
OV_accion          IN OUT           VARCHAR2,
OV_sqlcode         IN OUT           VARCHAR2,
OV_sqlerrm         IN OUT       VARCHAR2);

--
PROCEDURE P_MOVIMCAMESTA_PR(
TV_param        IN OUT          ged_parametros.val_parametro%type,
TV_nompara6     IN          ged_parametros.nom_parametro%TYPE,
CV_cod_modulo   IN          VARCHAR,
CI_cod_producto IN                      INTEGER   ,
OV_tabla        IN OUT          VARCHAR2,
OV_accion           IN OUT          VARCHAR2,
OV_sqlcode          IN OUT          VARCHAR2,
OV_sqlerrm          IN OUT      VARCHAR2);

--
PROCEDURE P_OBTIENEDATOSTRASPASO_PR(
TV_serie                 IN             al_series.num_serie%TYPE,
TI_bod_ori           IN OUT     al_bodegas.cod_bodega%TYPE,
TI_uso_tras          IN OUT     al_series.cod_uso%type,
TV_est_tras          IN OUT             al_series.cod_estado%type  ,
TN_prc_unidad            IN OUT     al_series.prc_compra%type,
OV_tabla                 IN OUT         VARCHAR2,
OV_accion                IN OUT     VARCHAR2,
OV_sqlcode               IN OUT     VARCHAR2,
OV_sqlerrm               IN OUT      VARCHAR2);

--
PROCEDURE P_OBTIENENUMTRASPASOMASIVO_PR(
TV_num_trasM   IN OUT    al_traspasos_masivo.num_traspaso_masivo%type,
OV_tabla       IN OUT    VARCHAR2,
OV_accion          IN OUT        VARCHAR2,
OV_sqlcode         IN OUT        VARCHAR2,
OV_sqlerrm         IN OUT    VARCHAR2);

--
PROCEDURE P_OBTIENENUMEROTRASPASO_PR(
TV_num_tras    IN OUT    al_traspasos_masivo.num_traspaso%type,
OV_tabla       IN OUT    VARCHAR2,
OV_accion          IN OUT        VARCHAR2,
OV_sqlcode         IN OUT        VARCHAR2,
OV_sqlerrm         IN OUT    VARCHAR2);

--
PROCEDURE P_OBTIENEPLAZA_PR(
IV_cod_bodega    IN     al_bodegas.cod_bodega%type,
OV_cod_plaza    IN OUT    al_series.cod_plaza%type,
OV_tabla       IN OUT    VARCHAR2,
OV_accion          IN OUT        VARCHAR2,
OV_sqlcode         IN OUT        VARCHAR2,
OV_sqlerrm         IN OUT    VARCHAR2);

--
END AL_DEVOLUCIONKIT_PG;
/
SHOW ERRORS
