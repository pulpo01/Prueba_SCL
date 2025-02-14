CREATE OR REPLACE PACKAGE FA_GENERAL_PG
IS
   TYPE refcursor IS REF CURSOR;
   GV_cod_modulo  CONSTANT VARCHAR2 (2) := 'GA';
   GV_cod_trana   CONSTANT VARCHAR2 (4) := 'ROAM';
   GV_cod_tipo    CONSTANT VARCHAR2 (7) := 'CODLLAM';
   GV_nom_tabla   CONSTANT VARCHAR2 (11):= 'SCH_CODIGOS';
   GV_local      CONSTANT VARCHAR2 (5) := 'LOCAL';
   GV_especial    CONSTANT VARCHAR2 (8) := 'ESPECIAL';
   GV_interzona   CONSTANT VARCHAR2 (9) := 'INTERZONA';
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION fa_recupera_cicloperactual_fn (
      EN_ciclo       IN    fa_ciclfact.cod_ciclo%TYPE,
      SN_cod_ciclfact    OUT  NOCOPY fa_ciclfact.cod_ciclfact%TYPE,
      SN_cod_retorno      OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno     OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
      SN_num_evento       OUT   NOCOPY ge_errores_pg.Evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------
   FUNCTION fa_valida_ciclo_fn (
      EN_cod_ciclfact       IN    fa_ciclfact.cod_ciclfact%TYPE,
      SN_cod_retorno      OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno     OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
      SN_num_evento       OUT   NOCOPY ge_errores_pg.Evento
   )
      RETURN BOOLEAN;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION fa_cons_tablas_enlacehist_fn (
      en_cod_ciclfact    IN              fa_enlacehist.cod_ciclfact%TYPE,
      sv_fa_detcelular   OUT NOCOPY      fa_enlacehist.fa_detcelular%TYPE,
      sv_fa_detroaming   OUT NOCOPY      fa_enlacehist.fa_detroaming%TYPE,
      sv_fa_histdocu     OUT NOCOPY      fa_enlacehist.fa_histdocu%TYPE,
      sv_fa_histconc     OUT NOCOPY      fa_enlacehist.fa_histconc%TYPE,
      sn_cod_tipalmac    OUT NOCOPY      fa_enlacehist.cod_tipalmac%TYPE,
      sn_ind_tasador     OUT NOCOPY      fa_enlacehist.ind_tasador%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION fa_datos_documento_fn (
      en_cod_cliente      IN              fa_histdocu.cod_cliente%TYPE,
      en_cod_ciclfact     IN              fa_histdocu.cod_ciclfact%TYPE,
      sn_num_folio        OUT NOCOPY      fa_histdocu.num_folio%TYPE,
      sn_ind_ordentotal   OUT NOCOPY      fa_histdocu.ind_ordentotal%TYPE,
      sn_num_proceso      OUT NOCOPY      fa_histdocu.num_proceso%TYPE,
      sn_num_secuenci     OUT NOCOPY      fa_histdocu.num_secuenci%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION fa_cons_llamadas_locales_fn (
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      en_cod_ciclfact   IN              fa_ciclfact.cod_ciclfact%TYPE,
      en_tip_factura    IN              NUMBER,
      sc_cur_llam       OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION fa_cons_llamadas_especiales_fn (
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      en_cod_ciclfact   IN              fa_ciclfact.cod_ciclfact%TYPE,
      en_tip_factura    IN              NUMBER,
      sc_cur_llam       OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION fa_cons_llamadas_interzona_fn (
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      en_cod_ciclfact   IN              fa_ciclfact.cod_ciclfact%TYPE,
      en_tip_factura    IN              NUMBER,
      sc_cur_llam       OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION fa_cons_llamadas_roaming_fn (
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      en_cod_ciclfact   IN              fa_ciclfact.cod_ciclfact%TYPE,
      en_tip_factura    IN              NUMBER,
      sc_cur_llam       OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION fa_recupera_ciclo_fact_fn (
--      en_cod_cliente    IN              ga_cliente_pcom.cod_plancom%TYPE,
      sn_cod_ciclfact   OUT NOCOPY      fa_ciclfact.cod_ciclfact%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

----------------------------------------------------------------------------------------------------------------------------

   FUNCTION fa_valida_ciclo_vig_fn (
--      en_cod_cliente    IN              ga_cliente_pcom.cod_plancom%TYPE,
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      en_cod_ciclfact   IN              fa_ciclfact.cod_ciclfact%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_datos_basicosabonando_fn (
      en_num_celular      IN              ga_abocel.num_celular%TYPE,
      en_num_abonado      IN              ga_abocel.num_abonado%TYPE,
      sn_cod_cliente      OUT NOCOPY      ga_abocel.cod_cliente%TYPE,
      sn_num_abonado      OUT NOCOPY      ga_abocel.num_abonado%TYPE,
      sn_cod_ciclo        OUT NOCOPY      ga_abocel.cod_ciclo%TYPE,
      sv_tip_terminal     OUT NOCOPY      ga_abocel.tip_terminal%TYPE,
      sn_cod_central      OUT NOCOPY      ga_abocel.cod_central%TYPE,
      sv_cod_estado       OUT NOCOPY      ga_abocel.cod_estado%TYPE,
      sv_num_serie        OUT NOCOPY      ga_abocel.num_serie%TYPE,
      sv_num_imei         OUT NOCOPY      ga_abocel.num_imei%TYPE,
      sv_cod_tecnologia   OUT NOCOPY      ga_abocel.cod_tecnologia%TYPE,
      sv_num_min          OUT NOCOPY      ga_abocel.num_min%TYPE,
      sv_num_imsi         OUT NOCOPY      VARCHAR2,
      sd_fec_activacion   OUT NOCOPY      ga_abocel.fec_activacion%TYPE,
      sv_tip_abonado      OUT NOCOPY      VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION fa_version_fn
      RETURN VARCHAR2;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END fa_general_pg;
/
SHOW ERRORS