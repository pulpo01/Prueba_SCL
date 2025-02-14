CREATE OR REPLACE PACKAGE FA_FACTURACION_DIF_SP_PG AS

GV_cod_modulo        CONSTANT VARCHAR2(2) := 'FA';
GV_error_no_clasif     CONSTANT VARCHAR2(50):= 'No es posible clasificar el error';
GV_ind_activo     CONSTANT VARCHAR2(1):= '1';
GV_Alta     CONSTANT VARCHAR2(3):= 'AAA';
GV_CatDobleCliAsoc     CONSTANT VARCHAR2(20):= 'CAT_DOBLE_CTA_ASOC';
GV_CatDobleCliCont     CONSTANT VARCHAR2(20):= 'CAT_DOBLE_CTA_CONTRA';

TYPE ref_cursor IS REF CURSOR;

-----------------------------------------------------------------
PROCEDURE FA_UP_FACTURACION_DIF_PR (
        EN_Num_Sec_Det        IN fa_det_facturacion_dif_to.num_sec_detalle_fd%TYPE,
        EN_Cod_CliAsoc        IN  fa_det_facturacion_dif_to.cod_cliente_asoc%TYPE,
        EN_Num_Abonado        IN  fa_det_facturacion_dif_to.num_abonado%TYPE,
        EV_Usuario        IN  fa_det_facturacion_dif_to.usuario%TYPE,
        SN_Cod_Retorno        OUT NOCOPY ge_errores_pg.coderror,
        SV_Mens_Retorno        OUT NOCOPY ge_errores_pg.msgerror,
        SN_Num_Evento        OUT NOCOPY ge_errores_pg.evento);

-----------------------------------------------------------------
PROCEDURE FA_IN_FACTURACION_DIF_PR (
        EN_Cod_CliContra        IN  fa_enc_facturacion_dif_to.cod_cliente_contra%TYPE,
        ED_Fec_Ingreso        IN  fa_enc_facturacion_dif_to.fec_ingreso_registro%TYPE,
        ED_Fec_Cierre        IN  fa_enc_facturacion_dif_to.fec_cierre_registro%TYPE,
        EN_Cod_Ciclo        IN  fa_enc_facturacion_dif_to.cod_ciclo%TYPE,
        EN_Tip_Operacion        IN  fa_enc_facturacion_dif_to.tip_operacion%TYPE,
        EN_Tip_Modalidad        IN  fa_enc_facturacion_dif_to.tip_modalidad%TYPE,
        EN_Tip_Valor        IN  fa_enc_facturacion_dif_to.tip_valor%TYPE,
        EV_Usuario        IN  fa_enc_facturacion_dif_to.usuario%TYPE,
        SN_Num_Sec_Enc        OUT NOCOPY fa_enc_facturacion_dif_to.num_sec_encabezado_fd%TYPE,
        SN_cod_retorno        OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno        OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento        OUT NOCOPY ge_errores_pg.evento);

-----------------------------------------------------------------
PROCEDURE FA_IN_DET_FACTURACION_DIF_PR (
        EN_Num_Sec_Enc        IN  fa_det_facturacion_dif_to.num_sec_encabezado_fd%TYPE,
        EN_Cod_CliAsoc        IN  fa_det_facturacion_dif_to.cod_cliente_asoc%TYPE,
        EN_Num_Abonado        IN  fa_det_facturacion_dif_to.num_abonado%TYPE,
        EN_Cod_Concep        IN  fa_det_facturacion_dif_to.cod_concepto%TYPE,
        EN_Mto_Concep        IN  fa_det_facturacion_dif_to.mnt_concepto_asoc%TYPE,
        ED_Fec_Ingreso        IN  fa_det_facturacion_dif_to.fec_ingreso_registro%TYPE,
        ED_Fec_Cierre        IN  fa_det_facturacion_dif_to.fec_cierre_registro%TYPE,
        EV_Usuario        IN  fa_det_facturacion_dif_to.usuario%TYPE,
        SN_Num_Sec_Det        OUT NOCOPY fa_det_facturacion_dif_to.num_sec_detalle_fd%TYPE,
        SN_cod_retorno        OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno        OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento        OUT NOCOPY ge_errores_pg.evento);

