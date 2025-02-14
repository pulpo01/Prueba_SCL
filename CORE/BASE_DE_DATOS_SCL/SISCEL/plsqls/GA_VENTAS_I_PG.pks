CREATE OR REPLACE PACKAGE GA_ventas_i_PG IS

        /*
		<Documentación TipoDoc = "GA_ventas_i_PG
		<Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="28-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripción> Encabezado de GA_ventas_i_PG/Descripción>
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

PROCEDURE GA_agregar_PR(EN_numventa          IN ga_ventas.num_venta%TYPE,
					    EV_codproducto       IN ga_ventas.cod_producto%TYPE,
					    EV_codoficina        IN ga_ventas.cod_oficina%TYPE,
					    EV_codtipcomis       IN ga_ventas.cod_tipcomis%TYPE,
					    EV_codvendedor       IN ga_ventas.cod_vendedor%TYPE,
					    EV_codvendedoragente IN ga_ventas.cod_vendedor_agente%TYPE,
					    EN_numunidades       IN ga_ventas.num_unidades%TYPE,
					 	ED_fecventa          IN ga_ventas.fec_venta%TYPE,
					 	EV_codregion         IN ga_ventas.cod_region%TYPE,
					 	EV_codprovincia      IN ga_ventas.cod_provincia%TYPE,
					 	EV_codciudad         IN ga_ventas.cod_ciudad%TYPE,
					 	EV_indestventa       IN ga_ventas.ind_estventa%TYPE,
					 	EN_numtransaccion    IN ga_ventas.num_transaccion%TYPE,
					 	EV_indpasocob        IN ga_ventas.ind_pasocob%TYPE,
					 	EV_nomusuarvta       IN ga_ventas.nom_usuar_vta%TYPE,
					 	EV_indventa          IN ga_ventas.ind_venta%TYPE,
					 	EV_codmoneda         IN ga_ventas.cod_moneda%TYPE,
					 	EV_codcausarec       IN ga_ventas.cod_causarec%TYPE,
					 	EN_impventa          IN ga_ventas.imp_venta%TYPE,
					 	EV_codtipcontrato    IN ga_ventas.cod_tipcontrato%TYPE,
					 	EV_numcontrato       IN ga_ventas.num_contrato%TYPE,
					 	EV_indtipventa       IN ga_ventas.ind_tipventa%TYPE,
					 	EV_codcliente        IN ga_ventas.cod_cliente%TYPE,
					 	EV_codmodventa       IN ga_ventas.cod_modventa%TYPE,
					 	EV_tipvalor          IN ga_ventas.tip_valor%TYPE,
					 	EV_codcuota          IN ga_ventas.cod_cuota%TYPE,
					 	EV_codtiptarjeta     IN ga_ventas.cod_tiptarjeta%TYPE,
					 	EV_numtarjeta        IN ga_ventas.num_tarjeta%TYPE,
					 	EV_codauttarj        IN ga_ventas.cod_auttarj%TYPE,
					 	EV_fecvencitarj      IN ga_ventas.fec_vencitarj%TYPE,
					 	EV_codbancotarj      IN ga_ventas.cod_bancotarj%TYPE,
					 	EV_numctacorr        IN ga_ventas.num_ctacorr%TYPE,
					 	EV_numcheque         IN ga_ventas.num_cheque%TYPE,
					 	EV_codbanco          IN ga_ventas.cod_banco%TYPE,
					 	EV_codsucursal       IN ga_ventas.cod_sucursal%TYPE,
					 	ED_feccumplimenta    IN ga_ventas.fec_cumplimenta%TYPE,
					 	ED_fecrecdocum       IN ga_ventas.fec_recdocum%TYPE,
					 	ED_fecaceprec        IN ga_ventas.fec_aceprec%TYPE,
					 	EV_nomusuaracerec    IN ga_ventas.nom_usuar_acerec%TYPE,
					 	EV_nomusuarrecdoc    IN ga_ventas.nom_usuar_recdoc%TYPE,
					 	EV_nomusuarcumpl     IN ga_ventas.nom_usuar_cumpl%TYPE,
					 	EV_indofiter         IN ga_ventas.ind_ofiter%TYPE,
					 	EV_indchkdicom       IN ga_ventas.ind_chkdicom%TYPE,
					 	EV_numconsulta       IN ga_ventas.num_consulta%TYPE,
						EV_codvendealer      IN ga_ventas.cod_vendealer%TYPE,
					    EV_numfoldealer      IN ga_ventas.num_foldealer%TYPE,
					    EV_coddocdealer      IN ga_ventas.cod_docdealer%TYPE,
					 	EV_inddoccomp        IN ga_ventas.ind_doccomp%TYPE,
					 	EV_obsincump         IN ga_ventas.obs_incump%TYPE,
					 	EV_codcausarep       IN ga_ventas.cod_causarep%TYPE,
					 	ED_fecrecprov        IN ga_ventas.fec_recprov%TYPE,
					 	EV_nomusuarrecprov   IN ga_ventas.nom_usuar_recprov%TYPE,
					 	EV_numdias           IN ga_ventas.num_dias%TYPE,
					 	EV_obsrecprov        IN ga_ventas.obs_recprov%TYPE,
					 	EV_impabono          IN ga_ventas.imp_abono%TYPE,
					 	EV_indabono          IN ga_ventas.ind_abono%TYPE,
					 	EV_fecrecepadmvtas   IN ga_ventas.fec_recep_admvtas%TYPE,
					 	EV_usurecepadmvtas   IN ga_ventas.usu_recep_admvtas%TYPE,
					 	EV_obsgralcumpl      IN ga_ventas.obs_gralcumpl%TYPE,
					 	EV_indconttelef      IN ga_ventas.ind_cont_telef%TYPE,
					 	ED_fechaconttelef    IN ga_ventas.fecha_cont_telef%TYPE,
					 	EV_usuarioconttelef  IN ga_ventas.usuario_cont_telef%TYPE,
					 	EN_mtogarantia       IN ga_ventas.mto_garantia%TYPE,
					 	EV_tipfoliacion      IN ga_ventas.tip_foliacion%TYPE,
					 	EV_codtipdocum       IN ga_ventas.cod_tipdocum%TYPE,
					 	EV_codplaza          IN ga_ventas.cod_plaza%TYPE,
					 	EV_codoperadora      IN ga_ventas.cod_operadora%TYPE,
					 	EV_numproceso        IN ga_ventas.num_proceso%TYPE,
					 	SV_error             OUT NOCOPY VARCHAR2
                       );
END GA_ventas_i_PG;
/
SHOW ERRORS
