CREATE OR REPLACE PACKAGE BODY GE_clientes_i_PG IS

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
                       ) IS

/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "GE_agregar_PR" Lenguaje="PL/SQL" Fecha="28/06/2005" Versión="1.0.0" Diseñador=""Rayen Ceballos Programador="Roberto Perez" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Ingresar datos GE_CLIENTES</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_CODCLIENTE"            Tipo="NUMBER">codigo cliente</param>
<param nom="EV_NOMCLIENTE"            Tipo="VARCHAR2">nombre cliente</param>
<param nom="EV_CODTIPIDENT"           Tipo="VARCHAR2">tipo cuenta</param>
<param nom="EV_NUMIDENT"              Tipo="VARCHAR2">numero identidad</param>
<param nom="EV_CODCALCLIEN"           Tipo="VARCHAR2">codigo calidad cliente</param>
<param nom="EV_INDSITUACION"          Tipo="VARCHAR2">indicador situacion</param>
<param nom="ED_FECALTA"               Tipo="DATE">fecha alta</param>
<param nom="EV_INDFACTUR"             Tipo="VARCHAR2">indicador facturacion</param>
<param nom="EV_INDTRASPASO"           Tipo="VARCHAR2">indicador traspaso</param>
<param nom="EV_INDAGENTE"             Tipo="VARCHAR2">indicador agente</param>
<param nom="ED_FECULTMOD"             Tipo="DATE">fecha ultima modificacion</param>
<param nom="EV_NUMFAX"                Tipo="VARCHAR2">numero de fax</param>
<param nom="EV_INDMANDATO"            Tipo="VARCHAR2">indicador mandato</param
<param nom="EV_NOMUSUARORA"          Tipo="VARCHAR2">usuario oracle</param>
<param nom="EV_INDALTA"              Tipo="VARCHAR2">indicador alta</param>
<param nom="EV_CODCUENTA"            Tipo="VARCHAR2">codigo cuenta</param>
<param nom="EV_INDACEPVENT"           Tipo="VARCHAR2">indicadior aceptacion venta</param>
<param nom="EV_CODABC"               Tipo="VARCHAR2">codigo clasificacion abc</param>
<param nom="EV_COD123"                Tipo="VARCHAR2">codigo clasificacion 123</param>
<param nom="EV_CODACTIVIDAD"          Tipo="VARCHAR2">codigo actividad</param>
<param nom="EV_CODPAIS"               Tipo="VARCHAR2">codigo pais</param>
<param nom="EV_TEFCLIENTE1"          Tipo="VARCHAR2">telefono particular cliente</param>
<param nom="EV_NUMABOCEL"             Tipo="VARCHAR2">numero abonados</param>
<param nom="EV_TEFCLIENTE2"          Tipo="VARCHAR2">telefono cliente</param>
<param nom="EV_NUMABOBEEP"           Tipo="VARCHAR2">numero abonados beeper</param>
<param nom="EV_INDDEBITO"             Tipo="VARCHAR2">indicadior debito</param>
<param nom="EV_NUMABOTRUNK"          Tipo="VARCHAR2">numero abonados trunking</param>
<param nom="EV_CODPROSPECTO"         Tipo="VARCHAR2">codigo prospecto</param>
<param nom="EV_NUMABOTREK"           Tipo="VARCHAR2">numero abonados trek</param>
<param nom="EV_CODSISPAGO"            Tipo="VARCHAR2">codigo sistema pago</param>
<param nom="EV_NOMAPECLIEN1"         Tipo="VARCHAR2">apellido paterno cliente</param>
<param nom="EV_NOMEMAIL"              Tipo="VARCHAR2">e-mail cliente</param>
<param nom="EV_INDSEXO"              Tipo="VARCHAR2">indicador sexo</param>
<param nom="EV_NUMINTGRUPFAM"        Tipo="VARCHAR2">numero de integrantes del grupo familiar</param>
<param nom="EV_CODNPI"               Tipo="VARCHAR2">indicador privacidad</param>
<param nom="EV_CODSUBCATEGORIA"      Tipo="VARCHAR2">codigo subcategoria</param>
<param nom="EV_CODUSO"               Tipo="VARCHAR2">codigo uso</param>
<param nom="EV_CODIDIOMA"            Tipo="VARCHAR2">codigo idioma</param>
<param nom="EV_CODTIPIDENT2"         Tipo="VARCHAR2">tipo identidad 2</param>
<param nom="EV_NUMIDENT2"            Tipo="VARCHAR2">tipo identidad 2</param>
<param nom="EV_NOMUSUARIOASESOR"     Tipo="VARCHAR2">nombre usuario asesor</param>
<param nom="EV_CODOPERADORA"         Tipo="VARCHAR2">codigo operadora</param>
</Entrada>
<Salida>
<param nom="SV_ERROR" Tipo="VARCHAR2">mensaje del error</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/


