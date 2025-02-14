CREATE OR REPLACE PACKAGE aip_consultas_mask_pg
IS
   TYPE refcursor IS REF CURSOR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE aip_consultaestados_pr (
      testado      OUT NOCOPY   refcursor,
      sv_retorno   OUT NOCOPY   VARCHAR2
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE aip_consultatecnologia_pr (
      ttecnologia   OUT NOCOPY   refcursor,
      sv_retorno    OUT NOCOPY   VARCHAR2
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE aip_consultasersuplement_pr (
      tsersupl     OUT NOCOPY   refcursor,
      sv_retorno   OUT NOCOPY   VARCHAR2
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE aip_consultaapiqos_pr (
      ev_vigencia   IN              aip_qos_to.vigencia%TYPE,
      tapiqos       OUT NOCOPY      refcursor,
      sv_retorno    OUT NOCOPY      VARCHAR2
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE aip_consultacompqos_pr (
      sc_conqos    OUT NOCOPY   refcursor,
      sv_retorno   OUT NOCOPY   VARCHAR2
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE aip_consultaapiapn_pr (
      ev_vigencia   IN              aip_apn_to.vigencia%TYPE,
      sc_apiapn     OUT NOCOPY      refcursor,
      sv_retorno    OUT NOCOPY      VARCHAR2
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE aip_consultaestadoip_pr (
      sc_estadoip   OUT NOCOPY   refcursor,
      sv_retorno    OUT NOCOPY   VARCHAR2
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE aip_consultarangosip_pr (
      en_cod_rangoip      IN              aip_rangoipta_to.cod_rangoip%TYPE,
      ev_cod_tecnologia   IN              aip_rangoipta_to.cod_tecnologia%TYPE,
      en_cod_apn          IN              aip_rangoipta_to.cod_apn%TYPE,
      ev_fecha_desde      IN              VARCHAR2,
      ev_fecha_hasta      IN              VARCHAR2,
      en_octeto_ini_1     IN              aip_rangoipta_to.octeto_ini_1%TYPE,
      en_octeto_ini_2     IN              aip_rangoipta_to.octeto_ini_2%TYPE,
      en_octeto_ini_3     IN              aip_rangoipta_to.octeto_ini_3%TYPE,
      en_octeto_ini_4     IN              aip_rangoipta_to.octeto_ini_4%TYPE,
      en_octeto_fin_1     IN              aip_rangoipta_to.octeto_fin_1%TYPE,
      en_octeto_fin_2     IN              aip_rangoipta_to.octeto_fin_2%TYPE,
      en_octeto_fin_3     IN              aip_rangoipta_to.octeto_fin_3%TYPE,
      en_octeto_fin_4     IN              aip_rangoipta_to.octeto_fin_4%TYPE,
      sc_rangosip         OUT NOCOPY      refcursor,
      sv_retorno          OUT NOCOPY      VARCHAR2
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE aip_consultaips_pr (
      ev_cod_tecnologia   IN              aip_ip_to.cod_tecnologia%TYPE,
      en_cod_apn          IN              aip_ip_to.cod_apn%TYPE,
      ev_fecha_desde      IN              VARCHAR2,
      ev_fecha_hasta      IN              VARCHAR2,
      en_octeto_ini_1     IN              aip_ip_to.octeto_1%TYPE,
      en_octeto_ini_2     IN              aip_ip_to.octeto_2%TYPE,
      en_octeto_ini_3     IN              aip_ip_to.octeto_3%TYPE,
      en_octeto_ini_4     IN              aip_ip_to.octeto_4%TYPE,
      en_octeto_fin_1     IN              aip_ip_to.octeto_1%TYPE,
      en_octeto_fin_2     IN              aip_ip_to.octeto_2%TYPE,
      en_octeto_fin_3     IN              aip_ip_to.octeto_3%TYPE,
      en_octeto_fin_4     IN              aip_ip_to.octeto_4%TYPE,
      sc_ips              OUT NOCOPY      refcursor,
      sv_retorno          OUT NOCOPY      VARCHAR2
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE aip_consultaipshis_pr (
      en_cod_apn         IN              aip_ip_th.cod_apn%TYPE,
      en_num_celular     IN              aip_ip_th.num_celular%TYPE,
      en_cod_estado_ip   IN              aip_ip_th.cod_estado_ip%TYPE,
      ev_fecha_desde     IN              VARCHAR2,
      ev_fecha_hasta     IN              VARCHAR2,
      en_octeto_ini_1    IN              aip_ip_th.octeto_1%TYPE,
      en_octeto_ini_2    IN              aip_ip_th.octeto_2%TYPE,
      en_octeto_ini_3    IN              aip_ip_th.octeto_3%TYPE,
      en_octeto_ini_4    IN              aip_ip_th.octeto_4%TYPE,
      en_octeto_fin_1    IN              aip_ip_th.octeto_1%TYPE,
      en_octeto_fin_2    IN              aip_ip_th.octeto_2%TYPE,
      en_octeto_fin_3    IN              aip_ip_th.octeto_3%TYPE,
      en_octeto_fin_4    IN              aip_ip_th.octeto_4%TYPE,
      sc_ipshis          OUT NOCOPY      refcursor,
      sv_retorno         OUT NOCOPY      VARCHAR2
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE aip_consultadisponibilizar_pr (
      ev_cod_tecnologia     IN              aip_rangoipta_to.cod_tecnologia%TYPE,
      en_cod_apn            IN              aip_rangoipta_to.cod_apn%TYPE,
      ev_formato_fecha      IN              VARCHAR2,
      ev_fecha_movimiento   IN              VARCHAR2,
      ev_disponibilizar     IN              VARCHAR2,
      sc_disponibilizarip   OUT NOCOPY      refcursor,
      sv_retorno            OUT NOCOPY      VARCHAR2
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE aip_consultavigencia_pr (
      sc_vigencia   OUT NOCOPY   refcursor,
      sv_retorno    OUT NOCOPY   VARCHAR2
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE aip_consultaTipoIp_pr (
      sc_TipoIp   OUT NOCOPY   refcursor,
      sv_retorno    OUT NOCOPY   VARCHAR2
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END aip_consultas_mask_pg; 
/
SHOW ERRORS