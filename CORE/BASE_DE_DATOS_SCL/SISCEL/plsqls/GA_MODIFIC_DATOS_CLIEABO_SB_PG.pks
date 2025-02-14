CREATE OR REPLACE PACKAGE Ga_Modific_Datos_Clieabo_Sb_Pg AS

 PROCEDURE GA_MODIFICA_DATOS_CLIE_PR (EN_cod_cliente IN GE_CLIENTES.cod_cliente%TYPE,
                                   EV_nom_email IN GE_CLIENTES.nom_email%TYPE,
								   EV_ind_fact_Elect IN GE_CLIENTES.ind_facturaelectronica%TYPE,
								   EV_cod_causa IN GA_MODCLI.cod_causa%TYPE,
								   EV_tip_modi  IN GA_MODCLI.cod_tipmodi%TYPE,
								   EV_nom_usuario IN GE_CLIENTES.NOM_USUARORA%TYPE,
								   SN_ind_facturaelect OUT NOCOPY ge_clientes.IND_FACTURAELECTRONICA%TYPE, --COL
								   SV_nom_email_clie OUT NOCOPY GE_CLIENTES.nom_email%TYPE, --COL
                                   SN_cod_retorno OUT NOCOPY NUMBER, SV_mens_retorno OUT NOCOPY VARCHAR2, SN_num_evento OUT NOCOPY NUMBER);


 PROCEDURE GA_MODIFICA_DATOS_USUA_PR (EN_num_celular IN ga_abocel.num_celular%TYPE,
                                   EV_email IN GA_MODUSUARIOS.email%TYPE,
								   EV_cod_causa IN GA_MODUSUARIOS.cod_causa%TYPE,
								   EV_tip_modi  IN GA_MODUSUARIOS.cod_tipmodi%TYPE,
								   EV_nom_usuario IN GA_MODUSUARIOS.nom_usuarora%TYPE,
								   SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER);

PROCEDURE GA_VALIDA_DATOS_PR ( EV_cod_causa IN GA_MODCLI.cod_causa%TYPE,
								EV_nom_usuario IN VARCHAR2,
								EV_cod_actabo IN ga_actabo.cod_actabo%TYPE,
                                 SN_cod_retorno OUT NOCOPY NUMBER, SV_mens_retorno OUT NOCOPY VARCHAR2, SN_num_evento OUT NOCOPY NUMBER);
   END;
/
SHOW ERRORS
