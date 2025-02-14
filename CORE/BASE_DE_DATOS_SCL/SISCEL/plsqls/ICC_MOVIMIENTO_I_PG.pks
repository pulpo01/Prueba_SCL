CREATE OR REPLACE PACKAGE ICC_movimiento_i_PG
AS

         /*
                <Documentación TipoDoc = "icc_movimiento_i_PG
                <Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="28-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD">
                <Retorno>NA</Retorno>
                <Descripción> Encabezado de icc_movimiento_i_PG/Descripción>
                <Parámetros>
                <Entrada>
                <param nom="" Tipo="STRING">Descripción Parametro1</param>
                </Entrada>
                <Salida>
                <param nom="" Tipo="STRING">Descripción Parametro4</param>
                </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */

PROCEDURE ICC_agregar_PR(EN_num_movimiento IN NUMBER,
                         EN_num_abonado    IN NUMBER,
                         EV_cod_modulo     IN VARCHAR2,
                         EN_cod_estado     IN NUMBER,
                         EN_cod_actuacion  IN NUMBER,
                         EV_nom_usuarora   IN VARCHAR2,
                         ED_fec_ingreso    IN DATE,
                         EN_cod_central    IN NUMBER,
                         EN_num_celular    IN NUMBER,
                         EV_num_serie      IN VARCHAR2,
                         EN_num_movpos     IN NUMBER,
                         EN_num_movant     IN NUMBER,
                         EV_tip_terminal   IN VARCHAR2,
                         EV_cod_actabo     IN VARCHAR2,
                         EV_num_min        IN VARCHAR2,
                         EV_cod_servicios  IN VARCHAR2,
                         EV_tip_tecnologia IN VARCHAR2,
                         EV_imsi           IN VARCHAR2,
                         EV_imei           IN VARCHAR2,
                         EV_icc            IN VARCHAR2,
                         SN_coderror       OUT NOCOPY NUMBER,
                         SV_msgerror       OUT NOCOPY VARCHAR2);
PROCEDURE ICC_AGREGAR_PR(
  EN_num_movimiento    IN icc_movimiento.num_movimiento%TYPE,
  EN_num_abonado       IN icc_movimiento.num_abonado%TYPE,
  EN_cod_estado        IN icc_movimiento.cod_estado%TYPE,
  EV_cod_actabo        IN icc_movimiento.cod_actabo%TYPE,
  EV_cod_modulo        IN icc_movimiento.cod_modulo%TYPE,
  EN_num_intentos      IN icc_movimiento.num_intentos%TYPE,
  EN_cod_central_nue   IN icc_movimiento.cod_central_nue%TYPE,
  EV_des_respuesta     IN icc_movimiento.des_respuesta%TYPE,
  EN_cod_actuacion     IN icc_movimiento.cod_actuacion%TYPE,
  EV_nom_usuarora      IN icc_movimiento.nom_usuarora%TYPE,
  ED_fec_ingreso       IN icc_movimiento.fec_ingreso%TYPE,
  EV_tip_terminal      IN icc_movimiento.tip_terminal%TYPE,
  EN_cod_central       IN icc_movimiento.cod_central%TYPE,
  ED_fec_lectura       IN icc_movimiento.fec_lectura%TYPE,
  EN_ind_bloqueo       IN icc_movimiento.ind_bloqueo%TYPE,
  ED_fec_ejecucion     IN icc_movimiento.fec_ejecucion%TYPE,
  EV_tip_terminal_nue  IN icc_movimiento.tip_terminal_nue%TYPE,
  EN_num_movant        IN icc_movimiento.num_movant%TYPE,
  EN_num_celular       IN icc_movimiento.num_celular%TYPE,
  EN_num_movpos        IN icc_movimiento.num_movpos%TYPE,
  EV_num_serie         IN icc_movimiento.num_serie%TYPE,
  EV_num_personal      IN icc_movimiento.num_personal%TYPE,
  EV_num_celular_nue   IN icc_movimiento.num_celular_nue%TYPE,
  EV_num_serie_nue     IN icc_movimiento.num_serie_nue%TYPE,
  EV_num_personal_nue  IN icc_movimiento.num_personal_nue%TYPE,
  EV_num_msnb          IN icc_movimiento.num_msnb%TYPE,
  EV_num_msnb_nue      IN icc_movimiento.num_msnb_nue%TYPE,
  EV_cod_suspreha      IN icc_movimiento.cod_suspreha%TYPE,
  EV_cod_servicios     IN icc_movimiento.cod_servicios%TYPE,
  EV_num_min           IN icc_movimiento.num_min%TYPE,
  EV_num_min_nue       IN icc_movimiento.num_min_nue%TYPE,
  EC_sta               IN icc_movimiento.sta%TYPE,
  EN_cod_mensaje       IN icc_movimiento.cod_mensaje%TYPE,
  EV_param1_mens       IN icc_movimiento.param1_mens%TYPE,
  EV_param2_mens       IN icc_movimiento.param2_mens%TYPE,
  EV_param3_mens       IN icc_movimiento.param3_mens%TYPE,
  EV_plan              IN icc_movimiento.plan%TYPE,
  EN_carga             IN icc_movimiento.carga%TYPE,
  EN_valor_plan        IN icc_movimiento.valor_plan%TYPE,
  EV_pin               IN icc_movimiento.pin%TYPE,
  ED_fec_expira        IN icc_movimiento.fec_expira%TYPE,
  EV_des_mensaje       IN icc_movimiento.des_mensaje%TYPE,
  EV_cod_pin           IN icc_movimiento.cod_pin%TYPE,
  EV_cod_idioma        IN icc_movimiento.cod_idioma%TYPE,
  EN_cod_enrutamiento  IN icc_movimiento.cod_enrutamiento%TYPE,
  EN_tip_enrutamiento  IN icc_movimiento.tip_enrutamiento%TYPE,
  EV_des_origen_pin    IN icc_movimiento.des_origen_pin%TYPE,
  EN_num_lote_pin      IN icc_movimiento.num_lote_pin%TYPE,
  EV_num_serie_pin     IN icc_movimiento.num_serie_pin%TYPE,
  EV_tip_tecnologia    IN icc_movimiento.tip_tecnologia%TYPE,
  EV_imsi              IN icc_movimiento.imsi%TYPE,
  EV_imsi_nue          IN icc_movimiento.imsi_nue%TYPE,
  EV_imei              IN icc_movimiento.imei%TYPE,
  EV_imei_nue          IN icc_movimiento.imei_nue%TYPE,
  EV_icc               IN icc_movimiento.icc%TYPE,
  EV_icc_nue           IN icc_movimiento.icc_nue%TYPE,
  EV_cod_prog              IN VARCHAR2,
  SN_p_correlativo    OUT NOCOPY  NUMBER,
  SN_p_filasafectas   OUT NOCOPY  NUMBER,
  SN_p_retornora      OUT NOCOPY  NUMBER,
  SN_p_nroevento      OUT NOCOPY  NUMBER,
  SV_p_vcod_retorno   OUT NOCOPY VARCHAR2
  );

END ICC_movimiento_i_PG;
/
SHOW ERRORS
