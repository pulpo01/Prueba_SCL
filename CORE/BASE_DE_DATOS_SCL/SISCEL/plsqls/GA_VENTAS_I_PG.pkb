CREATE OR REPLACE PACKAGE BODY GA_ventas_i_PG IS

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
                       ) IS

/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "GA_AGREGAR_PR" Lenguaje="PL/SQL" Fecha="28/06/2005" Versión="1.0.0" Diseñador=""Rayen Ceballos Programador="Roberto Perez" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Ingresar datos GA_VENTAS</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUMVENTA          "        Tipo="NUMBER">numero de venta</param>
<param nom="EV_CODPRODUCTO       "        Tipo="VARCHAR">codigo producto</param>
<param nom="EV_CODOFICINA        "        Tipo="VARCHAR">codigo oficina</param>
<param nom="EV_CODTIPCOMIS       "        Tipo="VARCHAR">codigo tipo comisionista</param>
<param nom="EV_CODVENDEDOR       "        Tipo="VARCHAR">codigo vendedor</param>
<param nom="EV_CODVENDEDORAGENTE "        Tipo="VARCHAR">codigo vendedor agente/param>
<param nom="EN_NUMUNIDADES       "        Tipo="NUMBER">numero de unidades</param>
<param nom="ED_FECVENTA          "        Tipo="DATE">fecha venta</param>
<param nom="EV_CODREGION         "        Tipo="VARCHAR">codigo region</param>
<param nom="EV_CODPROVINCIA      "        Tipo="VARCHAR">codigo provincia</param>
<param nom="EV_CODCIUDAD         "        Tipo="VARCHAR">codigo ciudad</param>
<param nom="EV_INDESTVENTA       "        Tipo="VARCHAR">indicador estado venta</param>
<param nom="EN_NUMTRANSACCION    "        Tipo="NUMBER">numero de transaccion</param>
<param nom="EV_INDPASOCOB        "        Tipo="VARCHAR">indicador paso cobros</param>
<param nom="EV_NOMUSUARVTA       "        Tipo="VARCHAR">nombre usuario venta</param>
<param nom="EV_INDVENTA          "        Tipo="VARCHAR">indicador venta</param>
<param nom="EV_CODMONEDA         "        Tipo="VARCHAR">codigo moneda</param>
<param nom="EV_CODCAUSAREC       "        Tipo="VARCHAR">codigo causa</param>
<param nom="EN_IMPVENTA          "        Tipo="number">importe de la venta</param>
<param nom="EV_CODTIPCONTRATO    "        Tipo="VARCHAR">codigo tipo contrato</param>
<param nom="EV_NUMCONTRATO       "        Tipo="VARCHAR">numero contrato</param>
<param nom="EV_INDTIPVENTA       "        Tipo="VARCHAR">indicador tipo venta</param>
<param nom="EV_CODCLIENTE        "        Tipo="VARCHAR">codigo cliente</param>
<param nom="EV_CODMODVENTA       "        Tipo="VARCHAR">codigo modalidad venta</param>
<param nom="EV_TIPVALOR          "        Tipo="VARCHAR">tipo valor</param>
<param nom="EV_CODCUOTA          "        Tipo="VARCHAR">codigo cuota</param>
<param nom="EV_CODTIPTARJETA     "        Tipo="VARCHAR">codigo tipo tarjeta</param>
<param nom="EV_NUMTARJETA        "        Tipo="VARCHAR">numero tarjeta</param>
<param nom="EV_CODAUTTARJ        "        Tipo="VARCHAR">codigo autorizacion tarjeta</param>
<param nom="EV_FECVENCITARJ      "        Tipo="DATE">fecha vencimiento tarjeta</param>
<param nom="EV_CODBANCOTARJ      "        Tipo="VARCHAR">codigo banco tarjeta</param>
<param nom="EV_NUMCTACORR        "        Tipo="VARCHAR">numero cuenta corriente</param>
<param nom="EV_NUMCHEQUE         "        Tipo="VARCHAR">numero cheque</param>
<param nom="EV_CODBANCO          "        Tipo="VARCHAR">codigo banco</param>
<param nom="EV_CODSUCURSAL       "        Tipo="VARCHAR">codigo sucursal</param>
<param nom="ED_FECCUMPLIMENTA    "        Tipo="DATE">fecha cumplimentacion</param>
<param nom="ED_FECRECDOCUM       "        Tipo="DATE">fecha recepcion decumentos</param>
<param nom="ED_FECACEPREC        "        Tipo="DATE">fecha aceptacion</param>
<param nom="EV_NOMUSUARACEREC    "        Tipo="VARCHAR">nombre usuario aceptacion</param>
<param nom="EV_NOMUSUARRECDOC    "        Tipo="VARCHAR">nombre usuario recepcion documentos</param>
<param nom="EV_NOMUSUARCUMPL     "        Tipo="VARCHAR">nombre usuario cumplimentacion</param>
<param nom="EV_INDOFITER         "        Tipo="VARCHAR">indicador oficina / terreno</param>
<param nom="EV_INDCHKDICOM       "        Tipo="VARCHAR">indicador dicom</param>
<param nom="EV_NUMCONSULTA       "        Tipo="VARCHAR">numero consulta dicom</param>
<param nom="EV_CODVENDEALER      "        Tipo="VARCHAR">codigo vendedor dealer</param>
<param nom="EV_NUMFOLDEALER      "        Tipo="VARCHAR">numero folio dealer</param>
<param nom="EV_CODDOCDEALER      "        Tipo="VARCHAR">codigo documento dealer/param>
<param nom="EV_INDDOCCOMP        "        Tipo="VARCHAR">indicador documentacion</param>
<param nom="EV_OBSINCUMP         "        Tipo="VARCHAR">observacion</param>
<param nom="EV_CODCAUSAREP       "        Tipo="VARCHAR">codigo causa</param>
<param nom="ED_FECRECPROV        "        Tipo="DATE">fecha recepcion provisional</param>
<param nom="EV_NOMUSUARRECPROV   "        Tipo="VARCHAR">nombre usuario recepcion provisional</param>
<param nom="EV_NUMDIAS           "        Tipo="VARCHAR">numero de dias/param>
<param nom="EV_OBSRECPROV        "        Tipo="VARCHAR">observacion recepcion provisional</param>
<param nom="EV_IMPABONO          "        Tipo="VARCHAR">importe abono</param>
<param nom="EV_INDABONO          "        Tipo="VARCHAR">indicador abono/param>
<param nom="EV_FECRECEPADMVTAS   "        Tipo="DATE">fecha recepcion adm. ventas</param>
<param nom="EV_USURECEPADMVTAS   "        Tipo="VARCHAR">usuario recepcion adm. ventas</param>
<param nom="EV_OBSGRALCUMPL      "        Tipo="VARCHAR">observacion cumplimentacion/param>
<param nom="EV_INDCONTTELEF      "        Tipo="VARCHAR">indicador contrato telefono</param>
<param nom="ED_FECHACONTTELEF    "        Tipo="DATE">fecha contrato telefono</param>
<param nom="EV_USUARIOCONTTELEF  "        Tipo="VARCHAR">usuario contrato telefono</param>
<param nom="EN_MTOGARANTIA       "        Tipo="NUMBER">monto garantia</param>
<param nom="EV_TIPFOLIACION      "        Tipo="VARCHAR">tipo foliacion</param>
<param nom="EV_CODTIPDOCUM       "        Tipo="VARCHAR">codigo tipo documento</param>
<param nom="EV_CODPLAZA          "        Tipo="VARCHAR">codigo plaza</param>
<param nom="EV_CODOPERADORA      "        Tipo="VARCHAR">codigo operadorate</param>
<param nom="EV_NUMPROCESO        "        Tipo="VARCHAR">numero proceso</param>
</Entrada>
<Salida>
<param nom="SV_ERROR" Tipo="VARCHAR2">mensaje del error</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/


