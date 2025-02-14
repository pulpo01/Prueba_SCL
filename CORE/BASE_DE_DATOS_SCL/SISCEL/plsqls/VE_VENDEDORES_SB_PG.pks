CREATE OR REPLACE PACKAGE ve_vendedores_sb_pg
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "VE_VENDEDORES_SB_PG"
          Lenguaje="PL/SQL"
          Fecha="13-08-2007"
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

   cv_error_no_clasif   CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'VE';
   cv_version           CONSTANT VARCHAR2 (2)  := '1';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_val_descuento_vendedor_pr (
      so_descuento      IN OUT NOCOPY   ge_procesos_qt,
      so_ve_descuento   IN OUT NOCOPY   ve_descuento_ven_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_reg_solicitud_descuento_pr (
      so_sol_des        IN OUT NOCOPY   ga_sol_descuento_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE ve_cons_solicitud_descuento_pr (
      SO_sol_des    	       IN OUT NOCOPY    GA_SOL_DESCUENTO_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ve_rec_codvendedorusuario_fn (
	    SO_descuento    	     IN OUT NOCOPY    GE_PROCESOS_QT,
		SO_ve_descuento	         IN OUT NOCOPY    VE_DESCUENTO_VEN_QT,
        SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        SN_num_evento            OUT NOCOPY		  ge_errores_pg.evento)
	RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ve_rec_descuento_vendedor_fn (
		SO_descuento    	     IN               GE_PROCESOS_QT,
		SO_ve_descuento	         IN OUT NOCOPY    VE_DESCUENTO_VEN_QT,
        SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        SN_num_evento            OUT NOCOPY		  ge_errores_pg.evento)
	 RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE ve_reg_venta_prebilling_pr (
      EO_venta      	       IN OUT NOCOPY    GA_VENTA_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE ve_rec_direccion_vendedor_pr (
      SO_direccion     	       IN OUT NOCOPY    GE_DIRECCION_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ve_recupera_codvenderaiz_fn (
		SO_descuento    	     IN OUT NOCOPY    GE_PROCESOS_QT,
        SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        SN_num_evento            OUT NOCOPY		  ge_errores_pg.evento) RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtener_vendedor_pr (
      SO_vendedor    	       IN OUT NOCOPY    VE_VENDEDOR_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtener_usuario_vendedor_pr (
      SO_usuario    	     IN OUT NOCOPY     GE_SEG_USUARIO_QT,
	  SC_Cursor	              OUT NOCOPY  REFCURSOR,
      SN_cod_retorno       OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno      OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento       OUT NOCOPY		 ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ve_vendedores_sb_pg;
/
SHOW ERRORS
