CREATE OR REPLACE PACKAGE GE_clientes_i_PG IS

        /*
		<Documentación TipoDoc = "ge_clientes_i_PG
		<Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="28-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripción> Encabezado de GE_clientes_i_PG/Descripción>
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

PROCEDURE GE_agregar_PR(EN_codcliente           IN ge_clientes.cod_cliente%TYPE,
	   	  		  	    EV_nomcliente           IN ge_clientes.nom_apeclien1%TYPE,
					    EV_codtipident          IN ge_clientes.cod_tipident%TYPE,
					    EV_numident             IN ge_clientes.num_ident%TYPE,
					    EV_codcalclien          IN ge_clientes.cod_calclien%TYPE,
					    EV_indsituacion         IN ge_clientes.ind_situacion%TYPE,
		   		  	 	ED_fecalta              IN ge_clientes.fec_alta%TYPE,
					 	EV_indfactur            IN ge_clientes.ind_factur%TYPE,
					 	EV_indtraspaso          IN ge_clientes.ind_traspaso%TYPE,
					 	EV_indagente            IN ge_clientes.ind_agente%TYPE,
					 	ED_fecultmod            IN ge_clientes.fec_ultmod%TYPE,
					 	EV_numfax               IN ge_clientes.num_fax%TYPE,
					 	EV_indmandato           IN ge_clientes.ind_mandato%TYPE,
					 	EV_nomusuarora          IN ge_clientes.nom_usuarora%TYPE,
					 	EV_indalta              IN ge_clientes.ind_alta%TYPE,
					 	EV_codcuenta            IN ge_clientes.cod_cuenta%TYPE,
					 	EV_indacepvent          IN ge_clientes.ind_acepvent%TYPE,
					 	EV_codabc               IN ge_clientes.cod_abc%TYPE,
						EV_cod123               IN ge_clientes.cod_123%TYPE,
					    EV_codactividad         IN ge_clientes.cod_actividad%TYPE,
					    EV_codpais              IN ge_clientes.cod_pais%TYPE,
					    EV_tefcliente1          IN ge_clientes.tef_cliente1%TYPE,
					 	EV_numabocel            IN ge_clientes.num_abocel%TYPE,
					 	EV_tefcliente2          IN ge_clientes.tef_cliente2%TYPE,
					 	EV_numabobeep           IN ge_clientes.num_abobeep%TYPE,
					 	EV_inddebito            IN ge_clientes.ind_debito%TYPE,
					 	EV_numabotrunk          IN ge_clientes.num_abotrunk%TYPE,
					 	EV_codprospecto         IN ge_clientes.cod_prospecto%TYPE,
 					 	EV_numabotrek           IN ge_clientes.num_abotrek%TYPE,
					 	EV_codsispago           IN ge_clientes.cod_sispago%TYPE,
					 	EV_nomapeclien1         IN ge_clientes.nom_apeclien1%TYPE,
					 	EV_nomemail             IN ge_clientes.nom_email%TYPE,
					 	EV_numaborent           IN ge_clientes.num_aborent%TYPE,
					 	EV_nomapeclien2         IN ge_clientes.nom_apeclien2%TYPE,
					 	EV_numaboroaming        IN ge_clientes.num_aboroaming%TYPE,
					 	ED_fecacepvent          IN ge_clientes.fec_acepvent%TYPE,
					 	EV_impstopdebit         IN ge_clientes.imp_stopdebit%TYPE,
					 	EV_codbanco             IN ge_clientes.cod_banco%TYPE,
					 	EV_codsucursal          IN ge_clientes.cod_sucursal%TYPE,
					 	EV_indtipcuenta         IN ge_clientes.ind_tipcuenta%TYPE,
					 	EV_codtiptarjeta        IN ge_clientes.cod_tiptarjeta%TYPE,
				     	EV_numctacorr           IN ge_clientes.num_ctacorr%TYPE,
					 	EV_numtarjeta           IN ge_clientes.num_tarjeta%TYPE,
					 	ED_fecvencitarj         IN ge_clientes.fec_vencitarj%TYPE,
					 	EV_codbancotarj         IN ge_clientes.cod_bancotarj%TYPE,
					 	EV_codtipidtrib         IN ge_clientes.cod_tipidtrib%TYPE,
					 	EV_numidenttrib         IN ge_clientes.num_identtrib%TYPE,
					 	EV_codtipidentapor      IN ge_clientes.cod_tipidentapor%TYPE,
					 	EV_numidentapor         IN ge_clientes.num_identapor%TYPE,
					 	EV_nomapoderado         IN ge_clientes.nom_apoderado%TYPE,
				 	 	EV_codoficina           IN ge_clientes.cod_oficina%TYPE,
					 	ED_fecbaja              IN ge_clientes.fec_baja%TYPE,
					 	EV_codcobrador          IN ge_clientes.cod_cobrador%TYPE,
					 	EV_codpincli            IN ge_clientes.cod_pincli%TYPE,
					 	EV_codciclo             IN ge_clientes.cod_ciclo%TYPE,
					 	EN_numcelular           IN ge_clientes.num_celular%TYPE,
					 	EV_indtippersona        IN ge_clientes.ind_tippersona%TYPE,
					 	EV_codciclonue          IN ge_clientes.cod_ciclonue%TYPE,
					 	EV_codcategoria         IN ge_clientes.cod_categoria%TYPE,
					 	EV_codsector            IN ge_clientes.cod_sector%TYPE,
					 	EV_codsupervisor        IN ge_clientes.cod_supervisor%TYPE,
					 	EV_indestcivil          IN ge_clientes.ind_estcivil%TYPE,
					 	ED_fecnacimien          IN ge_clientes.fec_nacimien%TYPE,
					 	EV_indsexo              IN ge_clientes.ind_sexo%TYPE,
					 	EV_numintgrupfam        IN ge_clientes.num_int_grup_fam%TYPE,
					 	EV_codnpi               IN ge_clientes.cod_npi%TYPE,
					 	EV_codsubcategoria      IN ge_clientes.cod_subcategoria%TYPE,
				 	 	EV_coduso               IN ge_clientes.cod_uso%TYPE,
					 	EV_codidioma            IN ge_clientes.cod_idioma%TYPE,
					 	EV_codtipident2         IN ge_clientes.cod_tipident2%TYPE,
					 	EV_numident2            IN ge_clientes.num_ident2%TYPE,
				 	 	EV_nomusuarioasesor     IN ge_clientes.nom_usuario_asesor%TYPE,
					 	EV_codoperadora         IN ge_clientes.cod_operadora%TYPE,
					 	SV_error                OUT NOCOPY VARCHAR2
                       );


END GE_clientes_i_PG;
/
SHOW ERRORS
