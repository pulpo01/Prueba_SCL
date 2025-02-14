CREATE OR REPLACE PACKAGE PV_EXCLUSION_PLANES_SS_PG
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "PV_EXCLUSION_PLANES_SS_PG"
          Lenguaje="PL/SQL"
          Fecha="25-03-2009"
          Versión="1.0"
          Diseñador=""
          Programador="Orlando Cabezas B."
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción></Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
</Elemento>
</Documentación>
*/
IS
	TYPE refCursor IS REF CURSOR;
	cv_error_no_clasif      VARCHAR2 (50) := 'No es posible clasificar el error';
   	cv_cod_modulo           VARCHAR2 (2)  := 'PV';
   	cv_version              VARCHAR2 (2)  := '1';
	
	
	TYPE  typ_rec_excluyente IS RECORD (
        t_v_tipo          VARCHAR2(4) , --('PLAN' o 'SS')
		t_v_codigo        VARCHAR2(10), --(cod_espec_prod o cod_servicio)
		t_v_id            VARCHAR2(10),	--(id_prod_ofertado o cod_servsupl)	
		t_v_glosa         VARCHAR2(1000)--(glosa)	
		
        );

    TYPE  typ_tab_excluyente IS TABLE OF typ_rec_excluyente
          INDEX BY binary_INTEGER;

    tab_excluyente    typ_tab_excluyente;
	
	
	ind_excluyente    BINARY_INTEGER := 0;
   	CV_1              varchar2(1) := 1; --tipo plan adicional
	CV_2              varchar2(1) := 2; --tipo servicio suplementario
--------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_PAD_EXCLUYENTES_PR (   EN_COD_PROD_OFERTADO  IN pf_productos_ofertados_td.COD_PROD_OFERTADO%TYPE,
                                        EN_NIVEL_APLIC     IN pf_productos_ofertados_td.IND_NIVEL_APLICA%TYPE, 
										EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
										EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
										SV_ID_ESPEC_PROD   OUT NOCOPY VARCHAR2,
										SV_TIPO_EXCLUYE    OUT NOCOPY VARCHAR2,
										SV_ID_PROD_OFERTA  OUT NOCOPY VARCHAR2,
										SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
										SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
										SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
							);
--------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_LISTA_PLANES_SS_CLIABO_PR (EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
										EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
										SO_LISTA_PLAN_SS   OUT NOCOPY refCursor,
										SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
										SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
										SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
							);

--------------------------------------------------------------------------------------------------------------------------------------							
PROCEDURE PV_LISTA_EXCLUYENTES_PLAN_PR (EN_ID_ESPEC_PROD  IN ps_especificaciones_prod_td.ID_ESPEC_PROD%TYPE,
										EN_NIVEL_APLIC     IN pf_productos_ofertados_td.IND_NIVEL_APLICA%TYPE, 
                                     	SO_LISTA_EXCLUYE   OUT NOCOPY refCursor,
										SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  								    SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
										SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
							);
							
PROCEDURE PV_VALIDACION_EXCLUYENTES_PR (EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
										EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
										EN_ID_ESPEC_PROD  IN ps_especificaciones_prod_td.ID_ESPEC_PROD%TYPE,
										EN_NIVEL_APLIC     IN pf_productos_ofertados_td.IND_NIVEL_APLICA%TYPE,
                                     	SO_LISTA_VALIDA    OUT NOCOPY refCursor,
										SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  								    SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
										SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
							);
/********************************************************************************************************************************************/
PROCEDURE PV_LOG_EXCLUSION_PR(  EN_NUM_OS             IN pr_log_excluyentes_to.num_os%TYPE,
								EN_COD_CLIENTE        IN pr_log_excluyentes_to.cod_cliente%TYPE,
								EN_NUM_ABONADO        IN pr_log_excluyentes_to.num_abonado%TYPE,
								EV_COD_EXCLUYENTE     IN pr_log_excluyentes_to.cod_excluyente%TYPE,
								EN_TIPO_EXCLUYENTE    IN pr_log_excluyentes_to.tipo_cod_excluyente%TYPE,
								EV_ID_PROD_OFERTADO   IN pr_log_excluyentes_to.id_prod_ofertado%TYPE,
								SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
								SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
								SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
							);														

END PV_EXCLUSION_PLANES_SS_PG;
/
SHOW ERRORS