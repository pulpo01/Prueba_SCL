CREATE OR REPLACE PACKAGE al_folios_pg AS
     
CV_anulada CONSTANT        AL_SOLFOLIOS_TO.cod_estadosol%TYPE:='AN';
CV_version                 CONSTANT  VARCHAR2(5):='1.0';
CV_error_no_clasif         CONSTANT  VARCHAR2(30):='Error no clasificado';
CV_cod_modulo              CONSTANT  ged_parametros.cod_modulo%TYPE:='AL';
CN_largoquery              CONSTANT  NUMBER:=3000;
CN_largoerrtec             CONSTANT  NUMBER:=500;
CN_largodesc               CONSTANT  NUMBER:=1000;
CV_dd_mm_yyyy              CONSTANT  VARCHAR2(25):= 'dd/mm/yyyy';
CV_uno                     CONSTANT  NUMBER(1):=1;
CV_insertar                CONSTANT  varchar2(1):='I';
CV_modificar               CONSTANT  varchar2(1):='M';
CV_eliminar                CONSTANT  varchar2(1):='E';
TYPE    refcursor               IS         REF CURSOR;
------------------------------------------------------------------------
procedure AL_VALIDAR_FOLIOS_PR(
EN_num_solfolios    IN AL_SOLFOLIOS_TO.num_solfolios%TYPE,
EN_cod_tipdocum     IN AL_SOLFOLIOS_TO.cod_tipdocum%TYPE,
EV_resolucion       IN AL_SOLFOLIOS_TO.resolucion%TYPE,
EV_fec_resolucion   IN VARCHAR2,
EV_serie            IN AL_SOLFOLIOS_TO.serie%TYPE,
EV_etiqueta         IN AL_SOLFOLIOS_TO.etiqueta%TYPE,
EN_inicio_rango     IN AL_SOLFOLIOS_TO.rango_desde%TYPE,
EN_fin_rango        IN AL_SOLFOLIOS_TO.rango_hasta%TYPE,
EV_operadora        IN AL_SOLFOLIOS_TO.cod_operadora%TYPE,
EV_accion           IN varchar2,
SN_num_solfolios    OUT NOCOPY AL_SOLFOLIOS_TO.num_solfolios%TYPE,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------
procedure AL_INS_SOLFOLIOS_PR (
EV_cod_oficina      IN AL_SOLFOLIOS_TO.cod_oficina%TYPE,
EV_cod_opera        IN AL_SOLFOLIOS_TO.cod_operadora%TYPE,
EN_cod_tipdocum     IN AL_SOLFOLIOS_TO.cod_tipdocum%TYPE,
EV_resolucion       IN AL_SOLFOLIOS_TO.resolucion%TYPE,
EV_fec_resolucion   IN varchar2,
EV_serie            IN AL_SOLFOLIOS_TO.serie%TYPE,
EV_etiqueta         IN AL_SOLFOLIOS_TO.etiqueta%TYPE,
EN_inicio_rango     IN AL_SOLFOLIOS_TO.rango_desde%TYPE,
EN_fin_rango        IN AL_SOLFOLIOS_TO.rango_HASTA%TYPE,
EV_cod_estado       IN AL_SOLFOLIOS_TO.cod_estadosol%TYPE,
EV_usuario_crea     IN AL_SOLFOLIOS_TO.usuario_crea%TYPE,
SN_num_solfolios    OUT NOCOPY AL_SOLFOLIOS_TO.num_solfolios%TYPE,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------
procedure AL_UPD_SOLFOLIOS_PR (
EN_num_solfolios  IN AL_SOLFOLIOS_TO.num_solfolios%TYPE,
EN_cod_tipdocum   IN AL_SOLFOLIOS_TO.cod_tipdocum%TYPE,
EV_cod_oficina    IN AL_SOLFOLIOS_TO.cod_oficina%TYPE,
EV_resolucion     IN AL_SOLFOLIOS_TO.resolucion%TYPE,
EV_fec_resolucion IN VARCHAR2,
EV_serie          IN AL_SOLFOLIOS_TO.serie%TYPE,
EV_etiqueta       IN AL_SOLFOLIOS_TO.etiqueta%TYPE,
EN_inicio_rango   IN AL_SOLFOLIOS_TO.rango_desde%TYPE,
EN_fin_rango      IN AL_SOLFOLIOS_TO.rango_hasta%TYPE,
EV_cod_estado     IN AL_SOLFOLIOS_TO.cod_estadosol%TYPE,
EV_usuario        IN AL_SOLFOLIOS_TO.usuario_crea%TYPE,
EV_observacion    IN AL_SOLFOLIOS_TO.observacion %TYPE,
EV_accion         IN VARCHAR2,
EV_cod_operadora  IN AL_SOLFOLIOS_TO.cod_operadora%TYPE,
EV_fec_creafolio  IN VARCHAR2,
EV_pref_plaza     IN AL_ASIG_DOCUMENTOST.pref_plaza%TYPE,
EV_tipofol        IN VARCHAR2,
SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------
procedure AL_DEL_SOLFOLIOS_PR (
EN_num_solfolios  IN AL_SOLFOLIOS_TO.num_solfolios%TYPE,
SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------
procedure AL_INS_TIPOS_DOCINF_PR (
EV_cod_tipdocum_inf  IN AL_TIPOS_DOCINF_TD.COD_TIPDOCUM_INF%TYPE,
EV_desc_docum        IN AL_TIPOS_DOCINF_TD.DESC_DOCUM%TYPE,
EV_usuario           IN AL_TIPOS_DOCINF_TD.USUARIO_CREA%TYPE,
SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

------------------------------------------------------------------------
procedure AL_DEL_TIPOS_DOCINF_PR (
EV_cod_tipdocum_inf  IN AL_TIPOS_DOCINF_TD.COD_TIPDOCUM_INF%TYPE,
SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------
procedure AL_UPD_TIPOS_DOCINF_PR (
EV_cod_tipdocum_inf  IN AL_TIPOS_DOCINF_TD.COD_TIPDOCUM_INF%TYPE,
EV_desc_docum        IN AL_TIPOS_DOCINF_TD.DESC_DOCUM%TYPE,
EV_usuario           IN AL_TIPOS_DOCINF_TD.USUARIO_CREA%TYPE,
SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------
procedure AL_INS_RELDOCINF_PR (
EV_cod_tipdocum_inf IN AL_REL_DOCINF_TD.COD_TIPDOCUM_INF%TYPE,
EN_cod_tipdocum     IN AL_REL_DOCINF_TD.COD_TIPDOCUM%TYPE,
EV_usuario          IN AL_REL_DOCINF_TD.USUARIO_CREA%TYPE,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------
procedure AL_DEL_RELDOCINF_PR (
EV_cod_tipdocum_inf IN AL_REL_DOCINF_TD.COD_TIPDOCUM_INF%TYPE,
EN_cod_tipdocum     IN AL_REL_DOCINF_TD.COD_TIPDOCUM%TYPE,
SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------
procedure AL_VALIDAR_DOCINF_PR(
EV_cod_tipdocum_inf  IN AL_TIPOS_DOCINF_TD.COD_TIPDOCUM_INF%TYPE,
EV_desc_docum        IN AL_TIPOS_DOCINF_TD.DESC_DOCUM%TYPE,
EV_accion            in varchar2,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------
procedure AL_VALIDAR_RELDOCINF_PR(
EV_cod_tipdocum_inf IN AL_REL_DOCINF_TD.COD_TIPDOCUM_INF%TYPE,
EN_cod_tipdocum     IN AL_REL_DOCINF_TD.COD_TIPDOCUM%TYPE,
EV_accion            in varchar2,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------
procedure AL_INS_CONS_DOCCONSUMIDO_PR (
EV_usuario          IN AL_CONS_FOLIOS_TO.nom_usuario%TYPE,
EV_observacion      IN AL_CONS_FOLIOS_TO.observacion%TYPE,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------
PROCEDURE AL_OBTFOLIO_GUIA_PR (
EN_cod_bodega       IN al_series.cod_bodega%TYPE,
EV_operadora        IN varchar2,
SN_consume          OUT NOCOPY number,
SV_num_folio        OUT NOCOPY varchar2,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------
END al_folios_pg;
/
SHOW ERROR