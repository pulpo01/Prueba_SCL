CREATE OR REPLACE PACKAGE ve_general_servicios_pg
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
   cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'VE';
   cv_version           CONSTANT VARCHAR2 (2)  := '1';
   cv_prod_celular      CONSTANT NUMBER (2)    := 1;
   cv_cod_modulo_ga     CONSTANT VARCHAR2 (2)  := 'VE';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	FUNCTION pv_rec_canal_venta_fn (
      eo_ve_tipcomis    IN OUT NOCOPY   ve_tipcomis_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
    )RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE pv_ejec_restriccion_pr (
      pv_restricciones     IN              pv_restricciones_qt,
	  sn_cod_retorno_rest  OUT NOCOPY      NUMBER,
	  sv_mens_retorno_rest OUT NOCOPY      VARCHAR2,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
    );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE pv_rec_eventos_restriccion_pr (
      pv_restricciones     IN              pv_restricciones_qt,
	  SC_evento_restricc   OUT NOCOPY      refcursor,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
    );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END VE_GENERAL_SERVICIOS_PG;
/
SHOW ERRORS