BEGIN

          INSERT INTO ga_ventas(num_venta, cod_producto, cod_oficina, cod_tipcomis, cod_vendedor,
           		 	            cod_vendedor_agente, num_unidades, fec_venta, cod_region,
							    cod_provincia, cod_ciudad, ind_estventa, num_transaccion,
							    ind_pasocob, nom_usuar_vta, ind_venta, cod_moneda, cod_causarec,
							    imp_venta, cod_tipcontrato, num_contrato, ind_tipventa,
							    cod_cliente, cod_modventa, tip_valor, cod_cuota, cod_tiptarjeta,
							    num_tarjeta, cod_auttarj, fec_vencitarj, cod_bancotarj, num_ctacorr,
							    num_cheque, cod_banco, cod_sucursal, fec_cumplimenta, fec_recdocum,
							    fec_aceprec, nom_usuar_acerec,nom_usuar_recdoc, nom_usuar_cumpl,
							    ind_ofiter, ind_chkdicom, num_consulta, cod_vendealer, num_foldealer,
							    cod_docdealer, ind_doccomp, obs_incump, cod_causarep, fec_recprov,
							    nom_usuar_recprov, num_dias, obs_recprov, imp_abono, ind_abono,
							    fec_recep_admvtas, usu_recep_admvtas, obs_gralcumpl, ind_cont_telef,
							    fecha_cont_telef, usuario_cont_telef, mto_garantia, tip_foliacion,
							    cod_tipdocum, cod_plaza, cod_operadora, num_proceso
		                       )
		  VALUES(EN_numventa, EV_codproducto, EV_codoficina, EV_codtipcomis, EV_codvendedor, EV_codvendedoragente,
		         EN_numunidades, ED_fecventa, EV_codregion, EV_codprovincia, EV_codciudad, EV_indestventa,
				 EN_numtransaccion, EV_indpasocob, EV_nomusuarvta, EV_indventa, EV_codmoneda, EV_codcausarec,
				 EN_impventa, EV_codtipcontrato, EV_numcontrato, EV_indtipventa, EV_codcliente, EV_codmodventa,
				 EV_tipvalor, EV_codcuota, EV_codtiptarjeta, EV_numtarjeta, EV_codauttarj, EV_fecvencitarj,
				 EV_codbancotarj, EV_numctacorr, EV_numcheque, EV_codbanco, EV_codsucursal, ED_feccumplimenta,
				 ED_fecrecdocum, ED_fecaceprec, EV_nomusuaracerec, EV_nomusuarrecdoc, EV_nomusuarcumpl,
				 EV_indofiter, EV_indchkdicom, EV_numconsulta, EV_codvendealer, EV_numfoldealer, EV_coddocdealer,
				 EV_inddoccomp, EV_obsincump, EV_codcausarep, ED_fecrecprov, EV_nomusuarrecprov, EV_numdias,
				 EV_obsrecprov, EV_impabono, EV_indabono, EV_fecrecepadmvtas, EV_usurecepadmvtas, EV_obsgralcumpl,
   				 EV_indconttelef, ED_fechaconttelef, EV_usuarioconttelef, EN_mtogarantia, EV_tipfoliacion,
				 EV_codtipdocum, EV_codplaza, EV_codoperadora, EV_numproceso
		        );

	     EXCEPTION
		    WHEN OTHERS THEN
			   SV_error:='GA_VENTAS_I_PG.GA_AGREGAR_PR: ' || TO_CHAR(SQLCODE) ||' ' || SQLERRM;

END GA_agregar_PR;

END GA_ventas_i_PG;
/
SHOW ERRORS
