CREATE OR REPLACE PACKAGE BP_PROMOCIONES_QUIOSCO_PG IS
-- *************************************************************
-- * Paquete            : BP_PROMOCIONES_QUIOSCO_PG
-- * Descripción        : Funciones y procedimientos de Beneficios y Promociones
-- * Fecha de creación  : Enero 2003
-- * F. de Homologacion : Agosto 2003
-- * Responsable        : Beneficios y Promociones SCL
-- *************************************************************

-- Declaracion de Variables Globales
   TYPE vCursor IS REF CURSOR;
   CV_tipmonepromo CONSTANT varchar2(2):='7';  -- Tipo de monedero para Promociones
-- Inicio especificacion PL/SQL

TYPE r_datos IS RECORD (r_codcampana BP_CAMPANAS_TD.cod_campana%TYPE,
                        r_descampana BP_CAMPANAS_TD.des_campana%TYPE,
                         r_codtiplan BP_CAMPANAS_TD.cod_tiplan%TYPE,
                         r_indefault BP_CAMPANAS_TD.ind_default%TYPE);

TYPE t_campanas IS TABLE OF r_datos;


PROCEDURE BP_INSERTA_GA_ERRORES_PR (p_vcod_actabo       IN GA_ERRORES.COD_ACTABO%TYPE,
                                p_ncod_cliente          IN GA_ERRORES.CODIGO%TYPE,
                                p_vcod_producto         IN GA_ERRORES.COD_PRODUCTO%TYPE,
                                p_vnom_proc             IN GA_ERRORES.NOM_PROC%TYPE,
                                p_vnom_tabla            IN GA_ERRORES.NOM_TABLA%TYPE,
                                p_vcod_act              IN GA_ERRORES.COD_ACT%TYPE,
                                p_vcod_sqlcode          IN GA_ERRORES.COD_SQLCODE%TYPE,
                                p_vcod_sqlerrm          IN GA_ERRORES.COD_SQLERRM%TYPE);

PROCEDURE BP_PROMOCION_OMISION_PR (p_nnum_transaccion   IN NUMBER,
                                p_nnum_abonado          IN GA_ABOAMIST.NUM_ABONADO%TYPE,
                                p_vcod_asignacion       IN BPD_PLANES.COD_ASIGNACION%TYPE,
                                p_vcod_tiplan           IN BPD_PLANES.COD_TIPLAN%TYPE,
                                p_cind_asignacion       IN CHAR,
                                p_cind_procequi         IN BP_PARAM_PREPAGO_TD.IND_PROCEQUI%TYPE,
                                p_ncod_canal            IN BP_PARAM_PREPAGO_TD.COD_CANAL%TYPE,
                                p_nnum_movimiento       IN ICC_MOVIMIENTO.num_movimiento%TYPE,
                                p_cind_recarga_aplicada IN CHAR);

PROCEDURE BP_INS_CONTROL_PROCESOS_PR (p_vnom_archivolog IN BP_CONTROL_PROCESOS_TO.NOM_ARCHIVOLOG%TYPE,
                                p_dfec_iniproceso       IN BP_CONTROL_PROCESOS_TO.FEC_INIPROCESO%TYPE,
                                p_vnom_funcion          IN BP_CONTROL_PROCESOS_TO.NOM_FUNCION%TYPE,
                                p_vdes_control          IN BP_CONTROL_PROCESOS_TO.DES_CONTROL%TYPE,
                                p_dfec_control          IN BP_CONTROL_PROCESOS_TO.FEC_CONTROL%TYPE,
                                p_nnum_nivellog         IN BP_CONTROL_PROCESOS_TO.NUM_NIVELLOG%TYPE,
                                p_nnum_registros        IN BP_CONTROL_PROCESOS_TO.NUM_REGISTROS%TYPE,
                                p_vind_error            IN BP_CONTROL_PROCESOS_TO.IND_ERROR%TYPE,
                                p_vcod_planpromocion    IN BP_CONTROL_PROCESOS_TO.COD_PLANPROMOCION%TYPE,
                                p_vnom_usuario          IN BP_CONTROL_PROCESOS_TO.NOM_USUARIO%TYPE);

