CREATE OR REPLACE PACKAGE ve_tiendas_quiosco_pg AS


cv_cod_modulo  CONSTANT VARCHAR2 (2)  := 'VE';
cv_version     CONSTANT VARCHAR2 (3)  := '1.0';
cv_ofi_caja    CONSTANT VARCHAR2 (2)  := 'NT';


TYPE refcursor IS REF CURSOR;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_get_tiendas_pr(sc_tiendas        OUT NOCOPY RefCursor,
							sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	      					sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	      					sn_num_evento     OUT NOCOPY ge_errores_pg.evento);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ve_get_infoVend_tienda_pr(EV_COD_TIENDA IN VE_TIENDA_TD.COD_TIENDA%TYPE,
							SV_DES_TIENDA     OUT NOCOPY VE_TIENDA_TD.DES_TIENDA%TYPE,
							SV_NOM_USUARIO    OUT NOCOPY GE_SEG_USUARIO.NOM_USUARIO%TYPE,
							SV_DES_BODEGA     OUT NOCOPY AL_BODEGAS.DES_BODEGA%TYPE,
							SV_NOM_VENDEDOR   OUT NOCOPY VE_VENDEDORES.NOM_VENDEDOR%TYPE,
							SV_COD_CAJA       OUT NOCOPY CO_CAJAS.COD_CAJA%TYPE,
							SV_DES_CAJA       OUT NOCOPY CO_CAJAS.DES_CAJA%TYPE,
                            SV_COD_VENDEDOR   OUT NOCOPY VE_VENDEDORES.COD_VENDEDOR%TYPE,
  							SV_COD_OFICINA    OUT NOCOPY VE_VENDEDORES.COD_OFICINA%TYPE,
							SV_NUM_IDENTCLI   OUT NOCOPY GE_CLIENTES.NUM_IDENT%TYPE,
							SV_COD_CLIENTE    OUT NOCOPY GE_CLIENTES.COD_CLIENTE%TYPE,
							SV_COD_CUENTA     OUT NOCOPY GE_CLIENTES.COD_CUENTA%TYPE,
							SV_COD_DIRECCION  OUT NOCOPY GA_DIRECCLI.COD_DIRECCION%TYPE,
                            sn_cod_bodega     OUT NOCOPY al_bodegas.COD_BODEGA%TYPE,
							SN_IND_APLI_PAGO  OUT NOCOPY VE_TIENDA_TD.IND_APLI_PAGO%TYPE,
							sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	      					sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	      					sn_num_evento     OUT NOCOPY ge_errores_pg.evento);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_insert_tienda_pr(
                                    sv_des_tienda           IN VE_TIENDA_TD.DES_TIENDA%TYPE,
                                    sv_nom_usuario_vendedor IN VE_TIENDA_TD.NOM_USUARIO_VENDEDOR%TYPE,
                                    sv_nom_usuario_cajero   IN VE_TIENDA_TD.NOM_USUARIO_CAJERO%TYPE,
                                    sv_nom_usuario          IN VE_TIENDA_TD.NOM_USUARIO%TYPE,
                                    sv_cod_cliente          IN VE_TIENDA_TD.COD_CLIENTE%TYPE,
                                    sv_cod_caja             IN VE_TIENDA_TD.COD_CAJA%TYPE,
									sn_ind_apli_pago        IN VE_TIENDA_TD.IND_APLI_PAGO%TYPE,
                                    sn_cod_tienda           OUT NOCOPY VE_TIENDA_TD.COD_TIENDA%TYPE,
                                    sn_cod_retorno          OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    sv_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    sn_num_evento           OUT NOCOPY ge_errores_pg.evento);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_selec_curs_tienda_pr(
                                    sc_tienda            OUT NOCOPY refcursor,
                                    sn_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    sv_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    sn_num_evento        OUT NOCOPY ge_errores_pg.evento);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_update_tienda_pr(
                                sn_cod_tienda           IN VE_TIENDA_TD.COD_TIENDA%TYPE,
                                sv_des_tienda           IN VE_TIENDA_TD.DES_TIENDA%TYPE,
                                sv_nom_usuario_vendedor IN VE_TIENDA_TD.NOM_USUARIO_VENDEDOR%TYPE,
                                sv_nom_usuario_cajero   IN VE_TIENDA_TD.NOM_USUARIO_CAJERO%TYPE,
                                sv_nom_usuario          IN VE_TIENDA_TD.NOM_USUARIO%TYPE,
                                sv_cod_cliente          IN VE_TIENDA_TD.COD_CLIENTE%TYPE,
                                sv_cod_caja             IN VE_TIENDA_TD.COD_CAJA%TYPE,
								en_ind_apli_pago        IN VE_TIENDA_TD.IND_APLI_PAGO%TYPE,
                                sn_cod_retorno          OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento           OUT NOCOPY ge_errores_pg.evento);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_delete_tienda_pr(
                                sn_cod_tienda     IN VE_TIENDA_TD.COD_TIENDA%TYPE,
                                sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento     OUT NOCOPY ge_errores_pg.evento);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_get_cajas_pr(ev_oficina        IN  co_cajas.cod_oficina%TYPE,  
                          sc_caja     	    OUT NOCOPY RefCursor,
						  sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	      				  sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	      			      sn_num_evento     OUT NOCOPY ge_errores_pg.evento);                                
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ve_tiendas_quiosco_pg;
/
SHOW ERRORS
