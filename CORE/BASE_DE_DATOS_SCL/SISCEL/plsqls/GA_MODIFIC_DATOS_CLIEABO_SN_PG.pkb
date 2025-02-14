CREATE OR REPLACE PACKAGE BODY GA_MODIFIC_DATOS_CLIEABO_SN_PG AS
 CV_error_no_clasif VARCHAR2(100) := 'Error no clasificado';
 PROCEDURE GA_MODIFICA_MAIL_CLIE_PR (EN_cod_cliente IN ge_clientes.cod_cliente%type,
                                   EV_nom_email IN ge_clientes.nom_email%type,
								   EV_cod_causa IN ga_modcli.cod_causa%type,
								   EV_tip_modi  IN ga_modcli.cod_tipmodi%type,
								   EV_nom_usuario IN ge_clientes.NOM_USUARORA%type,
                                   SN_cod_retorno OUT NOCOPY NUMBER, SV_mens_retorno OUT NOCOPY VARCHAR2, SN_num_evento OUT NOCOPY NUMBER)
 AS
 ERROR_CONTROLADO EXCEPTION;
 LV_sql varchar2(1000);
 LN_ind_facturaElectronica ge_clientes.ind_facturaelectronica%type;
 ln_nom_email_cli ge_clientes.nom_email%type;
 te_cliente_fact fa_cliente_dto_ot;
 BEGIN
    SN_cod_retorno := 0;
	SV_mens_retorno := NULL;
	SN_num_evento := 0;

	LV_sql := 'GA_MODIF_DATOS_CLIE_ABO_SB_PG.GA_MODIFICA_DATOS_CLIE_PR()';
	GA_MODIFIC_DATOS_CLIEABO_SB_PG.GA_MODIFICA_DATOS_CLIE_PR( en_cod_cliente, ev_nom_email, null,ev_cod_causa, ev_tip_modi,ev_nom_usuario,LN_ind_facturaElectronica,ln_nom_email_cli, sn_cod_retorno, sv_mens_retorno, sn_num_evento );

	IF sn_cod_retorno <> 0 THEN
	  RAISE ERROR_CONTROLADO;
	END IF;

	te_cliente_fact := new fa_cliente_dto_ot();
	te_cliente_fact.cod_cliente:= EN_cod_cliente;
    te_cliente_fact.tip_distribucion := LN_ind_facturaElectronica;
    te_cliente_fact.fec_desde := SYSDATE;
    te_cliente_fact.cod_despacho:= NULL;
    te_cliente_fact.fec_hasta := NULL;
    te_cliente_fact.nom_email:= EV_nom_email;
    te_cliente_fact.nom_usuario:= EV_nom_usuario;
    te_cliente_fact.fec_ultmod:=NULL;
	LV_sql := 'FA_CLIENTES_SN_PG.FA_REGISTRA_CAMBIOS_PR()';
	FA_CLIENTES_SN_PG.FA_REGISTRA_CAMBIOS_PR( te_cliente_fact, sn_cod_retorno, sv_mens_retorno, sn_num_evento );

	IF sn_cod_retorno <> 0 THEN
	  RAISE ERROR_CONTROLADO;
	END IF;

 EXCEPTION
      WHEN ERROR_CONTROLADO THEN
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SN_PG.GA_MODIFICA_MAIL_CLIE_PR', lv_sql, SN_cod_retorno, SV_mens_retorno );


      WHEN OTHERS THEN
         SN_COD_RETORNO := 1970; -- -1000 No se pudo realizar cambio del e-mail del cliente.
  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	       SV_mens_retorno := CV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SN_PG.GA_MODIFICA_MAIL_CLIE_PR', lv_sql, SQLCODE, SQLERRM );

 END;

 PROCEDURE GA_MODIFIC_TIP_DISTRIB_CLIE_PR (EN_cod_cliente IN ge_clientes.cod_cliente%type,
                                   EV_ind_fact_Elect IN ge_clientes.ind_facturaelectronica%type,
								   EV_cod_causa IN ga_modcli.cod_causa%type,
								   EV_tip_modi  IN ga_modcli.cod_tipmodi%type,
								   EV_nom_usuario IN ge_clientes.NOM_USUARORA%type, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
 AS

 ERROR_CONTROLADO EXCEPTION;
 LV_sql varchar2(1000);
 te_cliente_fact fa_cliente_dto_ot;
 LN_ind_facturaElectronica ge_clientes.ind_facturaelectronica%type;
  ln_nom_email_cli ge_clientes.nom_email%type;
 BEGIN
    SN_cod_retorno := 0;
	SV_mens_retorno := NULL;
	SN_num_evento := 0;

	LV_sql := 'GA_MODIF_DATOS_CLIE_ABO_SB_PG.GA_MODIFICA_DATOS_CLIE_PR()';
	GA_MODIFIC_DATOS_CLIEABO_SB_PG.GA_MODIFICA_DATOS_CLIE_PR( en_cod_cliente, null, ev_ind_fact_elect,ev_cod_causa,ev_tip_modi, ev_nom_usuario,LN_ind_facturaElectronica, ln_nom_email_cli,sn_cod_retorno, sv_mens_retorno, sn_num_evento );

	IF sn_cod_retorno <> 0 THEN
	  RAISE ERROR_CONTROLADO;
	END IF;

	te_cliente_fact := new fa_cliente_dto_ot();
	te_cliente_fact.cod_cliente:= EN_cod_cliente;
    te_cliente_fact.tip_distribucion :=EV_ind_fact_Elect;
    te_cliente_fact.fec_desde := SYSDATE;
    te_cliente_fact.cod_despacho:= NULL;
    te_cliente_fact.fec_hasta := NULL;
    te_cliente_fact.nom_email:= ln_nom_email_cli;
    te_cliente_fact.nom_usuario:= EV_nom_usuario;
    te_cliente_fact.fec_ultmod:=NULL;
	LV_sql := 'FA_CLIENTES_SN_PG.FA_REGISTRA_CAMBIOS_PR()';
	FA_CLIENTES_SN_PG.FA_REGISTRA_CAMBIOS_PR( te_cliente_fact, sn_cod_retorno, sv_mens_retorno, sn_num_evento );

	IF sn_cod_retorno <> 0 THEN
	  RAISE ERROR_CONTROLADO;
	END IF;

 EXCEPTION
      WHEN ERROR_CONTROLADO THEN
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SN_PG.GA_MODIFICA_MAIL_CLIE_PR', lv_sql, SN_cod_retorno, SV_mens_retorno );


      WHEN OTHERS THEN
         SN_COD_RETORNO := 1971; -- -2000 No se pudo realizar cambio del indicador de facturación electrónica del cliente..
  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	       SV_mens_retorno := CV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SN_PG.GA_MODIFICA_MAIL_CLIE_PR', lv_sql, SQLCODE, SQLERRM );

 END;

 PROCEDURE GA_MODIFICA_MAIL_USUARIO_PR (EN_num_celular IN ga_abocel.num_celular%type,
                                   EV_email IN ga_modusuarios.email%type,
								   EV_cod_causa IN ga_modusuarios.cod_causa%type,
								   EV_tip_modi  IN ga_modusuarios.cod_tipmodi%type,
								   EV_nom_usuario IN ga_modusuarios.nom_usuarora%type,
								   SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
 AS
 ERROR_CONTROLADO EXCEPTION;
 LV_sql varchar2(1000);

 BEGIN
    SN_cod_retorno := 0;
	SV_mens_retorno := NULL;
	SN_num_evento := 0;

	LV_sql := 'GA_MODIF_DATOS_CLIE_ABO_SB_PG.GA_MODIFICA_DATOS_USUA_PR()';
	GA_MODIFIC_DATOS_CLIEABO_SB_PG.GA_MODIFICA_DATOS_USUA_PR( en_num_celular, ev_email, ev_cod_causa,ev_tip_modi, ev_nom_usuario, sn_cod_retorno, sv_mens_retorno, sn_num_evento );

	IF sn_cod_retorno <> 0 THEN
	  RAISE ERROR_CONTROLADO;
	END IF;


 EXCEPTION
      WHEN ERROR_CONTROLADO THEN
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SN_PG.GA_MODIFICA_MAIL_CLIE_PR', lv_sql, SN_cod_retorno, SV_mens_retorno );
      WHEN OTHERS THEN
         SN_COD_RETORNO := 1972; -- -3000 No se pudo realizar cambio del e-mail del usuario.
  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	       SV_mens_retorno := CV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SN_PG.GA_MODIFICA_MAIL_CLIE_PR', lv_sql, SQLCODE, SQLERRM );

 END;
END;
/
SHOW ERRORS