PROCEDURE BP_REGISTRA_PROMOCION_PR (p_nnum_transaccion  IN NUMBER,
                                p_vcod_plan             IN BPD_PLANES.COD_PLAN%TYPE,
                                p_dfec_desdeapli        IN VARCHAR2,
                                p_ncod_cliente          IN BPT_BENEFICIARIOS.COD_CLIENTE%TYPE,
                                p_nnum_abonado          IN BPT_BENEFICIARIOS.NUM_ABONADO%TYPE,
                                p_cind_asignacion       IN CHAR,
                                p_nnum_movimiento       IN ICC_MOVIMIENTO.num_movimiento%TYPE,
                                p_cind_recarga_aplicada IN CHAR
								);

FUNCTION BP_PROMOCIONES_EXISTENTES_FN(p_vcod_asignacion IN BPD_PLANES.COD_ASIGNACION%TYPE,
                                p_ncod_cliente          IN BPT_BENEFICIARIOS.COD_CLIENTE%TYPE,
                                p_nnum_abonado          IN BPT_BENEFICIARIOS.NUM_ABONADO%TYPE,
                                p_cind_existente        IN CHAR,
                                p_vcod_tiplan           IN BPD_PLANES.COD_TIPLAN%TYPE) RETURN VARCHAR2;

FUNCTION BP_PROMOCIONES_EXISTEN_SAC_FN(p_ncod_cliente   IN BPT_BENEFICIARIOS.COD_CLIENTE%TYPE,
                                p_nnum_abonado          IN BPT_BENEFICIARIOS.NUM_ABONADO%TYPE,
                                p_cind_existente        IN CHAR,
                                p_vcod_tiplan           IN BPD_PLANES.COD_TIPLAN%TYPE) RETURN VARCHAR2;

PROCEDURE BP_REGISTRA_CAMPANA_PR (p_vcod_campana        IN BP_CAMPANAS_TD.COD_CAMPANA%TYPE,
                                p_ncod_cliente          IN BPT_BENEFICIARIOS.COD_CLIENTE%TYPE,
                                p_nnum_abonado          IN BPT_BENEFICIARIOS.NUM_ABONADO%TYPE,
                                p_cind_asignacion       IN CHAR);

FUNCTION BP_PROMOCION_OMISION_FN (p_nnum_abonado        IN GA_ABOAMIST.NUM_ABONADO%TYPE,
                                p_vcod_asignacion       IN BPD_PLANES.COD_ASIGNACION%TYPE,
                                p_vcod_tiplan           IN BPD_PLANES.COD_TIPLAN%TYPE) RETURN VARCHAR2;

PROCEDURE BP_UPD_RECARGA_PREPAGO_PR; -- Sin parametros

PROCEDURE BP_CANCELA_PROMOCION_VTA_PR (p_nnum_transaccion IN NUMBER,
                                p_ncod_cliente            IN BPT_BENEFICIARIOS.COD_CLIENTE%TYPE,
                                p_nnum_abonado            IN GA_ABOAMIST.NUM_ABONADO%TYPE);

PROCEDURE BP_APLICA_RECARGA_ICC_PR (p_vcod_plan         IN BPD_PLANES.COD_PLAN%TYPE,
                                p_dfec_desdeapli        IN VARCHAR2,
                                p_nnum_abonado          IN BPT_BENEFICIARIOS.NUM_ABONADO%TYPE,
                                p_nmto_cargadic         IN BPD_PLANES.MTO_CARGADIC%TYPE,
								p_ncod_tiplan 			IN BPD_PLANES.COD_TIPLAN%TYPE );

FUNCTION BP_MTOARTICULO_FN (p_vcod_articulo             IN BP_BENEF_ARTICULO_TD.COD_ARTICULO%TYPE,
                            p_dfec_beneficio            IN BP_BENEF_ARTICULO_TD.FEC_DESDEVIGE%TYPE ) RETURN NUMBER;

FUNCTION BP_LLENA_NTIP_FN(p_vcod_param IN VARCHAR2) RETURN NUMBER;

FUNCTION BP_UPD_CARGA_MASIVA_FN(p_ncod_transaccion IN BP_CARGA_MASIVA_TO.COD_TRANSACCION%TYPE,
                                p_ncod_cliente     IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                p_nnum_celular     IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                p_nnum_abonado     IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                p_ncod_clicte      IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                p_dfec_desdeapli   IN BPD_PLANES.FEC_DESDEAPLI%TYPE,
                                p_dfec_hastaapli   IN BPD_PLANES.FEC_HASTAAPLI%TYPE,
                                p_ncod_error       IN BP_CARGA_MASIVA_TO.COD_ERROR%TYPE ) RETURN NUMBER;

