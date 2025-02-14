CREATE OR REPLACE PACKAGE Pv_Consultas_Portal_Pg
AS
   gv_error_others        CONSTANT NUMBER                            := '156';
   gv_error_no_clasif     CONSTANT VARCHAR2 (100)                    := 'Error no Clasificado';
   gn_largoerrtec         CONSTANT NUMBER (3)                        := 500;
   gn_largodesc           CONSTANT NUMBER (3)                        := 100;
   gv_cod_modulo          CONSTANT VARCHAR2 (2)                      := 'GA';
   GV_TIP_SUJETO_CUENTA   CONSTANT VARCHAR2 (1)                      := 'R';
   GV_TIP_INTER_CUENTA    CONSTANT NUMBER (1)                        := 5;
   GV_TIP_SUJETO_CLIENTE  CONSTANT VARCHAR2 (1)                      := 'C';
   GV_TIP_INTER_CLIENTE   CONSTANT NUMBER (1)                        := 8;
   GV_TIP_SUJETO_ABONADO  CONSTANT VARCHAR2 (1)                      := 'A';
   GV_TIP_INTER_ABONADO   CONSTANT NUMBER (1)                        := 1;
   GV_TIP_TERMINAL        CONSTANT VARCHAR2 (1)                      := 'T';
   GV_TIP_SIM             CONSTANT VARCHAR2 (1)                      := 'G';
   GV_COD_PRODUCTO        CONSTANT NUMBER (1)                        := 1;
   GV_COD_TIPDOCUM_CERO   CONSTANT NUMBER (1)                        := 0;
   GV_cod_pragrama        CONSTANT VARCHAR2 (3)                      := 'PWE';
   GV_cod_aplicacion      CONSTANT VARCHAR2 (3)                      := 'PVA';
   gv_package             CONSTANT VARCHAR2 (50)                     := 'Pv_Consultas_Portal_Pg.';
   TYPE refcursor IS REF CURSOR;

------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_OOSS_X_USUARIO_PR(
    EV_NOM_USUARIO                IN  GA_USUARIOS.NOM_USUARIO%TYPE,
    SC_BLOQ_OOSS                 OUT NOCOPY REFCURSOR,
    SV_NOM_OPERADOR                 OUT NOCOPY GE_SEG_USUARIO.NOM_OPERADOR%TYPE,
    SV_DES_OFICINA                 OUT NOCOPY GE_OFICINAS.DES_OFICINA%TYPE,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );

------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_CUENTA_DETALLE_PR(
    EN_COD_CUENTA                   IN  GA_CUENTAS.COD_CUENTA%TYPE,
    SC_BLOQ_CUENTA               OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_CLIENTE_DETALLE_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_CANT_ABON_CLIENTE_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );

