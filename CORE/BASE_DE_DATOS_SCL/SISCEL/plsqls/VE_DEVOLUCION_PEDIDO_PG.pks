CREATE OR REPLACE PACKAGE VE_DEVOLUCION_PEDIDO_PG
 IS
PROCEDURE DEVOLUCION_PEDIDO;

PROCEDURE P_EJECUTA_PROCESO_DEV_PR   (EV_modulo          IN VARCHAR2,
									  EN_producto        IN VARCHAR2,
							          EV_tipo_articulo   IN AL_ARTICULOS.tip_articulo%TYPE,
     						          EV_ind_equiacc     IN AL_ARTICULOS.ind_equiacc%TYPE,
							          EV_cod_uso         IN NPT_DETALLE_PEDIDO.cod_uso%TYPE,
									  EV_nivel_actuacion IN VARCHAR2,
								      EV_param_entrada   IN VARCHAR2,
									  EV_operadora_local IN GE_OPERADORA_SCL.cod_operadora_scl%TYPE,
									  EN_tip_doc_pedido  IN VARCHAR2,
									  SV_nom_proceso    OUT VARCHAR2,
									  SV_nom_tabla      OUT VARCHAR2,
									  SV_cod_act        OUT VARCHAR2,
									  SV_error          OUT VARCHAR2,
									  SV_cadena         OUT VARCHAR2,
									  GN_ejecuta_proceso IN OUT PLS_INTEGER);

PROCEDURE PV_INVOCA_BAJA_PR          (EV_entrada        IN  VARCHAR2,
									  SV_tabla          OUT VARCHAR2,
									  SV_actabo         OUT VARCHAR2,
									  SV_error          OUT VARCHAR2,
									  SV_proc           OUT VARCHAR2
									  );

PROCEDURE GRABA_ERROR                (EV_modulo         IN VARCHAR2,
				                      EN_cod_devolucion IN NUMBER,
									  ED_fecsys         IN DATE,
									  EN_producto       IN NUMBER,
									  EV_proceso        IN VARCHAR2,
									  EV_tabla          IN VARCHAR2,
									  EV_act            IN VARCHAR2,
									  EV_cod_error      IN VARCHAR2,
									  EV_msg_error      IN VARCHAR2,
				                      EN_cod_pedido     IN NUMBER,
									  EV_user           IN VARCHAR2,
									  EV_flujo_error	IN VARCHAR2,
					   				  EN_usuario_cre    IN NUMBER,
					   				  EN_usuario_ing    IN NUMBER,
									  EV_cod_modgener   IN VARCHAR2,
									  EV_cod_aplic      IN VARCHAR2,
									  EN_cod_proceso    IN NUMBER,
									  EN_estado         IN NUMBER
									  );
END VE_DEVOLUCION_PEDIDO_PG;
/
SHOW ERRORS
