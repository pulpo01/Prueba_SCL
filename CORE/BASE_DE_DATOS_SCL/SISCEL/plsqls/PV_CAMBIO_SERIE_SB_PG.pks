CREATE OR REPLACE PACKAGE pv_cambio_serie_sb_pg
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "PV_CAMBIO_SERIE_SB_PG"
          Lenguaje="PL/SQL"
          Fecha="18-07-2007"
          Versión="1.0"
          Diseñador= "Marcelo Godoy"
        Programador="Marcelo Godoy"
          Ambiente Desarrollo="BD">
      <Descripción>Package servicios base para dirección</Descripción>
  </Elemento>
</Documentación>
*/
IS
   TYPE refcursor IS REF CURSOR;

   cv_error_no_clasif   CONSTANT VARCHAR2 (50)
                                       := 'No es posible clasificar el error';
   cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'PV';
   cv_version           CONSTANT VARCHAR2 (2)  := '1';
   cv_prod_celular      CONSTANT NUMBER (2)    := 1;
   cv_cod_modulo_ga     CONSTANT VARCHAR2 (2)  := 'GA';
   cv_categoria_lista   CONSTANT VARCHAR2 (3)  := 'ZZZ';
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_ge_seg_usuario_fn (
      eso_seg_usuario   IN OUT NOCOPY   ge_seg_usuario_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_rec_info_abonado_pr (
      seo_dat_abo       IN OUT NOCOPY   pv_datos_abo_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_rec_cau_cambio_serie_pr (
      sc_cau_cam_serie   OUT NOCOPY   refcursor,
      sn_cod_retorno     OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY   ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_rec_tipos_contrato_pr (
      oe_sesion         IN              ge_sesion_qt,
      sc_tip_contrato   OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_recuperar_bodegas_pr (
      eo_sesion         IN              ge_sesion_qt,
      sc_bodegas        OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_recuperar_tecnologias_pr (
      sc_tecnologia     OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_recuperar_usos_pr (
      sc_usos           OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_rec_meses_prorroga_pr (
      sc_prorroga       OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_rec_modalidad_pago_pr (
      eso_caucaser      IN OUT NOCOPY   ga_caucaser_qt,
      eso_sesion        IN OUT NOCOPY   ge_sesion_qt,
      sc_mod_pago       OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_rec_tipo_terminal_pr (
      ev_cod_tecnologia   IN              al_tecnologia.cod_tecnologia%TYPE,
      sc_tip_terminal     OUT NOCOPY      refcursor,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_recuperar_cuotas_pr (
      eo_sesion         IN              ge_sesion_qt,
      eo_modventa       IN              ge_modventa_qt,
      sc_cuotas         OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_rec_cat_tributaria_pr (
      eo_sesion           IN              ge_sesion_qt,
      sc_cat_tributaria   OUT NOCOPY      refcursor,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_rec_usos_ventas_pr (
      sc_usos_venta     OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_rec_central_hlr_pr (
      eo_icg_central    IN              icg_central_qt,
      eo_al_serie       IN              al_serie_qt,
      sc_icg_central    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_valida_permisos_fn (
      ev_nom_usuario       IN              ged_codigos.nom_tabla%TYPE,
      ev_cod_programa      IN              ged_codigos.nom_columna%TYPE,
      en_num_version       IN              ged_codigos.cod_valor%TYPE,
      ev_nom_perfil_proceso   IN              gad_procesos_perfiles.nom_perfil_proceso%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_tipo_contrato_fn (
      seo_tipcontrato   IN OUT NOCOPY   ga_tipcontrato_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_obtiene_ged_parametros_fn (
      ev_nom_parametro   IN              ged_parametros.nom_parametro%TYPE,
      ev_cod_modulo      IN              ged_parametros.cod_modulo%TYPE,
      sv_val_parametro   OUT NOCOPY      ged_parametros.val_parametro%TYPE,
      sv_des_parametro   OUT NOCOPY      ged_parametros.des_parametro%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_cat_plan_tarif_fn (
      eso_catplantarif   IN OUT NOCOPY   ve_catplantarif_qt,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_obtiene_datos_abonado_pr (
      so_abonado        IN OUT NOCOPY   ga_abonado2_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cnslta_centrls_pr(EN_cod_producto        IN icg_central.cod_producto%TYPE,
		  					   EV_cod_tecnologia	  IN icg_central.cod_tecnologia%TYPE,
							   EV_cod_hlr			  IN icg_central.cod_hlr%TYPE,
							   SC_central        	  OUT NOCOPY RefCursor,
						       SN_cod_retorno    	  OUT NOCOPY ge_errores_pg.CodError,
               		           SV_mens_retorno   	  OUT NOCOPY ge_errores_pg.MsgError,
               		           SN_num_evento     	  OUT NOCOPY ge_errores_pg.Evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_valida_serie_externa_PR(EN_cod_producto        IN ged_parametros.cod_producto%TYPE,
		  				    EV_num_serie	 				IN al_series.num_serie%TYPE,
		  					EV_tip_terminal	 	 	 IN ga_abocel.tip_terminal%TYPE,
							SN_cod_retorno    	   	 OUT NOCOPY ge_errores_pg.CodError,
	                       	SV_mens_retorno   	   	 OUT NOCOPY ge_errores_pg.MsgError,
	                       	SN_num_evento     	   	 OUT NOCOPY ge_errores_pg.Evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_cnslta_usos_PR(EN_cod_producto			 IN ga_caucaser.cod_producto%TYPE,
		  					SC_usos				 	 OUT NOCOPY RefCursor,
							SN_cod_retorno    	   	 OUT NOCOPY ge_errores_pg.CodError,
	                       	SV_mens_retorno   	   	 OUT NOCOPY ge_errores_pg.MsgError,
	                       	SN_num_evento     	   	 OUT NOCOPY ge_errores_pg.Evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_cnslta_articulos_PR(EN_cod_producto	 IN al_articulos.cod_producto%TYPE,
		  					EV_tip_terminal			 IN al_articulos.tip_terminal%TYPE,
		  					SC_articulos		 	 OUT NOCOPY RefCursor,
							SN_cod_retorno    	   	 OUT NOCOPY ge_errores_pg.CodError,
	                       	SV_mens_retorno   	   	 OUT NOCOPY ge_errores_pg.MsgError,
	                       	SN_num_evento     	   	 OUT NOCOPY ge_errores_pg.Evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION pv_verifica_plan_comercial_fn (
      eo_sesion          IN              GE_SESION_QT,
      eo_caucaser        IN              GA_CAUCASER_QT,
      eo_modventa        IN              GE_MODVENTA_QT,
      eo_uso             IN              AL_USO_QT,
      eo_tip_terminal    IN				 AL_TIPOS_TERMINALES_QT,
      eo_al_serie        IN              AL_SERIE_QT,
	  eo_dat_abo         IN 			 PV_DATOS_ABO_QT,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
  ) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION pv_valida_promocion_fn (
      en_num_abonado     IN              ga_equipaboser.num_abonado%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
    ) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_rec_prec_equipo_actual_PR(EN_numSerie	        IN al_series.num_serie%TYPE,
		  							   SN_impCargo			OUT NOCOPY ge_cargos.imp_cargo%TYPE,
		  							   SN_valDTO			OUT NOCOPY ge_cargos.val_dto%TYPE,
		  							   SN_tipDTO			OUT NOCOPY ge_cargos.tip_dto%TYPE,
									   SN_cod_retorno		OUT NOCOPY ge_errores_pg.CodError,
				                       SV_mens_retorno   	OUT NOCOPY ge_errores_pg.MsgError,
				                       SN_num_evento     	OUT NOCOPY ge_errores_pg.Evento) ;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_val_concep_fact_gtia_PR(SN_cod_retorno	OUT NOCOPY ge_errores_pg.CodError,
				                    SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
				                    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_rec_cargo_dif_garantia_PR(EN_valdiferencia     IN NUMBER,
		  							   SC_cursor			OUT NOCOPY refcursor,
									   SN_cod_retorno		OUT NOCOPY ge_errores_pg.CodError,
				                       SV_mens_retorno   	OUT NOCOPY ge_errores_pg.MsgError,
				                       SN_num_evento     	OUT NOCOPY ge_errores_pg.Evento) ;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_val_seleccion_causas_PR(EV_ind_procequi         IN ga_equipaboser.ind_procequi%TYPE,
		  							 EV_cod_caucaser	  	 IN ga_caucaser.cod_caucaser%TYPE,
									 EV_num_serie		  	 IN al_series.num_serie%TYPE,
									 EN_num_abonado		  	 IN ga_abocel.num_abonado%TYPE,
									 EV_nom_tabla		  	 IN VARCHAR2,
									 EV_nom_usuario		  	 IN ge_seg_grpusuario.nom_usuario%TYPE,
		  							 SV_des_combo_contrato 	 OUT NOCOPY VARCHAR2,
									 SN_cod_retorno		  	 OUT NOCOPY ge_errores_pg.CodError,
				                     SV_mens_retorno   	  	 OUT NOCOPY ge_errores_pg.MsgError,
				                     SN_num_evento     	  	 OUT NOCOPY ge_errores_pg.Evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


PROCEDURE pv_rec_tip_contrato_pr_oossweb (
	  OE_sesion                IN               GE_SESION_QT,
      SC_tip_contrato          OUT NOCOPY	    refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento);


END pv_cambio_serie_sb_pg;
/
SHOW ERRORS