CREATE OR REPLACE PACKAGE PV_OBTIENEINFO_ATLANTIDA_PG IS
--------------------------------------------------------------------------------------------------------------------------------------------------------
CV_codmodulo         CONSTANT VARCHAR2(2) := 'GA';
CV_codmodulo_venta   CONSTANT VARCHAR2(2) := 'VE';
CV_error_no_clasif       CONSTANT VARCHAR2(30) := 'Error no Clasificado';
CN_cliente_es_atl        CONSTANT NUMBER := 1;
CN_cliente_noes_atl  CONSTANT NUMBER := 0;
CN_producto              CONSTANT NUMBER := 1;
CV_cp_ind                CONSTANT VARCHAR2(6) := '10020';
CV_cp_fam                CONSTANT VARCHAR2(6) := '10029';
CV_cp_emp                CONSTANT VARCHAR2(6) := '10022';
----------------------------------------------------------
PROCEDURE PV_RECUPERA_LIMITES_PR(
    EN_num_abonado  IN GA_ABOCEL.num_abonado%TYPE,
    ET_nummovimiento IN ICC_MOVIMIENTO.num_movimiento%TYPE,
    SV_LimiteMax     OUT NOCOPY VARCHAR2,
    SV_LimiteEmp     OUT NOCOPY VARCHAR2,
    SV_LimiteUsu  OUT NOCOPY VARCHAR2,

    SN_cod_retorno    OUT NOCOPY GE_ERRORES_PG.CodError,
    SV_mens_retorno   OUT NOCOPY GE_ERRORES_PG.MsgError,
    SN_num_evento     OUT NOCOPY GE_ERRORES_PG.Evento
       );

--------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION  PV_IMP_CARGOBASICO_FN       (ET_cod_plantarif  IN  TA_PLANTARIF.COD_PLANTARIF%TYPE,
              ST_ImpCargoBasico OUT TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE
) RETURN BOOLEAN;

--------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION  PV_OBTIENE_SCORING_FN       (ET_num_ident    IN  GE_CLIENTES.NUM_IDENT%TYPE,
              ET_cod_tipident IN  GE_CLIENTES.COD_TIPIDENT%TYPE,
              SN_calificacion OUT NOCOPY ERT_SOLICITUD.MTO_RENTA%TYPE
) RETURN BOOLEAN;

--------------------------------------------------------------------------------------------------------------------------------------------------------


FUNCTION  PV_IMP_LIMCONSUMO_FN       (EN_num_abonado    IN  GA_ABOCEL.NUM_ABONADO%TYPE,
             ST_imp_limconsumo OUT TOL_LIMITE_TD.IMP_LIMITE%TYPE
) RETURN BOOLEAN;

--------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION  PV_CALCULA_IMPTO_FN       (EN_valor  IN  NUMBER
) RETURN NUMBER;

--------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION PV_OBTIENE_PARAM_VISTA_FN (EV_cod_modulo IN VARCHAR2,
         EV_nom_parametro IN VARCHAR2 ) RETURN VARCHAR2;

--------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION PV_CLIENTE_EXCEPCION_FN(ET_num_ident    IN GE_CLIENTES.NUM_IDENT%TYPE,
          ET_cod_tipident IN  GE_CLIENTES.COD_TIPIDENT%TYPE
         ) RETURN BOOLEAN;

--------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION PV_CLIENTEESATLANTIDA_FN(
       ET_COD_CLIENTE  in ga_abocel.COD_CLIENTE%type
) RETURN NUMBER;

--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_RECUPERA_EMAIL_PR(
    EN_num_abonado IN ga_abocel.num_abonado%TYPE,
    SV_email  OUT NOCOPY GE_CLIENTES.nom_email%TYPE,
    SN_cod_retorno    OUT NOCOPY GE_ERRORES_PG.CodError,
    SV_mens_retorno   OUT NOCOPY GE_ERRORES_PG.MsgError,
    SN_num_evento     OUT NOCOPY GE_ERRORES_PG.Evento
       );

--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_EXISTEABOATLANTIDA_PR(
    EN_num_abonado IN GA_ABOCEL.num_abonado%TYPE,
    SV_existeabo OUT NOCOPY VARCHAR2,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       );
--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_RECUPERAIDEMP_PR(
    EN_num_abonado IN ga_abocel.num_abonado%TYPE,
    SN_cliente  OUT NOCOPY NUMBER,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       );
--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENEFECHARES_PR(
    EN_num_abonado IN ga_abocel.num_abonado%TYPE,
    SN_fechares  OUT NOCOPY NUMBER,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       );

--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENEREPRES_PR(
    EN_num_abonado IN ga_abocel.num_abonado%TYPE,
    SV_nombreresp OUT NOCOPY VARCHAR2,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       );

--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_EXISTEABOATLANTIDA2_PR(
    EN_num_abonado IN ga_abocel.num_abonado%TYPE,
    SV_existeabo OUT NOCOPY VARCHAR2,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       );

--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_INSERTAMOV_ATL_PR(
      EN_num_abonado IN GA_ABOCEL.num_abonado%TYPE,
    EN_plan_destino IN GA_ABOCEL.cod_plantarif%TYPE,
    EN_cod_cliente  IN  GA_ABOCEL.cod_cliente%TYPE,
    EV_param  IN  VARCHAR2,
    SV_insertook OUT NOCOPY NUMBER,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       );

--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENESERVICIO_ATL_PR(
    EN_plan_destino   IN  GA_ABOCEL.cod_plantarif%TYPE,
    SV_SERVICIO       OUT NOCOPY varchar2,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       );

--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_CADENASERV_ATLANTIDA_PR(
    SV_ServAtlantida OUT NOCOPY VARCHAR2
       );
--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_ESCAMBIOPLAN_ATL_PR(
    EN_num_movimiento IN  ICC_MOVIMIENTO.num_movimiento%TYPE,
    SV_existeooss     OUT NOCOPY NUMBER,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       );

--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_INS_MOV_BAJATL_PR (
    EN_num_movimiento  IN icc_movimiento.NUM_MOVIMIENTO%TYPE,
        EV_cod_modulo      IN icc_movimiento.COD_MODULO%TYPE,
        EV_cod_cliente     IN icc_movimiento.NUM_CELULAR_NUE%TYPE,
        EV_atlantida       IN icc_movimiento.PARAM1_MENS%TYPE,
        EV_codplantarif    IN icc_movimiento.PLAN%TYPE,
        EV_cod_tecnologia  IN icc_movimiento.TIP_TECNOLOGIA%TYPE,
        EV_error           IN OUT NOCOPY VARCHAR2
                 );


PROCEDURE PV_INS_MOV_CAMNOMCL_PR (
    EN_num_movimiento  IN icc_movimiento.NUM_MOVIMIENTO%TYPE,
        EV_cod_modulo      IN icc_movimiento.COD_MODULO%TYPE,
        EV_cod_cliente     IN icc_movimiento.NUM_CELULAR_NUE%TYPE,
        EV_error           IN OUT NOCOPY VARCHAR2
                );

PROCEDURE PV_ins_mov_atlan_PR(
        EN_num_abonado  IN icc_movimiento.num_abonado%TYPE,
        EV_cod_actabo   IN icc_movimiento.cod_actabo%TYPE,
        EN_carga                IN icc_movimiento.carga%TYPE,
        EV_num_os               IN icc_movimiento.cod_pin%TYPE,
        SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
        SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
        SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento);

END PV_OBTIENEINFO_ATLANTIDA_PG;
/
SHOW ERRORS
