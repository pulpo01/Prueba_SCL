CREATE OR REPLACE PACKAGE pv_atencion_pg
AS


GV_IND_VIGENTE  CONSTANT VARCHAR2 (1) :='V';
GN_GRP_ATENCION CONSTANT NUMBER (3)   := 50;
--GN_GRP_ATENCION CONSTANT NUMBER (3)   := 459;
GV_COD_MODULO   CONSTANT VARCHAR2 (2) := 'PV';

TYPE refcursor IS REF CURSOR;

PROCEDURE pv_consulta_abonado_pr ( en_num_abonado   IN  ga_abocel.num_abonado%TYPE,
                                   sn_num_celular   OUT NOCOPY ga_abocel.num_celular%TYPE,
                                   sv_nom_usuario   OUT NOCOPY ga_usuarios.nom_usuario%TYPE,
                                   sv_nom_apellido1 OUT NOCOPY ga_usuarios.nom_apellido1%TYPE,
                                   sv_nom_apellido2 OUT NOCOPY ga_usuarios.nom_apellido2%TYPE,
                                   sn_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento    OUT NOCOPY ge_errores_pg.evento);
PROCEDURE pv_consulta_cliente_pr ( en_cod_cliente   IN  ga_abocel.cod_cliente%TYPE,
                                   sc_cons_cliente  OUT NOCOPY refcursor,
                                   sn_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento    OUT NOCOPY ge_errores_pg.evento);
PROCEDURE pv_consulta_cuenta_pr (  en_cod_cuenta    IN  ga_abocel.cod_cuenta%TYPE,
                                   sc_cons_cuenta   OUT NOCOPY refcursor,
                                   sn_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento    OUT NOCOPY ge_errores_pg.evento);
PROCEDURE pv_consulta_atencion_pr (sc_cons_aten     OUT NOCOPY refcursor,
                                   sn_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento    OUT NOCOPY ge_errores_pg.evento);
PROCEDURE pv_ingreso_atencion_pr ( ev_fecha_inicio  IN varchar2,
                                   ev_fecha_fin     IN varchar2,
                                   ev_usuarora      IN ci_reg_atencion_clientes.nom_usuarora%TYPE,
                                   en_num_abonado   IN ci_reg_atencion_clientes.num_abonado%TYPE,
                                   en_cod_atencion  IN ci_reg_atencion_clientes.cod_atencion%TYPE,
                                   ev_observacion   IN ci_reg_atencion_clientes.obs_atencion%TYPE,
                                   sn_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento    OUT NOCOPY ge_errores_pg.evento);
END pv_atencion_pg;
/
SHOW ERRORS