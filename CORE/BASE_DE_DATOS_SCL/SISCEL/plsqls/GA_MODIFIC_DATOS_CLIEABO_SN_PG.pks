CREATE OR REPLACE PACKAGE GA_MODIFIC_DATOS_CLIEABO_SN_PG AS

 PROCEDURE GA_MODIFICA_MAIL_CLIE_PR (EN_cod_cliente IN ge_clientes.cod_cliente%type,
                                   EV_nom_email IN ge_clientes.nom_email%type,
								   EV_cod_causa IN ga_modcli.cod_causa%type,
								   EV_tip_modi  IN ga_modcli.cod_tipmodi%type,
								   EV_nom_usuario IN ge_clientes.NOM_USUARORA%type,
                                   SN_cod_retorno OUT NOCOPY NUMBER, SV_mens_retorno OUT NOCOPY VARCHAR2, SN_num_evento OUT NOCOPY NUMBER);
 PROCEDURE GA_MODIFIC_TIP_DISTRIB_CLIE_PR (EN_cod_cliente IN ge_clientes.cod_cliente%type,
                                   EV_ind_fact_Elect IN ge_clientes.ind_facturaelectronica%type,
								   EV_cod_causa IN ga_modcli.cod_causa%type,
								   EV_tip_modi  IN ga_modcli.cod_tipmodi%type,
								   EV_nom_usuario IN ge_clientes.NOM_USUARORA%type, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER);
 PROCEDURE GA_MODIFICA_MAIL_USUARIO_PR (EN_num_celular IN ga_abocel.num_celular%type,
                                   EV_email IN ga_modusuarios.email%type,
								   EV_cod_causa IN ga_modusuarios.cod_causa%type,
								   EV_tip_modi  IN ga_modusuarios.cod_tipmodi%type,
								   EV_nom_usuario IN ga_modusuarios.nom_usuarora%type,
								   SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER);
END;
/
SHOW ERRORS
