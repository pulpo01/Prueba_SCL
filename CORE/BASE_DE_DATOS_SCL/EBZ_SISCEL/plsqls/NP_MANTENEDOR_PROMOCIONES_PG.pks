CREATE OR REPLACE PACKAGE NP_MANTENEDOR_PROMOCIONES_PG IS   
------------------------------------------------------------------------
procedure np_promocion_utilizada_pr(
EN_cod_promocion  IN npt_promocion_td.cod_promocion%TYPE,
SN_cod_error	  OUT NOCOPY NUMBER,
SV_mensaje		  OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
procedure np_promocion_utilizada_cli_pr(
EN_cod_promocion  IN npt_promocion_td.cod_promocion%TYPE,
EN_cod_usuario    IN npt_prom_cliente_td.cod_usuario%TYPE,
SN_cod_error	  OUT NOCOPY NUMBER,
SV_mensaje		  OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
procedure np_existe_descprom_pr (
 EN_cod_promocion IN npt_promocion_td.cod_promocion%TYPE,
 EV_des_promocion IN npt_promocion_td.des_promocion%TYPE,
 SN_cod_error	  OUT NOCOPY NUMBER,
 SV_mensaje		  OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
procedure np_articulo_utilizado_pr
(EN_cod_promocion IN npt_prom_articulo_td.cod_promocion%TYPE,
 EN_cod_articulo  IN npt_prom_articulo_td.cod_articulo%TYPE,
 SN_cod_error	  OUT NOCOPY NUMBER,
 SV_mensaje		  OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
procedure NP_INS_PROMOCION_PR(
   EV_des_promocion             IN npt_promocion_td.des_promocion%TYPE,
   EV_fec_ini_vigencia			IN varchar2,
   EV_fec_fin_vigencia			IN varchar2,
   EV_usu_creacion				IN npt_promocion_td.usua_creacion%TYPE,
   SN_cod_promocion				OUT NOCOPY NUMBER,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
procedure NP_INS_PROMOCION_HIST_PR(
   EN_cod_promocion             IN npt_promocion_td.cod_promocion%TYPE,
   EV_accion					IN npt_promocion_th.cod_accion%TYPE,
   EV_usua_actualiza			IN npt_promocion_th.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
procedure NP_INS_PROM_ARTICULO_PR(
   EN_cod_promocion             IN npt_prom_articulo_td.cod_promocion%TYPE,
   EN_cod_articulo              IN npt_prom_articulo_td.cod_articulo%TYPE,
   EV_prc_articulo   			IN VARCHAR2,
   EV_usu_creacion				IN npt_promocion_td.usua_creacion%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
procedure NP_INS_PROM_CLIENTE_PR(
   EN_cod_promocion             IN npt_prom_cliente_td.cod_promocion%TYPE,
   EN_cod_usuario               IN npt_prom_cliente_td.cod_usuario%TYPE,
   EV_usu_creacion				IN npt_prom_cliente_td.usua_creacion%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
procedure NP_INS_PROM_ARTICULO_HIST_PR(
   EN_cod_promocion             IN npt_prom_articulo_td.cod_promocion%TYPE,
   EN_cod_articulo              IN npt_prom_articulo_td.cod_articulo%TYPE,
   EV_accion					IN npt_prom_articulo_th.cod_accion%TYPE,
   EV_usuario_act				IN npt_prom_articulo_th.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
procedure NP_INS_PROM_CLIENTE_HIST_PR(
   EN_cod_promocion             IN npt_prom_cliente_td.cod_promocion%TYPE,
   EN_cod_usuario               IN npt_prom_cliente_td.cod_usuario%TYPE,
   EV_accion					IN npt_prom_cliente_th.cod_accion%TYPE,
   EV_usua_actualiza			IN npt_prom_cliente_th.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
procedure NP_DEL_PROMOCION_PR(
   EN_cod_promocion             IN npt_promocion_td.cod_promocion%TYPE,
   EV_usua_actualiza			IN npt_promocion_td.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
/*
procedure NP_DEL_PROM_ARTICULO_PR(
   EN_cod_promocion             IN npt_prom_articulo_td.cod_promocion%TYPE,
   EN_cod_articulo				IN npt_prom_articulo_td.cod_articulo%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
  procedure NP_DEL_PROM_CLIENTE_PR(
   EN_cod_promocion             IN npt_prom_cliente_td.cod_promocion%TYPE,
   EN_cod_usuario				IN npt_prom_cliente_td.cod_usuario%TYPE,
   EV_usua_actualiza			IN npt_prom_cliente_td.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2);
*/
------------------------------------------------------------------------
procedure NP_DEL_TODO_PROMOCION_PR(
   EN_cod_promocion             IN npt_promocion_td.cod_promocion%TYPE,
   EV_usua_actualiza			IN npt_promocion_td.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
procedure NP_MOD_PROM_ARTICULO_PR(
   EN_cod_promocion             IN npt_prom_articulo_td.cod_promocion%TYPE,
   EV_usuario_act				IN npt_prom_articulo_td.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
procedure NP_MOD_PROMOCION_PR(
   EN_cod_promocion             IN npt_promocion_td.cod_promocion%TYPE,
   EV_des_promocion_ant			IN npt_promocion_td.des_promocion%TYPE,
   EV_des_promocion				IN npt_promocion_td.des_promocion%TYPE,
   EV_fec_ini_ant	            IN VARCHAR2,
   EV_fec_ini		            IN VARCHAR2,
   EV_fec_fin_ant	            IN VARCHAR2,
   EV_fec_fin		            IN VARCHAR2,
   EV_usuario_act				IN VARCHAR2,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------
procedure NP_MOD_PROM_CLIENTES_PR(
   EN_cod_promocion             IN npt_prom_cliente_td.cod_promocion%TYPE,
   EV_usuario_act				IN npt_prom_cliente_td.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2);
------------------------------------------------------------------------


END NP_MANTENEDOR_PROMOCIONES_PG;
/   
SHOW ERRORS 