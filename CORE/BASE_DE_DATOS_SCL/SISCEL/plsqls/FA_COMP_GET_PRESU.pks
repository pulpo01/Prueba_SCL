CREATE OR REPLACE PACKAGE        fa_comp_get_presu is
  Procedure p_getimpsaldoant(v_cod_cliente in Fa_HistDocu.cod_cliente%TYPE,
			     v_imp_saldoant out Fa_HistDocu.imp_saldoant%TYPE);
  Procedure p_getordentotal(
                    v_ind_ordentotal in out Fa_HistDocu.ind_ordentotal%TYPE);
  Procedure p_getdesconcepto (v_cod_concepto in Fa_Conceptos.Cod_Concepto%TYPE,
			     v_des_concepto out Fa_Conceptos.Des_Concepto%TYPE);
  Procedure p_getfecemision (v_cod_ciclfact in Fa_HistDocu.cod_ciclfact%TYPE,
			     v_fec_emision out Fa_CiclFact.fec_emision%TYPE);
  Procedure p_updatesec (v_cod_tipdocum in Fa_Procesos.cod_tipdocum%TYPE,
			 v_cod_centremi in Fa_Procesos.cod_centremi%TYPE,
			 v_letra in Fa_HistDocu.Letra%TYPE,
			 v_secuencia in Fa_HistDocu.Num_Secuenci%TYPE);
  Procedure p_updventa (v_tot_cargosme in Fa_HistDocu.Tot_CargosMe%TYPE,
                        v_num_venta in Ga_Ventas.Num_Venta%TYPE,
                        v_num_transaccion in Ga_Ventas.Num_Transaccion%TYPE,
                        v_monefact in Fa_DatosGener.Cod_MoneFact%TYPE);
  Procedure p_updateproc (v_num_proceso in Fa_Procesos.num_proceso%TYPE,
			  v_letra in Fa_HistDocu.letra%TYPE,
			  v_num_secuenci in Fa_HistDocu.num_secuenci%TYPE);
  Procedure p_getcargosme(rec_presupuesto in Fa_Presupuesto%ROWTYPE,
                          v_monefact in Fa_DatosGener.Cod_MoneFact%TYPE,
			  v_tot_cargosme in out Fa_HistDocu.tot_cargosme%TYPE);
  Procedure p_getcarabo (rec_presupuesto in Fa_Presupuesto%ROWTYPE,
	                 v_tot_abonado in out Fa_HistAboCel.tot_cargosme%TYPE,
	                 v_tot_cargo   in out Fa_HistAboCel.acum_cargo%TYPE,
	                 v_tot_dto     in out Fa_HistAboCel.acum_dto%TYPE,
	                 v_tot_iva     in out Fa_HistAboCel.acum_iva%TYPE,
                         v_monefact in out Fa_DatosGener.Cod_MoneFact%TYPE);
  Procedure p_getvendedor (v_num_transaccion in
                                         Ga_TransContado.Num_Transaccion%TYPE,
                           v_num_venta in Ga_Ventas.Num_Venta%TYPE,
			   v_cod_vendedor out Fa_HistDocu.cod_vendedor%TYPE);
  Procedure p_getfechas(v_cod_ciclfact in Fa_Presupuesto.cod_ciclfact%TYPE,
			v_fec_emision out Fa_HistDocu.fec_emision%TYPE,
			v_fec_vencimie out Fa_HistDocu.fec_vencimie%TYPE,
			v_fec_caducida out Fa_HistDocu.fec_caducida%TYPE,
			v_fec_proxvenc out Fa_HistDocu.fec_proxvenc%TYPE);
  Procedure p_getcambio (v_fec_valor in Fa_HistConcCelu.fec_valor%TYPE,
                         v_cod_monedaorig in Fa_HistConcCelu.Cod_Moneda%TYPE,
                         v_cod_monedadest in Fa_DatosGener.Cod_MoneFact%TYPE,
                         v_imp_concepto in Fa_HistConcCelu.Imp_Concepto%TYPE,
                         v_num_unidades in Fa_HistConcCelu.Num_Unidades%TYPE,
                     v_imp_facturable out Fa_HistConcCelu.Imp_Facturable%TYPE);
  Procedure p_getfeccambiomo (v_fec_valor in Fa_Presupuesto.fec_valor%TYPE,
			      v_fec_cambiomo out Fa_HistDocu.fec_cambiomo%TYPE);
  Procedure p_getacum (v_num_proceso in Fa_Procesos.num_proceso%TYPE,
		       v_rec_fa_histdocu in out Fa_HistDocu%ROWTYPE,
		       v_monefact in out Fa_DatosGener.Cod_MoneFact%TYPE);
  Procedure p_getlimcredito(v_cod_cliente in Fa_Presupuesto.cod_Cliente%TYPE,
			    v_lim_credito out Fa_HistAboCel.lim_credito%TYPE);
  Procedure p_getdesactividad(v_actividad in Ge_Actividades.cod_actividad%TYPE,
                            v_des_actividad out Fa_HistClie.Des_Actividad%TYPE);
  Procedure p_getdescomuna(v_region in Ge_Regiones.cod_region%TYPE,
                           v_provin in Ge_Provincias.cod_provincia%TYPE,
                           v_comuna in Ge_Comunas.cod_comuna%TYPE,
                           v_des_comuna out Fa_HistClie.des_comuna%TYPE);
  Procedure p_getdesciudad(v_region in Ge_Regiones.cod_region%TYPE,
                           v_provin in Ge_Provincias.cod_provincia%TYPE,
                           v_ciudad in Ge_Ciudades.cod_ciudad%TYPE,
                           v_des_ciudad out Fa_HistClie.des_ciudad%TYPE);
  Procedure p_getdesabocelu(v_cod_cliente in Fa_HistDocu.Cod_Cliente%TYPE,
                           v_num_abonado in Fa_Presupuesto.Num_Abonado%TYPE,
                           v_prod_celular in Ge_DatosGener.Prod_Celular%TYPE,
                           v_nom_usuario out Fa_HistAboCel.nom_usuario%TYPE,
                         v_nom_apellido1 out Fa_HistAboCel.nom_apellido1%TYPE,
                         v_nom_apellido2 out Fa_HistAboCel.nom_apellido2%TYPE,
                           v_num_telefija out Fa_HistAboCel.num_telefija%TYPE,
                           v_cod_credmor out Fa_HistAboCel.cod_credmor%TYPE,
                         v_fec_fincontra out Fa_HistAboCel.fec_fincontra%TYPE);
  Procedure p_getdesabobeep(v_cod_cliente in Fa_HistDocu.Cod_Cliente%TYPE,
                        v_num_abonado in Fa_Presupuesto.Num_Abonado%TYPE,
                        v_prod_beeper in Ge_DatosGener.Prod_Beeper%TYPE,
                        v_nom_usuario out Fa_HistAboBeep.nom_usuario%TYPE,
                        v_nom_apellido1 out Fa_HistAboBeep.nom_apellido1%TYPE,
                        v_nom_apellido2 out Fa_HistAboBeep.nom_apellido2%TYPE,
                        v_cod_credmor out Fa_HistAboBeep.cod_credmor%TYPE,
                        v_fec_fincontra out Fa_HistAboBeep.fec_fincontra%TYPE);
  Procedure p_getdesabotrek(v_cod_cliente in Fa_HistDocu.Cod_Cliente%TYPE,
                        v_num_abonado in Fa_Presupuesto.Num_Abonado%TYPE,
                        v_prod_trek in Ge_DatosGener.Prod_Trek%TYPE,
                        v_nom_usuario out Fa_HistAboTrek.nom_usuario%TYPE,
                        v_nom_apellido1 out Fa_HistAboTrek.nom_apellido1%TYPE,
                        v_nom_apellido2 out Fa_HistAboTrek.nom_apellido2%TYPE,
                        v_cod_credmor out Fa_HistAboTrek.cod_credmor%TYPE,
                        v_fec_fincontra out Fa_HistAboTrek.fec_fincontra%TYPE);
