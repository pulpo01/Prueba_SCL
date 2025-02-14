CREATE OR REPLACE PACKAGE GA_cuentas_i_PG IS

        /*
		<Documentación TipoDoc = "ga_cuentas_i_PG
		<Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="28-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripción> Encabezado de VE_GA_CUENTAS_I_PG /Descripción>
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
                          );
END GA_cuentas_i_PG;
/
SHOW ERRORS