------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_ABONADO_DETALLE_PR(
    EN_NUM_ABONADO               IN  GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_DIRECCION_DETALLE_PR(
    EN_COD_DIRECCION               IN  GE_DIRECCIONES.COD_DIRECCION%TYPE,
    EN_COD_TIPDIRECCION          IN  GE_TIPDIRECCION.COD_TIPDIRECCION%TYPE,
    SC_BLOQ_DIRECCION            OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
-----------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_EQUISIM_DETALLE_PR(
    EN_NUM_ABONADO               IN  GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );

------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_CONS_GRILLA_CUENTA_X_COD_PR(
    EN_COD_CUENTA                   IN  GA_CUENTAS.COD_CUENTA%TYPE,
    SC_BLOQ_CUENTA              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_CUENTA_X_DES_PR(
    EN_DES_CUENTA                   IN  GA_CUENTAS.DES_CUENTA%TYPE,
    SC_BLOQ_CUENTA               OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_CUENTA_X_IDE_PR(
    EN_NUM_IDENT                   IN  GA_CUENTAS.NUM_IDENT%TYPE,
    SC_BLOQ_CUENTA               OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );

------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_CLIE_X_CUEN_PR(
    EN_COD_CUENTA                   IN  GE_CLIENTES.COD_CUENTA%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_CLIE_X_COD_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );

------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_CLIE_X_NOM_PR(
    EN_NOM_CLIENTE               IN  GE_CLIENTES.NOM_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
----------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_ABO_X_CEL_PR(
    EN_NUM_CELULAR               IN  GA_ABOCEL.NUM_CELULAR%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
----------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_ABO_X_CLI_PR(
    EN_COD_CLIENTE                IN  GA_ABOCEL.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
----------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_DIR_X_CLI_PR(
    EN_COD_CLIENTE                IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
----------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_FAC_X_CLI_PR(
    EN_COD_CLIENTE                IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
----------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_CC_X_CLI_PR(
    EN_COD_CLIENTE                IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
----------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_PAGOS_X_CLI_PR(
    EN_COD_CLIENTE                IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
----------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_AJUSTE_X_CLI_PR(
    EN_COD_CLIENTE                IN GE_CLIENTES.COD_CLIENTE%TYPE,
    EN_COD_TIPDOCUM              IN CO_AJUSTES.COD_TIPDOCUM%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
----------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_OS_X_CUENTA_PR(
    EN_COD_CUENTA                IN GA_CUENTAS.COD_CUENTA%TYPE,
    SC_BLOQ_CUENTA                OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
----------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_OS_X_CLIENTE_PR(
    EN_COD_CLIENTE                IN GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
----------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_OS_X_ABON_PR(
    EN_NUM_ABONADO                IN GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
----------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_SS_X_ABON_PR(
    EN_NUM_ABONADO                IN GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
---------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_BP_X_ABON_PR(
    EN_COD_CLIENTE                IN GA_ABOCEL.COD_CLIENTE%TYPE,
    EN_NUM_ABONADO                IN GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
---------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_LC_X_ABON_PR(
    EN_COD_CLIENTE                IN GA_ABOCEL.COD_CLIENTE%TYPE,
    EN_NUM_ABONADO                IN GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
  ---------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_PLC_X_ABON_PR(
    EN_COD_CLIENTE                IN GA_ABOCEL.COD_CLIENTE%TYPE,
    EN_NUM_ABONADO                IN GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
---------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_DETLLAM_X_PR(
    EN_COD_CLIENTE                IN GA_ABOCEL.COD_CLIENTE%TYPE,
    EN_NUM_ABONADO                IN GA_ABOCEL.NUM_ABONADO%TYPE,
    EN_COD_CICLFACT                 IN  FA_HISTDOCU.COD_CICLFACT%TYPE,
    EN_TIPO_LLAMADA              IN  GED_CODIGOS.DES_VALOR%TYPE,
  SC_BLOQ_LLAMADAS             OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
---------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_DEUDA_CLIENTE_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SN_MONTO_DEUDA               OUT NOCOPY NUMBER,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
---------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_DOC_FACT_X_CLI_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    EV_FEC_INI                   IN VARCHAR2,
    EV_FEC_FIN                   IN VARCHAR2,
    EV_FORMATO_FEC               IN VARCHAR2,
    SC_DOC_CLIENTE               OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
---------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_DOC_PAGOS_X_CLI_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    EV_FEC_INI                   IN VARCHAR2,
    EV_FEC_FIN                   IN VARCHAR2,
    EV_FORMATO_FEC               IN VARCHAR2,
    SC_DOC_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
---------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_DOC_AJUSTES_X_CLI_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    EV_FEC_INI                   IN VARCHAR2,
    EV_FEC_FIN                   IN VARCHAR2,
    EV_FORMATO_FEC               IN VARCHAR2,
    SC_DOC_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
---------------------------------------------------------------------------------------------------------------------------
/*PROCEDURE PV_CONS_SS_X_CLIENTE_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_SERVSUPL                 OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO);*/
-------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_PLANES_X_CLIENTE_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_PLANES              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
-------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cons_cbplan_clte_pr(
    EN_num_os                     ci_orserv.num_os%TYPE,
    SC_datcamplan                 OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    );
-------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cons_cbplan_abo_pos_pr(
    EN_num_os                     ci_orserv.num_os%TYPE,
    SC_datcamplan                 OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    );
-------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cons_plan_abo_pr(
    EN_num_abonado                 ga_abocel.num_abonado%TYPE,
    SC_datosplan                 OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    );
-------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cons_ss_abo_pr(
    EN_num_abonado                 ga_abocel.num_abonado%TYPE,
    SC_datosSS                      OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    );
-------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cons_detalle_plan_pr(
    EV_cod_plantarif             ta_plantarif.cod_plantarif%TYPE,
    SC_detplan                     OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    );
-------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cons_ss_defplan_x_abo_pr(
    EN_num_abonado                  ga_abocel.num_abonado%TYPE,
    SC_servsup                     OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    );
-------------------------------------------------------------------------------------------------------------------------
/*PROCEDURE pv_cons_ss_defplan_x_cli_pr(
    EN_cod_cliente                  IN ge_clientes.cod_cliente%TYPE,
    SC_servsup                     OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    );*/
--------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cons_numfrec_plan_pr(
    EN_num_abonado                  ga_abocel.num_abonado%TYPE,
    SC_numfrec                     OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    );
-------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_graba_traza_usr_pr(EV_cod_evento     ga_traza_usuario_to.cod_evento%TYPE,
                                  EV_nom_usuario     ga_traza_usuario_to.nom_usuario%TYPE,
                                EN_num_celular     ga_abocel.num_celular%TYPE,
                                EN_num_abonado     ga_abocel.num_abonado%TYPE,
                                EN_cod_cliente     ga_abocel.cod_cliente%TYPE,
                                EN_cod_cuenta     ga_abocel.cod_cuenta%TYPE,
                                SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cons_seg_grupo_pr(EV_nom_usuario            ge_seg_grpusuario.nom_usuario%TYPE,
                                 SC_grupos                 OUT NOCOPY REFCURSOR,
                                SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.evento

 );
-------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cons_perfil_segur_pr(EV_cod_grupo       ge_seg_perfiles.cod_grupo%TYPE,
                                  EV_cod_programa       ge_seg_perfiles.cod_programa%TYPE,
                                EN_num_version       ge_seg_perfiles.num_version%TYPE,
                                  SC_perfil           OUT NOCOPY REFCURSOR,
                                SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.evento
                                  );
-------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_valida_verfactura_pr(EN_cod_cliente       ge_clientes.cod_cliente%TYPE,
                                  EN_ind_ordentotal         fa_histdocu.num_secuenci%TYPE,
                                SN_cod_retorno          OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento           OUT NOCOPY ge_errores_pg.evento
                                  );
-------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cons_cbplan_abo_pre_pr(
    EN_num_os                     ci_orserv.num_os%TYPE,
    SC_datcamplan                 OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    );

-------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_TIPO_SUSPENSION_PR(
    SC_BLOQ_TIP_SUSP              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );

-------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_TIPO_SINIESTRO_PR(
    SC_BLOQ_TIP_SINI              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );

-------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_CAUSA_SINIESTRO_PR(
    SC_BLOQ_CAU_SINI              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
------------------------------------------------------------------------------------------------------------
PROCEDURE pv_obtiene_ooss_agendadas_pr(en_num_dato          NUMBER,
                                         en_tip_dato          NUMBER,
                                       sc_ooss_agendada     OUT NOCOPY refcursor,
                                       sn_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                       sv_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                       sn_cod_resultado        OUT NOCOPY NUMBER
);
------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cons_ooss_proceso_pr(ev_nom_usuario     IN pv_iorserv.usuario%TYPE,
                                  sn_cod_resultado   OUT NOCOPY NUMBER
);
------------------------------------------------------------------------------------------------------------
PROCEDURE pv_obtiene_ooss_proceso_pr(ev_nom_usuario   IN  pv_iorserv.usuario%TYPE,
                                     sc_ooss_proceso  OUT NOCOPY refcursor
);
------------------------------------------------------------------------------------------------------------
PROCEDURE pv_obtiene_ss_por_ooss_pr (en_num_os          IN pv_camcom.num_os%TYPE,
                                     sc_ss_ooss         OUT NOCOPY refcursor,
                                     sn_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                     sv_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                     sn_num_evento      OUT NOCOPY ge_errores_pg.evento
);
------------------------------------------------------------------------------------------------------------
PROCEDURE pv_inserta_comentario_pr( EV_comentario           CI_ORSERV.COMENTARIO%TYPE,
                                    EN_num_os               CI_ORSERV.NUM_OS%TYPE,
                                    SN_cod_retorno          OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento           OUT NOCOPY ge_errores_pg.evento
);
------------------------------------------------------------------------------------------------------------
PROCEDURE pv_insert_pv_iorserv_pr( EV_comentario           PV_IORSERV.COMENTARIO%TYPE,
                                               EN_num_os               PV_IORSERV.NUM_OS%TYPE,
                                               SN_cod_retorno          OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                               SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                               SN_num_evento           OUT NOCOPY ge_errores_pg.evento
);


--KVV 09-11-2010 RA-MIX-10008
PROCEDURE pv_cons_seg_grupo_pr(EV_nom_usuario            ge_seg_grpusuario.nom_usuario%TYPE,
                                EV_COD_PROGRAMA           GE_PROGRAMAS.COD_PROGRAMA%TYPE,
                                SC_grupos                 OUT NOCOPY REFCURSOR,
                                SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.evento);
PROCEDURE pv_obtiene_dominio_pr(EV_cod_ooss      GED_PARAMETROS.NOM_PARAMETRO%TYPE,
                                SV_dominio_ooss  OUT NOCOPY GED_PARAMETROS.VAL_PARAMETRO%TYPE,
                                SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.evento

 );
 
PROCEDURE PV_OBTIENE_CAMPOS_DIR_PR ( SC_CAMPOS_DIR      OUT NOCOPY REFCURSOR,
                                     SN_COD_RETORNO     OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                     SV_MENS_RETORNO    OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                     SN_NUM_EVENTO      OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_OBTIENE_DIR_POR_CLIENTE_PR ( EV_COD_CLIENTE       IN  VARCHAR2,
                                          EN_TIP_SUJETO        IN  GE_DIRPARAOPERAD.TIP_SUJETO%TYPE,   
                                          EN_COD_TIPDIRECCION  IN  NUMBER,
                                          EN_COD_DISPLAY       IN  GE_DIRPARAOPERAD.COD_DISPLAY%TYPE,
                                          SV_DIRECCION         OUT NOCOPY VARCHAR2,
                                          SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                          SV_MENS_RETORNO      OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                          SN_NUM_EVENTO        OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_OBTIENE_ESTADOS_PR ( SC_ESTADOS_DIR     OUT NOCOPY REFCURSOR,
                                  SN_COD_RETORNO     OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                  SV_MENS_RETORNO    OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                  SN_NUM_EVENTO      OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_OBTIENE_PUEBLO_POR_EST_PR ( EV_COD_ESTADO        IN  GE_PUEBLOS.COD_ESTADO%TYPE,
                                         SC_PUEBLOS_DIR       OUT NOCOPY REFCURSOR,
                                         SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                         SV_MENS_RETORNO      OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                         SN_NUM_EVENTO        OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_OBTIENE_TIPO_CALLE_PR (SC_CALLES_DIR        OUT NOCOPY REFCURSOR,
                                    SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO      OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO        OUT NOCOPY GE_ERRORES_PG.EVENTO
);


PROCEDURE PV_OBTIENE_ZIP_CODE_PR ( EV_COD_ZONA          IN  GE_ZIPCODE_TD.COD_ZONA%TYPE,
                                   SC_ZIPCODE_DIR       OUT NOCOPY REFCURSOR,
                                   SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                   SV_MENS_RETORNO      OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                   SN_NUM_EVENTO        OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_OBTIENE_PARAM_ZIP_CODE_PR ( SV_PARAM_ZIPCODE     OUT NOCOPY GED_PARAMETROS.VAL_PARAMETRO%TYPE,
                                         SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                         SV_MENS_RETORNO      OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                         SN_NUM_EVENTO        OUT NOCOPY GE_ERRORES_PG.EVENTO
);

END Pv_Consultas_Portal_Pg;
/

SHOW ERRORS