/*
  Procedure p_getdesabotrunk(v_cod_cliente in Fa_HistDocu.Cod_Cliente%TYPE,
                        v_num_abonado in Fa_Presupuesto.Num_Abonado%TYPE,
                        v_prod_trunk in Ge_DatosGener.Prod_Trunk%TYPE,
                        v_nom_usuario out Fa_HistAboTrek.nom_usuario%TYPE,
                        v_nom_apellido1 out Fa_HistAboTrek.nom_apellido1%TYPE,
                        v_nom_apellido2 out Fa_HistAboTrek.nom_apellido2%TYPE,
                        v_cod_credmor out Fa_HistAboTrek.cod_credmor%TYPE,
                        v_fec_fincontra out Fa_HistAboTrek.fec_fincontra%TYPE);
*/
  Procedure p_getdatoclie (rec_histclie in out Fa_HistClie%ROWTYPE,
                           v_cliente in Fa_HistClie.Cod_Cliente%TYPE);
  Procedure p_getdatoclie2 (rec_histclie in out Fa_HistClie%ROWTYPE,
                            v_cliente in Fa_HistClie.Cod_Cliente%TYPE);
  Procedure p_getdatoproc (v_rec_proceso in out Fa_Procesos%ROWTYPE);
  Procedure p_getgedatosgener (v_ge_datosgener out Ge_DatosGener%ROWTYPE);
  Procedure p_getinsertacum(rec_acumuloprod in Fa_AcumuloProd%ROWTYPE);
  Procedure p_getacumulado (vind_ordentotal in out
                                            Fa_HistDocu.Ind_OrdenTotal%TYPE,
                            vrec_ge_datosgener in out Ge_DatosGener%ROWTYPE,
                            v_proceso in out Fa_Procesos.Num_Proceso%TYPE,
                            v_cliente in out Ge_Clientes.Cod_Cliente%TYPE);
  Procedure p_getfadatosgener (v_fa_datosgener out Fa_DatosGener%ROWTYPE);
  Procedure p_getdeletecargos (v_num_proceso in Fa_Procesos.Num_Proceso%TYPE);
  Procedure p_getmuevecargos (v_num_proceso in Fa_Procesos.Num_Proceso%TYPE);
end fa_comp_get_presu;
/
SHOW ERRORS
