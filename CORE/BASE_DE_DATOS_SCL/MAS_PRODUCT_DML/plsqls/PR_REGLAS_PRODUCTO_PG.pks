CREATE OR REPLACE PACKAGE PR_reglas_producto_PG

/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "GA_reglas_producto_PG"
          Lenguaje="PL/SQL"
          Fecha="01-08-2007"
          Versión="1.0"
          Diseñador= "Christian Estay M"
		  Programador="Christian Estay M"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Package servicios base para las Reglas de Producto</Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
</Elemento>
</Documentación>
*/
AS

   cv_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   cv_procesoexi           CONSTANT VARCHAR2(30):= 'Proceso Existoso';
   cv_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   cv_version              CONSTANT VARCHAR2 (2)  := '1';
   cv_cod_producto		   CONSTANT NUMBER 		  := 1;
   cv_ind_default 		   CONSTANT VARCHAR2(1)	  := 'S';
   cv_formato_fecha		   CONSTANT	VARCHAR2(25)  := 'DD-MM-YYYY HH24:MI:SS';
   cv_fechaHasta 		   CONSTANT	VARCHAR2(12)  := '31-12-3000';

   PROCEDURE PR_valida_reglas_prod_PR(	EV_plan_orig      IN  ga_abocel.cod_plantarif%TYPE,
										EV_plan_dest      IN  ga_abocel.cod_plantarif%TYPE,
										EN_cod_cliente    IN  ga_abocel.cod_cliente%TYPE,
										EN_num_abonado    IN  ga_abocel.num_abonado%TYPE,
										SV_cadena_act     OUT NOCOPY VARCHAR2,
										SV_cadena_des     OUT NOCOPY VARCHAR2,
								        SN_cod_retorno 	  OUT NOCOPY ge_errores_pg.CodError,
								        SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
								        SN_num_evento 	  OUT NOCOPY ge_errores_pg.Evento);

   PROCEDURE PR_recupera_prod_activar_PR(EV_plan	       IN  ta_plantarif.cod_plantarif%TYPE,
										 SV_cadena_activar OUT NOCOPY ga_abocel.clase_servicio%TYPE,
										 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
										 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
										 SN_num_evento 	   OUT NOCOPY ge_errores_pg.Evento);

   PROCEDURE PR_recupera_prod_abonado_PR(EN_cod_cliente    IN  ga_abocel.cod_cliente%TYPE,
	   	  		  						 EN_num_abonado    IN  ga_abocel.num_abonado%TYPE,
										 EN_condicion	   IN  PR_PRODUCTOS_CONTRATADOS_TO.IND_CONDICION_CONTRATACION%TYPE,
										 SV_cadena_abonado OUT NOCOPY ga_abocel.clase_servicio%TYPE,
										 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
										 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
										 SN_num_evento 	   OUT NOCOPY ge_errores_pg.Evento);

   PROCEDURE PR_valida_categoria_planes_PR(EV_plan_orig      IN  ga_abocel.cod_plantarif%TYPE,
	   	  		  						   EV_plan_dest      IN  ga_abocel.cod_plantarif%TYPE,
										   SV_flag   	    OUT NOCOPY VARCHAR2,
										   SN_cod_retorno 	OUT NOCOPY ge_errores_pg.CodError,
										   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
										   SN_num_evento 	OUT NOCOPY ge_errores_pg.Evento);

   PROCEDURE PR_actualiza_prod_vetados_PR(EN_cod_cliente    IN  ga_abocel.cod_cliente%TYPE,
	   	  		  						  EN_num_abonado    IN  ga_abocel.num_abonado%TYPE,
										  EN_condicion		IN  PR_PRODUCTOS_CONTRATADOS_TO.IND_CONDICION_CONTRATACION%TYPE,
										  SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
										  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
										  SN_num_evento 	OUT NOCOPY ge_errores_pg.Evento);



end PR_reglas_producto_PG;
/
SHOW ERRORS