BEGIN
        INSERT INTO ge_clientes (cod_cliente, nom_cliente, cod_tipident, num_ident, cod_calclien, ind_situacion,
		   		  	   			 fec_alta, ind_factur, ind_traspaso, ind_agente, fec_ultmod, num_fax, ind_mandato,
								 nom_usuarora, ind_alta, cod_cuenta, ind_acepvent, cod_abc, cod_123, cod_actividad,
								 cod_pais, tef_cliente1, num_abocel, tef_cliente2, num_abobeep, ind_debito,
								 num_abotrunk, cod_prospecto, num_abotrek, cod_sispago, nom_apeclien1, nom_email,
								 num_aborent, nom_apeclien2, num_aboroaming, fec_acepvent, imp_stopdebit, cod_banco,
								 cod_sucursal, ind_tipcuenta, cod_tiptarjeta, num_ctacorr, num_tarjeta,
								 fec_vencitarj, cod_bancotarj, cod_tipidtrib, num_identtrib, cod_tipidentapor,
								 num_identapor, nom_apoderado, cod_oficina, fec_baja, cod_cobrador, cod_pincli,
								 cod_ciclo, num_celular, ind_tippersona, cod_ciclonue, cod_categoria, cod_sector,
								 cod_supervisor, ind_estcivil, fec_nacimien, ind_sexo, num_int_grup_fam, cod_npi,
								 cod_subcategoria, cod_uso, cod_idioma, cod_tipident2, num_ident2,
								 nom_usuario_asesor, cod_operadora
								)
		   VALUES (EN_codcliente, EV_nomcliente, EV_codtipident, EV_numident, EV_codcalclien, EV_indsituacion,
                   ED_fecalta, EV_indfactur, EV_indtraspaso, EV_indagente, ED_fecultmod, EV_numfax, EV_indmandato,
				   EV_nomusuarora, EV_indalta, EV_codcuenta, EV_indacepvent, EV_codabc, EV_cod123, EV_codactividad,
				   EV_codpais, EV_tefcliente1, EV_numabocel, EV_tefcliente2, EV_numabobeep, EV_inddebito,
				   EV_numabotrunk, EV_codprospecto, EV_numabotrek, EV_codsispago, EV_nomapeclien1, EV_nomemail,
				   EV_numaborent, EV_nomapeclien2, EV_numaboroaming, ED_fecacepvent, EV_impstopdebit, EV_codbanco,
				   EV_codsucursal, EV_indtipcuenta, EV_codtiptarjeta, EV_numctacorr, EV_numtarjeta, ED_fecvencitarj,
				   EV_codbancotarj, EV_codtipidtrib, EV_numidenttrib, EV_codtipidentapor, EV_numidentapor,
				   EV_nomapoderado, EV_codoficina, ED_fecbaja, EV_codcobrador, EV_codpincli, EV_codciclo,
				   EN_numcelular, EV_indtippersona, EV_codciclonue, EV_codcategoria, EV_codsector, EV_codsupervisor,
				   EV_indestcivil, ED_fecnacimien, EV_indsexo, EV_numintgrupfam, EV_codnpi, EV_codsubcategoria,
				   EV_coduso, EV_codidioma, EV_codtipident2, EV_numident2, EV_nomusuarioasesor, EV_codoperadora);

          EXCEPTION
		      WHEN OTHERS THEN
		         SV_error:='GE_CLIENTES_I_PG.GE_AGREGAR_PR: '  || TO_CHAR(SQLCODE) || ' ' || SQLERRM;
END GE_agregar_PR;

END GE_clientes_i_PG;
/
SHOW ERRORS
