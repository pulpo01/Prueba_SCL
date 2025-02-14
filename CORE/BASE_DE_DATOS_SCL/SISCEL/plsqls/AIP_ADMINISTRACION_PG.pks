CREATE OR REPLACE PACKAGE aip_administracion_pg
IS
    TYPE refcursor IS REF CURSOR;

    cn_uno                  CONSTANT PLS_INTEGER   := 1;
    cn_cero                 CONSTANT PLS_INTEGER   := 0;
    cn_maxocteto            CONSTANT PLS_INTEGER   := 255;
    cv_modulo               CONSTANT VARCHAR (2)   := 'IP';
    cv_estado_disponible    CONSTANT VARCHAR2 (20) := 'ESTADO_DISPONIBLE';
    cv_estado_eliminado     CONSTANT VARCHAR2 (20) := 'ESTADO_ELIMINADO';
    cv_estado_reservado     CONSTANT VARCHAR2 (20) := 'ESTADO_RESERVADO';
    cv_estado_asignado      CONSTANT VARCHAR2 (20) := 'ESTADO_USO';
    ln_cantidad                      PLS_INTEGER;
    cn_cod_producto         CONSTANT PLS_INTEGER   := 1;
    cv_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No Es Posible Recuperar Error Clasificado';
	cv_tabla                CONSTANT VARCHAR2(10)  := 'AIP_QOS_TO';
	cv_vigente 		        CONSTANT VARCHAR2(7)   := 'VIGENTE';
	cv_novigente 	        CONSTANT VARCHAR2(10)  := 'NO VIGENTE';
    ERROR_CONTROLADO        EXCEPTION;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_modificaparametro_pr (
        ev_nom_parametro    IN               ged_parametros.nom_parametro%TYPE,
        ev_val_parametro    IN               ged_parametros.val_parametro%TYPE,
        sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento       OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_ingresa_apn_pr (
        ev_des_apn           IN               aip_apn_to.des_apn%TYPE,
        en_tipo_ip           IN               aip_apn_to.tipo_ip%TYPE,
        ev_dns               IN               aip_apn_to.dns%TYPE,
        ev_vigencia          IN               aip_apn_to.vigencia%TYPE,
        en_cod_qos           IN               aip_apn_to.cod_qos%TYPE,
        en_cod_producto      IN               aip_apn_to.cod_producto%TYPE,
        ev_cod_servicio      IN               aip_apn_to.cod_servicio%TYPE,
        en_cod_tecnologia    IN               aip_apn_to.cod_tecnologia%TYPE,
        sn_cod_retorno       OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno      OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento        OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_modifica_apn_pr (
        en_cod_apn           IN               aip_apn_to.cod_apn%TYPE,
        ev_des_apn           IN               aip_apn_to.des_apn%TYPE,
        en_tipo_ip           IN               aip_apn_to.tipo_ip%TYPE,
        ev_dns               IN               aip_apn_to.dns%TYPE,
        ev_vigencia          IN               aip_apn_to.vigencia%TYPE,
        en_cod_qos           IN               aip_apn_to.cod_qos%TYPE,
        en_cod_producto      IN               aip_apn_to.cod_producto%TYPE,
        ev_cod_servicio      IN               aip_apn_to.cod_servicio%TYPE,
        en_cod_tecnologia    IN               aip_apn_to.cod_tecnologia%TYPE,
        sn_cod_retorno       OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno      OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento        OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_elimina_apn_pr (
        en_cod_apn         IN               aip_apn_to.cod_apn%TYPE,
        sn_cod_retorno     OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_ingresa_qos_pr (
        ev_componentes_qos    IN               aip_qos_to.componentes_qos%TYPE,
        ev_des_qos            IN               aip_qos_to.des_qos%TYPE,
        ev_vigencia           IN               aip_qos_to.vigencia%TYPE,
        en_eqosid             IN               aip_qos_to.eqosid%TYPE,
        sn_cod_retorno        OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno       OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento         OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_modifica_qos_pr (
        en_cod_qos            IN               aip_qos_to.cod_qos%TYPE,
        ev_componentes_qos    IN               aip_qos_to.componentes_qos%TYPE,
        ev_des_qos            IN               aip_qos_to.des_qos%TYPE,
        ev_vigencia           IN               aip_qos_to.vigencia%TYPE,
        en_eqosid             IN               aip_qos_to.eqosid%TYPE,
        sn_cod_retorno        OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno       OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento         OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_elimina_qos_pr (
        en_cod_qos         IN               aip_qos_to.cod_qos%TYPE,
        sn_cod_retorno     OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_ingresa_estado_pr (
        ev_des_estado_ip    IN               aip_estado_ip_to.des_estado_ip%TYPE,
        ev_vigencia         IN               aip_estado_ip_to.vigencia%TYPE,
        sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento       OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_modifica_estado_pr (
        en_cod_estado_ip    IN               aip_estado_ip_to.cod_estado_ip%TYPE,
        ev_des_estado_ip    IN               aip_estado_ip_to.des_estado_ip%TYPE,
        ev_vigencia         IN               aip_estado_ip_to.vigencia%TYPE,
        sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento       OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_elimina_estado_pr (
        en_cod_estado_ip    IN               aip_estado_ip_to.cod_estado_ip%TYPE,
        sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento       OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_ingresa_rangoip_pr (
        en_octeto_ini_1      IN               aip_rangoipta_to.octeto_ini_1%TYPE,
        en_octeto_ini_2      IN               aip_rangoipta_to.octeto_ini_2%TYPE,
        en_octeto_ini_3      IN               aip_rangoipta_to.octeto_ini_3%TYPE,
        en_octeto_ini_4      IN               aip_rangoipta_to.octeto_ini_4%TYPE,
        en_octeto_fin_1      IN               aip_rangoipta_to.octeto_fin_1%TYPE,
        en_octeto_fin_2      IN               aip_rangoipta_to.octeto_fin_2%TYPE,
        en_octeto_fin_3      IN               aip_rangoipta_to.octeto_fin_3%TYPE,
        en_octeto_fin_4      IN               aip_rangoipta_to.octeto_fin_4%TYPE,
        en_cod_apn           IN               aip_rangoipta_to.cod_apn%TYPE,
        ev_cod_tecnologia    IN               aip_rangoipta_to.cod_tecnologia%TYPE,
        eb_disponibilizar    IN               VARCHAR2,
        sn_cod_retorno       OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno      OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento        OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_modifica_rangoip_pr (
        en_cod_rangoip       IN               aip_rangoipta_to.cod_rangoip%TYPE,
        en_octeto_ini_1      IN               aip_rangoipta_to.octeto_ini_1%TYPE,
        en_octeto_ini_2      IN               aip_rangoipta_to.octeto_ini_2%TYPE,
        en_octeto_ini_3      IN               aip_rangoipta_to.octeto_ini_3%TYPE,
        en_octeto_ini_4      IN               aip_rangoipta_to.octeto_ini_4%TYPE,
        en_octeto_fin_1      IN               aip_rangoipta_to.octeto_fin_1%TYPE,
        en_octeto_fin_2      IN               aip_rangoipta_to.octeto_fin_2%TYPE,
        en_octeto_fin_3      IN               aip_rangoipta_to.octeto_fin_3%TYPE,
        en_octeto_fin_4      IN               aip_rangoipta_to.octeto_fin_4%TYPE,
        en_cod_apn           IN               aip_rangoipta_to.cod_apn%TYPE,
        ev_cod_tecnologia    IN               aip_rangoipta_to.cod_tecnologia%TYPE,
        eb_disponibilizar    IN               VARCHAR2,
        sn_cod_retorno       OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno      OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento        OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_elimina_rangoip_pr (
        en_cod_rangoip     IN               aip_rangoipta_to.cod_rangoip%TYPE,
        sn_cod_retorno     OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_disponibilizarip_pr (
        en_cod_rangoip      IN               aip_rangoipta_to.cod_rangoip%TYPE,
        en_cod_tipo_ip      IN               aip_ip_to.cod_tipo_ip%TYPE,
        en_cod_estado_ip    IN               aip_ip_to.cod_estado_ip%TYPE,
        sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento       OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_indisponibilizarip_pr (
        en_cod_rangoip     IN               aip_rangoipta_to.cod_rangoip%TYPE,
        sn_cod_retorno     OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_modifica_estadoips_pr (
        en_octeto_1         IN               aip_ip_to.octeto_1%TYPE,
        en_octeto_2         IN               aip_ip_to.octeto_2%TYPE,
        en_octeto_3         IN               aip_ip_to.octeto_3%TYPE,
        en_octeto_4         IN               aip_ip_to.octeto_4%TYPE,
        en_cod_estado_ip    IN               aip_ip_to.cod_estado_ip%TYPE,
        en_num_celular      IN               aip_ip_to.num_celular%TYPE,
        sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento       OUT NOCOPY       ge_errores_pg.evento
    );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_consultaestados_pr (
        testado            OUT NOCOPY    refcursor,
        sn_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY    ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_consultatecnologia_pr (
        ttecnologia        OUT NOCOPY    refcursor,
        sn_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY    ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_consultasersuplement_pr (
        tsersupl           OUT NOCOPY    refcursor,
        sn_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY    ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_consultaapiqos_pr (
        en_vigencia        IN               aip_qos_to.vigencia%TYPE,
        tapiqos            OUT NOCOPY       refcursor,
        sn_cod_retorno     OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_consultacompqos_pr (
        sc_conqos          OUT NOCOPY    refcursor,
        sn_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY    ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_consultaapiapn_pr (
        ev_vigencia        IN               aip_apn_to.vigencia%TYPE,
        sc_apiapn          OUT NOCOPY       refcursor,
        sn_cod_retorno     OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_consultaestadoip_pr (
        sc_estadoip        OUT NOCOPY    refcursor,
        sn_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY    ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_consultarangosip_pr (
        en_cod_rangoip       IN               aip_rangoipta_to.cod_rangoip%TYPE,
        ev_cod_tecnologia    IN               aip_rangoipta_to.cod_tecnologia%TYPE,
        en_cod_apn           IN               aip_rangoipta_to.cod_apn%TYPE,
        ev_fecha_desde       IN               VARCHAR2,
        ev_fecha_hasta       IN               VARCHAR2,
        en_octeto_ini_1      IN               aip_rangoipta_to.octeto_ini_1%TYPE,
        en_octeto_ini_2      IN               aip_rangoipta_to.octeto_ini_2%TYPE,
        en_octeto_ini_3      IN               aip_rangoipta_to.octeto_ini_3%TYPE,
        en_octeto_ini_4      IN               aip_rangoipta_to.octeto_ini_4%TYPE,
        en_octeto_fin_1      IN               aip_rangoipta_to.octeto_fin_1%TYPE,
        en_octeto_fin_2      IN               aip_rangoipta_to.octeto_fin_2%TYPE,
        en_octeto_fin_3      IN               aip_rangoipta_to.octeto_fin_3%TYPE,
        en_octeto_fin_4      IN               aip_rangoipta_to.octeto_fin_4%TYPE,
        sc_rangosip          OUT NOCOPY       refcursor,
        sn_cod_retorno       OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno      OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento        OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_consultaips_pr (
        ev_cod_tecnologia    IN               aip_ip_to.cod_tecnologia%TYPE,
        en_cod_apn           IN               aip_ip_to.cod_apn%TYPE,
        ev_fecha_desde       IN               VARCHAR2,
        ev_fecha_hasta       IN               VARCHAR2,
        en_octeto_ini_1      IN               aip_ip_to.octeto_1%TYPE,
        en_octeto_ini_2      IN               aip_ip_to.octeto_2%TYPE,
        en_octeto_ini_3      IN               aip_ip_to.octeto_3%TYPE,
        en_octeto_ini_4      IN               aip_ip_to.octeto_4%TYPE,
        en_octeto_fin_1      IN               aip_ip_to.octeto_1%TYPE,
        en_octeto_fin_2      IN               aip_ip_to.octeto_2%TYPE,
        en_octeto_fin_3      IN               aip_ip_to.octeto_3%TYPE,
        en_octeto_fin_4      IN               aip_ip_to.octeto_4%TYPE,
        sc_ips               OUT NOCOPY       refcursor,
        sn_cod_retorno       OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno      OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento        OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_consultaipshis_pr (
        en_cod_apn          IN               aip_ip_th.cod_apn%TYPE,
        en_num_celular      IN               aip_ip_th.num_celular%TYPE,
        en_cod_estado_ip    IN               aip_ip_th.cod_estado_ip%TYPE,
        ev_fecha_desde      IN               VARCHAR2,
        ev_fecha_hasta      IN               VARCHAR2,
        en_octeto_ini_1     IN               aip_ip_th.octeto_1%TYPE,
        en_octeto_ini_2     IN               aip_ip_th.octeto_2%TYPE,
        en_octeto_ini_3     IN               aip_ip_th.octeto_3%TYPE,
        en_octeto_ini_4     IN               aip_ip_th.octeto_4%TYPE,
        en_octeto_fin_1     IN               aip_ip_th.octeto_1%TYPE,
        en_octeto_fin_2     IN               aip_ip_th.octeto_2%TYPE,
        en_octeto_fin_3     IN               aip_ip_th.octeto_3%TYPE,
        en_octeto_fin_4     IN               aip_ip_th.octeto_4%TYPE,
        sc_ipshis           OUT NOCOPY       refcursor,
        sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento       OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_consultadisponibilizar_pr (
        ev_cod_tecnologia      IN               aip_rangoipta_to.cod_tecnologia%TYPE,
        en_cod_apn             IN               aip_rangoipta_to.cod_apn%TYPE,
        ed_fecha_movimiento    IN               aip_rangoipta_to.fecha_movimiento%TYPE,
        ev_disponibilizar      IN               VARCHAR2,
        sc_disponibilizarip    OUT NOCOPY       refcursor,
        sn_cod_retorno         OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno        OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento          OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_consultavigencia_pr (
        sc_vigencia        OUT NOCOPY    refcursor,
        sn_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY    ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_consultasolapamiento_pr (
        en_octeto_ini_1    IN               aip_rangoipta_to.octeto_ini_1%TYPE,
        en_octeto_ini_2    IN               aip_rangoipta_to.octeto_ini_2%TYPE,
        en_octeto_ini_3    IN               aip_rangoipta_to.octeto_ini_3%TYPE,
        en_octeto_ini_4    IN               aip_rangoipta_to.octeto_ini_4%TYPE,
        en_octeto_fin_1    IN               aip_rangoipta_to.octeto_fin_1%TYPE,
        en_octeto_fin_2    IN               aip_rangoipta_to.octeto_fin_2%TYPE,
        en_octeto_fin_3    IN               aip_rangoipta_to.octeto_fin_3%TYPE,
        en_octeto_fin_4    IN               aip_rangoipta_to.octeto_fin_4%TYPE,
        sn_solapamiento    OUT NOCOPY       NUMBER,
        sn_cod_retorno     OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_peticionip_pr (
        ev_cod_tecnologia    IN               aip_ip_to.cod_tecnologia%TYPE,
        en_cod_apn           IN               aip_ip_to.cod_apn%TYPE,
        en_tipo_ip           IN               aip_apn_to.tipo_ip%TYPE,
        en_cod_qos           IN               aip_apn_to.cod_qos%TYPE,
		sn_octeto_1		     OUT NOCOPY       aip_ip_to.octeto_1%TYPE,
		sn_octeto_2		     OUT NOCOPY       aip_ip_to.octeto_1%TYPE,
		sn_octeto_3		     OUT NOCOPY       aip_ip_to.octeto_1%TYPE,
		sn_octeto_4		  	 OUT NOCOPY       aip_ip_to.octeto_1%TYPE,
        sn_cod_retorno       OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno      OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento        OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE aip_conapn_pr (
        en_cod_servicio    IN               aip_apn_to.cod_servicio%TYPE,
        sn_cod_apn         OUT NOCOPY       aip_apn_to.cod_apn%TYPE,
	    sv_cod_tecnologia  OUT NOCOPY       aip_apn_to.cod_tecnologia%TYPE,
	    sn_cod_qos         OUT NOCOPY       aip_qos_to.cod_qos%TYPE,
        sv_eqosid          OUT NOCOPY       aip_qos_to.eqosid%TYPE,
        sn_cod_retorno     OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY       ge_errores_pg.evento
    );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION aip_disponible_fn (en_cod_rangoip IN aip_ip_to.cod_rangoip%TYPE)
        RETURN VARCHAR2;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaTipoIp_pr(
    sc_TipoIp        OUT NOCOPY refCursor,
	SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento    OUT NOCOPY ge_errores_pg.evento
);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_cambioip_pr (
        ev_cod_tecnologia    IN               aip_ip_to.cod_tecnologia%TYPE,
        en_cod_apn           IN               aip_ip_to.cod_apn%TYPE,
        en_octeto_1          IN               aip_ip_to.octeto_1%TYPE,
        en_octeto_2          IN               aip_ip_to.octeto_2%TYPE,
        en_octeto_3          IN               aip_ip_to.octeto_3%TYPE,
        en_octeto_4          IN               aip_ip_to.octeto_4%TYPE,
		sn_octeto_1		     OUT NOCOPY       aip_ip_to.octeto_1%TYPE,
		sn_octeto_2		     OUT NOCOPY       aip_ip_to.octeto_1%TYPE,
		sn_octeto_3		     OUT NOCOPY       aip_ip_to.octeto_1%TYPE,
		sn_octeto_4		  	 OUT NOCOPY       aip_ip_to.octeto_1%TYPE,
        sn_cod_retorno       OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno      OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento        OUT NOCOPY       ge_errores_pg.evento
);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultasolapamiento_m_pr (
        en_octeto_ini_1    IN               aip_rangoipta_to.octeto_ini_1%TYPE,
        en_octeto_ini_2    IN               aip_rangoipta_to.octeto_ini_2%TYPE,
        en_octeto_ini_3    IN               aip_rangoipta_to.octeto_ini_3%TYPE,
        en_octeto_ini_4    IN               aip_rangoipta_to.octeto_ini_4%TYPE,
        en_octeto_fin_1    IN               aip_rangoipta_to.octeto_fin_1%TYPE,
        en_octeto_fin_2    IN               aip_rangoipta_to.octeto_fin_2%TYPE,
        en_octeto_fin_3    IN               aip_rangoipta_to.octeto_fin_3%TYPE,
        en_octeto_fin_4    IN               aip_rangoipta_to.octeto_fin_4%TYPE,
        en_codrangoip      IN               aip_rangoipta_to.cod_rangoip%TYPE,
        sn_solapamiento    OUT NOCOPY       NUMBER,
        sn_cod_retorno     OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno    OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento      OUT NOCOPY       ge_errores_pg.evento
    );

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


END aip_administracion_pg; 
/
SHOW ERRORS