-----------------------------------------------------------------
PROCEDURE FA_SEL_INFO_FD_PR (
        EN_Cod_CliContra        IN ge_clientes.cod_cliente%TYPE,
        SC_Info_FD		  OUT NOCOPY ref_cursor,
        SN_cod_retorno			  OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno			  OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento			  OUT NOCOPY ge_errores_pg.evento);

-----------------------------------------------------------------
PROCEDURE FA_SEL_CLI_CONTRATA_PR (
        EN_Cod_CliContra        IN ge_clientes.cod_cliente%TYPE,
        SV_Nom_Cliente        OUT NOCOPY ge_clientes.nom_cliente%TYPE,
        SV_Cod_Tipident		  OUT NOCOPY ge_clientes.cod_tipident%TYPE,
        SV_Num_Ident		  OUT NOCOPY ge_clientes.num_ident%TYPE,
        SN_Cod_Cuenta		  OUT NOCOPY ge_clientes.cod_cuenta%TYPE,
        SV_Nom_Apeclien1	  OUT NOCOPY ge_clientes.nom_apeclien1%TYPE,
        SV_Nom_Apeclien2	  OUT NOCOPY ge_clientes.nom_apeclien2%TYPE,
        SN_Cod_Ciclo		  OUT NOCOPY ge_clientes.cod_ciclo%TYPE,
        SN_Num_Sec_Enc        OUT NOCOPY fa_enc_facturacion_dif_to.num_sec_encabezado_fd%TYPE,
        SN_Tip_Valor        OUT NOCOPY fa_enc_facturacion_dif_to.tip_valor%TYPE,
        SN_Cod_Retorno        OUT NOCOPY ge_errores_pg.coderror,
        SV_Mens_Retorno       OUT NOCOPY ge_errores_pg.msgerror,
        SN_Num_Evento         OUT NOCOPY ge_errores_pg.evento);

-----------------------------------------------------------------
PROCEDURE FA_SEL_CONCEPTOS_PR (
        SC_Conceptos		  OUT NOCOPY ref_cursor,
        SN_cod_retorno			  OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno			  OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento			  OUT NOCOPY ge_errores_pg.evento);

-----------------------------------------------------------------
PROCEDURE FA_SEL_CLIENTES_PR (
        EN_cod_cliente        IN ge_clientes.cod_cliente%TYPE,
        EV_num_ident		  IN ge_clientes.num_ident%TYPE,
        EV_nom_cliente        IN ge_clientes.nom_cliente%TYPE,
        EV_nom_apeclien1	  IN ge_clientes.nom_apeclien1%TYPE,
        EV_nom_apeclien2	  IN ge_clientes.nom_apeclien2%TYPE,
        EN_cod_ciclo		  IN ge_clientes.cod_ciclo%TYPE,
        SC_Clientes		  OUT NOCOPY ref_cursor,
        SN_cod_retorno			  OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno			  OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento			  OUT NOCOPY ge_errores_pg.evento);

-----------------------------------------------------------------
PROCEDURE FA_SEL_ABONADOS_PR (
        EN_cod_cliente        IN ga_abocel.cod_cliente%TYPE,
        EN_num_celular        IN ga_abocel.num_celular%TYPE,
        SC_Abonados		  OUT NOCOPY ref_cursor,
        SN_cod_retorno			  OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno			  OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento			  OUT NOCOPY ge_errores_pg.evento);

-----------------------------------------------------------------
PROCEDURE FA_UP_FACTURACION_DIF_M_PR (
        EN_Num_Sec_Enc        IN fa_enc_facturacion_dif_to.num_sec_encabezado_fd%TYPE,
        EV_Usuario        IN  fa_enc_facturacion_dif_to.usuario%TYPE,
        SN_Cod_Retorno        OUT NOCOPY ge_errores_pg.coderror,
        SV_Mens_Retorno        OUT NOCOPY ge_errores_pg.msgerror,
        SN_Num_Evento        OUT NOCOPY ge_errores_pg.evento);

END FA_FACTURACION_DIF_SP_PG; 
/
SHOW ERRORS
