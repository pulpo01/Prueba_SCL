CREATE OR REPLACE PACKAGE GA_SERV911CORREOFAX_PG
IS
   TYPE refcursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CV_PARAM_SS911          CONSTANT VARCHAR2 (20) := 'SS_ASISTENCIA_911';
   CV_PARAM_SSFAX          CONSTANT VARCHAR2 (20) := 'SS_FAX';
   CV_SS_FAX               CONSTANT VARCHAR2(25) := 'SS_FAX';
   CV_Modulo_GA  CONSTANT VARCHAR2(2) := 'GA';
   CN_Producto   CONSTANT NUMBER(1) := 1;
   CN_altaservBD CONSTANT NUMBER(1) := 1;
   CN_Err_Cli CONSTANT NUMBER(3) := 149;
   CN_Err_Usuario CONSTANT NUMBER(7) := 300008;
   CV_Err_NoClasif VARCHAR2(25) := 'Error no Clasificado';
   CV_REPONE_CELULAR    CONSTANT VARCHAR(1)   := 'R';  --Indica reposición de numero celular
   CV_REPONE_CEL_RES    CONSTANT VARCHAR(1)   := 'S';  --Indica reposición de num celular reservado
-------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE GA_INSERT_GACONTACTO_PR (   EN_NUM_ABONADO      IN   GA_ABOCEL.NUM_ABONADO%TYPE,
                                      EN_COD_SERVICIO     IN   GA_CONTACTO_ABONADO_TO.COD_SERVICIO%TYPE,
                                      EN_NUM_CONTACTO     IN   GA_CONTACTO_ABONADO_TO.NUM_CONTACTO%TYPE,
                                      EV_NOM_CONTACTO     IN   GA_CONTACTO_ABONADO_TO.NOMBRE_CONTACTO%TYPE,
                                      EV_APELLIDO         IN   GA_CONTACTO_ABONADO_TO.APELLIDO1_CONTACTO%TYPE,
                                      EV_APELLIDO2        IN   GA_CONTACTO_ABONADO_TO.APELLIDO2_CONTACTO%TYPE,
                                      EV_PARENTESCO       IN   GA_CONTACTO_ABONADO_TO.COD_PARENTESCO%TYPE,
                                      EN_COD_DIRECCION    IN   GA_CONTACTO_ABONADO_TO.COD_DIRECCION%TYPE,
                                      EV_PLACA_VEHICULAR  IN   GA_CONTACTO_ABONADO_TO.PLACA_VEHICULAR%TYPE,
                                      EV_COLOR_VEHICULO   IN   GA_CONTACTO_ABONADO_TO.COLOR_VEHICULO%TYPE,
                                      EV_ANIO_VEHICULO    IN   GA_CONTACTO_ABONADO_TO.ANIO_VEHICULO%TYPE,
                                      EV_OBSERVACION      IN   GA_CONTACTO_ABONADO_TO.OBSERVACION%TYPE,
                                      EV_NOM_USUARORA     IN   GA_CONTACTO_ABONADO_TO.NOM_USUAORA%TYPE,
                                      EN_NUM_TELEFONO     IN   GA_CONTACTO_ABONADO_TO.NUM_TELEFONO%TYPE,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento) ;

