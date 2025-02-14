CREATE OR REPLACE PACKAGE PV_CONSULTAS_OFVIRTUAL_PG
/*
<Documentación>
<TipoDoc = "Package"/>
 <Elemento
    Nombre = "PV_CONSULTAS_OFVIRTUAL_PG"
    Lenguaje="PL/SQL"
    Fecha="14-11-2005"
    Versión="1.0"
    Diseñador="***"
    Programador="Diego Rojo"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package que agrupa un conjunto de servicios para consulta de cambio de series</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS

	CV_version	        	CONSTANT  VARCHAR2(10):='1.0';
	CV_cod_modulo			CONSTANT   ged_parametros.cod_modulo%TYPE:='GA';
	CN_largoquery			CONSTANT   NUMBER:=3000;
	CV_cod_modulo_pv 		CONSTANT  ged_parametros.cod_modulo%TYPE:='PV';
	CV_cod_modulo_al 		CONSTANT  ged_parametros.cod_modulo%TYPE:='AL';
	CV_cod_modulo_ge 		CONSTANT  ged_parametros.cod_modulo%TYPE:='GE';
	CV_cod_producto 		CONSTANT  ged_parametros.cod_producto%TYPE:=1;
   	CV_error_no_clasif 		CONSTANT  VARCHAR2(30):='Error no clasificado';
   	CN_largodesc 			CONSTANT  NUMBER:=1000;
   	CN_largoerrtec 			CONSTANT  NUMBER:=500;
   	LV_largo_tgsm       	CONSTANT  ged_parametros.nom_parametro%TYPE:='LARGO_SERIE_TGSM';
	LV_largo_ttdma       	CONSTANT  ged_parametros.nom_parametro%TYPE:='LARGO_SERIE_TTDMA';
	LV_largo_ggsm       	CONSTANT  ged_parametros.nom_parametro%TYPE:='LARGO_SERIE_GGSM';
	LV_formato_sel2       	CONSTANT  ged_parametros.nom_parametro%TYPE:='FORMATO_SEL2';

	LR_DatAbonado			ga_abocel%ROWTYPE;
	LV_tabla_abo			varchar2(15);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_TIPO_CONTRATO_PR (EN_num_celular 			 IN  ga_abocel.num_celular%TYPE,
				    			    SV_cod_tipo_contrato    OUT  NOCOPY   ga_abocel.cod_tipcontrato%TYPE,
				    				SV_desc_tipo_contrato   OUT  NOCOPY   ga_tipcontrato.des_tipcontrato%TYPE,
				    				SN_cod_retorno      	OUT  NOCOPY   ge_errores_pg.CodError,
                              	    SV_mens_retorno     	OUT  NOCOPY   ge_errores_pg.MsgError,
				    				SN_num_evento       	OUT  NOCOPY   ge_errores_pg.Evento
                             		);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_ANTIGUEDAD_SERIE_PR (EN_num_celular       IN    ga_abocel.num_celular%TYPE,
				    			  SV_fecha_serie      OUT    NOCOPY   VARCHAR2,
				    			  SN_cod_retorno      OUT    NOCOPY   ge_errores_pg.CodError,
                              	  SV_mens_retorno     OUT    NOCOPY   ge_errores_pg.MsgError,
				    			  SN_num_evento       OUT    NOCOPY   ge_errores_pg.Evento
                             	  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_FORM_SERIE_EQUIPO_PR (EN_num_serie     IN GA_ABOCEL.NUM_SERIE%TYPE,
				    				   SN_formato      OUT NOCOPY NUMBER,
				    				   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                              	       SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
				    				   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                             		   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_FORM_SERIE_SIMCARD_PR (EN_num_serie     IN GA_ABOCEL.NUM_SERIE%TYPE,
				    				    SN_formato      OUT    NOCOPY  NUMBER,
				    					SN_cod_retorno  OUT    NOCOPY   ge_errores_pg.CodError,
                              	    	SV_mens_retorno OUT    NOCOPY   ge_errores_pg.MsgError,
				    					SN_num_evento   OUT    NOCOPY   ge_errores_pg.Evento
                             			);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_DEUDA_CLIENTE_PR (EN_num_celular       IN     ga_abocel.num_celular%TYPE,
				    			    SN_deuda_vencida    OUT    NOCOPY  NUMBER,
				    				SN_deuda_no_vencida OUT    NOCOPY  NUMBER,
				    				SN_cod_retorno      OUT    NOCOPY   ge_errores_pg.CodError,
                              	    SV_mens_retorno     OUT    NOCOPY   ge_errores_pg.MsgError,
				    				SN_num_evento       OUT    NOCOPY   ge_errores_pg.Evento
                             		);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_ART_BODEGA_PR (EN_num_serie     IN GA_ABOCEL.NUM_SERIE%TYPE,
				    			 SN_cod_art      OUT NOCOPY  al_articulos.cod_articulo%TYPE,
				    			 SV_desc_art     OUT NOCOPY  al_articulos.des_articulo%TYPE,
				    			 SV_modelo       OUT NOCOPY  al_articulos.cod_modelo%TYPE,
				    			 SV_fabricante   OUT NOCOPY  al_fabricantes.des_fabricante%TYPE,
				    			 SV_tecnologia   OUT NOCOPY  al_tecnologia.des_tecnologia%TYPE,
				    			 SV_concepto     OUT NOCOPY  fa_conceptos.des_concepto%TYPE,
				    			 SN_cod_retorno  OUT NOCOPY   ge_errores_pg.CodError,
                              	 SV_mens_retorno OUT NOCOPY   ge_errores_pg.MsgError,
				    			 SN_num_evento   OUT NOCOPY   ge_errores_pg.Evento
                             	 );
----------------------------------------------------------------------------------------------------------------
PROCEDURE PV_DATOS_ABONADO_PR(EN_num_celular       IN  ga_abocel.num_celular%TYPE,
	   	  					  SR_ABONADO 		  OUT NOCOPY GA_ABOCEL%ROWTYPE,
	   						  SV_tabla_abo		  OUT NOCOPY VARCHAR2,
	   						  SN_cod_retorno      OUT NOCOPY ge_errores_td.Cod_MsgError%TYPE
	   						 );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_existe_cliente_fn (
   EN_cod_cliente   IN           ge_clientes.cod_cliente%TYPE,
   SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_bodega_vendedor_pr(
	   	  		  			EN_CodVendedor		IN  ve_vendedores.cod_vendedor%TYPE,
							EN_CodBodega		IN  al_bodegas.cod_bodega%TYPE,
							EV_Cod_operadora	IN  ge_clientes.cod_operadora%TYPE,
							SN_cod_retorno      OUT NOCOPY ge_errores_td.Cod_MsgError%TYPE );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Procedure pv_serv_supl_pr(
ET_NumAbonado	  			IN				ga_abocel.num_abonado%TYPE,
ET_CodProducto	  			IN				ga_abocel.cod_producto%TYPE,
ET_codcentral				IN				icg_central.cod_central%TYPE,
ET_CodPlantarif				IN				ga_abocel.cod_plantarif%TYPE,
ET_CodUso					IN				ga_abocel.cod_uso%TYPE,
ET_Num_Celular				IN				ga_abocel.num_celular%TYPE,
ET_Tip_Terminal				IN 				icg_serviciotercen.tip_terminal%TYPE,
ET_Tip_Tecnologia			IN				icg_serviciotercen.tip_tecnologia%TYPE,
SV_CadServicio    			OUT NOCOPY   VARCHAR2);

END PV_CONSULTAS_OFVIRTUAL_PG;
/
SHOW ERROR