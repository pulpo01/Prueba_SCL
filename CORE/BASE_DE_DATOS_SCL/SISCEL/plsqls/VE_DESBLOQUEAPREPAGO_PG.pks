CREATE OR REPLACE PACKAGE VE_desbloqueaprepago_PG IS
        /*
		<Documentación TipoDoc = "VE_desbloqueaprepago_PG>
		<Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="21-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD>
		<Retorno>NA</Retorno>
		<Descripción> Encabezado de VE_desbloqueaprepago_PG</Descripción>
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

	PROCEDURE VE_desbloqueo_PR(EV_codvendealer IN ve_vendealer.cod_vendealer%TYPE,
		                       EV_tipident IN ge_clientes.cod_tipident%TYPE,
                               EV_numident IN ge_clientes.num_ident%TYPE,
							   EV_imsi IN ga_aboamist.num_serie%TYPE,
							   EV_apeclien1 IN ge_clientes.nom_apeclien1%TYPE,
							   EV_codplantarif IN icc_movimiento.plan%TYPE,
							   SN_codcliente OUT NOCOPY ge_clientes.cod_cliente%TYPE,
							   SN_numventa OUT NOCOPY ga_ventas.num_venta%TYPE,
							   SN_numcelular OUT NOCOPY ga_aboamist.num_celular%TYPE,
							   SD_fecalta OUT NOCOPY ga_aboamist.fec_alta%TYPE,
                               SV_error OUT NOCOPY VARCHAR2,
							   SN_coderror OUT NOCOPY NUMBER
                              );

    PROCEDURE VE_insertamovimiento_PR(EN_numabonado IN ga_aboamist.num_abonado%TYPE, EV_codtecno IN ga_aboamist.cod_tecnologia%TYPE,
									  EV_tipterminal IN ga_aboamist.tip_terminal%TYPE, EV_numseriehex IN ga_aboamist.num_seriehex%TYPE,
									  EV_codcentral IN ga_aboamist.cod_central%TYPE, EV_numcelular IN ga_aboamist.num_celular%TYPE,
									  EV_codplantarif IN icc_movimiento.plan%TYPE, SV_error OUT NOCOPY VARCHAR2
                                     );

	PROCEDURE VE_obtienenumabonado_PR(EV_codcliente_dist IN ga_aboamist.cod_cuenta_dist%TYPE, EV_imsi IN ga_aboamist.num_imei%TYPE,
                                      SV_numabonado OUT NOCOPY ga_aboamist.num_abonado%TYPE, SV_codtecno OUT NOCOPY ga_aboamist.cod_tecnologia%TYPE,
									  SV_tipterminal OUT NOCOPY ga_aboamist.tip_terminal%TYPE, SV_numseriehex OUT NOCOPY ga_aboamist.num_seriehex%TYPE,
									  SV_codcentral OUT NOCOPY ga_aboamist.cod_central%TYPE, SV_numcelular OUT NOCOPY ga_aboamist.num_celular%TYPE,
									  SV_nummin OUT NOCOPY ga_aboamist.num_min%TYPE, SV_error OUT NOCOPY VARCHAR2
                                     );

    PROCEDURE VE_existecliente_PR(EV_numident IN ga_cuentas.num_ident%TYPE, EV_tipident IN ga_cuentas.cod_tipident%TYPE,
								  SV_codcliente OUT NOCOPY ge_clientes.cod_cliente%TYPE, SV_codcuenta OUT nocopy ga_cuentas.cod_cuenta%TYPE,
								  SV_error OUT NOCOPY VARCHAR2
                                 );

	PROCEDURE VE_modificaabonadoprepago_PR(EV_codcliente IN ge_clientes.cod_cliente%TYPE, EV_codcuenta IN ga_cuentas.cod_cuenta%TYPE,
										   EV_codvendedor IN ga_aboamist.cod_vendedor%TYPE, EV_numventa IN ga_aboamist.num_venta%TYPE,
										   EV_numabonado IN ga_aboamist.num_abonado%TYPE, SV_error OUT NOCOPY VARCHAR2
                                          );


    PROCEDURE VE_generaventacero_PR (EN_numabonado IN ga_aboamist.num_abonado%TYPE, SN_numventa OUT NOCOPY ga_aboamist.num_venta%TYPE,
                                     SV_error OUT NOCOPY VARCHAR2
									);

	PROCEDURE VE_creacuenta_PR(EV_descta IN ga_cuentas.des_cuenta%TYPE, EV_nomresp IN ga_cuentas.nom_responsable%TYPE,
							   EV_numident IN GA_cuentas.num_ident%TYPE, EV_tipident IN ga_cuentas.cod_tipident%TYPE,
							   EV_coddireccion IN ga_cuentas.cod_direccion%TYPE, SV_codcta OUT NOCOPY ga_cuentas.cod_cuenta%TYPE,
							   SV_error OUT NOCOPY VARCHAR2
                              );

    PROCEDURE VE_creacliente_PR(EV_codcta IN ga_cuentas.cod_cuenta%TYPE,
                                EV_nomcliente IN ge_clientes.NOM_APECLIEN1%TYPE,
                                EV_numident IN ge_clientes.num_ident%TYPE,
								EV_tipident IN ge_clientes.cod_tipident%TYPE,
								SV_codcliente OUT NOCOPY ge_clientes.cod_cliente%TYPE,
                                SV_error OUT NOCOPY VARCHAR2
                               );

END VE_desbloqueaprepago_PG;
/
SHOW ERRORS