-------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GA_INSERT_CONTACTOABONADOTT_PR (EN_NUM_ABONADO         IN   PV_CONTACTO_ABONADO_TO.NUM_ABONADO%TYPE,
                                      EV_COD_SERVICIO        IN   PV_CONTACTO_ABONADO_TO.COD_SERVICIO%TYPE,
                                      EN_NUM_CONTACTO        IN   PV_CONTACTO_ABONADO_TO.NUM_CONTACTO%TYPE,
                                      EV_NOMBRE_CONTACTO     IN   PV_CONTACTO_ABONADO_TO.NOMBRE_CONTACTO%TYPE,
                                      EV_APELLIDO1_CONTACTO  IN   PV_CONTACTO_ABONADO_TO.APELLIDO1_CONTACTO%TYPE,
                                      EV_APELLIDO2_CONTACTO  IN   PV_CONTACTO_ABONADO_TO.APELLIDO2_CONTACTO%TYPE,
                                      EV_COD_PARENTESCO      IN   PV_CONTACTO_ABONADO_TO.COD_PARENTESCO%TYPE,
                                      EN_COD_DIRECCION       IN   PV_CONTACTO_ABONADO_TO.COD_DIRECCION%TYPE,
                                      EV_PLACA_VEHICULAR     IN   PV_CONTACTO_ABONADO_TO.PLACA_VEHICULAR%TYPE,
                                      EV_COLOR_VEHICULO      IN   PV_CONTACTO_ABONADO_TO.COLOR_VEHICULO%TYPE,
                                      EN_ANIO_VEHICULO       IN   PV_CONTACTO_ABONADO_TO.ANIO_VEHICULO%TYPE,
                                      EV_OBSERVACION         IN   PV_CONTACTO_ABONADO_TO.OBSERVACION%TYPE,
                                      EV_IND_VIGENTE         IN   PV_CONTACTO_ABONADO_TO.IND_VIGENTE%TYPE,
                                      EV_NOM_USUAORA         IN   PV_CONTACTO_ABONADO_TO.NOM_USUAORA%TYPE,
                                      EV_COD_PROVINCIA       IN   PV_CONTACTO_ABONADO_TO.COD_PROVINCIA%TYPE,
                                      EV_COD_REGION          IN   PV_CONTACTO_ABONADO_TO.COD_REGION%TYPE,
                                      EV_COD_CIUDAD          IN   PV_CONTACTO_ABONADO_TO.COD_CIUDAD%TYPE,
                                      EV_COD_COMUNA          IN   PV_CONTACTO_ABONADO_TO.COD_COMUNA%TYPE,
                                      EV_NOM_CALLE           IN   PV_CONTACTO_ABONADO_TO.NOM_CALLE%TYPE,
                                      EV_NUM_CALLE           IN   PV_CONTACTO_ABONADO_TO.NUM_CALLE%TYPE,
                                      EV_NUM_PISO            IN   PV_CONTACTO_ABONADO_TO.NUM_PISO%TYPE,
                                      EV_NUM_CASILLA         IN   PV_CONTACTO_ABONADO_TO.NUM_CASILLA%TYPE,
                                      EV_OBS_DIRECCION       IN   PV_CONTACTO_ABONADO_TO.OBS_DIRECCION%TYPE,
                                      EV_DES_DIREC1          IN   PV_CONTACTO_ABONADO_TO.DES_DIREC1%TYPE,
                                      EV_DES_DIREC2          IN   PV_CONTACTO_ABONADO_TO.DES_DIREC2%TYPE,
                                      EV_COD_PUEBLO          IN   PV_CONTACTO_ABONADO_TO.COD_PUEBLO%TYPE,
                                      EV_COD_ESTADO          IN   PV_CONTACTO_ABONADO_TO.COD_ESTADO%TYPE,
                                      EV_ZIP                 IN   PV_CONTACTO_ABONADO_TO.ZIP%TYPE,
                                      EV_COD_TIPOCALLE       IN   PV_CONTACTO_ABONADO_TO.COD_TIPOCALLE%TYPE,
                                       EN_NUM_TELEFONO       IN   PV_CONTACTO_ABONADO_TO.NUM_TELEFONO%TYPE,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------------------------------------------------
 PROCEDURE GA_GET_GACONTACTO_PR ( EN_num_abonado  IN   ga_contacto_abonado_to.num_abonado% TYPE,
                                                                     SC_cursordatos    OUT NOCOPY  REFCURSOR,
                                                                    SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                                    SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                                    SN_num_evento       OUT NOCOPY  ge_errores_pg.evento) ;

------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_GET_GACANTAC_GEDIRECC_PR ( EN_num_abonado  IN   ga_contacto_abonado_to.num_abonado% TYPE,
                                                                    EV_cod_servicio  IN   ga_contacto_abonado_to.cod_servicio% TYPE,
                                                                     SC_cursordatos    OUT NOCOPY  REFCURSOR,
                                                                    SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                                    SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                                    SN_num_evento       OUT NOCOPY  ge_errores_pg.evento) ;

------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GA_UPDATE_GACONTACTO_PR (   EN_NUM_ABONADO      IN   GA_ABOCEL.NUM_ABONADO%TYPE,
                                      EN_COD_SERVICIO     IN   GA_CONTACTO_ABONADO_TO.COD_SERVICIO%TYPE,
                                      EN_NUM_CONTACTO     IN   GA_CONTACTO_ABONADO_TO.NUM_CONTACTO%TYPE,
                                      EV_NOM_CONTACTO     IN   GA_CONTACTO_ABONADO_TO.NOMBRE_CONTACTO%TYPE,
                                      EV_APELLIDO         IN   GA_CONTACTO_ABONADO_TO.APELLIDO1_CONTACTO%TYPE,
                                      EV_APELLIDO2        IN   GA_CONTACTO_ABONADO_TO.APELLIDO2_CONTACTO%TYPE,
                                      EV_PARENTESCO       IN   GA_CONTACTO_ABONADO_TO.COD_PARENTESCO%TYPE,
                                      EN_COD_DIRECCION    IN   GA_CONTACTO_ABONADO_TO.COD_DIRECCION%TYPE,
                                      EV_PLACA_VEHICULAR  IN   GA_CONTACTO_ABONADO_TO.PLACA_VEHICULAR%TYPE,
                                      EV_COLOR_VEHICULO   IN   GA_CONTACTO_ABONADO_TO.COLOR_VEHICULO%TYPE,
                                      EV_ANIO_VEHICULO    IN   GA_CONTACTO_ABONADO_TO.ANIO_VEHICULO%TYPE,
                                      EV_OBSERVACION      IN   GA_CONTACTO_ABONADO_TO.OBSERVACION%TYPE,
                                      EV_NOM_USUARORA     IN   GA_CONTACTO_ABONADO_TO.NOM_USUAORA%TYPE,
                                      EV_IND_VIGENTE      IN   GA_CONTACTO_ABONADO_TO.IND_VIGENTE%TYPE,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DELETE_GACONTACTO_PR (  EN_NUM_ABONADO       IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                      EN_NUM_CONTACTO       IN GA_CONTACTO_ABONADO_TO.NUM_CONTACTO%TYPE,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_TRATAMIENTOSS_911FAX_PR (EN_NUM_ABONADO      IN  ga_abocel.NUM_ABONADO%TYPE,
                                      EV_USER             IN  VARCHAR2
                                      );
FUNCTION getNumFax_FN
                            (EN_numMovimiento IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
                            RETURN VARCHAR2;
FUNCTION IC_NUMEROFAX_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
PROCEDURE GA_UPDATE_FAX_PR        (   EN_NUM_ABONADO      IN   GA_ABOCEL.NUM_ABONADO%TYPE,
                                      EN_NUMFAX           IN   GA_DATABONADO_TO.NUM_FAX%TYPE,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento);


 PROCEDURE PV_CARGA_SS911_PR( EN_num_abonado  IN   ga_contacto_abonado_to.num_abonado% TYPE,
                              SC_cursordatos    OUT NOCOPY  REFCURSOR
                                                                   ) ;
 PROCEDURE PV_CARGO_REC911_PR( EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                               EO_COD_CLIENTE           IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                               EO_COD_PROD_CONTRA       IN              PR_PRODUCTOS_CONTRATADOS_TO.COD_PROD_CONTRATADO%TYPE,
                               EO_COD_CONCEPTO          IN              FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                               EO_NUM_ABONADO_PAGO      IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                               EO_COD_CLIENTE_PAGO      IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                               EO_COD_PLANSERV          IN              GA_ABOCEL.COD_PLANSERV%TYPE,
                               EO_IND_COBPRORRATEA      IN              NUMBER,
                               EO_COD_CARGO_PROD_CONTRA IN              FA_CARGOS_REC_TO.COD_CARGO_CONTRATADO%TYPE,
                               EO_FECHA_ALTA            IN              DATE,
                               EO_FECHA_BAJA            IN              DATE,
                               EO_USUARIO               IN              GA_ABOCEL.NOM_USUARORA%TYPE,
                               sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                               sn_num_evento            OUT NOCOPY      ge_errores_pg.evento);
 PROCEDURE PV_CARGO_DEL911_PR( EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                               EO_COD_CLIENTE           IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                               EO_COD_PROD_CONTRA       IN              PR_PRODUCTOS_CONTRATADOS_TO.COD_PROD_CONTRATADO%TYPE,
                               EO_COD_CONCEPTO          IN              FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                               EO_NUM_ABONADO_PAGO      IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                               EO_COD_CLIENTE_PAGO      IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                               EO_COD_PLANSERV          IN              GA_ABOCEL.COD_PLANSERV%TYPE,
                               EO_IND_COBPRORRATEA      IN              NUMBER,
                               EO_COD_CARGO_PROD_CONTRA IN              FA_CARGOS_REC_TO.COD_CARGO_CONTRATADO%TYPE,
                               EO_FECHA_ALTA            IN              DATE,
                               EO_FECHA_BAJA            IN              DATE,
                               EO_USUARIO               IN              GA_ABOCEL.NOM_USUARORA%TYPE,
                               sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                               sn_num_evento            OUT NOCOPY      ge_errores_pg.evento);

PROCEDURE PV_DELETE_GACONTACTO_PR (   EN_NUM_ABONADO       IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                      EV_COD_SERVICIO      IN GA_CONTACTO_ABONADO_TO.COD_SERVICIO%TYPE,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento);

PROCEDURE PV_DELETE_CONTACTOABONADOTT_PR (  EN_NUM_ABONADO       IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        EV_cod_servicio  IN   ga_contacto_abonado_to.cod_servicio% TYPE,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento);

END GA_SERV911CORREOFAX_PG;
/
SHOW ERRORS