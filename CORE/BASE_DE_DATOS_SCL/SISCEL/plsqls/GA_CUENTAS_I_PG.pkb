CREATE OR REPLACE PACKAGE BODY GA_cuentas_i_PG IS

PROCEDURE GA_agregar_PR(EV_codcuenta            IN ga_cuentas.cod_cuenta%TYPE,
                        EV_descuenta            IN ga_cuentas.des_cuenta%TYPE,
					    EV_tipcuenta            IN ga_cuentas.tip_cuenta%TYPE,
					    EV_nomresp              IN ga_cuentas.nom_responsable%TYPE,
					    EV_tipident             IN ga_cuentas.cod_tipident%TYPE,
					 	EV_numident             IN ga_cuentas.num_ident%TYPE,
			         	EV_coddireccion         IN ga_cuentas.cod_direccion%TYPE,
					 	ED_fecalta              IN ga_cuentas.fec_alta%TYPE,
					 	EV_indestado            IN ga_cuentas.ind_estado%TYPE,
					 	EV_telcontacto          IN ga_cuentas.tel_contacto%TYPE,
					 	EV_indsector            IN ga_cuentas.ind_sector%TYPE,
					 	EV_codclascta           IN ga_cuentas.cod_clascta%TYPE,
					 	EV_codcatribut          IN ga_cuentas.cod_catribut%TYPE,
					 	EV_codcategoria         IN ga_cuentas.cod_categoria%TYPE,
					 	EV_codsector            IN ga_cuentas.cod_sector%TYPE,
					 	EV_codsubcategoria      IN ga_cuentas.cod_subcategoria%TYPE,
					 	EV_indmultuso           IN ga_cuentas.ind_multuso%TYPE,
					 	EV_indcliepotencial     IN ga_cuentas.ind_cliepotencial%TYPE,
					 	EV_desrazonsocial       IN ga_cuentas.des_razon_social%TYPE,
					 	ED_fecinivtapac         IN ga_cuentas.fec_inivta_pac%TYPE,
					 	EV_codtipcomis          IN ga_cuentas.cod_tipcomis%TYPE,
					 	EV_nomusuarioasesor     IN ga_cuentas.nom_usuario_asesor%TYPE,
					 	ED_fecnacimiento        IN ga_cuentas.fec_nacimiento%TYPE,
					 	SV_error                OUT NOCOPY VARCHAR2
                       ) IS


/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "GA_AGREGAR_PR" Lenguaje="PL/SQL" Fecha="28/06/2005" Versión="1.0.0" Diseñador=""Rayen Ceballos Programador="Roberto Perez" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Ingresar datos GA_VENTAS</Descripción>
<Parámetros>
<Entrada>
<param nom="ev_codcuenta" tipo="varchar2">codigo cuenta</param>
<param nom="ev_descuenta   " tipo="varchar2">descripcion cuenta</param>
<param nom="ev_tipcuenta    " tipo="varchar2">tipo cuenta</param>
<param nom="ev_nomresp    " tipo="varchar2">nombre responsable</param>
<param nom="ev_tipident" tipo="varchar2">tipo iidentidad</param>
<param nom="ev_numident  " tipo="varchar2">numero identidad</param>
<param nom="ev_coddireccion  " tipo="varchar2">codigo direccion</param>
<param nom="ed_fecalta   " tipo="date">fecha alta</param>
<param nom="ev_indestado   " tipo="varchar2">indicador estado</param>
<param nom="ev_telcontacto     " tipo="varchar2">telefono contacto</param>
<param nom="ev_indsector    " tipo="varchar2">indicador sector</param>
<param nom="ev_codclascta    " tipo="varchar2">clase cuenta</param>
<param nom="ev_codcatribut  " tipo="varchar2">codigo categoria tributaria</param>
<param nom="ev_codcategoria    " tipo="varchar2">codigo categoria</param>
<param nom="ev_codsector       " tipo="varchar2">codigo sector</param>
<param nom="ev_codsubcategoria " tipo="varchar2">codigo subcategoria</param>
<param nom="ev_indmultuso" tipo="varchar2">indicadior multiuso</param>
<param nom="ev_indcliepotencial          " tipo="varchar2">indicador de cliente potencial</param>
<param nom="ev_desrazonsocial          " tipo="varchar2">razon social</param>
<param nom="ed_fecinivtapac           " tipo="varchar2">fecha venta pac</param>
<param nom="ev_codtipcomis          " tipo="varchar2">codigo tipo comisionista</param>
<param nom="ev_nomusuarioasesor           " tipo="varchar2">nombre ussuario asesor</param>
<param nom="ed_fecnacimiento          " tipo="date">fecha nacimiento/param>
</Entrada>
<Salida>
<param nom="sv_error" Tipo="VARCHAR2">mensaje del error</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/


BEGIN
        INSERT INTO
		ga_cuentas(cod_cuenta, des_cuenta, tip_cuenta, nom_responsable, cod_tipident, num_ident,
			       cod_direccion, fec_alta, ind_estado, tel_contacto, ind_sector, cod_clascta,
				   cod_catribut, cod_categoria, cod_sector, cod_subcategoria, ind_multuso,
				   ind_cliepotencial, des_razon_social, fec_inivta_pac, cod_tipcomis,
				   nom_usuario_asesor, fec_nacimiento)
		VALUES(EV_codcuenta, EV_descuenta, EV_tipcuenta, EV_nomresp, EV_tipident, EV_numident,
			   EV_coddireccion, ED_fecalta, EV_indestado, EV_telcontacto, EV_indsector,
			   EV_codclascta, EV_codcatribut, EV_codcategoria, EV_codsector, EV_codsubcategoria,
			   EV_indmultuso, EV_indcliepotencial, EV_desrazonsocial, ED_fecinivtapac, EV_codtipcomis,
			   EV_nomusuarioasesor, ED_fecnacimiento);

	    EXCEPTION
		   WHEN OTHERS THEN
		      SV_error:='GA_cuentas_i_PG.GA_agregar_PR: '  || TO_CHAR(SQLCODE) || ' ' || SQLERRM;
END GA_agregar_PR;

END GA_cuentas_i_PG;
/
SHOW ERRORS