FUNCTION BP_ASIGNA_BENEFICIOS_FN(p_ncod_cliente     IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                 p_nnum_abonado     IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                 p_nnum_ident       IN GE_CLIENTES.NUM_IDENT%TYPE,
                                 p_dfec_desdeapli   IN BPD_PLANES.FEC_DESDEAPLI%TYPE,
                                 p_vcind_reevalua   IN BPD_PLANES.IND_REEVALUA%TYPE,
                                 p_vcod_plan        IN BPD_PLANES.COD_PLAN%TYPE) RETURN NUMBER;

PROCEDURE BP_VALIDA_CARGA_PR(p_nnum_celular  IN     GA_ABOCEL.NUM_CELULAR%TYPE,
                            p_vcod_tiplan    IN     BPD_PLANES.COD_TIPLAN%TYPE,
                            p_vtip_beneficio IN     BPD_PLANES.TIP_BENEFICIO%TYPE,
                            p_vcod_plan      IN     BPD_PLANES.COD_PLAN%TYPE,
                            p_dfec_desdeapli IN     BPD_PLANES.FEC_DESDEAPLI%TYPE,
							p_ncod_cliente   IN OUT GA_ABOCEL.COD_CLIENTE%TYPE,
                            p_nnum_abonado   OUT    GA_ABOCEL.NUM_ABONADO%TYPE,
							p_nretorno       OUT    BP_CARGA_MASIVA_TO.COD_ERROR%TYPE);

PROCEDURE BP_CARGA_MASIVA_PR(p_ncod_transaccion  IN BP_CARGA_MASIVA_TO.COD_TRANSACCION%TYPE);

PROCEDURE BP_ASIGNA_BENEFICIOS_PR(p_ncod_transaccion  IN BP_CARGA_MASIVA_TO.COD_TRANSACCION%TYPE);

PROCEDURE BP_DEL_TMP_CARGA_MASIVA_PR(p_ncod_transaccion  IN BP_CARGA_MASIVA_TO.COD_TRANSACCION%TYPE);

PROCEDURE BP_CREAJOB_TMP_PR(p_ntransaccion IN NUMBER);

PROCEDURE BP_MULTIIDIOMA_TOL_DESC_PR(p_vcodcategdcto IN TOL_DESCUENTO_TD.COD_DCTO%TYPE,
                                     p_vdescategdcto IN TOL_DESCUENTO_TD.GLS_DCTO%TYPE,
                                     p_vtipcategdcto IN TOL_DESCUENTO_TD.TIP_DCTO%TYPE);

PROCEDURE BP_ACTUALIZA_BENEFICIOS_PR (p_nnum_transaccion      IN NUMBER,
                                      p_nnum_abonado          IN GA_ABOAMIST.NUM_ABONADO%TYPE,
                                      p_num_movimiento_alta   IN ICC_MOVIMIENTO.num_movimiento%TYPE,
                                      p_num_movimiento_carga  IN ICC_MOVIMIENTO.num_movimiento%TYPE);

/*PROCEDURE BP_RECUPERA_PROMOCIONES_PR(p_vcod_asignacion IN BPD_PLANES.COD_ASIGNACION%TYPE,
                                     p_ncod_cliente    IN BPT_BENEFICIARIOS.COD_CLIENTE%TYPE,
                                     p_nnum_abonado    IN BPT_BENEFICIARIOS.NUM_ABONADO%TYPE,
                                     p_cind_existente  IN CHAR,
                                     p_vcod_tiplan     IN BPD_PLANES.COD_TIPLAN%TYPE,
									 p_vCursor		   OUT vCursor,
									 p_iError		   OUT NUMBER);*/

PROCEDURE BP_RECUPERA_PROMOCIONES_PR(p_vcod_asignacion IN VARCHAR2,
                                     p_ncod_cliente    IN VARCHAR2,
                                     p_nnum_abonado    IN VARCHAR2,
                                     p_cind_existente  IN CHAR,
                                     p_vcod_tiplan     IN VARCHAR2,
									 p_vCursor		   OUT vCursor,
									 Error			   OUT VARCHAR2
									 );

PROCEDURE BP_OBTENER_BENEFICIOS_PR (v_tipidentidad     IN          BP_CAMPANAS_TD.TIP_ENTIDAD%TYPE,
                                    v_codtiplan        IN          BP_CAMPANAS_TD.COD_TIPLAN%TYPE,
                                    p_beneficios      OUT NOCOPY   vCursor,
                                    SN_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento     OUT NOCOPY   ge_errores_pg.evento
);


-- Fin especificacion PL/SQL
END BP_PROMOCIONES_QUIOSCO_PG;
/
SHOW ERRORS